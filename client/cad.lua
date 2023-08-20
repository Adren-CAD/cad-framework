-- AdrenCAD CAD Dashboard Integration Client File

RegisterCommand('cad', function()
	authencatedMethod(function()
		toggleNuiFrame(true)
		
		SendReactMessage('setPage', 'CAD')
	end)
end)

RegisterNUICallback('openCAD', function()
	toggleNuiFrame(true)
		
	SendReactMessage('setPage', 'CAD')
end)
