--[[
Project: VitaOnline
File: feuerwehr-server.lua
Author(s):	Sebihunter
]]--

local tor1 = createObject( 3037, 2627.2001953125, 1170.400390625, 12, 0, 0, 0 )
local tor1_key1 = createObject( 2886, 2626.400390625, 1165, 12.10000038147, 0, 0, 270 )
local tor1_key2 = createObject( 2886, 2628.0498046875, 1175.7998046875, 12.10000038147, 0, 0, 90 )
setElementData( tor1_key1, "cinfo", {"Tor öffnen/schließen"} )
setElementData( tor1_key2, "cinfo", {"Tor öffnen/schließen"} )

function fire_tor_func1 ( button, state, player )
	if getElementData( player, "job" ) ~= 7 then return end
		if getElementData( tor1, "moving" ) == true then return end
			setElementData( tor1, "moving", true )
			setTimer( setElementData, 2600, 1, tor1, "moving", false )   
		if getElementData( tor1, "state" ) == "open" then
			moveObject( tor1, 2500, 2627.2001953125, 1170.400390625, 12 )
			setElementData( tor1, "state", "closed" )
	else
		moveObject( tor1, 2500, 2627.2001953125, 1170.400390625, 7.5999999046326 )
		setElementData( tor1, "state", "open" )
	end
end
addEventHandler( "onElementClicked", tor1_key1, fire_tor_func1 )
addEventHandler( "onElementClicked", tor1_key2, fire_tor_func1 )


--- Haupttor 2

local tor2 = createObject( 3037, 2627.2998046875, 1182.2373046875, 12, 0, 0, 0 )
local tor2_key1 = createObject( 2886, 2626.400390625, 1176.7998046875, 12.10000038147, 0, 0, 270 )
local tor2_key2 = createObject( 2886, 2628.0498046875, 1187.599609375, 12.10000038147, 0, 0, 90 )
setElementData( tor2_key1, "cinfo", {"Tor öffnen/schließen"} )
setElementData( tor2_key2, "cinfo", {"Tor öffnen/schließen"} )

function fire_tor_func2 ( button, state, player )
	if getElementData( player, "job" ) ~= 7 then return end
		if getElementData( tor2, "moving" ) == true then return end
			setElementData( tor2, "moving", true )
			setTimer( setElementData, 2600, 1, tor2, "moving", false )   
		if getElementData( tor2, "state" ) == "open" then
			moveObject( tor2, 2500, 2627.2998046875, 1182.2373046875, 12 )
			setElementData( tor2, "state", "closed" )
	else
		moveObject( tor2, 2500, 2627.2998046875, 1182.2373046875, 7.5999999046326 )
		setElementData( tor2, "state", "open" )
	end
end
addEventHandler( "onElementClicked", tor2_key1, fire_tor_func2 )
addEventHandler( "onElementClicked", tor2_key2, fire_tor_func2 )


--- Schranke

local schranke = createObject( 968, 2649.400390625, 1233.099609375, 10.60000038147, 0, 270, 90 )
local schranke_key1 = createObject( 2886, 2649.1005859375, 1225.599609375, 10.89999961853, 0, 0, 270 )
local schranke_key2 = createObject( 2886, 2649.7299804688, 1225.599609375, 10.89999961853, 0, 0, 90 )
setElementData( schranke_key1, "cinfo", {"Schranke öffnen/schließen"} )
setElementData( schranke_key2, "cinfo", {"Schranke öffnen/schließen"} )

function schranke_func ( button, state, player )
	if getElementData( player, "job" ) ~= 7 then return end
		if getElementData( schranke, "moving" ) == true then return end
			setElementData( schranke, "moving", true )
			setTimer( setElementData, 2600, 1, schranke, "moving", false )   
		if getElementData( schranke, "state" ) == "open" then
			moveObject( schranke, 2500, 2649.400390625, 1233.099609375, 10.60000038147, 0, -90, 0 )
			setElementData( schranke, "state", "closed" )
	else
		moveObject( schranke, 2500, 2649.400390625, 1233.099609375, 10.60000038147, 0, 90, 0 )
		setElementData( schranke, "state", "open" )
	end
end
addEventHandler( "onElementClicked", schranke_key1, schranke_func )
addEventHandler( "onElementClicked", schranke_key2, schranke_func )



