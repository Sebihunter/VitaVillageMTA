--[[
Project: VitaOnline
File: jobs-server.lua
Author(s):	Sebihunter
]]--

theRPGPlayerSettingsFirma = {}
--Jobs definiert in utils shared
function isAtSecondPickup(ply)
	if getElementData(ply, "job") == 4 then
		local px, py, pz = getElementPosition(ply)
		if getDistanceBetweenPoints2D ( px, py, -1505.9951171875, 707.9970703125 ) < 5.0 or getDistanceBetweenPoints2D ( px, py, 84.414,-149.597 ) < 5.0 then
			return true
		else
			return false
		end	
	elseif getElementData(ply, "job") == 3 then	
		local px, py, pz = getElementPosition(ply)
		if getDistanceBetweenPoints2D ( px, py, 327.099609375, 307.2998046875 ) < 5.0 or getDistanceBetweenPoints2D ( px, py, 2829.3000488281, 955.90002441406 ) < 5.0  then
			return true
		else
			return false
		end			
	elseif getElementData(ply, "job") == 7 then
		local px, py, pz = getElementPosition(ply)
		if getDistanceBetweenPoints2D ( px, py, -2025.38806,66.8615 ) < 5.0 or getDistanceBetweenPoints2D ( px, py, 2657.400390625, 1202.7001953125 ) < 5.0  then
			return true
		else
			return false
		end		
	else
		return false
	end
end

local antiJobSpam = {}
function jobPickupUse( ply )
	if antiJobSpam[ply] == true then
		triggerClientEvent ( ply, "addNotification", getRootElement(), 1, 255,0,0, "Du musst kurz warten, um deinen Dienst erneut zu beginnen/beenden." )
		return
	end
	for job = 1, #gJobData do
		local px, py, pz = getElementPosition(ply)
		if (getDistanceBetweenPoints2D ( px, py, gJobData[job].px, gJobData[job].py ) < 5.0) or (isAtSecondPickup(ply) == true) then
			if getElementData(ply, "job") == job then
				antiJobSpam[ply] = true
				setTimer(function(ply) antiJobSpam[ply] = nil end, 10000, 1, ply)
				if getElementData(ply, "dienst") == 0 then
					if getElementData(ply, "rank") == 0 then
						setElementModel ( ply, gJobData[job].skin0 )
					elseif getElementData(ply, "rank") == 1 then
						setElementModel ( ply, gJobData[job].skin1 )
					elseif getElementData(ply, "rank") == 2 then
						setElementModel ( ply, gJobData[job].skin2 )
					end
					setElementData(ply, "dienst", 1)
					outputChatBox (getPlayerName(ply) .." beginnt seinen Dienst als "..tostring(gJobData[job].name)..".",getRootElement(),0,255,255)
					if job == 3 then
						giveWeapon(ply,3,1,true)
						giveWeapon(ply,17,99999)
						giveWeapon(ply,24,99999)
						giveWeapon(ply,29,99999)
						giveWeapon(ply,45,99999)
						setPedArmor(ply, 100)
						if gJailbreakBlip then
							setElementVisibleTo(gJailbreakBlip, ply, true)
						end						
					elseif job == 7 then
						giveWeapon(ply,42, 99999)
						giveWeapon(ply,9, 99999)
					elseif job == 9 then
						giveWeapon(ply,43,99999)
					end
				else
					setElementModel ( ply, getElementData(ply, "skin") )
					setElementData(ply, "dienst", 0)
					if job == 3 then
						setPedArmor(ply, 0)
						takeWeapon(ply,3)
						takeWeapon(ply,17)
						takeWeapon(ply,24)
						takeWeapon(ply,29)
						takeWeapon(ply, 45)
						if gJailbreakBlip then
							setElementVisibleTo(gJailbreakBlip, ply, false)
						end
					elseif job == 7 then
						takeWeapon(ply, 42 )
						takeWeapon(ply, 9 )
					elseif job == 9 then
						takeWeapon(ply,43)
					end
					outputChatBox (getPlayerName(ply) .." beendet seinen Dienst als "..tostring(gJobData[job].name)..".",getRootElement(),0,255,255)
				end
			else
				if (isAtSecondPickup(ply) == false) then
					triggerClientEvent ( ply, "addNotification", getRootElement(), 1, 255,0,0, "Du kannst dich hier nicht umziehen:\nAnderer Arbeitgeber." )
				end	
			end
		end
	end
end

