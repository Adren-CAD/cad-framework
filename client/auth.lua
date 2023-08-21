-- AdrenCAD Authencation Client File

RegisterNetEvent('adrenCAD:loginCallback')
AddEventHandler('adrenCAD:loginCallback', function(data)
	local _user = data.user

	local _token = data.token

	user = _user

	userToken = _token
end)

RegisterNetEvent('adrenCAD:accountError')
AddEventHandler('adrenCAD:accountError', function()
    notify('~r~[ERROR]~w~ ' .. 'You are not a member of the CAD community.')

	toggleNuiFrame(false)
end)

RegisterNetEvent('adrenCAD:setDashboardToken')
AddEventHandler('adrenCAD:setDashboardToken', function(token)
	userToken = token

    user = { username = 'iamadren' }

	SendReactMessage('setDashboardToken', token)

	SendReactMessage('setPage', 'CAD')

	TriggerEvent('adrenCAD:playerSetup', source)

	toggleNuiFrame(true)
end)

RegisterNUICallback('adrenCAD:setUserToken', function(data)
	TriggerServerEvent('adrenCAD:createDashboardToken', data.token)
end)

RegisterNUICallback('adrenCAD:fetchCommunityId', function()
	TriggerServerEvent('adrenCAD:fetchCommunityId')
end)

RegisterNetEvent('adrenCAD:setCommunityId')
AddEventHandler('adrenCAD:setCommunityId', function(data)
    SendReactMessage('setCommunityId', data.communityId)
end)

RegisterNetEvent('adrenCAD:setIdentifier')
AddEventHandler('adrenCAD:setIdentifier', function(data)
    local identifier = data.identifier

    if data.loginType == 'discord' then
        SendReactMessage('discordLogin', identifier)
    elseif data.loginType == 'steam' then
        SendReactMessage('steamLogin', identifier)
    end
end)

RegisterNUICallback('discordLogin', function(data)
	TriggerServerEvent('adrenCAD:createIdentifier', 'discord')
end)

RegisterNUICallback('steamLogin', function(data)
	TriggerServerEvent('adrenCAD:createIdentifier', 'steam')
end)

function setPed()
    local model = GetHashKey('s_m_y_sheriff_01')

    RequestModel(model)
    
    while not HasModelLoaded(model) do
        Wait(1)
    end

    SetPlayerModel(PlayerId(), model)
    
    SetPedDefaultComponentVariation(PlayerPedId())

    SetModelAsNoLongerNeeded(model)
end

local animationDict = "amb@world_human_smoking@male@male_a@base"
local animationName = "base"

-- Function to play the smoke animation
function playSmokeAnimation()
    local playerPed = GetPlayerPed(-1)
    RequestAnimDict(animationDict)
    while not HasAnimDictLoaded(animationDict) do
        Citizen.Wait(0)
    end
    TaskPlayAnim(playerPed, animationDict, animationName, 8.0, -8.0, -1, 1, 0, false, false, false)
end