gFires = {
	--LV
    [1] = {posX=1642.9, posY=2150.2, posZ=14.9},
    [2] = {posX=1639.2, posY=2096.3, posZ=14.7},
    [3] = {posX=1543.1, posY=2072.8999, posZ=15.1},
    [4] = {posX=1414.8, posY=2033.5, posZ=14.7},
    [5] = {posX=1525.8, posY=1912.2, posZ=14},
    [6] = {posX=1411.1, posY=1903.7, posZ=14.8},
    [7] = {posX=1313.2, posY=1930.4, posZ=14.7},
    [8] = {posX=1082.5, posY=2040.2, posZ=15.5},
    [9] = {posX=1030.2, posY=1980, posZ=14.9},
    [10] = {posX=985.79999, posY=1886.8, posZ=15.1},
    [11] = {posX=884.59998, posY=1988.9, posZ=15.1},
    [12] = {posX=978.70001, posY=2269.6001, posZ=15.3},
    [13] = {posX=1312.5, posY=2611.6001, posZ=15.1},
    [14] = {posX=1516.3, posY=2572.1001, posZ=15},
    [15] = {posX=1665.7, posY=2610.5, posZ=11.9},
    [16] = {posX=1633.5, posY=2748.8999, posZ=15.7},
    [17] = {posX=1655.6, posY=2839.6001, posZ=15.1},
    [18] = {posX=1548.3, posY=2843.8, posZ=15.9},
    [19] = {posX=1832.2, posY=2750, posZ=15.1},
    [20] = {posX=1856.8, posY=2583.2, posZ=17.1},
    [21] = {posX=1954.9, posY=2663.7, posZ=14.7},
    [22] = {posX=2066.5, posY=2675.3999, posZ=15},
    [23] = {posX=2194.3, posY=2791, posZ=15},
    [24] = {posX=2822.8, posY=2409.3, posZ=17.3},
    [25] = {posX=2782.2, posY=2259.3, posZ=15.7},
    [26] = {posX=2834.5, posY=2052.8999, posZ=14.2},
    [27] = {posX=2618.5, posY=2018.3, posZ=14.1},
    [28] = {posX=2408.6001, posY=1992.7, posZ=15.2},
    [29] = {posX=2325.8, posY=2127.8, posZ=18.5},
    [30] = {posX=2106.8999, posY=2165, posZ=14.5},
    [31] = {posX=2002.1, posY=1538.1, posZ=13.6},
    [32] = {posX=2017.8, posY=1209.9, posZ=15.2},
    [33] = {posX=2042.3, posY=733.40002, posZ=14.7},
    [34] = {posX=2121, posY=697.59998, posZ=15.1},
    [35] = {posX=2248.3999, posY=690.40002, posZ=14.6},
    [36] = {posX=2450, posY=734.20001, posZ=14.3},
    [37] = {posX=2461.3, posY=653.40002, posZ=14.7},
    [38] = {posX=2623.3999, posY=707.40002, posZ=15.4},
    [39] = {posX=2531, posY=1003.2, posZ=15.8},
    [40] = {posX=2437.3999, posY=1212, posZ=14.4},
    [41] = {posX=2563.6001, posY=1225.8, posZ=14.3},
    [42] = {posX=2532.6001, posY=1508.8, posZ=11.8},
    [43] = {posX=-28.8, posY=1214.6, posZ=22.5},
    [44] = {posX=-206.10001, posY=1062.4, posZ=19.7},
    [45] = {posX=-257.89999, posY=1150.3, posZ=21.6},
    [46] = {posX=-361.20001, posY=1140, posZ=21.1},
    [47] = {posX=-798.79999, posY=1501.6, posZ=24.8},
    [48] = {posX=-856.90002, posY=1529.2, posZ=23.9},
    [49] = {posX=-745.70001, posY=1591.1, posZ=27},
    [50] = {posX=-319.29999, posY=1306.8, posZ=53.7},
    [51] = {posX=-376.70001, posY=2243, posZ=42.7},
    [52] = {posX=-383.89999, posY=2206.5, posZ=45.7},
    [53] = {posX=-437.89999, posY=2228.3, posZ=43.8},
    [54] = {posX=-292.79999, posY=2689.7, posZ=65.9},
    [55] = {posX=-168.2, posY=2707.5, posZ=62.9},
    [56] = {posX=-198.10001, posY=2766.3999, posZ=62.7},
    [57] = {posX=-267, posY=2604, posZ=66.7},
    [58] = {posX=-788.59998, posY=2756.2, posZ=48.5},
    [59] = {posX=-1265, posY=2718.5, posZ=50.3},
    [60] = {posX=-1458.9, posY=2654.8999, posZ=56.7},
    [61] = {posX=-1531.2, posY=2591.3, posZ=56},
    [62] = {posX=-1563.9, posY=2651.2, posZ=56.2},
    [63] = {posX=-1357, posY=2061.2, posZ=53.6},
    [64] = {posX=695, posY=1968.5, posZ=9.2},
    [65] = {posX=-594.5, posY=2019.6, posZ=60.4}
}

