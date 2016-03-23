--[[
Project: VitaOnline
File: stadtverwaltung-server.lua
Author(s):	Sebihunter
			Einstein
			Werni
]]--

local svText = {}
local dreckberg = {}
local dreckmodels = {849, 854, 851, 2670, 852}
dreckberg[1] = {1645.98046875, 936.29296875, 10.761494636536}
dreckberg[2] = {1578.841796875, 936.9033203125, 10.671875}
dreckberg[3] = {1570.2333984375, 951.8017578125, 10.671875}
dreckberg[4] = {1569.6513671875, 1039.939453125, 10.738405227661}
dreckberg[5] = {1568.724609375, 1120.603515625, 10.671875}
dreckberg[6] = {1519.9169921875, 1134.5400390625, 10.671875}
dreckberg[7] = {1451.8759765625, 1138.396484375, 10.671875}
dreckberg[8] = {1447.447265625, 1190.2802734375, 10.679662704468}
dreckberg[9] = {1372.060546875, 1195.453125, 10.671875}
dreckberg[10] = {1217.6474609375, 1198.3466796875, 13.762510299683}
dreckberg[10] = {1051.111328125, 1195.8310546875, 10.671875}
dreckberg[11] = {1009.6943359375, 1221.1572265625, 10.671875}
dreckberg[12] = {1010.705078125, 1359.8232421875, 10.671875}
dreckberg[13] = {1081.29296875, 1370.06640625, 10.671875}
dreckberg[14] = {1166.908203125, 1376.228515625, 10.671875}
dreckberg[15] = {1167.814453125, 1431.9375, 5.8203125}
dreckberg[16] = {1094.904296875, 1432.591796875, 5.8203125}
dreckberg[17] = {1026.9443359375, 1428.5185546875, 5.8203125}
dreckberg[18] = {1020.8125, 1375.9140625, 10.736482620239}
dreckberg[19] = {1009.50390625, 1493.95703125, 10.671875}
dreckberg[20] = {1010.275390625, 1687.14453125, 10.7734375}
dreckberg[21] = {1010.853515625, 1808.615234375, 10.792903900146}
dreckberg[22] = {1123.1484375, 1812.5224609375, 10.671875}
dreckberg[23] = {1320.5234375, 1811.712890625, 10.671875}
dreckberg[24] = {1356.9326171875, 1870.638671875, 10.671875}
dreckberg[25] = {1389.5341796875, 1901.1640625, 10.671875}
dreckberg[26] = {1389.0966796875, 1987.736328125, 10.679672241211}
dreckberg[27] = {1392.0146484375, 2046.7490234375, 10.744769096375}
dreckberg[28] = {1449.916015625, 2050.7646484375, 10.671875}
dreckberg[29] = {1530.2841796875, 2081.6611328125, 10.671875}
dreckberg[30] = {1531.9365234375, 2166.5224609375, 10.671875}
dreckberg[31] = {1570.291015625, 2190.6865234375, 10.671875}
dreckberg[32] = {1596.2685546875, 2270.2041015625, 10.671875}
dreckberg[33] = {1712.181640625, 2270.06640625, 10.671875}
dreckberg[34] = {1868.6279296875, 2271.5341796875, 10.671875}
dreckberg[35] = {1916.44921875, 2271.755859375, 10.671875}
dreckberg[36] = {1984.4677734375, 2281.3857421875, 10.671875}
dreckberg[37] = {2088.140625, 2280.109375, 10.679672241211}
dreckberg[38] = {2124.2939453125, 2228.3955078125, 10.671875}
dreckberg[39] = {2125.4873046875, 2163.33984375, 10.67187}
dreckberg[40] = {2178.8564453125, 2135.6064453125, 10.671875}
dreckberg[41] = {2328.091796875, 2135.392578125, 10.671875}
dreckberg[42] = {2431.2568359375, 2135.37890625, 10.671875}
dreckberg[43] = {2514.673828125, 2135.453125, 10.671875}
dreckberg[44] = {2564.1630859375, 2110.6259765625, 10.671875}
dreckberg[45] = {2710.4501953125, 2110.48046875, 13.779481887817}
dreckberg[46] = {2844.0390625, 2096.2587890625, 10.679662704468}
dreckberg[47] = {2814.052734375, 1966.376953125, 10.679672241211}
dreckberg[48] = {2619.1005859375, 1956.1630859375, 10.671875}
dreckberg[49] = {2548.5322265625, 1968.271484375, 10.8203125}
dreckberg[50] = {2505.087890625, 1916.265625, 10.671875}
dreckberg[51] = {2505.0537109375, 1804.3447265625, 10.671875}
dreckberg[52] = {2541.77734375, 1708.6728515625, 10.671875}
dreckberg[53] = {2543.8759765625, 1626.3740234375, 10.671875}
dreckberg[54] = {2604.35546875, 1565.47265625, 10.671875}
dreckberg[55] = {2631.2548828125, 1469.6015625, 10.842329025269}
dreckberg[56] = {2705.7041015625, 1267.197265625, 6.734375}
dreckberg[57] = {2693.01171875, 1046.4306640625, 6.734375}
dreckberg[58] = {2572.015625, 891.36328125, 6.734375}
dreckberg[59] = {2400.1982421875, 869.505859375, 6.6892681121826}
dreckberg[60] = {2290.9794921875, 925.673828125, 10.946930885315}
dreckberg[61] = {2284.2998046875, 880.259765625, 12.291244506836}
dreckberg[62] = {2285.1162109375, 735.77734375, 10.671875}
dreckberg[63] = {2250.2607421875, 635.1416015625, 10.671875}
dreckberg[64] = {2131.1591796875, 675.3251953125, 10.671875}
dreckberg[65] = {1986.888671875, 672.35546875, 10.864924430847}
dreckberg[66] = {1908.9462890625, 635.73828125, 10.671875}
dreckberg[67] = {1869.751953125, 701.802734375, 10.858949661255}
dreckberg[68] = {1911.3759765625, 770.21875, 10.671875}
dreckberg[69] = {2007.2685546875, 751.962890625, 10.671875}
dreckberg[70] = {2140.8017578125, 751.7919921875, 10.781144142151}
dreckberg[71] = {2150.25390625, 840.2890625, 13.884880065918}
dreckberg[72] = {2133.7275390625, 975.3544921875, 10.671875}
dreckberg[73] = {2017.875, 975.0546875, 10.671875}
dreckberg[74] = {1922.2802734375, 935.5166015625, 10.671875}
dreckberg[75] = {1869.9326171875, 1012.88671875, 10.679672241211}
dreckberg[76] = {1870.248046875, 1115.611328125, 10.671875}
dreckberg[78] = {1761.3076171875, 1134.7197265625, 12.355081558228}
dreckberg[79] = {1623.640625, 1135.4365234375, 10.671875}
dreckberg[80] = {1564.626953125, 1074.8779296875, 10.671875}
dreckberg[81] = {1562.591796875, 946.9541015625, 10.518149375916}
dreckberg[82] = {1629.4375, 929.9248046875, 10.679662704468}
dreckberg[83] = {1675.6826171875, 953.9375, 10.671875}
dreckberg[84] = {1565.1484375, 763.7001953125, 10.671875}
dreckberg[85] = {1532.189453125, 655.7099609375, 10.782842636108}
dreckberg[86] = {1498.8681640625, 706.9072265625, 10.671875}
dreckberg[87] = {1412.7333984375, 656.294921875, 10.671875}
dreckberg[88] = {1411.408203125, 834.1025390625, 6.8125}
dreckberg[89] = {1802.576171875, 1101.205078125, 6.734375}
dreckberg[90] = {1863.4287109375, 1663.4423828125, 9.9997005462646}
dreckberg[91] = {2095.1005859375, 1756.0146484375, 10.679658889771}
dreckberg[92] = {2257.51171875, 1772.19921875, 10.671875}
dreckberg[93] = {2424.1767578125, 1768.0322265625, 10.671875}
dreckberg[94] = {2420.8701171875, 2018.228515625, 10.671875}
dreckberg[95] = {2289.9150390625, 2370.7958984375, 10.732476234436}
dreckberg[96] = {2368.296875, 2485.5478515625, 10.671875}
dreckberg[97] = {2384.2890625, 2639.9267578125, 13.52156829834}
dreckberg[98] = {2474.7685546875, 2772.3369140625, 10.721720695496}
dreckberg[99] = {2127.0302734375, 2823.142578125, 10.671875}
dreckberg[100] = {1988.3935546875, 2742.986328125, 10.671875}
dreckberg[101] = {1688.73046875, 2758.1259765625, 10.671875}
dreckberg[102] = {2068.88671875, 1166.33984375, 10.671875}
dreckberg[103] = {2065.3818359375, 1345.3828125, 10.671875}
dreckberg[104] = {2030.744140625, 1403.8173828125, 10.8203125}
dreckberg[105] = {1982.4326171875, 1392.724609375, 9.109375}
dreckberg[106] = {1857.2392578125, 1453.9765625, 10.675659179688}
dreckberg[107] = {1703.0205078125, 1486.3330078125, 10.777473449707}
dreckberg[108] = {1722.591796875, 1603.4287109375, 10.015625}
dreckberg[109] = {1797.4130859375, 1588.3427734375, 6.703125}
dreckberg[110] = {1811.2587890625, 1869.2568359375, 6.742000579834}
dreckberg[111] = {1850.349609375, 2050.365234375, 10.729214668274}
dreckberg[112] = {1766.634765625, 2164.5498046875, 10.828125}
dreckberg[113] = {1726.1328125, 2266.44140625, 10.844481468201}
dreckberg[114] = {1874.046875, 2273.314453125, 10.671875}
dreckberg[115] = {1938.5400390625, 2399.4296875, 10.8203125}
dreckberg[116] = {2026.267578125, 2399.1923828125, 10.76717376709}
dreckberg[117] = {2136.3369140625, 2453.962890625, 10.671875}
dreckberg[118] = {2287.36328125, 2512.72265625, 10.671875}
dreckberg[119] = {2379.0703125, 2512.58984375, 10.717844963074}
dreckberg[120] = {2387.6982421875, 2638.1845703125, 13.567533493042}
dreckberg[121] = {2467.2939453125, 2775.0078125, 10.687040328979}
dreckberg[122] = {2250.9970703125, 2712.78125, 10.671875}
dreckberg[123] = {2145.49609375, 2774.759765625, 10.714356422424}
dreckberg[124] = {2130.361328125, 2834.626953125, 10.866516113281}
dreckberg[125] = {1973.1806640625, 2744.0556640625, 10.671875}
dreckberg[126] = {1908.79296875, 2704.1513671875, 10.688549041748}
dreckberg[127] = {2001.9306640625, 2644.7509765625, 10.671875}
dreckberg[128] = {2088.76953125, 2667.751953125, 10.671875}
dreckberg[129] = {2024.1240234375, 2515.85546875, 12.140121459961}
dreckberg[130] = {1793.1064453125, 2715.875, 10.671875}
dreckberg[131] = {1685.326171875, 2742.6826171875, 10.688548088074}
dreckberg[132] = {1618.279296875, 2820.9873046875, 10.671875}
dreckberg[133] = {1626.7822265625, 2735.81640625, 10.671875}
dreckberg[134] = {1545.9189453125, 2770.845703125, 10.837356567383}
dreckberg[135] = {1470.94140625, 2788.078125, 10.671875}
dreckberg[136] = {1559.361328125, 2681.6748046875, 10.679672241211}
dreckberg[137] = {1588.8271484375, 2613.576171875, 10.671875}
dreckberg[138] = {1443.8740234375, 2713.3857421875, 10.671875}
dreckberg[139] = {1273.423828125, 2712.3642578125, 10.671875}
dreckberg[140] = {1247.037109375, 2599.021484375, 10.671875}
dreckberg[141] = {1354.4453125, 2591.244140625, 10.671875}
dreckberg[142] = {1431.2578125, 2606.681640625, 10.671875}
dreckberg[143] = {1644.1015625, 2588.072265625, 10.671875}
dreckberg[144] = {1779.1591796875, 2616.755859375, 10.8203125}
dreckberg[145] = {1475.71484375, 2509.5263671875, 11.63748550415}
dreckberg[146] = {1387.728515625, 2389.2138671875, 10.671875}
dreckberg[147] = {1498.4638671875, 2312.2646484375, 10.671875}
dreckberg[148] = {2453.0029296875, 1193.6826171875, 10.671875}
dreckberg[149] = {2527.2177734375, 1107.2373046875, 10.671875}
dreckberg[150] = {2445.89453125, 1075.146484375, 10.671875}
dreckberg[151] = {2347.2060546875, 1058.197265625, 10.671875}
dreckberg[153] = {2418.7451171875, 1378.18359375, 10.74949836731}
dreckberg[154] = {2510.6513671875, 1471.345703125, 10.807933807373}
dreckberg[155] = {2243.8994140625, 1534.689453125, 10.806491851807}
dreckberg[156] = {2248.453125, 1381.306640625, 10.757457733154}
dreckberg[157] = {2227.9775390625, 1282.4208984375, 10.671875}
dreckberg[158] = {2186.455078125, 1292.490234375, 10.671875}