callAccepters = {}
function initJobs()	
	for job = 1, #gJobData do
		callAccepters[job] = {}
		-- Team erstellen
		gJobTeams[job] = createTeam("Team"..tostring(job))	
		--Erstelle Pickup
		local pickup = createPickup ( gJobData[job].px, gJobData[job].py, gJobData[job].pz, 3, 1275, 1)
		if job == 4 then --ADAC
			local pickup2 = createPickup ( -1505.9951171875, 707.9970703125, 7.1875, 3, 1275, 1)
			addEventHandler ( "onPickupUse", pickup2, jobPickupUse)
			
			local pickup3 = createPickup ( 84.414,-149.597,2.5842, 3, 1275, 1)
			addEventHandler ( "onPickupUse", pickup3, jobPickupUse)			

		elseif job == 3 then --Polizei
			setElementInterior(pickup, 3)
			
			local pickup1 = createPickup ( 327.099609375, 307.2998046875, 999.20001220703, 3, 1275, 1)
			setElementInterior(pickup1, 5)
			addEventHandler ( "onPickupUse", pickup1, jobPickupUse)			
		elseif job == 6 then --Beamter
			setElementInterior(pickup, 3)
		elseif job == 7 then --Rettungsdienst
			setElementInterior(pickup, 3)
			local pickup1 = createPickup ( -2025.38806,66.8615,28.467, 3, 1275, 1)
			addEventHandler ( "onPickupUse", pickup1, jobPickupUse)
			pickup1 = createPickup (2657.400390625, 1202.7001953125, 10.5, 3, 1275, 1)
			addEventHandler ( "onPickupUse", pickup1, jobPickupUse)
		elseif job == 9 then
			setElementInterior(pickup, 3)
		end		
		
		if gJobData[job].bankname then
			--Erstelle Bankkonto wenn nicht schon erstellt
			if getBankAccount( gJobData[job].bankname) == nil then
				createBankAccount( gJobData[job].bankname, 1, 0)
			end		
		end
		--Erstelle FirmenXML wenn nicht schon erstellt
		local xml = xmlLoadFile("./xml/firmen/"..tostring(job)..".xml")
		if not xml then
			local xmlAdded = xmlCreateFile ( "./xml/firmen/"..tostring(job)..".xml", "data" )
			if(xmlAdded) then
				xmlSaveFile(xmlAdded)
				xmlUnloadFile(xmlAdded)
			end
		end
		addEventHandler ( "onPickupUse", pickup, jobPickupUse)
	end
end

function checkIfVehicleFK(veh, money)
	if getVehFK(source) == "1" and getElementData(source, "dienst") == 1 and getElementData(veh, "owner") == tostring(getElementData(source, "job")) then
		givePlayerMoneyEx(source, money)
		systemWithdraw((getElementData(source, "job")), money, "Tankrefundierung "..getPlayerName(source))
		triggerClientEvent ( source, "addNotification", getRootElement(), 3, 255,255,0, "Firmenfahrzeug aufgetankt:\nGeld ("..money.." Vero) wurde refundiert." )
	end
end
addEvent( "checkIfVehicleFK", true )
addEventHandler( "checkIfVehicleFK", getRootElement(), checkIfVehicleFK ) -- Bound to this resource only, saves on CPU usage.

function getFirmaBewerbungen(ply)
	local bewerbungentable = {}
		for i = 1, #gJobData do
		local xml = xmlLoadFile("./xml/firmen/"..tostring(i)..".xml")
		if xml then
			local text = xmlFindChild ( xml, "bewerbung",0 )
			if not text then
				text = xmlCreateChild ( xml, "bewerbung" )
				xmlNodeSetValue(text,"0")
			end
			local dat = xmlNodeGetValue(text)
			xmlSaveFile(xml)
			xmlUnloadFile(xml)
			bewerbungentable[i] = dat
		end
	end
	triggerLatentClientEvent ( ply, "receiveBewerbungen", 50000, false, ply, bewerbungentable)
end

function getFirmaBewerbung(ply)
	local xml = xmlLoadFile("./xml/firmen/"..tostring(getElementData(ply, "job"))..".xml")
	if xml then
		local text = xmlFindChild ( xml, "bewerbung",0 )
		if not text then
			text = xmlCreateChild ( xml, "bewerbung" )
			xmlNodeSetValue(text,"0")
		end
		local dat = xmlNodeGetValue(text)
		xmlSaveFile(xml)
		xmlUnloadFile(xml)
		return dat
	end
