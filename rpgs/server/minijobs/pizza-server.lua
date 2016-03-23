--[[
Project: VitaOnline
File: pizza-server.lua
Author(s):	Golf_R32
			Sebihunter
]]--

local miniMissionPizza = {}

function loadPizzaBikes()
miniMissionPizza[1] = createRPGVehicle(574,2281.9565429688,2526.9523925781,10.537092208862,179.88629150391 ,"Pizza",{{42,119,161},{42,119,161},{0,0,0},{0,0,0}},true,false)
miniMissionPizza[2] = createRPGVehicle(574,2281.9565429688,2531.9523925781,10.537092208862,179.88629150391  ,"Pizza",{{132,4,516},{132,4,516},{0,0,0},{0,0,0}},true,false)
miniMissionPizza[3] = createRPGVehicle(574,2281.9565429688,2536.9523925781,10.537092208862,179.88629150391 ,"Pizza",{{38,55,57},{38,55,57},{0,0,0},{0,0,0}},true,false)
miniMissionPizza[4] = createRPGVehicle(574,2281.9565429688,2541.9523925781,10.537092208862,179.88629150391  ,"Pizza",{{134,68,110},{134,68,110},{0,0,0},{0,0,0}},true,false)
miniMissionPizza[5] = createRPGVehicle(574,2281.9565429688,2546.9523925781,10.537092208862,179.88629150391 ,"Pizza",{{42,119,161},{42,119,161},{0,0,0},{0,0,0}},true,false)
miniMissionPizza[6] = createRPGVehicle(574,2281.9565429688,2551.9523925781,10.537092208862,179.88629150391  ,"Pizza",{{245,245,245},{132,4,16},{0,0,0},{0,0,0}},true,false)
miniMissionPizza[7] = createRPGVehicle(574,2281.9565429688,2556.9523925781,10.537092208862,179.88629150391 ,"Pizza",{{215,146,16},{215,146,16},{0,0,0},{0,0,0}},true,false)
miniMissionPizza[8] = createRPGVehicle(574,2281.9565429688,2561.9523925781,10.537092208862,179.88629150391  ,"Pizza",{{134,68,110},{134,68,110},{0,0,0},{0,0,0}},true,false)

--SF
--[[miniMissionPizza[1] = createRPGVehicle(574,-1805.0284423828,950.25555419922,23.560844421387,247.43536376953 ,"Niemand",{{42,119,161},{42,119,161},{0,0,0},{0,0,0}},true,false)
miniMissionPizza[2] = createRPGVehicle(574,-1805.0559082031,952.2470703125,23.560844421387,247.43383789063  ,"Niemand",{{132,4,516},{132,4,516},{0,0,0},{0,0,0}},true,false)
miniMissionPizza[3] = createRPGVehicle(574,-1805.0336914063,954.27154541016,23.560844421387,247.43383789063 ,"Niemand",{{38,55,57},{38,55,57},{0,0,0},{0,0,0}},true,false)
miniMissionPizza[4] = createRPGVehicle(574,-1804.9875488281,956.12341308594,23.560844421387,247.43383789063  ,"Niemand",{{134,68,110},{134,68,110},{0,0,0},{0,0,0}},true,false)
miniMissionPizza[5] = createRPGVehicle(574,-1805.0284423828,958.25555419922,23.560844421387,247.43536376953 ,"Niemand",{{42,119,161},{42,119,161},{0,0,0},{0,0,0}},true,false)
miniMissionPizza[6] = createRPGVehicle(574,-1805.0559082031,960.2470703125,23.560844421387,247.43383789063  ,"Niemand",{{245,245,245},{132,4,16},{0,0,0},{0,0,0}},true,false)
miniMissionPizza[7] = createRPGVehicle(574,-1805.0336914063,962.27154541016,23.560844421387,247.43383789063 ,"Niemand",{{38,55,57},{38,55,57},{0,0,0},{0,0,0}},true,false)
miniMissionPizza[8] = createRPGVehicle(574,-1804.9875488281,966.12341308594,23.560844421387,247.43383789063  ,"Niemand",{{134,68,110},{134,68,110},{0,0,0},{0,0,0}},true,false)
miniMissionPizza[9] = createRPGVehicle(574,-1804.9875488281,968.12341308594,23.560844421387,247.43383789063  ,"Niemand",{{115,14,26},{115,14,26},{0,0,0},{0,0,0}},true,false)
miniMissionPizza[10] = createRPGVehicle(574,-1804.9875488281,970.12341308594,23.560844421387,247.43383789063  ,"Niemand",{{215,146,16},{215,146,16},{0,0,0},{0,0,0}},true,false)
miniMissionPizza[11] = createRPGVehicle(574,-1804.9875488281,972.12341308594,23.560844421387,247.43383789063  ,"Niemand",{{76,117,183},{76,117,183},{0,0,0},{0,0,0}},true,false)
miniMissionPizza[12] = createRPGVehicle(574,-1804.9875488281,974.12341308594,23.560844421387,247.43383789063  ,"Niemand",{{189,180,198},{189,180,198},{0,0,0},{0,0,0}},true,false)
miniMissionPizza[13] = createRPGVehicle(574,-1804.9875488281,976.12341308594,23.560844421387,247.43383789063  ,"Niemand",{{94,112,14},{94,112,14},{0,0,0},{0,0,0}},true,false)
miniMissionPizza[14] = createRPGVehicle(574,-1804.9875488281,978.12341308594,23.560844421387,247.43383789063  ,"Niemand",{{70,89,122},{70,89,122},{0,0,0},{0,0,0}},true,false)
miniMissionPizza[15] = createRPGVehicle(574,-1804.9875488281,980.12341308594,23.560844421387,247.43383789063  ,"Niemand",{{101,106,121},{101,106,121},{0,0,0},{0,0,0}},true,false)
miniMissionPizza[16] = createRPGVehicle(574,-1804.9875488281,982.12341308594,23.560844421387,247.43383789063  ,"Niemand",{{93,126,141},{93,126,141},{0,0,0},{0,0,0}},true,false)
miniMissionPizza[17] = createRPGVehicle(574,-1804.9875488281,984.12341308594,23.560844421387,247.43383789063  ,"Niemand",{{88,89,90},{88,89,90},{0,0,0},{0,0,0}},true,false)
miniMissionPizza[18] = createRPGVehicle(574,-1804.9875488281,986.12341308594,23.560844421387,247.43383789063  ,"Niemand",{{52,26,30},{52,26,30},{0,0,0},{0,0,0}},true,false)
miniMissionPizza[19] = createRPGVehicle(574,-1804.9875488281,988.12341308594,23.560844421387,247.43383789063  ,"Niemand",{{156,161,163},{156,161,163},{0,0,0},{0,0,0}},true,false)
miniMissionPizza[20] = createRPGVehicle(574,-1804.9875488281,990.12341308594,23.560844421387,247.43383789063  ,"Niemand",{{51,95,63},{51,95,63},{0,0,0},{0,0,0}},true,false)]]
	for i = 1,#miniMissionPizza do
		setElementData( miniMissionPizza[i], "doNotLooseFuel", true)
		toggleVehicleRespawn( miniMissionPizza[i], true )
		setVehicleIdleRespawnDelay ( miniMissionPizza[i], 60000 )
		setVehicleHandling(miniMissionPizza[i], "engineAcceleration", 5)
		setVehicleHandling(miniMissionPizza[i], "maxVelocity", 200 )
		setElementData( miniMissionPizza[i], "shallRespawn", true)
	end		
end	
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), loadPizzaBikes)