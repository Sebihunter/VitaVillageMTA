--[[
Project: VitaOnline
File: polizei-server.lua
Author(s):	Sebihunter
			x86dev
]]--

gJailPlayers = {}
gHasPlayerHandschellen = {}
playerHandcuffTimer = {}
local currentRoadblocks = {}
local currentRoadblocksCount = 0
local currentBlitzerCount = 0

local MAX_DISTANCE = 150
local polyShapesTable = {}
local speedObjectTable = {}
ptimer = {}
ltimer = {}

lvpolizeitor1 = createObject(16773, 2336.1274414063, 2445.1982421875, 6.5435180664063, 0, 0, 60)
lvpolizeitor2 = createObject(16773, 2294.0407714844, 2498.2783203125, 5.2726535797119, 0, 0, 90)
setElementData(lvpolizeitor1, "state", "down" )
setElementData(lvpolizeitor2, "state", "down" )


--- Innere LVPD Tueren

local tuer1 = createObject( 3089, 209.08700561523, 156.47999572754, 1003.1500244141, 0, 0, 90 )
local tuer1_key1 = createObject( 2886, 209.69999694824, 156.19999694824, 1003.299987793, 0, 0, 180 )
local tuer1_key2 = createObject( 2886, 204.69999694824, 158.39999389648, 1003.299987793, 0, 0, 90 )
setElementData( tuer1_key1, "cinfo", {"Tür öffnen/schließen\nKnastausbruch (Gangs)"} )
setElementData( tuer1_key2, "cinfo", {"Tür öffnen/schließen\nKnastausbruch (Gangs)"} )
setElementData(tuer1_key1, "isKnastTuer", true)
setElementData(tuer1_key2, "isKnastTuer", true)

setElementData( tuer1, "doubleside", true )
setElementInterior( tuer1, 3 )

setElementInterior( tuer1_key1, 3 )
setElementInterior( tuer1_key2, 3 )

function pd_tuer1_func ( button, state, player )
	if state ~= "down" then return end
	if getElementData( player, "job" ) ~= 3 then 
		if getElementData(player, "dienst") ~= 1 and getElementData(player, "gang") ~= 0 then
			startJailbreak(player)
		end
		return
	end
	
	if getElementData( tuer1, "moving" ) == true then return end
	
	setElementData( tuer1, "moving", true )
	setTimer( setElementData, 2600, 1, tuer1, "moving", false ) 
	
	if getElementData( tuer1, "state" ) == "open" then
		moveObject( tuer1, 2500, 209.08700561523, 156.47999572754, 1003.1500244141, 0, 0, -90 )
		setElementData( tuer1, "state", "closed" )
	else
		moveObject( tuer1, 2500, 209.08700561523, 156.47999572754, 1003.1500244141, 0, 0, 90	)
		setElementData( tuer1, "state", "open" )
	end
end
addEventHandler( "onElementClicked", tuer1_key1, pd_tuer1_func )
addEventHandler( "onElementClicked", tuer1_key2, pd_tuer1_func )

--

local tuer2 = createObject( 3089, 209.08700561523, 177.36999511719, 1003.1500244141, 0, 0, 90 )
local tuer2_key1 = createObject( 2886, 211.19999694824, 177.10000610352, 1003.299987793, 0, 0, 180 )
local tuer2_key2 = createObject( 2886, 208.80000305176, 177.10000610352, 1003.299987793, 0, 0, 270 )
setElementData( tuer2_key1, "cinfo", {"Tür öffnen/schließen\nKnastausbruch (Gangs)"} )
setElementData( tuer2_key2, "cinfo", {"Tür öffnen/schließen\nKnastausbruch (Gangs)"} )
setElementData(tuer2_key1, "isKnastTuer", true)
setElementData(tuer2_key2, "isKnastTuer", true)

setElementData( tuer2, "doubleside", true )
setElementInterior( tuer2, 3 )

setElementInterior( tuer2_key1, 3 )
setElementInterior( tuer2_key2, 3 )


function pd_tuer2_func ( button, state, player )
	if state ~= "down" then return end
	if getElementData( player, "job" ) ~= 3 then 
		if getElementData(player, "dienst") ~= 1 and getElementData(player, "gang") ~= 0 then
			startJailbreak(player)
		end
		return
	end
	
	if getElementData( tuer2, "moving" ) == true then return end
	
	setElementData( tuer2, "moving", true )
	setTimer( setElementData, 2600, 1, tuer2, "moving", false ) 
	
	if getElementData( tuer2, "state" ) == "open" then
		moveObject( tuer2, 2500, 209.08700561523, 177.36999511719, 1003.1500244141, 0, 0, 90 )
		setElementData( tuer2, "state", "closed" )
	else
		moveObject( tuer2, 2500, 209.08700561523, 177.36999511719, 1003.1500244141, 0, 0,-90 )
		setElementData( tuer2, "state", "open" )
	end
end
addEventHandler( "onElementClicked", tuer2_key1, pd_tuer2_func )
addEventHandler( "onElementClicked", tuer2_key2, pd_tuer2_func )


addEventHandler("onColShapeHit", getRootElement(),
	function(player, matchingDimension)

		if not player then return end
		if not isElement(player) then return end
		
		if getElementType ( player ) ~= "player" then return end
		if not matchingDimension then return end
		if not isPedInVehicle(player) then return end
		
		local col = source
		local handleSpeed = true
		
		local vehicle = getPedOccupiedVehicle(player)
		if getVehicleOccupant(vehicle, 0) ~= player then return end

		if getVehicleType(vehicle) == "Plane" or getVehicleType(vehicle) == "BMX" or getVehicleType(vehicle) == "Helicopter" or getVehicleType(vehicle) == "Train" then
			handleSpeed = false
		end
		
		local av = getElementData(source, "vehicle")
		if getElementData(col, "isSpeedCamera") and handleSpeed and av and av ~= vehicle and ( getVehicleOccupant ( av, 2 ) or  getVehicleOccupant ( av, 3 ) or  getVehicleOccupant ( av, 4 ) ) then
			local maxSpeed = tonumber(getElementData(col, "maxVehicleSpeed"))
			if vehicle then
				local speedx, speedy, speedz = getElementVelocity(vehicle)
				if speedx ~= nil then
					actualSpeed = math.floor(  ((speedx^2 + speedy^2 + speedz^2) ^ 0.7) * 50 * 3.2 )	
				end
				actualSpeed = tonumber(string.format("%d", actualSpeed))

				if actualSpeed > maxSpeed then
					local isPol = false
					for numb,ply in ipairs(getElementsByType("player")) do
						if getElementData(ply, "job") == 3 and getElementData(ply, "dienst") == 1 and getElementData(ply, "afk") ~= true then
							local x,y,z = getElementPosition(player)
							local x1,y1,z1 = getElementPosition(ply)
							local distance = getDistanceBetweenPoints2D ( x,y,x1,y1 ) 
							if(distance < 100) then	
								isPol = true
								outputChatBox ( getPlayerName(player).." wurde geblitzt. (Erlaubt: "..maxSpeed.."KM/H - Gefahren: "..actualSpeed.."KM/H)", ply, 255, 255, 0, true )	
							end
						end
					end
					if isPol then
						fadeCamera(player, false, 0.2, 255, 255, 255)
						setTimer(fadeCamera, 150, 1, player, true, 0.2)
						outputChatBox ( "Du wurdest geblitzt. (Erlaubt: "..maxSpeed.."KM/H - Gefahren: "..actualSpeed.."KM/H)", player, 255, 0, 0, true )					
					end
				end
			end
		end
	end
)

