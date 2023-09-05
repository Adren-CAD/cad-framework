-- AdrenCAD MDT Integration Client File

local alerted = false
local inEmergencyVehicle = false
local MDTConnected = false

RegisterCommand('mdt', function()
	authencatedMethod(function()
		if MDTConnected then
			toggleNuiFrame(true)
			SendReactMessage('setPage', 'MDT')
		else
			notify('You are not connected too the MDT.')
		end
	end)
end)

-- beginPatrol

RegisterNUICallback('beginPatrol', function(data)
	-- print('begin...')

	TriggerServerEvent('MDT:beginPatrol', data)
end)

RegisterNUICallback('setMDTConnected', function(data)
	MDTConnected = data.connected

	TriggerEvent('adrenCAD:mdtConnected', data.connected)
end)

RegisterNUICallback('changeCallsign', function(data)
	SendReactMessage('setMDTConnected', false)
	setPage('MDT')
end)

RegisterNUICallback('openLivemap', function(data)
	SendReactMessage('openLivemap')
end)


local function MDTKeyPressThread()
    while true do
        Citizen.Wait(0)

        if spawned and MDTConnected then
            -- MDT (b)
            if IsControlJustPressed(1, Config.MDT_keybind) then
                toggleNuiFrame(true)
                SendReactMessage('setPage', 'MDT')
            end
        end
    end
end

local function VehicleDetctionThread()
    while true do
        Citizen.Wait(1000)

        local playerPed = PlayerPedId()

		local vehicle = GetVehiclePedIsIn(playerPed, false)
       
		local policeVehicle = (
			DoesEntityExist(vehicle) and 
			GetPedInVehicleSeat(vehicle, -1) == playerPed and 
			GetVehicleClassFromName(GetEntityModel(vehicle)) == 18 
		)

		if policeVehicle then
			inEmergencyVehicle = true
		else 
			inEmergencyVehicle = false
			alerted = false
		end
    end
end

local function MDTAlertThread()
    while true do
        Citizen.Wait(100)

		if inEmergencyVehicle and not alerted then
			hintToDisplay('Press B too open MDT.')

			alerted = true
		end
    end
end

Citizen.CreateThread(MDTKeyPressThread)

-- Citizen.CreateThread(VehicleDetctionThread)

-- Citizen.CreateThread(MDTAlertThread)

