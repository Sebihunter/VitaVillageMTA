--[[
Project: VitaOnline
File: adac-server.lua
Author(s):	Sebihunter
			Golf_R32
]]--

local magnetmoveing = {}

adacTor = createObject(2924,-1500.2551269531,710.25903320313,7.3811097145081,0,0,0)
setElementData(adacTor, "state", "closed")

autofixplanke1 = createObject (983 , -1528.9899902344, 724.55383300781 , 6.8674983978271 , 0 , 0, 0)
autofixplanke2 = createObject (983 , -1528.9885253906, 718.02197265625 , 6.8574924468994 , 0 , 0, 0) 

autofixplanke12 = createObject (983 , -1528.9899902344, 724.55383300781 , 8.118143081665 , 0 , 0, 0)
autofixplanke22 = createObject (983 , -1528.9885253906, 718.02197265625 , 8.118143081665 , 0 , 0, 0) 

adac_repair = {}
adac_repair[1] = createMarker ( -1519, 692, 5.1853160858154, "cylinder", 7, 0, 255, 0, 0 ) -- a: 150
adac_repair[2] = createMarker(-1510.5, 670.9,6,"cylinder",4.5, 0, 255, 0, 0)
adac_repair[3] = createMarker(-1492.4592285156, 670.9,6,"cylinder",6, 0, 255, 0, 0 )
adac_repair[4] = createMarker(-1503, 670.9,6,"cylinder",6, 0, 255, 0, 0 )
adac_repair[5] = createMarker(1637, 756.5, 9.89,"cylinder",8, 0, 255, 0, 0 )
adac_repair[6] = createMarker(1645.3000488281, 756.59997558594, 9.89,"cylinder",8, 0, 255, 0, 0 )
adac_repair[7] = createMarker(1653.8000488281, 756.59997558594, 9.89,"cylinder",4, 0, 255, 0,0 )
adac_repair[8] = createMarker(1662.5999755859, 756.40002441406, 9.89,"cylinder",4, 0, 255, 0, 0 )
adac_repair[9] = createMarker(1671.5999755859, 756.40002441406, 9.89,"cylinder",4, 0, 255, 0, 0 )
adac_repair[10] = createMarker(92.508,-164.911,2.59375,"cylinder",10, 0, 255, 0, 0 )
adac_repair[11] = createMarker(1680.0999755859, 756.5, 9.89,"cylinder",4, 0, 255, 0, 0 )
adac_repair[12] = createMarker(1688.6999511719, 756.09997558594, 9.89,"cylinder",6, 0, 255, 0, 0 )
adac_repair[13] = createMarker(1745, 720.70001220703, 9.83,"cylinder",6, 0, 255, 0, 0 )
adac_modshop =  createMarker( -1496.7607421875, 747.466796875, 5.1926379203796, "cylinder", 3, 255, 0, 0, 100 )	
adac_modshop2 =  createMarker( 1710.5, 749.5, 9.89, "cylinder", 3, 255, 0, 0, 100 )	
adac_modshop3 =  createMarker( 1642.6999511719, 584.79998779297, -0.10000000149012, "cylinder", 5, 255, 0, 0, 100 )	

hebebuehne1 = {}
hebebuehne2 = {}

hebebuehne1[1] = createObject ( 984, -1520.2313232422, 692.52581787109, 6.2, 0, 89.818115234375, 0)
hebebuehne2[1] = createObject ( 984, -1517.271484375, 692.51513671875, 6.2, 0, 89.818115234375, 0)

hebebuehne1[2] = createObject(983, -1511.1024169922, 671.2412109375, 6.2, 0, 89.97802734375, 0)
hebebuehne2[2] = createObject(983, -1509.7270507813, 671.21875, 6.2, 0, 89.97802734375, 179.99353027344)

hebebuehne1[3] = createObject(983, -1491.1604003906, 671.2412109375, 6.2, 0, 89.97802734375, 0)
hebebuehne2[3] =  createObject(983, -1493.5787353516, 671.2412109375, 6.2, 0, 89.97802734375, 0)
	
hebebuehne1[4] = createObject(983, -1504.5, 671.2412109375, 6.2, 0, 89.97802734375, 0)
hebebuehne2[4] = createObject(983, -1502.0095214844, 671.2412109375, 6.2, 0, 89.97802734375, 0)

hebebuehne1[5] = createObject(983, 1637.455078125, 756.5, 9.83, 0, 90, 180)
hebebuehne2[5] = createObject(983, 1636.3203125, 756.5302734375, 9.83, 0, 90, 0)

hebebuehne1[6] = createObject(983, 1644.4404296875, 756.5, 9.83, 0, 90, 0)
hebebuehne2[6] = createObject(983, 1646.330078125, 756.5, 9.83, 0, 90, 180)

hebebuehne1[7] = createObject(983, 1653, 756.5107421875, 9.83, 0, 90, 0)
hebebuehne2[7] = createObject(983, 1655.0302734375, 756.5, 9.83, 0, 90, 180)

hebebuehne1[8] = createObject(983, 1661.7001953125, 756.5, 9.83, 0, 90, 0)
hebebuehne2[8] = createObject(983, 1663.66015625, 756.5, 9.83, 0, 90, 180)

hebebuehne1[9] = createObject(983, 1670.400390625, 756.5, 9.83, 0, 90, 0)
hebebuehne2[9] = createObject(983, 1672.400390625, 756.48046875, 9.83, 0, 90, 180)

hebebuehne1[10] = createObject(983, 92.40039, -166.12, 1.59375, 0, 90, 270)
hebebuehne2[10] = createObject(983, 92.400395, -163.76805, 1.59375, 0, 90, 90)

hebebuehne1[11] = createObject (983, 1679, 756.490234375, 9.83, 0, 90, 0) --Hebebühne unten--
hebebuehne2[11] = createObject (983, 1681.099609375, 756.5, 9.83, 0, 90, 180) --Hebebühne unten--

hebebuehne1[12] = createObject (984, 1687.1103515625, 756.4501953125, 9.83, 0, 90, 0) --Hebebühne unten--
hebebuehne2[12] = createObject (984, 1690.2197265625, 756.4501953125, 9.83, 0, 90, 180) --Hebebühne unten--

hebebuehne1[13] =  createObject (975, 1745, 723.41015625, 9.8800001144409, 90, 0, 0) --Hebebühne unten--
hebebuehne2[13] =  createObject (975,1745, 718.599609375, 9.8800001144409, 90, 0, 0) --Hebebühne unten--

repairtor = createObject(9625, -1505.5383300781, 747.06762695313, 9.0815515518188, 0, 0, 0)

eingangadactuer = createObject(3037,-1516.49609375,710.25,8.386004447937,0,0,270.03295898438)
ausgangadactuer = createObject(3037,-1493.556640625,710.25,8.386004447937,0,0,270.03295898438)


lvliefer = createObject(10184, 1632.2998046875, 773.099609375, 16.66, 0, 0, 0)
lvwerk = createObject (968, 1706.599609375, 729.7998046875, 10.60000038147, 0,  90, 0 )
--[[
lvschranke= createObject(968,1062.6586914062,1338.8024902344,10.678913116455,0,90,0)
]]--
lveingang1 = createObject (2990, 1578.033203125, 713.212890625, 13.075480461121, 0, 0, 270) --Tor zu--

lvtor1 = createObject (7891, 1636.899999, 743.7001953125, 12.10000038147, 0, 0, 270) --Tor zu--
lvtor2 = createObject (7891, 1645.2998046875, 743.7001953125, 12.10000038147, 0, 0, 270) --Tor zu--
lvtor3 = createObject (7891, 1654.099609375, 743.7001953125, 12.10000038147, 0, 0, 270) --Tor zu--
lvtor4 = createObject (7891, 1662.7998046875, 743.7001953125, 12.10000038147, 0, 0, 270) --Tor zu--
lvtor5 = createObject (7891, 1671.400390625, 743.7001953125, 12.10000038147, 0, 0, 270) --Tor zu--
lvtor6 = createObject (7891, 1680.2001953125, 743.7001953125, 12.10000038147, 0, 0, 270) --Tor zu--
lvtor7 = createObject (7891, 1688.900390625, 743.7001953125, 12.10000038147, 0, 0, 270) --Tor zu--
lvschranke1 = createObject (968, 1733.599609375, 743.900390625, 10.60000038147, 0, 90, 0) --Schranke zu--
bluetor1 = createObject(9093, 88.2,-161,2.9,0,0,90)
bluetor2 = createObject(9093, 100,-164.7,2.9,0,0,0)

reperaturvehicle = {}
reperaturimgange = 0
adactorinbewegung = 0

aufzugasdjl = createObject(16501, -1490.6435546875, 693.9560546875, 6.0896143913269, 0, 269.98901367188,0)


local m_parkplatzk1 = createObject (2886, 1593.1099853516, 706.85998535156, 11.5, 0, 0, 180)--aussen--
local m_parkplatzk2 = createObject (2886, 1601.4000244141, 706.09997558594, 11.5, 0, 0, 0)--innen--
setElementData(m_parkplatzk1, "cinfo", {"Tor Öffnen/Schließen"})
setElementData(m_parkplatzk2, "cinfo", {"Tor Öffnen/Schließen"})

local m_parkplatzt = createObject (968, 1593.8000488281, 706.51000976563, 10.60000038147, 0, 90, 0)--zu--
setElementData ( m_parkplatzt, "state", "up", true )

function m_parkplatzf( theButton, theState, player, clickPosX, clickPosY, clickPosZ )			--SanitäterGarage
	if getElementData ( m_parkplatzt, "state" ) == "up" and theButton == "left" and theState == "down" and getElementData(player, "job") == 4 then
		moveObject ( m_parkplatzt, 2500, 1593.8000488281, 706.51000976563, 10.60000038147, 0, -90, 0  )
		setTimer(function() setElementData ( m_parkplatzt, "state", "down", true ) end, 2500,1)
		setElementData ( m_parkplatzt, "state", "moving", true )
	else if getElementData ( m_parkplatzt, "state" ) == "down" and theButton == "left" and theState == "down" and getElementData(player, "job") == 4 then
		moveObject ( m_parkplatzt, 2500, 1593.8000488281, 706.51000976563, 10.60000038147, 0, 90, 0)
		setElementData ( m_parkplatzt, "state", "moving", true )
		setTimer(function() setElementData ( m_parkplatzt, "state", "up", true ) end, 2500,1)
		end
	end
end
addEventHandler("onElementClicked", m_parkplatzk1, m_parkplatzf )
addEventHandler("onElementClicked", m_parkplatzk2, m_parkplatzf )

autofixplanke_status = "zu"

gCurrentRoadBlocks = 0
gRoadBlock = {}

function addRoadBlock(ply, command)
	if getElementData(ply, "job") == 4 and getElementData(ply, "dienst") == 1 then
		local x,y,z = getElementPosition(ply)
		local a = getPedRotation(ply)
		gCurrentRoadBlocks = gCurrentRoadBlocks+1
		gRoadBlock[gCurrentRoadBlocks] = createObject(1237, x, y, z - 1.0, 0.0, 0.0, a)
		local int = getElementInterior(ply)
		local dim = getElementDimension(ply)		
		setElementInterior(gRoadBlock[gCurrentRoadBlocks], int)
		setElementDimension(gRoadBlock[gCurrentRoadBlocks], dim)				
	end	
end
addCommandHandler("ab",addRoadBlock, false, false)
addCommandHandler("absperrung",addRoadBlock, false, false)

function delRoadBlock(ply, command)
	if getElementData(ply, "job") == 4 then
		if gCurrentRoadBlocks > 0 then
			destroyElement(gRoadBlock[gCurrentRoadBlocks])
			gCurrentRoadBlocks = gCurrentRoadBlocks-1
		end	
	end	
end
addCommandHandler("abdel",delRoadBlock, false, false)
addCommandHandler("delabsperrung",delRoadBlock, false, false)

addEvent("adacTorOpen", true)
function adacTorOpen()
	if getElementData(source, "job") == 4 then
		moveObject(aadacTor, 2000, -1500.2551269531,710.25903320313,7.3811097145081,0,0,-90)
		setTimer(setElementData,2000,1,adacTor, "state", "open")
		setElementData(adacTor, "state", "moving")
	elseif getElementData(adacTor, "state") ==  "open" then
		moveObject(adacTor, 2000, -1500.2551269531,710.25903320313,7.3811097145081,0,0,90)
		setTimer(setElementData,2000,1,adacTor, "state", "closed")
		setElementData(adacTor, "state", "moving")
	end
end
addEventHandler("adacTorOpen", getRootElement(), adacTorOpen)

function adactorfertigbewegt()
	adactorinbewegung = 0
end

setGarageOpen(22, true)
local werkstattOffen = 1
function ToggleADACTor()
    if getElementData(source, "job") == 4 then
		if werkstattOffen == 0 then
			setGarageOpen(22, true)
			werkstattOffen = 1
		else
			setGarageOpen(22, false)
			werkstattOffen = 0
		end
	end
end

addEvent("ToggleADACTor", true)
addEventHandler("ToggleADACTor", getRootElement(), ToggleADACTor)

addEvent("openthefirstadacdoor", true)
function autofixplankecmd(thePlayer, command)
    if getElementData(source, "job") == 4 then
		if  adactorinbewegung ~= 1 then
			adactorinbewegung = 1
			setTimer ( adactorfertigbewegt, 5000, 1 )
			if autofixplanke_status == "zu" then
				moveObject(autofixplanke1, 5000, -1528.9899902344, 729.2 , 6.8674983978271, 0, 0, 0)
				moveObject(autofixplanke12, 5000, -1528.9899902344, 729.2 , 8.118143081665, 0, 0, 0)
				moveObject(autofixplanke2, 5000, -1528.9885253906, 713.2 , 6.8574924468994, 0, 0, 0)
				moveObject(autofixplanke22, 5000, -1528.9885253906, 713.2 , 8.118143081665, 0, 0, 0)
				autofixplanke_status = "auf"
			else
				moveObject(autofixplanke1, 5000, -1528.9899902344, 724.55383300781 , 6.8674983978271, 0, 0, 0)
				moveObject(autofixplanke12, 5000, -1528.9899902344, 724.55383300781 , 8.118143081665, 0, 0, 0)
				moveObject(autofixplanke2, 5000, -1528.9885253906, 718.02197265625 , 6.8574924468994, 0, 0, 0)
				moveObject(autofixplanke22, 5000, -1528.9885253906, 718.02197265625 , 8.118143081665, 0, 0, 0)
				autofixplanke_status = "zu"
			end
		end		
	end