addEvent("movePolizeiTor", true)
addEventHandler("movePolizeiTor", getRootElement(),
function(id,player)
	outputDebugString("ANUS")
	if getElementData(player, "job") == 3 then
		if id == 2 then
			if getElementData(lvpolizeitor1, "state") == "open" then
				moveObject(lvpolizeitor1, 2500, 2336.1274414063, 2445.1982421875, 0.79351806640625)
				setElementData(lvpolizeitor1, "state", "down" )
			elseif getElementData(lvpolizeitor1, "state") == "down" then
				moveObject(lvpolizeitor1, 2500, 2336.1274414063, 2445.1982421875, 6.5435180664063)
				setElementData(lvpolizeitor1, "state", "open" )
			end
		end		
		if id == 3 then
			if getElementData(lvpolizeitor2, "state") == "open" then
				moveObject(lvpolizeitor2, 2500, 2294.0407714844, 2498.2783203125, -1.6799999475479)
				setElementData(lvpolizeitor2, "state", "down" )
			elseif getElementData(lvpolizeitor2, "state") == "down" then
				moveObject(lvpolizeitor2, 2500, 2294.0407714844, 2498.2783203125, 5.2726535797119)
				setElementData(lvpolizeitor2, "state", "open" )
			end
		end			
	end
end
)

function addSpeedcamera(ply, command, speed)
  if speed ~= "" and speed ~= nil and (0 < tonumber(speed) and tonumber(speed) < 200) then
	if getElementData(ply, "job") == 3 and getElementData(ply, "dienst") == 1 and getElementData(ply, "rank") >= 0 then
		local x,y,z = getElementPosition(ply)
		local a = getPedRotation(ply)
		local veh = getPedOccupiedVehicle(ply)
		if not veh or getPedOccupiedVehicleSeat ( ply ) <= 1 or getElementModel(veh) ~= 440	then return outputChatBox("Fehler: Blitzer konnte wegen falschem Sitz/Fahrzeug nicht erstellt werden!",ply,255,0,0) end
		if getElementData(veh, "isBlitzer") == true then return outputChatBox("Fehler: Dieses Fahrzeug besitzt bereits einen Blitzer!",ply,255,0,0) end
		
		currentBlitzerCount = currentBlitzerCount+1
		
		speedObjectTable[currentBlitzerCount] = createObject(3031, x, y, z, 0, 0, 90-(360-tonumber(a)))
		setElementData(speedObjectTable[currentBlitzerCount], "isBlitzer", true)
		setElementData(speedObjectTable[currentBlitzerCount], "id", currentBlitzerCount)
		setElementData(speedObjectTable[currentBlitzerCount], "name", getPlayerName(ply))
		setElementData(speedObjectTable[currentBlitzerCount], "vehicle", veh)
		setElementData(veh, "isBlitzer", true)
		
		setElementCollisionsEnabled ( speedObjectTable[currentBlitzerCount], false )
		setElementAlpha(speedObjectTable[currentBlitzerCount], 0)
		attachElements ( speedObjectTable[currentBlitzerCount], veh)
		
		local x, y, z = getElementPosition(speedObjectTable[currentBlitzerCount])
		--setObjectStatic(speedObjectTable[currentBlitzerCount], true)
		
		local leftX, leftY = getPointFromDistanceRotation(x, y, 35, 360-(a+30))
		local rightX, rightY = getPointFromDistanceRotation(x, y, 35, 360-(a-10))
		
		polyShapesTable[currentBlitzerCount] = createColPolygon(
			x, y,
			leftX, leftY,
			rightX, rightY,
			x, y
		)
		
		attachElements ( polyShapesTable[currentBlitzerCount], speedObjectTable[currentBlitzerCount])
		setElementData(polyShapesTable[currentBlitzerCount], "isSpeedCamera", true)
		setElementData(polyShapesTable[currentBlitzerCount], "maxVehicleSpeed", tonumber(speed))	
		setElementData(polyShapesTable[currentBlitzerCount], "vehicle", veh)		
	end	
  else
	outputChatBox("Fehler: /blitzer [Geschwindigkeit 1-200]",ply,255,0,0)
  end
end
addCommandHandler("blitzer",addSpeedcamera, false, false)

function delSpeedcamera(ply, command, obj)
	if not obj or obj == "" or not tonumber(obj) then outputChatBox("Fehler: /delblitzer [ID]",ply,255,0,0) return end
	obj = tonumber(obj)
	if getElementData(ply, "job") == 3 and getElementData(ply, "dienst") == 1 and getElementData(ply, "rank") >= 0 then
		if speedObjectTable[obj] and polyShapesTable[obj] then
			setElementData(getElementData(speedObjectTable[obj], "vehicle"), "isBlitzer", false)
			destroyElement(speedObjectTable[obj])
			destroyElement(polyShapesTable[obj])		
			polyShapesTable[obj] = nil
			speedObjectTable[obj] = nil
		else
			outputChatBox("Blitzer ID existiert nicht.",ply,255,0,0)
		end
	end	
end
addCommandHandler("delblitzer", delSpeedcamera, false, false)


function addRoadblock(ply, command)        
	if getElementData(ply, "job") == 3 and getElementData(ply, "dienst") == 1 then
		local x,y,z = getElementPosition(ply)
		local a = getPedRotation(ply)
		currentRoadblocksCount = currentRoadblocksCount+1
		currentRoadblocks[currentRoadblocksCount] = createObject(3091, x, y, z - 0.3, 0.0, 0.0, a)
		setObjectBreakable ( currentRoadblocks[currentRoadblocksCount], false)
		local int = getElementInterior(ply)
		local dim = getElementDimension(ply)		
		setElementInterior(currentRoadblocks[currentRoadblocksCount], int)
		setElementDimension(currentRoadblocks[currentRoadblocksCount], dim)
	end	
end
addCommandHandler("absperrung",addRoadblock, false, false)
addCommandHandler("ab",addRoadblock, false, false)