end

function setFirmaBewerbung(ply)
	local xml = xmlLoadFile("./xml/firmen/"..tostring(getElementData(ply, "job"))..".xml")
	if xml then
		local textnode = xmlFindChild ( xml, "bewerbung",0 )
		if textnode then
			if xmlNodeGetValue(textnode) == "0" then
				xmlNodeSetValue(textnode, "1")
				triggerClientEvent ( ply, "addNotification", getRootElement(), 2, 0,255,0, "Bewerbungsstatus:\nEin" )
			else
				triggerClientEvent ( ply, "addNotification", getRootElement(), 2, 0,255,0, "Bewerbungsstatus:\nAus" )
				xmlNodeSetValue(textnode, "0")
			end
		else
			textnode = xmlCreateChild ( xml, "bewerbung" )
			xmlNodeSetValue(textnode,"0")
			triggerClientEvent ( ply, "addNotification", getRootElement(), 2, 0,255,0, "Bewerbungsstatus:\nAus" )	
		end
		xmlSaveFile(xml)
		xmlUnloadFile(xml)		
	end
end

function getVehFK(ply)
	local xml = xmlLoadFile("./xml/firmen/"..tostring(getElementData(ply, "job"))..".xml")
	if xml then
		local text = xmlFindChild ( xml, "vehfk",0 )
		if not text then
			text = xmlCreateChild ( xml, "vehfk" )
			xmlNodeSetValue(text,"0")
		end
		local dat = xmlNodeGetValue(text)
		xmlSaveFile(xml)
		xmlUnloadFile(xml)
		return dat
	end
end

function setVehFK(ply)
	local xml = xmlLoadFile("./xml/firmen/"..tostring(getElementData(ply, "job"))..".xml")
	if xml then
		local textnode = xmlFindChild ( xml, "vehfk",0 )
		if textnode then
			if xmlNodeGetValue(textnode) == "0" then
				xmlNodeSetValue(textnode, "1")
				triggerClientEvent ( ply, "addNotification", getRootElement(), 2, 0,255,0, "Reparatur und Tanken auf Firmenkonto:\nEin" )
			else
				triggerClientEvent ( ply, "addNotification", getRootElement(), 2, 0,255,0, "Reparatur und Tanken auf Firmenkonto:\nAus" )
				xmlNodeSetValue(textnode, "0")
			end
		else
			textnode = xmlCreateChild ( xml, "vehfk" )
			xmlNodeSetValue(textnode,"0")
			triggerClientEvent ( ply, "addNotification", getRootElement(), 2, 0,255,0, "Reparatur und Tanken auf Firmenkonto:\nAus" )	
		end
		xmlSaveFile(xml)
		xmlUnloadFile(xml)		
	end
end
function sendJobNoteToPlayer(ply)
	local xml = xmlLoadFile("./xml/firmen/"..tostring(getElementData(ply, "job"))..".xml")
	if xml then
		local text = xmlFindChild ( xml, "text",0 )
		if not text then
			text = xmlCreateChild ( xml, "text" )
			xmlNodeSetValue(text,"Keine")
		end
		callClientFunction(ply, "recieveJobNote", xmlNodeGetValue(text))
		xmlSaveFile(xml)
		xmlUnloadFile(xml)
	end
end

function saveJobNote(ply, text)
	local xml = xmlLoadFile("./xml/firmen/"..tostring(getElementData(ply, "job"))..".xml")
	if xml then
		local textnode = xmlFindChild ( xml, "text",0 )
		xmlNodeSetValue(textnode, tostring(text))
		xmlSaveFile(xml)
		xmlUnloadFile(xml)		
	end
end

function getFirmenPlayers(source)

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
					
				theRPGPlayerSettingsFirma[i] = {}
				theRPGPlayerSettingsFirma[i]["name"] = row["name"]	
				local ply = getPlayerFromName(theRPGPlayerSettingsFirma[i]["name"])
				if ply then
					theRPGPlayerSettingsFirma[i]["dienstzeit"] = getElementData(ply, "dienstzeit")
					theRPGPlayerSettingsFirma[i]["gehalt"] = getElementData(ply, "gehalt")
					theRPGPlayerSettingsFirma[i]["einnahmen"] = getElementData(ply, "einnahmen")
					theRPGPlayerSettingsFirma[i]["einnahmen2"] = getElementData(ply, "einnahmen2")
					theRPGPlayerSettingsFirma[i]["job"] = getElementData(ply, "job")	
					theRPGPlayerSettingsFirma[i]["rank"] = getElementData(ply, "rank")						
				else
					theRPGPlayerSettingsFirma[i]["dienstzeit"] = row["dienstzeit"]
					theRPGPlayerSettingsFirma[i]["gehalt"] = row["gehalt"]
					theRPGPlayerSettingsFirma[i]["einnahmen"] = row["einnahmen"]
					theRPGPlayerSettingsFirma[i]["einnahmen2"] = row["einnahmen2"]
					theRPGPlayerSettingsFirma[i]["job"] = row["job"]
					theRPGPlayerSettingsFirma[i]["rank"] = row["rank"]
				end
				i = i+1
			end
			mysql_free_result(result)		
		end
		callClientFunction(source, "recieveFirmenPlayers", theRPGPlayerSettingsFirma)
