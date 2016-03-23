--[[
Project: VitaOnline
File: root-client.lua
Author(s):	Golf_R32
			Sebihunter
]]--
-- Version Text
g_version = "1.3"

--Adminlift_musik
local lift = playSound3D("sounds/elevator_music.mp3", 2393, 1495,3, true)
setSoundMaxDistance ( lift, 30 )
lift = playSound3D("http://www.top100station.de/switch/top100station_lq.asx", 2386,1385,0)
setSoundMaxDistance ( lift, 25 )
--[[addEvent("redoTheLoginScreen", true)
function makeRedoOFLoginScreen()
	createTheLogRegCamera()
	fadeCamera(true)
	setElementData(getLocalPlayer(), "freecam:state", false)
	toggleAllControls( true )
end
addEventHandler("redoTheLoginScreen", getLocalPlayer(), makeRedoOFLoginScreen)


function onClientPlayerJoin()
	createTheLogRegCamera()
	fadeCamera(true)
	if getElementData(source, "isPlayerLoggedIn") == false then
		showChat(false)
	else
		showChat(true)
	end
end
addEventHandler("onClientPlayerJoin", getLocalPlayer(), onClientPlayerJoin)]]

function handleVehicleDamage(attacker, weapon, loss, x, y, z, tyre)
	if getPedOccupiedVehicle(getLocalPlayer()) == source and not weapon and loss >= 50 then
		setElementHealth(getLocalPlayer(), getElementHealth(getLocalPlayer())-loss*0.06)
	end
end
addEventHandler("onClientVehicleDamage", root, handleVehicleDamage)

function syncTime()
	local time = getRealTime( )
	setTime( time.hour, time.minute )
end