function delRoadblock(ply, command)
	if getElementData(ply, "job") == 3 then
		for obj = 1, currentRoadblocksCount do
			destroyElement(currentRoadblocks[obj])
		end
		currentRoadblocksCount = 0
	end	
end
addCommandHandler("delabsperrung",delRoadblock, false, false)
addCommandHandler("abdel",delRoadblock, false, false)

function togglePaStatus(ply, command, playertoarrest, note)
	if getElementData(ply, "job") == 3 and getElementData(ply, "dienst") == 1 and getElementData(ply, "rank") == 2 then
		if playertoarrest ~= "" and playertoarrest ~= nil and note ~= "" and note ~= nil and tonumber(note) >= 0 and tonumber(note) <= 100 then
			theArrested = getPlayerFromName2 ( playertoarrest )
			if theArrested then
				if type(theArrested) == "table" then
					outputChatBox("Fehler: Mehrere Spieler gefunden!",ply,255,0,0)
					return
				end
				playertoarrest = getPlayerName(theArrested)
				
				setElementData(theArrested, "panote", note)
				outputChatBox("Du hast "..tostring(playertoarrest).." eine PA Note von "..note.."% gegeben.",ply,0,255,0)
				outputChatBox("Dir wurde von "..tostring(getPlayerName(ply)).." eine PA Note von "..note.."% gegeben.",theArrested,0,255,0)
			end
		else
			outputChatBox("Fehler: /panote [Spielername] [0-100]",ply,255,0,0)
		end
	end
end
addCommandHandler("panote",togglePaStatus, false, false)

function togglePlayerHandcuffs(ply, command, playertoarrest)
	if getElementData(ply, "job") == 3 and getElementData(ply, "dienst") == 1 then
		if playertoarrest ~= "" and playertoarrest ~= nil then
			theArrested = getPlayerFromName2 ( playertoarrest )
			if theArrested then
				if type(theArrested) == "table" then
					outputChatBox("Fehler: Mehrere Spieler gefunden!",ply,255,0,0)
					return
				end
				playertoarrest = getPlayerName(theArrested)
				local x,y,z = getElementPosition(ply)
				local x1,y1,z1 = getElementPosition(theArrested)
				local distance = getDistanceBetweenPoints2D ( x,y,x1,y1 ) 
				if(distance < 10) then
					if gHasPlayerHandschellen[theArrested] == 1 then
						gHasPlayerHandschellen[theArrested] = 0
						if playerHandcuffTimer[theArrested] and isTimer(playerHandcuffTimer[theArrested]) then killTimer(playerHandcuffTimer[theArrested]) end
						setPedAnimation(theArrested)
						outputChatBox("Der Spieler "..tostring(playertoarrest).." hat nun keine Handschellen mehr.",ply,0,255,0)
						outputChatBox("Dir wurden die Handschellen abgenommen.",theArrested,0,255,0)
						toggleControl ( theArrested, "enter_exit", false )
						toggleControl ( theArrested, "enter_passenger", false )
						setElementData(theArrested, "handschellen", false)
					else
						if ((not getPedOccupiedVehicle(theArrested)) and (not getPedOccupiedVehicle(ply))) or ((getPedOccupiedVehicle(ply) == getPedOccupiedVehicle(theArrested))) then
							gHasPlayerHandschellen[theArrested] = 1
							toggleHandcuffs(theArrested, ply, 1.0)
							outputChatBox("Der Spieler "..tostring(playertoarrest).." hat nun Handschellen.",ply,0,255,0)
							outputChatBox("Dir wurden Handschellen angelegt.",theArrested,0,255,0)
							setElementData(theArrested, "handschellen", ply)
						else
							outputChatBox("Fehler: Du und der Spieler müssen entweder beide zu Fuß, oder im selben Fahrzeug sein!",ply,255,0,0)
						end
					end
				end
			end
		else
			outputChatBox("Fehler: /handschellen [Spielername]",ply,255,0,0)
		end
	end
end
addCommandHandler("handschellen",togglePlayerHandcuffs, false, false)
addCommandHandler("hs",togglePlayerHandcuffs, false, false)

function checkPlayerGras(player, command, playername)
	if getElementData(player, "job") == 3 and getElementData(player, "rank") >= 0 then
		if playername ~= "" and playername ~= nil then
			local oplayer = getPlayerFromName2(playername)
			if type(oplayer) == "table" then
				outputChatBox("Fehler: Mehrere Spieler gefunden!",player,255,0,0)
				return
			end
			playername = getPlayerName(oplayer)
			
			local hasGras = false
			if #getElementData(oplayer, "items") ~= 0 then
				for i,v in pairs(getElementData(oplayer, "items")) do
					if v.itemid and v.itemid >= 61 and v.itemid <= 62 then
						hasGras = true
					end
				end
			end
			
			outputChatBox("Du wurdest auf Gras überprüft!",oplayer,0,0,255)
			if hasGras == true and getElementData(oplayer, "isHigh") == true then
				outputChatBox("Dieser Spieler hat Gras bei sich und ist ebenfalls bekifft!",player,0,255,0)
			elseif hasGras == true then
				outputChatBox("Dieser Spieler hat Gras bei sich, ist aber nicht bekifft!",player,0,255,0)
			elseif getElementData(oplayer, "isHigh") == true then
				outputChatBox("Dieser Spieler ist bekifft, hat aber kein Gras bei sich!",player,0,255,0)
			else
				outputChatBox("Dieser Spieler ist clean!",player,0,255,0)
			end
		else
			outputChatBox("Fehler: /grascheck [Spielername]",player,255,0,0)
		end
	end
end
addCommandHandler("grascheck", checkPlayerGras, false, false)



function removePlayersGras(player, command, playername)
	if getElementData(player, "job") == 3 and getElementData(player, "rank") >= 0 then
		if playername ~= "" and playername ~= nil then
			local oplayer = getPlayerFromName2(playername)
			if type(oplayer) == "table" then
				outputChatBox("Fehler: Mehrere Spieler gefunden!",player,255,0,0)
				return
			end
			playername = getPlayerName(oplayer)
			local hasWeapons = false
			
			if #getElementData(oplayer, "items") ~= 0 then
				for i,v in pairs(getElementData(oplayer, "items")) do
					if v.itemid and v.itemid >= 61 and v.itemid <= 62 then
						removeItem(oplayer, i, true)
						hasWeapons = true
					end
				end
			end
			
			if hasWeapons then
				outputChatBox("Dir wurde dein Gras entzogen!",oplayer,255,0,0)
				outputChatBox("Du hast diesem Spieler alles Gras abgenommen!",player,255,0,0)
			else	
				outputChatBox("Dieser Spieler hat kein Gras!",player,255,0,0)
			end
		else
			outputChatBox("Fehler: /grasabnehmen [Spielername]",player,255,0,0)
		end
	end
end
addCommandHandler("grasabnehmen", removePlayersGras, false, false)