local imStadtwerkeDienst = {}
local stadtverwaltungVeh = {}
function createStaatJobVehicles()
	stadtverwaltungVeh[#stadtverwaltungVeh+1] = createRPGVehicle(552,2405.3754882813,1512.7839355469,10.508823394775,0, "STADT", {{150,150,150},{50,50,50},{0,0,0},{0,0,0}}, true, false)
	stadtverwaltungVeh[#stadtverwaltungVeh+1] = createRPGVehicle(552,2402.4614257813,1512.7731933594,10.530003547668,0, "STADT", {{150,150,150},{50,50,50},{0,0,0},{0,0,0}}, true, false)
	stadtverwaltungVeh[#stadtverwaltungVeh+1] = createRPGVehicle(552,2398.6672363281,1512.7606201172,10.548187255859,0, "STADT", {{150,150,150},{50,50,50},{0,0,0},{0,0,0}}, true, false)
	stadtverwaltungVeh[#stadtverwaltungVeh+1] = createRPGVehicle(552,2395.5922851563,1512.7000732422,10.525036811829,0, "STADT", {{150,150,150},{50,50,50},{0,0,0},{0,0,0}}, true, false)
	stadtverwaltungVeh[#stadtverwaltungVeh+1] = createRPGVehicle(552,2391.9204101563,1512.7082519531,10.503707885742,0, "STADT", {{150,150,150},{50,50,50},{0,0,0},{0,0,0}}, true, false)
	stadtverwaltungVeh[#stadtverwaltungVeh+1] = createRPGVehicle(552,2389.0295410156,1512.72265625,10.540783882141,0, "STADT", {{150,150,150},{50,50,50},{0,0,0},{0,0,0}}, true, false)
	stadtverwaltungVeh[#stadtverwaltungVeh+1] = createRPGVehicle(552,2385.4899902344,1512.7210693359,10.521867752075,0, "STADT", {{150,150,150},{50,50,50},{0,0,0},{0,0,0}}, true, false)
	for i = 1,#stadtverwaltungVeh do
		setElementData( stadtverwaltungVeh[i], "doNotLooseFuel", true)
		toggleVehicleRespawn( stadtverwaltungVeh[i], true )
		setVehicleIdleRespawnDelay ( stadtverwaltungVeh[i], 60000 )
		setElementData( stadtverwaltungVeh[i], "shallRespawn", true)
	end			
end	
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), createStaatJobVehicles)


local stadtverwaltung_marker = createMarker ( 2408.965,1510.867,9.82, "cylinder", 2, 125,125,255,200)
function stadtverwaltung_marker_func( hitElement, matchingDimension )
    if matchingDimension and getElementType(hitElement) == "player" then
		triggerClientEvent ( hitElement, "addNotification", getRootElement(),  3, 145, 214, 231, "Nebenjob Stadtwerke:\nUm den Dienst zu beginnen steig in eines der Fahrzeuge ein." )	
	end
end
addEventHandler( "onMarkerHit", stadtverwaltung_marker, stadtverwaltung_marker_func )
 
function enterVehicleStadt ( theVehicle, seat, jacked )
	for i,v in ipairs(stadtverwaltungVeh) do
		if theVehicle == v then
			if getElementData(source, "dienst") == 1 then
				removePedFromVehicle ( source )
				triggerClientEvent ( source, "addNotification", getRootElement(),  1, 255, 0, 0, "Du darfst nicht im Dienst sein wenn du\neine Tour für die Stadtwerke machen willst." )
				return
			else
				if not imStadtwerkeDienst[source] then
					imStadtwerkeDienst[source] = {}
					imStadtwerkeDienst[source].dienst = true
					imStadtwerkeDienst[source].display = textCreateDisplay ()
					imStadtwerkeDienst[source].text = textCreateTextItem ( "Fahre zum Icon auf der Karte.", 0.5, 0.1, "l", 145, 214, 231, 255, 3, "center", "top", 150 )    
					textDisplayAddText ( imStadtwerkeDienst[source].display, imStadtwerkeDienst[source].text )  
					textDisplayAddObserver ( imStadtwerkeDienst[source].display, source )    
					local v = dreckberg[math.random(1, #dreckberg)]
					imStadtwerkeDienst[source].obj = createObject(dreckmodels[math.random(1, #dreckmodels)], v[1], v[2], v[3] - 0.75)
					imStadtwerkeDienst[source].blip = createBlipAttachedTo ( imStadtwerkeDienst[source].obj, 0, 2, 145, 214, 231, 255, 0 ,99999, source)
					triggerClientEvent ( source, "addNotification", getRootElement(),  3, 145, 214, 231, "Nebenjob Stadtwerke:\nFahre zu dem Icon auf der Karte und säubere die Straße mit deiner Schaufel." )	
					giveWeapon(source, 6)
				else
					textItemSetText ( imStadtwerkeDienst[source].text, "Fahre zum Icon auf der Karte." )
					if imStadtwerkeDienst[source].timer and isTimer(imStadtwerkeDienst[source].timer) then
						killTimer(imStadtwerkeDienst[source].timer)	
					end
				end
			end
		end
	end
end
addEventHandler ( "onPlayerVehicleEnter", getRootElement(), enterVehicleStadt )

function exitVehicleStadt (  theVehicle, seat, jacker )
	for i,v in ipairs(stadtverwaltungVeh) do
		if theVehicle == v then
			if imStadtwerkeDienst[source] then
				bindKey(source, "fire", "down", stadtClick)
				local x,y,z = getElementPosition(source)
				local x1,y1,z1 = getElementPosition(imStadtwerkeDienst[source].obj)
				if getDistanceBetweenPoints2D ( x,y,x1,y1 ) < 30 then
					textItemSetText ( imStadtwerkeDienst[source].text, "Schlage mit der Schaufel auf den Müll." )
					triggerClientEvent ( source, "addNotification", getRootElement(),  3, 145, 214, 231, "Schlage mit der Schaufel auf den Müll oder kehre zurück ins Fahrzeug.\nDu hast 15 Sekunden Zeit." )	
				else
					textItemSetText ( imStadtwerkeDienst[source].text, "Steige wieder ins Fahrzeug." )
					triggerClientEvent ( source, "addNotification", getRootElement(),  3, 145, 214, 231, "Du bist nicht nahe genug am Müll.\nDu hast 15 Sekunden Zeit wieder ins Fahrzeug zu steigen." )	
				end
				imStadtwerkeDienst[source].timer = setTimer(function(source)
					triggerClientEvent ( source, "addNotification", getRootElement(),  3, 145, 214, 231, "Nebenjob Stadtwerke:\nJob beendet." )	
					destroyElement(imStadtwerkeDienst[source].blip)
					destroyElement(imStadtwerkeDienst[source].obj)
					textDestroyTextItem(imStadtwerkeDienst[source].text)
					textDestroyDisplay(imStadtwerkeDienst[source].display)
					imStadtwerkeDienst[source] = nil
					takeWeapon(source, 6)
					unbindKey(source, "fire", "down", stadtClick)
				end, 15000, 1, source)
			end
		end
	end
end
addEventHandler ( "onPlayerVehicleExit", getRootElement(), exitVehicleStadt )


function stadtClick(source, key, state)
	if imStadtwerkeDienst[source] then
		local wep = getPedWeapon ( source )
		if wep == 6 then
			local x,y,z = getElementPosition(source)
			local x2,y2,z2 = getElementPosition(imStadtwerkeDienst[source].obj)
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) < 5 then
				if imStadtwerkeDienst[source].timer and isTimer(imStadtwerkeDienst[source].timer) then
					killTimer(imStadtwerkeDienst[source].timer)
				end			
				triggerClientEvent ( source, "addNotification", getRootElement(),  3, 145, 214, 231, "Müll beseitigt: 150 Vero bekommen.\nWeiter geht's im Fahrzeug!" )
				triggerClientEvent ( source, "showTutorialMessage", getRootElement(), "stadt_1", "Du hast deinen ersten Müll beseitigt. Du kannst nun entweder im Fahrzeug weiter machen oder den Job beenden, indem du nicht ins Fahrzeug einsteigst." )
				destroyElement(imStadtwerkeDienst[source].blip)
				destroyElement(imStadtwerkeDienst[source].obj)
				textDestroyTextItem(imStadtwerkeDienst[source].text)
				textDestroyDisplay(imStadtwerkeDienst[source].display)
				givePlayerMoneyEx(source, 150)
				setElementData(source, "exp", getElementData(source, "exp")+15)
				imStadtwerkeDienst[source] = nil		
				takeWeapon(source, 6)
				unbindKey(source, "fire", "down", stadtClick)				
			end
		end
	end
end
