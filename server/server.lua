players = {}

RegisterNetEvent('adrenCAD:fetchActivePlayers')
AddEventHandler('adrenCAD:fetchActivePlayers', function()
    local players = {}

    for _, player in ipairs(GetPlayers()) do
        local identifiers = GetPlayerIdentifiers(player)

        local name = GetPlayerName(player)

        table.insert(
            players,
            {
                name = name,
                source = source,
                identifiers = json.encode(identifiers),
            }
        )
    end

    TriggerClientEvent('adrenCAD:setActivePlayers', source, players)
end)

RegisterNetEvent('adrenCAD:fetchCommunityId')
AddEventHandler('adrenCAD:fetchCommunityId', function()
    TriggerClientEvent('adrenCAD:setCommunityId', source, {
        communityId = GetConvar('cad_communityId')
    })
end)