end	
addEventHandler("openthefirstadacdoor", getRootElement(), autofixplankecmd)
function plattenstart()	
	local xml = xmlLoadFile("./xml/firmen/4.xml")
	if xml then
		for i,v in ipairs(adac_repair) do
			local x = xmlFindChild ( xml, "buehne",i-1 )
			if x then
				setElementData(v, "repairs", tonumber(xmlNodeGetValue(x)))
			else
				x = xmlCreateChild ( xml, "buehne" )
				xmlNodeSetValue(x, "10")
				setElementData(v, "repairs", 10)
			end
		end
	
		local platte1 = xmlFindChild ( xml, "platte",0 )
		if platte1 then
			setElementData(hebebuehne1[1], "state", xmlNodeGetValue(platte1))
			if getElementData(hebebuehne1[1], "state") == "reparieren" then
				setElementData(hebebuehne1[1], "state", "down" )
			end			
		else
			platte1 = xmlCreateChild ( xml, "platte" )
			xmlNodeSetValue(platte1,"open")
			setElementData(hebebuehne1[1], "state", "open" )
		end
		local platte2 = xmlFindChild ( xml, "platte",1 )
		if platte2 then
			setElementData(hebebuehne1[2], "state", xmlNodeGetValue(platte2))
			if getElementData(hebebuehne1[2], "state") == "reparieren" then
				setElementData(hebebuehne1[2], "state", "down" )
			end			
		else
			platte2 = xmlCreateChild ( xml, "platte" )
			xmlNodeSetValue(platte2,"open")
			setElementData(hebebuehne1[2], "state", "open" )
		end
		local platte3 = xmlFindChild ( xml, "platte",2 )
		if platte3 then
			setElementData(hebebuehne1[3], "state", xmlNodeGetValue(platte3))
			if getElementData(hebebuehne1[3], "state") == "reparieren" then
				setElementData(hebebuehne1[3], "state", "down" )
			end			
		else
			platte3 = xmlCreateChild ( xml, "platte" )
			xmlNodeSetValue(platte3,"open")
			setElementData(hebebuehne1[3], "state", "open" )
		end
		local platte4 = xmlFindChild ( xml, "platte",3 )
		if platte4 then
			setElementData(hebebuehne1[4], "state", xmlNodeGetValue(platte4))
			if getElementData(hebebuehne1[4], "state") == "reparieren" then
				setElementData(hebebuehne1[4], "state", "down" )
			end
		else
			platte4 = xmlCreateChild ( xml, "platte" )
			xmlNodeSetValue(platte4,"open")
			setElementData(hebebuehne1[4], "state", "open" )
		end
		local platte5 = xmlFindChild ( xml, "platte",4 )
		if platte5 then
			setElementData(repairtor, "state", xmlNodeGetValue(platte5))
		else
			platte5 = xmlCreateChild ( xml, "platte" )
			xmlNodeSetValue(platte5,"down")
			setElementData(repairtor, "state", "down" )	
		end
		local platte6 = xmlFindChild ( xml, "platte",5 )
		if platte6 then
			setElementData(eingangadactuer, "state", xmlNodeGetValue(platte6))
		else
			platte6 = xmlCreateChild ( xml, "platte" )
			xmlNodeSetValue(platte6,"down")
			setElementData(eingangadactuer, "state", "down" )
		end
		local platte7 = xmlFindChild ( xml, "platte",6 )
		if platte7 then
			setElementData(ausgangadactuer, "state", xmlNodeGetValue(platte7))
		else
			platte7 = xmlCreateChild ( xml, "platte" )
			xmlNodeSetValue(platte7,"down")
			setElementData(ausgangadactuer, "state", "down" )	
		end
		local platte8 = xmlFindChild ( xml, "platte",7 )
		if platte8 then
			setElementData(aufzugasdjl, "state", xmlNodeGetValue(platte8))
		else
			platte8 = xmlCreateChild ( xml, "platte" )
			xmlNodeSetValue(platte8,"down")
			setElementData(aufzugasdjl, "state", "down" )	
		end
		local platte9 = xmlFindChild ( xml, "platte",8 )
		if platte9 then
			setElementData(hebebuehne1[5], "state", xmlNodeGetValue(platte9))
			if getElementData(hebebuehne1[5], "state") == "reparieren" then
				setElementData(hebebuehne1[5], "state", "down" )
			end			
		else
			platte9 = xmlCreateChild ( xml, "platte" )
			xmlNodeSetValue(platte9,"down")
			setElementData(hebebuehne1[5], "state", "down" )	
		end			
		local platte10 = xmlFindChild ( xml, "platte",9 )
		if platte10 then
			setElementData(hebebuehne1[6], "state", xmlNodeGetValue(platte10))
			if getElementData(hebebuehne1[6], "state") == "reparieren" then
				setElementData(hebebuehne1[6], "state", "down" )
			end			
		else
			platte10 = xmlCreateChild ( xml, "platte" )
			xmlNodeSetValue(platte10,"down")
			setElementData(hebebuehne1[6], "state", "down" )	
		end	
		
		local platte11 = xmlFindChild ( xml, "platte",10 )
		if platte11 then
			setElementData(lvliefer, "state", xmlNodeGetValue(platte11))
		else
			platte11 = xmlCreateChild ( xml, "platte" )
			xmlNodeSetValue(platte11,"down")
			setElementData(lvliefer, "state", "down" )
		end

		local platte12 = xmlFindChild ( xml, "platte",11 )
		if platte12 then
			setElementData(lvwerk, "state", xmlNodeGetValue(platte12))
		else
			platte12 = xmlCreateChild ( xml, "platte" )
			xmlNodeSetValue(platte12,"down")
			setElementData(lvwerk, "state", "down" )
		end
		local platte14 = xmlFindChild ( xml, "platte",13 )
		if platte14 then
			setElementData(lveingang1, "state", xmlNodeGetValue(platte14))
		else
			platte14 = xmlCreateChild ( xml, "platte" )
			xmlNodeSetValue(platte14,"down")
			setElementData(lveingang1, "state", "down" )
		end	
		local platte15 = xmlFindChild ( xml, "platte",14 )
		if platte15 then
			setElementData(hebebuehne1[7], "state", xmlNodeGetValue(platte15))
			if getElementData(hebebuehne1[7], "state") == "reparieren" then
				setElementData(hebebuehne1[7], "state", "down" )
			end			
		else
			platte15 = xmlCreateChild ( xml, "platte" )
			xmlNodeSetValue(platte15,"down")
			setElementData(hebebuehne1[7], "state", "down" )	
		end	
		local platte16 = xmlFindChild ( xml, "platte",15 )
		if platte16 then
			setElementData(hebebuehne1[8], "state", xmlNodeGetValue(platte16))
			if getElementData(hebebuehne1[8], "state") == "reparieren" then
				setElementData(hebebuehne1[8], "state", "down" )
			end			
		else
			platte16 = xmlCreateChild ( xml, "platte" )
			xmlNodeSetValue(platte16,"down")
			setElementData(hebebuehne1[8], "state", "down" )	
		end
		
		local platte17 = xmlFindChild ( xml, "platte",16 )
		if platte17 then
			setElementData(hebebuehne1[9], "state", xmlNodeGetValue(platte17))
			if getElementData(hebebuehne1[9], "state") == "reparieren" then
				setElementData(hebebuehne1[9], "state", "down" )
			end
		else
			platte17 = xmlCreateChild ( xml, "platte" )
			xmlNodeSetValue(platte17,"down")
			setElementData(hebebuehne1[9], "state", "down" )	
		end		
		
		local platte18 = xmlFindChild ( xml, "platte",17 )
		if platte18 then
			setElementData(hebebuehne1[10], "state", xmlNodeGetValue(platte18))
			if getElementData(hebebuehne1[10], "state") == "reparieren" then
				setElementData(hebebuehne1[10], "state", "down" )
			end
		else
			platte18 = xmlCreateChild ( xml, "platte" )
			xmlNodeSetValue(platte18,"down")
			setElementData(hebebuehne1[10], "state", "down" )	
		end

		platte18 = xmlFindChild ( xml, "platte",18 )
		if platte18 then
			setElementData(hebebuehne1[11], "state", xmlNodeGetValue(platte18))
			if getElementData(hebebuehne1[11], "state") == "reparieren" then
				setElementData(hebebuehne1[11], "state", "down" )
			end
		else
			platte18 = xmlCreateChild ( xml, "platte" )
			xmlNodeSetValue(platte18,"down")
			setElementData(hebebuehne1[11], "state", "down" )	
		end	
		
		platte18 = xmlFindChild ( xml, "platte",19 )
		if platte18 then
			setElementData(hebebuehne1[12], "state", xmlNodeGetValue(platte18))
			if getElementData(hebebuehne1[12], "state") == "reparieren" then
				setElementData(hebebuehne1[12], "state", "down" )
			end
		else
			platte18 = xmlCreateChild ( xml, "platte" )
			xmlNodeSetValue(platte18,"down")
			setElementData(hebebuehne1[12], "state", "down" )	
		end	
		
		platte18 = xmlFindChild ( xml, "platte",20 )
		if platte18 then
			setElementData(hebebuehne1[13], "state", xmlNodeGetValue(platte18))
			if getElementData(hebebuehne1[13], "state") == "reparieren" then
				setElementData(hebebuehne1[13], "state", "down" )
			end
		else
			platte18 = xmlCreateChild ( xml, "platte" )
			xmlNodeSetValue(platte18,"down")
			setElementData(hebebuehne1[13], "state", "down" )	
		end		
			
			if getElementData(hebebuehne1[1], "state") == "open" then
				setElementPosition(hebebuehne1[1], -1520.2313232422, 692.52581787109, 6.2)
				setElementPosition(hebebuehne2[1],  -1517.271484375, 692.51513671875, 6.2)
			elseif getElementData(hebebuehne1[1], "state") == "down" or getElementData(hebebuehne1[1], "state") == "reparieren" then
				setElementPosition(hebebuehne1[1],  -1520.2313232422, 692.52581787109, 8.4)
				setElementPosition(hebebuehne2[1],  -1517.271484375, 692.51513671875, 8.4)
			end
			
			if getElementData(hebebuehne1[2], "state") == "open" then
				setElementPosition(hebebuehne1[2], -1511.1024169922, 671.2412109375, 6.2)
				setElementPosition(hebebuehne2[2],  -1509.7270507813, 671.21875, 6.2)
			elseif getElementData(hebebuehne1[2], "state") == "down" or getElementData(hebebuehne1[2], "state") == "reparieren"then
				setElementPosition(hebebuehne1[2],  -1511.1024169922, 671.2412109375, 8.4)
				setElementPosition(hebebuehne2[2],  -1509.7270507813, 671.21875, 8.4)
			end
			
			if getElementData(hebebuehne1[3], "state") == "open" then
				setElementPosition(hebebuehne1[3], -1491.1604003906, 671.2412109375, 6.2)
				setElementPosition(hebebuehne2[3],  -1493.5787353516, 671.2412109375, 6.2)
			elseif getElementData(hebebuehne1[3], "state") == "down" or getElementData(hebebuehne1[3], "state") == "reparieren" then
				setElementPosition(hebebuehne1[3],  -1491.1604003906, 671.2412109375, 8.4)
				setElementPosition(hebebuehne2[3],  -1493.5787353516, 671.2412109375, 8.4)
			end
			
			if getElementData(hebebuehne1[4], "state") == "open" then
				setElementPosition(hebebuehne1[4], -1504.5, 671.2412109375, 6.2)
				setElementPosition(hebebuehne2[4],  -1502.0095214844, 671.2412109375, 6.2)
			elseif getElementData(hebebuehne1[4], "state") == "down" or getElementData(hebebuehne1[4], "state") == "reparieren" then
				setElementPosition(hebebuehne1[4],  -1504.5, 671.2412109375, 8.4)
				setElementPosition(hebebuehne2[4],  -1502.0095214844, 671.2412109375, 8.4)
			end
			
			if getElementData(repairtor, "state") == "open" then
				setElementPosition(repairtor, -1502.5383300781, 747.06762695313, 11.380932807922)
				setElementRotation(repairtor, 0, 88.077453613281, 0)
			elseif getElementData(repairtor, "state") == "down" or getElementData(repairtor, "state") == "moveing" then
				setElementPosition(repairtor,  -1505.5383300781, 747.06762695313, 9.0815515518188)
			end
			
			
			if getElementData(eingangadactuer, "state") == "open" then
				setElementPosition(eingangadactuer, -1516.49609375,708.3994140625,12.401002883911)
				setElementRotation(eingangadactuer, 0,46.554565429688,270.03295898438)
			elseif getElementData(eingangadactuer, "state") == "down" or getElementData(eingangadactuer, "state") == "moveing"  then
				setElementPosition(eingangadactuer,  -1516.49609375,710.25,8.386004447937)
				setElementData(eingangadactuer,"state", "down")
			end
			
			if getElementData(ausgangadactuer, "state") == "open" then
				setElementPosition(ausgangadactuer, -1493.5540771484, 708.91467285156, 12.236158370972)
				setElementRotation(ausgangadactuer, 0, 30.340576171875, 270.044921875)
			elseif getElementData(ausgangadactuer, "state") == "down" or getElementData(ausgangadactuer, "state") == "moveing" then
				setElementPosition(ausgangadactuer,  -1493.556640625,710.25,8.386004447937)
				setElementData(ausgangadactuer,"state", "down")
			end
			if getElementData(aufzugasdjl, "state") == "open" then
				setElementPosition(aufzugasdjl, -1490.6435546875, 693.9560546875, 10.563302993774)
				setElementRotation(aufzugasdjl, 0, 269.98901367188,0)
			elseif getElementData(aufzugasdjl, "state") == "down" or getElementData(aufzugasdjl, "state") == "moveing" then
				setElementPosition(aufzugasdjl,  -1490.6435546875, 693.9560546875, 6.0896143913269 )
				setElementRotation(aufzugasdjl, 0, 269.98901367188,0)
				setElementData(aufzugasdjl,"state", "down")
			end

			if getElementData(hebebuehne1[5], "state") == "open" then
				setElementPosition(hebebuehne1[5], 1637.455078125, 756.5, 9.83)
				setElementPosition(hebebuehne2[5], 1636.3203125, 756.5302734375, 9.83)
			elseif getElementData(hebebuehne1[5], "state") == "down" or getElementData(hebebuehne1[5], "state") == "reparieren" then
				setElementPosition(hebebuehne1[5], 1637.455078125, 756.5, 12)
				setElementPosition(hebebuehne2[5], 1636.3203125, 756.5302734375, 12)
			end
			
			if getElementData(hebebuehne1[6], "state") == "open" then
				setElementPosition(hebebuehne1[6], 1644.4404296875, 756.5, 9.83)
				setElementPosition(hebebuehne2[6], 1646.330078125, 756.5, 9.83)
			elseif getElementData(hebebuehne1[6], "state") == "down" or getElementData(hebebuehne1[6], "state") == "reparieren" then
				setElementPosition(hebebuehne1[6], 1644.4404296875, 756.5, 12)
				setElementPosition(hebebuehne2[6], 1646.330078125, 756.5, 12)
			end			

			if getElementData(hebebuehne1[7], "state") == "open" then
				setElementPosition(hebebuehne1[7],  1653, 756.5107421875, 9.83)
				setElementPosition(hebebuehne2[7],1655.0302734375, 756.5, 9.83)
			elseif getElementData(hebebuehne1[7], "state") == "down" or getElementData(hebebuehne1[6], "state") == "reparieren" then
				setElementPosition(hebebuehne1[7],  1653, 756.5107421875, 12)
				setElementPosition(hebebuehne2[7],1655.0302734375, 756.5, 12)
			end			

			if getElementData(hebebuehne1[8], "state") == "open" then
				setElementPosition(hebebuehne1[8], 1661.7001953125, 756.5, 9.83)
				setElementPosition(hebebuehne2[8], 1663.66015625, 756.5, 9.83)
			elseif getElementData(hebebuehne1[8], "state") == "down" or getElementData(hebebuehne1[6], "state") == "reparieren" then
				setElementPosition(hebebuehne1[8], 1661.7001953125, 756.5, 12)
				setElementPosition(hebebuehne2[8], 1663.66015625, 756.5, 12)
			end					
			
			if getElementData(hebebuehne1[9], "state") == "open" then
				setElementPosition(hebebuehne1[9], 1670.400390625, 756.5, 9.83)
				setElementPosition(hebebuehne2[9], 1672.400390625, 756.48046875, 9.899999618530)
			elseif getElementData(hebebuehne1[9], "state") == "down" or getElementData(hebebuehne1[6], "state") == "reparieren" then
				setElementPosition(hebebuehne1[9], 1670.400390625, 756.5, 12)
				setElementPosition(hebebuehne2[9], 1672.400390625, 756.48046875, 12)
			end	
			
			if getElementData(hebebuehne1[10], "state") == "open" then
				setElementPosition(hebebuehne1[10], 92.40039, -166.12, 1.59375)
				setElementPosition(hebebuehne2[10], 92.400395, -163.76805, 1.59375)
			elseif getElementData(hebebuehne1[10], "state") == "down" or getElementData(hebebuehne1[6], "state") == "reparieren" then
				setElementPosition(hebebuehne1[10], 92.40039, -166.12, 3.59375)
				setElementPosition(hebebuehne2[10], 92.400395, -163.76805, 3.59375)
			end							
			
			if getElementData(lvliefer, "state") == "open" then
				setElementPosition(lvliefer, 1632.2998046875, 773.099609375, 16.66)
			elseif getElementData(lvliefer, "state") == "down" or getElementData(lvliefer, "state") == "moveing" then
				setElementPosition(lvliefer, 1632.2998046875, 773.48046875, 12.340000152588)
				setElementData(lvliefer,"state", "down")
			end
			
			if getElementData(lvwerk, "state") == "open" then
				setElementPosition(lvwerk, 1706.599609375, 729.7998046875, 10.60000038147)
				setElementRotation(lvwerk, 0,0,0)
			elseif getElementData(lvwerk, "state") == "down" or getElementData(lvwerk, "state") == "moveing" then
				setElementPosition(lvwerk, 1706.599609375, 729.7998046875, 10.60000038147)
				setElementRotation(lvwerk, 0,90,0)
				setElementData(lvwerk,"state", "down")
			end
			if getElementData(lveingang1, "state") == "open" then
				setElementPosition(lveingang1, 1578.033203125, 723.2, 13.075480461121)	
			elseif getElementData(lveingang1, "state") == "down" or getElementData(lveingang1, "state") == "moveing" then
				setElementPosition(lveingang1, 1578.033203125, 713.212890625, 13.075480461121)
				setElementData(lveingang1,"state", "down")
			end
			
			if getElementData(hebebuehne1[11], "state") == "open" then
				setElementPosition(hebebuehne1[11], 1679, 756.490234375, 9.83)
				setElementPosition(hebebuehne2[11], 1681.099609375, 756.5, 9.83)
			elseif getElementData(hebebuehne1[11], "state") == "down" or getElementData(hebebuehne1[6], "state") == "reparieren" then
				setElementPosition(hebebuehne1[11], 1679, 756.490234375, 12)
				setElementPosition(hebebuehne2[11],1681.099609375, 756.5, 12)
			end					

			if getElementData(hebebuehne1[12], "state") == "open" then
				setElementPosition(hebebuehne1[12], 1687.1103515625, 756.4501953125, 9.83)
				setElementPosition(hebebuehne2[12], 1690.2197265625, 756.4501953125, 9.83)
			elseif getElementData(hebebuehne1[12], "state") == "down" or getElementData(hebebuehne1[6], "state") == "reparieren" then
				setElementPosition(hebebuehne1[12], 1687.1103515625, 756.4501953125, 12)
				setElementPosition(hebebuehne2[12], 1690.2197265625, 756.4501953125, 12)
			end		

			if getElementData(hebebuehne1[13], "state") == "open" then
				setElementPosition(hebebuehne1[13], 1745, 723.41015625, 9.8800001144409)
				setElementPosition(hebebuehne2[13], 1745, 718.599609375, 9.8800001144409)
			elseif getElementData(hebebuehne1[13], "state") == "down" or getElementData(hebebuehne1[6], "state") == "reparieren" then
				setElementPosition(hebebuehne1[13], 1745, 723.41015625, 12)
				setElementPosition(hebebuehne2[13], 1745, 718.599609375, 12)
			end		

			xmlSaveFile(xml)
			xmlUnloadFile(xml)
	end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), plattenstart)
