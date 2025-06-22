---@type SquAssets
local squassets = require("./SquAssets")

---@class SquAPI
local squapi = {}

---Contains all registered taurs
---@type SquAPI.Taur[]
squapi.taurs = {}

---@class SquAPI.Taur
---@field taurBody ModelPart
---@field frontLegs ModelPart
---@field backLegs ModelPart
---@field taur SquAssets.BERP
---@field target number
---@field enabled boolean
squapi.taur = {}
local TaurMT = {__index = squapi.taur}

---Toggle this taur on or off
function squapi.taur:toggle()
  self.enabled = not self.enabled
end

---Disable this taur
function squapi.taur:disable()
  self.enabled = false
end

---Enable this taur
function squapi.taur:enable()
  self.enabled = true
end

---Sets if this taur is enabled
---@param bool boolean
function squapi.taur:setEnabled(bool)
  assert(type(bool) == "boolean", "§4setEnabled must be set to a boolean.§c")
  self.enabled = bool
end
---Run tick function on taur
function squapi.taur:tick()
  if self.enabled then
    self.target = math.min(math.max(-30, squassets.verticalVel() * 40), 45)
  end
end

---Run render function on taur
---@param dt number Tick delta
function squapi.taur:render(dt, _)
  if self.enabled then
    self.taur:berp(self.target, dt / 2)
    local pose = player:getPose()

    if pose == "FALL_FLYING" or pose == "SWIMMING" or (player:isClimbing() and not player:isOnGround()) or player:riptideSpinning() then
      self.taurBody:setRot(80, 0, 0)
      if self.backLegs then
        self.backLegs:setRot(-50, 0, 0)
      end
      if self.frontLegs then
        self.frontLegs:setRot(-50, 0, 0)
      end
    else
      self.taurBody:setRot(self.taur.pos, 0, 0)
      if self.backLegs then
        self.backLegs:setRot(self.taur.pos * 3, 0, 0)
      end
      if self.frontLegs then
        self.frontLegs:setRot(-self.taur.pos * 3, 0, 0)
      end
    end
  end
end

---TAUR PHYSICS - this will add some extra movement to taur-based models when you jump/fall.
---@param taurBody ModelPart The group of the body that contains all parts of the actual centaur part of the body, pivot should be placed near the connection between body and taurs body.
---@param frontLegs? ModelPart The group that contains both front legs.
---@param backLegs? ModelPart The group that contains both back legs.
---@return SquAPI.Taur
function squapi.newTaur(taurBody, frontLegs, backLegs)
  local self = setmetatable({}, TaurMT)

  -- INIT -------------------------------------------------------------------------

  assert(taurBody, "§4Your model path for the body in taurPhysics is incorrect.§c")
  --assert(frontLegs, "§4Your model path for the front legs in taurPhysics is incorrect.§c")
  --assert(backLegs, "§4Your model path for the back legs in taurPhysics is incorrect.§c")
  self.taurBody = taurBody
  self.frontLegs = frontLegs
  self.backLegs = backLegs
  self.taur = squassets.BERP:new(0.01, 0.5)
  self.target = 0

  -- CONTROL -------------------------------------------------------------------------

  self.enabled = true

  -- UPDATES -------------------------------------------------------------------------


  table.insert(squapi.taurs, self)
  return self
end

---@param taurBody ModelPart The group of the body that contains all parts of the actual centaur part of the body, pivot should be placed near the connection between body and taurs body.
---@param frontLegs? ModelPart The group that contains both front legs.
---@param backLegs? ModelPart The group that contains both back legs.
---@return SquAPI.Taur
function squapi.taur:new(taurBody, frontLegs, backLegs)
  return squapi.newTaur(taurBody, frontLegs, backLegs)
end

local events_started = false
squapi[("$startEvents")] = function()
  if events_started then return end
  events_started = true

  events.tick:register(function()
    for _, taur in ipairs(squapi.taurs) do
      taur:tick()
    end
  end, "SquAPI_Taur")

  events.render:register(function(dt)
    for _, taur in ipairs(squapi.taurs) do
      taur:render(dt)
    end
  end, "SquAPI_Taur")
end

return squapi
