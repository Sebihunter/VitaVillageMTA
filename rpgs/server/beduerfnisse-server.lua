--[[
Project: VitaOnline
File: beduerfnisse-server.lua
Author(s):	Sebihunter
]]--

bed_Reaktion1 = {}
bed_Reaktion2 = {}
bed_Reaktion3 = {}
bed_Reaktion4 = {}
bed_fastfoodWaschmuschel = {}
bed_fastfoodToilette = {}
local toilettenSoundObjekt = {}


toiletPositions = {
	[1] = {   x=2193.9683, y=-1223.1493,  z=1049.0234,  i=6, r=270.0 }, --int 1
	[2] = {   x=2254.3809, y=-1217.5574,  z=1049.0234, i=10, r=180.0 }, --int 2
	[3] = {   x=234.6221,  y=1208.6162,  z=1080.2578,  i=3,   r=0.0 }, --int 3
	[4] = {   x=217.7598,  y=1288.2041,  z=1082.1406,  i=1,  r=90.0 }, --int 4
	[5] = {   x=254.2090,  y=1034.3848,  z=1084.7377,  i=7, r=270.0 }, --int 5: toilet (1st floor)
	[6] = {   x=238.3564,  y=1040.6328,  z=1088.3051,  i=7,  r=90.0 }, --int 5: toilet (2nd floor)
	[7] = {   x=285.0186,  y=1482.3047,  z=1080.2578, i=15,  r=90.0 }, --int 6
	[8] = {   x=332.3467,  y=1484.7969,  z=1084.4387, i=15,   r=0.0 }, --int 7
	[9] = {   x=444.8652,  y=1413.0703,  z=1084.3047,  i=2,  r=90.0 }, --int 8
	[10] = {   x=235.3945,  y=1119.2715,  z=1084.9922,  i=5,  r=90.0 }, --int 9: toilet (2nd floor)
	[11] = {   x=233.3496,  y=1110.6318,  z=1080.9922,  i=5,  r=90.0 }, --int 9: toilet (1st floor)
	[12] = {   x=250.2070,  y=1293.5811,  z=1080.2578,  i=4,  r=90.0 }, --int 10
	[13] = {   x=219.9023,  y=1074.5156,  z=1084.1953,  i=6,  r=90.0 }, --int 11: toilet (1st floor)
	[14] = {   x=225.4092,  y=1087.3047,  z=1087.8281,  i=6,  r=90.0 }, --int 11: toilet (2nd floor)
	[15] = {   x=-62.7422,  y=1356.0215,  z=1080.2109,  i=6,  r=0.0 }, --int 12
	[16] = {   x=252.6182,  y=1248.7305,  z=1084.2578,  i=9,  r=0.0 },  --int 13
	[17] = {   x=1713.598,  y=781.360,  z=10.999,  i=0,  r=-90 },  --AutoFix LV
	[18] = {   x=1591.277, y=2360.319, z=10.9841, i=0, r=0}, -- InterTrans
	[19] = {   x=2650.59, y=1203.78, z=10.82, i=0, r=90},--Feuerwehr
	[20] = {   x=-1476.768, y=2642.177, z=58.78, i=0, r=0},--Da Nangs
	[21] = {   x=2397, y=1361, z=-0.1, i=0, r=180}--Adminbase
}