end

function DienstTimer()
	local players = getElementsByType("player")
	for _,v in pairs(players) do
		if getElementData(v, "isPlayerLoggedIn") == true and getElementData(v, "afk") ~= true and getElementData(v, "dienst") == 1 and getElementData(v, "einsperrzeit") == 0 then
			setElementData(v, "dienstzeit", getElementData(v, "dienstzeit")+1)
			setElementData(v, "exp", getElementData(v, "exp")+15)
		end
	end
end

function removeFromJobVeh(id, playername)
	if id and playername then
		for i,v in ipairs(getElementsByType("vehicle")) do
			if getElementData(v, "owner") == tostring(id) then
				local keys = getElementData(v, "keys")
				if string.find(keys, ","..playername) then
					keys = string.gsub(keys, ","..playername, "")
				else
					keys = string.gsub(keys, playername, "")
				end
				setElementData(v, "keys", keys)
			end
		end
	end
end

function quitJob ( source, commandName)
	if getElementData(source, "job") ~= 0 then
		if getElementData(source, "dienst") == 0 then
			removeFromJobVeh(getElementData(source, "job"), getPlayerName(source))
			outputChatBox("Du hast deinen Job erfolgreich gekündigt.",source,0,255,0)
			setElementData(source, "job", 0)
			setPlayerTeam(source, nil)
			setElementData(source, "rank", 0)
			setElementData(source, "dienstzeit", 0)
			setElementData(source, "einnahmen", 0)
			setElementData(source, "einnahmen2", 0)
		else
			outputChatBox("Du musst erst den Dienst verlassen um zu Kündigen.", source,255,0,0)
		end
	else
		outputChatBox("Du hast keinen Job den du kündigen könntest.", source,255,0,0)
	end
end
addCommandHandler("kuendigen", quitJob, false, false) 
addCommandHandler("kündigen", quitJob, false, false) 

function kickFromJob ( source, commandName, playername)
	if getElementData(source, "rank") == 2 then
		if playername == getPlayerName(source) then			
			outputChatBox("Du Depp kannst dich doch nicht selbst entlassen!",source,255,0,0)
		else
			local sply = getPlayerFromName2 ( playername )
			if sply then
				if type(sply) == "table" then
					outputChatBox("Fehler: Mehrere Spieler gefunden!",source,255,0,0)
					return
				end
				playername = getPlayerName(sply)
				if getElementData(source, "job") == getElementData(sply, "job") then
					if getElementData(sply, "dienst") == 1 then
						setElementModel ( sply, getElementData(sply, "skin") )
						setElementData(sply, "dienst", 0)
					end	
					removeFromJobVeh(getElementData(sply, "job"), getPlayerName(sply))
					setElementData(sply, "job", 0)
					setPlayerTeam(sply, nil)
					setElementData(sply, "rank", 0)
					outputChatBox("Der Spieler "..tostring(playername).." wurde gefeuert!",source,0,255,0)
					outputChatBox("Du wurdest von "..getPlayerName(source).." gefeuert.",sply,0,255,0)
				else
					outputChatBox("Diese Person arbeitet nicht in deiner Firma.",source,255,0,0)
				end
			else
				outputChatBox("Die Person, die du kündigen willst befindet sich gerade nicht auf dem Server:",source,125,125,125)
				outputChatBox("Es wurde versucht die Person dennoch zu entlassen.",source,125,200,125)
				removeFromJobVeh(getElementData(source, "job"), playername)
				setPlayerUserFileData(playername, "job", 0)
				setPlayerUserFileData(playername, "rank", 0)
				setPlayerUserFileData(playername, "dienst", 0)
				setPlayerUserFileData(playername, "dienstzeit", 0)
				setPlayerUserFileData(playername, "einnahmen", 0)
				setPlayerUserFileData(playername, "einnahmen2", 0)
			end
		end
	end
