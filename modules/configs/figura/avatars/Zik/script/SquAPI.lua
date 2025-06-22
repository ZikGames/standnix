--[[--------------------------------------------------------------------------------------
███████╗ ██████╗ ██╗   ██╗██╗███████╗██╗  ██╗██╗   ██╗     █████╗ ██████╗ ██╗
██╔════╝██╔═══██╗██║   ██║██║██╔════╝██║  ██║╚██╗ ██╔╝    ██╔══██╗██╔══██╗██║
███████╗██║   ██║██║   ██║██║███████╗███████║ ╚████╔╝     ███████║██████╔╝██║
╚════██║██║▄▄ ██║██║   ██║██║╚════██║██╔══██║  ╚██╔╝      ██╔══██║██╔═══╝ ██║
███████║╚██████╔╝╚██████╔╝██║███████║██║  ██║   ██║       ██║  ██║██║     ██║
╚══════╝ ╚══▀▀═╝  ╚═════╝ ╚═╝╚══════╝╚═╝  ╚═╝   ╚═╝       ╚═╝  ╚═╝╚═╝     ╚═╝
--]] --------------------------------------------------------------------------------------ANSI Shadow

-- Author: Squishy
-- Discord tag: @mrsirsquishy

-- Version: 1.1.0
-- Legal: ARR

-- Special Thanks to
-- @jimmyhelp for errors and just generally helping me get things working.
-- FOX (@bitslayn) for overhauling annotations and clarity, and for fleshing out some functionality(fr big thanks)

-- IMPORTANT FOR NEW USERS!!! READ THIS!!!

-- Thank you for using SquAPI! Unless you're experienced and wish to actually modify the functionality
-- of this script, I wouldn't recommend snooping around.
-- Don't know exactly what you're doing? this site contains a guide on how to use!(also linked on github):
-- https://mrsirsquishy.notion.site/Squishy-API-Guide-3e72692e93a248b5bd88353c96d8e6c5

-- this SquAPI file does have some mini-documentation on paramaters if you need like a quick reference, but
-- do not modify, and do not copy-paste code from this file unless you are an avid scripter who knows what they are doing.

-- Don't be afraid to ask me for help, just make sure to provide as much info as possible so I or someone can help you faster.



---@class SquAPI
local squapi = {}

-- SQUAPI CONTROL VARIABLES AND CONFIG ----------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-- these variables can be changed to control certain features of squapi.


--when true it will automatically tick and update all the functions, when false it won't do that.  
--if false, you can run each objects respective tick/update functions on your own - better control.
squapi.autoFunctionUpdates = true



-- LOAD MODULES -----------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------

local module_names = {
  "tail",
  "ear",
  "crouch",
  "bewb",
  "randimation",
  "eye",
  "hoverpoint",
  "leg",
  "arm",
  "smoothhead",
  "bouncewalk",
  "taur",
  "fphand",
  "animatetexture"
}

local found_module = false
for _, name in ipairs(module_names) do
  --- Search for `./SquAPI_*.lua` first, then attempt `./SquAPI/SquAPI_*.lua`
  local success, module = xpcall(require, function(e)
    if type(e) ~= "string" or not e:match("^Tried to require nonexistent script \".*\"!$") then
      error("Error in SquAPI module '" .. name .. "': " .. tostring(e), 3)
    end
  end, "./SquAPI_" .. name)
  if not success then success, module = pcall(require, "./SquAPI/SquAPI_" .. name) end

  if success then
    found_module = true
    for key, value in pairs(module) do
      if key == "$startEvents" then
        if squapi.autoFunctionUpdates then value() end
      else
        squapi[key] = value
      end
    end
  end
end

if not found_module then
  local path = "/" .. (...):gsub("%.", "/")
  if path ~= "/" then path = path .. "/" end

  error(
    ("Could not find any SquAPI modules in paths\n  [%s] or [%s]\nDid you forgot to download the module files?")
      :format(path, path .. "SquAPI/")
  )
end

return squapi