gTrees = {
	--LS
	{846, 1996.5999755859, -1132.1999511719, 25, 0, 0, 0},
	{684, 1566.5, -2223.7001953125, 12.89999961853, 0, 0, 289.9951171875},
	{684, 1803.0999755859, -1838.9000244141, 13, 0, 0, 0},
	{684, 1215.2001953125, -2433.3994140625, 9.1999998092651, 0, 0, 5.99853515625},
	{684, -98.7998046875, -1134.099609375, 0.80000001192093, 0, 0, 45.994262695313},
	{684, 187.099609375, -1496.2001953125, 12.10000038147, 0, 0, 45.98876953125},
	{684, 605.099609375, -1117.2001953125, 46.900001525879, 0, 0, 45.98876953125},
	{684, 321.5, -1642, 32.799999237061, 0, 0, 35.9912109375},
	{684,519.5, -189.599609375, 36.200000762939, 0, 0, 75.986938476563},
	{684, 133.30000305176, -96.300003051758, 1, 0, 0, 125.98571777344},	
	--LV	
	{846 ,-1426.4000244141, 2663.3999023438, 55.299999237061, 0, 0, 306.75},
	{846, -302.099609375, 1503.5, 75.099998474121, 0, 0, 270},
	{846, -237.2001953125, 1198.599609375, 19.299999237061, 0, 0, 209.99450683594},
	{616, 1059.1999511719, 1385.5999755859, 9.6000003814697,0, 90, 289.99633789063},	
	{846, 1412.2998046875, 2607, 10.300000190735,0, 0, 0},	
	{616, 1035.1999511719, 2408.8999023438, 9.5, 0, 90, 236},
	{846, 1967.3000488281, 633.09997558594, 10.300000190735,0, 0, 329.99938964844},
	{846, 2069.5, 759.2001953125, 10.199999809265,0, 0, 339.99389648438},
	{616, 2121.2001953125, 1363, 10.3999996185303,0, 90, 124.99697875977},	
	{616, 1734.400390625, 1388.2001953125, 9.6000003814697, 0, 90, 149.99633789063},
	--SF
	{843, -1797.7001953125, 108.79979705811, 14.10000038147,0, 0, 9.99755859375},
	{836, -1570.7998046875, 632, 7.1999998092651, 0, 0, 229.99877929688 },
	{715, -1912, 1291.5, 5.4000000953674, 0, 90, 109.9951171875},
	{836, -2601, 1110.900390625, 55.599998474121,0, 0, 279.99755859375},
	{846, -2834.2998046875, 1236.599609375, 6.6999998092651, 338.49975585938, 0, 29.998168945313},
	{845, -2712.2001953125, 573.400390625, 14.5, 0, 0, 0},
	{837, -2281.5, -198.099609375, 34.799999237061, 0, 0, 90},
	{846, -2560.7998046875, 2289.1005859375, 4.4000000953674, 0, 0, 270},
	{846, -2813.8994140625, 122.2001953125, 7, 0, 0, 90},
}

