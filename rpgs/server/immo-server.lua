--[[
Project: VitaOnline
File: immo-server.lua
Author(s):	Sebihunter
]]--

local loadedInteriors = 0

function loadAllRootRPGHouses()
	if mysql_ping ( g_mysql["connection"] ) == false then
		onResourceStopMysqlEnd()
		onResourceStartMysqlConnection()
	end	
	
	local result = mysql_query(g_mysql["connection"], "SELECT * FROM `houses` ORDER BY `id` ASC")
	if result then
		local hses = 0
		while true do
			local row = mysql_fetch_assoc(result)
			if not row then break end
			
			local x = tonumber(row["x"])
			local y = tonumber(row["y"])
			local z = tonumber(row["z"])
			local ix = tonumber(row["ix"])
			local iy = tonumber(row["iy"])
			local iz = tonumber(row["iz"])
			local ii = tonumber(row["ii"])
			local id = tonumber(row["idd"])
			local preis = tonumber(row["preis"])
			local miete = tonumber(row["miete"])
			local owner = row["owner"]
			local keys = row["keys"]
			local locked = row["locked"]
			local lastjoin = tonumber(row["lastjoin"])
				
			--Erstelle Eingangspickup
			local pickup
			if owner == "Niemand" then
				pickup = createPickup ( x, y, z , 3, 1273, 0 )
			elseif owner == "SASO" then
				pickup = createPickup ( x, y, z , 3, 1272, 0 )
			else
				pickup = createPickup ( x, y, z , 3, 1277, 0 )
			end
			setElementData(pickup, "mysqlID", tonumber(row["id"]))
			setElementData(pickup, "intID", id)
			setElementData(pickup, "intType", 1)
			setElementData(pickup, "preis", preis)
			setElementData(pickup, "miete", miete)
			setElementData(pickup, "owner", owner)
			setElementData(pickup, "keys", keys)
			setElementData(pickup, "lastjoin", lastjoin)
			
			if locked == "true" then
				setElementData(pickup, "locked", true)
			else
				setElementData(pickup, "locked", false)
			end
				
			--Erstelle Ausgangspickup
			local intpickup = createPickup ( ix, iy, iz , 3, 1273, 0 )
			setElementInterior(intpickup, ii)
			setElementDimension(intpickup, id)
			setElementData(intpickup, "intType", 2)
			
			--Erstelle Verbindung zwischen Pickups
			setElementData(pickup, "ref", intpickup)
			setElementData(intpickup, "ref", pickup)			
			
			--Schauen, ob Haus nach 2 Monaten frei gemacht werden soll
			if owner ~= "Niemand" and ((lastjoin + 2678400*2) > getRealTime().timestamp) then
				setElementData(pickup, "keys", "Niemand")
				setElementData(pickup, "owner", "Niemand")
			end	
			hses = hses+1
			loadedInteriors = loadedInteriors+1
		end
		mysql_free_result(result)
		print("__~~*"..tonumber(hses).."*Houses/s*Loaded!*~~__")
		setTimer(saveAllRootRPGHouses, 1800030, 0, true)
	else
		print("__~~*Failed to load Houses*~~__")
	end	
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), loadAllRootRPGHouses)

