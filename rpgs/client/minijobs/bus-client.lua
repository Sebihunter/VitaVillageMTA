--[[
Project: VitaRP
File: bus-client.lua
Author(s):	Sebihunter
]]--


--http://onair-ha1.krone.at/kronehit-vollgas.mp3.m3u
setElementData(getLocalPlayer(), "busLine", nil)
setElementData(getLocalPlayer(), "busAt", nil)

BusGUI_Window = {}
BusGUI_Button = {}
BusGUI_Grid = {}
BusGUI_Column = {}


BusGUI_Window[1] = guiCreateWindow(screenWidth/2-155,screenHeight/2-202,289,403,"Dienst Starten",false)
BusGUI_Button[1] = guiCreateButton(179,379,101,15,"Schliessen",false,BusGUI_Window[1])
BusGUI_Button[2] = guiCreateButton(16,379,101,15,"Starten",false,BusGUI_Window[1])
BusGUI_Grid[1] = guiCreateGridList(16,33,264,336,false,BusGUI_Window[1])
guiGridListSetSelectionMode(BusGUI_Grid[1],1)
BusGUI_Column[1] = guiGridListAddColumn ( BusGUI_Grid[1], "Linie", 0.80 )
guiSetVisible( BusGUI_Window[1], false)
guiWindowSetSizable ( BusGUI_Window[1], false )

for i,v in ipairs(gBusLines) do
	local row = guiGridListAddRow ( BusGUI_Grid[1] )
	guiGridListSetItemText ( BusGUI_Grid[1], row, 1, "Linie "..i, false, false )
end

BusGUI_Window[2] = guiCreateWindow(screenWidth/2-100,screenHeight/2-25,200,70,"Busfahrer",false)
BusGUI_Button[3] = guiCreateButton(5,20,90,40,"Weiterfahren",false,BusGUI_Window[2])
BusGUI_Button[4] = guiCreateButton(105,20,90,40,"Beenden",false,BusGUI_Window[2])
guiWindowSetSizable ( BusGUI_Window[2], false )
guiSetVisible( BusGUI_Window[2], false)


local thebus = createObject(4735, 1066.6, 2359.7, 12.9,0,0,90.5)
setObjectScale(thebus, 0.2)
setElementCollisionsEnabled (thebus,false )
setElementDoubleSided (thebus,true )
replaceTexture(thebus, "diderSachs01", "images/dider_bus.jpg")

thebus = createObject(4735,1070.7998, 2359.7, 12.9,0,0,90.5)
setObjectScale(thebus, 0.2)
setElementDoubleSided (thebus,true )
setElementCollisionsEnabled (thebus,false )
replaceTexture(thebus, "diderSachs01", "images/dider_bus_2.jpg")


--thebus = createObject(3435,1097.400390625, 2329.1005859375, 15.199999809265,0,0,319.99877929688)
thebus = createObject(11352,1070.234375, 2370.5791015625, 13.967000007629,0,0,90)


local busData = false
local screenWidth, screenHeight = guiGetScreenSize()
local busDisplays = {
	[1] = {"1_lvn", "1_bus"},
	[2] = {"2_stadion", "2_yellow"},
	[3] = {"3_lastdime", "3_baseballstadion"},
	[4] = {"4_air", "4_lvo"},
	[5] = {"5_randolph", "5_linden"},
	[6] = {"6_fc", "6_air"}
}

function closeBus()
	guiSetVisible( BusGUI_Window[1], false)
	setElementFrozen ( getLocalPlayer(), false )
	callServerFunction("removePedFromVehicle", getLocalPlayer())
	showCursor(false)
end
addEventHandler ( "onClientGUIClick", BusGUI_Button[1], closeBus, false )


function choseBus()
	local selectedRow, selectedCol = guiGridListGetSelectedItem( BusGUI_Grid[1] )
	if selectedRow and selectedRow ~= -1 then
		startBusLine(selectedRow+1)
	end
end	
addEventHandler ( "onClientGUIClick", BusGUI_Button[2], choseBus, false)

function weiterBus()
	guiSetVisible( BusGUI_Window[2], false)
	setElementFrozen ( getLocalPlayer(), false )
	showCursor(false)
end
addEventHandler ( "onClientGUIClick", BusGUI_Button[3], weiterBus, false )


