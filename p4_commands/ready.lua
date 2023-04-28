-- Get Position
cuhFramework.commands.create("ready", {"r"}, false, nil, function(message, peer_id, admin, auth, command, ...)
    -- get player
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)

    -- quick check
    if playerStatesFunctions.hasState(player, "ready") then
        return announceFunctions.status.failure("You are already ready.", player)
    end

    -- set ready
    playerStatesFunctions.setState(player, "ready")
    announceFunctions.status.success("You are now recognised as ready.", player)

    -- teleport
    player:teleport(gameFunctions.helpers.getWaitingPos())

    -- hide ui
    local ui = cuhFramework.ui.screen.get(peer_id + 37000)
    if ui then
        ui:remove()
    end
end)