end
addCommandHandler("entlassen", kickFromJob, false, false)

function addToJob ( source, commandName, playername)
	if getElementData(source, "rank") == 2 then
		if playername == getPlayerName(source) then
			outputChatBox("Du Depp kannst dich doch nicht selbst einstellen!",source,255,0,0)
		else
			local sply = getPlayerFromName2 ( playername )
			if sply then
				if type(sply) == "table" then
					outputChatBox("Fehler: Mehrere Spieler gefunden!",source,255,0,0)
					return
				end
				playername = getPlayerName(sply)
				if getElementData(sply, "job") == 0 then
					if getElementData(sply, "dienst") == 0 then
						setElementData(sply, "job", getElementData(source, "job"))
						setPlayerTeam(sply, gJobTeams[getElementData(source, "job")])
						setElementData(sply, "rank", 1)
						setElementData(sply, "dienstzeit", 0)
						setElementData(sply, "einnahmen", 0)
						setElementData(sply, "einnahmen2", 0)
						outputChatBox("Der Spieler "..tostring(playername).." wurde eingestellt!",source,0,255,0)
						outputChatBox("Du wurdest von "..getPlayerName(source).." eingstellt.",sply,0,255,0)
					else
						outputChatBox("Der zu Feuernde muss erst seinen Dienst quittieren.",source,255,0,0)
					end
				else
					outputChatBox("Diese Person schon wo anders.",source,255,0,0)
				end
			else
				outputChatBox("Die Person, die du einstellen willst, existiert entweder nicht oder befindet sich gerade nicht auf dem Server.",source,255,0,0)
			end
		end
	end
end
addCommandHandler("einstellen", addToJob, false, false)

function addVehicleToJob(source, commandName)
	local vehicle = getPedOccupiedVehicle ( source )
	if getElementData(source, "job") ~= 0 and getElementData(source, "rank") == 2 and vehicle ~= false then
		if getElementData ( vehicle, "owner" ) == getPlayerName(source) then
			setElementData ( vehicle, "owner", tostring(getElementData(source, "job")) )
			outputChatBox("Du hast das Fahrzeug an die Firma überschrieben.",source,0,255,0)
		else
			outputChatBox("Dieses Fahrzeug gehört nicht dir.",source,255,0,0)
		end
	end
end
addCommandHandler("autoanfirma", addVehicleToJob, false, false)

function setautohausvehlcleundamageable ( res )
	for i, w in pairs(getElementsByType("vehicle")) do
		if getElementData ( w, "keys" ) == "Autohaus" or getElementData ( w, "keys" ) == "Autohus" or getElementData ( w, "keys" ) == "car4you" then
		setVehicleDamageProof ( w, true )
		end
	end
end
addEventHandler ( "onResourceStart", getRootElement(), setautohausvehlcleundamageable )

local ah_col = createColRectangle(1043.5462890625,1723.0559082031,50.5,50.5)
function setdameageoff( veh )
	setVehicleDamageProof ( veh, false )
	setElementFrozen(veh, false)
	if isElementWithinColShape (veh, ah_col) then
		setElementPosition(veh, 1101,1733,11)
		setElementRotation(veh,0,0,0)
	end	
end
addEvent ( "onclientbuyveh", true )
addEventHandler( "onclientbuyveh", getRootElement(), setdameageoff )

--Krankenhaus Tor
local Keypad1 = createObject ( 2886, 1577.9, 1793.1, 8.8, 0, 0, 90 )
setElementData(Keypad1, "cinfo", {"Tor Öffnen/Schließen"})
local Keypad2 = createObject ( 2886, 1582.3, 1799, 8.8, 0, 0, 268 )
setElementData(Keypad2, "cinfo", {"Tor Öffnen/Schließen"})
local Tor = createObject ( 9823, 1580.2, 1797, 7.9, 0, 0, 270 )
setElementData ( Tor, "state", "up", true )

function Keypad( theButton, theState, player, clickPosX, clickPosY, clickPosZ )			--SanitäterGarage
	if getElementData ( Tor, "state" ) == "up" and theButton == "left" and theState == "down" and getElementData(player, "job") == 7 then
		moveObject ( Tor, 2500, 1580.2, 1797, 2.9  )
		setElementData ( Tor, "state", "down", true )
	else if getElementData ( Tor, "state" ) == "down" and theButton == "left" and theState == "down" and getElementData(player, "job") == 7 then
		moveObject ( Tor, 2500, 1580.2, 1797, 7.9 )
		setElementData ( Tor, "state", "up", true )
		end
	end
