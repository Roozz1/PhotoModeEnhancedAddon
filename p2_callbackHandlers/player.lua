------------- Join
cuhFramework.callbacks.onPlayerJoin:connect(function(steam_id, name, peer_id, admin, auth)
    -- Debug
    df.print("player join - "..name)

    -- Get variables
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)

    -- Checks
    if not player then
        return
    end

    if miscellaneousFunctions.unnamedClientOrServerOrDisconnecting(player) then
        return
    end

    -- Announce
    chatAnnounce(player.properties.name.." has joined the event.")

    if gameFunctions.helpers.isGameInProgress() then
        chatAnnounce("You joined during a game. Unfortunately, you'll have to wait until it ends to participate in a game.", player)
    end

    -- Remove contestant status
    gameFunctions.contestant.remove(player)

    -- Add
    table.insert(players_unfiltered, player)
end)

------------- Leave
cuhFramework.callbacks.onPlayerLeave:connect(function(steam_id, name, peer_id, admin, auth)
    -- Debug
    df.print("player leave - "..name)

    -- Get variables
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)

    -- Checks
    if not player then
        return
    end

    if miscellaneousFunctions.unnamedClientOrServerOrDisconnecting(player) then
        return
    end

    -- Announce
    chatAnnounce(player.properties.name.." has left the event.")

    -- Remove
    cuhFramework.utilities.table.removeValueFromTable(players_unfiltered, player)

    -- Remove contestant status
    gameFunctions.contestant.remove(player)

    -- Clear states
    playerStatesFunctions.clearStates(player)
end)

------------- Character load
cuhFramework.callbacks.onObjectLoad:connect(function(object_id)
    -- Get variables
    local player = cuhFramework.players.getPlayerByObjectId(object_id)

    if not player then
        return
    end

    if miscellaneousFunctions.unnamedClientOrServerOrDisconnecting(player) then
        return
    end

    -- Debug
    df.print("player char load - "..player.properties.name)
end)

------------- Item Drop
cuhFramework.callbacks.onEquipmentDrop:connect(function(dropper_obj_id, equipment_obj_id, equipment_id)
    cleanupFunctions.addException(equipment_obj_id)

   cuhFramework.utilities.delay.create(config.cleanup.dropped_item_cleanup_time, function()
        cuhFramework.objects.despawnObject(equipment_obj_id)
   end)
end)