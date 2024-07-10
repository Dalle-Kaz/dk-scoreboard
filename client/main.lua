ESX = exports['es_extended']:getSharedObject()
StartLoop = false

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded',function(xPlayer)
	StartLoop = true
end)

RegisterCommand('reset_leaderboard', function()
    StartLoop = false
    StartLoop = true
end)

CreateThread(function()
    while true do
        Wait(2500)

        if StartLoop == true then
            ESX.TriggerServerCallback('dk-scoreboard:GetData', function(data)
                SendNUIMessage({
                    type = 'update',
                    jobs = data.jobs, 
                    players = data.players, 
                    activePlayers = data.activePlayers, 
                    maxPlayers = data.maxPlayers,
                    myid = GetPlayerServerId(PlayerId())
                })
            end)
        end
    end
end)

CreateThread(function()
    while true do
        if StartLoop == true then
            Wait(3)

            if IsControlJustPressed(0, 29) then SendNUIMessage({ type = 'state', status = true }) end
            if IsControlJustReleased(0, 29) then SendNUIMessage({ type = 'state', status = false }) end
        else
            Wait(2500)
        end
    end
end)