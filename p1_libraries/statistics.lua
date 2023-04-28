-- Variables
local statistics = {}

-- Functions
statisticsFunctions = {
    track = function(name, starting_value)
        statistics[name] = starting_value
    end,

    untrack = function(name)
        statistics[name] = nil
    end,

    add = function(name, amount)
        if not statistics[name] then
            return statistics.track(name, amount)
        end

        statistics[name] = statistics[name] + amount
    end,

    subtract = function(name, amount)
        if not statistics[name] then
            return statistics.track(name, 0)
        end

        statistics[name] = statistics[name] - amount
    end,

    set = function(name, value)
        if not statistics[name] then
            return statistics.track(name, value)
        end

        statistics[name] = value
    end,

    get = function(name)
        return statistics[name]
    end
}