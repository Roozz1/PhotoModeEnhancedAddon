---------------------------------------
------------- Player Leave
---------------------------------------

cuhFramework.callbacks.onPlayerLeave:connect(function(steam_id, name, peer_id, admin, auth)
    -- Get variables
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)

    -- Checks
    if not player then
        return
    end

    if miscellaneousFunctions.unnamedClientOrServerOrDisconnecting(player) then
        return
    end

    -- Remove
    cuhFramework.utilities.table.removeValueFromTable(players_unfiltered, player)

    -- Clear states
    playerStatesFunctions.clearStates(player)
end)