---------------------------------------
------------- Command
---------------------------------------

------------- ?help
cuhFramework.commands.create("help", {"h"}, false, nil, function(message, peer_id, admin, auth, command, ...)
    -- Get player
    local player = cuhFramework.players.getPlayerByPeerId(peer_id)

    -- Pack commands into table
    local commands = {}

    for i, v in pairs(cuhFramework.commands.registeredCommands) do
        -- probably an admin/internal command
        if v.description == "" then
            goto continue
        end

        -- add to commands list but nice and formatted
        table.insert(commands, "?"..v.command_name.."\n\\___"..v.shorthands.."\n\\___"..v.description)

        ::continue::
    end

    -- Show commands and help message

end)