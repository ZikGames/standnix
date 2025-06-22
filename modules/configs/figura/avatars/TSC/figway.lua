if not host:isHost() then return end

local options = {
    hover_time = 5,
    menu_open_time = 5,
    gui_scale = 1.5, -- scale of the markers and menus
    slider_length = 20, -- number of characters sliders should use
    icons = {
        default = "◆",
        hover = "◇"
    },
    sounds = {
        scroll = sounds["block.bamboo.break"]:pitch(6):subtitle("Menu scrolled"),
        scroll_end = sounds["block.bamboo.break"]:pitch(20):subtitle("Menu scrolled to end"),
        click = sounds["block.bamboo.break"]:pitch(1):subtitle("Button clicked"),
        new_waypoint = sounds["item.lodestone_compass.lock"]:pitch(1.5):subtitle("Waypoint created"),
        teleport = sounds["entity.illusioner.mirror_move"]:pitch(0.6):subtitle("Teleported to waypoint"),
    },
    world = (client.getServerData().ip or client.getServerData().name):gsub("[^%w._-]", "_") -- unique string for this world, used for saving waypoints.
}

-- Saving
local waypoints = {}
local function saveWaypoints()
    local to_save = {}
    for dimension, dimension_waypoints in pairs(waypoints) do
        to_save[dimension] = {}
        for name, waypoint in pairs(dimension_waypoints) do
            to_save[dimension][name] = { pos = waypoint.pos, colour = waypoint.colour, dimension = waypoint.dimension }
        end
    end
    config:setName("figway-"..options.world)
    config:save("waypoints", to_save)
end

-- Element object
local Element = {
    name = "",
    click = nil,
    scroll = nil,
    part = nil,
    tasks = {
        text = nil,
    },
}
Element.__index = Element