RegisterNUICallback('spawn', function(station)
	math.randomseed(GetGameTimer())

    local spawnLocation = nil

    if station.civilian then
        spawnLocation = station.coord
    else 
        spawnLocation = station.spawns[math.random(1, #station.spawns)] 
    end

    local _sitting = spawnLocation.sitting

    local _smoking = spawnLocation.smoking

    toggleNuiFrame(false)

	SendReactMessage('setPage', nil)

	IsChoosing = false

	local pos = spawnLocation

    setPed()

    SetTimecycleModifier('default')
    SetEntityCoords(GetPlayerPed(-1), pos.x, pos.y, pos.z)

    Citizen.Wait(50)

    DoScreenFadeIn(500)

    Citizen.Wait(500)

    SetNuiFocus(false, false)

    cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -1355.93,-1487.78,520.75, 300.00,0.00,0.00, 100.00, false, 0)

    PointCamAtCoord(cam2, pos.x,pos.y,pos.z+200)

    SetCamActiveWithInterp(cam2, cam, 900, true, true)

    Citizen.Wait(900)

    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", pos.x,pos.y,pos.z+200, 300.00,0.00,0.00, 100.00, false, 0)

    PointCamAtCoord(cam, pos.x,pos.y,pos.z+2)
    SetCamActiveWithInterp(cam, cam2, 3700, true, true)

    FreezeEntityPosition(GetPlayerPed(-1), false)
    SetEntityCoords(GetPlayerPed(-1), pos.x, pos.y, pos.z)    
    
    if _sitting then
        TriggerEvent('adrenCAD:sit')
    end

    if _smoking then
        playSmokeAnimation()
    end

    Citizen.Wait(3700)

    PlaySoundFrontend(-1, "Zoom_Out", "DLC_HEIST_PLANNING_BOARD_SOUNDS", 1)
    RenderScriptCams(false, true, 500, true, true)
    PlaySoundFrontend(-1, "CAR_BIKE_WHOOSH", "MP_LOBBY_SOUNDS", 1)

    Citizen.Wait(500)

    SetCamActive(cam, false)
    DestroyCam(cam, true)

    IsChoosing = false

    DisplayHud(true)
    DisplayRadar(true)
    
    if station.civilian then
        SetEntityHeading(PlayerPedId(), pos.w)
    else
        SetEntityHeading(PlayerPedId(), pos.h)
    end

    if _sitting then
        hintToDisplay('Press F to stand up, Press X too access the MDT')
    end

    if _smoking then
        hintToDisplay('Press F to stop smoking')
    end

    sitting = _sitting

    smoking = _smoking

    spawned = true

    SendReactMessage('setSpawned', true)
end)

RegisterNUICallback('unauthorizedLogin', function(data)
	toggleNuiFrame(true)
		
	SendReactMessage('setPage', 'login')
end)

AddEventHandler('adrenCAD:fetchUser', function(cb)
    TriggerEvent(cb, {
        user = user
    })
end)

RegisterCommand('login', function()
	if user then 
		toggleNuiFrame(true)

		return SendReactMessage('setPage', 'CAD') 
	end

	TriggerEvent('adrenCAD:loginPlayer')
end)

RegisterCommand('logout', function()
	user = nil
end)

local cam, cam2 = nil, nil

local IsChoosing = true

-- Citizen.CreateThread(function ()
--     while true do
--         Citizen.Wait(0)

--         if IsChoosing then
--             DisplayHud(false)
--             DisplayRadar(false)
-- 		else
-- 			DisplayHud(true)
--             DisplayRadar(true)
--         end
--     end
-- end)

AddEventHandler('adrenCAD:loginPlayer', function()
    -- ShutdownLoadingScreen()

	-- Citizen.Wait(100)

	-- DoScreenFadeOut(10)

	-- while not IsScreenFadedOut() do
    --     Citizen.Wait(10)
    -- end

	-- SetTimecycleModifier('hud_def_blur')

	-- FreezeEntityPosition(GetPlayerPed(-1), true)

	-- cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -1355.93,-1487.78,520.75, 300.00,0.00,0.00, 100.00, false, 0)

	-- SetCamActive(cam, true)

	-- RenderScriptCams(true, false, 1, true, true)

    -- DoScreenFadeIn(500)
    
	-- Citizen.Wait(500)

    SetNuiFocus(true, true)

	toggleNuiFrame(true)
		
	SendReactMessage('setPage', 'login')
end)

RegisterNUICallback('enableCinamatic', function()
    ShutdownLoadingScreen()

	Citizen.Wait(100)

	FreezeEntityPosition(GetPlayerPed(-1), true)

	cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -1355.93,-1487.78,520.75, 300.00,0.00,0.00, 100.00, false, 0)

	SetCamActive(cam, true)

	RenderScriptCams(true, false, 1, true, true)

    DoScreenFadeIn(500)
    
	Citizen.Wait(550)

    SetNuiFocus(true, true)
end)

-- Do not edit.

AddEventHandler('fetchAdrenCADConfig', function(cb)
    TriggerEvent(cb, Config)
end)
