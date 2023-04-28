-- Variables
cleanup_exceptions = {}
cleanup_previous_obj = nil

-- Functions
cleanupFunctions = {
    clearObjects = function()
        if not cleanup_previous_obj then
            cleanup_previous_obj = cuhFramework.objects.spawnObject(matrix.translation(0, 0, 0), 100)
        end

        local new = cuhFramework.objects.spawnObject(matrix.translation(0, 0, 0), 100)

        if not new then
            return
        end

        for i = cleanup_previous_obj.properties.object_id, new.properties.object_id do
            if not cleanup_exceptions[i] then
                cuhFramework.objects.despawnObject(i)
            end
        end

        cleanup_previous_obj = cuhFramework.objects.spawnObject(matrix.translation(0, 0, 0), 100)
    end,

    addException = function(id)
        cleanup_exceptions[id] = true
    end
}