--[[
Project: VitaOnline
File: train-server.lua
Author(s):	Sebihunter
]]--


local trainData = {}
local firstRound = false
function loadTrainData()
	local xml = xmlLoadFile("xml/train.xml")
	local i = 0
	
	if xml then
		while true do
			local vehnode = xmlFindChild ( xml, "data", i)
			if not vehnode then
				break
			end
			if vehnode then
				local x = tonumber(xmlNodeGetAttribute(vehnode, "x"))
				local y = tonumber(xmlNodeGetAttribute(vehnode, "y"))
				local z = tonumber(xmlNodeGetAttribute(vehnode, "z"))
				local speed = tonumber(xmlNodeGetAttribute(vehnode, "speed"))
				trainData[#trainData+1] = {}
				
				if x < 0 then x = x + 1 else x = x - 1 end
				if y < 0 then y = y + 1 else y = y - 1 end
				trainData[#trainData].x = x
				trainData[#trainData].y = y
				trainData[#trainData].z = z
				trainData[#trainData].speed = speed
			end
			i = i+1
		end
		xmlUnloadFile(xml)
		print("__~~*"..tonumber(i).." train points loaded!*~~__")
		createNewTrain()
		setTimer(function()
			if firstRound == true then return end
			createNewTrain()
		end, 60000, 0)
	else
		print("__~~*Failed to load train points*~~__")
	end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), loadTrainData)
		
function createNewTrain()
	local train = createRPGVehicle(538,trainData[1].x,trainData[1].y,trainData[1].z,0,"MVB",{{255,255,255},{255,255,255},{0,0,0},{0,0,0}},true, false)
	setTrainDirection ( train,true )
	setTrainDerailable ( train, false )
	local ped = createPed ( 253, trainData[1].x,trainData[1].y,trainData[1].z )
	warpPedIntoVehicle ( ped, train )
	--createBlipAttachedTo ( train )
	local c1 = createRPGVehicle(570,trainData[1].x,trainData[1].y,trainData[1].z,0,"MVB",{{245,245,245},{134,68,110},{0,0,0},{0,0,0}},true, false)
	--local c2 = createRPGVehicle(570,trainData[1].x,trainData[1].y,trainData[1].z,0,"MVB",{{245,245,245},{134,68,110},{0,0,0},{0,0,0}},true, false)
	attachTrailerToVehicle ( train, c1 )
	--attachTrailerToVehicle ( c1, c2 )
	setElementData(train, "traindata", 2)
	setElementData(train, "atStation", 0)
	setTimer(function(train,c1,c2)
		local data = getElementData(train, "traindata")
		local station = getElementData(train, "atStation")
		if not trainData[data] then
			data = 1
			firstRound = true
		end
		detachTrailerFromVehicle(train, c1)
		--detachTrailerFromVehicle(c1, c2)
		
		setElementPosition(train, trainData[data].x, trainData[data].y, trainData[data].z)
		--setElementPosition(c1, trainData[data].x, trainData[data].y, trainData[data].z)
		--setElementPosition(c2, trainData[data].x, trainData[data].y, trainData[data].z)
		attachTrailerToVehicle ( train, c1 )
		--attachTrailerToVehicle ( c1, c2 )
		if station == 0 and getDistanceBetweenPoints2D(2030,-1956,trainData[data].x, trainData[data].y) < 10 then
			callClientFunction(getRootElement(), "playSound3DLoud", "sounds/zug.mp3", 1727,-1948,13)
			setElementData(train, "atStation", 1)
		elseif station == 1 and getDistanceBetweenPoints2D(1016.59,-1579.77,trainData[data].x, trainData[data].y) < 10 then
			setElementData(train, "atStation", 2)
			callClientFunction(getRootElement(), "playSound3DLoud", "sounds/zug.mp3", 824,-1361,0)
		elseif station == 2 and getDistanceBetweenPoints2D(-1958,-223,trainData[data].x, trainData[data].y) < 10 then
			setElementData(train, "atStation", 3)	
			callClientFunction(getRootElement(), "playSound3DLoud", "sounds/zug.mp3", -1957,153,27)
		elseif station == 3 and getDistanceBetweenPoints2D(-264.956,1267.250,trainData[data].x, trainData[data].y) < 10 then
			setElementData(train, "atStation", 4)
			callClientFunction(getRootElement(), "playSound3DLoud", "sounds/zug.mp3", -14,1289,18)
		elseif station == 4 and getDistanceBetweenPoints2D(1107,2700,trainData[data].x, trainData[data].y) < 10 then
			setElementData(train, "atStation", 5)
			callClientFunction(getRootElement(), "playSound3DLoud", "sounds/zug.mp3", 1430,2626,11)
		elseif station == 5 and getDistanceBetweenPoints2D(2779,2034,trainData[data].x, trainData[data].y) < 10 then
			setElementData(train, "atStation", 6)
			callClientFunction(getRootElement(), "playSound3DLoud", "sounds/zug.mp3", 2776,1769,11)
		elseif station == 6 and getDistanceBetweenPoints2D(2862,1529,trainData[data].x, trainData[data].y) < 10 then
			setElementData(train, "atStation", 0)	
			callClientFunction(getRootElement(), "playSound3DLoud", "sounds/zug.mp3", 2859,1282,11)			
		end
		setTrainSpeed(train, trainData[data].speed)
		setElementData(train, "traindata", data+1)
		setTrainDirection ( train,true )
	end, 100, 0, train,c1,c2)
end

addCommandHandler ( "traintest", function()
	createNewTrain()
	outputChatBox("traintest")
end)