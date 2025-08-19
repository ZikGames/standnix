-- Цветовое смещение
local hue = 0
function events.tick()
    -- Инкрементируем угол (в радианах)
    hue = (hue + 0.05) % (2 * math.pi)
    -- Интерполируем цвет по синусоиде
    local t = (1 + math.cos(hue)) / 2  -- от 0 до 1
    local r = math.floor(255 * t + 128 * (1 - t))
    local g = 0
    local b = math.floor(255 * t + 128 * (1 - t))
    -- Формируем JSON-строку для цвета
    local colorCode = string.format("#%02X%02X%02X", r, g, b)
    -- Устанавливаем надпись над головой
    nameplate.ENTITY:setText('{"text":"Зик1213","color":"'..colorCode..'"}')
end
-- Выполнить один раз при инициализации
function events.entity_init()
    nameplate.LIST:setText('{"text":"Зик1213","color":"#FF00FF"}')
end
