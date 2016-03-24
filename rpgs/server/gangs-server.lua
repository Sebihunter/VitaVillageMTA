--[[
Project: VitaOnline
File: gangs-server.lua
Author(s):	Sebihunter
]]--


--[[
TODO:
Geld für Gebiet
]]--

theRPGPlayerSettingsGang = {}
gIsJailbreakRunning = false
gJailbreakTimer = nil
gJailbreakBlip = nil
gJailbreakBlock = false

gGangData = {
	[0] = { name = "Ganglos" },	
	[1] = { name = "La Piedra" },
	[2] = { name = "The Heaven Devils" },
	[3] = { name = "Da Nangs" }
}

gGangZoneData = {
	[0] = { gang =  0,x1 = 2347.00,y1=904.00,x2=2537.00,y2=1193.00},
	[1] = { gang =  0,x1 = 2073.00,y1=861.00,x2=2347.00,y2=980.00},
	[2] = { gang =  0,x1 = 2073.00,y1=980.00,x2=2347.00,y2=1193.00},
	[3] = { gang =  0,x1 = 2537.00,y1=1008.00,x2=2621.00,y2=1193.00},
	[4] = { gang =  0,x1 = 1808.00,y1=883.00,x2=2073.00,y2=1104.00},
	[5] = { gang =  0,x1 = 2419.00,y1=1193.00,x2=2600.00,y2=1374.00},
	[6] = { gang =  0,x1 = 2072.00,y1=1193.00,x2=2419.00,y2=1370.00},
	[7] = { gang =  0,x1 = 1927.00,y1=1104.00,x2=2072.00,y2=1269.00},
	[8] = { gang =  0,x1 = 1809.00,y1=1104.00,x2=1927.00,y2=1270.00},
	[9] = { gang =  0,x1 = 1811.00,y1=1270.00,x2=2072.00,y2=1465.00},
	[10] = { gang =  0,x1 = 2409.00,y1=1373.00,x2=2601.00,y2=1611.00},
	[11] = { gang =  0,x1 = 2242.00,y1=1371.00,x2=2409.00,y2=1537.00},
	[12] = { gang =  0,x1 = 2082.00,y1=1371.00,x2=2242.00,y2=1542.00},
	[13] = { gang =  0,x1 = 1571.00,y1=884.00,x2=1807.00,y2=1120.00},
	[14] = { gang =  0,x1 = 1638.00,y1=1141.00,x2=1809.00,y2=1283.00},
	[15] = { gang =  0,x1 = 1811.00,y1=1467.00,x2=2082.00,y2=1708.00},
	[16] = { gang =  0,x1 = 2082.00,y1=1542.00,x2=2242.00,y2=1710.00},
	[17] = { gang =  0,x1 = 2243.00,y1=1537.00,x2=2409.00,y2=1716.00},
	[18] = { gang =  0,x1 = 2409.00,y1=1611.00,x2=2673.00,y2=1794.00},
	[19] = { gang =  0,x1 = 2496.00,y1=1794.00,x2=2678.00,y2=1956.00},
	[20] = { gang =  0,x1 = 2145.00,y1=1710.00,x2=2409.00,y2=1873.00},
	[21] = { gang =  0,x1 = 2409.00,y1=1794.00,x2=2496.00,y2=1959.00},
	[22] = { gang =  0,x1 = 2145.00,y1=1873.00,x2=2409.00,y2=2005.00},
	[23] = { gang =  0,x1 = 1952.00,y1=1710.00,x2=2145.00,y2=2004.00},
	[24] = { gang =  0,x1 = 1636.00,y1=1708.00,x2=1952.00,y2=1875.00},
	[25] = { gang =  0,x1 = 1702.00,y1=1875.00,x2=1952.00,y2=2061.00},
	[26] = { gang =  0,x1 = 1716.00,y1=2061.00,x2=1945.00,y2=2194.00},
	[27] = { gang =  0,x1 = 1945.00,y1=2004.00,x2=2113.00,y2=2194.00},
	[28] = { gang =  0,x1 = 2113.00,y1=2005.00,x2=2353.00,y2=2156.00},
	[29] = { gang =  0,x1 = 2409.00,y1=1956.00,x2=2676.00,y2=2007.00},
	[30] = { gang =  0,x1 = 2353.00,y1=2007.00,x2=2522.00,y2=2150.00},
	[31] = { gang =  0,x1 = 2522.00,y1=2007.00,x2=2676.00,y2=2148.00},
	[32] = { gang =  0,x1 = 2413.00,y1=2148.00,x2=2652.00,y2=2309.00},
	[33] = { gang =  0,x1 = 2286.00,y1=2156.00,x2=2413.00,y2=2394.00},
	[34] = { gang =  0,x1 = 2413.00,y1=2309.00,x2=2653.00,y2=2391.00},
	[35] = { gang =  0,x1 = 2114.00,y1=2156.00,x2=2286.00,y2=2335.00},
	[36] = { gang =  0,x1 = 1937.00,y1=2194.00,x2=2114.00,y2=2388.00},
	[37] = { gang =  0,x1 = 2114.00,y1=2335.00,x2=2286.00,y2=2514.00},
	[38] = { gang =  0,x1 = 2286.00,y1=2394.00,x2=2533.00,y2=2513.00},
	[39] = { gang =  0,x1 = -2155.1960,y1= -108.1418, x2= -1992.9630,y2=124.6110},
	[40] = { gang =  0,x1 = -2155.196044,y1=124.611000,x2= -1992.963012,y2=353.418914},
	[41] = { gang =  0,x1 = -1992.963012,y1= -108.141799,x2= -1799.828857,y2=353.418914},
	[42] = { gang =  0,x1 = -2247.900878,y1=120.666000,x2= -2155.196044,y2=353.418914},
	[43] = { gang =  0,x1 = -2587.8168,y1= 160.1157, x2= -2406.2709,y2=353.4189},
	[44] = { gang =  0,x1 = -2742.323974,y1=1359.385009,x2= -2247.900878,y2=1505.348876},
	[45] = { gang =  0,x1 = -2502.8378,y1= 1158.1920,x2= -2247.9008,y2=1359.3850},
	[46] = { gang =  0,x1 = -2742.323974,y1=1047.733032,x2= -2502.837890,y2=1359.385009},
	[47] = { gang =  0,x1 = -2831.1660,y1=1118.7419, x2= -2742.3239,y2=1367.2750},
	[48] = { gang =  0,x1 = -2641.8950,y1= -368.5094, x2= -2259.4890,y2= -194.9311},
	[49] = { gang =  0,x1 = -2807.9899,y1= -431.6289,x2= -2641.8950,y2= -194.9311},
	[50] = { gang =  0,x1 = -2807.9899,y1= -194.9311, x2= -2406.2709,y2= -52.9123},
	[51] = { gang =  0,x1 = -2406.270996,y1= -194.931106,x2= -2155.196044,y2=120.666000},
	[52] = { gang =  0,x1 = -2267.2141,y1=767.6401, x2= -1989.1009,y2=968.8333},
	[53] = { gang = 0,x1 = -1989.100952,y1=759.750305,x2= -1830.730957,y2=1158.192016},
	[54] = { gang =  0,x1 = -2124.2949, y1=617.7316,x2= -1989.1009,y2=767.6401},
	[55] = { gang =  0,x1 = -2267.2141,y1= 586.1718,x2= -2124.2949,y2=767.6401},
	[56] = { gang =  0,x1 = -2267.2141,y1= 353.4189,x2= -2124.2949,y2=586.1718},
	[57] = { gang =  0,x1 = -2251.762939,y1=1154.246948,x2= -1826.868041,y2=1296.265014},
	[58] = { gang =  0,x1 = -1726.4379, y1=274.5197,x2= -1208.8380,y2=455.9880},
	[59] = { gang =  0,x1 = -1529.4410,y1=455.9880,x2= -1212.7010,y2=546.7222},
	[60] = { gang =  0,x1 = -618.9274, y1= -595.5717,x2= -443.7593,y2= -443.7593},
	[61] = { gang =  0,x1 = -618.9274, y1= -782.4177,x2= -385.3699,y2= -595.5717},
	[62] = { gang =  0,x1 = -934.2299, y1= -992.6193,x2= -618.9274,y2= -560.5380},
	[63] = { gang =  0,x1 = -1191.1429, y1= -759.0618,x2= -934.2299,y2= -432.0813},
	[64] = { gang =  0,x1 = -2807.9899,y1= 353.4189,x2= -2518.2890,y2=590.1168},
	[65] = { gang =  0,x1 = -2807.9899, y1=590.1168,x2= -2518.2890,y2=740.0255},
	[66] = { gang =  0,x1 = -2518.2890,y1=353.4189,x2= -2267.2141,y2=594.0618},
	[67] = { gang =  0,x1 = -2518.2890,y1=594.0618,x2= -2267.2141,y2=743.9703},
	[68] = { gang =  0,x1 = -2510.5629, y1=743.9703,x2= -2267.2141,y2=842.5944},
	[69] = { gang =  0,x1 = -1989.1009, y1=353.4189, x2= -1726.4379,y2=463.8779},
	[70] = { gang =  0,x1 = -1992.963012,y1=463.877899,x2= -1726.437866,y2=617.731628},
	[71] = { gang =  0,x1 = -1726.4379,y1= 455.9880,x2= -1529.4410,y2=661.1262},
	[72] = { gang =  0,x1 = -2000.688842,y1=617.731628,x2= -1714.849853,y2=759.750305},
	[73] = { gang =  0,x1 = -1714.8499, y1=661.1262,x2= -1529.4410,y2=755.8052},
	[74] = { gang =  0,x1 = -1695.5369, y1=755.8052,x2= -1417.4229,y2=854.4293},
	[75] = { gang =  0,x1 = -1830.730957,y1=759.750305,x2= -1695.536865,y2=1047.733032},
	[76] = { gang =  0,x1 = -2807.9899,y1= -52.9123,x2= -2595.5419,y2=160.1157},
	[77] = { gang =  0,x1 = -2595.5419, y1= -52.9123,x2= -2406.2709,y2=160.1157},
	[78] = { gang =  0,x1 = -2807.9899,y1= 160.1157,x2= -2684.3840,y2=353.4189},
	[79] = { gang =  0,x1 = -2684.3840,y1=160.1157,x2= -2587.8168,y2=353.4189},
	[80] = { gang =  0,x1 = -2406.270996,y1=120.666000,x2= -2247.900878,y2=353.418914},
	[81] = { gang =  0,x1 = -2124.294921,y1=353.418914,x2= -1989.100952,y2=617.731628},
	[82] = { gang =  0,x1 = -2807.9899,y1= 740.0255,x2= -2510.5629,y2=949.1085},
	[83] = { gang =  0,x1 = -2510.5629,y1= 842.5944,x2= -2267.2141,y2=1043.7879},
	[84] = { gang =  0,x1 = -2742.3239,y1= 949.1085,x2= -2506.6999,y2=1047.7330},
	[85] = { gang =  0,x1 = -2807.9899,y1= 949.1085, x2= -2742.3239,y2=1118.7419},
	[86] = { gang =  0,x1 = -2502.8378,y1= 1043.7879,x2= -2267.2141,y2=1158.1920},
	[87] = { gang =  0,x1 = -2267.2141,y1= 968.8333, x2= -1989.1009,y2=1158.1920},
	[88] = { gang =  0,x1 = -1734.1639,y1= -680.1616,x2= -1191.1429,y2= -432.0813},
	[89] = { gang =  0,x1 = -1726.4379,y1= -432.0813,x2= -1386.5219,y2=57.5466},
	[90] = { gang =  0,x1 = -1726.4379,y1= 57.5466,x2= -1123.8590,y2=274.5197},
	[91] = { gang =  0,x1 = -1386.5219,y1= -432.0813,x2= -1123.8590,y2=57.5466},
	[92] = { gang =  0,x1 = -1803.6920,y1= -108.1418,x2= -1726.4379,y2=353.4189},
	[93] = { gang =  0,x1 = -2247.900878,y1=1296.265014,x2= -1842.318847,y2=1505.348876},
	[94] = { gang =  0,x1 = -1830.730957,y1=1047.733032,x2= -1626.008056,y2=1296.265014},
	[95] = { gang =  0,x1 = 1988.037,y1= -1752.921,x2=2611.702,y2= -1614.75},
	[96] = { gang =  0,x1 = 1607.753,y1= -1452.893,x2=2056.488,y2= -1026.537},
	[97] = { gang =  0,x1 = 2216.207,y1= -2321.396,x2=2391.137,y2= -1768.712},
	[98] = { gang =  0,x1 = 2349.306,y1= -2747.752,x2=2866.492,y2= -2309.553},
	[99] = { gang =  0,x1 = 1025.919,y1= -2372.717,x2=1524.091,y2= -1910.831},
	[100] = { gang =  0,x1 = 1067.75,y1= -1587.116,x2=1368.174,y2= -1156.812},
	[101] = { gang =  0,x1 = 2615.505,y1= -1606.855,x2=2896.915,y2= -1263.401},
	[102] = { gang =  0,x1 = 1322.54,y1= -1748.974,x2=1995.642,y2= -1622.646},
	[103] = { gang =  0,x1 = 2067.896,y1= -1377.886,x2=2269.447,y2= -1223.924},
	[104] = { gang =  0,x1 = 1710.43,y1= -2210.859,x2=1961.9646,y2= -1753.6873},
	[105] = { gang =  0,x1 = 2064.094,y1= -1614.75,x2=2265.644,y2= -1381.833},
	[106] = { gang =  0,x1 = 1543.105,y1= -2388.508,x2=1721.838,y2= -1764.764},
	[107] = { gang =  0,x1 = 2296.066,y1= -1247.61,x2=2866.492,y2= -927.8433},
	[108] = { gang =  0,x1 = 200.7038,y1= -2076.636,x2=987.8908,y2= -1752.921},
	[109] = { gang =  0,x1 = 2216.207,y1= -1847.667,x2=2615.505,y2= -1752.921},
	[110] = { gang =  0,x1 = 2398.743,y1= -2159.539,x2=2790.435,y2= -1855.563},
	[111] = { gang =  0,x1 = 193.0981,y1= -1705.548,x2=664.6498,y2= -1156.812},
	[112] = { gang =  0,x1 = 2288.461,y1= -1598.959,x2=2547.053,y2= -1263.401},
	[113] = { gang =  0,x1 = 1482.26,y1= -1598.959,x2=2064.094,y2= -1464.736},
	[114] = { gang =  0,x1 = 673.3464,y1= -1731.4495,x2=924.1724,y2= -1569.8148},
	[115] = { gang =  0,x1 = 1961.9646,y1= -2209.9104,x2=2175.3706,y2= -1753.6873},
	[116] = { gang =  0,x1 = -1842.3189,y1= 1296.2650,x2= -1629.8709,y2=1576.3580},
	[117] = { gang =  0,x1 = -1502.4019,y1= 1449.6789,x2= -1332.4439,y2=1568.4680},
	[118] = { gang =  0,x1 = -1626.0080,y1=1047.7330,x2= -1452.1879,y2=1288.3750}
}