bathPositions = {
	[1] ={  x=2191.9102, y=-1225.6934,  z=1049.7234,  i=6, r=180.0 }, --int 1
	[2] ={  x=2252.0605, y=-1215.4980,  z=1049.8052, i=10,  r=90.0 }, --int 2
	[3] ={   x=236.8740,  y=1209.2686,  z=1080.6082,  i=3, r=-180.0 }, --int 3: shower
	[4] ={   x=217.9531,  y=1289.9033,  z=1082.8776,  i=1, r=90.0 }, --int 4
	[5] ={   x=251.9307,  y=1031.5820,  z=1084.7438,  i=7,r=-360.0 }, --int 5: shower (1st floor)
	[6] ={   x=241.1455,  y=1042.6602,  z=1088.3785,  i=7,r=-180.0 }, --int 5: shower (2nd floor)
	[7] ={   x=287.2354,  y=1484.4609,  z=1080.2878, i=15,r=-180.0 }, --int 6: shower
	[8] ={   x=334.3027,  y=1484.7139,  z=1085.0021, i=15,r=180.0 }, --int 7
	[9] ={   x=444.2129,  y=1410.6836,  z=1084.3047,  i=2,r=-90.0 }, --int 8: shower
	[10] ={   x=235.6514,  y=1109.2832,  z=1081.3499,  i=5,r=-90.0 }, --int 9: shower (1st floor)
	[11] ={   x=237.4160,  y=1120.2949,  z=1085.0122,  i=5,r=-180.0 }, --int 9: shower (2nd floor)
	[12] ={   x=252.4531,  y=1294.4941,  z=1080.2678,  i=4,r=-180.0 }, --int 10: shower
	[13] ={   x=219.9443,  y=1076.4385,  z=1084.8979,  i=6,r=270.0 }, --int 11: bath (1st floor)
	[14] ={   x=227.8242,  y=1087.2217,  z=1088.5308,  i=6,r=270.0 }, --int 11: bath (2nd floor)
	[15] ={   x=-63.8232,  y=1353.6865,  z=1080.9058,  i=6,r=270.0 }, --int 12
	[16] ={   x=254.2822,  y=1249.1777,  z=1084.9604,  i=9,r=270.0 },  --int 13
	[17] ={   x=1712.665,  y=779.4635,  z=11.1939,  i=0,r=90.0 },  --AutoFix LV
	[18] ={   x=1591.000, y=2358.184, z=11.9841,  i=0,r=90}, -- InterTrans
	[19] ={   x=2650.19, y=1201.93, z=10.82,  i=0,r=360 },  --Feuerwehr
	[20] ={   x=-1481.8320, y=2642.956, z=58.7812,  i=0,r=0 },  --Da Nangs
	[21] ={   x=2396.87, y=1365.99, z=0.62,  i=0,r=90 }  --Adminbase
}

function useWaschmuschel(player)
	if getElementData(player, "getPlayerHygiene") < 75 then
		setElementData(player,"getPlayerHygiene", 75)
		outputChatBox("Du hast dir die Hände gewaschen.",player,0,255,0)
		setElementPosition(player, 368.0387,-61.7809,1001.5151)
		setPedRotation(player, 172.3115)
	else
		outputChatBox("Sauberer kannst du hier nicht werden!",player,255,0,0)
	end
end

function useToilette(player)
	setElementPosition(player, 366.9922, -57.4104, 1001.5103)
	setPedRotation(player, 0.0)
	setPedAnimation (player, "PAULNMAC", "Piss_loop", 5000, false, false, true )
	local x, y, z = getElementPosition(player)
	setCameraMatrix(player, x, y - 1, z+0.5, x, y, z+0.5)
	--toilettenSoundObjekt[player] = createObject(6965, x, y + 5.0, z, 0.0, 0.0, 0.0);
	--setElementInterior(toilettenSoundObjekt[player], getElementInterior(player))
	--setElementDimension(toilettenSoundObjekt[player], getElementDimension(player));
	setTimer(
			function(player)
			setPedAnimation (player, false)
			setCameraTarget ( player )
			local x, y, z = getElementPosition(player)
			setElementPosition(player, x, y, z)
			setElementData(player,"getPlayerHarndrang", 100)
			setElementData(player,"getPlayerHygiene", getElementData(player,"getPlayerHygiene")-20)
			outputChatBox("Geschäft erledigt.",player,0,255,0)
			--destroyElement(toilettenSoundObjekt[player])
			end
		,5000,1, player)	
end

