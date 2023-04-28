cuhFramework.utilities.delay.create(0.01, function() -- reload scripts for loop cleans the map objects below, so this is here to prevent it
    ------------- Screen Popups
    -- Discord
    discord_ui = cuhFramework.ui.screen.create(11000, "Discord:\n"..config.info.discord, -0.9, 0.2)

    -- Help
    help_ui = cuhFramework.ui.screen.create(11001, "Type '?help' for help.", -0.9, 0.37)

    -- Game Info
    game_info_ui = cuhFramework.ui.screen.create(11004, "Wave 1", 0, 0.9):setVisibility(false)

    -- Player Count
    player_count_ui = cuhFramework.ui.screen.create(11005, "", -0.9, 0)

    cuhFramework.utilities.loop.create(1, function()
        local player_count = miscellaneousFunctions.getPlayerCount()
        player_count_ui:edit(player_count.." player"..miscellaneousFunctions.pluralOrSingular(player_count).."."..cuhFramework.utilities.miscellaneous.switchbox("", "\n"..gameFunctions.helpers.getMinimumPlayers() - player_count.." more needed.", player_count < gameFunctions.helpers.getMinimumPlayers()))
    end)
end)