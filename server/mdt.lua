local activePlayers = {}

RegisterNetEvent('MDT:beginPatrol')
AddEventHandler('MDT:beginPatrol', function(data)
	local player = source
    
    local callsign = data.callsign

	local token = data.token

    local headers = {
        ['Content-Type'] = 'application/json',
        ['Authorization'] = 'Bearer ' .. token
    }

    PerformHttpRequest(API_URL .. '/internal/user', function(statusCode, responseBody, responseHeaders)
        local user = json.decode(responseBody)

        table.insert(activePlayers, {
            userId = user._id,
            displayName = user.displayName,
            callsign = callsign,
            player = player
        })
    end, 'GET', nil, headers)
end)

AddEventHandler('MDT:fetchActivePlayers', function(cb)
    TriggerEvent(cb, {
        activePlayers = activePlayers
    })
end)
