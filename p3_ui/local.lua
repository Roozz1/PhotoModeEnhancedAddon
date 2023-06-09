---------------------------------------
------------- UI [Local]
---------------------------------------

------------- Main
cuhFramework.callbacks.onPlayerJoin:connect(function(steam_id, name, peer_id, admin, auth)
    -- Get variables
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)

    -- Checks
    if not player then
        return
    end

    if miscellaneousFunctions.unnamedClientOrServerOrDisconnecting(player) then
        return
    end

    ------------- Screen Popups
    -- Animation Info UI
    cuhFramework.ui.screen.create(peer_id + 10000, "", 0, 0.9, player):setVisibility(false)
end)