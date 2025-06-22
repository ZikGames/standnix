---@diagnostic disable: redefined-local
-- CostumesAPI v1.2.0 by Vercte

local function tableContains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end


local CostumesAPI = {}

CostumesAPI.Suits = {}
CostumesAPI.Suit = {}
function CostumesAPI.Suit:new(name)
    local self = setmetatable({}, CostumesAPI.Suit)

    assert(name, "Your suit needs a name in the :new()")
    self.name = name
    self.parts = {}

    self.costumes = {}
    self.currentCostume = nil
    self.defaultCostume = nil
    self.changeFunction = nil

    function self:addCostume(costume)
        costume.suit = self
        table.insert(self.costumes, costume)
        return self
    end

    function self:enableCostume(costume, isSync)
        if costume == self.currentCostume then return self end
        if self.currentCostume then
            self.currentCostume:disable()
        end

        if self.changeFunction and player:isLoaded() then
            self.changeFunction(isSync)
        end

        costume:enable()
        self.currentCostume = costume

        CostumesAPI.Persistence:saveToWorn()
        return self
    end

    function self:enableDefaultCostume()
        assert(self.defaultCostume, "Suit "..name.." has no default costume")
        return self:enableCostume(self.defaultCostume)
    end

    function self:onChange(f)
        self.changeFunction = f
        return self
    end

    self.basicUV = vec(0, 0)
    function self:defaultUV(uv, y)
        if y then uv = vec(uv, y) end
        self.basicUV = uv
        return self
    end

    -- Specify any number of parts, as individual arguments, or as tables in the args
    function self:addParts(...)
        for _, part in ipairs({...}) do
            assert(part, "Provided a part that doesn't exist. Check your indexing?")
            if type(part) == "table" then
                for _, p in ipairs(part) do
                    assert(p, "Provided a part that doesn't exist. Check your indexing?")
                    table.insert(self.parts, p)
                end
            else
                table.insert(self.parts, part)
            end
        end

        return self
    end

    function self:applyTexture(costume, texture)
        for _, part in ipairs(self.parts) do
            local textureType = "Custom"
            if type(texture) == "string" then textureType = "Resource" end
            if not tableContains(costume.excludedParts, part) then 
                part:setPrimaryTexture(textureType, texture)
            end
        end
    end

    function self:applyUV(costume, uv, y)
        if y then uv = vec(uv, y) end
        local relativeUV = uv - self.basicUV
        for _, part in ipairs(self.parts) do
            if not tableContains(costume.excludedParts, part) then 
                part:setUVPixels(relativeUV)
            end
        end
    end

    function self:generateActionWheelPage(back)
        local page = action_wheel:newPage()

        if back then 
            page:newAction()
                :setOnLeftClick(function() action_wheel:setPage(back) end)
                :setColor(1,140/255,0):setTitle("Go Back")
                :setItem("minecraft:dark_oak_door")
        end

        page:newAction()
            :setOnLeftClick(function() pings.changeCostume(self.id, self.defaultCostume.id) end)
            :setColor(1,0,0):setTitle("Equip Default")
            :setItem("minecraft:barrier")

        for _, costume in ipairs(self.costumes) do
            page:newAction()
                :setOnLeftClick(function() pings.changeCostume(self.id, costume.id) end)
                :setTitle(costume.name)
                :setItem(costume.icon or "minecraft:leather_chestplate")
        end

        return page
    end

    table.insert(CostumesAPI.Suits, self)
    self.id = #CostumesAPI.Suits
    return self
end

CostumesAPI.Costume = {}
function CostumesAPI.Costume:new(name)
    local self = setmetatable({}, CostumesAPI.Costume)

    assert(name, "Your costume needs a name in the :new()")
    self.name = name
    self.id = 0

    self.suit = nil
    self.excludedParts = {}
    function self:inSuit(suit) 
        suit:addCostume(self) 
        self.id = #suit.costumes
        return self
    end

    function self:default()
        self.suit.defaultCostume = self
        self:enable()
        return self
    end

    function self:exclude(...)
        for _, part in ipairs({...}) do
            assert(part, "Provided a part that doesn't exist. Check your indexing?")
            if type(part) == "table" then
                for _, p in ipairs(part) do
                    assert(p, "Provided a part that doesn't exist. Check your indexing?")
                    table.insert(self.excludedParts, p)
                end
            else
                table.insert(self.excludedParts, part)
            end
        end

        return self
    end

    self.uv = vec(0,0)
    function self:setUV(uv, y)
        if y then uv = vec(uv, y) end
        self.uv = uv
        return self
    end

    self.isTexture = nil
    self.texture = nil
    function self:setTexture(texture)
        self.isTexture = true
        self.texture = texture
        return self
    end

    self.icon = nil
    function self:setIcon(to)
        self.icon = to
        return self
    end

    self.props = {}
    -- Specify any number of props (ModelPart), as individual arguments, or as tables in the args
    function self:addProps(...)
        for _, part in ipairs({...}) do
            assert(part, "Provided a part that doesn't exist. Check your indexing?")
            if type(part) == "table" then
                for _, p in ipairs(part) do
                    assert(p, "Provided a part that doesn't exist. Check your indexing?")
                    table.insert(self.props, p)
                end
            else
                table.insert(self.props, part)
            end
        end

        return self
    end

    function self:enable() return self:set(true) end
    function self:disable() return self:set(false) end

    function self:set(to)
        if to then 
            self.suit:applyUV(self, self.uv) 
            if self.isTexture then
                self.suit:applyTexture(self, self.texture)
            end
        end
        for _, prop in ipairs(self.props) do
            prop:setVisible(to)
        end
        return self
    end

    return self
end

function pings.changeCostume(suitID, costumeID)
    for _, suit in ipairs(CostumesAPI.Suits) do
        if suit.id == suitID then
            for _, costume in ipairs(suit.costumes) do
                if costume.id == costumeID then
                    suit:enableCostume(costume)
                    return
                end
            end
        end
    end
end

function pings.sendEquippedCostumes(...)
    local ids = {...}
    for i, suit in ipairs(CostumesAPI.Suits) do
        for _, costume in ipairs(suit.costumes) do
            if costume.id == ids[i] then
                suit:enableCostume(costume, true)
            end
        end
    end
end

CostumesAPI.Persistence = {}

CostumesAPI.Persistence.SyncOnePing = pings.changeCostume

function CostumesAPI.Persistence:saveToWorn()
    local saveTable = {}

    for _, suit in ipairs(CostumesAPI.Suits) do
        local currentCostume = suit.currentCostume or suit.defaultCostume
        table.insert(saveTable, {suit.name, currentCostume.name})
    end

    config:save("CostumesAPI.Persistence", saveTable)
end

function CostumesAPI.Persistence:loadWorn()
    local saveTable = config:load("CostumesAPI.Persistence")
    if not saveTable then return end

    for _, table in ipairs(saveTable) do
        for _, suit in ipairs(CostumesAPI.Suits) do
            if suit.name == table[1] then
                for _, costume in ipairs(suit.costumes) do
                    if costume.name == table[2] then
                        suit:enableCostume(costume)
                    end
                end
            end
        end
    end

    events.TICK:register(function()
        if host:isHost() and world.getTime() % 200 == 0 then
            local tableToSend = {}
            for _, suit in ipairs(CostumesAPI.Suits) do
                table.insert(tableToSend, suit.currentCostume.id)
            end
            pings.sendEquippedCostumes(table.unpack(tableToSend))
        end
    end)
end

return CostumesAPI