local immoSaveTable = {}
local theSaveTimer
function saveAllRootRPGHouses(timer)
	if timer ~= true then timer = false else timer = true end
	if #immoSaveTable > 0 and timer == true then return end
	if theSaveTimer and isTimer(theSaveTimer) then killTimer(theSaveTimer) end
	immoSaveTable = {}
	for _, house in ipairs(getElementsByType("pickup")) do
		if getElementData(house, "intType") == 1 then
			local mid = getElementData(house, "mysqlID")
			
			local intpickup = getElementData(house, "ref")
			local x, y, z = getElementPosition(house)
			local ix, iy, iz = getElementPosition(intpickup)
			local ii = getElementInterior(intpickup)
			local idd = getElementDimension(intpickup)
			
			immoSaveTable[#immoSaveTable+1] = {}
			immoSaveTable[#immoSaveTable].house = house
			immoSaveTable[#immoSaveTable].mid = mid
			immoSaveTable[#immoSaveTable].x = tostring(math.round(x, 5))
			immoSaveTable[#immoSaveTable].y = tostring(math.round(y, 5))
			immoSaveTable[#immoSaveTable].z = tostring(math.round(z, 5))
			immoSaveTable[#immoSaveTable].ix = tostring(math.round(ix, 5))
			immoSaveTable[#immoSaveTable].iy = tostring(math.round(iy, 5))
			immoSaveTable[#immoSaveTable].iz = tostring(math.round(iz, 5))
			immoSaveTable[#immoSaveTable].ii = tostring(ii)
			immoSaveTable[#immoSaveTable].idd = tostring(idd)
			immoSaveTable[#immoSaveTable].preis = tostring(getElementData(house, "preis"))
			immoSaveTable[#immoSaveTable].owner = tostring(getElementData(house, "owner"))
			immoSaveTable[#immoSaveTable].miete = tostring(getElementData(house, "miete"))
			immoSaveTable[#immoSaveTable].keys = tostring(getElementData(house, "keys"))
			immoSaveTable[#immoSaveTable].locked = tostring(getElementData(house, "locked"))
		end
	end
	if timer == true then
		saveImmoTimer(timer)
	else
		for i = 1, #immoSaveTable do
			saveImmoTimer(timer)
		end
	end
end		
addEventHandler("onResourceStop", getResourceRootElement(getThisResource()),saveAllRootRPGHouses)

function saveImmoTimer(timer)
	local i = 1
	if immoSaveTable[i] then
		if mysql_ping ( g_mysql["connection"] ) == false then
			onResourceStopMysqlEnd()
			onResourceStartMysqlConnection()
		end
			
		if not immoSaveTable[i].mid then
			mysql_query(g_mysql["connection"], "INSERT INTO `houses` (`locked`) VALUES ('false');")
	
			local temp = mysql_query(g_mysql["connection"], "SELECT LAST_INSERT_ID(id) AS last FROM houses ORDER BY id DESC LIMIT 1;")
			immoSaveTable[i].mid = mysql_insert_id(g_mysql["connection"])
			mysql_free_result(temp)
			setElementData(immoSaveTable[i].house, "mysqlID", immoSaveTable[i].mid)
		end	
			
		local sql = "UPDATE `houses` SET `locked` = '"..immoSaveTable[i].locked.."',\
													`x` = '"..immoSaveTable[i].x.."',\
													`y` = '"..immoSaveTable[i].y.."',\
													`z` = '"..immoSaveTable[i].z.."',\
													`ix` = '"..immoSaveTable[i].ix.."',\
													`iy` = '"..immoSaveTable[i].iy.."',\
													`iz` = '"..immoSaveTable[i].iz.."',\
													`ii` = '"..immoSaveTable[i].ii.."',\
													`idd` = '"..immoSaveTable[i].idd.."',\
													`preis` = '"..immoSaveTable[i].preis.."',\
													`miete` = '"..immoSaveTable[i].miete.."',\
													`owner` = '"..immoSaveTable[i].owner.."',\
													`keys` = '"..immoSaveTable[i].keys.."'\
											WHERE `id` = '"..tostring(immoSaveTable[i].mid).."' LIMIT 1 ;"
													
												
		local query = mysql_query(g_mysql["connection"], sql)
		if query then mysql_free_result(query) end			
			
		table.remove(immoSaveTable,1)
		if immoSaveTable[i] and timer == true then theSaveTimer = setTimer(saveImmoTimer, 50,1, true) end
	end
end

function refreshHousePickup(pick)
	local owner = getElementData(pick, "owner")
	if owner == "Niemand" then
		setPickupType ( pick, 3, 1273, 0 )
	elseif owner == "SASO" then
		setPickupType ( pick, 3, 1272, 0 )
	else
		setPickupType ( pick, 3, 1277, 0 )
	end

end

function useHausExit(ply)
	local posX, posY, posZ = getElementPosition(ply)
	local chatSphere = createColSphere( posX, posY, posZ, 3 )
	local nearbyPlayers = getElementsWithinColShape( chatSphere, "pickup" )
	for i,v in pairs(nearbyPlayers) do
		if getElementData(v, "intType") == 2 and getElementDimension(v) == getElementDimension(ply) and getElementInterior(v) == getElementInterior(ply) then
			local x, y, z = getElementPosition(getElementData(v, "ref"))
			local int = getElementInterior(getElementData(v, "ref"))
			local dim = getElementDimension(getElementData(v, "ref"))
			setElementPosition(ply, x, y, z)
			setElementInterior(ply, int)
			setElementDimension(ply, dim)
			break
		end
	end
end

function houseEnter ( ply )
	if getElementData(source, "intType") == 1 then
		if getElementData(source, "owner") == "Niemand" then
			callClientFunction( ply, "showImmo1", source )
		else
			callClientFunction( ply, "showImmo2", source )
		end
    elseif getElementData(source, "intType") == 2 then
		--[[local x, y, z = getElementPosition(getElementData(source, "ref"))
		local int = getElementInterior(getElementData(source, "ref"))
		local dim = getElementDimension(getElementData(source, "ref"))
		setElementPosition(ply, x, y, z)
		setElementInterior(ply, int)
		setElementDimension(ply, dim)]]
	end
end
addEventHandler ( "onPickupUse", getRootElement(), houseEnter )

function isHouseOwner(ply, ownerstring)
	local ownerTable = split(ownerstring, string.byte(','))
	for k,v in ipairs(ownerTable) do
		if v == getPlayerName(ply) then
			return true
		end
	end
	return false
end

function checkPlayerNumber(ownerstring)
	local int = 0
	local ownerTable = split(ownerstring, string.byte(','))
	for k,v in ipairs(ownerTable) do
		int = int+1
	end
	if int > 4 then return false end
	return true
end

function lockHouse(player, command, houseid, owner)
	for _, house in ipairs(getElementsByType("pickup")) do
		local playerx, playery,playerz = getElementPosition ( player )
		local hitedx,hittedy,hittedz = getElementPosition(house)
		if getElementData(house, "intType") == 1 then
			if (getDistanceBetweenPoints3D(hitedx,hittedy,hittedz, playerx, playery,playerz) < 5) and (isHouseOwner(player, getElementData(house, "keys")) == true or isHouseOwner(player, getElementData(house, "owner")) == true) and (getElementInterior(player) == getElementInterior(house)) and (getElementDimension(player) == getElementDimension(house)) then
				if getElementData(house, "locked") == true then
					outputChatBox("Haus aufgesperrt.",player,0,255,0)
					setElementData(house, "locked", false)
				else
					outputChatBox("Haus abgesperrt.",player,0,255,0)
					setElementData(house, "locked", true)
				end
			end
		elseif getElementData(house, "intType") == 2 then
			if (getDistanceBetweenPoints3D(hitedx,hittedy,hittedz, playerx, playery,playerz) < 5) and (isHouseOwner(player, getElementData(getElementData(house, "ref"), "keys")) == true or isHouseOwner(player, getElementData(getElementData(house, "ref"), "owner")) == true) and (getElementInterior(player) == getElementInterior(house)) and (getElementDimension(player) == getElementDimension(house)) then
				if getElementData(getElementData(house, "ref"), "locked") == true then
					outputChatBox("Haus aufgesperrt.",player,0,255,0)
					setElementData(getElementData(house, "ref"), "locked", false)
				else
					outputChatBox("Haus abgesperrt.",player,0,255,0)
					setElementData(getElementData(house, "ref"), "locked", true)
				end
			end
		end
	end
end
addCommandHandler("schluessel", lockHouse)

function createHouse(ply, command)
	if getElementData(ply, "job") == 6 or getElementData(ply, "getPlayerSpecialRights") == 1 or getElementData(ply, "getPlayerSpecialRights") == 2 then
		local x, y, z = getElementPosition(ply)
		local pickup = createPickup ( x, y, z, 3, 1273, 0 )
		setElementData(pickup, "intID", loadedInteriors)
		setElementData(pickup, "intType", 1)
		setElementData(pickup, "preis", "0")	
		setElementData(pickup, "miete", "0")
		setElementData(pickup, "owner", "Niemand")		
		setElementData(pickup, "keys", "Niemand")
		setElementData(pickup, "locked", true)	
		
		local intpickup = createPickup ( 223.0525,1287.3276,1082.1406 , 3, 1273, 0 )
		setElementInterior(intpickup, 1)
		setElementDimension(intpickup, loadedInteriors)
		setElementData(intpickup, "intType", 2)
		setElementData(pickup, "ref", intpickup)
		setElementData(intpickup, "ref", pickup)
		
		pLogger["einsperren"]:addEntry(getPlayerName(ply).." hat ein Haus (ID: "..tostring(loadedInteriors)..") in "..getElementZoneName(ply).." erstellt.")
		
		loadedInteriors = loadedInteriors+1		
	end	
end
addCommandHandler("haus",createHouse)

function rentHouse(ply, atHouse)
	local acc = getBankAccount(getPlayerName(ply))
	if hasPlayerBankAccess(ply, acc) then
		if getPlayerMoneyEx(ply) >= getElementData(atHouse, "miete") then
			outputChatBox("Haus gemietet. Die erste Miete wurde von deinem Bargeld abgezogen.", ply, 0,255,0)
			outputChatBox("Die Miete ist jeden Freitag um 20 Uhr fällig und wird automatisch abgebucht.", ply, 125,125,125)
			takePlayerMoneyEx(ply, getElementData(atHouse, "miete"))
			setElementData(atHouse, "owner", "SASO")
			setElementData(atHouse, "keys", getPlayerName(ply))
			refreshHousePickup(atHouse)
			callClientFunction( ply, "closeImmo1" )
			callClientFunction( ply, "showImmo2", atHouse )
		else
			callClientFunction( ply, "guiSetText", HausGUI_1_Label[6], "Fehler: Zu wenig Geld auf der Hand." )
		end
	else
		callClientFunction( ply, "guiSetText", HausGUI_1_Label[6], "Fehler: Du brauchst ein Bankkonto." )
		callClientFunction( ply, "guiSetVisible", HausGUI_1_Label[6], true )
	end
end

function stopHouseRent(player, command, houseid)
	if houseid ~= "" and houseid ~= nil then
		for _, house in ipairs(getElementsByType("pickup")) do
			if getElementData(house, "intID") == tonumber(houseid) then
				if getElementData(house, "owner") == "SASO" and getElementData(house, "keys") == getPlayerName(player) then
					outputChatBox("Miete wurde erfolgreich beendet.", player, 0,255,0)
					setElementData(house, "owner", "Niemand")
					setElementData(house, "keys", "Niemand")
					callClientFunction( player, "closeImmo1" )
					callClientFunction( player, "closeImmo2" )
					refreshHousePickup(house)
				end
			end
		end
	end
end
addCommandHandler("stopmiete", stopHouseRent)

function sellHouse(player, command, houseid)
	if houseid ~= "" and houseid ~= nil then
		for _, house in ipairs(getElementsByType("pickup")) do
			if getElementData(house, "intID") == tonumber(houseid) then
				if getElementData(house, "owner") == getPlayerName(player) then
					outputChatBox("Dein Haus wurde für 80% des Kaufpreises verkauft", player, 0,255,0)
					setElementData(house, "owner", "Niemand")
					setElementData(house, "keys", "Niemand")
					callClientFunction( player, "closeImmo1" )
					callClientFunction( player, "closeImmo2" )
					givePlayerMoneyEx(player, tonumber(math.ceil(getElementData(house, "preis"))*0.8))
					refreshHousePickup(house)
				end
			end
		end
	end
end
addCommandHandler("verkaufehaus", sellHouse)

function moveHouse(player, command, houseid)
	if getElementData(player, "job") == 6 or getElementData(player, "getPlayerSpecialRights") == 1 or getElementData(player, "getPlayerSpecialRights") == 2 then
		if houseid ~= "" and houseid ~= nil then
			for _, house in ipairs(getElementsByType("pickup")) do
				if getElementData(house, "intType") == 1 then
					if getElementData(house, "intID") == tonumber(houseid) then
						local x,y,z = getElementPosition(player)
						setElementPosition(house, x,y,z)
					end
				end
			end
		else
			outputChatBox("Fehler: /hausverlegen [HausID]",player,255,0,0)
		end
	end
end
addCommandHandler("hausverlegen", moveHouse)

function changeHouseOwner(player, command, houseid, owner)
	if getElementData(player, "job") == 6 or getElementData(player, "getPlayerSpecialRights") == 1 or getElementData(player, "getPlayerSpecialRights") == 2 then
		if houseid ~= "" and houseid ~= nil and owner ~= "" and owner ~= nil  then
			for _, house in ipairs(getElementsByType("pickup")) do
				if getElementData(house, "intType") == 1 then
					if getElementData(house, "intID") == tonumber(houseid) then
						setElementData(house, "owner", tostring(owner))
						refreshHousePickup(house)
					end
				end
			end
		else
			outputChatBox("Fehler: /besitzer [HausID] [Besitzer]",player,255,0,0)
		end
	end
end
addCommandHandler("besitzer", changeHouseOwner)

function changeHouseBesitzer(player, command, houseid, keys)
	if houseid ~= "" and houseid ~= nil and keys ~= "" and keys ~= nil  then
		for _, house in ipairs(getElementsByType("pickup")) do
			if getElementData(house, "intType") == 1 then
				if getElementData(house, "intID") == tonumber(houseid) then
					if getElementData(house, "owner") == getPlayerName(player) then
						local ply2 = getPlayerFromName(keys)
						if not ply2 then outputChatBox("Der Spieler konnte nicht online gefunden werden.",player,255,0,0) return end
						setElementData(house, "owner", getPlayerName(ply2))
						refreshHousePickup(house)
					end	
				end
			end
		end
	else
		outputChatBox("Fehler: /setbesitzer [HausID] [Neuer Besitzer]",player,255,0,0)
	end
end
addCommandHandler("setbesitzer", changeHouseBesitzer)

function changeHouseKeys(player, command, houseid, keys)
	if houseid ~= "" and houseid ~= nil and keys ~= "" and keys ~= nil  then
		for _, house in ipairs(getElementsByType("pickup")) do
			if getElementData(house, "intType") == 1 then
				if getElementData(house, "intID") == tonumber(houseid) then
					if getElementData(house, "owner") == getPlayerName(player) then
						if checkPlayerNumber(keys) == true then
							setElementData(house, "keys", tostring(keys))
							refreshHousePickup(house)
						else
							outputChatBox("Du darfst nur maximal 4 Personen den Schlüssel geben.",player,255,0,0)
						end
					end	
				end
			end
		end
	else
		outputChatBox("Fehler: /setschluessel [HausID] [Schluesselbesitzer, Schluessel...]",player,255,0,0)
	end
end
addCommandHandler("setschluessel", changeHouseKeys)

function changeHousePrice(player, command, houseid, miete)
	if getElementData(player, "job") == 6 or getElementData(player, "getPlayerSpecialRights") == 1 or getElementData(player, "getPlayerSpecialRights") == 2 then
		if houseid ~= "" and houseid ~= nil and miete ~= "" and miete ~= nil  then
			for _, house in ipairs(getElementsByType("pickup")) do
				if getElementData(house, "intType") == 1 then
					if getElementData(house, "intID") == tonumber(houseid) then
						setElementData(house, "preis", tonumber(miete))
					end
				end
			end
		else
			outputChatBox("Fehler: /preis [HausID] [Preis]",player,255,0,0)
		end
	end
end
addCommandHandler("preis", changeHousePrice)

function changeHouseRent(player, command, houseid, miete)
	if getElementData(player, "job") == 6 or getElementData(player, "getPlayerSpecialRights") == 1 or getElementData(player, "getPlayerSpecialRights") == 2 then
		if houseid ~= "" and houseid ~= nil and miete ~= "" and miete ~= nil  then
			for _, house in ipairs(getElementsByType("pickup")) do
				if getElementData(house, "intType") == 1 then
					if getElementData(house, "intID") == tonumber(houseid) then
						setElementData(house, "miete", tonumber(miete))
					end
				end
			end
		else
			outputChatBox("Fehler: /miete [HausID] [Miete pro Woche]",player,255,0,0)
		end
	end
end
addCommandHandler("miete", changeHouseRent)

function showIntList(ply, command)
	if getElementData(player, "job") == 6 or getElementData(ply, "getPlayerSpecialRights") == 1 or getElementData(ply, "getPlayerSpecialRights") == 2 then
		outputChatBox("***Interiors***",ply,0,255,255)
		outputChatBox("Klein: 4, 7, 12, 13",ply,255,255,255)
		outputChatBox("Mittel: 1, 2, 6, 8, 10",ply,255,255,255)
		outputChatBox("Groß: 3, 5, 9, 11",ply,255,255,255)
	end	
end
addCommandHandler("intliste",showIntList)


function changeHouseInt(player, command, houseid, int)
	if getElementData(player, "job") == 6 or getElementData(player, "getPlayerSpecialRights") == 1 or getElementData(player, "getPlayerSpecialRights") == 2 then
		if houseid ~= "" and houseid ~= nil and int ~= "" and int ~= nil  then
			for _, house in ipairs(getElementsByType("pickup")) do
				if getElementData(house, "intType") == 1 then
					if getElementData(house, "intID") == tonumber(houseid) then
						int = tonumber(int)
						local intpickup = getElementData(house, "ref")
						if int >= 0 and int <= 13 then
							if int == 1 then
								setElementPosition(intpickup, 2195.7532, -1204.3674, 1049.0234)
								setElementInterior(intpickup, 6)
								outputChatBox("Interior erfolgreich geändert.",player,0,255,0)
							end
							if int == 2 then
								setElementPosition(intpickup, 2269.2061, -1210.5090, 1047.5625)
								setElementInterior(intpickup, 10)
								outputChatBox("Interior erfolgreich geändert.",player,0,255,0)
							end		
							if int == 3 then
								setElementPosition(intpickup, 235.4232, 1186.9608, 1080.2578)
								setElementInterior(intpickup, 3)
								outputChatBox("Interior erfolgreich geändert.",player,0,255,0)
							end			
							if int == 4 then
								setElementPosition(intpickup, 223.1880, 1288.3348, 1082.1406)
								setElementInterior(intpickup, 1)
								outputChatBox("Interior erfolgreich geändert.",player,0,255,0)
							end		
							if int == 5 then
								setElementPosition(intpickup, 225.4194, 1021.8854, 1084.0165)
								setElementInterior(intpickup, 7)
								outputChatBox("Interior erfolgreich geändert.",player,0,255,0)
							end				
							if int == 6 then
								setElementPosition(intpickup, 295.0987, 1473.3938, 1080.2578)
								setElementInterior(intpickup, 15)
								outputChatBox("Interior erfolgreich geändert.",player,0,255,0)
							end	
							if int == 7 then
								setElementPosition(intpickup, 328.2560, 1478.0437, 1084.4375)
								setElementInterior(intpickup, 15)
								outputChatBox("Interior erfolgreich geändert.",player,0,255,0)
							end			
							if int == 8 then
								setElementPosition(intpickup, 447.1555, 1397.7323, 1084.3047)
								setElementInterior(intpickup, 2)
								outputChatBox("Interior erfolgreich geändert.",player,0,255,0)
							end	
							if int == 9 then
								setElementPosition(intpickup, 227.0200, 1114.3785, 1080.9966)
								setElementInterior(intpickup, 5)
								outputChatBox("Interior erfolgreich geändert.",player,0,255,0)
							end				
							if int == 10 then
								setElementPosition(intpickup, 261.1383, 1285.4542, 1080.2578)
								setElementInterior(intpickup, 4)
								outputChatBox("Interior erfolgreich geändert.",player,0,255,0)
							end		
							if int == 11 then
								setElementPosition(intpickup, 234.4033, 1064.0447, 1084.2118)
								setElementInterior(intpickup, 6)
								outputChatBox("Interior erfolgreich geändert.",player,0,255,0)
							end		
							if int == 12 then
								setElementPosition(intpickup, -68.6160, 1353.0022, 1080.2109)
								setElementInterior(intpickup, 6)
								outputChatBox("Interior erfolgreich geändert.",player,0,255,0)
							end
							if int == 13 then
								setElementPosition(intpickup, 260.7870, 1237.7090, -1084.2578)
								setElementInterior(intpickup, 9)
								outputChatBox("Interior erfolgreich geändert.",player,0,255,0)
							end	
						else
							outputChatBox("Dieses Interior existiert nicht. (Benutze: /intliste)",player,255,0,0)
						end
					end
				end
			end
		else
			outputChatBox("Fehler: /changeint [HausID] [Interior]",player,255,0,0)
		end
	end
end
addCommandHandler("changeint", changeHouseInt)