function checkPlayersWeapon(player, command, playername)
	if getElementData(player, "job") == 3 and getElementData(player, "rank") >= 0 then
		if playername ~= "" and playername ~= nil then
			local oplayer = getPlayerFromName2(playername)
			if type(oplayer) == "table" then
				outputChatBox("Fehler: Mehrere Spieler gefunden!",player,255,0,0)
				return
			end
			playername = getPlayerName(oplayer)
			local hasWeapons = false
			for i = 1, 12 do
				if getPedWeapon(oplayer, i) ~= 0 and getPedTotalAmmo (oplayer, i ) ~= 0 then
					hasWeapons = true
					outputChatBox("Waffe: "..getWeaponNameFromID ( getPedWeapon(oplayer, i) ),player,40,80,255)
				end
			end
			
			local itemweapon = {}
			if #getElementData(oplayer, "items") ~= 0 then
				for i,v in pairs(getElementData(oplayer, "items")) do
					if v.itemid and v.itemid >= 9 and v.itemid <= 40 or v.itemid == 53 then
						local isAlready = false
						for i2,v2 in ipairs(itemweapon) do
							if v2 == v.itemid then isAlready = true end
						end
						if not isAlready then 
							outputChatBox("ITEM Waffe: "..tostring(getItemName(v.itemid)),player,40,80,255)
							itemweapon[#itemweapon+1] = v.itemid
						end
						hasWeapons = true
					end
				end
			end
			
			if hasWeapons then
				outputChatBox("Du wurdest auf Waffen überprüft!",oplayer,255,0,0)
			else	
				outputChatBox("Dieser Spieler hat keine Waffen!",player,255,0,0)
			end
		else
			outputChatBox("Fehler: /waffencheck [Spielername]",player,255,0,0)
		end
	end
end
addCommandHandler("waffencheck", checkPlayersWeapon, false, false)


function removePlayersWeapon(player, command, playername)
	if getElementData(player, "job") == 3 and getElementData(player, "rank") >= 0 then
		if playername ~= "" and playername ~= nil then
			local oplayer = getPlayerFromName2(playername)
			if type(oplayer) == "table" then
				outputChatBox("Fehler: Mehrere Spieler gefunden!",player,255,0,0)
				return
			end
			playername = getPlayerName(oplayer)
			local hasWeapons = false
			for i = 1, 12 do
				if getPedWeapon(oplayer, i) ~= 0 and getPedTotalAmmo (oplayer, i ) ~= 0 then
					hasWeapons = true
					break;
				end
			end
			takeAllWeapons ( oplayer )
			
			if #getElementData(oplayer, "items") ~= 0 then
				for i,v in pairs(getElementData(oplayer, "items")) do
					if v.itemid and v.itemid >= 9 and v.itemid <= 40 then
						removeItem(oplayer, i, true)
						hasWeapons = true
					end
				end
			end
			
			if hasWeapons then
				outputChatBox("Dir wurden alle Waffen entzogen!",oplayer,255,0,0)
				outputChatBox("Du hast diesem Spieler alle Waffen abgenommen!",player,255,0,0)
			else	
				outputChatBox("Dieser Spieler hat keine Waffen!",player,255,0,0)
			end
		else
			outputChatBox("Fehler: /waffenabnehmen [Spielername]",player,255,0,0)
		end
	end
end
addCommandHandler("waffenabnehmen", removePlayersWeapon, false, false)

function callPolice(source, commandName)
    if getElementData(source, "isPlayerLoggedIn") == true then
		if getElementData(source, "job") ~= 3 or getElementData(source, "dienst") ~= 1 then return end
		local x, y, z = getElementPosition(source)
		local zone = getZoneName ( x, y, z )
		local city = getZoneName ( x, y, z, true )
		for numb,ply in ipairs(getElementsByType("player")) do
			if getElementData(ply, "job") == getElementData(source, "job") and getElementData(ply, "dienst") == 1 then
				outputChatBox ( getPlayerName(source).." benötigt polizeiliche Verstärkung in "..zone.." ("..city..").", ply, 0, 0, 125, true )
				outputChatBox ( "Ein Icon ist für 3 Minuten auf der Karte sichtbar.", ply, 0, 0, 125, true )
				local blip = createBlipAttachedTo ( source, 0, 5, 0,0, 125, 255, 0, 99999.0, ply )
				setTimer(
					function()
						destroyElement(blip)
					end
				,180000,1, blip)					
			end
		end
	end
end
addCommandHandler("pcall", callPolice, false, false)

local zellen = {
[1] = {189.577,160.884,1004.0234},
[2] = {193.677,160.884,1005.0234},
[3] = {198.577,160.884,1004.0234},
[4] = {189.577,176.494,1004.0234},
[5] = {193.677,176.494,1004.0234},
[6] = {198.577,176.494,1004.0234}
}
cabinMoney = {}

function forcePerso( source, commandName, playername)
	if(playername ~= "" and playername ~= nil) then	
		if getElementData(source, "job") == 3 and getElementData(source, "dienst") == 1 and getElementData(source, "rank") >=  0 then
		    local player = getPlayerFromName2 ( playername )
			if player then
				if type(player) == "table" then
					outputChatBox("Fehler: Mehrere Spieler gefunden!",source,255,0,0)
					return
				end
				playername = getPlayerName(player)
				local x,y,z = getElementPosition(player)
				for i,v in ipairs(zellen) do
					local distance = getDistanceBetweenPoints3D ( x,y,z, v[1], v[2], v[3]) 
					if distance < 20 then
						outputChatBox("Du hast den Personalausweis von "..playername.." abgenommen.", source,0,0,255)
						outputChatBox("Dein Personalausweis wurde von "..getPlayerName(source).." abgenommen.", player,0,0,255)
						executeCommandHandler ( "perso", player, tostring(getPlayerName(source)) )
						return
					end
				end
				outputChatBox("Dieser Spieler ist nicht bei den Zellen.",source,255,0,0)
			else
				outputChatBox("Dieser Spieler existiert nicht.",source,255,0,0)
			end
		end
	else
		outputChatBox("Fehler: /forceperso [Spielername]",source,255,0,0)
	end
end
addCommandHandler("forceperso", forcePerso, false, false)

function togglePlayerCabin(ply, command, playertoarrest, arreststatus, zelle, timer)
	if getElementData(ply, "job") == 3 and getElementData(ply, "dienst") == 1 and getElementData(ply, "rank") >= 0 then
		if playertoarrest ~= "" and playertoarrest ~= nil and arreststatus ~= "" and arreststatus ~= nil and zelle ~= "" and zelle ~= nil and timer ~= "" and timer ~= nil then
			if not zellen[tonumber(zelle)] then outputChatBox("Fehler: Zelle existiert nicht!",ply,255,0,0) return end
			zelle = tonumber(zelle)
			theArrested = getPlayerFromName2 ( playertoarrest )
			if theArrested then
				if type(theArrested) == "table" then
					outputChatBox("Fehler: Mehrere Spieler gefunden!",ply,255,0,0)
					return
				end
				if theArrested == ply then outputChatBox("Fehler: Du kannst diesen Befehl nicht an dir selbst ausführen.",ply,255,0,0) return end
				playertoarrest = getPlayerName(theArrested)
				local x,y,z = getElementPosition(ply)
				local x1,y1,z1 = getElementPosition(theArrested)
				local distance = getDistanceBetweenPoints2D ( x,y,x1,y1 ) 
				if(distance < 10) then
					local distance1 = getDistanceBetweenPoints2D ( zellen[zelle][1], zellen[zelle][2],x1,y1 )
					if(distance1 < 5) then
						if(arreststatus == "1") then
							setElementPosition(theArrested, zellen[zelle][1], zellen[zelle][2], zellen[zelle][3])
							if timer == 0 then return end
							--if timer then
								toggleControl ( theArrested, "enter_exit", false)
								toggleControl ( theArrested, "fire", false)
								toggleControl ( theArrested, "aim_weapon", false )
								cabinMoney[theArrested] = 0
								setElementData(theArrested, "einsperrzeit", tonumber(timer))
								pLogger["einsperren"]:addEntry(getPlayerName(ply).." hat "..getPlayerName(theArrested).." für "..tostring(timer).." Minuten in das Gefängnis gesteckt.")
							--else
							--	pLogger["einsperren"]:addEntry(getPlayerName(ply).." hat "..getPlayerName(theArrested).." in das Gefängnis gesteckt.")
							--end
						else
							if cabinMoney[theArrested] then
								systemDeposit("Polizei", cabinMoney[theArrested])
								cabinMoney[theArrested] = 0
							end
							setElementData(theArrested, "einsperrzeit", 0)
							setElementPosition(theArrested, 229.768,154.3054,1003.023)
							toggleControl ( theArrested, "enter_exit", true )
							toggleControl ( theArrested, "fire", true )
							toggleControl ( theArrested, "aim_weapon", true )
							pLogger["einsperren"]:addEntry(getPlayerName(ply).." hat "..getPlayerName(theArrested).." aus dem Gefängnis geholt.")
						end
					else
						outputChatBox("Fehler: Du bist nicht nah genug an der Zelle!",ply,255,0,0)
					end
				end			
			end
		else
			outputChatBox("Fehler: /einsperren [Spielername] [0/1] [Zelle 1-6] [Zeit in Minuten]",ply,255,0,0)
		end
	end
end
addCommandHandler("einsperren", togglePlayerCabin, false, false)


function updatePlayerCabin()
	gJailPlayers = {}
	local etime
	for k, v in pairs(getElementsByType("player")) do
		etime = getElementData(v, "einsperrzeit")
		if etime ~= false and etime ~= 0 then
			gJailPlayers[#gJailPlayers+1] = v
			if getElementData(v, "afk") ~= true then
				if etime > 0 and etime <= 1 then
					setElementPosition(v, 229.768,154.3054,1003.023)
					setElementData(v, "einsperrzeit", 0)
					toggleControl ( v, "enter_exit", true )
					toggleControl ( v, "fire", true )
					toggleControl ( v, "aim_weapon", true )
					if cabinMoney[v] then
						systemDeposit("Polizei", cabinMoney[v])
						cabinMoney[v] = 0
					end
				elseif etime > 0 then
					if not cabinMoney[v] then cabinMoney[v] = 0 end
					setElementData(v, "einsperrzeit", etime -1)
					cabinMoney[v] = cabinMoney[v] + 100
				elseif etime <= 0 then
					setElementData(v, "einsperrzeit", 0)
				end
			end
		end
	end
end
setTimer(updatePlayerCabin, 60000, 0)



function showJailTime( source, commandName, playername)
	if(playername ~= "" and playername ~= nil) then	
		if getElementData(source, "job") == 3 and getElementData(source, "dienst") == 1 and getElementData(source, "rank") >=  0 then
		    local player = getPlayerFromName2 ( playername )
			if player then
				if type(player) == "table" then
					outputChatBox("Fehler: Mehrere Spieler gefunden!",source,255,0,0)
					return
				end
				playername = getPlayerName(player)
				outputChatBox(playername.." ist noch "..tostring(getElementData(player, "einsperrzeit")).." Minuten eingesperrt.", source,0,255,0)
			else
				outputChatBox("Dieser Spieler existiert nicht.",source,255,0,0)
			end
		end
	else
		outputChatBox("Fehler: /jailtime [Spielername]",source,255,0,0)
	end
end
addCommandHandler("jailtime", showJailTime, false, false)

function removeDrivingLicense( source, commandName, playername, fschein )
	if(fschein ~= "" and fschein ~= nil and playername ~= "" and playername ~= nil) then	
		if getElementData(source, "job") == 3 and getElementData(source, "dienst") == 1 and getElementData(source, "rank") >= 0 then
		    local player = getPlayerFromName2 ( playername )
			if player then
				if type(player) == "table" then
					outputChatBox("Fehler: Mehrere Spieler gefunden!",source,255,0,0)
					return
				end
				playername = getPlayerName(player)
				if (tonumber(fschein) >= 1 and tonumber(fschein) <= 4) then
					outputChatBox("Du hast den "..tostring(gFscheinTyp[tonumber(fschein)].name).." "..playername.." entzogen.", source,0,255,0)
					outputChatBox("Du hast den "..tostring(gFscheinTyp[tonumber(fschein)].name).." von "..getPlayerName(source).." entzogen bekommen!", player,0,255,0)
					setElementData(player, tostring(gFscheinTyp[tonumber(fschein)].element), false)
				else
					outputChatBox("Dieser Scheintyp existiert nicht.",source,255,0,0)
				end
			else
				outputChatBox("Dieser Spieler existiert nicht.",source,255,0,0)
			end
		end
	else
		outputChatBox("Fehler: /fscheinweg [Spielername] [FscheinID]",source,255,0,0)
	end
end
addCommandHandler("fscheinweg", removeDrivingLicense, false, false)


function toggleHandcuffs(ply, thePolice)
	if thePolice and isElement(thePolice) and getElementData(thePolice, "isDead") ~= true and getElementData(ply, "isDead") ~= true then
		if(isPedInVehicle ( thePolice )) then
			toggleControl ( ply, "enter_exit", false )
			toggleControl ( ply, "enter_passenger", false )
			veh = getPedOccupiedVehicle ( thePolice )
			warpPedIntoVehicle ( ply, veh, 1 )
			playerHandcuffTimer[ply] = setTimer ( toggleHandcuffs, 700, 1, ply, thePolice )
		else
			if not getElementData(ply, "einsperrzeit") or getElementData(ply, "einsperrzeit") == 0 then
				toggleControl ( ply, "enter_exit", true )
			end
			toggleControl ( ply, "enter_passenger", true )	
			removePedFromVehicle(ply)
			local x,y,z = getElementPosition(ply)
			local x1,y1,z1 = getElementPosition(thePolice)
			local distance = getDistanceBetweenPoints2D ( x,y,x1,y1 ) 
		
			local X, Y = 0, 0;
		
			local faceX = math.abs( x - x1 );
			local faceY = math.abs( y - y1 );
			local faceMe = math.deg( math.atan2( faceY , faceX ) );	

			if ( x >= x1 ) and ( y > y1 ) then		-- north-east
				faceMe = 90 + faceMe
			elseif ( x <= x1 ) and ( y > y1 ) then	-- north-west
				faceMe = 270 - faceMe
			elseif ( x >= x1 ) and ( y <= y1 ) then	-- south-east
				faceMe = 90 - faceMe
			elseif ( x < x1 ) and ( y <= y1 ) then 	-- south-west
				faceMe = 270 + faceMe
			end
		
			if (distance < 100) then
				setPedRotation( ply, faceMe );
			end
		
			if(distance < 2.0) then
				setPedAnimation ( ply, "ped", "WALK_csaw", -1, true, true, false )
			else
				setPedAnimation ( ply, "ped", "run_csaw", -1, true, true, false )	
			end	
		
		--	if (distance < 100) then
			playerHandcuffTimer[ply] = setTimer ( toggleHandcuffs, 700, 1, ply, thePolice)
			--else
			--	if getElementInterior(ply) == getElementInterior(thePolice) then
			--		outputChatBox("Du konntest dich von den Handschellen befreien.",ply,0,255,0)
			--		gHasPlayerHandschellen[ply] = 0
			--	else
			--		playerHandcuffTimer[ply] = setTimer ( toggleHandcuffs, 700, 1, ply, thePolice)
			--	end
			--end
		end	
	else
		if not getElementData(ply, "einsperrzeit") or getElementData(ply, "einsperrzeit") == 0 then
			toggleControl ( ply, "enter_exit", true )
		end
		toggleControl ( ply, "enter_passenger", true )
		setElementData(ply, "handschellen", false)
		setPedAnimation(ply)
		outputChatBox("Du konntest dich von den Handschellen befreien.",ply,0,255,0)
		if thePolice and isElement(thePolice) then
			outputChatBox(getPlayerName(ply).." konnte sich von den Handschellen befreien.",thePolice,255,0,0)
		end
		gHasPlayerHandschellen[ply] = 0
	end
end

function changeWeaponLicense( source, commandName, playername, fscheinstatus, preis )
	if(playername ~= "" and playername ~= nil and fscheinstatus ~= "" and fscheinstatus ~= nil and preis ~= nil) then	
		if (getElementData(source, "job") == 3) and getElementData(source, "dienst") == 1 and getElementData(source, "rank") >=  1 then
		    local player = getPlayerFromName2 ( playername )
			if player then
				if type(player) == "table" then
					outputChatBox("Fehler: Mehrere Spieler gefunden!",source,255,0,0)
					return
				end
				playername = getPlayerName(player)
				fscheinstatus = tonumber(fscheinstatus)
				if fscheinstatus == false or fscheinstatus > 2 then
					outputChatBox("Dieser Waffenschein exisitiert nicht.",source,255,0,0)
					return
				end
		
				preis = tonumber(preis)
		
				if not preis then
					outputChatBox("Der Preis muss eine Zahl sein.",source,255,0,0)
					return
				end
				
				if fscheinstatus >= 1 then
					pLogger["rechnungen"]:addEntry("Waffenschein über "..tostring(preis).." von "..getPlayerName(source).." an "..playername)
					outputChatBox("Du "..playername.." den Waffenschein der Stufe "..tostring(fscheinstatus).." für "..tostring(preis).." angeboten.", source,0,255,0)
					outputChatBox("Dir wurde der Waffenschein der Stufe "..tostring(fscheinstatus).." von "..getPlayerName(source).." für "..tostring(preis).." angeboten.",player,0,255,0)
					outputChatBox("Benutze '/annehmen Waffenschein' um ihn anzunehmen.",player,0,255,0)
					addAcceptCommand(player, "waffenschein", acceptWSchein)
					setElementData(player, "pWScheinData", { ["price"] = preis, ["schein"] = fscheinstatus, ["giver"] = source })
				else
					outputChatBox("Du hast den Waffenschein "..playername.." entzogen.", source,0,255,0)
					outputChatBox("Du hast den Waffenschein von "..getPlayerName(source).." entzogen bekommen.", player,0,255,0)
					setElementData(player, "wschein", 0)
				end
				
			else
				outputChatBox("Dieser Spieler existiert nicht.",source,255,0,0)
			end
		end
	else
		outputChatBox("Fehler: /wschein [Spielername] [1-2] [Preis]",source,255,0,0)
	end
end
addCommandHandler("wschein", changeWeaponLicense, false, false)

function alkoTest( source, commandName, playername )
	if(playername ~= "" and playername ~= nil) then	
		if (getElementData(source, "job") == 3) and getElementData(source, "dienst") == 1 and getElementData(source, "rank") >=  0 then
		    local player = getPlayerFromName2 ( playername )
			if player then
				if type(player) == "table" then
					outputChatBox("Fehler: Mehrere Spieler gefunden!",source,255,0,0)
					return
				end
				local x,y,z = getElementPosition(source)
				local x1,y1,z1 = getElementPosition(player)
				local distance = getDistanceBetweenPoints2D ( x,y,x1,y1 ) 
				if(distance > 10) then outputChatBox("Du bist nicht nah genug am Spieler, um dessen Alkoholpegel zu ermitteln.",source,255,0,0) return false end	
				playername = getPlayerName(player)
				outputChatBox("Der Alkoholgehalt von "..playername.." beträgt "..tostring(getElementData(player, "promille")).." Promille.", source,0,255,0)
				outputChatBox("Dein Alkoholgehalt wurde von "..getPlayerName(source).." gemessen.", player,0,255,0)
			else
				outputChatBox("Dieser Spieler existiert nicht.",source,255,0,0)
			end
		end
	else
		outputChatBox("Fehler: /alkotest [Spielername]",source,255,0,0)
	end
end
addCommandHandler("alkotest", alkoTest, false, false)


addEvent("onPlayerTasered", true) 
addEventHandler("onPlayerTasered", getRootElement(), 
	function(target)
		outputChatBox("Du wurdest von "..getPlayerName(source).." getasert. Du kannst dich für 10 Sekunden nicht bewegen.", target, 255, 0, 0)
		toggleAllControls(target, false, true, false)
		setTimer(toggleAllControls, 10000, 1, target, true, true, false)
	end
)

addCommandHandler("tasertoggle", 
	function(source)
		if (getElementData(source, "job") ~= 3) or getElementData(source, "dienst") ~= 1 then return end
		if getElementData(source, "pTaserMode") ~= true then
			setElementData(source, "pTaserMode", true, true)
			outputChatBox("Du hast deinen Taser aktiviert", source, 255, 255, 255)
		else
			setElementData(source, "pTaserMode", false, true)
			outputChatBox("Du hast deinen Taser deaktiviert", source, 255, 255, 255)
		end
	end
)

addCommandHandler("zeigeakte", 
	function(source, cmd, aktenname)
		if (getElementData(source, "job") ~= 3 and getElementData(source, "job") ~= 6) or getElementData(source, "dienst") ~= 1 then return end
		local myakte
		for i,v in ipairs(getElementsByType("wanted")) do
			if string.lower(getElementData(v, "name")) == string.lower(aktenname) then
				myakte = v
				break
			end
		end
		if not myakte then outputChatBox("Akte konnte nicht gefunden werden.", source, 255, 255, 255) return end
				
		outputChatBox("Akte von "..aktenname, source, 255, 255, 255)
		outputChatBox("---------------------", source, 255, 255, 255)
		outputChatBox("Wanted Level: "..tostring(getElementData(myakte, "wantedLevel")).." Sterne", source, 255, 255, 255)
		for i,v in ipairs(getElementData(myakte, "text")) do
			outputChatBox(tostring(i)..": "..v, source, 255, 255, 255)
		end
		outputChatBox("---------------------", source, 255, 255, 255)
		
    end
)

addCommandHandler("wlevel", 
	function(source, cmd, aktenname, id)
		if (getElementData(source, "job") ~= 3 and getElementData(source, "job") ~= 6) or getElementData(source, "dienst") ~= 1 or getElementData(source, "rank") < 0 then return end
		if isNameRegistered(aktenname) == false then outputChatBox("Bürger konnte nicht gefunden werden.", source, 255, 255, 255) return end
		local myakte
		for i,v in ipairs(getElementsByType("wanted")) do
			if string.lower(getElementData(v, "name")) == string.lower(aktenname) then
				myakte = v
				break
			end
		end
		id = tonumber(id)
		if not myakte then
			myakte = createElement("wanted")
			setElementData(myakte, "wantedLevel", 0)
			setElementData(myakte, "text", {})
			setElementData(myakte, "name", aktenname)
		end
		if id >= 0 and id <= 6 then
			if getPlayerFromName2 ( aktenname )	then
				setElementData(getPlayerFromName2 ( aktenname ), "akte", myakte)
				--outputChatBox("Dein ein Wanted Level wurde geändert. Du hast jetzt "..tostring(id).." Stern(e).", getPlayerFromName2 ( aktenname ), 0, 0, 255)
				triggerClientEvent ( getPlayerFromName2 ( aktenname ), "addNotification", getRootElement(), 2, 0,0,255, "Dein Wanted Level wurde geändert.\nDu hast jetzt "..tostring(id).." Stern(e)." )
			end	
			setElementData(myakte, "wantedLevel", id)
			outputChatBox("Wanted Level von "..aktenname.." auf "..tostring(id).." Sterne gesetzt.", source, 255, 255, 255)
		else
			outputChatBox("Wanted Level muss zwischen 0 und 6 Sterne sein.", source, 255, 255, 255)
		end
    end
)

addCommandHandler("addakte", 
	function(source, cmd, aktenname, ...)
		if (getElementData(source, "job") ~= 3 and getElementData(source, "job") ~= 6) or getElementData(source, "dienst") ~= 1 or getElementData(source, "rank") < 0 then return end
		if isNameRegistered(aktenname) == false then outputChatBox("Bürger konnte nicht gefunden werden.", source, 255, 255, 255) return end
		local myakte
		for i,v in ipairs(getElementsByType("wanted")) do
			if string.lower(getElementData(v, "name")) == string.lower(aktenname) then
				myakte = v
				break
			end
		end
		if not myakte then
			myakte = createElement("wanted")
			setElementData(myakte, "wantedLevel", 0)
			setElementData(myakte, "text", {})
			setElementData(myakte, "name", aktenname)
		end
		if getPlayerFromName2 ( aktenname )	then
			setElementData(getPlayerFromName2 ( aktenname ), "akte", myakte)
		end		
		local text = getElementData(myakte, "text")
		text[#text+1] = table.concat({ ... }, " ")
		text[#text] = text[#text].." ["..getPlayerName(source).."]"
		setElementData(myakte, "text", text)
		outputChatBox("Eintrag zur Akte von "..aktenname.." hinzugefügt.", source, 255, 255, 255)
		callClientFunction(source, "refreshAkten")
    end
)
addCommandHandler("removeeintrag",
	function(source, cmd, aktenname, eintragid)
		if (getElementData(source, "job") ~= 3 and getElementData(source, "job") ~= 6) or getElementData(source, "dienst") ~= 1 or getElementData(source, "rank") < 0 then return end
		local myakte
		for i,v in ipairs(getElementsByType("wanted")) do
			if string.lower(getElementData(v, "name")) == string.lower(aktenname) then
				myakte = v
				break
			end
		end
		if not myakte then outputChatBox("Akte konnte nicht gefunden werden.", source, 255, 255, 255) return end

		local text = getElementData(myakte, "text")
		if text[tonumber(eintragid)] then
			table.remove(text, eintragid)
		else
			outputChatBox("Eintrag konnte nicht gefunden werden.", source, 255, 255, 255) return
		end
		setElementData(myakte, "text", text)
		outputChatBox("Akteneintrag "..eintragid.." von "..aktenname.." entfernt.", source, 255, 255, 255)
    end
)

addCommandHandler("removeakte",
	function(source, cmd, aktenname)
		if (getElementData(source, "job") ~= 3 and getElementData(source, "job") ~= 6) or getElementData(source, "dienst") ~= 1 or getElementData(source, "rank") < 0 then return end
		local myakte
		for i,v in ipairs(getElementsByType("wanted")) do
			if string.lower(getElementData(v, "name")) == string.lower(aktenname) then
				myakte = v
				break
			end
		end
		if not myakte then outputChatBox("Akte konnte nicht gefunden werden.", source, 255, 255, 255) return end
		if getPlayerFromName2 ( aktenname )	then
			setElementData(getPlayerFromName2 ( aktenname ), "akte", false)
		end
		
		local id = getElementData(myakte, "mysqlID")
		if id then
			if mysql_ping ( g_mysql["connection"] ) == false then
				onResourceStopMysqlEnd()
				onResourceStartMysqlConnection()
			end
			local sql = "DELETE FROM `wanteds` WHERE `id` = '"..id.."';"											
			local query = mysql_query(g_mysql["connection"], sql)
			if query then mysql_free_result(query) end	
		end
		destroyElement(myakte)
		outputChatBox("Akte von "..aktenname.." entfernt.", source, 255, 255, 255)
    end
)

function Eskortlicht( player )
	local vehp = getPedOccupiedVehicle ( player )
	local model = getElementModel ( vehp )
	if model == 597 or model == 598 or model == 599 or model == 528 or model == 427 then 
		if getElementData ( player, "job" ) == 3 and isPedInVehicle ( player ) and getElementData(player, "rank") >=  0 then
			if getElementData ( vehp, "Eskortlicht" ) and isTimer(getElementData ( vehp, "Eskortlicht" )) then
				killTimer ( ptimer[vehp] )
				setVehicleLightState ( vehp, 0,  0 )
				setVehicleLightState ( vehp, 1,  0 )
				setVehicleHeadLightColor ( vehp, 0, 0, 0 )
				setVehicleOverrideLights ( vehp, 1 )
			else
				setVehicleHeadLightColor ( vehp, 0, 0, 255 )
				setVehicleOverrideLights ( vehp, 2 )
				ptimer[vehp] = setTimer ( function () setVehicleLightState ( vehp, 0, 1 ) setVehicleLightState ( vehp, 1, 0 )
				if isElement ( vehp ) == false or isElement ( vehp ) == nil then
					killTimer ( ptimer[vehp] )
				end
				setTimer ( function () setVehicleHeadLightColor ( vehp, 0, 0, 255 ) setVehicleLightState ( vehp, 0, 0 ) setVehicleLightState ( vehp, 1, 1 ) end, 500, 1, vehp ) end, 1000, 0 , vehp )
				setElementData ( vehp, "Eskortlicht", ptimer[vehp] )
			end
		end
	end
	if model == 523 then 
		if getElementData ( player, "job" ) == 3 and isPedInVehicle ( player )  then
			if getElementData ( vehp, "Eskortlighttimer" ) and isTimer(getElementData ( vehp, "Eskortlighttimer" )) then
				killTimer ( ltimer )
				setVehicleHeadLightColor ( vehp, 0, 0, 0 )
			else
				setVehicleHeadLightColor ( vehp, 0, 0, 255 )
				ltimer = setTimer ( function () setVehicleOverrideLights ( vehp, 2 )
				if isElement ( vehp ) == false or isElement ( vehp ) == nil then
					killTimer ( ltimer )
				end
				setTimer ( function () setVehicleHeadLightColor ( vehp, 0, 0, 255 ) setVehicleOverrideLights ( vehp, 1 ) end, 500, 1, vehp ) end, 1000, 0 , vehp )
				setElementData ( vehp, "Eskortlighttimer", ltimer )
			end
		end
	end		
end
addCommandHandler ( "eskortlicht", Eskortlicht )

function loadWanteds()
	if mysql_ping ( g_mysql["connection"] ) == false then
		onResourceStopMysqlEnd()
		onResourceStartMysqlConnection()
	end
	
	local result = mysql_query(g_mysql["connection"], "SELECT * FROM `wanteds` ORDER BY `id` ASC")
	if result then
		local hses = 0
		while true do
			local row = mysql_fetch_assoc(result)
			if not row then break end
			
			local wlevel = tonumber(row["wantedLevel"])
			local name = row["name"]
			local text = row["text"]
				
			--Erstelle Eingangspickup
			local wanted = createElement("wanted")
			setElementData(wanted, "mysqlID", tonumber(row["id"]))
			setElementData(wanted, "text", table.load(text))
			setElementData(wanted, "wantedLevel", tonumber(wlevel))
			setElementData(wanted, "name", name)		

			hses = hses+1
		end
		mysql_free_result(result)
		print("__~~*"..tonumber(hses).."*Wanted/s*Loaded!*~~__")
		setTimer(saveWanteds, 1800070, 0, true)
	else
		print("__~~*Failed to load Wanteds*~~__")
	end	
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), loadWanteds)

local theSaveTimer
local wantedSaveTable = {}
function saveWanteds(timer)
	if timer ~= true then timer = false else timer = true end
	if #wantedSaveTable > 0 and timer == true then return end
	if theSaveTimer and isTimer(theSaveTimer) then killTimer(theSaveTimer) end
	wantedSaveTable = {}
	for _, wanted in ipairs(getElementsByType("wanted")) do
		local mid = getElementData(wanted, "mysqlID")
		wantedSaveTable[#wantedSaveTable+1] = {}
		wantedSaveTable[#wantedSaveTable].wanted = wanted
		wantedSaveTable[#wantedSaveTable].name = tostring(getElementData(wanted, "name"))
		wantedSaveTable[#wantedSaveTable].text = tostring(table.save(getElementData(wanted, "text")))
		wantedSaveTable[#wantedSaveTable].wantedLevel = tostring(getElementData(wanted, "wantedLevel"))
		wantedSaveTable[#wantedSaveTable].mid = mid	
	end
	
	if timer == true then
		saveWantedTimer(timer)
	else
		for i = 1, #wantedSaveTable do
			saveWantedTimer(timer)
		end
	end	
end	
addEventHandler("onResourceStop", getResourceRootElement(getThisResource()),saveWanteds)


function saveWantedTimer(timer)
	local i = 1
	if wantedSaveTable[i] then
		if mysql_ping ( g_mysql["connection"] ) == false then
			onResourceStopMysqlEnd()
			onResourceStartMysqlConnection()
		end
			
		if not wantedSaveTable[i].mid then
			mysql_query(g_mysql["connection"], "INSERT INTO `wanteds` (`name`) VALUES ('"..wantedSaveTable[i].name.."');")
		
			local temp = mysql_query(g_mysql["connection"], "SELECT LAST_INSERT_ID(id) AS last FROM wanteds ORDER BY id DESC LIMIT 1;")
			wantedSaveTable[i].mid = mysql_insert_id(g_mysql["connection"])
			mysql_free_result(temp)
			setElementData(wantedSaveTable[i].wanted, "mysqlID", wantedSaveTable[i].mid)
		end	
			
		local sql = "UPDATE `wanteds` SET `name` = '"..wantedSaveTable[i].name.."',\
													`text` = '"..wantedSaveTable[i].text.."',\
													`wantedLevel` = '"..wantedSaveTable[i].wantedLevel.."'\
													WHERE `id` = '"..tostring(wantedSaveTable[i].mid).."' LIMIT 1 ;"
													
		local query = mysql_query(g_mysql["connection"], sql)
		if query then mysql_free_result(query) end			
			
		table.remove(wantedSaveTable,1)
		if wantedSaveTable[i] and timer == true then theSaveTimer = setTimer(saveWantedTimer, 50,1) end
	end
end