function beendenBus()
	givePlayerMoneyEx(busData.money)
	setElementData(getLocalPlayer(), "exp", getElementData(getLocalPlayer(), "exp")+math.floor(busData.money/10))
	callServerFunction("respawnBus", busData.veh)
	addNotification(3, 255,100,0, "Du hast den Busfahrer Dienst beendet.\nLohn: "..busData.money.." Vero")
	guiSetVisible( BusGUI_Window[2], false)
	stopBusLine()
	setElementFrozen ( getLocalPlayer(), false )
	showCursor(false)	
end	
addEventHandler ( "onClientGUIClick", BusGUI_Button[4], beendenBus, false)

addEventHandler("onClientVehicleEnter", getRootElement(),
	function(theplayer,seat)
		if theplayer == getLocalPlayer() and seat == 0 and busData and busData.veh ~= source then
			callServerFunction("removePedFromVehicle", getLocalPlayer())
		end
		if theplayer == getLocalPlayer() and seat == 0 and busData == false then
			if getElementModel(source) == 431 then
				guiSetVisible( BusGUI_Window[1], true)
				setElementFrozen ( getLocalPlayer(), true )
				showCursor(true)
			end
		end
	end
)
addEventHandler("onClientPlayerWasted", getLocalPlayer(),
	function()
		if busData == false then return end
		stopBusLine()
	end
)

function startBusLine(line)
	local veh = getPedOccupiedVehicle(getLocalPlayer())
	if not isElement(veh) and getElementModel(veh) == 431 then return end
	if getElementData(getLocalPlayer(), "dienst") == 1 then addNotification(1, 255, 0, 0, "Du kannst keinen Nebenjob beginnen\nwenn du im Dienst bist.") return end
	if busData == false and gBusLines[line] then
		setElementFrozen ( getLocalPlayer(), false )
		guiSetVisible( BusGUI_Window[1], false)
		showCursor(false)	
		
		--Teleport Stuff
		if line == 2 then
			setElementPosition(veh, 1387.6788330078,2538.0627441406,10.66478309631)
			setElementRotation(veh, 0,0,359.11871337891)
		elseif line == 3 then
			setElementPosition(veh, 1308.6804199219,2086.1147460938,10.813708877563)
			setElementRotation(veh, 0,0,179.54321289063)
		elseif line == 4 then
			setElementPosition(veh, 2611.6940917969,2022.6341552734,10.71311855316)
			setElementRotation(veh, 0,0,179.54321289063)
		elseif line == 5 then
			setElementPosition(veh, 2826.7009277344, 1252.9790039063, 11.017000198364)
			setElementRotation(veh, 0,0,0)
		elseif line == 6 then
			setElementPosition(veh, 1682.7467041016,1255.6385498047,10.249607086182)
			setElementRotation(veh, 0,0,270)		
		end
	
		busData = {}
		local x, y, _ = getElementPosition(getLocalPlayer())
		busData.stations = 0
		busData.pos = {x, y}
		busData.line = line
		busData.nextNumber = 1
		setElementData(getLocalPlayer(), "busLine", line)
		setElementData(getLocalPlayer(), "busAt", 1)
		busData.stopAllowed = true
		busData.terminates = false
		busData.nowstop = false
		busData.veh = veh
		busData.money = 0
		busData.text = ""
		busData.timer = setTimer(busTimer, 100,0)
		if type(gBusLines[line][1]) == "table" then
			busData.terminates = true
			busData.nextStop = gBusLines[line][1][1]
		else
			busData.nextStop = gBusLines[line][1]
		end
		addEventHandler("onClientRender", getRootElement(), busRender)
		busData.marker = createMarker ( gBusStops[busData.nextStop].obj[1], gBusStops[busData.nextStop].obj[2], gBusStops[busData.nextStop].obj[3]+3, "arrow", 1, 255,0,255,255 )
		busData.blip = createBlip ( gBusStops[busData.nextStop].obj[1], gBusStops[busData.nextStop].obj[2], gBusStops[busData.nextStop].obj[3], 0, 2, 255, 0, 255, 255)
		--triggerServerEvent ( "onBusAnnouncement", getLocalPlayer(), busData.veh, busData.nextStop, busData.line, busData.terminates )
		triggerServerEvent ( "onBusShaderReceive", getLocalPlayer(), veh, busDisplays[line][1], "line_"..line )
		showPlayerHudComponent ( "radar", true )
		showTutorialMessage("bus_1", "Fahre die verschiedenen Stationen ab (auf der Karte markiert) und halte neben den Haltestellen für einige Sekunden an.")
		showTutorialMessage("bus_2", "Um den Job mit XP und Geld zu beenden musst du die komplette Route abfahren.")
	end