gGangZones = {}

function initGangs()	
	for gang = 0, #gGangData do
		--Erstelle GangXML wenn nicht schon erstellt
		local xml = xmlLoadFile("./xml/gangs/"..tostring(gang)..".xml")
		if not xml then
			local xmlAdded = xmlCreateFile ( "./xml/gangs/"..tostring(gang)..".xml", "data" )
			if(xmlAdded) then
				xmlSaveFile(xmlAdded)
				xmlUnloadFile(xmlAdded)
			end
		end	
		if getBankAccount(gGangData[gang].name) == nil then
			createBankAccount(gGangData[gang].name, 2, 0)
		end
	end
	
	for gangZone = 0, #gGangZoneData do
		--Erstelle GangXML wenn nicht schon erstellt
		local xml = xmlLoadFile("./xml/gangs/zones/"..tostring(gangZone)..".xml")
		if not xml then
			xml = xmlCreateFile ( "./xml/gangs/zones/"..tostring(gangZone)..".xml", "data" )
		end
		
		local child = xmlFindChild ( xml, "gangZoneOwner",0 )
		if not child then
			child = xmlCreateChild ( xml, "gangZoneOwner" )
			xmlNodeSetValue(child, "0")
		end

		gGangZones[gangZone] = createRadarArea ( gGangZoneData[gangZone].x1, gGangZoneData[gangZone].y1, gGangZoneData[gangZone].x2-gGangZoneData[gangZone].x1, gGangZoneData[gangZone].y2-gGangZoneData[gangZone].y1, 255, 255, 255, 100 )
		local gang = tonumber(xmlNodeGetValue(child))
		if gang == 1 then
			setRadarAreaColor ( gGangZones[gangZone], 255, 0, 0, 50 ) 
		elseif gang == 2 then
			setRadarAreaColor ( gGangZones[gangZone], 0, 255, 0, 50 ) 
		elseif gang == 3 then
			setRadarAreaColor ( gGangZones[gangZone], 255, 255, 0, 50 )
		else
			setRadarAreaColor ( gGangZones[gangZone], 255, 255, 255, 50 ) 
		end
		setElementData( gGangZones[gangZone], "gangZoneID", gangZone )
		setElementData( gGangZones[gangZone], "gangZoneOwner", gang )
		for gang = 1, #gGangData do
			setElementData( gGangZones[gangZone], "gangZonePeople"..gang, 0 )
		end
		setElementData( gGangZones[gangZone], "gangZoneWar", 0)
		setElementData( gGangZones[gangZone], "gangZoneWarSeconds", 0)
		xmlSaveFile(xml)
		xmlUnloadFile(xml)		
	end