function Element:new(menu, name, click)
    local self = setmetatable({}, Element)
    self.menu = menu
    self.name = name
    self.click = click
    self.tasks = {
        text = self.menu.part:newText("figway_element-" .. self.name):outline(true):shadow(true):light(15,15):pos(vec(6,-#self.menu.elements*8,0):add(self.menu.text_offset),0),
    }
    return self
end

function Element:render(selected, percent_open)
    local style = selected and options.icons.default .. " §2§l" or options.icons.hover .. " §7"
    style = self.locked and "" or style
    if percent_open < 1 then
        local length = #self.name
        local substring = self.name:sub(1, math.floor(length * percent_open))
        self.tasks.text:text(style .. substring)
    else
        self.tasks.text:text(style .. self.name) 
    end
end

function Element:remove()
    self.tasks.text:remove()
    self = nil
end

-- Menu object
local Menu = {
    elements = {},
    selected = 1,
    part = nil,
    text_offset = vec(0,0,0),
    open_time = 0,
}
Menu.__index = Menu

local scroll_registry = {}
local click_registry = {}
local menu_open = false
function Menu:new(part, text_offset)
    menu_open = true
    local self = setmetatable({}, Menu)
    self.part = part
    self.text_offset = text_offset or self.text_offset
    self.elements = {}
    scroll_registry[self] = function(dir) return self:scroll(dir) end
    click_registry[self] = function(state) return self:click(state) end
    return self
end

function Menu:newButton(name, click)
    local element = Element:new(self, name, click)
    self.elements[#self.elements+1] = element
    return element
end

function Menu:newSlider(name, value, min, max, step, callback)
    local element = Element:new(self, name)
    element.value = value
    element.min = min
    element.max = max
    element.step = step
    local function steppedBar()
        local bar = ""
        for i = 1, math.floor((element.value - element.min)/(element.max - element.min) * options.slider_length) do
            bar = bar .. "§a|"
        end
        for i = 1, options.slider_length - math.floor((element.value - element.min)/(element.max - element.min) * options.slider_length) do
            bar = bar .. "§7|"
        end
        return bar
    end
    function element:click()
        self.tasks.text:text(options.icons.default .. " §2§l" .. self.name .. " §7" .. steppedBar())
        return true
    end
    function element:scroll(dir)
        element.value = element.value - dir * element.step
        if element.value < element.min or element.value > element.max then
            element.value = math.clamp(element.value, element.min, element.max)
            options.sounds.scroll_end:pos(player:getPos()):stop():play()
        else
            options.sounds.scroll:pos(player:getPos()):stop():play()
            callback(element.value)
        end
        self.tasks.text:text(options.icons.default .. " §2§l" .. self.name .. " §7" .. steppedBar())
        return true
    end
    function element:render(selected, percent_open)
        local style = selected and options.icons.default .. " §2§l" or options.icons.hover .. " §7"
        style = self.locked and "" or style
        if percent_open < 1 then
            local length = #self.name
            local substring = self.name:sub(1, math.floor(length * percent_open))
            self.tasks.text:text(style .. substring)
            return
        end
        self.tasks.text:text(style .. self.name .. " " .. steppedBar())
    end
    self.elements[#self.elements+1] = element
    return element
end

function Menu:tick()
    self.open_time = math.clamp(self.open_time + 1, 0, options.menu_open_time)
end

function Menu:render(delta)
    for i, element in pairs(self.elements) do
        element:render(i == self.selected, (self.open_time + delta)/options.menu_open_time)
    end
end

function Menu:click(state)
    if state == 1 then
        self.clicking = true 
        options.sounds.click:pos(player:getPos()):stop():play()
        self.elements[self.selected]:click()
        return true
    elseif state == 0 then
        self.clicking = false
        return true
    end
end

function Menu:scroll(dir)
    if self.clicking and self.elements[self.selected].scroll then
        self.elements[self.selected]:scroll(dir)
        return true
    end
    self.selected = self.selected + dir
    local element = self.elements[self.selected]
    if self.selected < 1 or self.selected > #self.elements or not element or element.locked then
        self.selected = self.selected - dir
        options.sounds.scroll_end:pos(player:getPos()):stop():play()
    else
        options.sounds.scroll:pos(player:getPos()):stop():play()
    end
    return true
end

function Menu:clear()
    for _, element in pairs(self.elements) do
        element:remove()
    end
    self.elements = {}
end

function Menu:remove()
    menu_open = false
    for _, element in pairs(self.elements) do
        element:remove()
    end
    scroll_registry[self] = nil
    click_registry[self] = nil
    self = nil
end

function events.MOUSE_SCROLL(dir)
    for _, scroll in pairs(scroll_registry) do
        if scroll(-dir) then
            return true
        end
    end
end

function events.MOUSE_PRESS(_, state)
    for _, click in pairs(click_registry) do
        if click(state) then
            return true
        end
    end
end

-- Waypoint object
local Waypoint = {
    name = "",
    pos = vec(0,0,0),
    colour = "#00ff00",
    hovering = false,
    hover_time = 0,
    distance = 0,
    pinned = false,
}
Waypoint.__index = Waypoint

local world_part = models:newPart("figway_world", "WORLD")
function Waypoint:new(name, pos, dimension)
    local self = setmetatable({}, Waypoint)
    self.name = name
    self.pos = pos
    self.dimension = dimension
    self.part = world_part:newPart("waypoint-" .. name, "WORLD"):pos(vec(0,0,0):add(pos)*16)
    local dimensions = client.getTextDimensions(options.icons.default)
    self.text_offset = vec(-dimensions.x/2, dimensions.y/2, 0)
    self.task = self.part:newText("waypoint-text-" .. name):pos(self.text_offset):outline(true):shadow(true):alignment("RIGHT"):light(15,15)
    return self
end

function Waypoint:load(name, data)
    local waypoint = Waypoint:new(name, data.pos)
    for key, value in pairs(data) do
        waypoint[key] = value
    end
    return waypoint
end

function Waypoint:tick(distance, hovering)
    self.distance = distance
    if hovering and not menu_open then
        self.hovering = true
        self.hover_time = math.clamp(self.hover_time + 1, 0, options.hover_time)
        if self.hover_time == 5 and not self.menu and player:isSneaking() then
            self:setupMenu()
        elseif self.menu and not player:isSneaking() then
            self.menu:remove()
            self.menu = nil
        end
    elseif not player:isSneaking() then
        self.hovering = false
        self.hover_time = self.hover_time - 1
        if self.menu and self.hover_time == 0 then
            self.menu:remove()
            self.menu = nil
        end
    end
    -- if self.hover_time < -100 then -- waiting on a bug with opacity and outlines to be fixed
    --     self.task:opacity(0.4)
    -- else
    --     self.task:opacity(math.clamp(self.hover_time/options.hover_time, 0.8, 1))
    -- end
    if self.menu then
        self.menu:tick()
    end
end

function Waypoint:render(delta, player_rot)
    local text = ""
    local length = #self.name + 1
    if self.hovering then
        text = (self.name.." "):sub(1, math.floor(length * math.clamp((self.hover_time + delta - 1)/(options.hover_time - 1), 0, 1)))
    elseif self.hover_time > 0 then
        text = (self.name.." "):sub(1, math.floor(length * math.clamp((self.hover_time - delta)/(options.hover_time), 0, 1)))
    end
    self.task:text('[{"text":"'..text..'"},{"text":"'..(options.icons[self.hovering and "hover" or "default"])..'", "color":"'..(self.menu and "white" or self.colour)..'"}]')
    self.part:scale(math.lerp(self.part:getScale(), 0.5 * math.max(1, self.distance/6) * (self.hover_time > 1 and 0.6 or 1) * options.gui_scale, 0.1))
    self.part:rot(player_rot.x, -player_rot.y, 0)
    self.part:matrix(self.part:getPositionMatrix() * matrices.mat4() * (1 / (self.distance + 1) * (self.menu and 0.5 or 1)))
    if self.menu then
        self.menu:render(delta)
    end
end

function Waypoint:setupMenu()
    self.menu = self.menu or Menu:new(self.part, self.text_offset)
    if player:getPermissionLevel() >= 2 then
        self.menu:newButton("Teleport", function() 
            host:sendChatCommand("/tp " .. math.floor(self.pos.x) .. " " .. math.floor(self.pos.y) .. " " .. math.floor(self.pos.z)) 
            options.sounds.teleport:pos(player:getPos()):attenuation(9999):stop():play()
        end)
    end
    self.menu:newButton("Copy pos", function() 
        host:setClipboard(math.floor(self.pos.x) .. " " .. math.floor(self.pos.y) .. " " .. math.floor(self.pos.z)) 
    end)
    self.menu:newButton("Set colour", function() 
        self.menu:clear()
        self.menu.selected = 1
        self.menu:newButton("Back", function()
            self.menu:clear()
            self:setupMenu()
        end)
        local display = nil
        local colour = vectors.rgbToHSV(vectors.hexToRGB(self.colour))
        local function updateColour()
            self.colour = "#" .. vectors.rgbToHex(vectors.hsvToRGB(colour.x, colour.y, colour.z))
            display.name = '{"text":"'..options.icons.default..'","color":"'..self.colour..'"}'
            saveWaypoints()
        end
        self.menu:newSlider("H", colour.x, 0, 1, 0.05, function(value)
            colour.x = value
            updateColour()
        end)
        self.menu:newSlider("S", colour.y, 0, 1, 0.05, function(value)
            colour.y = value
            updateColour()
        end)
        self.menu:newSlider("V", colour.z, 0, 1, 0.05, function(value)
            colour.z = value
            updateColour()
        end)
        display = self.menu:newButton()
        display.tasks.text:pos(23,-5,0):scale(3)
        display.locked = true
        updateColour()
    end)
    self.menu:newButton("Share", function() 
        self:share() 
    end)
    self.menu:newButton("Remove", function() 
        self:remove()
    end)
end

function Waypoint:share()
    local encoded = toJson({
        dimension = world.getDimension(),
        name = self.name,
        colour = self.colour,
        pos = { self.pos:unpack() },
    })
    host:sendChatMessage("figway-waypoint"..encoded)
end

function Waypoint:remove()
    self.task:remove()
    if self.menu then
        self.menu:remove()
    end
    world_part:removeChild(self.part)
    waypoints[self.dimension][self.name] = nil
    self = nil
    saveWaypoints()
end

-- Loading
local function loadWaypoints()
    config:setName("figway-"..options.world)
    local to_load = config:load("waypoints")
    if to_load then
        for dimension, dimension_waypoints in pairs(to_load) do
            waypoints[dimension] = {}
            for name, data in pairs(dimension_waypoints) do
                waypoints[dimension][name] = Waypoint:load(name, data)
            end
        end
    end
end

-- Commands
local function isOperator()
    if player:getPermissionLevel() >= 2 then
        return true
    else
        logJson("§2[Figway] §cYou must be an operator to use this command.\n")
    end
end

local subcommands = {}
function subcommands.add(name)
    if name then
        local pos = player:getPos():floor():add(0.5,0.5,0.5)
        local dimension = world.getDimension()
        local waypoint = Waypoint:new(name, pos, dimension)
        waypoints[dimension] = waypoints[dimension] or {}
        waypoints[dimension][name] = waypoint
        options.sounds.new_waypoint:pos(player:getPos()):stop():play()
        saveWaypoints()
        logJson("§2[Figway] §7Added waypoint §a§l" .. name .. " §7at §a§l" .. math.floor(pos.x) .. "§7, §a§l" .. math.floor(pos.y) .. "§7, §a§l" .. math.floor(pos.z) .. "§7 in §a§l" .. dimension .. "§7.\n")
    else
        logJson("§2[Figway] §cUsage: §7/figway add <name>\n")
    end
end

function subcommands.remove(name)
    if name then
        local dimension = world.getDimension()
        if waypoints[dimension] and waypoints[dimension][name] then
            waypoints[dimension][name]:remove()
            waypoints[dimension][name] = nil
            saveWaypoints()
            logJson("§2[Figway] §7Removed waypoint §a§l" .. name .. "§7.\n")
        else
            logJson("§2[Figway] §7Waypoint §a§l" .. name .. " §7does not exist.\n")
        end
    else
        logJson("§2[Figway] §cUsage: §7/figway remove <name>\n")
    end
end

function subcommands.list(dimension)
    dimension = dimension or world.getDimension()
    if waypoints[dimension] then
        logJson("§2[Figway] §7Waypoints in §a§l" .. dimension .. "§7:\n")
        for name, waypoint in pairs(waypoints[dimension]) do
            logJson("§2[Figway] §7- §a§l" .. name .. "§7 at §a§l" .. math.floor(waypoint.pos.x) .. "§7, §a§l" .. math.floor(waypoint.pos.y) .. "§7, §a§l" .. math.floor(waypoint.pos.z) .. "§7.\n")
        end
    else
        logJson("§2[Figway] §7No waypoints in §a§l" .. dimension .. "§7.\n")
    end
end

function subcommands.tp(name)
    if not isOperator() then return end
    if name then
        local dimension = world.getDimension()
        if waypoints[dimension] and waypoints[dimension][name] then
            host:sendChatCommand("/tp " .. math.floor(waypoints[dimension][name].pos.x) .. " " .. math.floor(waypoints[dimension][name].pos.y) .. " " .. math.floor(waypoints[dimension][name].pos.z))
            logJson("§2[Figway] §7Teleported to §a§l" .. name .. "§7.\n")
        else
            logJson("§2[Figway] §7Waypoint §a§l" .. name .. " §7does not exist.\n")
        end
    else
        logJson("§2[Figway] §cUsage: §7/figway tp <name>\n")
    end
end

function subcommands.import(name)
    if name then
        -- world id
        config:setName("figway-"..name)
        local new_waypoints = config:load("waypoints")
        if new_waypoints then
            for dimension, dimension_waypoints in pairs(new_waypoints) do
                waypoints[dimension] = waypoints[dimension] or {}
                for name, data in pairs(dimension_waypoints) do
                    if waypoints[dimension][name] then
                        waypoints[dimension][name]:remove()
                    end
                    waypoints[dimension][name] = Waypoint:load(name, data)
                end
            end
            saveWaypoints()
            logJson("§2[Figway] §7Imported waypoints from §a§l" .. name .. "§7.\n")
        else
            logJson("§2[Figway] §7No waypoints found for §a§l" .. name .. "§7.\n")
        end
    else
        logJson("§2[Figway] §cUsage: §7/figway import <server ip>\n")
    end
end

function subcommands.share(name)
    if name then
        local dimension = world.getDimension()
        if waypoints[dimension] and waypoints[dimension][name] then
            waypoints[dimension][name]:share()
        else
            logJson("§2[Figway] §7Waypoint §a§l" .. name .. " §7does not exist.\n")
        end
    else
        logJson("§2[Figway] §cUsage: §7/figway share <name>\n")
    end
end

function events.CHAT_RECEIVE_MESSAGE(message, json)
    if message:find("figway%-waypoint") then
        local success, data = pcall(parseJson, message:match("figway%-waypoint(%b{})"))
        if success and data.dimension and data.name and data.pos then
            data.pos = vec(table.unpack(data.pos))
            logJson("§2[Figway] §7Received waypoint §a§l" .. data.name .. "§7.\n")
            if waypoints[data.dimension] and waypoints[data.dimension][data.name] then
                waypoints[data.dimension][data.name]:remove()
            end
            local waypoint = Waypoint:load(data.name, data)
            waypoints[data.dimension] = waypoints[data.dimension] or {}
            waypoints[data.dimension][data.name] = waypoint
            saveWaypoints()
            return json, vec(0,0.2,0)
        else
            logJson("§2[Figway] §7Received invalid waypoint.\n")
            return json, vec(0.2,0,0)
        end
    end
end

function events.CHAT_SEND_MESSAGE(message)
    if not message then return end
    if message:sub(1,7) == "/figway" then
        local subcommand = subcommands[message:match("^/figway (%w+)")]
        if subcommand then
            subcommand(message:match("^/figway %w+ (.+)"))
        else
            local keys = {}
            for key, _ in pairs(subcommands) do
                keys[#keys+1] = key
            end
            logJson("§2[Figway] §7Unknown command. Valid commands are: §a§l" .. table.concat(keys, "§7, §a§l") .. "§7.\n")
        end
    else
        return message
    end
end

-- Init
function events.ENTITY_INIT()
    local last_dimension = world.getDimension()
    function events.WORLD_TICK()
        local current_dimension = world.getDimension()
        if current_dimension ~= last_dimension then
            last_dimension = current_dimension
            for _, dimension in pairs(waypoints) do
                for _, waypoint in pairs(dimension) do
                    waypoint.part:visible(false)
                end
            end
            for _, waypoint in pairs(waypoints[current_dimension] or {}) do
                waypoint.part:visible(true)
            end
        end
        for _, waypoint in pairs(waypoints[current_dimension] or {}) do
            local camera = vectors.worldToScreenSpace(waypoint.pos)
            local distance = camera[4]
            local scale = 1 / (distance + 1)
            local hover_area = math.max(0.15, 0.05*scale)
            local hovering = math.abs(camera.x) <= hover_area/2 and math.abs(camera.y) <= hover_area/2
            waypoint:tick(distance, hovering)
        end
    end

    function events.WORLD_RENDER(delta)
        local player_rot = player:getRot(delta)
        for _, waypoint in pairs(waypoints[world.getDimension()] or {}) do
            waypoint:render(delta, player_rot)
        end
    end

    loadWaypoints()
end