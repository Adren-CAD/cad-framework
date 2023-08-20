-- AdrenCAD Ingame settings client file

RegisterNUICallback('openSettings', function()
	SendReactMessage('setShowSettingsModal', true)
end)