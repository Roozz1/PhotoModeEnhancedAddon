---------------------------------------
------------- Main
---------------------------------------

------------- Variables
---@type table<integer, ca_animation>
local animations = {}

------------- Functions
mainFunctions = {
    ---@param player player
    createAnimation = function(player)
        animations[player.properties.peer_id] = {
            properties = {
                plots = {},
                currentPlotPoint = 1,
                isInProgress = false,
                player = player,
                animation = nil
            },

            events = {
                started = eventFunctions.new(player.properties.peer_id.."_anim_started"),
                stopped = eventFunctions.new(player.properties.peer_id.."_anim_stopped"),
                finished = eventFunctions.new(player.properties.peer_id.."_anim_finished")
            },

            ---@param self ca_animation
            play = function(self)
                -- set properties
                self.properties.isInProgress = true
                self.properties.currentPlotPoint = 1

                -- animation stuff
                local current_plot = self.properties.plots[self.properties.currentPlotPoint]
                local next_plot = self.properties.plots[self.properties.currentPlotPoint + 1]

                -- animation has finished
                if not current_plot or not next_plot then
                    self.properties.isInProgress = false
                    self.events.finished:call()
                    return
                end

                -- actual animation stuff
                self.properties.animation = cuhFramework.animation.createLinearAnimation(current_plot.pos, next_plot.pos, 0.001 * cuhFramework.utilities.number.clamp(current_plot.speed, 0.0001, 1), false, function(animation) ---@param animation animation
                    -- animation has finished
                    if animation.properties.finished then
                        -- stop this animation so a new one can be created next iteration
                        animation:remove()

                        -- increase the current plot point ready for next iteration
                        self.properties.currentPlotPoint = self.properties.currentPlotPoint + 1

                        -- start next iteration
                        return self:play()
                    end

                    -- animate
                    self.properties.player:teleport(animation.properties.current_pos)
                end)
            end,

            ---@param self ca_animation
            stop = function(self)
                -- pause the animation
                if self.properties.animation then
                    self.properties.animation:setPaused(true)
                end

                -- set properties
                self.properties.isInProgress = false
            end,

            ---@param self ca_animation
            remove = function(self)
                return mainFunctions.removeAnimation(self)
            end,

            ---@param self ca_animation
            createPlot = function(self, position, speed)
                table.insert(self.properties.plots, {
                    pos = position,
                    speed = speed
                })
            end,

            ---@param self ca_animation
            removeRecentPlot = function(self)
                self.properties.plots[#self.properties.plots] = nil
            end
        }

        return animations[player.properties.peer_id]
    end,

    ---@param animation ca_animation
    removeAnimation = function(animation)
        if animation.properties.animation then
            animation.properties.animation:remove()
        end

        animation[animation.properties.player.properties.peer_id] = nil
    end,

    ---@param player player
    getAnimationByPlayer = function(player)
        return animations[player.properties.peer_id]
    end,

    ---@param player player
    hasAnimation = function(player)
        return animations[player.properties.peer_id] ~= nil
    end
}