ESX = exports['es_extended']:getSharedObject()
maxPlayers = GetConvar("sv_maxclients", 64)

ESX.RegisterServerCallback('dk-scoreboard:GetData', function(src, cb)
    local activePlayers = 0
    local players = {}
    local jobs = {}

    for k,v in pairs(ESX.GetPlayers()) do
        activePlayers = activePlayers + 1

        local yPlayer = ESX.GetPlayerFromId(v)

        if yPlayer == nil then
            table.insert(players, { name = 'No Name Detected' })
        else
            table.insert(players, {
                name = yPlayer.getName()
            })

            for k,v in pairs(Config.Jobs) do
                local job = v.job

                if jobs[job] == nil then
                    jobs[job] = { label = v.label, online = 0 }
                end

                if yPlayer.getJob() == job then
                    jobs[job].online = jobs[job].online + 1
                end
            end
        end
    end

    cb({
        players = players,
        jobs = jobs,
        maxPlayers = maxPlayers,
        activePlayers = activePlayers
    })
end)