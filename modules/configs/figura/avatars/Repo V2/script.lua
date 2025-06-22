vanilla_model.PLAYER:setVisible(false)
vanilla_model.ARMOR:setVisible(false)
vanilla_model.HELMET_ITEM:setVisible(false)
vanilla_model.CAPE:setVisible(false)
vanilla_model.ELYTRA:setVisible(false)

models.model.root.torso.body.topbody.head.upperhead.googly.Rcutout:setPrimaryRenderType("CUTOUT_CULL")
models.model.root.torso.body.topbody.head.upperhead.googly.Lcutout:setPrimaryRenderType("CUTOUT_CULL")
models.model.root.torso.body.topbody.head.upperhead.googly.rightgoogle.rightgoogle_light:setSecondaryRenderType("EMISSIVE")
models.model.root.torso.body.topbody.head.upperhead.googly.leftgoogle.leftgoogle_light:setSecondaryRenderType("EMISSIVE")

require("GSAnimBlend")
local anims = require("EZAnims")
local repo = anims:addBBModel(animations.model)
local squapi = require("SquAPI")
local SwingingPhysics = require("swinging_physics")
local swingOnHead = SwingingPhysics.swingOnHead
local swingOnBody = SwingingPhysics.swingOnBody

--========== ANIM SETTINGS

animations.model.armrot:play()

animations.model.crouching:setBlendTime(1)
animations.model.yap:setBlendTime(1)
animations.model.shrink:setBlendTime(0.5)

--========== LIMBS

swingOnBody(models.model.root.torso.body.topbody.arms.rightarm.armrot, 0, {-5,5,-5,5,-5,5})
swingOnHead(models.model.root.torso.body.topbody.arms.rightarm.armrot.botarm_R.bothand_R.pivotrot.RightItemPivot, 0, {-20,20,-20,20,-50,05})
swingOnHead(models.model.root.torso.body.topbody.arms.leftarm.botarm_L.bothand_L.pivotrotL.LeftItemPivot, 0, {-20,20,-20,20,-50,50})

animations.model.firstpersonidle:play()
function events.render(delta,context)
    local firstPerson=context=="FIRST_PERSON"
    models.model.firstpersonarm:setVisible(firstPerson):setParentType(context=="FIRST_PERSON" and "RightArm" or "None")

    if animations.model.holdL:isPlaying() then
        models.model.root.torso.body.topbody.arms.leftarm.botarm_L.bothand_L.pivotrotL.LeftItemPivot:setRot(vanilla_model.RIGHT_ARM:getOriginRot()*0.1)
      else
        models.model.root.torso.body.topbody.arms.leftarm.botarm_L.bothand_L.pivotrotL.LeftItemPivot:setRot(0)
    end
    if animations.model.holdR:isPlaying() then
        models.model.root.torso.body.topbody.arms.rightarm.armrot.botarm_R.bothand_R.pivotrot.RightItemPivot:setRot(vanilla_model.LEFT_ARM:getOriginRot()*0.1)
      else
        models.model.root.torso.body.topbody.arms.rightarm.armrot.botarm_R.bothand_R.pivotrot.RightItemPivot:setRot(0)
    end
end

    animations.model.holdNoR:play()
    animations.model.holdNoR:setBlendTime(2)
    animations.model.holdNoL:play()
    animations.model.holdNoL:setBlendTime(2)

-- LEANWALK

      local prevVel = vec(0,0,0)
      local curVel = vec(0,0,0)
    function events.tick()
        prevVel = curVel
        curVel = player:getVelocity()
    end

      local walkStr = 50
    function events.render(delta)
          
      local vel = math.lerp(prevVel,curVel,delta):transform(matrices.rotation3(0, player:getRot().y)) * walkStr
      local moveRot = vec(-vel.z*0.7, 0, vel.x*0.7)

        models.model.root:offsetRot(moveRot/4)
        models.model.root.torso:offsetRot(moveRot/4)
    end

--========== UHH MORE SETTINGS

-- random anims

local animFreq = 100 -- measured in ticks
local animVar = 0.75 -- 0-1

local ramdomAnimations = {
    animations.model.fingertwitch,
    animations.model.fingertwitch2,
    animations.model.fingerspin,
}
    animations.model.fingertwitch:setBlendTime(3)
    animations.model.fingertwitch2:setBlendTime(3)
    animations.model.fingerspin:setBlendTime(0)

