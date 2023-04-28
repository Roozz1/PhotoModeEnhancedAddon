---------------------------------------
------------- Command
---------------------------------------

------------- ?new
cuhFramework.commands.create("new", {"n"}, false, nil, function(message, peer_id, admin, auth, command, ...)
    -- Get player
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)

    -- Check
    if mainFunctions.hasAnimation(player) then
        return announceFunctions.status.failure("You have already created an animation. If you would like to delete it, type '?delete'.", player)
    end

    -- Create
    mainFunctions.createAnimation(player)
    announceFunctions.status.success("You have successfully created an animation. If you would like to create an animation point (plot) for the animation, type '?plot add'.", player)
end)

------------- ?delete
cuhFramework.commands.create("new", {"n"}, false, nil, function(message, peer_id, admin, auth, command, ...)
    -- Get player
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)

    -- Check
    if mainFunctions.hasAnimation(player) then
        return announceFunctions.status.failure("You have already created an animation. If you would like to delete it, type '?delete'.", player)
    end
end)