function createFireJob()
	if #getElementsByType("fireJob") > 3 then createFireJobTimer = setTimer(createFireJob,math.random(5,10)*1000*60, 1) return end
	local rnd = math.random(1,#gFires)
	local fire = createElement("fireJob")
	setElementPosition(fire, gFires[rnd].posX,gFires[rnd].posY,gFires[rnd].posZ)
	local blip = createBlipAttachedTo ( fire, 0, 5, 200 ,0,0, 255, 0, 99999.0, getRootElement() )
	setElementVisibleTo ( blip, getRootElement(), false)
	setElementData(fire, "blip", blip)
	setElementData(fire, "health", 1000)
	addEventHandler("onElementDataChange",fire,fireDataChange)
	
	local jobPeople = 0
	for numb,ply in ipairs(getElementsByType("player")) do
		if getElementData(ply, "job") == 7 and getElementData(ply, "dienst") == 1 then
			jobPeople = jobPeople + 1
			local city = getZoneName ( gFires[rnd].posX,gFires[rnd].posY,gFires[rnd].posZ, true)
			local zone = getZoneName ( gFires[rnd].posX,gFires[rnd].posY,gFires[rnd].posZ)
			triggerClientEvent ( ply, "addNotification", getRootElement(), 3, 255,255,0, "ACHTUNG: In "..city.." ist ein Feuer ausgebrochen.\nDu siehst es auf deiner Dienstkarte im Fahrzeug." )
			callClientFunction(ply, "playDispatch", "Achtung an alle Einheiten: Ein Feuer ist in "..zone.." ("..city..") ausgebrochen.")
			outputChatBox ( "#aaaa00[Funk] Leitstelle: Achtung an alle Einheiten: Ein Feuer ist in "..zone.." ("..city..") ausgebrochen.", ply, 200, 200, 0, true )
			outputChatBox ( "#aaaa00[Funk] Leitstelle: Die Position wurde auf der Dienstkarte im Fahrzeug markiert.", ply, 200, 200, 0, true )
			refreshTreePositions(ply)
		end
		if getElementData(ply, "job") == 9 and getElementData(ply, "dienst") == 1 then
			local city = getZoneName ( gFires[rnd].posX,gFires[rnd].posY,gFires[rnd].posZ, true)
			local zone = getZoneName ( gFires[rnd].posX,gFires[rnd].posY,gFires[rnd].posZ)		
			triggerClientEvent ( ply, "addNotification", getRootElement(), 3, 255,255,0, "Nachrichten:\nEin Brand ist ausgebrochen: "..zone.." ("..city..")." )
			outputChatBox ( "Nachrichten: Ein Brand ist ausgebrochen: "..zone.." ("..city..").", ply, 255, 255, 0, true )	
		end
	end	
	createfireJobTimer = setTimer(createFireJob,math.random(6,12)*1000*60, 1)
end

 
gTreeParent = createElement("treeJob")
function createTreeJob()
	local fireppl = 0
	for numb,ply in ipairs(getElementsByType("player")) do if getElementData(ply, "job") == 7 and getElementData(ply, "dienst") == 1 then fireppl = fireppl + 1 end end
	if #getElementChildren ( gTreeParent ) > 2 or fireppl == 0 then createTreeJobTimer = setTimer(createTreeJob,math.random(6,12)*1000*60, 1) return end
	local rnd = math.random(1,#gTrees)
	local tree = createObject(gTrees[rnd][1],gTrees[rnd][2],gTrees[rnd][3],gTrees[rnd][4],gTrees[rnd][5],gTrees[rnd][6],gTrees[rnd][7])
	local blip = createBlipAttachedTo ( tree, 0, 5, 100 ,0,0, 255, 0, 99999.0, getRootElement() )
	setElementVisibleTo ( blip, getRootElement(), false)
	setElementData(tree, "blip", blip)
	setElementData(tree, "isTree", true)
	setElementData(tree, "health", 1000)
	addEventHandler("onElementDataChange",tree,treeDataChange)
	setElementParent ( tree, gTreeParent )
	
	local jobPeople = 0
	for numb,ply in ipairs(getElementsByType("player")) do
		if getElementData(ply, "job") == 7 and getElementData(ply, "dienst") == 1 then
			jobPeople = jobPeople + 1
			local city = getZoneName ( gTrees[rnd][2],gTrees[rnd][3],gTrees[rnd][4], true)
			local zone = getZoneName ( gTrees[rnd][2],gTrees[rnd][3],gTrees[rnd][4])
			triggerClientEvent ( ply, "addNotification", getRootElement(), 3, 255,255,0, "ACHTUNG: In "..city.." ist ein Baum umgefallen.\nDu siehst ihn auf deiner Dienstkarte im Fahrzeug." )
			callClientFunction(ply, "playDispatch", "Achtung an alle Einheiten: Ein Baum ist in "..zone.." ("..city..") umgefallen und blockirt die Strasse.")
			outputChatBox ( "#aaaa00[Funk] Leitstelle: Achtung an alle Einheiten: Ein Baum ist in "..zone.." ("..city..") umgefallen und blockiert die Straße.", ply, 200, 200, 0, true )
			outputChatBox ( "#aaaa00[Funk] Leitstelle: Die Position wurde auf der Dienstkarte im Fahrzeug markiert.", ply, 200, 200, 0, true )
			refreshTreePositions(ply)
		end
		if getElementData(ply, "job") == 9 and getElementData(ply, "dienst") == 1 then
			local city = getZoneName ( gTrees[rnd][2],gTrees[rnd][3],gTrees[rnd][4], true)
			local zone = getZoneName ( gTrees[rnd][2],gTrees[rnd][3],gTrees[rnd][4])
			triggerClientEvent ( ply, "addNotification", getRootElement(), 3, 255,255,0, "Nachrichten:\nEin Baum ist umgefallen: "..zone.." ("..city..")." )
			outputChatBox ( "Nachrichten: Ein Baum ist umgefallen: "..zone.." ("..city..").", ply, 255, 255, 0, true )	
		end		
	end	
	createTreeJobTimer = setTimer(createTreeJob,math.random(6,12)*1000*60, 1)
end


function fireDataChange(data,old)
	if not client then return end
	if data == "health" then
		local new = getElementData(source,data)
		if new ~= 0 then
			setElementAlpha ( source, 140+115*new/1000)
		else
			setElementData(client, "einnahmen", getElementData(client, "einnahmen")+800)
			setElementData(client, "einnahmen2", getElementData(client, "einnahmen2")+800)
			systemDeposit("Krankenhaus", 800)
			outputChatBox ( "Du hast den Brand gelöscht und der Feuerwehr damit 800 Vero gebracht.", client, 255, 255, 0, true )		
			destroyElement(getElementData(source, "blip"))
			destroyElement(source)
		end
	end
end

function treeDataChange(data,old)
	if not client then return end
	if data == "health" then
		local new = getElementData(source,data)
		if new ~= 0 then
			setElementAlpha ( source, 140+115*new/1000)
		else
			setElementData(client, "einnahmen", getElementData(client, "einnahmen")+800)
			setElementData(client, "einnahmen2", getElementData(client, "einnahmen2")+800)
			systemDeposit("Krankenhaus", 800)
			outputChatBox ( "Du hast den Baum entfernt und der Feuerwehr damit 800 Vero gebracht.", client, 255, 255, 0, true )		
			destroyElement(getElementData(source, "blip"))
			destroyElement(source)
		end
	end
end

--This also refreshes fire positions
function refreshTreePositions(player)
	if isPedInVehicle ( player) and (getElementModel(getPedOccupiedVehicle(player)) == 407 or getElementModel(getPedOccupiedVehicle(player)) == 544) and getElementData(player, "job") == 7 and getElementData(player, "dienst") == 1 then
		for i,v in ipairs(getElementChildren ( gTreeParent )) do
			setElementVisibleTo ( getElementData(v, "blip"), player, true)
		end
		for i,v in ipairs(getElementsByType("fireJob")) do
			setElementVisibleTo ( getElementData(v, "blip"), player, true)
		end
	else
		for i,v in ipairs(getElementChildren ( gTreeParent )) do
			setElementVisibleTo ( getElementData(v, "blip"), player, false)
		end	
		for i,v in ipairs(getElementsByType("fireJob")) do
			setElementVisibleTo ( getElementData(v, "blip"), player, false)
		end		
	end
end

local gRoadBlockFeuer = {}
function addRoadBlock(ply, command)
	if getElementData(ply, "job") == 7 and getElementData(ply, "dienst") == 1 then
		local x,y,z = getElementPosition(ply)
		local a = getPedRotation(ply)
		gRoadBlockFeuer[#gRoadBlockFeuer+1] = createObject(1237, x, y, z - 1.0, 0.0, 0.0, a)
		local int = getElementInterior(ply)
		local dim = getElementDimension(ply)		
		setElementInterior(gRoadBlockFeuer[#gRoadBlockFeuer], int)
		setElementDimension(gRoadBlockFeuer[#gRoadBlockFeuer], dim)		
	end	
end
addCommandHandler("ab",addRoadBlock, false, false)
addCommandHandler("absperrung",addRoadBlock, false, false)

function delRoadBlock(ply, command)
	if getElementData(ply, "job") == 7 then
		if #gRoadBlockFeuer > 0 then
			local i = #gRoadBlockFeuer
			destroyElement(gRoadBlockFeuer[i])
			table.remove(gRoadBlockFeuer,i)
		end	
	end	
end
addCommandHandler("abdel",delRoadBlock, false, false)
addCommandHandler("delabsperrung",delRoadBlock, false, false)
