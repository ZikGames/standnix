---@type SquAssets
local squassets = require("./SquAssets")

---@class SquAPI
local squapi = {}

---Contains all registered smooth heads
---@type SquAPI.SmoothHead[]
squapi.smoothHeads = {}


---@class SquAPI.SmoothHead
---@field element ModelPart
---@field strength number[]
---@field tilt number
---@field keepOriginalHeadPos boolean | number
---@field headRot Vector3
---@field offset Vector3
---@field speed number
---@field enabled boolean
squapi.smoothHead = {}
local SmoothheadMT = {__index = squapi.smoothHead}

---Applies an offset to the heads rotation to more easily modify it. Applies as a vector.(for multisegments it will modify the target rotation)
---@param xRot number X rotation
---@param yRot number Y rotation
---@param zRot number Z rotation
function squapi.smoothHead:setOffset(xRot, yRot, zRot)
  self.offset = vec(xRot, yRot, zRot)
end

---Toggles this smooth head on or off
function squapi.smoothHead:toggle()
  self.enabled = not self.enabled
end

---Disables this smooth head
function squapi.smoothHead:disable()
  self.enabled = false
end

---Enables this smooth head
function squapi.smoothHead:enable()
  self.enabled = true
end

---Sets if this smooth head is enabled
---@param bool boolean
function squapi.smoothHead:setEnabled(bool)
  assert(type(bool) == "boolean", "§4setEnabled must be set to a boolean.§c")
  self.enabled = bool
end

---Resets this smooth head's position and rotation to their initial values
function squapi.smoothHead:zero()
  for _, v in ipairs(self.element) do
    v:setPos(0, 0, 0)
    v:setOffsetRot(0, 0, 0)
    self.headRot = vec(0, 0, 0)
  end
end

---Run tick function on smooth head
function squapi.smoothHead:tick()
  if self.enabled then
    local vanillaHeadRot = squassets.getHeadRot()

    self.headRot[1] = self.headRot[1] + (vanillaHeadRot[1] - self.headRot[1]) * self.speed
    self.headRot[2] = self.headRot[2] + (vanillaHeadRot[2] - self.headRot[2]) * self.speed
    self.headRot[3] = self.headRot[2] * self.tilt
  end
end