addEventHandler("onResourceStop", getResourceRootElement(getThisResource()),
	function()
		local xml = xmlLoadFile("./xml/firmen/4.xml")
		if xml then
		
			for i,v in ipairs(adac_repair) do 
				local k = xmlFindChild ( xml, "buehne",i-1 )
				xmlNodeSetValue(k,getElementData(v, "repairs"))
			end
			
			local platte1 = xmlFindChild ( xml, "platte",0 )
			local platte2 = xmlFindChild ( xml, "platte",1 )
			local platte3 = xmlFindChild ( xml, "platte",2 )
			local platte4 = xmlFindChild ( xml, "platte",3 )
			local platte5 = xmlFindChild ( xml, "platte",4 )
			local platte6 = xmlFindChild ( xml, "platte",5 )
			local platte7 = xmlFindChild ( xml, "platte",6 )
			local platte8 = xmlFindChild ( xml, "platte",7 )
			local platte9 = xmlFindChild ( xml, "platte",8 )
			local platte10 = xmlFindChild ( xml, "platte",9 )
			local platte11 = xmlFindChild ( xml, "platte",10 )
			local platte12 = xmlFindChild ( xml, "platte",11 )
			local platte13 = xmlFindChild ( xml, "platte",12 )
			local platte14 = xmlFindChild ( xml, "platte",13 )
			local platte15 = xmlFindChild ( xml, "platte",14 )
			local platte16 = xmlFindChild ( xml, "platte",15 )
			local platte17 = xmlFindChild ( xml, "platte",16 )
			local platte18 = xmlFindChild ( xml, "platte",17 )
			local platte19 = xmlFindChild ( xml, "platte",18 )
			local platte20 = xmlFindChild ( xml, "platte",19 )
			local platte21 = xmlFindChild ( xml, "platte",20 )
			xmlNodeSetValue(platte1,getElementData(hebebuehne1[1], "state"))
			xmlNodeSetValue(platte2,getElementData(hebebuehne1[2], "state"))
			xmlNodeSetValue(platte3,getElementData(hebebuehne1[3], "state"))
			xmlNodeSetValue(platte4,getElementData(hebebuehne1[4], "state"))
			xmlNodeSetValue(platte5,getElementData(repairtor, "state"))
			xmlNodeSetValue(platte6,getElementData(eingangadactuer, "state"))
			xmlNodeSetValue(platte7,getElementData(ausgangadactuer, "state"))
			xmlNodeSetValue(platte8,getElementData(aufzugasdjl, "state"))
			xmlNodeSetValue(platte9,getElementData(hebebuehne1[5], "state"))
			xmlNodeSetValue(platte10,getElementData(hebebuehne1[6], "state"))
			xmlNodeSetValue(platte11,getElementData(lvliefer, "state"))
			xmlNodeSetValue(platte12,getElementData(lvwerk, "state"))
			--xmlNodeSetValue(platte13,getElementData(lvschranke, "state"))
			xmlNodeSetValue(platte14,getElementData(lveingang1, "state"))
			xmlNodeSetValue(platte15,getElementData(hebebuehne1[7], "state"))
			xmlNodeSetValue(platte16,getElementData(hebebuehne1[8], "state"))			
			xmlNodeSetValue(platte17,getElementData(hebebuehne1[9], "state"))
			xmlNodeSetValue(platte18,getElementData(hebebuehne1[10], "state"))
			xmlNodeSetValue(platte19,getElementData(hebebuehne1[11], "state"))
			xmlNodeSetValue(platte20,getElementData(hebebuehne1[12], "state"))
			xmlNodeSetValue(platte21,getElementData(hebebuehne1[13], "state"))
			xmlSaveFile(xml)
			xmlUnloadFile(xml)
		end
	end
)

