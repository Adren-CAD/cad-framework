-- Utils file

function authencatedMethod(callback)
	if user then
		callback()
	else
		-- notify('You must be logged in! Type /login to continue.')

		TriggerEvent('adrenCAD:loginPlayer')
	end
end

function notify(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(true, true)
end

function hintToDisplay(text, bool)
	BeginTextCommandDisplayHelp("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, bool, -1)
end

RegisterNetEvent('adrenCAD:notify')
AddEventHandler('adrenCAD:notify', notify)
