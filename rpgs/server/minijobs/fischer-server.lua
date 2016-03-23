--[[
Project: VitaOnline
File: fischer-server.lua
Author(s):	Golf_R32
			Sebihunter
]]--

local miniMissionFischer = {}
function createFischerJobVehicle()
	--Hafen SF
	miniMissionFischer[1] = createRPGVehicle(453,-1717.498046875, 1431.173828125, -0.34857136011124, 270,"FISCH",{{42,119,161},{42,119,161},{0,0,0},{0,0,0}},true,false)
	miniMissionFischer[2] = createRPGVehicle(453,-1717.498046875, 1437.173828125, -0.34857136011124, 270,"FISCH",{{189,190,198},{189,190,198},{0,0,0},{0,0,0}},true,false)
	miniMissionFischer[3] = createRPGVehicle(453,-1717.498046875, 1443.173828125, -0.34857136011124, 270,"FISCH",{{245,245,245},{245,245,245},{0,0,0},{0,0,0}},true,false)
	miniMissionFischer[4] = createRPGVehicle(453,-1717.498046875, 1449.173828125, -0.34857136011124, 270,"FISCH",{{38,55,57},{38,55,57},{0,0,0},{0,0,0}},true,false)


	for i = 1,#miniMissionFischer do
		setElementData( miniMissionFischer[i], "doNotLooseFuel", true)
		toggleVehicleRespawn( miniMissionFischer[i], true )
		setVehicleIdleRespawnDelay ( miniMissionFischer[i], 60000 )
		setElementData( miniMissionFischer[i], "shallRespawn", true)
	end		
end	
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), createFischerJobVehicle)
