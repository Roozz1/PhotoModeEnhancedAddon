---------------------------------------
------------- Player Join
---------------------------------------

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

    -- Add
    table.insert(players_unfiltered, player)

    -- Announce
    chatAnnounce("This server uses the "..config.info.addon_name.." addon. For help using this addon, type '?help'.\n    Discord: "..config.info.discord.."\n    Creator: "..config.info.creator, player)
end)