end

function busTimer()
	local veh = getPedOccupiedVehicle(getLocalPlayer())
	if veh and veh == busData.veh then
		if busData.outTimer and  isTimer(busData.outTimer) then killTimer(busData.outTimer) busData.text = "" end
		local vx,vy,vz = getElementVelocity ( veh )
		local x,y,z = getElementPosition(veh)
		if vx == 0 and vy == 0 and vz == 0 then
			if (not isTimer(busData.stopTimer) or not busData.stopTimer) and getDistanceBetweenPoints3D(x,y,z, gBusStops[busData.nextStop].obj[1], gBusStops[busData.nextStop].obj[2], gBusStops[busData.nextStop].obj[3]) < 15  then
				busData.stopTimer = setTimer(nextBusStation, 5000, 1)
				busData.text = "Bitte Warten..."
			end
		else
			if busData.stopTimer and isTimer(busData.stopTimer) then killTimer(busData.stopTimer) busData.text = "" end
		end
	else
		if (not busData.outTimer or not isTimer(busData.outTimer)) then
			busData.outTimer = setTimer(stopBusLine, 20000, 1)
		elseif isTimer(busData.outTimer) then
			local i,_,_ = getTimerDetails ( busData.outTimer )
			busData.text = "Job abgebrochen in: "..math.round(i/1000)
		end
		if busData.stopTimer and isTimer(busData.stopTimer) then killTimer(busData.stopTimer) end
	end
end

local isLast = false
function nextBusStation()
	setElementData(getLocalPlayer(), "busAt", busData.nextNumber)
	busData.pos = {gBusStops[busData.nextStop].obj[1], gBusStops[busData.nextStop].obj[2]}
	if busData.nowstop == true then
		guiSetVisible( BusGUI_Window[2], true)
		setElementFrozen ( getLocalPlayer(), true )
		showCursor(true)
	end
	if isLast == true then
		busData.nowstop = false
	end	
	if not gBusLines[busData.line][busData.nextNumber+1] then
		isLast = true
		busData.nextNumber = 0
		busData.nowstop = true
	end
	busData.text = ""
	busData.money = busData.money + math.round(120*getElementHealth(busData.veh)/1000)
	busData.stations = busData.stations +1
	busData.terminates = false
	busData.nextNumber = busData.nextNumber+1
	if type(gBusLines[busData.line][busData.nextNumber]) == "table" then
		busData.nextStop = gBusLines[busData.line][busData.nextNumber][1]
		busData.terminates = true
	else
		busData.nextStop = gBusLines[busData.line][busData.nextNumber]
	end
	busData.stopAllowed = false
	if isElement(busData.marker) then destroyElement(busData.marker) end
	if isElement(busData.blip) then destroyElement(busData.blip) end
	busData.marker = createMarker ( gBusStops[busData.nextStop].obj[1], gBusStops[busData.nextStop].obj[2], gBusStops[busData.nextStop].obj[3]+3, "arrow", 1, 255,0,255,255 )
	busData.blip = createBlip ( gBusStops[busData.nextStop].obj[1], gBusStops[busData.nextStop].obj[2], gBusStops[busData.nextStop].obj[3], 0, 2, 255, 0, 255, 255)
end

function stopBusLine()
	if busData == false then return end
	if isElement(busData.marker) then destroyElement(busData.marker) end
	if isElement(busData.blip) then destroyElement(busData.blip) end
	triggerServerEvent ( "onBusShaderReceive", getLocalPlayer(), busData.veh, false	)
	removeEventHandler("onClientRender", getRootElement(), busRender)
	showPlayerHudComponent ( "radar", false )
	if isTimer(busData.timer) then killTimer(busData.timer) end
	if busData.stopTimer and isTimer(busData.stopTimer) then killTimer(busData.stopTimer) end
	if busData.outTimer and  isTimer(busData.outTimer) then killTimer(busData.outTimer) end
	busData = false
	setElementData(getLocalPlayer(), "busLine", nil)
	setElementData(getLocalPlayer(), "busAt", nil)
