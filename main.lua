------------------------------------------------------------------------
    --cuhFramework || An addon creation framework to make SW addon development easier. 
	-- 		Created by cuh4#7366
	--		cuhHub - Stormworks Server Hub: https://discord.gg/zTQxaZjwDr
	--		This framework is open-source: https://github.com/Roozz1/cuhFramework
------------------------------------------------------------------------

--------------
--[[
    cuhHub Photo Mode Enhanced Addon
    Created by cuh4#7366

    An addon that makes cinematics much easier by allowing you to plot a
    path which your character will follow. Great to use in combination with
    the game's built-in photo mode.

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
------------- Main
---@class ca_animation
---@field properties ca_animationProperties
---@field events ca_animationEvents
---
---@field play function<ca_animation>
---@field stop function<ca_animation>
---@field remove function<ca_animation>
---@field createPlot function<ca_animation, SWMatrix, number>
---@field removeRecentPlot function<ca_animation>

---@class ca_animationEvents
---@field started event
---@field stopped event
---@field finished event

---@class ca_animationProperties
---@field plots table<integer, ca_plot>
---@field currentPlotPoint integer
---@field isInProgress boolean
---@field player player
---@field animation animation|nil

---@class ca_plot
---@field pos SWMatrix
---@field speed number

------------- Miscellaneous
---@class event
---@field connections table<any, function>
---@field connect function<connection, function>
---@field call function<connection, any>

----------------------------------------------------------------
-- Variables
----------------------------------------------------------------
---@type table<integer, player>
players_unfiltered = {}

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------
------------- Uncategorised
chatAnnounce = function(message, player)
    cuhFramework.chat.send_message(miscellaneousFunctions.stringBeforeAfter("[", config.info.addon_name, "]"), message, player)
end

notificationAnnounce = function(message, player)
    cuhFramework.ui.notifications.custom(miscellaneousFunctions.stringBeforeAfter("[", config.info.addon_name, "]"), message, player, 7)
end

---@return player
get_random_player = function()
    return players_unfiltered[math.random(1, #players_unfiltered)]
end

----------------------------------------------------------------
-- Game
----------------------------------------------------------------
------------- 

----------------------------------------------------------------
-- Setup
----------------------------------------------------------------
------------- Reload
for i = 1, 60000 do
    -- Remove UI
    cuhFramework.ui.screen.remove(i)

    -- Remove physical stuff
    cuhFramework.objects.despawnObject(i)
end