--[[
Project: VitaOnline
File: Mower-server.lua
Author(s):	Golf_R32
			Sebihunter
]]--

local miniMissionMower = {}
function loadMowerBikes()
miniMissionMower[1] = createRPGVehicle(572,1426.390625, 2811.0458984375, 9.388384819031,0  ,"Niemand",{{132,4,516},{132,4,516},{0,0,0},{0,0,0}},true,false)
miniMissionMower[2] = createRPGVehicle(572,1422.185546875, 2809.9873046875, 9.392434120178,0 ,"Niemand",{{38,55,57},{38,55,57},{0,0,0},{0,0,0}},true,false)
	for i = 1,#miniMissionMower do
		setElementData( miniMissionMower[i], "doNotLooseFuel", true)
		toggleVehicleRespawn( miniMissionMower[i], true )
		setVehicleIdleRespawnDelay ( miniMissionMower[i], 60000 )
		setElementData( miniMissionMower[i], "shallRespawn", true)
	end		
end	
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), loadMowerBikes)