addEvent("moveFirstPlateUporDown", true)
addEventHandler("moveFirstPlateUporDown", getRootElement(),
		function(id,player)
			if getElementData(player, "job") == 4 then
			if id == 1 then
				if getElementData(hebebuehne1[1], "state") == "open" then
					moveObject(hebebuehne1[1], 2500, -1520.2313232422, 692.52581787109, 8.4)
					moveObject(hebebuehne2[1], 2500, -1517.271484375, 692.51513671875, 8.4)
					setElementData(hebebuehne1[1], "state", "down" )
				elseif getElementData(hebebuehne1[1], "state") == "down" then
					moveObject(hebebuehne1[1], 2500, -1520.2313232422, 692.52581787109, 6.2)
					moveObject(hebebuehne2[1], 2500, -1517.271484375, 692.51513671875, 6.2)
					setElementData(hebebuehne1[1], "state", "open" )
				end
			end
			
			if id == 2 then
				if getElementData(hebebuehne1[2], "state") == "open" then
					moveObject(hebebuehne1[2], 2500,-1511.1024169922, 671.2412109375, 8.4)
					moveObject(hebebuehne2[2], 2500, -1509.7270507813, 671.21875, 8.4)
					setElementData(hebebuehne1[2], "state", "down" )
				elseif getElementData(hebebuehne1[2], "state") == "down" then
					moveObject(hebebuehne1[2], 2500, -1511.1024169922, 671.2412109375, 6.2)
					moveObject(hebebuehne2[2], 2500, -1509.7270507813, 671.21875, 6.2)
					setElementData(hebebuehne1[2], "state", "open" )
				end
			end
			if id == 3 then
				if getElementData(hebebuehne1[3], "state") == "open" then
					moveObject(hebebuehne1[3], 2500,-1491.1604003906, 671.2412109375, 8.4)
					moveObject(hebebuehne2[3], 2500,-1493.5787353516, 671.2412109375, 8.4)
					setElementData(hebebuehne1[3], "state", "down" )
				elseif getElementData(hebebuehne1[3], "state") == "down" then
					moveObject(hebebuehne1[3], 2500, -1491.1604003906, 671.2412109375, 6.2)
					moveObject(hebebuehne2[3], 2500, -1493.5787353516, 671.2412109375, 6.2)
					setElementData(hebebuehne1[3], "state", "open" )
				end
			end
			if id == 4 then
				if getElementData(hebebuehne1[4], "state") == "open" then
					moveObject(hebebuehne1[4], 2500,-1504.5, 671.2412109375, 8.4)
					moveObject(hebebuehne2[4], 2500,-1502.0095214844, 671.2412109375, 8.4)
					setElementData(hebebuehne1[4], "state", "down" )
				elseif getElementData(hebebuehne1[4], "state") == "down" then
					moveObject(hebebuehne1[4], 2500, -1504.5, 671.2412109375, 6.2)
					moveObject(hebebuehne2[4], 2500, -1502.0095214844, 671.2412109375, 6.2)
					setElementData(hebebuehne1[4], "state", "open" )
				end
			end
			if id == 5 then
				if getElementData(repairtor, "state") == "open" then
					moveObject(repairtor, 2500,-1505.5383300781, 747.06762695313, 9.0815515518188,0, -88.077453613281)
					setElementData(repairtor, "state", "moveing")
					setTimer(setElementData,2600,1,repairtor, "state", "down" )
				elseif getElementData(repairtor, "state") == "down" then
					moveObject(repairtor, 2500, -1502.5383300781, 747.06762695313, 11.380932807922, 0, 88.077453613281, 0)
					setElementData(repairtor, "state", "moveing")
					setTimer(setElementData,2600,1,repairtor, "state", "open" )
				end
			end
			
			if id == 6 then
				if getElementData(eingangadactuer, "state") == "open" then
					moveObject(eingangadactuer, 3500,-1516.49609375,710.25,8.386004447937,0, -46.554565429688)
					setElementData(eingangadactuer, "state", "moveing")
					setTimer(setElementData,3600,1,eingangadactuer, "state", "down" )
				elseif getElementData(eingangadactuer, "state") == "down" then
					moveObject(eingangadactuer, 3500, -1516.49609375,708.3994140625,12.401002883911, 0, 46.554565429688, 0)
					setElementData(eingangadactuer, "state", "moveing")
					setTimer(setElementData,3600,1,eingangadactuer, "state", "open" )
				end
			end
			
			if id == 7 then
				if getElementData(ausgangadactuer, "state") == "open" then
					moveObject(ausgangadactuer, 3500,-1493.556640625,710.25,8.386004447937,0, -30.340576171875)
					setElementData(ausgangadactuer, "state", "moveing")
					setTimer(setElementData,3600,1,ausgangadactuer, "state", "down" )
				elseif getElementData(ausgangadactuer, "state") == "down" then
					moveObject(ausgangadactuer, 3500, -1493.5540771484, 708.91467285156, 12.236158370972, 0, 30.340576171875, 0)
					setElementData(ausgangadactuer, "state", "moveing")
					setTimer(setElementData,3600,1,ausgangadactuer, "state", "open" )
				end
			end
			if id == 8 then
				if getElementData(aufzugasdjl, "state") == "open" then
					moveObject(aufzugasdjl, 6000, -1490.6435546875, 693.9560546875, 6.0896143913269, 0, 0, 0)
					setElementData(aufzugasdjl, "state", "moveing")
					setTimer(setElementData,6100,1,aufzugasdjl, "state", "down" )
				elseif getElementData(aufzugasdjl, "state") == "down" then
					moveObject(aufzugasdjl, 6000,-1490.6435546875, 693.95678710938, 10.563302993774)
					setElementData(aufzugasdjl, "state", "moveing")
					setTimer(setElementData,6100,1,aufzugasdjl, "state", "open" )
				end
			end
			if id == 9 then
				if getElementData(hebebuehne1[5], "state") == "open" then
					moveObject(hebebuehne1[5], 2500, 1637.455078125, 756.5, 12)
					moveObject(hebebuehne2[5], 2500, 1636.3203125, 756.5302734375, 12)
					setElementData(hebebuehne1[5], "state", "down" )
				elseif getElementData(hebebuehne1[5], "state") == "down" then
					moveObject(hebebuehne1[5], 2500, 1637.455078125, 756.5, 9.83)
					moveObject(hebebuehne2[5], 2500, 1636.3203125, 756.5302734375, 9.83)
					setElementData(hebebuehne1[5], "state", "open" )
				end
			end

			if id == 10 then
				if getElementData(hebebuehne1[6], "state") == "open" then
					moveObject(hebebuehne1[6], 2500, 1644.4404296875, 756.5, 12)
					moveObject(hebebuehne2[6], 2500, 1646.330078125, 756.5, 12)
					setElementData(hebebuehne1[6], "state", "down" )
				elseif getElementData(hebebuehne1[6], "state") == "down" then
					moveObject(hebebuehne1[6], 2500, 1644.4404296875, 756.5, 9.83)
					moveObject(hebebuehne2[6], 2500, 1646.330078125, 756.5, 9.83)
					setElementData(hebebuehne1[6], "state", "open" )
				end
			end
	
			if id == 11 then
				if getElementData(lvliefer, "state") == "open" then
					moveObject(lvliefer, 2500, 1632.2998046875, 773.48046875, 12.340000152588)
					setElementData(lvliefer, "state", "moveing")
					setTimer(setElementData,2600,1,lvliefer, "state", "down" )
				elseif getElementData(lvliefer, "state") == "down" then
					moveObject(lvliefer, 2500, 1632.2998046875, 773.099609375, 16.66)
					setElementData(lvliefer, "state", "moveing")
					setTimer(setElementData,2600,1,lvliefer, "state", "open" )
				end
			end
			
			if id == 12 then
				if getElementData(lvwerk, "state") == "open" then
					moveObject(lvwerk, 2500, 1706.599609375, 729.7998046875, 10.60000038147,0,90,0)
					setElementData(lvwerk, "state", "moveing")
					setTimer(setElementData,2600,1,lvwerk, "state", "down" )
				elseif getElementData(lvwerk, "state") == "down" then
					moveObject(lvwerk, 2500, 1706.599609375, 729.7998046875, 10.60000038147,0,-90,0)
					setElementData(lvwerk, "state", "moveing")
					setTimer(setElementData,2600,1,lvwerk, "state", "open" )	
				end
			end
			if id == 14 then
				if getElementData(lveingang1, "state") == "open" then
					moveObject(lveingang1, 2500,1578.033203125, 713.212890625, 13.075480461121)			
					setElementData(lveingang1, "state", "down" )
				elseif getElementData(lveingang1, "state") == "down" then
					moveObject(lveingang1, 2500, 1578.033203125, 723.2, 13.075480461121)
					setElementData(lveingang1, "state", "open" )
				end
			end	

			if id == 15 then
				if getElementData(hebebuehne1[7], "state") == "open" then
					moveObject(hebebuehne1[7], 2500,  1653, 756.5107421875, 12)
					moveObject(hebebuehne2[7], 2500,1655.0302734375, 756.5, 12)
					setElementData(hebebuehne1[7], "state", "down" )
				elseif getElementData(hebebuehne1[7], "state") == "down" then
					moveObject(hebebuehne1[7], 2500,  1653, 756.5107421875, 9.83)
					moveObject(hebebuehne2[7], 2500,1655.0302734375, 756.5, 9.83)
					setElementData(hebebuehne1[7], "state", "open" )
				end
			end

			if id == 16 then
				if getElementData(hebebuehne1[8], "state") == "open" then
					moveObject(hebebuehne1[8], 2500, 1661.7001953125, 756.5, 12)
					moveObject(hebebuehne2[8], 2500, 1663.66015625, 756.5, 12)
					setElementData(hebebuehne1[8], "state", "down" )
				elseif getElementData(hebebuehne1[8], "state") == "down" then
					moveObject(hebebuehne1[8], 2500, 1661.7001953125, 756.5, 9.83)
					moveObject(hebebuehne2[8], 2500, 1663.66015625, 756.5, 9.83)
					setElementData(hebebuehne1[8], "state", "open" )
				end
			end
			
			if id == 17 then
				if getElementData(hebebuehne1[9], "state") == "open" then
					moveObject(hebebuehne1[9], 2500, 1670.400390625, 756.5, 12)
					moveObject(hebebuehne2[9], 2500, 1672.400390625, 756.48046875, 12)
					setElementData(hebebuehne1[9], "state", "down" )
				elseif getElementData(hebebuehne1[9], "state") == "down" then
					moveObject(hebebuehne1[9], 2500, 1670.400390625, 756.5, 9.83)
					moveObject(hebebuehne2[9], 2500, 1672.400390625, 756.48046875, 9.83)
					setElementData(hebebuehne1[9], "state", "open" )
				end
			end
			
			if id == 18 then
				if getElementData(lvtor1, "moving") == true then return end
				setElementData(lvtor1, "moving", true)
				setTimer(setElementData,2600,1,lvtor1, "moving", false )
				if getElementData(lvtor1, "state") == "open" then
					moveObject(lvtor1, 2500, 1636.899999, 743.7001953125, 12.10000038147)
					setElementData(lvtor1, "state", "closed")
				else
					moveObject(lvtor1, 2500, 1636.899999, 743.7001953125, 16.4)
					setElementData(lvtor1, "state", "open")
				end
			end
			if id == 19 then
				if getElementData(lvtor2, "moving") == true then return end
				setElementData(lvtor2, "moving", true)
				setTimer(setElementData,2600,1,lvtor2, "moving", false )			
				if getElementData(lvtor2, "state") == "open" then
					moveObject(lvtor2, 2500, 1645.2998046875, 743.7001953125, 12.10000038147)
					setElementData(lvtor2, "state", "closed")
				else
					moveObject(lvtor2, 2500, 1645.2998046875, 743.7001953125, 16.4)
					setElementData(lvtor2, "state", "open")
				end
			end	
			if id == 20 then
				if getElementData(lvtor3, "moving") == true then return end
				setElementData(lvtor3, "moving", true)
				setTimer(setElementData,2600,1,lvtor3, "moving", false )			
				if getElementData(lvtor3, "state") == "open" then
					moveObject(lvtor3, 2500,  1654.099609375, 743.7001953125, 12.10000038147)
					setElementData(lvtor3, "state", "closed")
				else
					moveObject(lvtor3, 2500, 1654.099609375, 743.7001953125, 16.4)
					setElementData(lvtor3, "state", "open")
				end
			end		
			if id == 21 then
				if getElementData(lvtor4, "moving") == true then return end
				setElementData(lvtor4, "moving", true)
				setTimer(setElementData,2600,1,lvtor4, "moving", false )			
				if getElementData(lvtor4, "state") == "open" then
					moveObject(lvtor4, 2500,  1662.7998046875, 743.7001953125, 12.10000038147)
					setElementData(lvtor4, "state", "closed")
				else
					moveObject(lvtor4, 2500, 1662.7998046875, 743.7001953125, 16.4)
					setElementData(lvtor4, "state", "open")
				end
			end	
			if id == 22 then
				if getElementData(lvtor5, "moving") == true then return end
				setElementData(lvtor5, "moving", true)
				setTimer(setElementData,2600,1,lvtor5, "moving", false )			
				if getElementData(lvtor5, "state") == "open" then
					moveObject(lvtor5, 2500, 1671.400390625, 743.7001953125, 12.10000038147)
					setElementData(lvtor5, "state", "closed")
				else
					moveObject(lvtor5, 2500, 1671.400390625, 743.7001953125, 16.4)
					setElementData(lvtor5, "state", "open")
				end
			end			
			if id == 23 then
				if getElementData(lvschranke1, "moving") == true then return end
				setElementData(lvschranke1, "moving", true)
				setTimer(setElementData,2600,1,lvschranke1, "moving", false )			
				if getElementData(lvschranke1, "state") == "open" then
					moveObject(lvschranke1, 2500,1733.599609375, 743.900390625, 10.60000038147, 0, 90, 0)
					setElementData(lvschranke1, "state", "closed")
				else
					moveObject(lvschranke1, 2500,1733.599609375, 743.900390625, 10.60000038147, 0, -90, 0)
					setElementData(lvschranke1, "state", "open")
				end
			end		
			if id == 24 then
				if getElementData(bluetor1, "moving") == true then return end
				setElementData(bluetor1, "moving", true)
				setTimer(setElementData,2600,1,bluetor1, "moving", false )			
				if getElementData(bluetor1, "state") == "open" then
					moveObject(bluetor1, 2500, 88.2,-161,2.9)
					setElementData(bluetor1, "state", "closed")
				else
					moveObject(bluetor1, 2500, 88.2,-161,-0.1)
					setElementData(bluetor1, "state", "open")
				end
			end		
			if id == 25 then
				if getElementData(bluetor2, "moving") == true then return end
				setElementData(bluetor2, "moving", true)
				setTimer(setElementData,2600,1,bluetor2, "moving", false )			
				if getElementData(bluetor2, "state") == "open" then
					moveObject(bluetor2, 2500, 100,-164.7,2.9)
					setElementData(bluetor2, "state", "closed")
				else
					moveObject(bluetor2 ,2500, 100,-164.7,-0.1)
					setElementData(bluetor2, "state", "open")
				end
			end	
			if id == 26 then
				if getElementData(hebebuehne1[10], "state") == "open" then
					moveObject(hebebuehne1[10], 2500, 92.40039, -166.12, 3.59375)
					moveObject(hebebuehne2[10], 2500, 92.400395, -163.76805, 3.59375)
					setElementData(hebebuehne1[10], "state", "down" )
				elseif getElementData(hebebuehne1[10], "state") == "down" then
					moveObject(hebebuehne1[10], 2500,  92.40039, -166.12, 1.59375)
					moveObject(hebebuehne2[10], 2500, 92.400395, -163.76805, 1.59375)
					setElementData(hebebuehne1[10], "state", "open" )
				end
			end	
			if id == 27 then
				if getElementData(hebebuehne1[11], "state") == "open" then
					moveObject(hebebuehne1[11], 2500, 1679, 756.490234375, 12)
					moveObject(hebebuehne2[11], 2500, 1681.099609375, 756.5, 12)
					setElementData(hebebuehne1[11], "state", "down" )
				elseif getElementData(hebebuehne1[11], "state") == "down" then
					moveObject(hebebuehne1[11], 2500, 1679, 756.490234375, 9.83)
					moveObject(hebebuehne2[11], 2500, 1681.099609375, 756.5, 9.83)
					setElementData(hebebuehne1[11], "state", "open" )
				end
			end
			if id == 28 then
				if getElementData(hebebuehne1[12], "state") == "open" then
					moveObject(hebebuehne1[12], 2500, 1687.1103515625, 756.4501953125, 12)
					moveObject(hebebuehne2[12], 2500, 1690.2197265625, 756.4501953125, 12)
					setElementData(hebebuehne1[12], "state", "down" )
				elseif getElementData(hebebuehne1[12], "state") == "down" then
					moveObject(hebebuehne1[12], 2500, 1687.1103515625, 756.4501953125, 9.83)
					moveObject(hebebuehne2[12], 2500, 1690.2197265625, 756.4501953125, 9.83)
					setElementData(hebebuehne1[12], "state", "open" )
				end
			end
			if id == 29 then
				if getElementData(hebebuehne1[13], "state") == "open" then
					moveObject(hebebuehne1[13], 2500, 1745, 723.41015625, 12)
					moveObject(hebebuehne2[13], 2500, 1745, 718.599609375, 12)
					setElementData(hebebuehne1[13], "state", "down" )
				elseif getElementData(hebebuehne1[13], "state") == "down" then
					moveObject(hebebuehne1[13], 2500, 1745, 723.41015625, 9.8800001144409)
					moveObject(hebebuehne2[13], 2500, 1745, 718.599609375, 9.8800001144409)
					setElementData(hebebuehne1[13], "state", "open" )
				end
			end		
			if id == 30 then
				if getElementData(lvtor6, "moving") == true then return end
				setElementData(lvtor6, "moving", true)
				setTimer(setElementData,2600,1,lvtor6, "moving", false )			
				if getElementData(lvtor6, "state") == "open" then
					moveObject(lvtor6, 2500, 1680.2001953125, 743.7001953125, 12.10000038147)
					setElementData(lvtor6, "state", "closed")
				else
					moveObject(lvtor6, 2500, 1680.2001953125, 743.7001953125, 16.4)
					setElementData(lvtor6, "state", "open")
				end
			end	
			if id == 31 then
				if getElementData(lvtor7, "moving") == true then return end
				setElementData(lvtor7, "moving", true)
				setTimer(setElementData,2600,1,lvtor7, "moving", false )			
				if getElementData(lvtor7, "state") == "open" then
					moveObject(lvtor7, 2500, 1688.900390625, 743.7001953125, 12.10000038147)
					setElementData(lvtor7, "state", "closed")
				else
					moveObject(lvtor7, 2500, 1688.900390625, 743.7001953125, 16.4)
					setElementData(lvtor7, "state", "open")
				end
			end				
		end   
		
	end
)

