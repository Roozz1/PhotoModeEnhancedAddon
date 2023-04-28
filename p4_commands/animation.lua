---------------------------------------
------------- Command
---------------------------------------

------------- ?new
cuhFramework.commands.create("create", {"cr"}, false, nil, function(message, peer_id, admin, auth, command, ...)
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
cuhFramework.commands.create("delete", {"d"}, false, nil, function(message, peer_id, admin, auth, command, ...)
    -- Get player
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)

    -- Check
    if not mainFunctions.hasAnimation(player) then
        return announceFunctions.status.failure("You don't have an animation. If you would to make one, type '?create'.", player)
    end

    -- Remove animation
    local animation = mainFunctions.getAnimationByPlayer(player)
    animation
end)