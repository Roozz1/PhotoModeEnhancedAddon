-- Functions
miscellaneousFunctions = {
    stringIfNil = function(var, str)
        -- df.setRecentlyCalled("miscellaneous.stringIfNil", var, str) -- ERR: lag

        if not var then
            return str
        end
    end,

    stringBeforeAfter = function(before, string, after)
        -- df.setRecentlyCalled("miscellaneous.stringBeforeAfter", before, string, after) -- ERR: lag
        return before..string..after
    end,

    aOrAn = function(str)
        df.setRecentlyCalled("miscellaneous.aOrAn", str)
        local first_character = str:sub(1, 1):lower()

        if ("aeiou"):find(first_character:lower()) then
            return "an "
        end

        return "a "
    end,

    ---@param player player
    unnamedClientOrServerOrDisconnecting = function(player)
        -- df.setRecentlyCalled("miscellaneous.unnamedClientOrServerOrDisconnecting", player) -- ERR: called a lot, may lag
        return (player.properties.peer_id == 0 and config.isDedicatedServer or player.properties.steam_id == 0) or player.properties.disconnecting
    end,

    ---@param pos SWMatrix
    matrixFormatted = function(pos)
        df.setRecentlyCalled("miscellaneous.matrixFormatted", pos)
        return cuhFramework.utilities.number.round(pos[13], 1)..", "..cuhFramework.utilities.number.round(pos[14], 1)..", "..cuhFramework.utilities.number.round(pos[15], 1)
    end,

    addCommas = function(number)
        -- df.setRecentlyCalled("miscellaneous.addCommas", number) -- ERR: lag

        local formatted = tostring(number)
        local k = 3

        while true do
            formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2', k)

            if k == 0 then
                break
            end
        end

        return formatted
    end,

    getPlayerCount = function()
        local count = 0

        for _, v in pairs(cuhFramework.players.connectedPlayers) do
            if not miscellaneousFunctions.unnamedClientOrServerOrDisconnecting(v) and playerStatesFunctions.hasState(v, "ready") then
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

matrix.add = function(matrix1, matrix2)
    local new = matrix.translation(0, 0, 0)

    for i, v in pairs(new) do
        if matrix1[i] and matrix2[i] then
            new[i] = matrix1[i] + matrix2[i]
        end
    end

    return new
end