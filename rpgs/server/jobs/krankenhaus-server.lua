--[[
Project: VitaOnline
File: krankenhaus-server.lua
Author(s):	Sebihunter
]]--

gAccidentPos = {
    [1] = {x = 1917.5682,y = 2772.3608,z = 10.4427},
    [2] = {x = 2039.6875,y = 2657.9197,z = 10.4451},
    [3] = {x = 1952.1135,y = 2658.8271,z = 10.4452},
    [4] = {x = 1677.9829,y = 2695.9146,z = 10.4450},
    [5] = {x = 1624.6128,y = 2716.1995,z = 10.4449},
    [6] = {x = 1556.5555,y = 2755.8870,z = 10.4453},
    [7] = {x = 1622.1414,y = 2834.4451,z = 10.4454},
    [8] = {x = 1460.6370,y = 2773.5288,z = 10.4453},
    [9] = {x = 1600.4808,y = 2650.1497,z = 10.4452},
    [10] = {x = 1620.0356,y = 2578.9216,z = 10.4468},
    [11] = {x = 1944.5940,y = 2602.7224,z = 10.4451},
    [12] = {x = 1843.8279,y = 2645.0649,z = 10.4454},
    [13] = {x = 1348.1985,y = 2578.0061,z = 10.4450},
    [14] = {x = 1235.9042,y = 2585.8123,z = 10.4451},
    [15] = {x = 1308.9415,y = 2524.2925,z = 10.4452},
    [16] = {x = 1459.9569,y = 2522.3887,z = 10.4450},
    [17] = {x = 1545.8271,y = 2090.5479,z = 11.0487},
    [18] = {x = 1636.4094,y = 2039.8854,z = 10.8750},
    [19] = {x = 1646.2472,y = 2130.9280,z = 10.8281},
    [20] = {x = 1690.7598,y = 2090.5361,z = 11.0206},
    [21] = {x = 1630.2762,y = 1973.6566,z = 10.4452},
    [22] = {x = 1530.5337,y = 1913.0570,z = 10.4764},
    [23] = {x = 1538.0496,y = 2024.2548,z = 10.4454},
    [24] = {x = 1456.3345,y = 2026.0061,z = 10.4448},
    [25] = {x = 1416.3021,y = 1954.8884,z = 11.0697},
    [26] = {x = 1367.6740,y = 2008.1423,z = 11.0874},
    [27] = {x = 1067.8674,y = 1737.1266,z = 10.4453},
    [28] = {x = 1606.8096,y = 1821.0052,z = 10.4492},
    [29] = {x = 2020.7587,y = 1905.2867,z = 11.9209},
    [30] = {x = 2437.4382,y = 2061.9729,z = 10.4451},
    [31] = {x = 2634.9785,y = 2016.0648,z = 10.4453},
    [32] = {x = 2619.9336,y = 2182.9165,z = 10.4887},
    [33] = {x = 2835.6907,y = 2067.6904,z = 10.4451},
    [34] = {x = 2821.8845,y = 2141.3337,z = 10.4867},
    [35] = {x = 2795.2234,y = 2225.5781,z = 10.4459},
    [36] = {x = 2633.4253,y = 2347.8914,z = 10.2970},
    [37] = {x = 2296.2061,y = 2429.9285,z = 10.4450},
    [38] = {x = 2089.4634,y = 2077.4277,z = 10.5823},
    [39] = {x = 2127.0771,y = 1483.7570,z = 10.4452},
    [40] = {x = 1962.6752,y = 922.5854,z = 10.4454},
    [41] = {x = 1858.6407,y = 970.4388,z = 10.4524},
    [42] = {x = 1857.5586,y = 1097.0818,z = 10.4431},
    [43] = {x = 1917.0452,y = 739.9970,z = 10.4454},
    [44] = {x = 1900.1559,y = 668.8907,z = 10.4452},
    [45] = {x = 2046.5809,y = 693.2980,z = 11.0781},
    [46] = {x = 2090.0791,y = 654.3246,z = 11.0521},
    [47] = {x = 2089.8364,y = 771.3110,z = 11.0569},
    [48] = {x = 2059.9717,y = 734.8697,z = 11.0347},
    [49] = {x = 2172.0166,y = 693.6989,z = 11.0844},
    [50] = {x = 2262.2915,y = 731.7529,z = 11.0593},
    [51] = {x = 2362.0881,y = 736.3741,z = 11.0856},
    [52] = {x = 2402.5039,y = 651.4893,z = 11.0465},
    [53] = {x = 2445.0898,y = 695.4839,z = 11.0536},
    [54] = {x = 2617.6277,y = 719.6056,z = 10.4456},
    [55] = {x = 2537.5906,y = 722.8360,z = 10.4465}
}

