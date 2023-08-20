-- NUI Management client file

function toggleNuiFrame(shouldShow)
	SetNuiFocus(shouldShow, shouldShow)
	SendReactMessage('setVisible', shouldShow)
end

-- RegisterNUICallback('handleClose', function()end)

-- AddEventHandler('adrenCAD:handleClose', function()end)

RegisterNUICallback('fetchConfig', function()
	SendReactMessage('setConfig', Config)
end)

RegisterNUICallback('hideFrame', function()
	toggleNuiFrame(false)
end)

RegisterNUICallback('createAlert', function(data)
	if data.error then
		notify('~r~[ERROR]~w~ ' .. data.text)
	else
		notify(data.text)
	end
end)