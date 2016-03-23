--[[
Project: VitaOnline
File: Bus-server.lua
Author(s):	Golf_R32
			Sebihunter
]]--

local miniMissionBus = {}

function createBusJobVehicle()
--Depot
miniMissionBus[#miniMissionBus+1] = createRPGVehicle(431, 1090.2998046875,  2321.7001953125, 10.89999961853, 344.73999023438  ,"MVB",{{245,245,245},{132,4,16},{0,0,0},{0,0,0}},true,false)
miniMissionBus[#miniMissionBus+1] = createRPGVehicle(431, 1085.599609375,  2321.7001953125, 10.89999961853, 344.73999023438  ,"MVB",{{245,245,245},{132,4,16},{0,0,0},{0,0,0}},true,false)
miniMissionBus[#miniMissionBus+1] = createRPGVehicle(431, 1080.7998046875,  2321.7001953125, 10.89999961853, 344.73999023438  ,"MVB",{{245,245,245},{132,4,16},{0,0,0},{0,0,0}},true,false)
miniMissionBus[#miniMissionBus+1] = createRPGVehicle(431, 1076.099609375,  2321.7001953125, 10.89999961853, 344.73999023438  ,"MVB",{{245,245,245},{132,4,16},{0,0,0},{0,0,0}},true,false)
miniMissionBus[#miniMissionBus+1] = createRPGVehicle(431, 1071.2998046875,  2321.7001953125, 10.89999961853, 344.73999023438  ,"MVB",{{245,245,245},{132,4,16},{0,0,0},{0,0,0}},true,false)
miniMissionBus[#miniMissionBus+1] = createRPGVehicle(431, 1066.5,  2321.7001953125, 10.89999961853, 344.73999023438  ,"MVB",{{245,245,245},{132,4,16},{0,0,0},{0,0,0}},true,false)
miniMissionBus[#miniMissionBus+1] = createRPGVehicle(431, 1061.7998046875,  2321.7001953125, 10.89999961853, 344.73999023438  ,"MVB",{{245,245,245},{132,4,16},{0,0,0},{0,0,0}},true,false)
miniMissionBus[#miniMissionBus+1] = createRPGVehicle(431, 1057.2001953125,  2321.7001953125, 10.89999961853, 344.73999023438  ,"MVB",{{245,245,245},{132,4,16},{0,0,0},{0,0,0}},true,false)
miniMissionBus[#miniMissionBus+1] = createRPGVehicle(431, 1052.599609375,  2321.7001953125, 10.89999961853, 344.73999023438  ,"MVB",{{245,245,245},{132,4,16},{0,0,0},{0,0,0}},true,false)
miniMissionBus[#miniMissionBus+1] = createRPGVehicle(431, 1047.9000244141,  2321.7001953125, 10.89999961853, 344.73999023438  ,"MVB",{{245,245,245},{132,4,16},{0,0,0},{0,0,0}},true,false)

	for i = 1,#miniMissionBus do
		local randint = math.random(0,2)
		setVehicleVariant ( miniMissionBus[i], randint,randint )
		setElementData( miniMissionBus[i], "doNotLooseFuel", true)
		setElementData(miniMissionBus[i], "shallRespawn", true)
		toggleVehicleRespawn( miniMissionBus[i], true )
		setVehicleIdleRespawnDelay ( miniMissionBus[i], 60000 )
		setElementData( miniMissionBus[i], "shallRespawn", true)
	end		
end	
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), createBusJobVehicle)

function respawnBus(veh)
	for i,v in pairs(getVehicleOccupants ( veh )) do
		removePedFromVehicle(v)
		if i == 0 then
			setElementPosition(v,1080.8980,2384.600,11)
		end
	end
	respawnVehicle(veh)
end

function onBusShaderReceive ( veh, shader, line )
	if isElement(veh) then
		setElementData(veh, "setShader", {shader, line})
		if shader == false then
			callClientFunction(getRootElement(), "removeBusShader", veh)
		else
			callClientFunction(getRootElement(), "setBusShader", veh, shader, line)
		end
	end
end
 
addEvent ( "onBusShaderReceive", true )
addEventHandler ( "onBusShaderReceive", getRootElement(), onBusShaderReceive )

function onBusAnnouncement ( veh, stop, line, terminates )
	if isElement(veh) then
		for i,v in pairs(getVehicleOccupants ( veh )) do
			callClientFunction(v, "playBusAnnouncement", stop, line, terminates)
		end
	end
end
 
addEvent ( "onBusAnnouncement", true )
addEventHandler ( "onBusAnnouncement", getRootElement(), onBusAnnouncement )

 
function startEnteringBus ( player, seat, jacked, door )
	if (getElementModel(source) == 431 or getElementModel(source) == 437) and door == 0 and jacked and isElement(jacked) then --Bus & Coach
		cancelEvent()
	end
end
addEventHandler ( "onVehicleStartEnter", getRootElement(), startEnteringBus ) --add an event handler for onVehicleStartEnter

--[[
--Sonderlinie
addCommandHandler ( "sonderlinie_start", function(source)
	local veh = getPedOccupiedVehicle(source)
	if veh then
		onBusShaderReceive ( veh, "sonder", "l_son" )
	end
end )

addCommandHandler ( "sans", function(source, name, station)
	local veh = getPedOccupiedVehicle(source)
	if veh then
		for i,v in pairs(getVehicleOccupants ( veh )) do
			callClientFunction(v, "playSound", "http://vita-online.eu/"..station..".mp3")
		end
	end
end )]]