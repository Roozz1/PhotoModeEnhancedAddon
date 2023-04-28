---------------------------------------
------------- Command
---------------------------------------

------------- ?plot add
cuhFramework.commands.create("add", {"a"}, false, "plot", function(message, peer_id, admin, auth, command, ...)
    -- Get player and args
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)
    local args = {...}

    -- Check
    if not mainFunctions.hasAnimation(player) then
        return announceFunctions.status.failure("You don't have an animation. If you would like to create one, type '?create'.", player)
    end

    -- Create plot point
    local animation = mainFunctions.getAnimationByPlayer(player)

    local playerPos = player:get_position()
    local speed = tonumber(args[1])

    animation:createPlot(playerPos, speed or 1)

    announceFunctions.status.success("You have successfully created a plot point for your animation. Want to see your plot points? Type '?plot show'."..cuhFramework.utilities.miscellaneous.switchbox("\nTip: You can specify a speed for your plot point by typing '?plot add (speed)'.", "", speed), player)
end, "Create a new plot in your animation.")

------------- ?plot show
local showing_plots = {}

cuhFramework.utilities.loop.create(0.01, function()
    for i, _ in pairs(showing_plots) do
        -- get variables
        local data = showing_plots[i]

        local player = cuhFramework.players.getPlayerByPeerId(i)
        local animation = mainFunctions.getAnimationByPlayer(player)

        -- quick check
        if not animation then
            for _, plotObject in pairs(data.plotObjects) do
                plotObject:explode(0)
            end

            showing_plots[i] = nil
            return
        end

        -- pooof
        for plot_index, plot in pairs(animation.properties.plots) do
            if not data.plotObjects[plot_index] then
                data.plotObjects[plot_index] = cuhFramework.objects.spawnObject(plot.pos, 71) -- glowstick
            end

            data.plotObjects[plot_index]:teleport(plot.pos)
        end
    end
end)

cuhFramework.commands.create("show", {"s"}, false, "plot", function(message, peer_id, admin, auth, command, ...)
    -- Get player
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)

    -- Check
    if not mainFunctions.hasAnimation(player) then
        return announceFunctions.status.failure("You don't have an animation. If you would like to create one, type '?create'.", player)
    end

    -- Show/Hide plot points
    local data = showing_plots[peer_id]
    if data then
        -- hide
        ---@param v object
        for i, v in pairs(data.plotObjects) do
            v:explode(0)
        end

        showing_plots[peer_id] = nil
    else
        -- show
        showing_plots[peer_id] = {
            plotObjects = {}
        }
    end
end, "Show your animation's plots.")

------------- ?plot delete
cuhFramework.commands.create("delete", {"d"}, false, "plot", function(message, peer_id, admin, auth, command, ...)
    -- Get player
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)

    -- Check
    if not mainFunctions.hasAnimation(player) then
        return announceFunctions.status.failure("You don't have an animation. If you would like to create one, type '?create'.", player)
    end

    -- Remove most recent plot point
    local animation = mainFunctions.getAnimationByPlayer(player)
    animation:removeRecentPlot()

    announceFunctions.status.success("You have successfully removed the most recent plot point from your animation. Want to see your plot points? Type '?plot show'.", player)
end, "Delete your animation's most recent plot.")

------------- ?plot
cuhFramework.commands.create("plot", {"p"}, false, nil, function(message, peer_id, admin, auth, command, ...)
    -- Get player
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)

    -- Typed command incorrectly
    announceFunctions.status.failure("This command requires a subcommand. Type '?help' to see them.", player)
end, "s")