function useHausToilette(player)
  if getElementData(player, "amBeduerfnisseAufladen") == false then
	for obj = 1, #toiletPositions do
		local px,py,pz = getElementPosition(player)
		local distance = getDistanceBetweenPoints2D ( px,py,toiletPositions[obj].x,toiletPositions[obj].y ) 
		if distance < 1 then
			setElementData(player,"amBeduerfnisseAufladen", true)
			setElementPosition(player, toiletPositions[obj].x, toiletPositions[obj].y, toiletPositions[obj].z)
			setPedRotation(player, toiletPositions[obj].r);
			setPedAnimation (player, "PAULNMAC", "Piss_loop", 5000, false, false, true )
			toilettenSoundObjekt[player] = createObject(6965, px, py + 5.0, pz, 0.0, 0.0, 0.0);
			setElementInterior(toilettenSoundObjekt[player], getElementInterior(player))
			getElementDimension(toilettenSoundObjekt[player], getElementDimension(player));
			setTimer(
				function(player,px,py,pz)
					setPedAnimation (player)
					setCameraTarget ( player )
					local x, y, z = getElementPosition(player)
					setElementPosition(player, px,py,pz)
					setElementData(player,"getPlayerHarndrang", 100)
					setElementData(player,"getPlayerHygiene", getElementData(player,"getPlayerHygiene")-20)
					outputChatBox("Geschäft erledigt.",player,0,255,0)
					destroyElement(toilettenSoundObjekt[player])
					setElementData(player,"amBeduerfnisseAufladen", false)
				end
			,5000,1, player,px,py,pz)
		end
	end
  end		
end

function useHausBad(player)
  if getElementData(player, "amBeduerfnisseAufladen") == false then
	for obj = 1, #bathPositions do
		local px,py,pz = getElementPosition(player)
		local distance = getDistanceBetweenPoints2D ( px,py,bathPositions[obj].x,bathPositions[obj].y ) 
		if distance < 1 then
			setElementData(player,"amBeduerfnisseAufladen", true)
			setElementPosition(player, bathPositions[obj].x, bathPositions[obj].y, bathPositions[obj].z)
			setPedRotation(player, bathPositions[obj].r);
			setPedAnimation (player, "BEACH", "bather", 5000, false, false, true )
			toilettenSoundObjekt[player] = createObject(6965, px, py, pz-9, 0.0, 0.0, 0.0);
			setElementInterior(toilettenSoundObjekt[player], getElementInterior(player))
			getElementDimension(toilettenSoundObjekt[player], getElementDimension(player));
			setTimer(
				function(player,px,py,pz)
					setPedAnimation (player)
					setCameraTarget ( player )
					setElementPosition(player, px, py, pz)
					setElementData(player,"getPlayerHygiene", 100)
					outputChatBox("Du hast dich gewaschen.",player,0,255,0)
					destroyElement(toilettenSoundObjekt[player])
					setElementData(player,"amBeduerfnisseAufladen", false)
				end
			,5000,1, player,px,py,pz)
		end
	end
  end	
end


function schlafen(player)
	setElementData(player, "amSchlafen", true)
	toggleAllControls ( player, false )
end
addCommandHandler ( "schlafen", schlafen )

function aufwachen(player)
	if getElementData(player, "amSchlafen") == true then
		setElementData(player, "amSchlafen", false)
		setPedAnimation (player, false)
		toggleAllControls ( player, true )
	end
end

function schlafen(player)
	if (getElementData(player,"getPlayerEnergie") + 1) > 100 then
		setElementData(player,"getPlayerEnergie", 100)
		aufwachen(player)		
	else
		setElementData(player,"getPlayerEnergie", getElementData(player,"getPlayerEnergie")+1)
		setPedAnimation (player, "BEACH", "bather", 1000, false, false, true )
		toggleAllControls ( player, false )
	end
end

