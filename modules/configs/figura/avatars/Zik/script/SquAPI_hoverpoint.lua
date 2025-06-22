---@class SquAPI
local squapi = {}

---Contains all registered hover points
---@type SquAPI.HoverPoint[]
squapi.hoverPoints = {}

---@class SquAPI.HoverPoint
---@field element ModelPart
---@field elementOffset Vector3
---@field springStrength number
---@field mass number
---@field resistance number
---@field rotationSpeed number
---@field doCollisions boolean
---@field rotateWithPlayer boolean
---@field enabled boolean
---@field pos Vector3
---@field vel Vector3
---@field init boolean
---@field delay number
squapi.hoverPoint = {}
local HoverpointMT = {__index = squapi.hoverPoint}

---Toggles this hover point on or off
function squapi.hoverPoint:toggle()
  self.enabled = not self.enabled
end

---Disables this hover point
function squapi.hoverPoint:disable()
  self.enabled = false
end

---Enables this hover point
function squapi.hoverPoint:enable()
  self.enabled = true
end

---Sets if this hover point is enabled
---@param bool boolean
function squapi.hoverPoint:setEnabled(bool)
  assert(type(bool) == "boolean",
    "§4setEnabled must be set to a boolean.§c")
  self.enabled = bool
end

---Resets this hover point's position to its initial position
function squapi.hoverPoint:reset()
  local yaw
  if self.rotateWithPlayer then
      yaw = math.rad(player:getBodyYaw() + 180)
  else
      yaw = 0
  end
  local sin, cos = math.sin(yaw), math.cos(yaw)
  local offset = vec(
      cos*self.elementOffset.x - sin*self.elementOffset.z, 
      self.elementOffset.y,
      sin*self.elementOffset.x + cos*self.elementOffset.z
  )
  self.pos = player:getPos() + offset/16
  self.element:setPos(self.pos*16)
  self.element:setOffsetRot(0,-player:getBodyYaw()+180,0)
end

function squapi.hoverPoint:tick()
  if self.enabled then
    local yaw
    if self.rotateWithPlayer then
        yaw = math.rad(player:getBodyYaw() + 180)
    else
        yaw = 0
    end

    local sin, cos = math.sin(yaw), math.cos(yaw)
    local offset = vec(
      cos*self.elementOffset.x - sin*self.elementOffset.z, 
      self.elementOffset.y,
      sin*self.elementOffset.x + cos*self.elementOffset.z
    )

    if self.init then
      self.init = false
      self.pos = player:getPos() + offset/16
      self.element:setPos(self.pos*16)
      self.element:setOffsetRot(0,-player:getBodyYaw()+180,0)
    end

    --adjusts the target based on the players rotation
    local target = player:getPos() + offset/16
    local pos = self.element:partToWorldMatrix():apply()
    local dif = self.pos - target

    local force = vec(0,0,0)

    if self.delay == 0 then
      --behold my very janky collision system
      if self.doCollisions and world.getBlockState(pos):getCollisionShape()[1] then
        local block, hitPos, side = raycast:block(pos-self.vel*2, pos)
        self.pos = self.pos + (hitPos - pos)
        if side == "east" or side == "west" then
          self.vel.x = -self.vel.x*0.5
        elseif side == "north" or side == "south" then
          self.vel.z = -self.vel.z*0.5
        else
          self.vel.y = -self.vel.y*0.5
        end
        self.delay = 2
      else
        force = force - dif*self.springStrength --spring force
      end
    else
      self.delay = self.delay - 1
    end
    force = force - self.vel * self.resistance --resistive force(based on air resistance)

    self.vel = self.vel + force/self.mass
    self.pos = self.pos + self.vel
  end
end

---Run render function on hover point
---@param dt number Tick delta
function squapi.hoverPoint:render(dt, _)
  self.element:setPos(
    math.lerp(self.element:getPos(), self.pos * 16, dt / 2)
  )
  self.element:setOffsetRot(0,
    math.lerp(self.element:getOffsetRot()[2], 180-player:getBodyYaw(), dt * self.rotationSpeed), 0)
