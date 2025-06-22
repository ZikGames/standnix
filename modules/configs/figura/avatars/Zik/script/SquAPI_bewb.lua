---@type SquAssets
local squassets = require("./SquAssets")

---@class SquAPI
local squapi = {}

---Contains all registered bewbs
---@type SquAPI.Bewb[]
squapi.bewbs = {}

---@class SquAPI.Bewb
---@field element ModelPart
---@field doIdle boolean
---@field bendability number
---@field bewby SquAssets.BERP
---@field idleStrength number
---@field idleSpeed number
---@field target number
---@field enabled boolean
---@field oldpose Entity.pose
squapi.bewb = {}
local BewbMT = {__index = squapi.bewb}

---Toggle these bewbs on or off
function squapi.bewb:toggle()
  self.enabled = not self.enabled
end

---Disable these bewbs
function squapi.bewb:disable()
  self.enabled = false
end

---Enable these bewbs
function squapi.bewb:enable()
  self.enabled = true
end

---Sets if these bewbs are enabled
---@param bool boolean
function squapi.bewb:setEnabled(bool)
  assert(type(bool) == "boolean",
    "§4setEnabled must be set to a boolean.§c")
  self.enabled = bool
end

---Run tick function on bewbs
function squapi.bewb:tick()
  if self.enabled then
    local vel = squassets.forwardVel()
    local yvel = squassets.verticalVel()
    local worldtime = world.getTime()

    if self.doIdle then
      self.target = math.sin(worldtime / 8 * self.idleSpeed) * self.idleStrength
    end

    --physics when crouching/uncrouching
    local pose = player:getPose()
    if pose == "CROUCHING" and self.oldpose == "STANDING" then
      self.bewby.vel = self.bewby.vel + self.bendability
    elseif pose == "STANDING" and self.oldpose == "CROUCHING" then
      self.bewby.vel = self.bewby.vel - self.bendability
    end
    self.oldpose = pose

    --physics when moving
    self.bewby.vel = self.bewby.vel - yvel * self.bendability
    self.bewby.vel = self.bewby.vel - vel * self.bendability
  else
    self.target = 0
  end
end

---Run render function on bewbs
---@param dt number Tick delta
function squapi.bewb:render(dt, _)
  self.element:setOffsetRot(self.bewby:berp(self.target, dt), 0, 0)
end

---BEWB PHYSICS - this can add bewb physics to your avatar, which for some reason is also versatile for non-tiddy related activities.
---@param element ModelPart The bewb element that you want to affect (models.[modelname].path).
---@param bendability? number Defaults to `2`, how much the bewb should move when you move.
---@param stiff? number Defaults to `0.05`, how stiff the bewb should be.
---@param bounce? number Defaults to `0.9`, how bouncy the bewb should be.
---@param doIdle? boolean Defaults to `true`, whether or not the bewb should have an idle sway (like breathing).
---@param idleStrength? number Defaults to `4`, how much the bewb should sway when idle.
---@param idleSpeed? number Defaults to `1`, how fast the bewb should sway when idle.
---@param downLimit? number Defaults to `-10`, the lowest the bewb can rotate.
---@param upLimit? number Defaults to `25`, the highest the bewb can rotate.
---@return SquAPI.Bewb
function squapi.newBewb(
  element, bendability, stiff, bounce, doIdle, idleStrength, idleSpeed,
  downLimit, upLimit
)
  local self = setmetatable({}, BewbMT)

  -- INIT -------------------------------------------------------------------------
  assert(element, "§4Your model path for bewb is incorrect.§c")
  self.element = element
  if doIdle == nil then doIdle = true end
  self.doIdle = doIdle
  self.bendability = bendability or 2
  self.bewby = squassets.BERP:new(stiff or 0.05, bounce or 0.9, downLimit or -10, upLimit or 25)
  self.idleStrength = idleStrength or 4
  self.idleSpeed = idleSpeed or 1
  self.target = 0

  -- CONTROL -------------------------------------------------------------------------

  self.enabled = true

  -- UPDATE -------------------------------------------------------------------------

  self.oldpose = "STANDING"

  table.insert(squapi.bewbs, self)
  return self
end

---For compatibility
---@param element ModelPart The bewb element that you want to affect (models.[modelname].path).
---@param bendability? number Defaults to `2`, how much the bewb should move when you move.
---@param stiff? number Defaults to `0.05`, how stiff the bewb should be.
---@param bounce? number Defaults to `0.9`, how bouncy the bewb should be.
---@param doIdle? boolean Defaults to `true`, whether or not the bewb should have an idle sway (like breathing).
---@param idleStrength? number Defaults to `4`, how much the bewb should sway when idle.
---@param idleSpeed? number Defaults to `1`, how fast the bewb should sway when idle.
---@param downLimit? number Defaults to `-10`, the lowest the bewb can rotate.
---@param upLimit? number Defaults to `25`, the highest the bewb can rotate.
---@return SquAPI.Bewb
function squapi.bewb:new(
  element, bendability, stiff, bounce, doIdle, idleStrength, idleSpeed,
  downLimit, upLimit
)
  return squapi.newBewb(
    element, bendability, stiff, bounce, doIdle, idleStrength, idleSpeed,
    downLimit, upLimit
  )
end

local events_started = false
squapi[("$startEvents")] = function()
  if events_started then return end
  events_started = true

  events.tick:register(function()
    for _, bewb in ipairs(squapi.bewbs) do
      bewb:tick()
    end
  end, "SquAPI_Bewb")

  events.render:register(function(dt)
    for _, bewb in ipairs(squapi.bewbs) do
      bewb:render(dt)
    end
  end, "SquAPI_Bewb")
end

return squapi
