-- Variable
---@type map|nil
local selected_map = nil

---@type table<string, map>
local maps = {}

---@type table<any, map>
local maps_raw = {}

-- Functions
mapFunctions = {
    new = function(name, position, size, needs_zone)
        df.setRecentlyCalled("mapFunctions.new", name, position)

        maps[name] = {
            name = name,
            position = position,
            size = size,
            needs_zone = needs_zone
        }

        table.insert(maps_raw, maps[name])

        return {
            map = maps[name],

            remove = function(self)
                return mapFunctions.remove(self.map.name)
            end
        }
    end,

    remove = function(name)
        df.setRecentlyCalled("mapFunctions.remove", name)

        local data = maps[name]
        cuhFramework.utilities.table.removeValueFromTable(maps_raw, data)

        maps[name] = nil
    end,

    ---@param map map
    spawnMap = function(map)
        df.setRecentlyCalled("mapFunctions.spawnMap", map)

        if selected_map then
            return
        end

        if map.needs_zone then
            map_zone = cuhFramework.customZones.createPlayerZone(map.position, map.size, function(player, entered)
                if not gameFunctions.contestant.isContestant(player) then
                    return
                end

                if not entered then
                    player:teleport(map.position)
                end
            end)
        end

        selected_map = map
        return map
    end,

    despawnMap = function()
        df.setRecentlyCalled("mapFunctions.despawnMap")

        if map_zone then
            map_zone:remove()
        end

        if selected_map then
            selected_map = nil
        end
    end,

    getRandomMap = function()
        df.setRecentlyCalled("mapFunctions.getRandomMap")
        return maps_raw[math.random(1, #maps_raw)]
    end,

    getCurrentMap = function()
        return selected_map
    end
}