---@class SquAPI
local squapi = {}

---Contains all registered randimations
---@type SquAPI.Randimation[]
squapi.randimations = {}

---@class SquAPI.Randimation
---@field stopOnSleep boolean
---@field animation Animation
---@field chanceRange number
squapi.randimation = {}
local RandimationMT = {__index = squapi.randimation}

---Toggle this randimation on or off
function squapi.randimation:toggle()
  self.enabled = not self.enabled
end

---Disable this randimation
function squapi.randimation:disable()
  self.enabled = false
end

---Enable this randimation
function squapi.randimation:enable()
  self.enabled = true
end

---Sets if this randimation is enabled
---@param bool boolean
function squapi.randimation:setEnabled(bool)
  assert(type(bool) == "boolean",
    "§4setEnabled must be set to a boolean.§c")
  self.enabled = bool
end

---Run tick function on randimation
function squapi.randimation:tick()
  if self.enabled and self.animation:isStopped() and (not self.stopOnSleep or player:getPose() ~= "SLEEPING") and math.random(0, self.chanceRange) == 0 then
    self.animation:play()
  end
end



---RANDOM ANIMATION OBJECT - this will randomly play a given animation with a modifiable chance. (good for blinking)
---@param animation Animation The animation to play.
---@param chanceRange? number Defaults to `200`, an optional paramater that sets the range. 0 means every tick, larger values mean lower chances of playing every tick.
---@param stopOnSleep? boolean Defaults to `false`, if this is for blinking set this to true so that it doesn't blink while sleeping.
---@return SquAPI.Randimation
function squapi.newRandimation(animation, chanceRange, stopOnSleep)
  local self = setmetatable({}, RandimationMT)

  -- INIT -------------------------------------------------------------------------
  self.stopOnSleep = stopOnSleep
  self.animation = animation
  self.chanceRange = chanceRange or 200


  -- CONTROL -------------------------------------------------------------------------

  self.enabled = true

  -- UPDATES -------------------------------------------------------------------------


  table.insert(squapi.randimations, self)
  return self
end

---For compatibility
---@param animation Animation The animation to play.
---@param chanceRange? number Defaults to `200`, an optional paramater that sets the range. 0 means every tick, larger values mean lower chances of playing every tick.
---@param stopOnSleep? boolean Defaults to `false`, if this is for blinking set this to true so that it doesn't blink while sleeping.
---@return SquAPI.Randimation
function squapi.randimation:new(animation, chanceRange, stopOnSleep)
  return squapi.newRandimation(animation, chanceRange, stopOnSleep)
end

local events_started = false
squapi[("$startEvents")] = function()
  if events_started then return end
  events_started = true

  events.tick:register(function()
    for _, randimation in ipairs(squapi.randimations) do
      randimation:tick()
    end
  end, "SquAPI_Randimation")
end

return squapi