function AutoReparieren(thePlayer, command)
		if getElementData(thePlayer, "job") == 4 and getElementData(thePlayer, "dienst") == 1 then
			if getElementData(thePlayer, "promille") >= 2 or getElementData(thePlayer, "promillesoll") >= 2 then
				triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Du bist zu betrunken um ein Auto zu reparieren." )
				return
			end		
			local firemen = false
			for i,v in ipairs(getElementsByType("player")) do
				if getElementData(v, "job") == 7 and getElementData(v, "dienst") == 1 and getElementData(v, "afk") ~= true then
					firemen = true
					break
				end
			end
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[1])) and (isElementWithinMarker ( e, adac_repair[1] )) and getElementData(hebebuehne1[1], "state") == "down" then
						if getElementData(adac_repair[1], "repairs") == 0 then
							return triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Du kannst hier im Moment nichts reparieren.\nInterTrans muss erst neue Teile nachliefern." )
						else
							setElementData(adac_repair[1], "repairs", getElementData(adac_repair[1], "repairs")-1)
						end
						
						if math.random(1,16) == 1 and firemen == true then setElementData(e, "onFire", true) triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Gratulation.\nDank deiner Reparatur brennt jetzt das Fahrzeug..." ) end
						if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Du kannst kein brennendes Fahrzeug reparieren." ) return false end
						local randomint = 10000/getElementHealth(e)
						local reperaturzeit = 60+randomint
						setElementData(hebebuehne1[1], "state", "reparieren" )
						setPedRotation(thePlayer, 358.26138305664 )
						triggerClientEvent ( thePlayer, "InitReperatur", getRootElement(), math.ceil(reperaturzeit))
						
					setTimer(
						function(veh)
							if isVehicleLocked(veh) ~= true then
								setVehicleDamageProof(veh, false)
								setElementFrozen(veh, false)
							end
							setElementData(hebebuehne1[1], "state", "open" )
							setElementData(veh, "blockUnfreeze", false)
						end
					,math.ceil(reperaturzeit)*1000,1,e)

						reperaturvehicle[thePlayer]  = e
						setElementFrozen(e, true)
						setElementData(e, "blockUnfreeze", true)
						break
			   end
			end
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[2])) and (isElementWithinMarker ( e, adac_repair[2] )) and getElementData(hebebuehne1[2], "state") == "down" then
					if getElementData(adac_repair[2], "repairs") == 0 then
						return triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Du kannst hier im Moment nichts reparieren.\nInterTrans muss erst neue Teile nachliefern." )
					else
						setElementData(adac_repair[2], "repairs", getElementData(adac_repair[2], "repairs")-1)
					end					
					
					if math.random(1,16) == 1 and firemen == true then setElementData(e, "onFire", true) triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Gratulation.\nDank deiner Reparatur brennt jetzt das Fahrzeug..." ) end
					if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Du kannst kein brennendes Fahrzeug reparieren." ) return false end
					local randomint = 10000/getElementHealth(e)
					local reperaturzeit = 60+randomint
					setElementData(hebebuehne1[2], "state", "reparieren" )
					
					setPedRotation(thePlayer, 358.26138305664 )
					triggerClientEvent ( thePlayer, "InitReperatur", getRootElement(), math.ceil(reperaturzeit))
					
					setTimer(
						function(veh)
							if isVehicleLocked(veh) ~= true then
								setVehicleDamageProof(veh, false)
								setElementFrozen(veh, false)
							end
							setElementData(hebebuehne1[2], "state", "open" )
							setElementData(veh, "blockUnfreeze", false)
						end
					,math.ceil(reperaturzeit)*1000,1,e)
					
					reperaturvehicle[thePlayer]  = e
					setElementFrozen(e, true)
					setElementData(e, "blockUnfreeze", true)
					break
			   end
			end
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[3])) and (isElementWithinMarker ( e, adac_repair[3] )) and getElementData(hebebuehne1[3], "state") == "down" then
					if getElementData(adac_repair[3], "repairs") == 0 then
						return triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Du kannst hier im Moment nichts reparieren.\nInterTrans muss erst neue Teile nachliefern." )
					else
						setElementData(adac_repair[3], "repairs", getElementData(adac_repair[3], "repairs")-1)
					end							
					
					if math.random(1,16) == 1 and firemen == true then setElementData(e, "onFire", true) triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Gratulation.\nDank deiner Reparatur brennt jetzt das Fahrzeug..." ) end
					if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Du kannst kein brennendes Fahrzeug reparieren." ) return false end
					local randomint = 10000/getElementHealth(e)
					local reperaturzeit = 60+randomint
					setElementData(hebebuehne1[3], "state", "reparieren" )
					
					setPedRotation(thePlayer, 358.26138305664 )
					triggerClientEvent ( thePlayer, "InitReperatur", getRootElement(), math.ceil(reperaturzeit))
					
						setTimer(
						function(veh)
							if isVehicleLocked(veh) ~= true then
								setVehicleDamageProof(veh, false)
								setElementFrozen(veh, false)
							end
							setElementData(hebebuehne1[6], "state", "open" )
							setElementData(veh, "blockUnfreeze", false)
						end
					,math.ceil(reperaturzeit)*1000,1,e)
					
					reperaturvehicle[thePlayer]  = e
					setElementFrozen(e, true)
					setElementData(e, "blockUnfreeze", true)
					break
			   end
			end
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[4])) and (isElementWithinMarker ( e, adac_repair[4] )) and getElementData(hebebuehne1[4], "state") == "down" then
					if getElementData(adac_repair[4], "repairs") == 0 then
						return triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Du kannst hier im Moment nichts reparieren.\nInterTrans muss erst neue Teile nachliefern." )
					else
						setElementData(adac_repair[4], "repairs", getElementData(adac_repair[4], "repairs")-1)
					end		
					
					if math.random(1,16) == 1 and firemen == true then setElementData(e, "onFire", true) triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Gratulation.\nDank deiner Reparatur brennt jetzt das Fahrzeug..." ) end
					if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Du kannst kein brennendes Fahrzeug reparieren." ) return false end
					local randomint = 10000/getElementHealth(e)
					local reperaturzeit = 60+randomint
					setElementData(hebebuehne1[4], "state", "reparieren" )

					setTimer(
						function(veh)
							if isVehicleLocked(veh) ~= true then
								setVehicleDamageProof(veh, false)
								setElementFrozen(veh, false)
							end
							setElementData(hebebuehne1[4], "state", "open" )
							setElementData(veh, "blockUnfreeze", false)
						end
					,math.ceil(reperaturzeit)*1000,1,e)
					
					setPedRotation(thePlayer, 358.26138305664 )
					triggerClientEvent ( thePlayer, "InitReperatur", getRootElement(), math.ceil(reperaturzeit))

					reperaturvehicle[thePlayer] = e
					setElementFrozen(e, true)
					setElementData(e, "blockUnfreeze", true)
					break
			   end
			end
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[5])) and (isElementWithinMarker ( e, adac_repair[5] )) and getElementData(hebebuehne1[5], "state") == "down" then
					if getElementData(adac_repair[5], "repairs") == 0 then
						return triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Du kannst hier im Moment nichts reparieren.\nInterTrans muss erst neue Teile nachliefern." )
					else
						setElementData(adac_repair[5], "repairs", getElementData(adac_repair[5], "repairs")-1)
					end							
					
					if math.random(1,16) == 1 and firemen == true then setElementData(e, "onFire", true) triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Gratulation.\nDank deiner Reparatur brennt jetzt das Fahrzeug..." ) end
					if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Du kannst kein brennendes Fahrzeug reparieren." ) return false end
					local randomint = 10000/getElementHealth(e)
					local reperaturzeit = 60+randomint
					setElementData(hebebuehne1[5], "state", "reparieren" )
					
					setPedRotation(thePlayer, 358.26138305664 )
					triggerClientEvent ( thePlayer, "InitReperatur", getRootElement(), math.ceil(reperaturzeit))

					setTimer(
						function(veh)
							if isVehicleLocked(veh) ~= true then
								setVehicleDamageProof(veh, false)
								setElementFrozen(veh, false)
							end
							setElementData(hebebuehne1[5], "state", "open" )
							setElementData(veh, "blockUnfreeze", false)
						end
					,math.ceil(reperaturzeit)*1000,1,e)					
					
					reperaturvehicle[thePlayer] = e
					setElementFrozen(e, true)
					setElementData(e, "blockUnfreeze", true)
					break
			   end
			end		
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[6])) and (isElementWithinMarker ( e, adac_repair[6] )) and getElementData(hebebuehne1[6], "state") == "down" then
					if getElementData(adac_repair[6], "repairs") == 0 then
						return triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Du kannst hier im Moment nichts reparieren.\nInterTrans muss erst neue Teile nachliefern." )
					else
						setElementData(adac_repair[6], "repairs", getElementData(adac_repair[6], "repairs")-1)
					end							
					
					if math.random(1,16) == 1 and firemen == true then setElementData(e, "onFire", true) triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Gratulation.\nDank deiner Reparatur brennt jetzt das Fahrzeug..." ) end
					if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Du kannst kein brennendes Fahrzeug reparieren." ) return false end
					local randomint = 10000/getElementHealth(e)
					local reperaturzeit = 60+randomint
					setElementData(hebebuehne1[6], "state", "reparieren" )
					
					setTimer(
						function(veh)
							if isVehicleLocked(veh) ~= true then
								setVehicleDamageProof(veh, false)
								setElementFrozen(veh, false)
							end
							setElementData(hebebuehne1[6], "state", "open" )
							setElementData(veh, "blockUnfreeze", false)
						end
					,math.ceil(reperaturzeit)*1000,1,e)
					
					setPedRotation(thePlayer, 358.26138305664 )
					triggerClientEvent ( thePlayer, "InitReperatur", getRootElement(), math.ceil(reperaturzeit))

					reperaturvehicle[thePlayer] = e
					setElementFrozen(e, true)
					setElementData(e, "blockUnfreeze", true)
					break
			   end
			end	
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[7])) and (isElementWithinMarker ( e, adac_repair[7] )) and getElementData(hebebuehne1[7], "state") == "down" then
					if getElementData(adac_repair[7], "repairs") == 0 then
						return triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Du kannst hier im Moment nichts reparieren.\nInterTrans muss erst neue Teile nachliefern." )
					else
						setElementData(adac_repair[7], "repairs", getElementData(adac_repair[7], "repairs")-1)
					end							
					
					if math.random(1,16) == 1 and firemen == true then setElementData(e, "onFire", true) triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Gratulation.\nDank deiner Reparatur brennt jetzt das Fahrzeug..." ) end
					if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Du kannst kein brennendes Fahrzeug reparieren." ) return false end
					local randomint = 10000/getElementHealth(e)
					local reperaturzeit = 60+randomint
					setElementData(hebebuehne1[7], "state", "reparieren" )
					
					setTimer(
						function(veh)
							if isVehicleLocked(veh) ~= true then
								setVehicleDamageProof(veh, false)
								setElementFrozen(veh, false)
							end
							setElementData(hebebuehne1[7], "state", "open" )
							setElementData(veh, "blockUnfreeze", false)
						end
					,math.ceil(reperaturzeit)*1000,1,e)
					
					setPedRotation(thePlayer, 358.26138305664 )
					triggerClientEvent ( thePlayer, "InitReperatur", getRootElement(), math.ceil(reperaturzeit))

					reperaturvehicle[thePlayer] = e
					setElementFrozen(e, true)
					setElementData(e, "blockUnfreeze", true)
					break
			   end
			end		
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[8])) and (isElementWithinMarker ( e, adac_repair[8] )) and getElementData(hebebuehne1[8], "state") == "down" then
					if getElementData(adac_repair[8], "repairs") == 0 then
						return triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Du kannst hier im Moment nichts reparieren.\nInterTrans muss erst neue Teile nachliefern." )
					else
						setElementData(adac_repair[8], "repairs", getElementData(adac_repair[8], "repairs")-1)
					end							
					
					if math.random(1,16) == 1 and firemen == true then setElementData(e, "onFire", true) triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Gratulation.\nDank deiner Reparatur brennt jetzt das Fahrzeug..." ) end
					if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Du kannst kein brennendes Fahrzeug reparieren." ) return false end
					local randomint = 10000/getElementHealth(e)
					local reperaturzeit = 60+randomint
					setElementData(hebebuehne1[8], "state", "reparieren" )
					
					setTimer(
						function(veh)
							if isVehicleLocked(veh) ~= true then
								setVehicleDamageProof(veh, false)
								setElementFrozen(veh, false)
							end
							setElementData(hebebuehne1[8], "state", "open" )
							setElementData(veh, "blockUnfreeze", false)
						end
					,math.ceil(reperaturzeit)*1000,1,e)
					
					setPedRotation(thePlayer, 358.26138305664 )
					triggerClientEvent ( thePlayer, "InitReperatur", getRootElement(), math.ceil(reperaturzeit))

					reperaturvehicle[thePlayer] = e
					setElementFrozen(e, true)
					setElementData(e, "blockUnfreeze", true)
					break
			   end
			end				
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[9])) and (isElementWithinMarker ( e, adac_repair[9] )) and getElementData(hebebuehne1[9], "state") == "down" then
					if getElementData(adac_repair[9], "repairs") == 0 then
						return triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Du kannst hier im Moment nichts reparieren.\nInterTrans muss erst neue Teile nachliefern." )
					else
						setElementData(adac_repair[9], "repairs", getElementData(adac_repair[9], "repairs")-1)
					end							
					
					if math.random(1,16) == 1 and firemen == true then setElementData(e, "onFire", true) triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Gratulation.\nDank deiner Reparatur brennt jetzt das Fahrzeug..." ) end
					if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Du kannst kein brennendes Fahrzeug reparieren." ) return false end
					local randomint = 10000/getElementHealth(e)
					local reperaturzeit = 60+randomint
					setElementData(hebebuehne1[9], "state", "reparieren" )
					
					setTimer(
						function(veh)
							if isVehicleLocked(veh) ~= true then
								setVehicleDamageProof(veh, false)
								setElementFrozen(veh, false)
							end
							setElementData(hebebuehne1[9], "state", "open" )
							setElementData(veh, "blockUnfreeze", false)
						end
					,math.ceil(reperaturzeit)*1000,1,e)
					
					setPedRotation(thePlayer, 358.26138305664 )
					triggerClientEvent ( thePlayer, "InitReperatur", getRootElement(), math.ceil(reperaturzeit))

					reperaturvehicle[thePlayer] = e
					setElementFrozen(e, true)
					setElementData(e, "blockUnfreeze", true)
					break
			   end
			end			
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[10])) and (isElementWithinMarker ( e, adac_repair[10] )) and getElementData(hebebuehne1[10], "state") == "down" then
					if getElementData(adac_repair[10], "repairs") == 0 then
						return triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Du kannst hier im Moment nichts reparieren.\nInterTrans muss erst neue Teile nachliefern." )
					else
						setElementData(adac_repair[10], "repairs", getElementData(adac_repair[10], "repairs")-1)
					end							
					
					if math.random(1,16) == 1 and firemen == true then setElementData(e, "onFire", true) triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Gratulation.\nDank deiner Reparatur brennt jetzt das Fahrzeug..." ) end
					if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Du kannst kein brennendes Fahrzeug reparieren." ) return false end
					local randomint = 10000/getElementHealth(e)
					local reperaturzeit = 60+randomint
					setElementData(hebebuehne1[10], "state", "reparieren" )
					
					setTimer(
						function(veh)
							if isVehicleLocked(veh) ~= true then
								setVehicleDamageProof(veh, false)
								setElementFrozen(veh, false)
							end
							setElementData(hebebuehne1[10], "state", "open" )
							setElementData(e, "blockUnfreeze", false)
						end
					,math.ceil(reperaturzeit)*1000,1,e)
					
					setPedRotation(thePlayer, 358.26138305664 )
					triggerClientEvent ( thePlayer, "InitReperatur", getRootElement(), math.ceil(reperaturzeit))

					reperaturvehicle[thePlayer] = e
					setElementFrozen(e, true)
					setElementData(e, "blockUnfreeze", true)
					break
			   end
			end				
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[11])) and (isElementWithinMarker ( e, adac_repair[11] )) and getElementData(hebebuehne1[11], "state") == "down" then
					if getElementData(adac_repair[11], "repairs") == 0 then
						return triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Du kannst hier im Moment nichts reparieren.\nInterTrans muss erst neue Teile nachliefern." )
					else
						setElementData(adac_repair[11], "repairs", getElementData(adac_repair[11], "repairs")-1)
					end							
					
					if math.random(1,16) == 1 and firemen == true then setElementData(e, "onFire", true) triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Gratulation.\nDank deiner Reparatur brennt jetzt das Fahrzeug..." ) end
					if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Du kannst kein brennendes Fahrzeug reparieren." ) return false end
					local randomint = 10000/getElementHealth(e)
					local reperaturzeit = 60+randomint
					setElementData(hebebuehne1[11], "state", "reparieren" )
					
					setTimer(
						function(veh)
							if isVehicleLocked(veh) ~= true then
								setVehicleDamageProof(veh, false)
								setElementFrozen(veh, false)
							end
							setElementData(hebebuehne1[11], "state", "open" )
							setElementData(e, "blockUnfreeze", false)
						end
					,math.ceil(reperaturzeit)*1000,1,e)
					
					setPedRotation(thePlayer, 358.26138305664 )
					triggerClientEvent ( thePlayer, "InitReperatur", getRootElement(), math.ceil(reperaturzeit))

					reperaturvehicle[thePlayer] = e
					setElementFrozen(e, true)
					setElementData(e, "blockUnfreeze", true)
					break
			   end
			end				
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[12])) and (isElementWithinMarker ( e, adac_repair[12] )) and getElementData(hebebuehne1[12], "state") == "down" then
					if getElementData(adac_repair[12], "repairs") == 0 then
						return triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Du kannst hier im Moment nichts reparieren.\nInterTrans muss erst neue Teile nachliefern." )
					else
						setElementData(adac_repair[12], "repairs", getElementData(adac_repair[12], "repairs")-1)
					end							
					
					if math.random(1,16) == 1 and firemen == true then setElementData(e, "onFire", true) triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Gratulation.\nDank deiner Reparatur brennt jetzt das Fahrzeug..." ) end
					if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Du kannst kein brennendes Fahrzeug reparieren." ) return false end
					local randomint = 10000/getElementHealth(e)
					local reperaturzeit = 60+randomint
					setElementData(hebebuehne1[12], "state", "reparieren" )
					
					setTimer(
						function(veh)
							if isVehicleLocked(veh) ~= true then
								setVehicleDamageProof(veh, false)
								setElementFrozen(veh, false)
							end
							setElementData(hebebuehne1[12], "state", "open" )
							setElementData(e, "blockUnfreeze", false)
						end
					,math.ceil(reperaturzeit)*1000,1,e)
					
					setPedRotation(thePlayer, 358.26138305664 )
					triggerClientEvent ( thePlayer, "InitReperatur", getRootElement(), math.ceil(reperaturzeit))

					reperaturvehicle[thePlayer] = e
					setElementFrozen(e, true)
					setElementData(e, "blockUnfreeze", true)
					break
			   end
			end				
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[13])) and (isElementWithinMarker ( e, adac_repair[13] )) and getElementData(hebebuehne1[13], "state") == "down" then
					if getElementData(adac_repair[13], "repairs") == 0 then
						return triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Du kannst hier im Moment nichts reparieren.\nInterTrans muss erst neue Teile nachliefern." )
					else
						setElementData(adac_repair[13], "repairs", getElementData(adac_repair[13], "repairs")-1)
					end							
					
					if math.random(1,16) == 1 and firemen == true then setElementData(e, "onFire", true) triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Gratulation.\nDank deiner Reparatur brennt jetzt das Fahrzeug..." ) end
					if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Du kannst kein brennendes Fahrzeug reparieren." ) return false end
					local randomint = 10000/getElementHealth(e)
					local reperaturzeit = 60+randomint
					setElementData(hebebuehne1[3], "state", "reparieren" )
					
					setTimer(
						function(veh)
							if isVehicleLocked(veh) ~= true then
								setVehicleDamageProof(veh, false)
								setElementFrozen(veh, false)
							end
							setElementData(hebebuehne1[13], "state", "open" )
							setElementData(e, "blockUnfreeze", false)
						end
					,math.ceil(reperaturzeit)*1000,1,e)
					
					setPedRotation(thePlayer, 358.26138305664 )
					triggerClientEvent ( thePlayer, "InitReperatur", getRootElement(), math.ceil(reperaturzeit))

					reperaturvehicle[thePlayer] = e
					setElementFrozen(e, true)
					setElementData(e, "blockUnfreeze", true)
					break
			   end
			end				
		end		
