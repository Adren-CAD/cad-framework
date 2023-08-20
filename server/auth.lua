-- Server auth management

RegisterNetEvent('adrenCAD:createDashboardToken')
AddEventHandler('adrenCAD:createDashboardToken', function(token)
    local player = source

    local data = json.encode({ 
        token = token, 
        fivem = true,
        key = GetConvar('ADRENCAD_KEY')
    })

    local headers = {
        ['Content-Type'] = 'application/json',
        ['Authorization'] = 'Bearer ' .. token
    }

    PerformHttpRequest(API_URL .. '/internal/user/createToken', function(statusCode, responseBody, responseHeaders)
        local responseData = json.decode(responseBody)

        local userDashboardToken = responseData.token

        TriggerClientEvent('adrenCAD:setDashboardToken', player, userDashboardToken)
    end, 'POST', data, headers)
end)
