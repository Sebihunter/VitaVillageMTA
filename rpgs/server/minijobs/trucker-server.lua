--[[
Project: VitaOnline
File: trucker-server.lua
Author(s):	Golf_R32
			Sebihunter
]]--

local miniMissionBension = {}

addEvent("giveTheMiniMissionPrize",true)
addEventHandler("giveTheMiniMissionPrize", getRootElement(),
	function(source,preis)
		givePlayerMoneyEx(source, tonumber(preis))
		setElementData(source, "exp", getElementData(source, "exp")+math.floor(preis/10))
	end
)

function loadPizzaBikes()
miniMissionBension[1] = createRPGVehicle(499,1034.3594970703,2097.8405761719,10.547338485718,272.35992431641 ,"Niemand",{{245,245,245},{245,245,245},{0,0,0},{0,0,0}},true,false)
miniMissionBension[2] = createRPGVehicle(499,1034.3594970703,2100.8405761719,10.547338485718,272.35992431641  ,"Niemand",{{94,112,114},{94,112,114},{0,0,0},{0,0,0}},true,false)
miniMissionBension[3] = createRPGVehicle(499,1034.3594970703,2103.8405761719,10.547338485718,272.35992431641 ,"Niemand",{{215,142,16},{94,112,114},{0,0,0},{0,0,0}},true,false)
miniMissionBension[4] = createRPGVehicle(499,1034.3594970703,2106.8405761719,10.547338485718,272.35992431641  ,"Niemand",{{76,117,183},{76,117,183},{0,0,0},{0,0,0}},true,false)
miniMissionBension[5] = createRPGVehicle(499,1034.3594970703,2109.8405761719,10.547338485718,272.35992431641 ,"Niemand",{{189,190,198},{189,190,198},{0,0,0},{0,0,0}},true,false)
	for i = 1,#miniMissionBension do
		setElementData( miniMissionBension[i], "doNotLooseFuel", true)
		toggleVehicleRespawn( miniMissionBension[i], true )
		setVehicleIdleRespawnDelay ( miniMissionBension[i], 60000 )
		setElementData( miniMissionBension[i], "shallRespawn", true)
	end		
end	
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), loadPizzaBikes)