end	

addCommandHandler("reparieren", AutoReparieren)

function refillWater(thePlayer, command)
		if getElementData(thePlayer, "job") == 4 and getElementData(thePlayer, "dienst") == 1 then
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[1])) and (isElementWithinMarker ( e, adac_repair[1] )) and getElementData(hebebuehne1[1], "state") == "down" then
					if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Das Fahrzeug in in Flammen! Du kannst das nicht tun." ) return false end
					if getVehicleOccupant ( e,0 ) then outputChatBox("Es darf sich kein Fahrer im Fahrzeug befinden.", thePlayer, 255,0,0) return end
					setElementData(e, "water", 100 )
					callClientFunction(thePlayer, "setVehicleWaterFromServer", 100)
					outputChatBox("Kühlwasser nachgefüllt.", thePlayer, 0, 255, 0)
					break
			   end
			end
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[2])) and (isElementWithinMarker ( e, adac_repair[2] )) and getElementData(hebebuehne1[2], "state") == "down" then
					if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Das Fahrzeug in in Flammen! Du kannst das nicht tun." ) return false end
					if getVehicleOccupant ( e,0 ) then outputChatBox("Es darf sich kein Fahrer im Fahrzeug befinden.", thePlayer, 255,0,0) return end
					setElementData(e, "water", 100 )
					callClientFunction(thePlayer, "setVehicleWaterFromServer", 100)
					outputChatBox("Kühlwasser nachgefüllt.", thePlayer, 0, 255, 0)
					break
			   end
			end
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[3])) and (isElementWithinMarker ( e, adac_repair[3] )) and getElementData(hebebuehne1[3], "state") == "down" then
					if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Das Fahrzeug in in Flammen! Du kannst das nicht tun." ) return false end
					if getVehicleOccupant ( e,0 ) then outputChatBox("Es darf sich kein Fahrer im Fahrzeug befinden.", thePlayer, 255,0,0) return end
					setElementData(e, "water", 100 )
					callClientFunction(thePlayer, "setVehicleWaterFromServer", 100)
					outputChatBox("Kühlwasser nachgefüllt.", thePlayer, 0, 255, 0)
					break
			   end
			end
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[4])) and (isElementWithinMarker ( e, adac_repair[4] )) and getElementData(hebebuehne1[4], "state") == "down" then
					if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Das Fahrzeug in in Flammen! Du kannst das nicht tun." ) return false end
					if getVehicleOccupant ( e,0 ) then outputChatBox("Es darf sich kein Fahrer im Fahrzeug befinden.", thePlayer, 255,0,0) return end
					setElementData(e, "water", 100 )
					callClientFunction(thePlayer, "setVehicleWaterFromServer", 100)
					outputChatBox("Kühlwasser nachgefüllt.", thePlayer, 0, 255, 0)
					break
			   end
			end
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[5])) and (isElementWithinMarker ( e, adac_repair[5] )) and getElementData(hebebuehne1[5], "state") == "down" then
					if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Das Fahrzeug in in Flammen! Du kannst das nicht tun." ) return false end
					if getVehicleOccupant ( e,0 ) then outputChatBox("Es darf sich kein Fahrer im Fahrzeug befinden.", thePlayer, 255,0,0) return end
					setElementData(e, "water", 100 )
					callClientFunction(thePlayer, "setVehicleWaterFromServer", 100)
					outputChatBox("Kühlwasser nachgefüllt.", thePlayer, 0, 255, 0)
					break
			   end
			end
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[6])) and (isElementWithinMarker ( e, adac_repair[6] )) and getElementData(hebebuehne1[6], "state") == "down" then
					if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Das Fahrzeug in in Flammen! Du kannst das nicht tun." ) return false end
					if getVehicleOccupant ( e,0 ) then outputChatBox("Es darf sich kein Fahrer im Fahrzeug befinden.", thePlayer, 255,0,0) return end
					setElementData(e, "water", 100 )
					callClientFunction(thePlayer, "setVehicleWaterFromServer", 100)
					outputChatBox("Kühlwasser nachgefüllt.", thePlayer, 0, 255, 0)
					break
			   end
			end		
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[7])) and (isElementWithinMarker ( e, adac_repair[7] )) and getElementData(hebebuehne1[7], "state") == "down" then
					if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Das Fahrzeug in in Flammen! Du kannst das nicht tun." ) return false end
					if getVehicleOccupant ( e,0 ) then outputChatBox("Es darf sich kein Fahrer im Fahrzeug befinden.", thePlayer, 255,0,0) return end
					setElementData(e, "water", 100 )
					callClientFunction(thePlayer, "setVehicleWaterFromServer", 100)
					outputChatBox("Kühlwasser nachgefüllt.", thePlayer, 0, 255, 0)
					break
			   end
			end	
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[8])) and (isElementWithinMarker ( e, adac_repair[8] )) and getElementData(hebebuehne1[8], "state") == "down" then
					if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Das Fahrzeug in in Flammen! Du kannst das nicht tun." ) return false end
					if getVehicleOccupant ( e,0 ) then outputChatBox("Es darf sich kein Fahrer im Fahrzeug befinden.", thePlayer, 255,0,0) return end
					setElementData(e, "water", 100 )
					callClientFunction(thePlayer, "setVehicleWaterFromServer", 100)
					outputChatBox("Kühlwasser nachgefüllt.", thePlayer, 0, 255, 0)
					break
			   end
			end				
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[9])) and (isElementWithinMarker ( e, adac_repair[9] )) and getElementData(hebebuehne1[9], "state") == "down" then
					if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Das Fahrzeug in in Flammen! Du kannst das nicht tun." ) return false end
					if getVehicleOccupant ( e,0 ) then outputChatBox("Es darf sich kein Fahrer im Fahrzeug befinden.", thePlayer, 255,0,0) return end
					setElementData(e, "water", 100 )
					callClientFunction(thePlayer, "setVehicleWaterFromServer", 100)
					outputChatBox("Kühlwasser nachgefüllt.", thePlayer, 0, 255, 0)
					break
			   end
			end
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[10])) and (isElementWithinMarker ( e, adac_repair[10] )) and getElementData(hebebuehne1[10], "state") == "down" then
					if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Das Fahrzeug in in Flammen! Du kannst das nicht tun." ) return false end
					if getVehicleOccupant ( e,0 ) then outputChatBox("Es darf sich kein Fahrer im Fahrzeug befinden.", thePlayer, 255,0,0) return end
					setElementData(e, "water", 100 )
					callClientFunction(thePlayer, "setVehicleWaterFromServer", 100)
					outputChatBox("Kühlwasser nachgefüllt.", thePlayer, 0, 255, 0)
					break
			   end
			end	
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[11])) and (isElementWithinMarker ( e, adac_repair[11] )) and getElementData(hebebuehne1[11], "state") == "down" then
					if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Das Fahrzeug in in Flammen! Du kannst das nicht tun." ) return false end
					if getVehicleOccupant ( e,0 ) then outputChatBox("Es darf sich kein Fahrer im Fahrzeug befinden.", thePlayer, 255,0,0) return end
					setElementData(e, "water", 100 )
					callClientFunction(thePlayer, "setVehicleWaterFromServer", 100)
					outputChatBox("Kühlwasser nachgefüllt.", thePlayer, 0, 255, 0)
					break
			   end
			end	
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[12])) and (isElementWithinMarker ( e, adac_repair[12] )) and getElementData(hebebuehne1[12], "state") == "down" then
					if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Das Fahrzeug in in Flammen! Du kannst das nicht tun." ) return false end
					if getVehicleOccupant ( e,0 ) then outputChatBox("Es darf sich kein Fahrer im Fahrzeug befinden.", thePlayer, 255,0,0) return end
					setElementData(e, "water", 100 )
					callClientFunction(thePlayer, "setVehicleWaterFromServer", 100)
					outputChatBox("Kühlwasser nachgefüllt.", thePlayer, 0, 255, 0)
					break
			   end
			end	
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[13])) and (isElementWithinMarker ( e, adac_repair[13] )) and getElementData(hebebuehne1[13], "state") == "down" then
					if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Das Fahrzeug in in Flammen! Du kannst das nicht tun." ) return false end
					if getVehicleOccupant ( e,0 ) then outputChatBox("Es darf sich kein Fahrer im Fahrzeug befinden.", thePlayer, 255,0,0) return end
					setElementData(e, "water", 100 )
					callClientFunction(thePlayer, "setVehicleWaterFromServer", 100)
					outputChatBox("Kühlwasser nachgefüllt.", thePlayer, 0, 255, 0)
					break
			   end
			end				
		end
end	
addCommandHandler("wasser", refillWater)

function refillOil(thePlayer, command)
		if getElementData(thePlayer, "job") == 4 and getElementData(thePlayer, "dienst") == 1 then
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[1])) and (isElementWithinMarker ( e, adac_repair[1] )) and getElementData(hebebuehne1[1], "state") == "down" then
					if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Das Fahrzeug in in Flammen! Du kannst das nicht tun." ) return false end
					if getVehicleOccupant ( e,0 ) then outputChatBox("Es darf sich kein Fahrer im Fahrzeug befinden.", thePlayer, 255,0,0) return end
					setElementData(e, "oil", 100 )
					callClientFunction(thePlayer, "setVehicleOilFromServer", 100)
					outputChatBox("Öl nachgefüllt.", thePlayer, 0, 255, 0)
					break
			   end
			end
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[2])) and (isElementWithinMarker ( e, adac_repair[2] )) and getElementData(hebebuehne1[2], "state") == "down" then
					if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Das Fahrzeug in in Flammen! Du kannst das nicht tun." ) return false end
					if getVehicleOccupant ( e,0 ) then outputChatBox("Es darf sich kein Fahrer im Fahrzeug befinden.", thePlayer, 255,0,0) return end
					setElementData(e, "oil", 100 )
					callClientFunction(thePlayer, "setVehicleOilFromServer", 100)
					outputChatBox("Öl nachgefüllt.", thePlayer, 0, 255, 0)
					break
			   end
			end
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[3])) and (isElementWithinMarker ( e, adac_repair[3] )) and getElementData(hebebuehne1[3], "state") == "down" then
					if getVehicleOccupant ( e,0 ) then outputChatBox("Es darf sich kein Fahrer im Fahrzeug befinden.", thePlayer, 255,0,0) return end
					if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Das Fahrzeug in in Flammen! Du kannst das nicht tun." ) return false end
					setElementData(e, "oil", 100 )
					callClientFunction(thePlayer, "setVehicleOilFromServer", 100)
					outputChatBox("Öl nachgefüllt.", thePlayer, 0, 255, 0)
					break
			   end
			end
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[4])) and (isElementWithinMarker ( e, adac_repair[4] )) and getElementData(hebebuehne1[4], "state") == "down" then
					if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Das Fahrzeug in in Flammen! Du kannst das nicht tun." ) return false end
					if getVehicleOccupant ( e,0 ) then outputChatBox("Es darf sich kein Fahrer im Fahrzeug befinden.", thePlayer, 255,0,0) return end
					setElementData(e, "oil", 100 )
					callClientFunction(thePlayer, "setVehicleOilFromServer", 100)
					outputChatBox("Öl nachgefüllt.", thePlayer, 0, 255, 0)
					break
			   end
			end
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[5])) and (isElementWithinMarker ( e, adac_repair[5] )) and getElementData(hebebuehne1[5], "state") == "down" then
					if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Das Fahrzeug in in Flammen! Du kannst das nicht tun." ) return false end
					if getVehicleOccupant ( e,0 ) then outputChatBox("Es darf sich kein Fahrer im Fahrzeug befinden.", thePlayer, 255,0,0) return end
					setElementData(e, "oil", 100 )
					callClientFunction(thePlayer, "setVehicleOilFromServer", 100)
					outputChatBox("Öl nachgefüllt.", thePlayer, 0, 255, 0)
					break
			   end
			end		
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[6])) and (isElementWithinMarker ( e, adac_repair[6] )) and getElementData(hebebuehne1[6], "state") == "down" then
					if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Das Fahrzeug in in Flammen! Du kannst das nicht tun." ) return false end
					if getVehicleOccupant ( e,0 ) then outputChatBox("Es darf sich kein Fahrer im Fahrzeug befinden.", thePlayer, 255,0,0) return end
					setElementData(e, "oil", 100 )
					callClientFunction(thePlayer, "setVehicleOilFromServer", 100)
					outputChatBox("Öl nachgefüllt.", thePlayer, 0, 255, 0)
					break
			   end
			end		
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[7])) and (isElementWithinMarker ( e, adac_repair[7] )) and getElementData(hebebuehne1[7], "state") == "down" then
					if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Das Fahrzeug in in Flammen! Du kannst das nicht tun." ) return false end
					if getVehicleOccupant ( e,0 ) then outputChatBox("Es darf sich kein Fahrer im Fahrzeug befinden.", thePlayer, 255,0,0) return end
					setElementData(e, "oil", 100 )
					callClientFunction(thePlayer, "setVehicleOilFromServer", 100)
					outputChatBox("Öl nachgefüllt.", thePlayer, 0, 255, 0)
					break
			   end
			end	
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[8])) and (isElementWithinMarker ( e, adac_repair[8] )) and getElementData(hebebuehne1[8], "state") == "down" then
					if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Das Fahrzeug in in Flammen! Du kannst das nicht tun." ) return false end
					if getVehicleOccupant ( e,0 ) then outputChatBox("Es darf sich kein Fahrer im Fahrzeug befinden.", thePlayer, 255,0,0) return end
					setElementData(e, "oil", 100 )
					callClientFunction(thePlayer, "setVehicleOilFromServer", 100)
					outputChatBox("Öl nachgefüllt.", thePlayer, 0, 255, 0)
					break
			   end
			end				
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[9])) and (isElementWithinMarker ( e, adac_repair[9] )) and getElementData(hebebuehne1[9], "state") == "down" then
					if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Das Fahrzeug in in Flammen! Du kannst das nicht tun." ) return false end
					if getVehicleOccupant ( e,0 ) then outputChatBox("Es darf sich kein Fahrer im Fahrzeug befinden.", thePlayer, 255,0,0) return end
					setElementData(e, "oil", 100 )
					callClientFunction(thePlayer, "setVehicleOilFromServer", 100)
					outputChatBox("Öl nachgefüllt.", thePlayer, 0, 255, 0)
					break
			   end
			end		
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[10])) and (isElementWithinMarker ( e, adac_repair[10] )) and getElementData(hebebuehne1[10], "state") == "down" then
					if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Das Fahrzeug in in Flammen! Du kannst das nicht tun." ) return false end
					if getVehicleOccupant ( e,0 ) then outputChatBox("Es darf sich kein Fahrer im Fahrzeug befinden.", thePlayer, 255,0,0) return end
					setElementData(e, "oil", 100 )
					callClientFunction(thePlayer, "setVehicleOilFromServer", 100)
					outputChatBox("Öl nachgefüllt.", thePlayer, 0, 255, 0)
					break
			   end
			end				
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[11])) and (isElementWithinMarker ( e, adac_repair[11] )) and getElementData(hebebuehne1[11], "state") == "down" then
					if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Das Fahrzeug in in Flammen! Du kannst das nicht tun." ) return false end
					if getVehicleOccupant ( e,0 ) then outputChatBox("Es darf sich kein Fahrer im Fahrzeug befinden.", thePlayer, 255,0,0) return end
					setElementData(e, "oil", 100 )
					callClientFunction(thePlayer, "setVehicleOilFromServer", 100)
					outputChatBox("Öl nachgefüllt.", thePlayer, 0, 255, 0)
					break
			   end
			end		
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[12])) and (isElementWithinMarker ( e, adac_repair[12] )) and getElementData(hebebuehne1[12], "state") == "down" then
					if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Das Fahrzeug in in Flammen! Du kannst das nicht tun." ) return false end
					if getVehicleOccupant ( e,0 ) then outputChatBox("Es darf sich kein Fahrer im Fahrzeug befinden.", thePlayer, 255,0,0) return end
					setElementData(e, "oil", 100 )
					callClientFunction(thePlayer, "setVehicleOilFromServer", 100)
					outputChatBox("Öl nachgefüllt.", thePlayer, 0, 255, 0)
					break
			   end
			end		
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[13])) and (isElementWithinMarker ( e, adac_repair[13] )) and getElementData(hebebuehne1[13], "state") == "down" then
					if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Das Fahrzeug in in Flammen! Du kannst das nicht tun." ) return false end
					if getVehicleOccupant ( e,0 ) then outputChatBox("Es darf sich kein Fahrer im Fahrzeug befinden.", thePlayer, 255,0,0) return end
					setElementData(e, "oil", 100 )
					callClientFunction(thePlayer, "setVehicleOilFromServer", 100)
					outputChatBox("Öl nachgefüllt.", thePlayer, 0, 255, 0)
					break
			   end
			end					
		end