end

function busRender()
	local x, y, _ = getElementPosition(getLocalPlayer())

	dxDrawText("Erreichte Stationen: "..busData.stations.." ("..busData.money.." Vero)\n"..busData.text, 5,0,screenWidth, screenHeight*0.25,tocolor(0,0,0,255), 1.4, "bankgothic", "center", "center",true,true,true)
	dxDrawText("Erreichte Stationen: "..busData.stations.." ("..busData.money.." Vero)\n"..busData.text, 0,5,screenWidth, screenHeight*0.25,tocolor(0,0,0,255), 1.4, "bankgothic", "center", "center",true,true,true)
	dxDrawText("Erreichte Stationen: "..busData.stations.." ("..busData.money.." Vero)\n"..busData.text, 0,-5,screenWidth, screenHeight*0.25,tocolor(0,0,0,255), 1.4, "bankgothic", "center", "center",true,true,true)
	dxDrawText("Erreichte Stationen: "..busData.stations.." ("..busData.money.." Vero)\n"..busData.text, -5,0,screenWidth, screenHeight*0.25,tocolor(0,0,0,255), 1.4, "bankgothic", "center", "center",true,true,true)

	dxDrawText("Erreichte Stationen: "..busData.stations.." ("..busData.money.." Vero)\n"..busData.text, 5,5,screenWidth, screenHeight*0.25,tocolor(0,0,0,255), 1.4, "bankgothic", "center", "center",true,true,true)
	dxDrawText("Erreichte Stationen: "..busData.stations.." ("..busData.money.." Vero)\n"..busData.text, -5,5,screenWidth, screenHeight*0.25,tocolor(0,0,0,255), 1.4, "bankgothic", "center", "center",true,true,true)
	dxDrawText("Erreichte Stationen: "..busData.stations.." ("..busData.money.." Vero)\n"..busData.text, 5,-5,screenWidth, screenHeight*0.25,tocolor(0,0,0,255), 1.4, "bankgothic", "center", "center",true,true,true)
	dxDrawText("Erreichte Stationen: "..busData.stations.." ("..busData.money.." Vero)\n"..busData.text, -5,-5,screenWidth, screenHeight*0.25,tocolor(0,0,0,255), 1.4, "bankgothic", "center", "center",true,true,true)

	dxDrawText("Erreichte Stationen: "..busData.stations.." ("..busData.money.." Vero)\n"..busData.text, 0,0,screenWidth, screenHeight*0.25,tocolor(255,100,0,255), 1.4, "bankgothic", "center", "center",true,true,true)
	
	if getDistanceBetweenPoints2D ( x, y, busData.pos[1], busData.pos[2] ) > 50 and busData.stopAllowed == false then
		busData.stopAllowed = true
		if busData.terminates == true then
			if busData.nextNumber == 1 then
				triggerServerEvent ( "onBusShaderReceive", getLocalPlayer(), busData.veh, busDisplays[busData.line][1], "line_"..busData.line )
			else
				triggerServerEvent ( "onBusShaderReceive", getLocalPlayer(), busData.veh, busDisplays[busData.line][2], "line_"..busData.line )
			end
		end
		triggerServerEvent ( "onBusAnnouncement", getLocalPlayer(), busData.veh, busData.nextStop, busData.line, busData.terminates )
	end
end


--[[setTimer(function()
	for i,v in ipairs(gBusStops) do
		local x,y,z = getElementPosition(getLocalPlayer())
		if getDistanceBetweenPoints2D ( x,y,v.obj[1], v.obj[2] ) < 50 then
			local sound = playSound3D("sounds/bus/streik.mp3",v.obj[1], v.obj[2], v.obj[3])
			setSoundEffectEnabled ( sound, "flanger", true )
		end
	end
end, 30000, 0)]]

