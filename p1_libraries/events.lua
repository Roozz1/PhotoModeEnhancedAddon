-- Variables
---@type table<string, event>
local events = {}

-- Functions
eventFunctions = {
    ---@return event
    new = function(name)
        events[name] = {
            connections = {},

            connect = function(self, func)
                table.insert(self.connections, func)
            end,

            call = function(self, ...)
                for i, v in pairs(self.connections) do
                    v(...)
                end
            end
        }

        return events[name]
    end,

    ---@return event
    get = function(name)
        return events[name]
    end
}