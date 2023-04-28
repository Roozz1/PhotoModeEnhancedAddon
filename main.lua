------------------------------------------------------------------------
    --cuhFramework || An addon creation framework to make SW addon development easier. 
	-- 		Created by cuh4#7366
	--		cuhHub - Stormworks Server Hub: https://discord.gg/zTQxaZjwDr
	--		This framework is open-source: https://github.com/Roozz1/cuhFramework
------------------------------------------------------------------------

--------------
--[[
    cuhHub Cinematography Addon
    Created by cuh4#7366

    An addon that makes cinematics much easier by allowing you to plot a
    path which your character will follow.

    This addon uses the cuhFramework, see above.
]]

--[[
    UI IDs:
        peer_id + 10000 = Animation Info UI
]]
--------------

----------------------------------------------------------------
-- Intellisense
----------------------------------------------------------------
------------- Inventory
---@class inventory
---@field item item

---@class item
---@field ammo number
---@field id integer

------------- Miscellaneous
---@class color
---@field r number
---@field g number
---@field b number

---@class min_max
---@field min number
---@field max number

---@class event
---@field connections table<any, function>
---@field connect function<connection, function>
---@field call function<connection, any>

------------- Map
---@class map
---@field name string
---@field position SWMatrix
---@field size number
---@field needs_zone boolean

------------- Zombie
---@class zombie
---@field value number
---@field creature creature

----------------------------------------------------------------
-- Variables
----------------------------------------------------------------
---@type table<integer, boolean>
recognisedDespawns = {}

---@type table<integer, player>
players_unfiltered = {}

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------
------------- Uncategorised
chatAnnounce = function(message, player)
    cuhFramework.chat.send_message(miscellaneousFunctions.stringBeforeAfter("[", config.info.server_name, "]"), message, player)
end

notificationAnnounce = function(message, player)
    cuhFramework.ui.notifications.custom(miscellaneousFunctions.stringBeforeAfter("[", config.info.server_name, "]"), message, player, 7)
end

---@param min_max_tbl min_max
minMaxRandom = function(min_max_tbl, divide)
    if not min_max_tbl.min or not min_max_tbl.max then
        df.print("minMaxRandom - missing min or max, returned 0 to prevent error")
        return 0
    end

    if min_max_tbl.min > min_max_tbl.max then
        df.print("minMaxRandom - min is over max, returned 0 to prevent error | min: "..min_max_tbl.min.." | max: "..min_max_tbl.max.." | divide: "..tostring(divide))
        return 0
    end

    if min_max_tbl.min == 0 or min_max_tbl.max == 0 then
        df.print("minMaxRandom - min or max is 0, returned 0")
        return 0
    end

    if divide then
        return math.random(min_max_tbl.min, min_max_tbl.max) / 1000
    else
        return math.random(min_max_tbl.min, min_max_tbl.max)
    end
end

---@return player
get_random_player = function()
    return players_unfiltered[math.random(1, #players_unfiltered)]
end

----------------------------------------------------------------
-- Loops
----------------------------------------------------------------
------------- Radiation Cleanup
cuhFramework.utilities.loop.create(config.cleanup.radiation_cleanup_time, function()
    -- Clear radiation
    server.clearRadiation()
end)

------------- Object Cleanup
cuhFramework.utilities.loop.create(config.cleanup.obj_cleanup_time, function()
    cleanupFunctions.clearObjects()
end)

----------------------------------------------------------------
-- Game
----------------------------------------------------------------
------------- Maps
mapFunctions.new("Origin", matrix.translation(-7.4, 9.4, -4774.4), 100, true)
mapFunctions.new("Mines", matrix.translation(-8321.1, 141.2, -26251.3), 100, true)

----------------------------------------------------------------
-- Setup
----------------------------------------------------------------
------------- Reload
for i = 1, 60000 do
    -- Remove UI
    cuhFramework.ui.screen.remove(i)
    cuhFramework.references.removeMapObject(-1, i)

    -- Remove physical stuff
    cuhFramework.vehicles.despawnVehicle(i)
    cuhFramework.objects.despawnObject(i)
end

------------- Debug
debugFunctions.initialize()

------------- Game
gameFunctions.helpers.setWaitingPos(matrix.translation(4020.7, 75.5, -6013.3))
gameFunctions.helpers.setMapSpawnPos(matrix.translation(4047.7, 13.5, -6013.3))

gameFunctions.helpers.setWaitingPosVehicleSpawnOffset(-3, -4, -3)
gameFunctions.helpers.setPlayerSpawnPosOffset(0, 1, 0)
gameFunctions.helpers.setZombieSpawnOffset(0, 0, 2)

gameFunctions.helpers.setMinimumPlayers(2)
gameFunctions.helpers.setGameStartDelay(7)
gameFunctions.game.mainLoop()

gameFunctions.initialize()