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
    -- Damage
    cuhFramework.ui.screen.create(peer_id + 36000, "!!", 0, 0, player):setVisibility(false)

    -- Type '?ready'
    cuhFramework.ui.screen.create(peer_id + 37000, "Type '?ready' or '?r' to begin playing.", 0, 0, player)

    ------------- Map Objects
    -- Game Area
    cuhFramework.utilities.delay.create(1, function() -- just in case ?reload_scripts is used and map spawn pos hasnt been set yet
        eventFunctions.get("game_start"):connect(function()
            local current_map = mapFunctions.getCurrentMap()
            if current_map then
                cuhFramework.references.addMapObject(peer_id, 11003, 0, 18, current_map.position[13], current_map.position[15],  nil, nil, nil, nil, "Game Area", current_map.size, "Map: "..current_map.name.."\nYou cannot exit this area.", 255, 255, 255, 255)
            end
        end)

        eventFunctions.get("game_end"):connect(function()
            cuhFramework.references.removeMapObject(peer_id, 11003)
        end)
    end)
end)