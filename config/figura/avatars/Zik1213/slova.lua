local slova = {
    "А роза упала на лапу Азора",
    "Аргентина манит негра",
    "Я иду с мечом судия",
    "Улыбок тебе дед Макар",
    "Коту скоро сорок суток",
    "Огонь лоб больно го",
    "Нажал кабан на баклажан",
    "Искать такси",
    "Лёша на полке клопа нашёл",
    "А луна канула",
    "Сегодня на улице светит солнце",
    "Я изучаю программирование на языке Луа",
    "Кошка спит на мягком диване",
    "Завтра будет новый интересный день",
    "Кофе помогает проснуться по утрам",
    "Мы пошли гулять в городской парк",
    "Книга лежит на рабочем столе",
    "В небе медленно плывут облака",
    "Мой друг прислал мне сообщение",
    "В лесу поют красивые птицы"
}
local to_lower = {
    ["А"]="а", ["Б"]="б", ["В"]="в", ["Г"]="г", ["Д"]="д", ["Е"]="е", ["Ё"]="е", ["ё"]="е",
    ["Ж"]="ж", ["З"]="з", ["И"]="и", ["Й"]="й", ["К"]="к", ["Л"]="л", ["М"]="м", ["Н"]="н",
    ["О"]="о", ["П"]="п", ["Р"]="р", ["С"]="с", ["Т"]="т", ["У"]="у", ["Ф"]="ф", ["Х"]="х",
    ["Ц"]="ц", ["Ч"]="ч", ["Ш"]="ш", ["Щ"]="щ", ["Ъ"]="ъ", ["Ы"]="ы", ["Ь"]="ь", ["Э"]="э",
    ["Ю"]="ю", ["Я"]="я"
}

local valid_chars = {
    ["а"]=true, ["б"]=true, ["в"]=true, ["г"]=true, ["д"]=true, ["е"]=true,
    ["ж"]=true, ["з"]=true, ["и"]=true, ["й"]=true, ["к"]=true, ["л"]=true,
    ["м"]=true, ["н"]=true, ["о"]=true, ["п"]=true, ["р"]=true, ["с"]=true,
    ["т"]=true, ["у"]=true, ["ф"]=true, ["х"]=true, ["ц"]=true, ["ч"]=true,
    ["ш"]=true, ["щ"]=true, ["ъ"]=true, ["ы"]=true, ["ь"]=true, ["э"]=true,
    ["ю"]=true, ["я"]=true
}

local function isPalindrome(text)
    local chars = {}

    for char in text:gmatch("[%z\1-\127\194-\244][\128-\191]*") do
        local lower_char = to_lower[char] or char

        if valid_chars[lower_char] then
            table.insert(chars, lower_char)
        end
    end

    local len = #chars
    if len == 0 then return false end

    for i = 1, math.floor(len / 2) do
        if chars[i] ~= chars[len - i + 1] then
            return false
        end
    end

    return true
end

local palindromes_list = {}
local normal_list = {}


for _, sentence in ipairs(slova) do
    if isPalindrome(sentence) then
        table.insert(palindromes_list, sentence)
    else
        table.insert(normal_list, sentence)
    end
end
print("=== ПАЛИНДРОМЫ (" .. #palindromes_list .. " шт.) ===")
for i, sentence in ipairs(palindromes_list) do
    print(i .. ". " .. sentence)
    end

    print(" ")


    print("=== ПРОСТЫЕ ПРЕДЛОЖЕНИЯ (" .. #normal_list .. " шт.) ===")
    for i, sentence in ipairs(normal_list) do
        print(i .. ". " .. sentence)
        end
