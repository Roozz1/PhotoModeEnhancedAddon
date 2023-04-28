---------------------------------------
------------- Command
---------------------------------------

------------- ?anim new
cuhFramework.commands.create("create", {"cr"}, false, "anim", function(message, peer_id, admin, auth, command, ...)
    -- Get player
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)

    -- Check
    if mainFunctions.hasAnimation(player) then
        return announceFunctions.status.failure("You have already created an animation. If you would like to delete it, type '?delete'.", player)
    end

    -- Create
    mainFunctions.createAnimation(player)
    announceFunctions.status.success("You have successfully created an animation. If you would like to create an animation point (plot) for the animation, type '?plot add'.", player)
end, "Create an animation.")

------------- ?anim play
cuhFramework.commands.create("play", {"p"}, false, "anim", function(message, peer_id, admin, auth, command, ...)
    -- Get player
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)

    -- Check
    if not mainFunctions.hasAnimation(player) then
        return announceFunctions.status.failure("You don't have an animation. If you would to make one, type '?create'.", player)
    end

    -- Play
    local animation = mainFunctions.getAnimationByPlayer(player)
    animation:play()
end, "Play your animation.")

------------- ?anim stop
cuhFramework.commands.create("stop", {"s"}, false, "anim", function(message, peer_id, admin, auth, command, ...)
    -- Get player
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)

    -- Check
    if not mainFunctions.hasAnimation(player) then
        return announceFunctions.status.failure("You don't have an animation. If you would to make one, type '?create'.", player)
    end

    -- Stop
    local animation = mainFunctions.getAnimationByPlayer(player)
    animation:stop()
end, "Stop your ongoing animation.")

------------- ?anim delete
cuhFramework.commands.create("delete", {"d"}, false, "anim", function(message, peer_id, admin, auth, command, ...)
    -- Get player
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)

    -- Check
    if not mainFunctions.hasAnimation(player) then
        return announceFunctions.status.failure("You don't have an animation. If you would to make one, type '?create'.", player)
    end

    -- Remove
    local animation = mainFunctions.getAnimationByPlayer(player)
    animation:remove()

    announceFunctions.status.success("You have successfully removed your animation. If you would like to create an animation, type '?create'.", player)
end, "Delete your animation.")

------------- ?anim
cuhFramework.commands.create("anim", nil, false, nil, function(message, peer_id, admin, auth, command, ...)
    -- Get player
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)

    -- Typed command incorrectly
    announceFunctions.status.failure("This command requires a subcommand. Type '?help' to see them.", player)
end)