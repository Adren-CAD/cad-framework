-- AdrenCAD Pause menu client file

local function openKeybindings()
	toggleNuiFrame(false)

	Citizen.CreateThread(function()
		ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_LANDING_KEYMAPPING_MENU'), 0, -1)

		while true do
			Citizen.Wait(0)

			if IsControlJustPressed(0, 177) then
				SetFrontendActive(0)

				toggleNuiFrame(true)
					
				SendReactMessage('setPage', 'pause')

				break
			end
		end
	end)
end

RegisterNUICallback('openKeybindings', openKeybindings)

local function openMap()
    setMapShown(true)

    toggleNuiFrame(false)

    Citizen.CreateThread(function()
        ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_MP_PAUSE'), 0, -1)

        SetFrontendActive(0)
    end)
end

RegisterNUICallback('openMap', openMap)