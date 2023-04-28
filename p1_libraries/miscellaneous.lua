---------------------------------------
------------- Miscellaneous
---------------------------------------

------------- Functions
miscellaneousFunctions = {
    stringBeforeAfter = function(before, string, after)
        return before..string..after
    end,

    aOrAn = function(str)
        local first_character = str:sub(1, 1):lower()

        if ("aeiou"):find(first_character:lower()) then
            return "an "
        end

        return "a "
    end,

    ---@param player player
    unnamedClientOrServerOrDisconnecting = function(player)
        return (player.properties.peer_id == 0 and config.isDedicatedServer or player.properties.steam_id == 0) or player.properties.disconnecting
    end,

    ---@param pos SWMatrix
    matrixFormatted = function(pos)
        return cuhFramework.utilities.number.round(pos[13], 1)..", "..cuhFramework.utilities.number.round(pos[14], 1)..", "..cuhFramework.utilities.number.round(pos[15], 1)
    end,

    getPlayerCount = function()
        local count = 0

        for _, v in pairs(cuhFramework.players.connectedPlayers) do
            if not miscellaneousFunctions.unnamedClientOrServerOrDisconnecting(v) then
                count = count + 1
            end
        end

        return count
    end,

    pluralOrSingular = function(input)
        if tonumber(input) == 1 then
            return ""
        else
            return "s"
        end
    end
}