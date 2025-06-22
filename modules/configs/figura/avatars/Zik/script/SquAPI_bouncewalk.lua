---@class SquAPI
local squapi = {}

---Contains all registered bounce walks
---@type SquAPI.BounceWalk[]
squapi.bounceWalks = {}


---@class SquAPI.BounceWalk
---@field modelpart ModelPart
---@field bounceMultiplier number
---@field target number
---@field enabled boolean
squapi.bounceWalk = {}
local BounceWalkMT = {__index = squapi.bounceWalk}

---Toggle this bounce walk on or off
function squapi.bounceWalk:toggle()
  self.enabled = not self.enabled
end

---Disable this bounce walk
function squapi.bounceWalk:disable()
  self.enabled = false
end

---Enable this bounce walk
function squapi.bounceWalk:enable()
  self.enabled = true
end

---Sets if this bounce walk is enabled
---@param bool boolean
function squapi.bounceWalk:setEnabled(bool)
  assert(type(bool) == "boolean",
    "§4setEnabled must be set to a boolean.§c")
  self.enabled = bool
end

---Run render function on bounce walk
function squapi.bounceWalk:render(dt, _)
  local pose = player:getPose()
  if self.enabled and (pose == "STANDING" or pose == "CROUCHING") then
    local leftlegrot = vanilla_model.LEFT_LEG:getOriginRot()[1]
    local bounce = self.bounceMultiplier
    if pose == "CROUCHING" then
      bounce = bounce / 2
    end
    self.target = math.abs(leftlegrot) / 40 * bounce
  else
    self.target = 0
  end
  self.modelpart:setPos(0, math.lerp(self.modelpart:getPos()[2], self.target, dt), 0)
end

---BOUNCE WALK - this will make your character curtly bounce/hop with each step (the strength of this bounce can be controlled).
---@param model ModelPart The path to your model element.
---@param bounceMultiplier? number Defaults to `1`, this multiples how much the bounce occurs.
---@return SquAPI.BounceWalk
function squapi.newBounceWalk(model, bounceMultiplier)
  local self = setmetatable({}, BounceWalkMT)

  -- INIT -------------------------------------------------------------------------

  assert(model, "Your model path is incorrect for bounceWalk")
  self.modelpart = model
  self.bounceMultiplier = bounceMultiplier or 1
  self.target = 0

  -- CONTROL -------------------------------------------------------------------------

  self.enabled = true

  -- UPDATES -------------------------------------------------------------------------


  table.insert(squapi.bounceWalks, self)
  return self
end

---For compatibility.
---@param model ModelPart The path to your model element.
---@param bounceMultiplier? number Defaults to `1`, this multiples how much the bounce occurs.
---@return SquAPI.BounceWalk
function squapi.bounceWalk:new(model, bounceMultiplier)
  return squapi.newBounceWalk(model, bounceMultiplier)
end

local events_started = false
squapi[("$startEvents")] = function()
  if events_started then return end
  events_started = true

  events.render:register(function(dt)
    for _, bouncewalk in ipairs(squapi.bounceWalks) do
      bouncewalk:render(dt)
    end
  end, "SquAPI_BounceWalk")
end

return squapi
