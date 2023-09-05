API_URL = GetConvar('cad_internal_API')

local resourceName = GetCurrentResourceName()

if resourceName ~= 'adrenCAD' then
    TriggerEvent('adrenCAD:log', 'It is highly reccomended too rename the resource to "adrenCAD"', true)
    TriggerEvent('adrenCAD:log', 'Leaving the resource name as "' .. resourceName .. '" will cause issues!', true)
end

if Config.list_server then
    AddEventHandler('adrenCAD:configSet', function()
        TriggerEvent('adrenCAD:log', 'Heartbeat enabled.')

        function GetActivePlayerCount()
            local playerCount = 0
        
            for _, player in ipairs(GetPlayers()) do
                playerCount = playerCount + 1
            end
        
            return playerCount
        end

        Citizen.CreateThread(function()
            while true do
                TriggerEvent('adrenCAD:sendHearteat', {
                    playerCount = GetActivePlayerCount()
                })
                
                Citizen.Wait(300000)
            end
        end)
    end)
end