---Run render function on smooth head
---@param dt number Tick delta
---@param context Event.Render.context
function squapi.smoothHead:render(dt, context)
  if self.enabled then
    dt = dt / 5
    for i in ipairs(self.element) do
      local c = self.element[i]:getOffsetRot()
      local target = (self.headRot * self.strength[i]) - self.offset / #self.element
      self.element[i]:setOffsetRot(
        math.lerp(c[1], target[1], dt), 
        math.lerp(c[2], target[2], dt),
        math.lerp(c[3], target[3], dt)
      )

      -- Better Combat SquAPI Compatibility created by @jimmyhelp and @foxy2526 on Discord
      if renderer:isFirstPerson() and context == "RENDER" then
        self.element[i]:setVisible(false)
      else
        self.element[i]:setVisible(true)
      end
    end

    if self.keepOriginalHeadPos then
      self.element
          [type(self.keepOriginalHeadPos) == "number" and self.keepOriginalHeadPos or #self.element]
          :setPos(-vanilla_model.HEAD:getOriginPos())
    end
  end
end



---SMOOTH HEAD - Mimics a vanilla player head, but smoother and with some extra life. Can also do smooth Torsos and Smooth Necks!
---@param element ModelPart|table<ModelPart> The head element that you wish to effect. If you want a smooth neck or torso, instead of a single element, input a table of head elements(imagine it like {element1, element2, etc.}). this will apply the head rotations to each of these.
---@param strength? number|table<number> Defaults to `1`, the target rotation is multiplied by this factor. If you want a smooth neck or torso, instead of an single number, you can put in a table(imagine it like {strength1, strength2, etc.}). this will apply each strength to each respective element.(make sure it is the same length as your element table)
---@param tilt? number Defaults to `0.1`, for context the smooth head applies a slight tilt to the head as it's rotated toward the side, this controls the strength of that tilt.
---@param speed? number Defaults to `1`, how fast the head will rotate toward the target rotation.
---@param keepOriginalHeadPos? boolean|number Defaults to `true`, when true the heads position will follow the vanilla head position. For example when crouching the head will shift down to follow. If set to a number, changes which modelpart gets moved when doing actions such as crouching. this should normally be set to the neck modelpart.
---@param fixPortrait? boolean Defaults to `true`, sets whether or not the portrait should be applied if a group named "head" is found in the elements list
function squapi.newSmoothHead(element, strength, tilt, speed, keepOriginalHeadPos, fixPortrait)
  local self = setmetatable({}, SmoothheadMT)

  -- INIT -------------------------------------------------------------------------
  if type(element) == "ModelPart" then
    assert(element, "§4Your model path for smoothHead is incorrect.§c")
    element = { element }
  end
  assert(type(element) == "table", "§4your element table seems to to be incorrect.§c")

  for i = 1, #element do
    assert(element[i]:getType() == "GROUP",
      "§4The head element at position " ..
      i ..
      " of the table is not a group. The head elements need to be groups that are nested inside one another to function properly.§c")
    assert(element[i], "§4The head segment at position " .. i .. " is incorrect.§c")
    element[i]:setParentType("NONE")
  end
  self.element = element

  self.strength = strength or 1 --[=[@as number[]]=]
  if type(self.strength) == "number" then
    local strengthDiv = self.strength / #element
    self.strength = {}
    for i = 1, #element do
      self.strength[i] = strengthDiv
    end
  end

  self.tilt = tilt or 0.1
  if keepOriginalHeadPos == nil then keepOriginalHeadPos = true end
  self.keepOriginalHeadPos = keepOriginalHeadPos
  self.headRot = vec(0, 0, 0)
  self.offset = vec(0, 0, 0)
  self.speed = (speed or 1) / 2

  if fixPortrait == nil then fixPortrait = true end
  if fixPortrait then
    if type(element) == "table" then
      for _, part in ipairs(element) do
        if squassets.caseInsensitiveFind(part, "head") then
          part:copy("_squapi-portrait"):moveTo(models):setParentType("Portrait")
              :setPos(-part:getPivot())
          break
        end
      end
    elseif type(element) == "ModelPart" and element:getType() == "GROUP" then
      if squassets.caseInsensitiveFind(element, "head") then
        element:copy("_squapi-portrait"):moveTo(models):setParentType("Portrait")
            :setPos(-element:getPivot())
      end
    end
  end

  -- CONTROL -------------------------------------------------------------------------

  -- UPDATE -------------------------------------------------------------------------

  table.insert(squapi.smoothHeads, self)
  return self
end

---For compatibility
---@param element ModelPart|table<ModelPart> The head element that you wish to effect. If you want a smooth neck or torso, instead of a single element, input a table of head elements(imagine it like {element1, element2, etc.}). this will apply the head rotations to each of these.
---@param strength? number|table<number> Defaults to `1`, the target rotation is multiplied by this factor. If you want a smooth neck or torso, instead of an single number, you can put in a table(imagine it like {strength1, strength2, etc.}). this will apply each strength to each respective element.(make sure it is the same length as your element table)
---@param tilt? number Defaults to `0.1`, for context the smooth head applies a slight tilt to the head as it's rotated toward the side, this controls the strength of that tilt.
---@param speed? number Defaults to `1`, how fast the head will rotate toward the target rotation.
---@param keepOriginalHeadPos? boolean|number Defaults to `true`, when true the heads position will follow the vanilla head position. For example when crouching the head will shift down to follow. If set to a number, changes which modelpart gets moved when doing actions such as crouching. this should normally be set to the neck modelpart.
---@param fixPortrait? boolean Defaults to `true`, sets whether or not the portrait should be applied if a group named "head" is found in the elements list
function squapi.smoothHead:new(element, strength, tilt, speed, keepOriginalHeadPos, fixPortrait)
  return squapi.newSmoothHead(element, strength, tilt, speed, keepOriginalHeadPos, fixPortrait)
end

local events_started = false
squapi[("$startEvents")] = function()
  if events_started then return end
  events_started = true

  events.tick:register(function()
    for _, smoothhead in ipairs(squapi.smoothHeads) do
      smoothhead:tick()
    end
  end, "SquAPI_SmoothHead")

  events.render:register(function(dt, ctx)
    for _, smoothhead in ipairs(squapi.smoothHeads) do
      smoothhead:render(dt, ctx)
    end
  end, "SquAPI_SmoothHead")
end

return squapi