for i = 0, 40 do
	bed_fastfoodWaschmuschel[i] = createPickup ( 368.0387,-61.7809,1001.5151, 3, 1318, 1000 )
	setElementInterior(bed_fastfoodWaschmuschel[i], 10)
	setElementDimension(bed_fastfoodWaschmuschel[i], i)
	addEventHandler ( "onPickupUse", bed_fastfoodWaschmuschel[i], useWaschmuschel )
	
	bed_fastfoodToilette[i] = createPickup ( 366.9922, -57.4104, 1001.5103, 3, 1318, 5000 )
	setElementInterior(bed_fastfoodToilette[i], 10)
	setElementDimension(bed_fastfoodToilette[i], i)
	addEventHandler ( "onPickupUse", bed_fastfoodToilette[i], useToilette )
end

function BeduerfnisTimer()
	if g_FreeMode == false then
		local players = getElementsByType("player")
		for _,v in pairs(players) do
		  setElementData(v, "todestimer", false)
		  if getElementData(v, "isPlayerLoggedIn") == true and getElementData(v, "afk") ~= true
			then
				--Timerdisplay
				if hospitalTimer[v] and isTimer(hospitalTimer[v]) then
					local ms, _, _ = getTimerDetails ( hospitalTimer[v] )
					setElementData(v, "todestimer", tostring(msToTimeStr(ms, true)))
				end
				
				--Bedürfnisse
				bed_Reaktion1[v] = "false"
				if getElementData(v, "amSchlafen") == true then
					schlafen(v)
					bed_Reaktion1[v] = "true"
				end
				
				if (getElementData(v,"getPlayerEnergie") - 0.001) < 0 then
					setElementData(v,"getPlayerEnergie", 0)
					if(bed_Reaktion1[v] == "false") then
						bed_Reaktion1[v] = "true"
						triggerEvent ( "BeduerfnisReaktion", v, "1" )
					end
				else
					setElementData(v,"getPlayerEnergie", getElementData(v,"getPlayerEnergie")-0.001)
				end
				
				if (getElementData(v,"getPlayerHunger")- 0.002) < 0 then
					setElementData(v,"getPlayerHunger", 0)
					if(bed_Reaktion2[v] == "false") then
						bed_Reaktion2[v] = "true"
						triggerEvent ( "BeduerfnisReaktion", v, "2" )					
					end				
				else
					setElementData(v,"getPlayerHunger", getElementData(v,"getPlayerHunger")-0.002)
				end
				
				if (getElementData(v,"getPlayerHarndrang") - 0.008) < 0 then
					setElementData(v,"getPlayerHarndrang", 0)
					if(bed_Reaktion3[v] == "false") then
						bed_Reaktion3[v] = "true"
						triggerEvent ( "BeduerfnisReaktion", v, "3" )				
					end				
				else
					setElementData(v,"getPlayerHarndrang", getElementData(v,"getPlayerHarndrang")-0.008)
				end
				
				if (getElementData(v,"getPlayerHygiene") - 0.0015) < 0 then
					setElementData(v,"getPlayerHygiene", 0)
					if isElementInWater(v) == true then
						setElementData(v,"getPlayerHygiene", getElementData(v,"getPlayerHygiene")+2)
					end
				else
					if isElementInWater(v) == true then
						setElementData(v,"getPlayerHygiene", getElementData(v,"getPlayerHygiene")+2)
					else
						setElementData(v,"getPlayerHygiene", getElementData(v,"getPlayerHygiene")-0.0015)
					end
				end
				
				if (getElementData(v,"getPlayerEnergie") > 100) then
					setElementData(v,"getPlayerEnergie", 100)
				end
				if (getElementData(v,"getPlayerHygiene") > 100) then
					setElementData(v,"getPlayerHygiene", 100)
				end		
				if (getElementData(v,"getPlayerHarndrang") > 100) then
					setElementData(v,"getPlayerHarndrang", 100)
				end	
				if (getElementData(v,"getPlayerHunger") > 100) then
					setElementData(v,"getPlayerHunger", 100)
				end			
				
				-- Alkoholsystem
				if (math.round( getElementData(v,"promille"), 1) == math.round( getElementData(v,"promillesoll"), 1)) then
					if getElementData(v,"promillesoll") - 0.1 < 0 then
						setElementData(v, "promillesoll", 0)
					else
						setElementData(v, "promillesoll", getElementData(v,"promillesoll")-0.1)
					end				
				elseif (getElementData(v,"promille") > getElementData(v,"promillesoll")) then
					setElementData(v, "promille", getElementData(v,"promille")-0.001)
				elseif (getElementData(v,"promille") < getElementData(v,"promillesoll")) then
					setElementData(v, "promille", getElementData(v,"promille")+0.05)
				end
				if getElementData(v,"promille") > 3 then
					outputChatBox("Du bist Aufgrund Alkoholmissbrauchs zusammengebrochen.",v,255,0,0)	
					setElementData(v, "promille", 0)
					setElementData(v, "promillesoll", 0)
					killPed(v)
				elseif getElementData(v, "promille") > 2 then
					if isPedInVehicle(v) then
						local randint = math.random(1,5)
						if randint == 1 then
							setControlState ( v, "vehicle_left", true )
							setControlState ( v, "vehicle_right", false )
						elseif randint == 2 then
							setControlState ( v, "vehicle_left", false )
							setControlState ( v, "vehicle_right", true )
						end
					else
						local foundveh = false
						local vehicles = getElementsByType("vehicle")
						for _,g in pairs(vehicles) do
							local x, y, z = getElementPosition( g )
							local x1, y1, z1 = getElementPosition( v )	
							if getDistanceBetweenPoints2D ( x, y, x1, y1 ) < 2 then
								foundveh = true
							end
						end
						if foundveh == false then
							setPedAnimation ( v, "ped", "WALK_DRUNK", -1, false, true, true, false )
							setElementData(v, "prom-torkelt", true)
						elseif foundveh == true then
							setElementData(v, "prom-torkelt", false)
							setPedAnimation( v, false )
						end
					end
				elseif getElementData(v, "promille") < 2 and getElementData(v, "prom-torkelt") == true then
					setElementData(v, "prom-torkelt", false)
					setPedAnimation( v, false )
				end
				setElementData(v, "promille", math.round(getElementData(v, "promille"), 3))
				setElementData(v, "promillesoll", math.round(getElementData(v, "promillesoll"), 3))	
			end
		end
	end