function createCustomImages()
	local customblips = {}
	
	local rshad = dxCreateShader("fx/texture2.fx")
    dxSetShaderValue(rshad, "gTexture", dxCreateTexture("images/radardisc.png"))
	engineApplyShaderToWorldTexture(rshad, "radardisc")
	
	local rshad = dxCreateShader("fx/texture.fx")
    dxSetShaderValue(rshad, "gTexture", dxCreateTexture("images/radar_north.png"))
	engineApplyShaderToWorldTexture(rshad, "radar_north")
	
	customblips[#customblips+1] = exports.customblips:createCustomBlip(1906.1958,-1358.2620, 16, 16, "images/blips/drink.png") --Freibad Bar
	customblips[#customblips+1] = exports.customblips:createCustomBlip(886.24176025391, 1915.5100097656, 16, 16, "images/blips/drink.png") --Wilder Ösi Bar
	customblips[#customblips+1] = exports.customblips:createCustomBlip(1904.712890625, 1916.2265625, 16, 16, "images/blips/drink.png") --PBC Bar
	customblips[#customblips+1] = exports.customblips:createCustomBlip( -2042.5107421875, 163.583984375, 16, 16, "images/blips/drink.png") --Die Werkstatt
	customblips[#customblips+1] = exports.customblips:createCustomBlip(-960.093,-975.0950, 16, 16, "images/blips/drink.png")	-- Baumhaus
	
	customblips[#customblips+1] = exports.customblips:createCustomBlip(2007.650, 2182.711, 16, 16, "images/blips/news.png")	-- Baumhaus
	customblips[#customblips+1] = exports.customblips:createCustomBlip( 251.71875, -54.470703125, 20, 20, "images/blips/shop.png") --Einkausladen
	customblips[#customblips+1] = exports.customblips:createCustomBlip( 2247.701, 2396.466, 20, 20, "images/blips/shop.png") --Einkausladen
	customblips[#customblips+1] = exports.customblips:createCustomBlip( 2333.1286621094, -17.434419631958, 20, 20, "images/blips/shop.png") --Einkausladen
	customblips[#customblips+1] = exports.customblips:createCustomBlip( 1257.6785888672, 204.42744445801, 20, 20, "images/blips/shop.png") --Einkausladen
	customblips[#customblips+1] = exports.customblips:createCustomBlip( 143.52349853516, -201.02392578125, 20, 20, "images/blips/shop.png") --Einkausladen
	customblips[#customblips+1] = exports.customblips:createCustomBlip( 681.59497070313, -473.66870117188, 20, 20, "images/blips/shop.png") --Einkausladen
	customblips[#customblips+1] = exports.customblips:createCustomBlip( 2090.8071289063, -1905.3587646484, 20, 20, "images/blips/shop.png") --Einkausladen
	customblips[#customblips+1] = exports.customblips:createCustomBlip( 2423.7739257813, -1742.49609375, 20, 20, "images/blips/shop.png") --Einkausladen
	customblips[#customblips+1] = exports.customblips:createCustomBlip(1582.2902832031, -1171.0111083984, 20, 20, "images/blips/shop.png") --Einkausladen
	customblips[#customblips+1] = exports.customblips:createCustomBlip( 875.73303222656, -1565.1317138672, 20, 20, "images/blips/shop.png") --Einkausladen
	customblips[#customblips+1] = exports.customblips:createCustomBlip( 685.55603027344, -1774.8443603516, 20, 20, "images/blips/shop.png") --Einkausladen
	customblips[#customblips+1] = exports.customblips:createCustomBlip( 1000.2669677734, -920.24731445313, 20, 20, "images/blips/shop.png") --Einkausladen
	customblips[#customblips+1] = exports.customblips:createCustomBlip( -2057.7546386719, -2464.3930664063, 20, 20, "images/blips/shop.png") --Einkausladen
	customblips[#customblips+1] = exports.customblips:createCustomBlip( -1809.9008789063, 902.78948974609, 20, 20, "images/blips/shop.png") --Einkausladen
	customblips[#customblips+1] = exports.customblips:createCustomBlip( -2442.7277832031, 754.38671875, 20, 20, "images/blips/shop.png") --Einkausladen
	customblips[#customblips+1] = exports.customblips:createCustomBlip( -2510.4709472656, 10.707441329956, 20, 20, "images/blips/shop.png") --Einkausladen
	customblips[#customblips+1] = exports.customblips:createCustomBlip( -2537.4670410156, 2319.0427246094, 20, 20, "images/blips/shop.png") --Einkausladen
	customblips[#customblips+1] = exports.customblips:createCustomBlip( -19.243934631348, 1175.484375, 20, 20, "images/blips/shop.png") --Einkausladen
	customblips[#customblips+1] = exports.customblips:createCustomBlip( -780.43737792969, 1501.4187011719, 20, 20, "images/blips/shop.png") --Einkauslade
	customblips[#customblips+1] = exports.customblips:createCustomBlip( -1531.1008300781, 2591.5463867188, 20, 20, "images/blips/shop.png") --Einkausladen
	customblips[#customblips+1] = exports.customblips:createCustomBlip( -254.61477661133, 2603.3488769531, 20, 20, "images/blips/shop.png") --Einkausladen
	customblips[#customblips+1] = exports.customblips:createCustomBlip( 2546.1206054688, 1972.2390136719, 20, 20, "images/blips/shop.png") --Einkausladen
	customblips[#customblips+1] = exports.customblips:createCustomBlip( 2194.6928710938, 1991.1397705078, 20, 20, "images/blips/shop.png") --Einkausladen
	customblips[#customblips+1] = exports.customblips:createCustomBlip( 2884.5805664063, 2453.6506347656, 20, 20, "images/blips/shop.png") --Einkausladen
	customblips[#customblips+1] = exports.customblips:createCustomBlip( -2767.509, 788.7322, 16, 16, "images/blips/donut.png") --Donutladen
	customblips[#customblips+1] = exports.customblips:createCustomBlip( -144.1506, 1224.925, 16, 16, "images/blips/donut.png") --Donutladen			
	customblips[#customblips+1] = exports.customblips:createCustomBlip(1936.26,2318.87, 16, 16, "images/blips/donut.png") --Donutladen			

	customblips[#customblips+1] = exports.customblips:createCustomBlip( 811.982, -1616.02, 16, 16, "images/blips/eat.png") --Burger Shot
	customblips[#customblips+1] = exports.customblips:createCustomBlip( 1199.13, -918.071, 16, 16, "images/blips/eat.png") --Burger Shot
	customblips[#customblips+1] = exports.customblips:createCustomBlip( -1912.27, 828.025, 16, 16, "images/blips/eat.png") --Burger Shot
	customblips[#customblips+1] = exports.customblips:createCustomBlip( -2336.95, -166.646, 16, 16, "images/blips/eat.png") --Burger Shot
	customblips[#customblips+1] = exports.customblips:createCustomBlip( -2356.48, 1008.01, 16, 16, "images/blips/eat.png") --Burger Shot
	customblips[#customblips+1] = exports.customblips:createCustomBlip( 2366.74, 2071.02, 16, 16, "images/blips/eat.png") --Burger Shot
	customblips[#customblips+1] = exports.customblips:createCustomBlip( 2472.68, 2033.88, 16, 16, "images/blips/eat.png") --Burger Shot
	customblips[#customblips+1] = exports.customblips:createCustomBlip( 2169.86, 2795.79, 16, 16, "images/blips/eat.png") --Burger Shot
	customblips[#customblips+1] = exports.customblips:createCustomBlip( 1872.24, 2072.07, 16, 16, "images/blips/eat.png") --Burger Shot
	customblips[#customblips+1] = exports.customblips:createCustomBlip( 1158.43, 2072.02, 16, 16, "images/blips/eat.png") --Burger Shot
	customblips[#customblips+1] = exports.customblips:createCustomBlip( 172.727, 1176.68, 16, 16, "images/blips/eat.png") --Cluckin' Bell
	customblips[#customblips+1] = exports.customblips:createCustomBlip( -1213.71, 1830.46, 16, 16, "images/blips/eat.png") --Cluckin' Bell
	customblips[#customblips+1] = exports.customblips:createCustomBlip( -2155.03, -2460.28, 16, 16, "images/blips/eat.png") --Cluckin' Bell
	customblips[#customblips+1] = exports.customblips:createCustomBlip( 2419.95, -1509.8, 16, 16, "images/blips/eat.png") --Cluckin' Bell
	customblips[#customblips+1] = exports.customblips:createCustomBlip( 2397.83, -1898.65, 16, 16, "images/blips/eat.png") --Cluckin' Bell
	customblips[#customblips+1] = exports.customblips:createCustomBlip( 928.525, -1352.77, 16, 16, "images/blips/eat.png") --Cluckin' Bell
	customblips[#customblips+1] = exports.customblips:createCustomBlip( -1815.84, 618.678, 16, 16, "images/blips/eat.png") --Cluckin' Bell
	customblips[#customblips+1] = exports.customblips:createCustomBlip( -2671.53, 258.344, 16, 16, "images/blips/eat.png") --Cluckin' Bell
	customblips[#customblips+1] = exports.customblips:createCustomBlip( 2638.58, 1671.18, 16, 16, "images/blips/eat.png") --Cluckin' Bell
	customblips[#customblips+1] = exports.customblips:createCustomBlip( 2393.18, 2041.66, 16, 16, "images/blips/eat.png") --Cluckin' Bell
	customblips[#customblips+1] = exports.customblips:createCustomBlip( 2838.43, 2407.26, 16, 16, "images/blips/eat.png") --Cluckin' Bell
	customblips[#customblips+1] = exports.customblips:createCustomBlip( 2102.69, 2228.76, 16, 16, "images/blips/eat.png") --Cluckin' Bell
	customblips[#customblips+1] = exports.customblips:createCustomBlip( 1367.27, 248.388, 16, 16, "images/blips/eat.png") --Well Stacked Pizza
	customblips[#customblips+1] = exports.customblips:createCustomBlip( 2333.43, 75.0488, 16, 16, "images/blips/eat.png") --Well Stacked Pizza
	customblips[#customblips+1] = exports.customblips:createCustomBlip( 1367.27, 248.388, 16, 16, "images/blips/eat.png") --Well Stacked Pizza
	customblips[#customblips+1] = exports.customblips:createCustomBlip( 2105.32, -1806.49, 16, 16, "images/blips/eat.png") --Well Stacked Pizza
	customblips[#customblips+1] = exports.customblips:createCustomBlip( -1808.69, 945.863, 16, 16, "images/blips/eat.png") --Well Stacked Pizza
	customblips[#customblips+1] = exports.customblips:createCustomBlip( -1721.13, 1359.01, 16, 16, "images/blips/eat.png") --Well Stacked Pizza
	customblips[#customblips+1] = exports.customblips:createCustomBlip( 2638.58, 1849.97, 16, 16, "images/blips/eat.png") --Well Stacked Pizza
	customblips[#customblips+1] = exports.customblips:createCustomBlip( 2756.01, 2477.05, 16, 16, "images/blips/eat.png") --Well Stacked Pizza
	customblips[#customblips+1] = exports.customblips:createCustomBlip( 2351.89, 2532.19, 16, 16, "images/blips/eat.png") --Well Stacked Pizza
	customblips[#customblips+1] = exports.customblips:createCustomBlip( 2083.49, 2224.2, 16, 16, "images/blips/eat.png") --Well Stacked Pizza

	customblips[#customblips+1] = exports.customblips:createCustomBlip( 1368.35, -1279.06, 16, 16, "images/blips/ammu.png") --Ammunation
	customblips[#customblips+1] = exports.customblips:createCustomBlip( -2625.85, 208.345, 16, 16, "images/blips/ammu.png") --Ammunation
	customblips[#customblips+1] = exports.customblips:createCustomBlip( 242.668, -178.478, 16, 16, "images/blips/ammu.png") --Ammunation
	customblips[#customblips+1] = exports.customblips:createCustomBlip( 2333.43, 61.5173, 16, 16, "images/blips/ammu.png") --Ammunation
	customblips[#customblips+1] = exports.customblips:createCustomBlip( 2159.51, 943.329, 16, 16, "images/blips/ammu.png") --Ammunation
	customblips[#customblips+1] = exports.customblips:createCustomBlip( 2539.04, 2083.56, 16, 16, "images/blips/ammu.png") --Ammunation
	customblips[#customblips+1] = exports.customblips:createCustomBlip( 777.231, 1871.47, 16, 16, "images/blips/ammu.png") --Ammunation
	customblips[#customblips+1] = exports.customblips:createCustomBlip(-315.676, 829.868, 16, 16, "images/blips/ammu.png") --Ammunation
	customblips[#customblips+1] = exports.customblips:createCustomBlip( -2093.51, -2464.79, 16, 16, "images/blips/ammu.png") --Ammunation
	customblips[#customblips+1] = exports.customblips:createCustomBlip( 2400.5, -1981.48, 16, 16, "images/blips/ammu.png") --Ammunation
	customblips[#customblips+1] = exports.customblips:createCustomBlip( -1508.89, 2610.8, 16, 16, "images/blips/ammu.png") --Ammunation
	
	customblips[#customblips+1] = exports.customblips:createCustomBlip( 2408.965,1510.867, 16, 16, "images/blips/trashbin.png") --Autofix LV
	customblips[#customblips+1] = exports.customblips:createCustomBlip(1672,708, 49, 16, "images/blips/autofix.png") --Autofix LV
	customblips[#customblips+1] = exports.customblips:createCustomBlip(-1503.5009765625, 723.63867187, 49, 16, "images/blips/autofix.png") --Autofix SF
	customblips[#customblips+1] = exports.customblips:createCustomBlip(94.8, -162.8, 49, 16, "images/blips/autofix.png") --Autofix Blueberry
	customblips[#customblips+1] = exports.customblips:createCustomBlip(1064.9267578125,  1754.8349609, 16, 16, "images/blips/autohaus.png") --Autohaus LV
	customblips[#customblips+1] = exports.customblips:createCustomBlip(-1946.509765625, 271.29296875, 16, 16, "images/blips/sf_auto.png") --Autohaus SF
	customblips[#customblips+1] = exports.customblips:createCustomBlip(2172.400390625, 1390.5, 16, 16, "images/blips/autohus.png") --Autohus LV
	customblips[#customblips+1] = exports.customblips:createCustomBlip(1607.8955078125,  1820.7578125, 16, 16, "images/blips/kh.png") --Krankenhaus LV
	customblips[#customblips+1] = exports.customblips:createCustomBlip(2285.44140625,    2430.7265625, 16, 16, "images/blips/polizei.png") --Polizei LV
	customblips[#customblips+1] = exports.customblips:createCustomBlip(2360.2001953125, 536.7001953125, 16, 16, "images/blips/polizei.png") --Polizei Wasserwacht
	customblips[#customblips+1] = exports.customblips:createCustomBlip( 2464.1999511719, 2244.8000488281, 16, 16, "images/blips/gericht.png") --Gericht LV
	customblips[#customblips+1] = exports.customblips:createCustomBlip(2443.3994140625,  2373.9658203, 16, 16, "images/blips/saso.png") --SASO LV
	customblips[#customblips+1] = exports.customblips:createCustomBlip(2639.4250488281,1213.7762451172, 16, 16, "images/blips/feuerwehr.png") -- Feuerwehr LV
	customblips[#customblips+1] = exports.customblips:createCustomBlip(-2025.38806,66.8615, 16, 16, "images/blips/feuerwehr.png") -- Feuerwehr SF
	customblips[#customblips+1] = exports.customblips:createCustomBlip(2019.49,1007.11, 16, 16, "images/blips/casino.png") -- Four Dragons
--	customblips[#customblips+1] = exports.customblips:createCustomBlip(2414.5439453125,  1120.4687500, 16, 16, "images/blips/bank.png") --Bank LV
	customblips[#customblips+1] = exports.customblips:createCustomBlip(1643.19921875,  2322.8154296875, 16, 16, "images/blips/truckerjob.png") --Trucker LV
	customblips[#customblips+1] = exports.customblips:createCustomBlip(1136.9000244141, 1314.8000488281, 16, 16, "images/blips/autoverwahrung.png") --Autoverwahrung LV
	customblips[#customblips+1] = exports.customblips:createCustomBlip(1050.9000244141,  2321.7001953125, 16, 16, "images/blips/busjob.png") --Busjob LV
	customblips[#customblips+1] = exports.customblips:createCustomBlip(1083.9000244141, 2409.1000976563, 28, 28, "images/blips/taxi.png") --Taxi
	customblips[#customblips+1] = exports.customblips:createCustomBlip(365.4619140625, 2537.1484375, 24, 24, "images/blips/geld.png") --Uezguer
	customblips[#customblips+1] = exports.customblips:createCustomBlip(-2026.515625, -101.3857421875, 16, 16, "images/blips/school.png") --Fahrschule SF
	customblips[#customblips+1] = exports.customblips:createCustomBlip(1172.5443115234, 1358.7442626953, 16, 16, "images/blips/school.png") --Fahrschule LV
	customblips[#customblips+1] = exports.customblips:createCustomBlip(-1686.5439453125, 1451.197265625, 16, 16, "images/blips/anker.png") --Fischjob	
	customblips[#customblips+1] = exports.customblips:createCustomBlip(1899.4377,-1426.37707, 16, 16, "images/blips/pool.png") --Strandbad
	customblips[#customblips+1] = exports.customblips:createCustomBlip(2086.011,2073.992, 16, 16, "images/blips/boobs.png") --Sexshop
	customblips[#customblips+1] = exports.customblips:createCustomBlip(1656.270,2199.664, 16, 16, "images/blips/car4you.png") --car4you
	
	for i,v in ipairs(PaintnSprayIDTab) do
		customblips[#customblips+1] = exports.customblips:createCustomBlip(v.x, v.y, 16, 16, "images/blips/paynspray.png") --car4you
	end
	
	
	for i,v in ipairs(getElementsByType("tankstelle")) do
		local colC = getElementData(v, "colCircle")
		local x,y,_ = getElementPosition(colC)
		customblips[#customblips+1] = exports.customblips:createCustomBlip(x,y, 12, 12, "images/blips/fuel.png") --Tankstelle 	
	end
	
	for i,v in ipairs(customblips) do
		exports.customblips:setCustomBlipStreamRadius ( v, 40 )
	end
	
	loadRadarMarker ()
	
end

function onClientRPGResourceStart()
	
	setPedTargetingMarkerEnabled ( false )
	
	local obj = createObject( 8332, 1398.7998046875, -9.900390625, 1005.0999755859,0, 0, 269.09362792969)
	setObjectScale( obj, 0.5 )
	setElementInterior(obj, 1)
	setElementDoubleSided ( obj, true )
	setElementCollisionsEnabled ( obj, false )
	replaceTexture(obj, "heat_03", "images/gericht.jpg")
	
	--Ampeln disablen
	setTrafficLightState ( 9 )	
	setTrafficLightsLocked(true)	
	

	setGravity ( 0.008 )
	setGameSpeed ( 1 )	
	setElementData(getLocalPlayer(), "isHigh", false)
	
	--createTheLogRegCamera()
	fadeCamera(true)
	setElementData(getLocalPlayer(), "freecam:state", false)
	toggleAllControls ( true )  
	setMinuteDuration( 60000 )
	syncTime( )
	
	for i,v in ipairs(getElementsByType("object")) do
		if getElementModel(v) == 2942 or getElementModel(v) == 2886 then
			setObjectBreakable ( v, false )
		end
	end	
	--setTimer( syncTime, 100000, 0 )
	bindKey("F11", "down", function() 
		if getElementData(getLocalPlayer(), "hideTacho") ~= true then 
			setElementData(getLocalPlayer(), "hideTacho", true)
		else
			setElementData(getLocalPlayer(), "hideTacho", false)
		end
	end
	)
	
	for i,v in ipairs(getElementsByType("vehicle")) do
		if getElementData(v, "siren") then
			triggerEvent ( "toggleSiren", getLocalPlayer(), v, getElementData(v, "siren") )
		end
	end
	bindKey("b", "down", "chatbox", "LOOC" )
	bindKey("x", "down", "chatbox", "Gang" )
	bindKey("m", "down",
		function()
			if getElementData(getLocalPlayer(), "isPlayerLoggedIn") == true then
				showCursor(not isCursorShowing())
			end
		end
	)	
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), onClientRPGResourceStart)

-- Unverwundbares Ped

function onClientPlayerWasted()
	if getElementData(source, "afk") == true then
		cancelEvent()	
	end
end
addEventHandler("onClientPlayerWasted", getRootElement(), onClientPlayerWasted)


function onClientPedWasted()
	if getElementData(source, "isInvincible") then
		cancelEvent()
	end
end
addEventHandler("onClientPedWasted", getRootElement(), onClientPedWasted)

function onClientPlayerDamage(attacker, weapon, bodypart, loss)
	if getElementData(source, "isInvincible") then
		setPedHealth(source,getPedHealth(ped)+loss)
		cancelEvent()
	end
	if source ~= getLocalPlayer() then return end
	if getElementData(source, "afk") == true then
		setElementHealth(source, getElementHealth(source)+loss)
		cancelEvent()	
	end
end
addEventHandler("onClientPlayerDamage", getRootElement(), onClientPlayerDamage)


local g_tooltipTable = {
[1] = "Du kannst auf F1 alle wichtigen Befehle, Tasten, Gesetze und Regeln nachlesen.",
[2] = "Um bei Gangs oder Firmen beizutreten, musst du dich in ihrem Unterforen auf www.vita-online.eu bewerben.",
[3] = "Es gibt viele spannende Nebenjobs die keine Bewerbung benötigen.\nInfos dazu findest du in der Stadthalle (gelber Punkt auf 'F11') neben dem LVPD.",
[4] = "Es gibt an mehreren öffentlichen Plätzen (Bahnhöfen, Krankenhäuser) Fahrräder, welche jedem frei zur Verfügung stehen.",
[5] = "Es ist möglich an jedem Bahnhof schnell in eine andere Stadt zu reisen.\nWarte dafür einfach auf den automatischen Zug.",
[6] = "Für das Bekommen des Gehalts benötigst du ein Konto, welches du bei jedem ATM erstellen kannst.",
[7] = "Fahrzeuge können bei den Autohäusern (Wang Cars, AutoHus und Ares Automobiles) erworben werden.",
[8] = "Wenn dein Auto kaputt ist, kannst du mit /autofix den Pannendienst rufen.\nBei einem Brand musst du mit /113 auch die Feuerwehr rufen.",
[9] = "Um mit anderen Spielern über eine weite Distanz kommunizieren zu können, kannst du dir in einem Geschäft ein Handy kaufen.",
[10] = "Wenn du im Krankenhaus respawnst verlierst du dein gesamtes Bargeld.\nMit Glück findest du es an deiner letzten Position."
}

g_showTooltip = false
g_tooltipText = ""
g_tooltipPosY = -100
-- showTooltip
-- Zeigt einen Tooltip auf dem Bildschirm des Spielers
function showTooltip(text)
	playSound("sounds/info.mp3")
	g_tooltipText = text
	g_showTooltip = true
	setTimer(function() g_showTooltip = false end, 10000, 1)
end

setTimer(function() showTooltip(g_tooltipTable[math.random(1, #g_tooltipTable)]) end, 5*60*1000, 0)

-- makePlayerExitVehicle
-- Laesst einen Spieler aussteigen
function makePlayerExitVehicle()
	setControlState("enter_exit", true)
end

function hygienePlus(ped)
	if ped == getLocalPlayer() then
		if getElementData(getLocalPlayer(), "getPlayerHygiene") + 5 <= 100 then
			setElementData(getLocalPlayer(), "getPlayerHygiene", getElementData(getLocalPlayer(), "getPlayerHygiene") + 5)
		else
			setElementData(getLocalPlayer(), "getPlayerHygiene", 100)
		end
	end
end
addEventHandler("onClientPlayerHitByWaterCannon", getRootElement(), hygienePlus)

function AlertHandler ( x1, y1, z1, veh )
	local dsound = playSound3D ( "sounds/alarm.mp3", x1, y1, z1, false )
	attachElements ( dsound, veh )
	setSoundVolume ( dsound, 1.0 )
	setSoundMaxDistance ( dsound, 30 )
end
addEvent ( "onServerTriggerAlert", true )
addEventHandler ( "onServerTriggerAlert", getRootElement(), AlertHandler )

local text1LevelUp
local text2LevelUp
local infoProgressLevelUp
local partLevelUp
local alphaProgressLevelUp
local soundPlayedLevelUp
function showLevelUp(text1, text2)
	if not isEventHandlerAdded( "onClientRender", getRootElement(), renderLevelUp ) then
		text1LevelUp = text1
		text2LevelUp = text2
		infoProgressLevelUp = 0
		alphaProgressLevelUp = 0
		soundPlayedLevelUp = false
		playSound("sounds/levelup.mp3")
		addEventHandler("onClientRender", getRootElement(), renderLevelUp, false, "low+1")
		
		--ADD LEVEL UP INFO WHATS NEW WITH A TIMER!!!!
	end
end

function renderLevelUp()
	if 0.35 < infoProgressLevelUp and infoProgressLevelUp < 0.65 then 
		infoProgressLevelUp = infoProgressLevelUp + 0.005
		if infoProgressLevelUp < 0.5 then
			alphaProgressLevelUp = alphaProgressLevelUp + 0.05
		else
			alphaProgressLevelUp = alphaProgressLevelUp - 0.05
		end
	else
		infoProgressLevelUp = infoProgressLevelUp + 0.025
	end
	
	if alphaProgressLevelUp > 1 then alphaProgressLevelUp = 1 elseif alphaProgressLevelUp < 0 then alphaProgressLevelUp = 0 end
	
	if infoProgressLevelUp > 1 then removeEventHandler("onClientRender", getRootElement(), renderLevelUp) end
	
	local x, _, _ = interpolateBetween ( 0, 0, 0, screenWidth, 0, 0, infoProgressLevelUp, "OutInQuad")
	local x2, _, _ = interpolateBetween ( screenWidth, 0, 0, 0, 0, 0, infoProgressLevelUp, "OutInQuad")
	
	dxDrawLine ( screenWidth/2-200, screenHeight/2-16, screenWidth/2+200,screenHeight/2-16, tocolor(0,0,0,alphaProgressLevelUp*255), 1 )
	dxDrawLine ( screenWidth/2-200, screenHeight/2-15, screenWidth/2+200,screenHeight/2-15, tocolor(255,255,255,alphaProgressLevelUp*255), 2 )
	dxDrawLine ( screenWidth/2-200, screenHeight/2-13, screenWidth/2+200,screenHeight/2-13, tocolor(0,0,0,alphaProgressLevelUp*255), 1 )
	dxDrawBackgroundedText ( text1LevelUp, x, screenHeight/2-10, x, screenHeight, tocolor ( 255, 255, 255, 255 ),  tocolor ( 0, 0, 0, 255 ), 2, "default-bold", "center", "top", false, false, false )
	dxDrawBackgroundedText ( text2LevelUp, x2, screenHeight/2+15, x2, screenHeight, tocolor ( 255, 255, 255, 255 ),  tocolor ( 0, 0, 0, 255 ), 2, "default-bold", "center", "top", false, false, false )	
	dxDrawLine ( screenWidth/2-200, screenHeight/2+49, screenWidth/2+200,screenHeight/2+49, tocolor(0,0,0,alphaProgressLevelUp*255), 1 )
	dxDrawLine ( screenWidth/2-200, screenHeight/2+50, screenWidth/2+200,screenHeight/2+50, tocolor(255,255,255,alphaProgressLevelUp*255), 2 )
	dxDrawLine ( screenWidth/2-200, screenHeight/2+52, screenWidth/2+200,screenHeight/2+52, tocolor(0,0,0,alphaProgressLevelUp*255), 1 )
end

-- by Zipper --

local rotX, rotY = 0,0
local camVehRot = 0
local rot = 0
local egoEnabled = false

local lp = getLocalPlayer()

local mouseSensitivity = 0.1

local delay = 0

local function freecamFrame ( slice )

    local camPosX, camPosY, camPosZ = getPedBonePosition ( lp, 8 )
	
	local angleZ = math.sin(rotY)
    local angleY = math.cos(rotY) * math.cos(rotX)
    local angleX = math.cos(rotY) * math.sin(rotX)
	
	local camTargetX = camPosX + ( angleX ) * 100
    local camTargetY = camPosY + angleY * 100
    local camTargetZ = camPosZ + angleZ * 100

    local mspeed = 2
	
    setCameraMatrix ( camPosX, camPosY, camPosZ, camTargetX, camTargetY, camTargetZ )
end

local function freecamMouse (cX,cY,aX,aY)

	if isCursorShowing() or isMTAWindowActive() then
		delay = 5
		return
	elseif delay > 0 then
		delay = delay - 1
		return
	end
	
    local width, height = guiGetScreenSize()
    aX = aX - width / 2 
    aY = aY - height / 2
	
    rotX = rotX + aX * mouseSensitivity * 0.01745
    rotY = rotY - aY * mouseSensitivity * 0.01745
	
	local PI = math.pi
	if rotX > PI then
		rotX = rotX - 2 * PI
	elseif rotX < -PI then
		rotX = rotX + 2 * PI
	end
	
	if rotY > PI then
		rotY = rotY - 2 * PI
	elseif rotY < -PI then
		rotY = rotY + 2 * PI
	end
    if rotY < -PI / 2.05 then
       rotY = -PI / 2.05
    elseif rotY > PI / 2.05 then
        rotY = PI / 2.05
    end
end

function setEgoEnabled (x, y, z)

	if (x and y and z) then
	    setCameraMatrix ( camPosX, camPosY, camPosZ )
	end
	addEventHandler("onClientPreRender", getRootElement(), freecamFrame)
	addEventHandler("onClientRender", getRootElement(), freecamFrame)
	addEventHandler("onClientCursorMove",getRootElement(), freecamMouse)
end

function setEgoDisabled()

	if egoEnabled then
		egoEnabled = false
		removeEventHandler("onClientPreRender", getRootElement(), freecamFrame)
		removeEventHandler("onClientRender", getRootElement(), freecamFrame)
		removeEventHandler("onClientCursorMove",getRootElement(), freecamMouse)
		setCameraTarget ( lp )
	end
end
addEventHandler ( "onClientPlayerWasted", getLocalPlayer(), setEgoDisabled )

function ego_func ()

	if egoEnabled then
		setEgoDisabled()
	else
		egoEnabled = true
		local x, y, z = getElementPosition ( lp )
		setEgoEnabled ( x, y, z )
	end
end
addCommandHandler( "ego", ego_func)