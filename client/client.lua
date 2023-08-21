-- Client init file

communityId = nil
spawned = false
config = nil
configTriggered = false
configSet = false
user = nil
userToken = nil
mapShown = false
balance = 0
inGarage = false
smoking = false

SendReactMessage('setResourceName', GetCurrentResourceName())

RegisterNetEvent('adrenCAD:setConfig')
AddEventHandler('adrenCAD:setConfig', function(_data)
    local data = _data

    communityId = _data.communityId

    data.police_stations = Config.police_stations

    data.civilian_spawns = Config.civilian_spawns

    SendReactMessage('setConfig', _data)

    config = data

    configSet = true
end)

RegisterNetEvent('adrenCAD:setActivePlayers')
AddEventHandler('adrenCAD:setActivePlayers', function(data)
    SendReactMessage('setActivePlayers', data)
end)

-- CreateThread(function()
--     while true do 
--         SetPauseMenuActive(false) 

--         Wait(1)
--     end
-- end)

function requestConfigThread()
    Citizen.Wait(500)

    TriggerServerEvent('adrenCAD:fetchConfig')
    
    configTriggered = true
end

RegisterNUICallback('openPlayers', function()
    toggleNuiFrame(true)

    TriggerServerEvent('adrenCAD:fetchActivePlayers')
        
    SendReactMessage('setPage', 'players')
end)

RegisterNUICallback('openSettings', function()
	toggleNuiFrame(true)
		
	SendReactMessage('setPage', 'settings')
end)

local function keyPressThread()
    while true do
        Citizen.Wait(0)

        if spawned then 
            local openMap = IsPauseMenuActive()

            -- Get up from chair
            if IsControlJustPressed(1, 23) and sitting then
                TriggerEvent('adrenCAD:situp')
            end

            -- Stop smoking
            if IsControlJustPressed(1, 23) and smoking then
                local playerPed = GetPlayerPed(-1)

                ClearPedTasks(playerPed)

                smoking = false
            end

            -- UP ARROW
            if IsControlJustPressed(1, 172) and not openMap and not inGarage then
                toggleNuiFrame(true)

                TriggerServerEvent('adrenCAD:fetchActivePlayers')
                    
                SendReactMessage('setPage', 'players')
            end

            -- ESC
            if IsControlJustPressed(1, 200) 
            -- and not openMap
            then
                toggleNuiFrame(true)
                    
                SendReactMessage('setPage', 'pause')
            end

            -- BACKSPACE / ESC
            if IsControlJustPressed(1, 177) and openMap then
                Citizen.Wait(400)

                if not IsPauseMenuActive() then
                    setMapShown(false)
                end
            end

            -- P
            if IsControlJustPressed(1, 199) and not openMap then
                ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_MP_PAUSE'),0,-1) 
                    
                setMapShown(true)
            end

            -- Y
            if IsControlJustPressed(1, 246) and mapShown and Config.tpm_enabled then
                local WaypointHandle = GetFirstBlipInfoId(8)

                if DoesBlipExist(WaypointHandle) then
                    local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)

                    for height = 1, 1000 do
                        SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

                        local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)

                        if foundGround then
                            SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

                            break
                        end

                        Citizen.Wait(5)
                    end
                end

                SetPauseMenuActive(false)
            end
        end
    end
end

function ignoreWantedLevelThread()
    while true do
        Citizen.Wait(0)

        if GetPlayerWantedLevel(PlayerId()) ~= 0 then
            SetPlayerWantedLevel(PlayerId(), 0, false)
            SetPlayerWantedLevelNow(PlayerId(), false)
        end
    end
end

Citizen.CreateThread(requestConfigThread)

-- Citizen.CreateThread(keyPressThread)

if Config.ignore_wanted_level then
    Citizen.CreateThread(ignoreWantedLevelThread)
end

-- if Config.require_login == true then
--     TriggerEvent('adrenCAD:loginPlayer')
-- else
--     SendReactMessage('setSpawned', true)
-- end

SendReactMessage('setSpawned', true)

spawned = true