end	
addCommandHandler("oel", refillOil)
addCommandHandler("öl", refillOil)

function refillBattery(thePlayer, command)
		if getElementData(thePlayer, "job") == 4 and getElementData(thePlayer, "dienst") == 1 then
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[1])) and (isElementWithinMarker ( e, adac_repair[1] )) and getElementData(hebebuehne1[1], "state") == "down" then
					if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Das Fahrzeug in in Flammen! Du kannst das nicht tun." ) return false end
					if getVehicleOccupant ( e,0 ) then outputChatBox("Es darf sich kein Fahrer im Fahrzeug befinden.", thePlayer, 255,0,0) return end
					setElementData(e, "battery", 100 )
					callClientFunction(thePlayer, "setVehicleBatteryFromServer", 100)
					outputChatBox("Autobatterie aufgeladen.", thePlayer, 0, 255, 0)
					break
			   end
			end
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[2])) and (isElementWithinMarker ( e, adac_repair[2] )) and getElementData(hebebuehne1[2], "state") == "down" then
					if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Das Fahrzeug in in Flammen! Du kannst das nicht tun." ) return false end
					if getVehicleOccupant ( e,0 ) then outputChatBox("Es darf sich kein Fahrer im Fahrzeug befinden.", thePlayer, 255,0,0) return end
					setElementData(e, "battery", 100 )
					callClientFunction(thePlayer, "setVehicleBatteryFromServer", 100)
					outputChatBox("Autobatterie aufgeladen.", thePlayer, 0, 255, 0)
					break
			   end
			end
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[3])) and (isElementWithinMarker ( e, adac_repair[3] )) and getElementData(hebebuehne1[3], "state") == "down" then
					if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Das Fahrzeug in in Flammen! Du kannst das nicht tun." ) return false end
					if getVehicleOccupant ( e,0 ) then outputChatBox("Es darf sich kein Fahrer im Fahrzeug befinden.", thePlayer, 255,0,0) return end
					setElementData(e, "battery", 100 )
					callClientFunction(thePlayer, "setVehicleBatteryFromServer", 100)
					outputChatBox("Autobatterie aufgeladen.", thePlayer, 0, 255, 0)
					break
			   end
			end
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[4])) and (isElementWithinMarker ( e, adac_repair[4] )) and getElementData(hebebuehne1[4], "state") == "down" then
					if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Das Fahrzeug in in Flammen! Du kannst das nicht tun." ) return false end
					if getVehicleOccupant ( e,0 ) then outputChatBox("Es darf sich kein Fahrer im Fahrzeug befinden.", thePlayer, 255,0,0) return end
					setElementData(e, "battery", 100 )
					callClientFunction(thePlayer, "setVehicleBatteryFromServer", 100)
					outputChatBox("Autobatterie aufgeladen.", thePlayer, 0, 255, 0)
					break
			   end
			end
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[5])) and (isElementWithinMarker ( e, adac_repair[5] )) and getElementData(hebebuehne1[5], "state") == "down" then
					if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Das Fahrzeug in in Flammen! Du kannst das nicht tun." ) return false end
					if getVehicleOccupant ( e,0 ) then outputChatBox("Es darf sich kein Fahrer im Fahrzeug befinden.", thePlayer, 255,0,0) return end
					setElementData(e, "battery", 100 )
					callClientFunction(thePlayer, "setVehicleBatteryFromServer", 100)
					outputChatBox("Autobatterie aufgeladen.", thePlayer, 0, 255, 0)
					break
			   end
			end			
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[6])) and (isElementWithinMarker ( e, adac_repair[6] )) and getElementData(hebebuehne1[6], "state") == "down" then
					if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Das Fahrzeug in in Flammen! Du kannst das nicht tun." ) return false end
					if getVehicleOccupant ( e,0 ) then outputChatBox("Es darf sich kein Fahrer im Fahrzeug befinden.", thePlayer, 255,0,0) return end
					setElementData(e, "battery", 100 )
					callClientFunction(thePlayer, "setVehicleBatteryFromServer", 100)
					outputChatBox("Autobatterie aufgeladen.", thePlayer, 0, 255, 0)
					break
			   end
			end			
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[7])) and (isElementWithinMarker ( e, adac_repair[7] )) and getElementData(hebebuehne1[7], "state") == "down" then
					if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Das Fahrzeug in in Flammen! Du kannst das nicht tun." ) return false end
					if getVehicleOccupant ( e,0 ) then outputChatBox("Es darf sich kein Fahrer im Fahrzeug befinden.", thePlayer, 255,0,0) return end
					setElementData(e, "battery", 100 )
					callClientFunction(thePlayer, "setVehicleBatteryFromServer", 100)
					outputChatBox("Autobatterie aufgeladen.", thePlayer, 0, 255, 0)
					break
			   end
			end		
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[8])) and (isElementWithinMarker ( e, adac_repair[8] )) and getElementData(hebebuehne1[8], "state") == "down" then
					if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Das Fahrzeug in in Flammen! Du kannst das nicht tun." ) return false end
					if getVehicleOccupant ( e,0 ) then outputChatBox("Es darf sich kein Fahrer im Fahrzeug befinden.", thePlayer, 255,0,0) return end
					setElementData(e, "battery", 100 )
					callClientFunction(thePlayer, "setVehicleBatteryFromServer", 100)
					outputChatBox("Autobatterie aufgeladen.", thePlayer, 0, 255, 0)
					break
			   end
			end					
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[9])) and (isElementWithinMarker ( e, adac_repair[9] )) and getElementData(hebebuehne1[9], "state") == "down" then
					if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Das Fahrzeug in in Flammen! Du kannst das nicht tun." ) return false end
					if getVehicleOccupant ( e,0 ) then outputChatBox("Es darf sich kein Fahrer im Fahrzeug befinden.", thePlayer, 255,0,0) return end
					setElementData(e, "battery", 100 )
					callClientFunction(thePlayer, "setVehicleBatteryFromServer", 100)
					outputChatBox("Autobatterie aufgeladen.", thePlayer, 0, 255, 0)
					break
			   end
			end
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[10])) and (isElementWithinMarker ( e, adac_repair[10] )) and getElementData(hebebuehne1[10], "state") == "down" then
					if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Das Fahrzeug in in Flammen! Du kannst das nicht tun." ) return false end
					if getVehicleOccupant ( e,0 ) then outputChatBox("Es darf sich kein Fahrer im Fahrzeug befinden.", thePlayer, 255,0,0) return end
					setElementData(e, "battery", 100 )
					callClientFunction(thePlayer, "setVehicleBatteryFromServer", 100)
					outputChatBox("Autobatterie aufgeladen.", thePlayer, 0, 255, 0)
					break
			   end
			end				
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[11])) and (isElementWithinMarker ( e, adac_repair[11] )) and getElementData(hebebuehne1[11], "state") == "down" then
					if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Das Fahrzeug in in Flammen! Du kannst das nicht tun." ) return false end
					if getVehicleOccupant ( e,0 ) then outputChatBox("Es darf sich kein Fahrer im Fahrzeug befinden.", thePlayer, 255,0,0) return end
					setElementData(e, "battery", 100 )
					callClientFunction(thePlayer, "setVehicleBatteryFromServer", 100)
					outputChatBox("Autobatterie aufgeladen.", thePlayer, 0, 255, 0)
					break
			   end
			end	
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[12])) and (isElementWithinMarker ( e, adac_repair[12] )) and getElementData(hebebuehne1[12], "state") == "down" then
					if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Das Fahrzeug in in Flammen! Du kannst das nicht tun." ) return false end
					if getVehicleOccupant ( e,0 ) then outputChatBox("Es darf sich kein Fahrer im Fahrzeug befinden.", thePlayer, 255,0,0) return end
					setElementData(e, "battery", 100 )
					callClientFunction(thePlayer, "setVehicleBatteryFromServer", 100)
					outputChatBox("Autobatterie aufgeladen.", thePlayer, 0, 255, 0)
					break
			   end
			end	
			for i,e in ipairs(getElementsByType("vehicle")) do 
				if ( isElementWithinMarker(thePlayer,adac_repair[13])) and (isElementWithinMarker ( e, adac_repair[13] )) and getElementData(hebebuehne1[13], "state") == "down" then
					if getElementData(e, "onFire") == true then triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 255,0,0, "Das Fahrzeug in in Flammen! Du kannst das nicht tun." ) return false end
					if getVehicleOccupant ( e,0 ) then outputChatBox("Es darf sich kein Fahrer im Fahrzeug befinden.", thePlayer, 255,0,0) return end
					setElementData(e, "battery", 100 )
					callClientFunction(thePlayer, "setVehicleBatteryFromServer", 100)
					outputChatBox("Autobatterie aufgeladen.", thePlayer, 0, 255, 0)
					break
			   end
			end				
		end
end	
addCommandHandler("batterie", refillBattery)

function ADACrepanim(g_reperaturanim)

	if g_reperaturanim == 0 then
		setPedRotation(source, 358.26138305664 )
		setPedAnimation ( source ,"ped", "IDLE_taxi", 1, false, true, false )
		local players = getElementsByType("player")
		for _,v in pairs(players) do
			local x
			local y
			x, y = getElementPosition(v)
			x1, y1 = getElementPosition(source)
			if( getDistanceBetweenPoints2D(x1, y1, x, y) < 25) then
				playSoundFrontEnd (v, 46 )
			end	
		end
	elseif g_reperaturanim == 1 then
		--setPedAnimation ( source ,"ped", "handscower", 1, false, true, false )
	elseif g_reperaturanim == 2 then
		--setPedAnimation ( source ,"ped", "handscower", 1, false, true, false )
	elseif g_reperaturanim == 3 then
		--setPedAnimation ( source ,"ped", "GunMove_FWD", 1, false, true, false )
	end
end

addEvent("ADACrepanim", true)
addEventHandler("ADACrepanim", getRootElement(), ADACrepanim)

function ADACrepfertig()
    setElementData(reperaturvehicle[source], "panne", false)
	fixVehicle ( reperaturvehicle[source] )
	setElementFrozen(reperaturvehicle[source], false)
	-- remove damage proof, setted when breaking down
	setVehicleDamageProof(reperaturvehicle[source], false);
	outputChatBox("Auto erfolgreich repariert!", source, 0, 255, 0)
	toggleAllControls ( source, true )
	setPedAnimation(source)
	for i = 1,6 do
		if ( isElementWithinMarker(source,adac_repair[i])) then
			setElementData(hebebuehne1[i], "state", "open" )
		end
	end
end

addEvent("ADACrepfertig", true)
addEventHandler("ADACrepfertig", getRootElement(), ADACrepfertig)


function inModZone(element)
	if getElementType(element) == "vehicle" then
		local player = getVehicleOccupant ( element )
		if player and isElement(player) and getElementData(player, "job") == 4 then
			triggerClientEvent ( player, "startModshop", getRootElement())
		end	
	end
end
addEventHandler("onMarkerHit", adac_modshop, inModZone)
addEventHandler("onMarkerHit", adac_modshop2, inModZone)
addEventHandler("onMarkerHit", adac_modshop3, inModZone)
	
