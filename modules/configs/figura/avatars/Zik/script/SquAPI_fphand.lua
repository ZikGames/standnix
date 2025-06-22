---@class SquAPI
local squapi = {}

---Contains all registered first person hands
---@type SquAPI.FPHand[]
squapi.FPHands = {}

---@class SquAPI.FPHand
---@field element ModelPart
---@field x number
---@field y number
---@field z number
---@field scale number
---@field onlyVisibleInFP boolean
squapi.FPHand = {}
local FPHandMT = {}

---Set the first person hand's position
---@param _x number X position
---@param _y number Y position
---@param _z number Z position
function squapi.FPHand:updatePos(_x, _y, _z)
  self.x = _x
  self.y = _y
  self.z = _z
end

---Run render function on first person hand
---@param context Event.Render.context
function squapi.FPHand:render(_, context)
  if context == "FIRST_PERSON" then
    if self.onlyVisibleInFP then
      self.element:setVisible(true)
    end
    self.element:setPos(self.x, self.y, self.z)
    self.element:setScale(self.scale, self.scale, self.scale)
  else
    if self.onlyVisibleInFP then
      self.element:setVisible(false)
    end
    self.element:setPos(0, 0, 0)
  end
end

---CUSTOM FIRST PERSON HAND  
---**!!Make sure the setting for modifying first person hands is enabled in the Figura settings for this to work properly!!**
---@param element ModelPart The actual hand element to change.
---@param x? number Defaults to `0`, the x change.
---@param y? number Defaults to `0`, the y change.
---@param z? number Defaults to `0`, the z change.
---@param scale? number Defaults to `1`, this will multiply the size of the element by this size.
---@param onlyVisibleInFP? boolean Defaults to `false`, this will make the element invisible when not in first person if true.
---@return SquAPI.FPHand
function squapi.newFPHand(element, x, y, z, scale, onlyVisibleInFP)
  local self = setmetatable({}, FPHandMT)

  -- INIT -------------------------------------------------------------------------

  assert(element, "Your First Person Hand path is incorrect")
  element:setParentType("RightArm")
  self.element = element
  self.x = x or 0
  self.y = y or 0
  self.z = z or 0
  self.scale = scale or 1
  self.onlyVisibleInFP = onlyVisibleInFP

  -- CONTROL -------------------------------------------------------------------------

  -- UPDATES -------------------------------------------------------------------------

  table.insert(squapi.FPHands, self)
  return self
end

---For compatibility
---@param element ModelPart The actual hand element to change.
---@param x? number Defaults to `0`, the x change.
---@param y? number Defaults to `0`, the y change.
---@param z? number Defaults to `0`, the z change.
---@param scale? number Defaults to `1`, this will multiply the size of the element by this size.
---@param onlyVisibleInFP? boolean Defaults to `false`, this will make the element invisible when not in first person if true.
---@return SquAPI.FPHand
function squapi.FPHand:new(element, x, y, z, scale, onlyVisibleInFP)
  return squapi.newFPHand(element, x, y, z, scale, onlyVisibleInFP)
end

local events_started = false
squapi[("$startEvents")] = function()
  if events_started then return end
  events_started = true

  events.render:register(function(dt, ctx)
    for _, fphand in ipairs(squapi.FPHands) do
      fphand:render(dt, ctx)
    end
  end, "SquAPI_FPHand")
end

return squapi
