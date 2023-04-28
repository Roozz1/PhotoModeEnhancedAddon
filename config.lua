config = {
    isDedicatedServer = true,
    debugEnabled = true,
    debugShouldLog = true,

    info = {
        server_name = "Event",
        discord = "discord.gg/zTQxaZjwDr"
    },

    cleanup = {
        obj_cleanup_time = 45,
        radiation_cleanup_time = 1,
        dropped_item_cleanup_time = 30
    },

    starter_inventory = {
        nil,
        {id = 35, amount = 17},
        nil, nil, nil, nil, nil, nil, nil,
        {id = 76, amount = 1},
    },

    zombie = {
        value = {
            min = 50,
            max = 200
        },

        maxConcurrentZombies = 45,
        spawnTime = 7
    },

    game = {
        timeUntilNext = 15,
        timeUntilFullDeath = 20,

        upgradeWeaponWave = 5,

        sounds = {
            gameStart = "gameStart",
            gameEnd = "gameEnd",
            newWave = "newWave"
        }
    }
}