local playRandom = animFreq 

local _rot
local rot = { 0,0,0 }

local head_part = models.model.root.torso.body.topbody.head
local torso_part = models.model.root.torso
local toptorso_part = models.model.root.torso.body.topbody
local model = models.model
local rArm = models.model.root.torso.body.topbody.arms.rightarm
local lArm = models.model.root.torso.body.topbody.arms.leftarm

function events.tick()

-- random anims

    playRandom = playRandom - 1

    if playRandom <= 0 then
        for _, ramdomAnim in ipairs(ramdomAnimations) do
            ramdomAnim:stop()
        end
            ramdomAnimations[math.random(#ramdomAnimations)]:play()

    playRandom = animFreq * (math.random()+0.5) * animVar * 2

    end

-- holding item = finger activation

    if animations.model.holdR:isPlaying(true) then
        animations.model.holdNoR:stop()
    else
        animations.model.holdNoR:play()
    end
    if animations.model.holdL:isPlaying(true) then
        animations.model.holdNoL:stop()
    else
        animations.model.holdNoL:play()
    end

--  yes

  _rot = (vanilla_model.HEAD:getOriginRot() + 180) % 360 - 180

end
function GetRotations()
  rot[1] = math.lerp(rot[1], _rot.x,0.1)

  rot[2] = math.lerp(rot[2], _rot.y,0.1)
end
function SmoothBodyRot(modelpart, xmod, ymod, zxmod, zymod)
  zxmod = zxmod or 0
  zymod = zymod or 0

  modelpart:setRot(rot[1] * xmod, rot[2] * ymod, rot[1] * zxmod + rot[2] * zymod)
  modelpart:setPos(-rot[1] * xmod / 200, -rot[2] * ymod / 2000, rot[1] * zxmod / 200 + rot[2] * zymod / 200)
end

squapi.arm:new(models.model.root.torso.body.topbody.arms.leftarm, 0.2, isRight, false) 
squapi.arm:new(models.model.root.torso.body.topbody.arms.rightarm, 0.2, true, false) 

function events.render()
  GetRotations()

  -- smoove body
    SmoothBodyRot(head_part, 0.5,0.5,0)
    SmoothBodyRot(torso_part, 0.3, 0.3, 0)
    SmoothBodyRot(toptorso_part, 0.3, 0, 0)
    SmoothBodyRot(model, 0.05, 0.1, 0)

    if animations.model.holdL:isPlaying() then
        SmoothBodyRot(lArm, 0.8,0.2,0.3)
      else
        SmoothBodyRot(lArm, 0,0,0)
    end
    if animations.model.holdR:isPlaying() then
        SmoothBodyRot(rArm, 0.8,0.2,-0.3)
      else
        SmoothBodyRot(rArm, 0,0,0)
    end

-- item collision
    local randomtime = math.random(-10,5)
    if world.getTime() % randomtime == 1 and animations.model.holdR:isPlaying() and (world.getBlockState(models.model.root.torso.body.topbody.arms.rightarm.armrot.botarm_R.bothand_R.pivotrot.RightItemPivot:partToWorldMatrix():apply()).id ~= "minecraft:air") then
        animations.model.itemBreakR:play()
        particles:newParticle("minecraft:cloud", models.model.root.torso.body.topbody.arms.rightarm.armrot.botarm_R.bothand_R.pivotrot.RightItemPivot:partToWorldMatrix(2,2,2):apply()):color(math.lerp(vec(.2,.2,.2), vec(0.5,0.5,0.5), math.random())):setScale(3):setLifetime(20):spawn()
    else
        animations.model.itemBreakR:stop()
    end
    if world.getTime() % randomtime == 1 and animations.model.holdL:isPlaying() and (world.getBlockState(models.model.root.torso.body.topbody.arms.leftarm.botarm_L.bothand_L.pivotrotL.LeftItemPivot:partToWorldMatrix():apply()).id ~= "minecraft:air") then
        animations.model.itemBreakL:play()
        particles:newParticle("minecraft:cloud", models.model.root.torso.body.topbody.arms.leftarm.botarm_L.bothand_L.pivotrotL.LeftItemPivot:partToWorldMatrix(2,2,2):apply()):color(math.lerp(vec(.2,.2,.2), vec(0.5,0.5,0.5), math.random())):setScale(3):setLifetime(20):spawn()
    else
        animations.model.itemBreakL:stop()
    end

-- legs & boing updown
    local isWalking = player:getVelocity().xz:length() ~= 0
    if player:isSprinting() or isWalking then
        models.model.root:setPos(0, math.abs(vanilla_model.LEFT_LEG:getOriginRot()[1]/90), 0)
    end
    if isWalking and not animations.model.shrink:isPlaying() then
        models.model.root.legs.leftleg:setPos(0, math.abs(vanilla_model.RIGHT_LEG:getOriginRot()[1]/50), 0)
        models.model.root.legs.rightleg:setPos(0, math.abs(vanilla_model.RIGHT_LEG:getOriginRot()[1]/50), 0)
    end
--[[
-- jump up held item phys
    local jumpVel = player:getVelocity().y
    models.model.root.torso.body.topbody.arms.rightarm.armrot.botarm_R.bothand_R.pivotrot.RightItemPivot:setPos(0, jumpVel[1], 0)]]
end
	-- legs rotation \\ squapi.leg:new(element, strength, isRight(false), keepPosition)
		squapi.leg:new(models.model.root.legs.leftleg, 0.5, isRight, false)
		squapi.leg:new(models.model.root.legs.rightleg, 0.5, true, false)

--========== KEYBINDS

-- yapping

local keybindState = false
function pings.yapPing(state)
    keybindState = state
    if state then
	    animations.model.yap:play()
	else
		animations.model.yap:stop()
	end
end
local yapkey = keybinds:newKeybind("Yap Key","key.keyboard.g")
yapkey.press = function() pings.yapPing(true) end
yapkey.release = function() pings.yapPing(false) end

-- full crouch

local shrinkToggled = false
local lastShrinkState = false
local crouchkey = keybinds:newKeybind("Shrink Key","key.keyboard.r")

crouchkey.press = function() isShrinkPressed = true pings.shrinkPing() end

function pings.shrinkPing()
    if isShrinkPressed then
            animations.model.shrink:play() 
        if shrinkToggled or animations.model.crouching:isPlaying() then
            animations.model.shrink:stop()
            shrinkToggled = false
            return
        end

        shrinkToggled = true
        --log(shrinkToggled)
    end
end

-- extend and retract held items

local upArrow = keybinds:newKeybind("Move Item Forward", "key.keyboard.up")
local downArrow = keybinds:newKeybind("Move Item Backward", "key.keyboard.down")

local currentZ = 0
local targetZ = 0

local moveSpeed = 0.8         -- How much to move per tick while held
local smoothingFactor = 1    -- How quickly the position blends (higher = snappier)
local minZ, maxZ = -30, 5     -- Clamp range

function events.render()
    -- Check if keys are held down and adjust targetZ
    if upArrow:isPressed() then
        targetZ = math.min(targetZ + moveSpeed, maxZ)
    elseif downArrow:isPressed() then
        targetZ = math.max(targetZ - moveSpeed, minZ)
    end

    -- Apply exponential smoothing for smooth movement
    --currentZ = currentZ + (targetZ - currentZ) * smoothingFactor
    currentZ = math.lerp(currentZ, targetZ, smoothingFactor)

    -- Apply to the model only if the animation is playing
    if animations.model.holdR:isPlaying() then
        models.model.root.torso.body.topbody.arms.rightarm.armrot.botarm_R.bothand_R.pivotrot.RightItemPivot:setPos(currentZ/3, currentZ, currentZ/2)
    end
    if animations.model.holdL:isPlaying() then
        models.model.root.torso.body.topbody.arms.leftarm.botarm_L.bothand_L.pivotrotL.LeftItemPivot:setPos(-currentZ/3, currentZ, currentZ/2)
    end
end

--========== EYE MVT 

function events.render()
    headRotX = (vanilla_model.HEAD:getOriginRot().x+180)%360-180
    headRotY = (vanilla_model.HEAD:getOriginRot().y+180)%360-180

  if headRotY > 0 then
      models.model.root.torso.body.topbody.head.upperhead.googly.leftgoogle.leftgoogle_light:setPos(math.clamp(headRotY / 150 * -1, 1, 0),math.clamp(headRotX / 100 * 1, -1, 0),0)
      models.model.root.torso.body.topbody.head.upperhead.googly.rightgoogle.rightgoogle_light:setPos(0,math.clamp(headRotX / 100 * 1, -2, 0),0)
  else if headRotY < 0 then
      models.model.root.torso.body.topbody.head.upperhead.googly.leftgoogle.leftgoogle_light:setPos(0,math.clamp(headRotX / 100 * 1, -2, 0),0)
      models.model.root.torso.body.topbody.head.upperhead.googly.rightgoogle.rightgoogle_light:setPos(math.clamp(headRotY / 150 * -1, 0, 1),math.clamp(headRotX / 100 * 1, -1, 0),0)
  end
  end

end

--========== EYE JIGGLE WIGGLE PHYSICS // credits to @invalid_os on discord

config:name("GooglyEyes")

-- velocity dampening constant for when a collision occurs
local BOUNCINESS = 0.7

-- acceleration from gravity
local GRAVITY = 0.08

-- determines how the googly eyes move
-- 0 causes them to only move with gravity and player movement
-- 1 causes them to follow the head rotation
-- 2 combines them, using 0's physics while applying a force towards the positon the iris would be at with 1
local movementMode = config:load("Mode") or 1

-- the position values of each googly eye's iris are relative to their respective eye's center
local leftGooglePos = vec(-0.25,0)
local leftGooglePrevPos = vec(-0.25,0)
local leftGoogleVel = vec(0,0)

local rightGooglePos = vec(0.25,0)
local rightGooglePrevPos = vec(0.25,0)
local rightGoogleVel = vec(0,0)

local headRot = vec(0,0)
local prevHeadRot = vec(0,0)
local headRotVel = vec(0,0)

--- Classic head rotation-based movement.
--- @return Vector2
--- @return Vector2
local function getGooglyEyePosFromHeadRot()
    local headRotX = (vanilla_model.HEAD:getOriginRot().x+180)%360-180
    local headRotY = (vanilla_model.HEAD:getOriginRot().y+180)%360-180

    local headYawSign = math.sign(headRotY)
    local leftMult  = headYawSign == 1 and 0.01    or 0.00667 -- 1/100 if head yaw is greater than 0, ~1/150 if less than or equal to 0
    local rightMult = headYawSign == 1 and 0.00667 or 0.01    -- ~1/150 if head yaw is greater than 0, 1/100 if less than or equal to 0

    return
        -- left eye pos
        vec(
            math.clamp(-headRotY * leftMult, -1, 0.5),
            math.clamp(headRotX * 0.05, -0.5, 0.5)
        ),

        -- right eye pos
        vec(
            math.clamp(-headRotY * rightMult, -0.5, 1),
            math.clamp(headRotX * 0.05, -0.5, 0.5)
        )
end

--- Returns a force vector from head rotation.
--- @return Vector2
local function headRotVelForce()
    return vec(-headRotVel.y / 90, headRotVel.x / 90)
end

--- Detects if a collision occurred, and returns where and when it happened, plus the normal vector of the surface it hit.
--- @param pos Vector2
--- @param vel Vector2
--- @return Vector2 posHit
--- @return number time
--- @return Vector2 normal
local function doCollisionStep(pos, vel)
    -- for detecting if we've hit the edge, we can simply assume the iris is a point, and the googly eye itself is only 1 pixel wide
    -- this means the boundaries for the eye are at +-0.5 on both axes

    local time = 1

    local collisionTimes = {1, 1}
    local posHit = {vec(0,0), vec(0,0)}
    local axisVel = 0
    local truePosHit = vec(0,0)

    -- find collision times for each side
    for index = 1,2 do
        local nextPos = pos[index] + vel[index]

        -- absolute value lets us not have to test each side, only ones we can collide with this tick
        if math.abs(nextPos) > 0.5 then
            --pos + vel / x = 0.5
            --vel / x = 0.5 - pos
            --x = (0.5 - pos) / vel

            -- attempt to avoid divison by 0
            collisionTimes[index] = vel[index] == 0 and 1 or ((math.sign(vel[index]) * 0.5 - pos[index]) / vel[index])
            posHit[index] = pos + vel * collisionTimes[index]

            truePosHit = posHit[index]
            axisVel = vel[index]
        end
    end

    -- if the collision time is greater than 1, it didn't happen this frame.
    if collisionTimes[1] >= 1 and collisionTimes[2] >= 1 then return pos+vel, 1, vec(0,0) end

    -- get collision normal/time
    local normal = vec(1,1)
    time = collisionTimes[1]

    if collisionTimes[1] < collisionTimes[2] then
        normal = vec(1,0)
    elseif collisionTimes[2] < collisionTimes[1] then
        normal = vec(0,1)
        time = collisionTimes[2]
    end

    normal = -math.sign(axisVel) * normal

    return truePosHit, time, normal
end

local function flipVec(vec, normal)
    if normal.x ~= 0 then vec.x = -vec.x end
    if normal.y ~= 0 then vec.y = -vec.y end

    return vec
end

--- Handles collision.
--- @param pos Vector2
--- @param vel Vector2
--- @return Vector2 newPos
--- @return Vector2 newVel
local function doCollision(pos, vel)
    local panicked = false
    local doGrav = true
    local timeLatest = 0
    local iter = 0

    local prevPos = pos
    while true do
        -- stop infinite loops
        if iter > 50 then
            panicked = true
            break
        end

        -- velocity for this step
        local stepVel = iter == 0 and vel or (pos - prevPos)

        -- do step
        local posHit, time, normal = doCollisionStep(prevPos, stepVel)
        --print(posHit, time, normal)

        local normalSquare = normal:lengthSquared() -- normal.normal

        -- break if the collision doesn't happen this tick
        if time >= 1 then
            break
        else
            if normalSquare ~= 0 then
                -- save this for later
                prevPos = pos

                --[[ set new position / velocity
                vel = flipVec(vel, normal) * BOUNCINESS + headRotVelForce()
                pos = posHit + normal*0.005]]

                local velDot = (1-time) * stepVel:dot(normal)
                local wallSlideVec = ((1-time) * stepVel) - (velDot/normalSquare)*normal

                -- new pos
                pos = posHit + wallSlideVec

                -- new vel part 1
                vel = vel * normal.yx:applyFunc(math.abs) * 0.99 +
                    flipVec(vel,normal) * normal:applyFunc(math.abs) * BOUNCINESS
            end

            -- new vel part 2
            vel = vel + headRotVelForce()
        end

        iter = iter + 1
    end

    --print(pos, vel, iter)

    -- if an infinite loop occurred, extinguish the fire
    if panicked then pos, vel = vec(0,0), vec(0,0) end

    return pos, vel
end

local prevVel = vec(0,0,0)
local prevHeadRotVel = vec(0,0)
function events.tick()
    headRot = vec((vanilla_model.HEAD:getOriginRot().x+180)%360-180, (vanilla_model.HEAD:getOriginRot().y+180)%360-180)
    headRotVel = headRot - prevHeadRot

    local accel = player:getVelocity() - prevVel
    local lrAccel = (accel * matrices.rotation3(0, player:getRot().y, 0)).x
    local udAccel = accel.y

    local headRotAccel = (headRotVel - prevHeadRotVel).yx
    prevHeadRotVel = headRotVel

    local accelRelative = vec(
        lrAccel, -udAccel
    ) / 2 + headRotAccel * (2*math.pi / 360)

    leftGooglePrevPos = leftGooglePos
    rightGooglePrevPos = rightGooglePos

    -- disable gravity for mode 2
    local grav = movementMode == 2 and 0 or GRAVITY

    -- drag and gravity
    leftGoogleVel = (leftGoogleVel - vec(0,grav)) * 0.95
    rightGoogleVel = (rightGoogleVel - vec(0,grav)) * 0.9 -- ever so slightly different value so they fall out of sync and look sillier

    if movementMode ~= 1 then
        local leftForce = accelRelative
        local rightForce = accelRelative

        if movementMode == 2 then
            local leftTarget, rightTarget = getGooglyEyePosFromHeadRot()
            rightTarget = rightTarget * vec(1,-1) -- again, sillier

            leftGoogleVel = leftGoogleVel + (leftTarget - leftGooglePos) / 6
            rightGoogleVel = rightGoogleVel + (rightTarget - rightGooglePos) / 6
        end

        leftGoogleVel = leftGoogleVel + leftForce
        rightGoogleVel = rightGoogleVel + rightForce

        leftGooglePos, leftGoogleVel = doCollision(leftGooglePos, leftGoogleVel)
        rightGooglePos, rightGoogleVel = doCollision(rightGooglePos, rightGoogleVel)

        leftGooglePos = leftGooglePos + leftGoogleVel
        rightGooglePos = rightGooglePos + rightGoogleVel

        -- just in case
        leftGooglePos = vec(math.clamp(leftGooglePos.x, -0.5, 0.5), math.clamp(leftGooglePos.y, -0.5, 0.5))
        rightGooglePos = vec(math.clamp(rightGooglePos.x, -0.5, 0.5), math.clamp(rightGooglePos.y, -0.5, 0.5))
    else
        -- get new positions
        leftGooglePos, rightGooglePos = getGooglyEyePosFromHeadRot()

        -- set new velocities in case the mode gets switched
        leftGoogleVel = leftGooglePos - leftGooglePrevPos
        rightGoogleVel = rightGooglePos - rightGooglePrevPos
    end

    prevHeadRot = headRot
end

function events.RENDER(delta)
    models.model.root.torso.body.topbody.head.upperhead.googly.leftgoogle:pos(
        math.lerp(leftGooglePrevPos, leftGooglePos, delta).xy_
    )

    models.model.root.torso.body.topbody.head.upperhead.googly.rightgoogle:pos(
        math.lerp(rightGooglePrevPos, rightGooglePos, delta).xy_
    )
end

--========== ACTION WHEEL SETUP

local mainPage = action_wheel:newPage()
action_wheel:setPage(mainPage)

--========== MAIN WHEEL

-- king of the losers

models.model.root.torso.body.topbody.head.upperhead.kingOTL:setVisible(false)
function pings.kotl(state)
    if state then
        models.model.root.torso.body.topbody.head.upperhead.kingOTL:setVisible(true)
    else
        models.model.root.torso.body.topbody.head.upperhead.kingOTL:setVisible(false)
    end
end
mainPage:newAction()
    :title("King Of The Losers")
    :hoverColor(1,0,0.3)
    :item("minecraft:golden_helmet")
    :toggleItem("minecraft:barrier")
    :onToggle(pings.kotl)


--#region SELF DESTRUCT

models.model.head_destroyed:setVisible(false)
local selfDest = false;
function pings.destruct(state)
    selfDest = state
    animations.model.destruct:setPlaying(state)
    models.model.head_destroyed:setVisible(state)
end

mainPage:newAction()
    :title("Self Destruct")
    :toggleTitle("Reconstruct")
    :hoverColor(1, 0, 0.3)
    :item("minecraft:tnt")
    :toggleItem("minecraft:white_bed")
    :onToggle(pings.destruct);


local selfDestParts = {
    models.model.root.legs,
    models.model.root.torso.body.botbody,
    models.model.root.torso.body.topbody.chest,
    models.model.root.torso.body.topbody.head.throat,
    models.model.root.torso.body.topbody.head.upperhead.mound,
    models.model.root.torso.body.topbody.arms,
}

for _, v in pairs(selfDestParts) do
    v:setSecondaryTexture("CUSTOM", textures["model.destruct"]):setSecondaryRenderType("NONE")
end



local _selfDest = false;
local selfDestAnim = animations.model.destruct;
function events.tick()
    if _selfDest ~= selfDest then
        _selfDest = selfDest;

        for _, v in pairs(selfDestParts) do
            v:setSecondaryTexture("CUSTOM", textures["model.destruct"]):setSecondaryRenderType(
                selfDest and "EMISSIVE" or "NONE")

            if not selfDest then
                v:setSecondaryColor(1)
            end
        end
    end

    if selfDest then
        local animtime = selfDestAnim:getTime()
        local cvalue = math.max((animtime - 0.2) * (animtime - 0.8), 0);
        models.model.root.legs:setSecondaryColor(cvalue)
        models.model.root.torso.body.botbody:setSecondaryColor(cvalue)
        models.model.root.torso.body.topbody.chest:setSecondaryColor(cvalue)
        models.model.root.torso.body.topbody.head.throat:setSecondaryColor(cvalue)
        models.model.root.torso.body.topbody.head.upperhead.mound:setSecondaryColor(cvalue)
        models.model.root.torso.body.topbody.arms:setSecondaryColor(cvalue)
    end
end

--#endregion

-- googly eye physics options

function pings.changeMode()
    movementMode = (movementMode + 1) % 3
    config:save("Mode", movementMode)
end

local googlyMovementTbl = {
    {
        title = "Eye Physics: physics only",
        color = vectors.hexToRGB("FF2222")
    },
    {
        title = "Eye Physics: normal eyes",
        color = vectors.hexToRGB("22FF22")
    },
    {
        title = "Eye Physics: combo",
        color = vectors.hexToRGB("2222FF")
    }
}

local googlyMovementAction = mainPage:newAction()
    :title("Change Eye Mode")
    :item("minecraft:ender_eye")
    :onToggle(pings.changeMode)

function events.tick()
    googlyMovementAction
        :title(googlyMovementTbl[movementMode+1].title)
        :color(googlyMovementTbl[movementMode+1].color)
end

--========== SKIN WHEEL


local skinTbl = {
    { title = "Skin: Grey",                   clr = "#6a7c82" },
    { title = "Skin: Dark Grey",              clr = "#5b5b5b" },
    { title = "Skin: Peach",                  clr = "#ff8484" },
    { title = "Skin: Red",                    clr = "#ff1e1e" },
    { title = "Skin: Maroon",                 clr = "#a44341" },
    { title = "Skin: Dark Brown",             clr = "#5a2f2e" },
    { title = "Skin: Cherry",                 clr = "#ff135c" },
    { title = "Skin: Magenta",                clr = "#ff3f8a" },
    { title = "Skin: Neon Pink",              clr = "#ff2daf" },
    { title = "Skin: Mauve",                  clr = "#ff8dd4" },
    { title = "Skin: Light Purple",           clr = "#cda3ff" },
    { title = "Skin: Purple",                 clr = "#a759f5" },
    { title = "Skin: Violet",                 clr = "#9a00a5" },
    { title = "Skin: Black",                  clr = "#503e63" },
    { title = "Skin: Dark Blue",              clr = "#4a4f8e" },
    { title = "Skin: Blue",                   clr = "#3049d6" },
    { title = "Skin: Azure Blue",             clr = "#5673ff" },
    { title = "Skin: Cyan",                   clr = "#01ace0" },
    { title = "Skin: Turquoise",              clr = "#21d6c3" },
    { title = "Skin: Light Blue",             clr = "#69ffe0" },
    { title = "Skin: Pale Green",             clr = "#93ff92" },
    { title = "Skin: Green",                  clr = "#48da69" },
    { title = "Skin: Neon Green",             clr = "#00ff21" },
    { title = "Skin: Jungle Green",           clr = "#86d718" },
    { title = "Skin: Dark Green",             clr = "#79a426" },
    { title = "Skin: Extra Dark Green",       clr = "#5e8b60" },
    { title = "Skin: Extra Extra Dark Green", clr = "#48744a" },
    { title = "Skin: Yellow",                 clr = "#ffe84c" },
    { title = "Skin: Orangeish Yellow",       clr = "#ffd112" },
    { title = "Skin: Dark Yellow",            clr = "#cba800" },
    { title = "Skin: Orange",                 clr = "#ff8100" },
    { title = "Skin: Reddish Orange",         clr = "#ff5b0e" },
    { title = "Skin: Caramel Brown",          clr = "#8f5939" },
    { title = "Skin: Coffee Brown",           clr = "#6e6733" },
    { title = "Skin: Light Brown",            clr = "#bc965e" },
}


local semibotColor = config:load("Skin") or 1;

local function applySkin(int)
    local clr = vectors.hexToRGB(skinTbl[int].clr);

    models.model.firstpersonarm:setColor(clr)
    models.model.Skull:setColor(clr)
    models.model.head_destroyed:setColor(clr)
    models.model.root.legs:setColor(clr)
    models.model.root.torso.body.botbody:setColor(clr)
    models.model.root.torso.body.topbody.chest:setColor(clr)
    models.model.root.torso.body.topbody.head.throat:setColor(clr)
    models.model.root.torso.body.topbody.head.upperhead.mound:setColor(clr)
    models.model.root.torso.body.topbody.arms:setColor(clr)
end

applySkin(semibotColor);

function pings.changeSkin(int)
    semibotColor = int;
    applySkin(semibotColor);
    config:save("Skin", semibotColor)
end



-- skin wheel
if host:isHost() then
    function events.tick()
        if world.getTime() % 200 == 0 then
            pings.changeSkin(semibotColor)
        end
    end
    
    mainPage:newAction()
        :title("Change Skin")
        :item("minecraft:armor_stand")
        :onScroll(function(dir, self)
            dir = dir > 0 and 1 or - 1
            semibotColor = ((semibotColor + dir - 1) % #skinTbl) + 1;
            self:title(skinTbl[semibotColor].title)
        end)
        :onLeftClick(function() pings.changeSkin(semibotColor); end);
end

--#endregion


-- sync toggle configs 
function pings.syncVariables(a, b)
    movementMode = a
    skinColour = b
end
function events.tick()
    if world.getTime() % 200 == 0 then
        pings.syncVariables(movementMode, skinColour)
    end

-- shrink vs crouch
    if animations.model.crouching:isPlaying() then
        animations.model.shrink:stop()
        shrinkToggled = false
    end

-- hp
    local hp = math.ceil(player:getHealth());
    models.model.root.torso.body.topbody.head.hp.hp1:setVisible(hp >= 0);
    models.model.root.torso.body.topbody.head.hp.hp2:setVisible(hp >= 5);
    models.model.root.torso.body.topbody.head.hp.hp3:setVisible(hp >= 10);
    models.model.root.torso.body.topbody.head.hp.hp4:setVisible(hp >= 15);
    models.model.root.torso.body.topbody.head.hp.hp5:setVisible(hp >= 20);
end



local _rot = 0;
function events.render(d)
    if not player:getVehicle() then
        _rot = math.lerp(_rot, vanilla_model.LEFT_LEG:getOriginRot().x / 8, d / 6)
        models.model.root.torso:setRot(0, _rot, _rot / 8)
        models.model.root.legs:setRot(0, -_rot, -_rot / 8)
    end
end
local FOXCamera = require("FOXCamera")

-- Keybind that must be held to scroll

local holdingAlt = false
local altKey = keybinds:newKeybind("Distance scroll keybind"):setKey("key.keyboard.left.alt")
altKey.press = function() holdingAlt = true end
altKey.release = function() holdingAlt = false end

-- Set the target distance by scrolling while holding alt

local target = 4
function events.mouse_scroll(dir)
  -- Check if you're holding alt, are not in a GUI, and are in third person
  if not holdingAlt or renderer:isFirstPerson() or host:getScreen() or action_wheel:isEnabled() then return end
  target = math.clamp(target - (dir * math.max(1, target) / 4), 0, 128) -- Prevent the distance from going below 0 and above 128
  return true -- Prevent the hotbar from scrolling
end

-- Lerp the distance

local old, new = 4, 4
function events.tick()
  old = new
  new = math.lerp(new, target, 0.5)
end

-- Apply the distance

function events.render(delta)
  local lerped = math.lerp(old, new, delta)
  local appliedCamera = FOXCamera.getCamera()
  if not appliedCamera then return end -- If there's no camera applied, don't set the distance
  appliedCamera.distance = lerped
end
-- Create a camera, disabling collisions, and moving the camera up to eye level.

---@type Camera
local orthographicCamera = {
  cameraPart = models,

  doCollisions = false,
  doEyeOffset = true,

  offsetSpace = "LOCAL",
  offsetPos = vec(0, 24, 0)
}

FOXCamera.setCamera(orthographicCamera)

-- Make orthographic projection mode only enabled in third person

local wasThirdPerson
function events.tick()
  local isThirdPerson = not renderer:isFirstPerson()
  if wasThirdPerson == isThirdPerson then return end
  wasThirdPerson = isThirdPerson

  orthographicCamera.distance = isThirdPerson and 100 or 1
  renderer:fov(isThirdPerson and 0.1 or nil)
end