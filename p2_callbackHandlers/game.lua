cuhFramework.utilities.delay.create(0.1, function() -- give time for connections to be made
    ------------- Game Callbacks
    -- Start
    eventFunctions.get("game_starting"):connect(function()
        -- Items
        local pistol = inventoryFunctions.newItem(35, 17)
        local flashlight = inventoryFunctions.newItem(15, 100)

        for i, v in pairs(cuhFramework.players.connectedPlayers) do
            if not miscellaneousFunctions.unnamedClientOrServerOrDisconnecting(v) then
                inventoryFunctions.clear(v)

                inventoryFunctions.set(v, 2, pistol) -- game gives the items
                inventoryFunctions.set(v, 3, flashlight)
            end
        end
    end)

    eventFunctions.get("game_start"):connect(function()
        -- Sound
        local sound_vehicle = gameFunctions.helpers.getSoundsVehicle()
        sound_vehicle:press_button(config.game.sounds.gameStart)
    end)

    -- End
    eventFunctions.get("game_end"):connect(function()
        local sound_vehicle = gameFunctions.helpers.getSoundsVehicle()
        sound_vehicle:press_button(config.game.sounds.gameEnd)
    end)

    ------------- Miscellaneous Callbacks
    -- New wave
    eventFunctions.get("new_wave"):connect(function(wave)
        -- despawn zombies
        zombieFunctions.despawnAllZombies(true)

        -- ui stuff
        local ui = cuhFramework.ui.screen.get(11004)

        if ui then
            ui:edit("Wave "..wave.."\nKills: "..statisticsFunctions.get("total_kills"), 0, 0)

            cuhFramework.utilities.delay.create(5, function()
                ui_anim = cuhFramework.animation.createLinearAnimation(matrix.translation(0, 0, 0), matrix.translation(0, 0.9, 0), 0.01, false, function(animation_data) ---@param animation_data animation_data
                    ui:edit("Wave "..wave, 0, animation_data.current_pos[14])

                    if animation_data.finished or not gameFunctions.helpers.isGameInProgress() then
                        ui:edit("Wave "..wave, 0, 0.9)
                        ui_anim:remove()
                    end
                end)
            end)
        end

        -- reset kills
        gameFunctions.misc.resetTotalKillsForThisWave()
    end)

    eventFunctions.get("new_wave"):connect(function(wave)
        -- go through contestants
        for i, v in pairs(gameFunctions.contestant.getAll()) do
            v:damage(-100) -- heal
            gameFunctions.helpers.giveItems(v)
        end

        -- Items
        if wave == config.game.upgradeWeaponWave then
            local rifle = inventoryFunctions.newItem(39, 30)

            for i, v in pairs(gameFunctions.contestant.getAll()) do
                if not miscellaneousFunctions.unnamedClientOrServerOrDisconnecting(v) then
                    inventoryFunctions.set(v, 1, rifle)
                    inventoryFunctions.giveItems(v)
                end
            end

            notificationAnnounce("Congratulations on making it to Wave "..wave..".\nYou have been given a rifle as a gift.")
        end

        -- sound
        local sound_vehicle = gameFunctions.helpers.getSoundsVehicle()
        sound_vehicle:press_button(config.game.sounds.newWave)
    end)

    ------------- Zombie Callbacks
    ---@param zombie zombie
    ---@param player player
    eventFunctions.get("zombie_death"):connect(function(zombie, player)
        df.print("zombie death")

        -- despawn
        zombieFunctions.despawnZombie(zombie, true)

        -- announce
        notificationAnnounce("You killed a zombie!", player)

        -- add to kills
        gameFunctions.misc.increaseTotalKillsForThisWave()
        gameFunctions.misc.increaseTotalKills()
    end)

    ---@param zombie zombie
    ---@param pos SWMatrix
    ---@param player player
    eventFunctions.get("zombie_move"):connect(function(zombie, pos, player)
        -- move
        zombie.creature:set_move_target(pos)
        -- df.print("moving zombie to "..miscellaneousFunctions.matrixFormatted(pos))
    end)

    ---@param zombie zombie
    ---@param player player
    eventFunctions.get("zombie_attack"):connect(function(zombie, player)
        df.print("zombie attack")

        -- damage player
        player:damage(zombieFunctions.damageAmount())

        -- temporarily show damage ui
        local ui = cuhFramework.ui.screen.get(player.properties.peer_id + 36000)
        if ui and not debounceFunctions.debounce("attack_ui_"..player.properties.peer_id, 0.1) then
            ui:setVisibility(true)

            cuhFramework.utilities.delay.create(0.1, function()
                ui = cuhFramework.ui.screen.get(player.properties.peer_id + 36000) -- quick check

                if not ui then
                    return
                end

                ui:setVisibility(false)
            end)
        end
    end)

    ------------- Player Callbacks
    -- Death
    cuhFramework.callbacks.onPlayerDie:connect(function(steam_id, name, peer_id, admin, auth)
        -- Get variables
        local player = cuhFramework.players.getPlayerByPeerId(peer_id)

        -- Checks
        if not player then
            return
        end

        if miscellaneousFunctions.unnamedClientOrServerOrDisconnecting(player) then
            return
        end

        if debounceFunctions.debounce("die_"..peer_id, 1) then
            return
        end

        -- Announce
        if not gameFunctions.helpers.isGameInProgress() then
            local character = player:get_character()
            server.reviveCharacter(character)
            return player:damage(-100)
        else
            gameFunctions.contestant.remove(player, true)
            chatAnnounce(player.properties.name.." has been eliminated.")
        end

        -- Debug
        df.print("player death - "..name)
    end)
end)