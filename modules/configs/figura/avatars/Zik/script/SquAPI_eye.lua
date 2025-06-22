---@type SquAssets
local squassets = require("./SquAssets")

---@class SquAPI
local squapi = {}

---Contains all registered eyes
---@type SquAPI.Eye[]
squapi.eyes = {}

---@class SquAPI.Eye
---@field element ModelPart
---@field switchValues boolean
---@field left number
---@field right number
---@field up number
---@field down number
---@field x number
---@field y number
---@field eyeScale number
---@field enabled boolean
squapi.eye = {}
local EyeMT = {__index = squapi.eye}

---For funzies if you want to change the scale of the eyes you can use self. (lerps to scale)
---@param scale number Scale multiplier
function squapi.eye:setEyeScale(scale)
  self.eyeScale = scale
end

---Toggles this eye on or off
function squapi.eye:toggle()
  self.enabled = not self.enabled
end

---Disables this eye
function squapi.eye:disable()
  self.enabled = false
end

---Enables this eye
function squapi.eye:enable()
  self.enabled = true
end

---Sets if this eye is enabled
---@param bool boolean
function squapi.eye:setEnabled(bool)
  assert(type(bool) == "boolean",
    "§4setEnabled must be set to a boolean.§c")
  self.enabled = bool
end

---Resets this eye's position to its initial posistion
function squapi.eye:zero()
  self.x, self.y = 0, 0
end

---Run tick function on eye
function squapi.eye:tick()
  if self.enabled then
    local headrot = squassets.getHeadRot()
    headrot[2] = math.max(math.min(50, headrot[2]), -50)

    --parabolic curve so that you can control the middle position of the eyes.
    self.x = -squassets.parabolagraph(-50, -self.left, 0, 0, 50, self.right, headrot[2])
    self.y = squassets.parabolagraph(-90, -self.down, 0, 0, 90, self.up, headrot[1])

    --prevents any eye shenanigans
    self.x = math.max(math.min(self.left, self.x), -self.right)
    self.y = math.max(math.min(self.up, self.y), -self.down)
  end
end

---Run render function on eye
---@param dt number Tick delta
function squapi.eye:render(dt, _)
  local c = self.element:getPos()
  if self.switchValues then
    self.element:setPos(0, math.lerp(c[2], self.y, dt), math.lerp(c[3], -self.x, dt))
  else
    self.element:setPos(math.lerp(c[1], self.x, dt), math.lerp(c[2], self.y, dt), 0)
  end
  local scale = math.lerp(self.element:getOffsetScale()[1], self.eyeScale, dt)
  self.element:setOffsetScale(scale, scale, scale)
end


---MOVING EYES - Moves an eye based on the head rotation to look toward where you look; should work with any general eye type.<br><br>Note: you call this function for each eye, so if you have two eyes you will call this function twice (one for each eye).
---@param element ModelPart The eye element that is going to be moved, each eye is seperate.
---@param leftDistance? number Defaults to `0.25`, the distance from the eye to it's leftmost posistion.
---@param rightDistance? number Defaults to `1.25`, the distance from the eye to it's rightmost posistion.
---@param upDistance? number Defaults to `0.5`, the distance from the eye to it's upmost posistion.
---@param downDistance? number Defaults to `0.5`, the distance from the eye to it's downmost posistion.
---@param switchValues? boolean Defaults to `false`, this will switch from side to side movement to front back movement. this is good if the eyes are on the *side* of the head rather than the *front*.
---@return SquAPI.Eye
function squapi.newEye(element, leftDistance, rightDistance, upDistance, downDistance, switchValues)
  local self = setmetatable({}, EyeMT)

  -- INIT -------------------------------------------------------------------------
  assert(element, "§4Your eye model path is incorrect.§c")
  self.element = element
  self.switchValues = switchValues or false
  self.left = leftDistance or .25
  self.right = rightDistance or 1.25
  self.up = upDistance or 0.5
  self.down = downDistance or 0.5

  self.x = 0
  self.y = 0
  self.eyeScale = 1

  -- CONTROL -------------------------------------------------------------------------

  self.enabled = true

  -- UPDATES -------------------------------------------------------------------------


  table.insert(squapi.eyes, self)
  return self
end

---For compatibility
---@param element ModelPart The eye element that is going to be moved, each eye is seperate.
---@param leftDistance? number Defaults to `0.25`, the distance from the eye to it's leftmost posistion.
---@param rightDistance? number Defaults to `1.25`, the distance from the eye to it's rightmost posistion.
---@param upDistance? number Defaults to `0.5`, the distance from the eye to it's upmost posistion.
---@param downDistance? number Defaults to `0.5`, the distance from the eye to it's downmost posistion.
---@param switchValues? boolean Defaults to `false`, this will switch from side to side movement to front back movement. this is good if the eyes are on the *side* of the head rather than the *front*.
---@return SquAPI.Eye
function squapi.eye:new(element, leftDistance, rightDistance, upDistance, downDistance, switchValues)
  return squapi.newEye(element, leftDistance, rightDistance, upDistance, downDistance, switchValues)
end

local events_started = false
squapi[("$startEvents")] = function()
  if events_started then return end
  events_started = true

  events.tick:register(function()
    for _, eye in ipairs(squapi.eyes) do
      eye:tick()
    end
  end, "SquAPI_Eye")

  events.render:register(function(dt)
    for _, eye in ipairs(squapi.eyes) do
      eye:render(dt)
    end
  end, "SquAPI_Eye")
end

return squapi