addEventHandler ( "onClientResourceStart", getRootElement(), function(resource)
	if resource ~= getThisResource() then return end
	removeWorldModel( 1257,10000,0,0,0)

	for i,v in ipairs(gBusStops) do
		if v.obj then
			local elem
			
			if v.small then
				elem = createObject(1229, v.obj[1], v.obj[2], v.obj[3], v.obj[4], v.obj[5], v.obj[6])
			else
				elem = createObject(1257, v.obj[1], v.obj[2], v.obj[3], v.obj[4], v.obj[5], v.obj[6])
			end
			local cm = createElement("busStation")
			setElementData(cm, "name", v.name)
			setElementData(cm, "obj", elem)
			setElementData(cm, "id", i)
			if not v.small then
				replaceTexture(elem, "CJ_BS_MENU5", "images/bus/stations/"..v.def..".jpg")
			end
			setObjectBreakable (elem,false )
		end
	end
	
	for i,v in ipairs(getElementsByType("vehicle")) do
		if getElementModel(v) == 431 then
			if type(getElementData(v, "setShader")) == "table" then
				setBusShader(v, getElementData(v, "setShader")[1], getElementData(v, "setShader")[2])
			end
		end
	end
end)
local busShaders = {}
local busShaders2 = {}

function playBusAnnouncement(station, line, terminates)
	if station and gBusStops[station] and gBusStops[station].sound then
		local sounds = {}
		local blockNext = false
		for i,v in ipairs(gBusStops[station].sound) do
			if terminates == false and (v == "ziel.mp3" or v == "last_stop.mp3" or (gBusStops[station].sound[#gBusStops[station].sound-1] == "gong2.mp3" and v == "gong2.mp3")) then
			elseif v == "in_richtung.mp3" and string.find (gBusStops[station].sound[i-1], "linie_"..line) then
				blockNext = true
			elseif string.find (v, "linie_"..line) and not string.find (v, "gong") then
			elseif blockNext == true then
				blockNext = false
			else
				sounds[#sounds+1] = playSound("sounds/bus/"..v)
				setSoundPaused(sounds[#sounds], true)
			end
		end
		
		if sounds then
			local maxLenght =0
			for i,v in ipairs(sounds) do
				local newLength = getSoundLength(v)
				if i == 1 then
					setSoundPaused(v, false)
				else
					setTimer(function(sound) setSoundPaused(sound, false) end, maxLenght,1, v)
				end
				maxLenght = maxLenght + newLength*1000 + 500
			end
		end
	end
end


function removeBusShader(veh)
	if getElementData(veh, "busShader") then
		engineRemoveShaderFromWorldTexture(getElementData(veh, "busShader"), "bus_livery2", veh)
		setElementData(veh, "busShader", false)
	end
	if getElementData(veh, "busShader2") then
		engineRemoveShaderFromWorldTexture(getElementData(veh, "busShader2"), "targa", veh)
		setElementData(veh, "busShader2", false)
	end	
end

function setBusShader(veh, target, line)
	if veh and isElement(veh) then
		if not busShaders[tostring(target)] then
			local texture = dxCreateTexture("images/bus/"..target..".jpg","dxt3")
			if not texture then return false end
			local shader = dxCreateShader("fx/texture.fx")
			if not shader then return false end
			dxSetShaderValue(shader,"gTexture",texture)
			busShaders[tostring(target)] = shader
		end
		
		if getElementData(veh, "busShader") then
			engineRemoveShaderFromWorldTexture(getElementData(veh, "busShader"), "bus_livery2", veh)
		end
		engineApplyShaderToWorldTexture(busShaders[tostring(target)],"bus_livery2",veh)
		setElementData(veh, "busShader", busShaders[tostring(target)], false)
		
		if not busShaders2[tostring(line)] then
			local texture = dxCreateTexture("images/bus/"..line..".png","dxt3")
			if not texture then return false end
			local shader = dxCreateShader("fx/texture.fx")
			if not shader then return false end
			dxSetShaderValue(shader,"gTexture",texture)
			busShaders2[tostring(line)] = shader
		end
		
		if getElementData(veh, "busShader2") then
			engineRemoveShaderFromWorldTexture(getElementData(veh, "busShader2"), "targa", veh)
		end
		engineApplyShaderToWorldTexture(busShaders2[tostring(line)],"targa",veh)		
		setElementData(veh, "busShader2", busShaders2[tostring(line)], false)
	end
	
	return true
end
