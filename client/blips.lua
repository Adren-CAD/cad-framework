local function createBlip(blipType, station)
	local sprite, colour, label = nil

	if blipType == 'police' then
		label = 'Police Station'
		sprite = 60
		colour = 29
	elseif blipType == 'fire' then
		label = 'Fire Station'
		sprite = 60
		colour = 1
	elseif blipType == 'hospital' then
		label = 'Hospital'
		sprite = 61
		colour = 0
	end

	local blip = AddBlipForCoord(
		vector3(
			station.pos.x, 
			station.pos.y, 
			station.pos.z
		)
	)

	SetBlipScale(blip, Config.blips.scale)

	SetBlipDisplay(blip, 4)

	SetBlipSprite(blip, sprite)

	SetBlipColour(blip, colour)

	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')

	AddTextComponentSubstringPlayerName(label)

	EndTextCommandSetBlipName(blip)
end

if Config.enable_blips then
	CreateThread(function()
		for k, station in pairs(Config.police_stations) do
			createBlip('police', station)
		end

		for k, station in pairs(Config.fire_stations) do
			createBlip('fire', station)
		end
		
		for k, station in pairs(Config.hospitals) do
			createBlip('hospital', station)
		end
	end)
end