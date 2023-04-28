-- general settings
local settings = {
    ["despawn_on_leave"] = true,
    ["clear_fow"] = true, -- show map
    ["infinite_ammo"] = true,
    ["respawning"] = true,
    ["infinite_batteries"] = true
}

for i, v in pairs(settings) do
    server.setGameSetting(i, v)
end

-- currency
server.setCurrency(10000000, 10000000)

-- weather
local weather = {
    1, -- fog
    0, -- rain
    0 -- wind
}

server.setWeather(table.unpack(weather))