end

function saveGangs()
	if isThereFailMySQL == true then return end
	for gangZone = 0, #gGangZoneData do
		if tostring(getElementData(gGangZones[gangZone], "gangZoneOwner")) ~= nil or tostring(getElementData(gGangZones[gangZone], "gangZoneOwner")) ~= false then
			local xml = xmlLoadFile("./xml/gangs/zones/"..tostring(gangZone)..".xml")
			local child = xmlFindChild ( xml, "gangZoneOwner",0 )
			xmlNodeSetValue(child, tostring(getElementData(gGangZones[gangZone], "gangZoneOwner")))
			xmlSaveFile ( xml )
			xmlUnloadFile ( xml )
		end
	end
end		
addEventHandler("onResourceStop", getResourceRootElement(getThisResource()),saveGangs)

function getElementCurrentGangArea(element)
	local areas = getElementsByType ( "radararea" )
	local x,y,z = getElementPosition(element)
	for theKey,theArea in ipairs(areas) do
		if isInsideRadarArea ( theArea, x, y ) then
			return theArea
		end
	end
	return false
end

function gangWarCMD ( player )
	if ( player ) then
		if getElementData(player, "gang") ~= 0 then
			local gangArea = getElementCurrentGangArea(player)
			if gangArea ~= false then
				setElementData(gangArea, "gangZoneStart", true)
				setTimer(function() setElementData(gangArea, "gangZoneStart", false) end, 3000,1)
			end	
		end
	end