end


---HOVER POINT ITEM - this will cause this element to naturally float to it’s normal position rather than being locked with the players movement. Great for floating companions.
---@param element ModelPart The element you are moving.
---@param elementOffset? Vector3 Defaults to `vec(0,0,0)`, the position of the hover point relative to you.
---@param springStrength? number Defaults to `0.2`, how strongly the object is pulled to it's original spot.
---@param mass? number Defaults to `5`, how heavy the object is (heavier accelerate/deccelerate slower).
---@param resistance? number Defaults to `1`, how much the elements speed decays (like air resistance).
---@param rotationSpeed? number Defaults to `0.05`, how fast the element should rotate to it's normal rotation.
---@param rotateWithPlayer? boolean Defaults to `true`, wheather or not the hoverPoint should rotate with you
---@param doCollisions? boolean Defaults to `false`, whether or not the element should collide with blocks (warning: the system is janky).
---@return SquAPI.HoverPoint
function squapi.newHoverPoint(element, elementOffset, springStrength, mass, resistance, rotationSpeed, rotateWithPlayer, doCollisions)
  local self = setmetatable({}, HoverpointMT)

  -- INIT -------------------------------------------------------------------------
  self.element = element
  assert(self.element,
    "§4The Hover point's model path is incorrect.§c")
  self.element:setParentType("WORLD")
  elementOffset = elementOffset or vec(0,0,0)
  self.elementOffset = elementOffset*16
  self.springStrength = springStrength or 0.2
  self.mass = mass or 5
  self.resistance = resistance or 1
  self.rotationSpeed = rotationSpeed or 0.05
  self.doCollisions = doCollisions
  self.rotateWithPlayer = rotateWithPlayer
  if self.rotateWithPlayer == nil then self.rotateWithPlayer = true end

  -- CONTROL -------------------------------------------------------------------------

  self.enabled = true

  self.pos = vec(0,0,0)
  self.vel = vec(0,0,0)

  -- UPDATES -------------------------------------------------------------------------

  self.init = true
  self.delay = 0

  table.insert(squapi.hoverPoints, self)
  return self
end

---For compatibility
---@param element ModelPart The element you are moving.
---@param elementOffset? Vector3 Defaults to `vec(0,0,0)`, the position of the hover point relative to you.
---@param springStrength? number Defaults to `0.2`, how strongly the object is pulled to it's original spot.
---@param mass? number Defaults to `5`, how heavy the object is (heavier accelerate/deccelerate slower).
---@param resistance? number Defaults to `1`, how much the elements speed decays (like air resistance).
---@param rotationSpeed? number Defaults to `0.05`, how fast the element should rotate to it's normal rotation.
---@param rotateWithPlayer? boolean Defaults to `true`, wheather or not the hoverPoint should rotate with you
---@param doCollisions? boolean Defaults to `false`, whether or not the element should collide with blocks (warning: the system is janky).
---@return SquAPI.HoverPoint
function squapi.hoverPoint:new(element, elementOffset, springStrength, mass, resistance, rotationSpeed, rotateWithPlayer, doCollisions)
  return squapi.newHoverPoint(element, elementOffset, springStrength, mass, resistance, rotationSpeed, rotateWithPlayer, doCollisions)
end

local events_started = false
squapi[("$startEvents")] = function()
  if events_started then return end
  events_started = true

  events.tick:register(function()
    for _, hoverpoint in ipairs(squapi.hoverPoints) do
      hoverpoint:tick()
    end
  end, "SquAPI_HoverPoint")

  events.render:register(function(dt)
    for _, hoverpoint in ipairs(squapi.hoverPoints) do
      hoverpoint:render(dt)
    end
  end, "SquAPI_HoverPoint")
end

return squapi