function showMarkedVehicles(source, commandName)
    if getElementData(source, "job") == 4 and getElementData(source, "dienst") == 1 then
		outputChatBox("Die abzuschleppenden Fahrzeuge werden für 3 Minuten angezeigt.",source,0,255,0)	
		outputChatBox("Rot = Motorräder und Fahrräder; Grün = Autos",source,0,255,0)	
		for _, vehicle in ipairs(getElementsByType("vehicle")) do
			if getElementData ( vehicle, "marked" ) == true then
				local blip 
				if getVehicleType(vehicle) == "Bike" or getVehicleType(vehicle) == "BMX" then
					blip = createBlipAttachedTo ( vehicle, 0, 2, 255, 0, 0, 255, 0, 65530.0, source )
				else
					blip = createBlipAttachedTo ( vehicle, 0, 2, 0, 255, 0, 255, 0, 65530.0, source )
				end
				setTimer(
					function()
						destroyElement(blip)
					end
				,180000,1, blip)	
			end
		end	
	end	
end	
addCommandHandler("markierte", showMarkedVehicles, false, false )
	
function magnet_func ( player )
	if isElement ( player ) == true then
		local veh = getPedOccupiedVehicle ( player )
		if veh then
			if getElementData(veh, "magnetic") == false then
				if getElementModel(veh) == 417 then
					setVehicleAsMagnetHelicopter ( veh )
					magnetmoveing[veh] = 1
				end
			end
		end
	end
end
addCommandHandler ( "magnet", magnet_func )
	
	
-- Attaches a magnet to it if its a Leviathan
function setVehicleAsMagnetHelicopter ( veh )
	if getElementModel ( veh ) == 417 then
		local x, y, z = getElementPosition ( veh )
		local magnet = createObject ( 1301, x, y, z-1.5)
		attachElements ( magnet, veh, 0, 0, -1.5 )
		setElementData ( veh, "magpos", -1.5 )
		setElementData ( veh, "magnet", magnet )
		setElementData ( veh, "magnetic", true )
		setElementData ( veh, "hasmagnetactivated", false )
	end
end

-- When the helicopter is destroyed, kill the magnet
function destroyMagnet()
	if source then
		if not isElement(source) then return end
		if getElementData ( source, "magnetic" ) == true then
			local magnetelem = getElementData ( source, "magnet" )
			if magnetelem then
				destroyElement ( magnetelem )
			end
		end
	end
end
addEventHandler ( "onVehicleExplode", getRootElement(), destroyMagnet )

-- Moves the magnet up/down
function magnetUp ( player )
	if isElement ( player ) then
		local veh = getPedOccupiedVehicle ( player )
		if veh then
			if getElementModel ( veh ) == 417 and getElementData(veh, "magpos") ~= nil then
			local magpos = getElementData ( veh, "magpos" )
				if magpos < -1.5 then
					local magnet = getElementData ( veh, "magnet" )
					detachElements ( magnet )
					local magpos = magpos+0.1
					attachElements ( magnet, veh, 0, 0, magpos, 0, 0, 0 )
					setElementData ( veh, "magpos", magpos )
				end
			end
		end
	end
end

function magnetDown ( player )
	if isElement ( player ) == true then
	local veh = getPedOccupiedVehicle ( player )
	if veh then
		if getElementModel ( veh ) == 417 and getElementData(veh, "magpos") ~= nil then
			local magpos = getElementData ( veh, "magpos" )
			if magpos > -75 then
				local magnet = getElementData ( veh, "magnet" )
				detachElements ( magnet )
				local magpos = magpos-0.1
				attachElements ( magnet, veh, 0, 0, magpos, 0, 0, 0 )
				setElementData ( veh, "magpos", magpos )
			end
		end
	end
	end
end

-- (un)Bind the keys
function stopmagnetmoveing(da)
	if isElement ( da ) == true then
	local veh = getPedOccupiedVehicle ( da )
		if veh then
			if isTimer (magnetmoveing[veh]) then
				killTimer(magnetmoveing[veh])
			end
		end
	end
end
addCommandHandler("magnet_stop", stopmagnetmoveing)

function magdown(da)
	if isElement ( da ) == true then
		local veh = getPedOccupiedVehicle ( da )
		if veh then
			if magnetmoveing[veh] and isTimer(magnetmoveing[veh]) then killTimer(magnetmoveing[veh]) end
			magnetmoveing[veh] = setTimer(magnetDown,50,0,da)
		end
	end
end
addCommandHandler("magnet_down", magdown)

function magup(da)
	if isElement ( da ) == true then
		local veh = getPedOccupiedVehicle ( da )
		if veh then
			if magnetmoveing[veh] and isTimer(magnetmoveing[veh]) then killTimer(magnetmoveing[veh]) end
			magnetmoveing[veh] = setTimer(magnetUp,50,0,da)
		end
	end
end
addCommandHandler("magnet_up", magup)

function bindTrigger ()
	if getElementType(source) ~= "player" then return end
	if not isKeyBound ( source, "lctrl", "down", magnetVehicleCheck ) then
		bindKey ( source, "lctrl", "down", magnetVehicleCheck )
		bindKey ( source, "rctrl", "down", magnetVehicleCheck )
		bindKey ( source, "num_sub", "down", magup )
		bindKey ( source, "num_add", "down", magdown )
		bindKey ( source, "num_sub", "up", stopmagnetmoveing )
		bindKey ( source, "num_add", "up", stopmagnetmoveing )
	end
end

function unbindTrigger ()
	if getElementType(source) ~= "player" then return end
	if isKeyBound ( source, "lctrl", "down", magnetVehicleCheck ) then
		unbindKey ( source, "lctrl", "down", magnetVehicleCheck )
		unbindKey ( source, "rctrl", "down", magnetVehicleCheck )
		unbindKey ( source, "num_sub", "down", magup )
		unbindKey ( source, "num_add", "down", magdown )
		unbindKey ( source, "num_sub", "up", stopmagnetmoveing )
		unbindKey ( source, "num_add", "up", stopmagnetmoveing )
	end
end
addEventHandler ( "onPlayerVehicleEnter", getRootElement(), bindTrigger )
addEventHandler ( "onPlayerVehicleExit", getRootElement(), unbindTrigger )
addEventHandler ( "onPlayerWasted", getRootElement(), unbindTrigger )

-- When Ctrl is pressed, attach / detatch the helicopter
function magnetVehicleCheck ( player )
	if isElement ( player ) == true then
	local veh = getPedOccupiedVehicle ( player )
	if veh then
		if getElementData ( veh, "magnetic" ) then
			if getElementData ( veh, "hasmagnetactivated" ) then
				setElementData ( veh, "hasmagnetactivated", false )
				detachElements ( getElementData ( veh, "magneticVeh" ) )
				attachedVeh = getElementData ( veh, "magneticVeh" )
				if getElementData(attachedVeh, "isProtected") == true then
					setTimer(setElementFrozen, 5000, 1, attachedVeh, true)
					setElementFrozen(attachedVeh, false)
				end
			else
				local magnet = getElementData ( veh, "magnet" )
				local x, y, z = getElementPosition ( magnet )
				local magpos = getElementData ( veh, "magpos" )
				local marker = createColSphere ( x , y , z, 5 )
				local vehs = getElementsWithinColShape ( marker, "vehicle" )
				destroyElement ( marker )
				grabveh = false
				for key, vehitem in ipairs(vehs) do
					if vehitem ~= veh then
						if getElementData(vehitem, "onFire") == true then return end
						local grabveh = vehitem
						attachElements ( grabveh, magnet, 0, 0, -1, 0, 0, getVehicleRotation(grabveh) )
						setElementData ( veh, "hasmagnetactivated", true )
						setElementData ( veh, "magneticVeh", grabveh )
						pLogger["abschlepper"]:addEntry(getPlayerName(player).." hat einen "..getVehicleNameFromModel(getElementModel(grabveh)).." (ID:"..tostring(getElementData(grabveh, "model"))..") von "..tostring(getElementData(grabveh, "owner")).." mit einem Magnetheli abgeschleppt.")
						break
					end
				end
			end
		end
	end
	end
end
addCommandHandler("magnet_tow", magnetVehicleCheck)

--Heli-repair pad
local marker1 = createMarker ( 1732.4000244141, 684.90002441406, 12.89999961853, "cylinder", 20, 0, 0, 0, 0 )
function Leviathanrep ( player, commandname )
	if getPedOccupiedVehicle ( player ) and isElementWithinMarker ( player, marker1 ) and ( getVehicleType ( getPedOccupiedVehicle ( player ) ) == "Helicopter" or getVehicleType ( getPedOccupiedVehicle ( player ) ) == "Plane" ) and getElementData(player, "job") == 4 and getElementData(player, "dienst") == 1 then
		fixVehicle ( getPedOccupiedVehicle ( player ) )
		setElementData( getPedOccupiedVehicle ( player ), "panne", false)
		setVehicleDamageProof( getPedOccupiedVehicle(player), false)
		outputChatBox("Fahrzeug repariert.",player,0,255,0)	
	end
end
addCommandHandler ( "reparieren", Leviathanrep )

--Boot Reparatur
local marker2 = createMarker ( 1614, 585.79998779297, -0.10000000149012, "cylinder", 10, 0, 0, 0, 0 )
function bootrep ( player, commandname )
	if getPedOccupiedVehicle ( player ) and isElementWithinMarker ( player, marker2 ) and getVehicleType ( getPedOccupiedVehicle ( player ) ) == "Boat" and getElementData(player, "job") == 4 and getElementData(player, "dienst") == 1 then
		fixVehicle ( getPedOccupiedVehicle ( player ) )
		setElementData( getPedOccupiedVehicle ( player ), "panne", false)
		setVehicleDamageProof( getPedOccupiedVehicle(player), false)
		outputChatBox("Fahrzeug repariert.",player,0,255,0)	
	end
end
addCommandHandler ( "reparieren", bootrep )

function motorrep ( player, commandname )
	if getPedOccupiedVehicle ( player ) and getElementData ( getPedOccupiedVehicle ( player ), "panne" ) == true and getElementData(player, "job") == 4 and getElementData(player, "dienst") == 1 then
		setElementHealth(getPedOccupiedVehicle(player), 1000)
		setElementData( getPedOccupiedVehicle ( player ), "panne", false)
		setVehicleDamageProof( getPedOccupiedVehicle(player), false)
		outputChatBox("Fahrzeugmotor wurde repariert.",player,0,255,0)	
	end
end
addCommandHandler ( "motorrep", motorrep )


local torTimer
addEventHandler("onResourceStart",getResourceRootElement(),function()
	for i,row in pairs(PaintnSprayIDTab) do
		setGarageOpen(row.ID,true)
		local marker=createMarker(row.x,row.y,row.z,"cylinder")
		createBlip(row.x,row.y,row.z,63,2,0,0,0,255,0,500)
		addEventHandler("onMarkerHit",marker,function(player)
			if getElementType(player)=="player" and not getElementData(marker, "used")  then
				if isPedInVehicle(player) then
					if getPlayerOccupiedVehicleSeat(player)==0 and getElementHealth(getPedOccupiedVehicle(player)) < 900 then
						if getPlayerMoneyEx(player) < 1000 then return triggerClientEvent ( player, "addNotification", getRootElement(), 1, 255, 0, 0, "Du benötigst mindestens 1000 Vero für die Fahrzeugreparatur.")	 end
						setGarageOpen(row.ID,false)
						local veh = getPedOccupiedVehicle(player)
						setElementData(marker, "used", true)
						setVehicleDamageProof(veh, true)
						triggerClientEvent ( player, "showTutorialMessage", getRootElement(), "paynspray_1", "Der Pay'N'Spray erlaubt dir den Fahrzeugmotor zu reparieren. Für Blechschäden musst du dich an den AutoFix wenden." )
						--setElementFrozen(veh, true)
						triggerClientEvent ( player, "addNotification", getRootElement(), 1, 0,255,0, "Fahrzeug wird für 1000 Vero repariert." )
						torTimer = setTimer( function(id, marker, veh)
							setGarageOpen(id, true)
							setElementData(marker, "used", false)
							setElementData(veh, "panne", false)
							setVehicleDamageProof(veh, false)
							--setElementFrozen(veh, false)
							setElementHealth(veh, 1000)
							setElementData(veh, "panne", false)
						end,5000,1,row.ID, marker, veh)
					end
				end
			end
		end)
	end
end)



local tuev_marker_1 = createMarker ( 1113.0999755859, 1717.8000488281, 9.8000001907349, "cylinder", 6, 0, 255, 0, 0 )
local tuev_marker_2 = createMarker (1114.9000244141, 1711.6999511719, 9.8999996185303, "cylinder", 6, 0, 255, 0, 0 )
local tuev_marker_3 = createMarker ( 1113.5, 1706.6999511719, 9.8000001907349, "cylinder", 6, 0, 255, 0, 0 )
function checkTuev(ply, command)
	if getElementData(ply, "job") == 1 and getElementData(ply, "dienst") == 4 then --Autohaus
		local veh = getPedOccupiedVehicle(ply)
		if veh then
			local price = 0
			if gVehicleData[getElementModel(veh)] and gVehicleData[getElementModel(veh)].price then
				price = gVehicleData[getElementModel(veh)].price*0.05
			end
			outputChatBox("Der derzeitige Preis der neuen TÜV Plakette beträgt "..math.floor(getElementData(veh, "tuevpreis")+price).." Vero.",ply,88,54,150)	
		else
			outputChatBox("Zum Überprüfen des TÜV Preises musst du dich im Fahrzeug befinden.",ply,255,0,0)	
		end
	end
end
addCommandHandler("checktuev", checkTuev, false, false)

function tuev ( player, commandname )
	if getPedOccupiedVehicle(player) then return end
	for i,e in ipairs(getElementsByType("vehicle")) do 
		for i2,v in ipairs(adac_repair) do
			if ( isElementWithinMarker(player,v)) and (isElementWithinMarker ( e, v )) then
				local price = 0
				if gVehicleData[getElementModel(e)] and gVehicleData[getElementModel(e)].price then
					price = gVehicleData[getElementModel(e)].price*0.05
				end			
				local tp = getElementData(e, "tuevpreis")
				setElementData( e, "tuev", getRealTime().yearday)
				systemWithdraw("Autofix", math.floor(tp+price))
				outputChatBox("Das Fahrzeug hat eine neue TÜV Plakette bekommen. "..math.floor(tp+price).." Vero wurden vom Autofix Konto abgezogen.",player,88,54,150)				
				break
			end	
		end
	end
end
addCommandHandler ( "tuev", tuev )	
	
	
function tuev(player, commandname)
	if getPedOccupiedVehicle ( player ) and ( getVehicleType ( getPedOccupiedVehicle ( player ) ) == "Boat" or getVehicleType ( getPedOccupiedVehicle ( player ) ) == "Helicopter" or getVehicleType ( getPedOccupiedVehicle ( player ) ) == "Plane" ) and getElementData(player, "job") == 4 and getElementData(player, "dienst") == 1 then
		local tp = getElementData(getPedOccupiedVehicle ( player ), "tuevpreis")
		setElementData( getPedOccupiedVehicle ( player ), "tuev", getRealTime().yearday)
		systemWithdraw("Autofix", tp)
		outputChatBox("Das Fahrzeug hat eine neue TÜV Plakette bekommen. "..tp.." Vero wurden vom AutoFix Konto abgezogen.",player,88,54,150)	
	end
end
addCommandHandler ( "tuev", tuev )