end

function BeduerfnisReaktion(beduerfniss)    
	if(beduerfniss == "1") then
		outputChatBox("Du bist eingschlafen!",source,255,0,0)
		setElementData(source, "amSchlafen", true)
	end
	
	if(beduerfniss == "2") then
		outputChatBox("Du bist verhungert!",source,255,0,0)
		killPed(source)
		setElementData(source,"getPlayerHunger", 100)
		bed_Reaktion2[source] = "false"
	end
	
	if(beduerfniss == "3") then
		outputChatBox("Du inkontinente Sau!",source,255,0,0)	
		setElementData(source,"getPlayerHygiene", getElementData(source,"getPlayerHygiene")-50)
		setElementData(source,"getPlayerHarndrang", 80)
		bed_Reaktion3[source] = "false"
		setPedAnimation (source, "PAULNMAC", "Piss_loop", 3000, false, true, true )
		local x, y, z = getElementPosition(source)
		local players = getElementsByType("player")
		for _,v in pairs(players) do
			callClientFunction( v, "fxAddWaterSplash", x, y, z )
			callClientFunction(v, "playSound3D", "sounds/fail.mp3", x, y, z)
		end
		setTimer(
				function(ply)
				setPedAnimation (ply, false)
				end
			,1000,1, source)
	end
end

addEvent("BeduerfnisReaktion", true)
addEventHandler("BeduerfnisReaktion", getRootElement(), BeduerfnisReaktion)