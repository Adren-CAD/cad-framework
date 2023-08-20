local garages = {}

local inCircle = true

local notified = false

local vehicleCoords = {
    x = 395.98,
    y = -971.02,
    z = -99.39,
    h = 297.95
}

local garageVehicle = nil

local vehicles = {
    "police",
    "police2",
    "sheriff",
    "sheriff2",
    "polmav"
}

local index = 1

local function upgradeVehicle() 
    if garageVehicle then DeleteVehicle(garageVehicle) end
    
    SetEntityVisible(GetPlayerPed(-1), false)
    
    local vehiclehash = GetHashKey(vehicles[index])
    
    local model = RequestModel(vehiclehash)

    local vehicle = CreateVehicle(vehiclehash, vehicleCoords.x, vehicleCoords.y, vehicleCoords.z, vehicleCoords.h, 1, 0)

    garageVehicle = vehicle

    SetPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)

    SetEntityVisible(GetPlayerPed(-1), true)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)

        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        local readyForInput = false

        for _, garage in ipairs(garages) do
            local distance = #(playerCoords - vector3(garage.x, garage.y, garage.z))

            if distance < 5 then
                DrawMarker(27, garage.x, garage.y, garage.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 100, false, true, 2, true, false, false, false)
            end

            if distance < 1.5 then
                readyForInput = true
            end
        end

        if not readyForInput then
            notified = false
        end

        if not notified and readyForInput then
            hintToDisplay('Press E too open the Police Garage.')

            notified = true
        end
        
        if IsControlJustPressed(1, 86) and readyForInput then
            inGarage = true

            Citizen.CreateThread(function()
                DoScreenFadeOut(10)
            
                Citizen.Wait(500)
            
                DoScreenFadeIn(500)

                SendReactMessage('setPage', 'garage')
            end)
        
            Citizen.CreateThread(function()
                cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 397.44, -966.0, -98.0, -15.00,0.00,170.00, 80.00, false, 0)
            
                SetCamActive(cam, true)
            
                RenderScriptCams(true, false, 1, true, true)
            
                Citizen.Wait(200)

                upgradeVehicle()
            
                Citizen.CreateThread(function()
                    while true do
                        Citizen.Wait(0)
                
                        local openMap = IsPauseMenuActive()
                
                        -- UP ARROW
                        if IsControlJustPressed(1, 172) and not openMap then
                            index = index + 1
                            
                            upgradeVehicle()
                        end
                    end
                end)
            end)
        end

        if IsControlJustPressed(1, 18) and inGarage then
            local pos = {
                x = 449.86,
                y = -1017.3,
                z = 28.13,
                h = 90.29
            }
        
            IsChoosing = false

            SendReactMessage('setPage', nil)
            
            DoScreenFadeOut(500)
        
            Citizen.Wait(500)
        
            FreezeEntityPosition(GetPlayerPed(-1), false)
            SetEntityCoords(GetPlayerPed(-1), pos.x, pos.y, pos.z)    
        
            RenderScriptCams(false, true, 0, true, true)
        
            DisplayHud(true)
            DisplayRadar(true)

            local vehiclehash = GetHashKey(vehicles[index])

            local model = RequestModel(vehiclehash)
        
            local playerPed = GetPlayerPed(-1)

            local heading = GetEntityHeading(playerPed)

            local vehicle = CreateVehicle(vehiclehash, pos.x, pos.y, pos.z, pos.h, 1, 0)

            SetVehicleOnGroundProperly(vehicle)

            SetModelAsNoLongerNeeded(model)

            TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

            SetNuiFocus(false, false)

            DoScreenFadeIn(400)

            inGarage = false

            index = 1
        end
    end
end)

for _, station in ipairs(Config.police_stations) do
    if station.garage then
        table.insert(garages, station.garage)
    end
end