end
addEventHandler("onElementClicked", Keypad1, Keypad )
addEventHandler("onElementClicked", Keypad2, Keypad )

--Reporter Tor
--createWater(1978.522753906, 2163.3566894531, 10.048090362549, 1997.8559570313, 2163.3566894531, 10.048090362549, 1978.522753906, 2173.4482421875,10.048090362549, 1997.8559570313, 2173.4482421875,10.048090362549, false)
--createWater(2017.6767578125, 2163.3566894531, 11.648090362549, 2038.3861083984, 2163.3566894531, 11.648090362549, 2017.6767578125, 2173.4482421875, 11.648090362549, 2038.3861083984, 2173.4482421875,11.648090362549, true)

local r_Keypad1 = createObject ( 2886, 2036.400390625, 2123.2998046875, 12.10000038147, 0, 0, 0 )
setElementData(r_Keypad1, "cinfo", {"Tor Öffnen/Schließen"})
local r_Keypad2 = createObject ( 2886, 2036.400390625, 2124, 12.10000038147, 0, 0, 180 )
setElementData(r_Keypad2, "cinfo", {"Tor Öffnen/Schließen"})
local r_Tor = createObject ( 971, 2031.7001953125, 2123.6005859375, 10, 0, 0, 0 )
setElementData ( r_Tor, "state", "up", true )

function r_Keypad( theButton, theState, player, clickPosX, clickPosY, clickPosZ )			--SanitäterGarage
	if getElementData ( r_Tor, "state" ) == "up" and theButton == "left" and theState == "down" and getElementData(player, "job") == 9 then
		moveObject ( r_Tor, 2500, 2031.7001953125, 2123.6005859375, 5.1999998092651  )
		setTimer(function() setElementData ( r_Tor, "state", "down", true ) end, 2500,1)
		setElementData ( r_Tor, "state", "moving", true )
	else if getElementData ( r_Tor, "state" ) == "down" and theButton == "left" and theState == "down" and getElementData(player, "job") == 9 then
		moveObject ( r_Tor, 2500, 2031.7001953125, 2123.6005859375, 10 )
		setElementData ( r_Tor, "state", "moving", true )
		setTimer(function() setElementData ( r_Tor, "state", "up", true ) end, 2500,1)
		end
	end
end
addEventHandler("onElementClicked", r_Keypad1, r_Keypad )
addEventHandler("onElementClicked", r_Keypad2, r_Keypad )

local r_Keypad3 = createObject ( 2886, 2105.7001953125, 2183.5, 11.60000038147, 0, 0, 270 )
setElementData(r_Keypad3, "cinfo", {"Tor Öffnen/Schließen"})
local r_Keypad4 = createObject ( 2886, 2106.400390625, 2183.5, 11.60000038147, 0, 0, 90 )
setElementData(r_Keypad4, "cinfo", {"Tor Öffnen/Schließen"})
local r_Tor2 = createObject ( 971, 2106.1000976563, 2188.1999511719, 10, 0, 0, 90 )
setElementData ( r_Tor2, "state", "up", true )

function r_Keypad2( theButton, theState, player, clickPosX, clickPosY, clickPosZ )			--SanitäterGarage
	if getElementData ( r_Tor2, "state" ) == "up" and theButton == "left" and theState == "down" and getElementData(player, "job") == 9 then
		moveObject ( r_Tor2, 2500, 2106.1000976563, 2188.1999511719, 5.1999998092651  )
		setTimer(function() setElementData ( r_Tor2, "state", "down", true ) end, 2500,1)
		setElementData ( r_Tor2, "state", "moving", true )
	else if getElementData ( r_Tor2, "state" ) == "down" and theButton == "left" and theState == "down" and getElementData(player, "job") == 9 then
		moveObject ( r_Tor2, 2500, 2106.1000976563, 2188.1999511719, 10 )
		setElementData ( r_Tor2, "state", "moving", true )
		setTimer(function() setElementData ( r_Tor2, "state", "up", true ) end, 2500,1)
		end
	end
end

addEventHandler("onElementClicked", r_Keypad3, r_Keypad2 )
addEventHandler("onElementClicked", r_Keypad4, r_Keypad2 )