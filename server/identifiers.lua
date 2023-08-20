-- Identifiers Management

local identifiers = {}

local function generateIdentifier()
    local length = 32

    local charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
    local identifier = ""
    local charsetLength = string.len(charset)
    
    math.randomseed(os.time())
    
    for _ = 1, length do
        local randomIndex = math.random(1, charsetLength)

        identifier = identifier .. string.sub(charset, randomIndex, randomIndex)
    end
    
    return identifier
end

local function fetchIdentifier(target)
    local identifier

    for c = 1, #identifiers, 1 do
        local id = identifiers[c]

        if id.identifier == target then
            identifier = id
        end
    end

    return identifier
end

AddEventHandler('adrenCAD:accountAuthencated', function(data)
    local validIdentifier = fetchIdentifier(data.identifier)

    if validIdentifier then
        TriggerClientEvent('adrenCAD:setDashboardToken', validIdentifier.player, data.token)
    end
end)

AddEventHandler('adrenCAD:accountError', function(data)
    local validIdentifier = fetchIdentifier(data.identifier)

    if validIdentifier then
        TriggerClientEvent('adrenCAD:accountError', validIdentifier.player)
    end
end)

RegisterNetEvent('adrenCAD:createIdentifier')
AddEventHandler('adrenCAD:createIdentifier', function(loginType)
    local player = source

    local identifier = generateIdentifier()

    table.insert(identifiers, {
        player = player,
        identifier = identifier
    })

    TriggerClientEvent('adrenCAD:setIdentifier', player, {
        identifier = identifier,
        loginType = loginType
    })
end)
