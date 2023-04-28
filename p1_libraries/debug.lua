---------------------------------------
------------- Debug
---------------------------------------

------------- Variables
debug_recently_called_function = nil

------------- Functions
debugFunctions = {
    initialize = function()
        -- alive loop
        cuhFramework.utilities.loop.create(1, function()
            df.print("alive")
        end)
    end,

    debugEnabled = function()
        return config.debugEnabled
    end,

    getRecentlyCalledFunction = function()
        return tostring(debug_recently_called_function)
    end,

    setRecentlyCalled = function(name, ...)
        df.print("setting recently called function to "..name)

        debug_recently_called_function = name.." | Args: "..table.concat(cuhFramework.utilities.table.tostringValues({...}), ", ")
        df.print("Recently called function:\n"..debug_recently_called_function)
    end,

    print = function(...)
        if not debugFunctions.debugEnabled() then
            return
        end

        local to_print = {...}

        if not to_print[1] then
            return
        end

        to_print = cuhFramework.utilities.table.tostringValues(to_print)

        if config.debugShouldLog then
            debug.log("DEBUG - "..table.concat(to_print, "\n").."\n----------------------")
        else
            chatAnnounce("DEBUG - "..table.concat(to_print, "\n"))
        end
    end
}

df = debugFunctions