-- Variables
local zombie_count = 0
local wave = 0
local zombies = {}

-- Functions
zombieFunctions = {
    new = function(pos)
        df.setRecentlyCalled("zombieFunctions.new")

        local zombie_creature = cuhFramework.creatures.spawnCreature(pos, math.random(64, 96), 1)

        if zombie_creature then
            cleanupFunctions.addException(zombie_creature.properties.object_id)

            zombie_count = zombie_count + 1
            zombies[zombie_creature.properties.object_id] = {
                value = 0, -- money to award on death
                creature = zombie_creature
            }

            return {
                zombie = zombies[zombie_creature.properties.object_id],

                set_value = function(self, value)
                    self.zombie.value = value
                end,

                despawn = function(self, explode)
                    return zombieFunctions.despawnZombie(self.zombie, explode)
                end
            }
        end
    end,

    getAllZombies = function()
        return zombies
    end,

    ---@param zombie zombie
    despawnZombie = function(zombie, explode)
        df.setRecentlyCalled("despawnZombie", zombie, explode)

        -- decrease count
        zombie_count = zombie_count - 1

        --remove data
        zombies[zombie.creature.properties.object_id] = nil

        -- despawn
        if explode then
            zombie.creature:explode(0.01)
        else
            zombie.creature:despawn()
        end
    end,

    despawnAllZombies = function(should_explode)
        df.setRecentlyCalled("despawn_all_zombies", should_explode)

        for i, v in pairs(zombies) do
            zombieFunctions.despawnZombie(v, should_explode)
        end
    end,

    getZombieCount = function()
        --df.setRecentlyCalled("get_zombie_count")
        return zombie_count
    end,

    getWave = function()
        return wave
    end,

    setWave = function(num)
        wave = num
    end,

    increaseWave = function(num)
        wave = wave + num
    end,

    maxZombies = function()
        return math.floor(wave * 1.2 ^ 2)
    end,

    getZombieSpawnTimer = function()
        return cuhFramework.utilities.number.clamp(config.zombie.spawnTime - ((zombieFunctions.getWave() / 4) ^ 1.1), 0.2, config.zombie.spawnTime)
    end,

    damageAmount = function()
        return cuhFramework.utilities.number.clamp(wave * 2, 1, 10)
    end
}