local lastAccidentPed = false
function g_AcceptEvents.passant(source)
	if getElementData(source, "job") == 7 and getElementData(source, "dienst") == 1 then
		if isElement(lastAccidentPed) then
			local blip = getElementData(lastAccidentPed, "blip")
			for numb,ply in ipairs(getElementsByType("player")) do
				if getElementData(ply, "job") == 7 and getElementData(ply, "dienst") == 1 then
					removeAcceptCommand(ply, "passant")
					outputChatBox ( "#aaaa00[Funk] Leitstelle: Passanten-Einsatz wurde von "..getPlayerName(source).." übernommen.", ply, 200, 200, 0, true )
					setElementVisibleTo ( blip, ply, false )
				end
			end
			outputChatBox ( "Ein Icon ist für 3 Minuten auf der Karte sichtbar.", source, 255, 255, 0, true )
			setElementVisibleTo ( blip, source, true )
		end
		lastAccidentPed = false
	end
end

function createAccident()	
	local rnd = math.random(1,55)
	local accidentPed = createPed ( math.random(168,189), gAccidentPos[rnd].x, gAccidentPos[rnd].y, gAccidentPos[rnd].z+0.5 )
	local blip = createBlipAttachedTo ( accidentPed, 0, 5, 0 ,50,100, 255, 0, 99999.0, getRootElement() )
	setElementVisibleTo ( blip, getRootElement(), false)
	setElementData(accidentPed, "blip", blip)
	setElementData(accidentPed, "cinfo", {"Passanten helfen."})
	setElementFrozen ( accidentPed, true )
	setPedAnimation ( accidentPed, "CRACK", "crckdeth2", -1, true, true, false, false )
	addEventHandler("onElementClicked", accidentPed, clickOnAccident )
	local saniNumber = 0
	for numb,ply in ipairs(getElementsByType("player")) do
		if getElementData(ply, "job") == 7 and getElementData(ply, "dienst") == 1 then
			saniNumber = saniNumber + 1
			triggerClientEvent ( ply, "addNotification", getRootElement(), 3, 255,255,0, "Ein Passant benötigt einen Sanitäter.\nNimm den Einsatz mit '/annehmen passant' an." )
			callClientFunction(ply, "playDispatch", "Achtung an alle Einheiten: Ein Passant benötigt einen Sani.")
			outputChatBox ( "Ein Passant benötigt einen Sanitäter. Du kannst den Einsatz mit '/annehmen passant' annehmen.", ply, 255, 255, 0, true )	
			addAcceptCommand(ply, "passant")
			--setElementVisibleTo ( blip, ply, true )
		end
	end	
	lastAccidentPed = accidentPed
	local randomNumber = nil
	if saniNumber < 3 then
		randomNumber = 3
	elseif saniNumber < 6 then
		randomNumber = 2
	else
		randomNumber = 1
	end
	createAccidentTimer = setTimer(createAccident, randomNumber*1000*60, 1)
	setTimer(
		function(accidentPed)
			if accidentPed ~= nil then
				if getElementData(accidentPed, "blip") and isElement(getElementData(accidentPed, "blip")) then
					destroyElement(getElementData(accidentPed, "blip"))
				end
				destroyElement(accidentPed)
				accidentPed = nil
			end
		end
	,1000*60*3,1, accidentPed)	
end

function clickOnAccident( theButton, theState, ply, clickPosX, clickPosY, clickPosZ )	
	if getElementData(ply, "job") == 7 and getElementData(ply, "dienst") == 1 and theButton == "left" and theState == "down" then
		if isElement(getElementData(source, "blip")) then destroyElement(getElementData(source, "blip")) end
		destroyElement(source)
		givePlayerMoneyEx(ply, 250)
		setElementData(ply, "einnahmen", getElementData(ply, "einnahmen")+250)
		setElementData(ply, "einnahmen2", getElementData(ply, "einnahmen2")+250)
		systemDeposit("Krankenhaus", 250)
		outputChatBox ( "Du hast 250 Vero für die Rettung des Passanten erhalten. 250 Vero gingen ebenfalls an das Krankenhaus.", ply, 255, 255, 0, true )
	end
end