end
addCommandHandler ( "gangwar", gangWarCMD )

function callGang(source, commandName)
    if getElementData(source, "isPlayerLoggedIn") == true then
		if getElementData(source, "gang") == 0 then return end
		local x, y, z = getElementPosition(source)
		local zone = getZoneName ( x, y, z )
		local city = getZoneName ( x, y, z, true )
		for numb,ply in ipairs(getElementsByType("player")) do
			if getElementData(ply, "gang") == getElementData(source, "gang") and getElementData(ply, "dienst") == 0 then
				outputChatBox ( getPlayerName(source).." benötigt die Gang in "..zone.." ("..city..").", ply, 125, 0, 125, true )
				outputChatBox ( "Ein Icon ist für 3 Minuten auf der Karte sichtbar.", ply, 125, 0, 125, true )
				local blip = createBlipAttachedTo ( source, 0, 5, 125,0, 125, 255, 0, 99999.0, ply )
				setTimer(
					function()
						destroyElement(blip)
					end
				,180000,1, blip)					
			end
		end
	end
end
addCommandHandler("gangcall", callGang, false, false)

function startJailbreak(player)
	if gJailbreakBlock == true then
		triggerClientEvent ( player, "addNotification", getRootElement(), 1, 255,0,0, "Du kannst im Moment keinen Knastausbruch starten." )
		return
	end
	if gIsJailbreakRunning == false then
		if #gJailPlayers ~= 0 then
			local cops = {}
			for i,v in ipairs(getElementsByType("player")) do
				if getElementData(v, "job") == 3 and getElementData(v, "dienst") == 1 then
					cops[#cops+1] = v
				end
			end
			if #cops < 3 then
				triggerClientEvent ( player, "addNotification", getRootElement(), 1, 255,0,0, "Es müssen mindestens 3 Cops im Dienst sein um den Knastausbruch zu starten." )
				return
			end
			if gJailbreakTimer and isTimer(gJailbreakTimer) then killTimer(gJailbreakTimer) end
			
			local jb = createElement("jailbreak")
			setElementID ( jb, "jailbreak")
			setElementData(jb, "percent",0)
			
			gJailbreakTimer = setTimer ( gJailbreakFunction, 1000, 300, jb)
			gJailbreakBlip = createBlip ( 2296,2429,10, 0, 5, 51, 153, 255,255,0,99999.0,getRootElement())
			
			setElementVisibleTo ( gJailbreakBlip , getRootElement(), false )
			for i,v in ipairs(cops) do
				setElementVisibleTo(gJailbreakBlip, v, true)
				triggerClientEvent ( v, "addNotification", getRootElement(), 3, 255,255,0, "Ein versuchter Knastausbruch findet in der Polizeistation statt." )
				callClientFunction(v, "playDispatch", "Achtung an alle Einheiten: Ein versuchter Knastausbruch findet in der Polizeistation statt.")
				outputChatBox ( "Ein versuchter Knastausbruch findet in der Polizeistation statt.", v, 255, 255, 0, true )					
			end
			gIsJailbreakRunning = true
			
			triggerClientEvent ( player, "addNotification", getRootElement(), 2, 0,255,0, "Knastausbruch gestartet\nEs muss bis zur Beendigung mindestens ein Gangmitglied beim Tor bleiben." )
		else
			triggerClientEvent ( player, "addNotification", getRootElement(), 1, 255,0,0, "Es befindet sich derzeit niemand im Knast." )
		end
	else
		triggerClientEvent ( player, "addNotification", getRootElement(), 1, 255,0,0, "Es ist bereits ein Knastausbruch im Gange." )
	end  
end

function gJailbreakFunction(jb)
	local _,int,_ = getTimerDetails ( gJailbreakTimer )
	setElementData(jb, "percent", (300-int)/300)
	
	local inArea = {}
	local cops = {}
	
	for i,v in ipairs(getElementsByType("player")) do
		local x,y,z = getElementPosition(v)
		if getElementData(v, "job") == 3 and getElementData(v, "dienst") == 1 then
			cops[#cops+1] = v
		elseif getElementData(v, "dienst") ~= 1 and getElementData(v, "gang") ~= 0 and getElementInterior(v) == 3 and getDistanceBetweenPoints2D(x,y,210,167) < 50 and (getElementData(v, "einsperrzeit") == false or getElementData(v, "einsperrzeit") == 0) and gHasPlayerHandschellen[v] ~= 1 and getElementData(v, "afk") ~= true and getElementData(v, "isWaitingForDeath") ~= true then
			inArea[#inArea+1] = v
		end
	end	
	
	if #inArea == 0 then
		for i,v in ipairs(cops) do
			triggerClientEvent ( v, "addNotification", getRootElement(), 2, 0,255,0, "Knastausbruch erfolgreich verhindert." )
		end
		if gJailbreakTimer and isTimer(gJailbreakTimer) then killTimer(gJailbreakTimer) end
		if gJailbreakBlip and isElement(gJailbreakBlip) then destroyElement(gJailbreakBlip) end
		if jb and isElement(jb) then destroyElement(jb) end
		gIsJailbreakRunning = false
		gJailbreakBlock = true
		setTimer(function() gJailbreakBlock = false end, 1800000, 1)
		return
	end
	
	if int == 1 then
		if gJailbreakTimer and isTimer(gJailbreakTimer) then killTimer(gJailbreakTimer) end
		if gJailbreakBlip and isElement(gJailbreakBlip) then destroyElement(gJailbreakBlip) end
		if jb and isElement(jb) then destroyElement(jb) end
		gIsJailbreakRunning = false
		gJailbreakBlock = true
		setTimer(function() gJailbreakBlock = false end, 1800000, 1)
		for i,v in ipairs(cops) do
			triggerClientEvent ( v, "addNotification", getRootElement(), 1, 255,0,0, "Knastausbruch war leider erfolgreich." )
		end		
		for i,v in ipairs(inArea) do
			triggerClientEvent ( v, "addNotification", getRootElement(), 2, 0,255,0, "Knastausbruch war erfolgreich." )
		end
		for i,v in ipairs(gJailPlayers) do
			triggerClientEvent ( v, "addNotification", getRootElement(), 2, 0,255,0, "Eine Gang hat einen erfolgreichen Knastausbruch verübt\nDu bist frei!" )
			setElementPosition(v, 229.768,154.3054,1003.023)
			local etime = getElementData(v, "einsperrzeit")
			setElementData(v, "einsperrzeit", 0)
			if cabinMoney[v] then
				systemDeposit("Polizei", cabinMoney[v])
				cabinMoney[v] = 0
			end
			local myakte
			for i,v2 in ipairs(getElementsByType("wanted")) do
				if string.lower(getElementData(v2, "name")) == string.lower(getPlayerName(v)) then
					myakte = v2
					break
				end
			end
			id = tonumber(id)
			if not myakte then
				myakte = createElement("wanted")
				setElementData(myakte, "wantedLevel", 0)
				setElementData(myakte, "text", {})
				setElementData(myakte, "name", getPlayerName(v))
			end		
			setElementData(myakte, "wantedLevel", 6)	
			local text = getElementData(myakte, "text")
			text[#text+1] = "Knastausbruch - Nicht abgesessen: "..etime.." Minuten"
			setElementData(myakte, "text", text)			
		end
	end
end

setTimer(function()
	for gangZone = 0, #gGangZoneData do
		for gang = 1, #gGangData do
			if gGangZones[gangZone] and isElement(gGangZones[gangZone]) then
				setElementData( gGangZones[gangZone], "gangZonePeople"..gang, 0 )
			end
		end
	end
	
	local players = getElementsByType ( "player" )
	for theKey,player in ipairs(players) do
		setElementData(player, "gangText", false)
		if getElementData(player, "gang") ~= 0 and getElementData(player, "dienst") == 0 then	
			local gangArea = getElementCurrentGangArea(player)
			if gangArea ~= false then
				setElementData(gangArea, "gangZonePeople"..getElementData(player, "gang"), getElementData(gangArea, "gangZonePeople"..getElementData(player, "gang"))+1)
				if getElementData(gangArea,"gangZoneWar") ~= 0 then
					setElementData(player, "gangText", tostring(10*60-tonumber(getElementData(gangArea,"gangZoneWarSeconds"))))
				end
			end
		end
	end
	for gangZone = 0, #gGangZoneData do
		for gang = 1, #gGangData do
			if gGangZones[gangZone] and isElement(gGangZones[gangZone]) then
				if getElementData(gGangZones[gangZone], "gangZonePeople"..gang) >= 3 then
					if getElementData(gGangZones[gangZone],"gangZoneWar") == 0 and getElementData(gGangZones[gangZone],"gangZoneOwner") ~= gang and getElementData(gGangZones[gangZone],"gangZoneWaiting") == false and getElementData(gGangZones[gangZone],"gangZoneStart") == true then
						setRadarAreaFlashing ( gGangZones[gangZone], true )
						setElementData( gGangZones[gangZone], "gangZoneWar", gang)
						gGangZoneData[gangZone].blip = createBlip(gGangZoneData[gangZone].x1+(gGangZoneData[gangZone].x2-gGangZoneData[gangZone].x1)/2,gGangZoneData[gangZone].y1+(gGangZoneData[gangZone].y2-gGangZoneData[gangZone].y1)/2,0,19, 1,255,255,255,255,0,200)
						for theKey,player in ipairs(players) do
							if getElementData(player, "dienst") == 0 and getElementData(player, "gang") == getElementData( gGangZones[gangZone], "gangZoneOwner" ) and getElementData( gGangZones[gangZone], "gangZoneOwner" ) ~= 0 then
								outputChatBox("Ein Gebiet deiner Gang wird angegriffen! Du hast 10 Minuten Zeit es zu verteidigen.", player,111,10,86)
							elseif getElementData(player, "dienst") == 0 and getElementData(player, "gang") == gang then
								outputChatBox("Deine Gang greift ein feindliches Ganggebiet an.", player,111,10,86)
								outputChatBox("Versuche für 10 Minuten mindestens 3 Spieler in diesem Gebiet zu postieren um es zu übernehmen.", player,111,10,86)
							end
						end
						setElementData( gGangZones[gangZone], "gangZoneWarSeconds", 1)
					elseif getElementData(gGangZones[gangZone],"gangZoneWar") == gang then
						setElementData(gGangZones[gangZone], "gangZoneWarSeconds", getElementData(gGangZones[gangZone], "gangZoneWarSeconds")+1)
						if getElementData(gGangZones[gangZone], "gangZoneWarSeconds") == 10*60 then --10 Minuten
							setRadarAreaFlashing ( gGangZones[gangZone], false )
							if gang == 1 then
								setRadarAreaColor ( gGangZones[gangZone], 255, 0, 0, 50 ) 
							elseif gang == 2 then
								setRadarAreaColor ( gGangZones[gangZone], 0, 255, 0, 50 ) 
							elseif gang == 3 then
								setRadarAreaColor ( gGangZones[gangZone], 255, 255, 0, 50 ) 
							end
							setElementData( gGangZones[gangZone], "gangZoneWar", 0)
							setElementData( gGangZones[gangZone], "gangZoneWarSeconds", 0)	
							setElementData(gGangZones[gangZone],"gangZoneWaiting", true)
							gGangZoneData[gangZone].blip2 = createBlip(gGangZoneData[gangZone].x1+(gGangZoneData[gangZone].x2-gGangZoneData[gangZone].x1)/2,gGangZoneData[gangZone].y1+(gGangZoneData[gangZone].y2-gGangZoneData[gangZone].y1)/2,0,20, 1,255,255,255,255,0,200)
							setTimer(function(blip, zone)
								destroyElement(blip)
								setElementData(zone,"gangZoneWaiting", false)
							end, 1000*60*15,1, gGangZoneData[gangZone].blip2, gGangZones[gangZone])
							destroyElement(gGangZoneData[gangZone].blip)
							gGangZoneData[gangZone].blip = nil	
							for theKey,player in ipairs(players) do
								if getElementData(player, "dienst") == 0 and getElementData(player, "gang") == getElementData( gGangZones[gangZone], "gangZoneOwner" ) and getElementData( gGangZones[gangZone], "gangZoneOwner" ) ~= 0 then
									outputChatBox("Ganggebiet konnte nicht verteidigt werden. Gebietschutz für 15 Minuten.", player,111,10,86)
								elseif getElementData(player, "dienst") == 0 and getElementData(player, "gang") == gang then
									outputChatBox("Übernahme eines feindlichen Ganggebietes erfolgreich. Gebietschutz für 15 Minuten.", player,111,10,86)
								end
							end
							setElementData( gGangZones[gangZone], "gangZoneOwner", gang)
						end
					end
				else
					if getElementData(gGangZones[gangZone],"gangZoneWar") == gang and getElementData(gGangZones[gangZone], "gangZonePeople"..gang) < 3 then
						setRadarAreaFlashing ( gGangZones[gangZone], false )
						setElementData( gGangZones[gangZone], "gangZoneWar", 0)
						setElementData( gGangZones[gangZone], "gangZoneWarSeconds", 0)
						setElementData(gGangZones[gangZone],"gangZoneWaiting", true)
						gGangZoneData[gangZone].blip2 = createBlip(gGangZoneData[gangZone].x1+(gGangZoneData[gangZone].x2-gGangZoneData[gangZone].x1)/2,gGangZoneData[gangZone].y1+(gGangZoneData[gangZone].y2-gGangZoneData[gangZone].y1)/2,0,20, 1,255,255,255,255,0,200)
						setTimer(function(blip, zone)
							destroyElement(blip)
							setElementData(zone,"gangZoneWaiting", false)
						end, 1000*60*30,1, gGangZoneData[gangZone].blip2, gGangZones[gangZone])
						destroyElement(gGangZoneData[gangZone].blip)
						gGangZoneData[gangZone].blip = nil
						for theKey,player in ipairs(players) do
							if getElementData(player, "dienst") == 0 and getElementData(player, "gang") == getElementData( gGangZones[gangZone], "gangZoneOwner" ) and getElementData( gGangZones[gangZone], "gangZoneOwner" ) ~= 0 then
								outputChatBox("Ganggebiet erfolgreich verteidigt. Gebietschutz für 15 Minuten.", player,111,10,86)
							elseif ggetElementData(player, "dienst") == 0 and etElementData(player, "gang") == gang then
								outputChatBox("Übernahme eines feindlichen Ganggebietes fehlgeschlagen. Gebietschutz für 15 Minuten.", player,111,10,86)
							end
						end
					end
				end
			end
		end
	end	
end, 1000, 0)

function sendGangNoteToPlayer(ply)
	local xml = xmlLoadFile("./xml/gangs/"..tostring(getElementData(ply, "gang"))..".xml")
	if xml then
		local text = xmlFindChild ( xml, "text",0 )
		if not text then
			text = xmlCreateChild ( xml, "text" )
			xmlNodeSetValue(text,"Keine")
		end
		callClientFunction(ply, "recieveGangNote", xmlNodeGetValue(text))
		xmlSaveFile(xml)
		xmlUnloadFile(xml)
	end
end

function saveGangNote(ply, text)
	local xml = xmlLoadFile("./xml/gangs/"..tostring(getElementData(ply, "gang"))..".xml")
	if xml then
		local textnode = xmlFindChild ( xml, "text",0 )
		xmlNodeSetValue(textnode, tostring(text))
		xmlSaveFile(xml)
		xmlUnloadFile(xml)		
	end
end

function getGangPlayers(source)
		if mysql_ping ( g_mysql["connection"] ) == false then
			onResourceStopMysqlEnd()
			hasPlayersLoaded = false
			onResourceStartMysqlConnection()
		end	
		
		local i = 1
		theRPGPlayerSettingsGang = {}

		local result = mysql_query(g_mysql["connection"], "SELECT * FROM `users` ORDER BY `id` ASC")
		if result then
			while true do
				local row = mysql_fetch_assoc(result)
				if not row then break end
					
				theRPGPlayerSettingsGang[i] = {}
				theRPGPlayerSettingsGang[i]["name"] = row["name"]	
				local ply = getPlayerFromName(theRPGPlayerSettingsGang[i]["name"])
				if ply then
					theRPGPlayerSettingsGang[i]["gang"] = getElementData(ply, "gang")	
					theRPGPlayerSettingsGang[i]["gangrank"] = getElementData(ply, "gangrank")					
				else
					theRPGPlayerSettingsGang[i]["gang"] = row["gang"]
					theRPGPlayerSettingsGang[i]["gangrank"] = row["gangrank"]
				end
				i = i+1
			end
			mysql_free_result(result)		
		end
		callClientFunction(source, "recieveGangPlayers", theRPGPlayerSettingsGang)
end

function quitGang ( source, commandName)
	if getElementData(source, "gang") ~= 0 then
		outputChatBox("Du hast die Gang erfolgreich verlassen.",source,0,255,0)
		setElementData(source, "gang", 0)
		setElementData(source, "gangrank", 0)
	else
		outputChatBox("Du bist in keiner Gang die du verlassen könntest.", source,255,0,0)
	end
end
addCommandHandler("gangverlassen", quitGang, false, false) 

function kickFromGang ( source, commandName, playername)
	if getElementData(source, "gangrank") == 2 then
		if playername == getPlayerName(source) then			
			outputChatBox("Du Depp kannst dich doch nicht selbst rauschmeißen!",source,255,0,0)
		else
			local sply = getPlayerFromName2 ( playername )
			if sply then
				if type(sply) == "table" then
					outputChatBox("Fehler: Mehrere Spieler gefunden!",source,255,0,0)
					return
				end
				playername = getPlayerName(sply)
				if getElementData(source, "gang") == getElementData(sply, "gang") then
					setElementData(sply, "gang", 0)
					setElementData(sply, "gangrank", 0)
					outputChatBox("Der Spieler "..tostring(playername).." wurde rausgeschmissen!",source,0,255,0)
					outputChatBox("Du wurdest von "..getPlayerName(source).." aus der Gang geschmissen.",sply,0,255,0)
				else
					outputChatBox("Diese Person ist nicht in deiner Gang.",source,255,0,0)
				end
			else
				outputChatBox("Die Person, die du kicken willst befindet sich gerade nicht auf dem Server:",source,125,125,125)
				outputChatBox("Es wurde versucht die Person dennoch zu verweißen.",source,125,200,125)
				setPlayerUserFileData(playername, "gang", 0)
				setPlayerUserFileData(playername, "gangrank", 0)
			end
		end
	end
end
addCommandHandler("rausausgang", kickFromGang, false, false)

function addToGang ( source, commandName, playername)
	if getElementData(source, "gangrank") == 2 then
		if playername == getPlayerName(source) then
			outputChatBox("Du Depp kannst dich doch nicht selbst aufnehmen!",source,255,0,0)
		else
			local sply = getPlayerFromName2 ( playername )
			if sply then
				if type(sply) == "table" then
					outputChatBox("Fehler: Mehrere Spieler gefunden!",source,255,0,0)
					return
				end
				playername = getPlayerName(sply)
				if getElementData(sply, "gang") == 0 then
					setElementData(sply, "gang", getElementData(source, "gang"))
					setElementData(sply, "gangrank", 1)
					outputChatBox("Der Spieler "..tostring(playername).." wurde aufgenommen!",source,0,255,0)
					outputChatBox("Du wurdest von "..getPlayerName(source).." in die Gang aufgenommen.",sply,0,255,0)
				else
					outputChatBox("Diese Person ist bereits in einer Gang.",source,255,0,0)
				end
			else
				outputChatBox("Die Person, die du aufnehmen willst, existiert entweder nicht oder befindet sich gerade nicht auf dem Server.",source,255,0,0)
			end
		end
	end
end
addCommandHandler("aufingang", addToGang, false, false)

function addVehicleToGang(source, commandName)
	local vehicle = getPedOccupiedVehicle ( source )
	if getElementData(source, "gang") ~= 0 and getElementData(source, "gangrank") == 2 and vehicle ~= false then
		if getElementData ( vehicle, "owner" ) == getPlayerName(source) then
			setElementData ( vehicle, "owner", "g"..tostring(getElementData(source, "gang")) )
			outputChatBox("Du hast das Fahrzeug an die Gang überschrieben.",source,0,255,0)
		else
			outputChatBox("Dieses Fahrzeug gehört nicht dir.",source,255,0,0)
		end
	end
end
addCommandHandler("autoangang", addVehicleToGang, false, false)

--Tore

local BikeKeyPad1 = createObject ( 2886, -260.10000610352, 1213.3000488281, 20.39999961853, 0, 0, 270 )
local BikeKeyPad2 = createObject ( 2886, -259.79998779297, 1213.4000244141, 20.39999961853, 0, 0, 90 )
setElementData(BikeKeyPad1, "cinfo", {"Tor Öffnen/Schließen"})
setElementData(BikeKeyPad2, "cinfo", {"Tor Öffnen/Schließen"})
local BikeGate = createObject ( 3037, -260, 1217.9000244141, 20.89999961853, 0, 0, 0 )
setElementData ( BikeGate, "state", "up", true )
function BikerGeatf( theButton, theState, player, clickPosX, clickPosY, clickPosZ )	
	if getElementData ( BikeGate, "state" ) == "up" and theButton == "left" and theState == "down" and getElementData(player, "gang") == 2 then
		moveObject ( BikeGate, 2500, -260, 1217.9000244141, 25.119998931885 )
		setElementData ( BikeGate, "state", "down", true )
	elseif getElementData ( BikeGate, "state" ) == "down" and theButton == "left" and theState == "down" and getElementData(player, "gang") == 2 then
		moveObject ( BikeGate, 2500, -260, 1217.9000244141, 20.89999961853 )
		setElementData ( BikeGate, "state", "up", true )
	end
end
addEventHandler("onElementClicked", BikeKeyPad1, BikerGeatf )
addEventHandler("onElementClicked", BikeKeyPad2, BikerGeatf )

--La Piedra tor
local tor1 = createObject( 2990, -2485.8000488281, -615.59997558594, 135.455, 0, 0, 86.5 )
local tor_key1 = createObject( 2886, -2485.25, -610.40002441406, 133, 0, 0, 86.5 )
local tor_key2 = createObject( 2886, -2486.6101074219, -620.40002441406, 133, 0, 0, 266.25 )
setElementData( tor_key1, "cinfo", {"Tor öffnen/schließen"} )
setElementData( tor_key2, "cinfo", {"Tor öffnen/schließen"} )

setElementData( tor1, "doubleside", true )

function piedra_tor_func ( button, state, player )
	if getElementData( player, "gang" ) ~= 1 then return end
	if getElementData( tor1, "moving" ) == true then return end
	setElementData( tor1, "moving", true )
	
    setTimer(function()
        setElementData(tor1, "moving", false)
    end, 2600, 1)
	
	if getElementData( tor1, "state" ) == "open" then
		moveObject( tor1, 2500, -2485.8000488281, -615.59997558594, 135.455 )
		setElementData( tor1, "state", "closed" )
	else
		moveObject( tor1, 2500, -2485.8000488281, -615.59997558594, 127.59999847412 )
		setElementData( tor1, "state", "open" )
	end
end
addEventHandler( "onElementClicked", tor_key1, piedra_tor_func )
addEventHandler( "onElementClicked", tor_key2, piedra_tor_func )
--Ende la piedra

local tor1 = createObject( 9093, -1466.7199707031, 2660.9099121094, 56.549999237061, 0, 0, 270 )
local tor_key1 = createObject( 2886, -1470.8000488281, 2661.1000976563, 56.400001525879, 0, 0, 180 )
local tor_key2 = createObject( 2886, -1462.6999511719, 2660.4499511719, 56.400001525879, 0, 0, 0 )
setElementData( tor_key1, "cinfo", {"Tor öffnen/schließen"} )
setElementData( tor_key2, "cinfo", {"Tor öffnen/schließen"} )

setElementData( tor1, "doubleside", true )

function danangs_tor_func ( button, state, player )
	if getElementData( player, "gang" ) ~= 3 then return end
		if getElementData( tor1, "moving" ) == true then return end
			setElementData( tor1, "moving", true )
			setTimer( setElementData, 2600, 1, tor1, "moving", false ) 
		if getElementData( tor1, "state" ) == "open" then
			moveObject( tor1, 2500, -1466.7199707031, 2660.9099121094, 56.549999237061 )
			setElementData( tor1, "state", "closed" )
	else
		moveObject( tor1, 2500, -1466.7199707031, 2660.9099121094, 53.069999694824 )
		setElementData( tor1, "state", "open" )
	end
end
addEventHandler( "onElementClicked", tor_key1, danangs_tor_func )
addEventHandler( "onElementClicked", tor_key2, danangs_tor_func )


local marker11 = createMarker(-2521.4228,-624.6962,132.7822, "corona", 1.0, 255, 0, 0, 255, getRootElement())
local marker22 = createMarker(318.08203125, 1115.243164062, 1083.8830 , "corona", 1.0, 255, 0, 0, 255, getRootElement())
setElementInterior ( marker22, 5 )

local inLaPiedraTeleport = false
function teleportLapiadra1 ( hitElement, matchingDimension )
	if not isPedInVehicle (hitElement) then
		if inLaPiedraTeleport == true then return end
		if getElementType ( hitElement  ) ~= "player" then return end
		if getElementData ( hitElement, "gang") ~= 1 then return end	
		inLaPiedraTeleport = true
		setTimer(function() inLaPiedraTeleport = false end, 1000, 1)		
		setElementInterior ( hitElement, 5, 318.08203125, 1115.243164062, 1083.8830  )
	end
end
function teleportLapiadra2 ( hitElement, matchingDimension )
	if inLaPiedraTeleport == true then return end
	if getElementType ( hitElement  ) ~= "player" then return end
	inLaPiedraTeleport = true
	setTimer(function() inLaPiedraTeleport = false end, 1000, 1)	
	setElementInterior ( hitElement, 0, -2521.4228,-618.6962,132.7822 )
end
addEventHandler("onMarkerHit", marker11, teleportLapiadra1 )
addEventHandler("onMarkerHit", marker22, teleportLapiadra2 )