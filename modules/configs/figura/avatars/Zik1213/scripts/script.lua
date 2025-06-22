nameplate.ALL:setText("Зик1213")
--#nameplate.ALL:setColor(208,32,144)
nameplate.Entity:setVisible(true)
vanilla_model.player:setVisible(false)

--entity init event, used for when the avatar entity is loaded for the first time
function events.entity_init()
  --player functions goes here
end

--tick event, called 20 times per second
function events.tick()
  --code goes here
end

--render event, called every time your avatar is rendered
--it have two arguments, "delta" and "context"
--"delta" is the percentage between the last and the next tick (as a decimal value, 0.0 to 1.0)
--"context" is a string that tells from where this render event was called (the paperdoll, gui, player render, first person)
function events.render(delta, context)
  --code goes here
end
-- Init variables
local glintEnabled = false
local avatarVisible = true
local glintAction = nil
local avatarAction = nil

-- Function to toggle GLINT render type
local function toggleGlint()
    glintEnabled = not glintEnabled
    
    if glintEnabled then
        models:setPrimaryRenderType("GLINT")
        glintAction:setTitle("GLINT: ON")
        glintAction:setColor(0, 1, 0) -- Green when enabled
    else
        models:setPrimaryRenderType("NONE")
        glintAction:setTitle("GLINT: OFF")
        glintAction:setColor(1, 0, 0) -- Red when disabled
    end
end

-- Function to toggle avatar visibility
local function toggleAvatar()
    avatarVisible = not avatarVisible
    
    if avatarVisible then
        vanilla_model.PLAYER:setVisible(false)
        models:setVisible(true)
        avatarAction:setTitle("Avatar: ON")
        avatarAction:setColor(0, 0.7, 1) -- Blue when visible
    else
        vanilla_model.PLAYER:setVisible(true)
        models:setVisible(false)
        avatarAction:setTitle("Avatar: OFF")
        avatarAction:setColor(0.5, 0.5, 0.5) -- Gray when hidden
    end
end
local function toggleGlint()
    glintEnabled = not glintEnabled
    
    if glintEnabled then
        models:setPrimaryRenderType("GLINT")
        glintAction:setTitle("GLINT: ON")
        glintAction:setColor(0, 1, 0) -- Green when enabled
    else
        models:setPrimaryRenderType("NONE")
        glintAction:setTitle("GLINT: OFF")
        glintAction:setColor(1, 0, 0) -- Red when disabled
    end
end

-- Create action wheel page
local mainPage = action_wheel:newPage()

-- Initialize GLINT action

    glintAction = mainPage:newAction()
    :title("GLINT: OFF")
    :item("minecraft:glowstone_dust")
    :color(1, 0, 0)  -- Start as red (disabled)
    :hoverColor(0.5, 0.5, 0.5)
    :onToggle(toggleGlint)

-- Initialize Avatar toggle action
avatarAction = mainPage:newAction()
    :title("Avatar: ON")
    :item("minecraft:player_head")
    :color(0, 0.7, 1) -- Blue when visible
    :hoverColor(0.3, 0.9, 1)
    :onToggle(toggleAvatar)

-- Set as default page
action_wheel:setPage(mainPage)