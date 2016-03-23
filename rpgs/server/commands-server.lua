--[[
Project: VitaOnline
File: commands-server.lua
Author(s):	Sebihunter
]]--

local blipscreated = {}
local blips = {}

function givePassport(source, commandName, playername)
	if getElementData(source, "isPlayerLoggedIn") == true then
		if(playername ~= "" and playername ~= nil) then		
			player = getPlayerFromName2 ( playername )	
			if player then
				if type(player) == "table" then
					outputChatBox("Fehler: Mehrere Spieler gefunden!",source,255,0,0)
					return
				end
				playername = getPlayerName(player)
				local fscheinstring, mscheinstring, gscheinstring, flscheinstring, wscheinstring, tscheinstring
				if getElementData(source, "aschein") == true then
					fscheinstring = "Ja"
				else
					fscheinstring = "Nein"
				end
				if getElementData(source, "mschein") == true then
					mscheinstring = "Ja"
				else
					mscheinstring = "Nein"
				end				
				if getElementData(source, "bschein") == true then
					gscheinstring = "Ja"
				else
					gscheinstring = "Nein"
				end		
				if getElementData(source, "fschein") == true then
					flscheinstring = "Ja"
				else
					flscheinstring = "Nein"
				end				
				if getElementData(source, "wschein") >= 1 then
					wscheinstring = "Stufe "..tostring(getElementData(source, "wschein"))
				else
					wscheinstring = "Nein"
				end			
				if hasTempLicense(getPlayerName(source)) ~= false then
					tscheinstring = hasTempLicense(getPlayerName(source))
				else
					tscheinstring = "Nein"
				end					
				local skinid = getPedSkin ( source )					
				outputChatBox("Du hast "..playername.." deinen Ausweis gezeigt!", source, 0,255,0)
				local deinjob
				if tonumber(isjobid) == 0 then
					deinjob = "Arbeitslos"
				else
					deinjob = tostring(gJobData[tonumber(getElementData(source, "job"))].name)
				end
				triggerClientEvent ( player, "zeigePerso", getRootElement(), getPlayerName(source), getElementData(source, "geb"), getElementData(source, "geschlecht"), deinjob, fscheinstring, mscheinstring, gscheinstring, flscheinstring, wscheinstring, tscheinstring, tostring(getElementData(source, "pif")), tostring(getElementData(source, "skin")), tostring(getElementData(source, "panote")))
			end
		else
			outputChatBox("Fehler: /perso <Spielername>",source,255,0,0)
		end	 
	end
end
addCommandHandler("perso", givePassport, false, false)

function revokeVehicleRegistration(source, command, spielername)
	if(spielername ~= "" and spielername ~= nil) then
		vehicle = getPedOccupiedVehicle ( source )
		otherplayer = getPlayerFromName2(spielername)
		if otherplayer then
			if type(otherplayer) == "table" then
				outputChatBox("Fehler: Mehrere Spieler gefunden!",source,255,0,0)
				return
			end
			
			local hasLicense = false
			if (getElementData(otherplayer, "aschein") and (getVehicleType(vehicle) == "Automobile" or getVehicleType(vehicle) == "Monster Truck")) then hasLicense = true end
			if (getElementData(otherplayer, "fschein") and (getVehicleType(vehicle) == "Plane" or getVehicleType(vehicle) == "Helicopter")) then hasLicense = true end
			if (getElementData(otherplayer, "bschein") and (getVehicleType(vehicle) == "Trailer")) then hasLicense = true end
			if (getElementData(otherplayer, "mschein") and (getVehicleType(vehicle) == "Bike" or getVehicleType(vehicle) == "Quad")) then hasLicense = true end
			if (getVehicleType(vehicle) == "BMX" or getVehicleType(vehicle) == "Train" or getVehicleType(vehicle) == "Boat") then hasLicense = true end
			if hasLicense == false then return outputChatBox("Der Spieler hat keinen Führerschein für diesen Fahrzeugtyp.", source,255,0,0) end
			
			spielername = getPlayerName(otherplayer)
			if vehicle ~= false then
				spielername = getPlayerName(otherplayer) -- Kompletten Spielernamen für die Ausgabe verwenden
				if getElementData ( vehicle, "owner" ) == getPlayerName(source) then
					setElementData ( vehicle, "owner", spielername )
					outputChatBox("Du hast "..spielername.." den Fahrzeugbrief übergeben.", source, 0, 255, 0)
					outputChatBox("Du hast den Fahrzeugbrief von "..getPlayerName(source).." bekommen.", otherplayer, 0, 255, 0)
				else
					outputChatBox("Du bist nicht der Besitzer dieses Fahrzeuges.", source, 255, 0, 0)
				end
			else
				outputChatBox("Du bist in keinem Fahrzeug.", source,255,0,0)
			end
		else
			outputChatBox("Dieser Spieler existiert nicht!", source, 255, 0, 0)
		end
	end	
end
addCommandHandler("autoabgeben", revokeVehicleRegistration, false, false)

function changeJobRang(player, command, playername, newrang)
	if getElementData(player, "rank") == 2 then
		if playername ~= "" and playername ~= nil then
			local rangid = tonumber(newrang)
			if rangid == 0 or rangid == 1 or rangid == 2 then
				local otherplayer = getPlayerFromName(playername)
				if otherplayer ~= false then
					if getElementData(otherplayer, "job") == getElementData(player, "job") then
						setElementData(otherplayer, "rank", rangid)
						outputChatBox("Du hast den Rang von "..playername.." in "..getJobRangNameFromID(rangid).." geändert.", player, 0, 255, 0)
						outputChatBox("Dein Rang wurde von "..getPlayerName(player).." auf "..getJobRangNameFromID(rangid).." geändert.", otherplayer, 0, 255, 0)
					end
				else
					outputChatBox("Dieser Spieler exestiert nicht!", player, 255, 0, 0)
				end
			else
				outputChatBox("Fehler: /rang <Spielername> <RangID>", player, 255, 0, 0)
			end
		else
			outputChatBox("Fehler: /rang <Spielername> <RangID>", player, 255, 0, 0)
		end
	else
		outputChatBox("Du kannst diesen Befehl nicht nutzen!", player, 255, 0, 0)
	end
end
addCommandHandler("rang", changeJobRang, false, false)

function revokeVehicleKeys(source, command, ...)
	vehicle = getPedOccupiedVehicle ( source )
	if not isElement(vehicle) then
		outputChatBox("Du bist in keinem Fahrzeug.", source, 255, 0, 0)
		return
	elseif  getElementData ( vehicle, "owner" ) ~= getPlayerName(source) then
		outputChatBox("Du bist nicht der Besitzer dieses Fahrzeuges.", source, 255, 0, 0)
		return
	end
	local spielername = getPlayerName(source)
	local keytable = {}
	local othername 
	for k, v in pairs(arg) do
		if k == "n" then break end
		otherplayer = getPlayerFromName2(v)
		if otherplayer then
			if type(otherplayer) == "table" then
				outputChatBox("Fehler: Mehrere Spieler gefunden für "..v.."!",source,255,0,0)
				return
			end
		else
			outputChatBox("Der Spieler mit dem Namen "..v.." existiert nicht!", source, 255, 0, 0)
			return
		end
		othername = getPlayerName(otherplayer)
		
		outputChatBox("Du hast "..othername.." einen Autoschluessel gegeben.",source, 0, 255, 0)
		outputChatBox("Du hast einen Autoschlüssel von "..getPlayerName(source).." bekommen.", otherplayer , 0, 255, 0)
		keytable[#keytable+1] = othername
	end
	keytable = table.concat(keytable, ",")
	setElementData(vehicle, "keys", keytable)	
end
addCommandHandler("schluesselabgeben", revokeVehicleKeys, false, false)

addCommandHandler( { "report", "support"},
	function( thePlayer, commandName, ... )
		if getElementData(thePlayer, "isPlayerLoggedIn") == true and tonumber(getElementData(thePlayer, "getPlayerSpecialRights")) ~= 0 then
			local message = table.concat( { ... }, " " )
			if message == "" then return  outputChatBox("Du musst eine Supportnachricht angeben.",source,255,0,0) end
			local reportElement = false
			for i,v in ipairs(getElementsByType("report")) do
				if getElementData(v, "name") == getPlayerName(thePlayer) then
					reportElement = v
					break
				end
			end
			if not reportElement then
				reportElement = createElement("report")
				setElementData(reportElement, "name", getPlayerName(thePlayer))
				setElementData(reportElement, "table", {})
			end
			local dtab = getElementData(reportElement, "table")
			dtab[#dtab+1] = getPlayerName(thePlayer)..": "..message
			setElementData(reportElement, "table", dtab)
			setElementData(reportElement, "read", false)
			outputChatBox("Supportnachricht ("..message..") abgeschickt.",thePlayer,0,255,0)
		end
	end
)

function giveMoney(source, commandName, playername, money)
	if getElementData(source, "isPlayerLoggedIn") == true then
	    if(playername ~= "" and playername ~= nil and money ~= "" and money ~= nil) then
		    if ((tonumber(money) <= getPlayerMoneyEx(source)) and (tonumber(money) > 0)) then
				local targetPlayer = getPlayerFromName2 ( playername )
				if ( targetPlayer ) then         
					if type(targetPlayer) == "table" then
						outputChatBox("Fehler: Mehrere Spieler gefunden!",source,255,0,0)
						return
					end
					playername = getPlayerName(targetPlayer)
					takePlayerMoneyEx ( source, math.floor(money) )
					givePlayerMoneyEx (targetPlayer, math.floor(money))
					pLogger["geld"]:addEntry( getPlayerName(source) .."  hat ".. math.floor(money).. " Vero ".. getPlayerName(targetPlayer).. " gegeben ")
					outputChatBox("Du hast dem Spieler "..playername.." "..math.floor(money).." Vero gegeben.",source,0,255,0)
					outputChatBox("Du hast vom Spieler "..getPlayerName(source).." "..math.floor(money).." Vero erhalten.",targetPlayer,0,255,0)
				else
				    outputChatBox("Dieser Spieler existiert nicht.",source,255,0,0)
				end
			else
				outputChatBox("Du hast nicht so viel Geld.",source,255,0,0)
			end
	    else
	        outputChatBox("Fehler: /sende <Spielername> <Summe>",source,255,0,0)
	    end
	end
end
addCommandHandler("sende", giveMoney, false, false)
addCommandHandler("pay", giveMoney, false, false)

local blips_houses = {}
local blips_housescreated = {}
function setHousesVisible(source, commandName)
    if getElementData(source, "isPlayerLoggedIn") == true then
		if not blips_houses[source] then blips_houses[source] ={} end
		if blips_housescreated[source] == true then
			for _, vehicle in ipairs(getElementsByType("pickup")) do
				if blips_houses[source][vehicle] ~= nil then
					destroyElement(blips_houses[source][vehicle])
					blips_houses[source][vehicle] = nil
				end	
			end
			blips_housescreated[source] = false
			outputChatBox("Deine Häuser wurden auf der Karte wieder ausgeblendet.", source, 0,255,0)  
		else
			for _, vehicle in ipairs(getElementsByType("pickup")) do
				if getElementData ( vehicle, "owner" ) == getPlayerName(source) or isVehicleOwner(source,  getElementData ( vehicle, "keys" )) then --No vehicle but this works too ;)
					blips_houses[source][vehicle] = createBlipAttachedTo ( vehicle, 31, 2, 255, 0, 0, 255, 0, 99999.0, source )
				end
			end	
			blips_housescreated[source] = true
			outputChatBox("Deine Häuser werden nun auf der Karte angezeigt.", source, 0,255,0)	
		end		
	end	
end	
addCommandHandler("häuseranzeigen", setHousesVisible, false, false )

local blips = {}
function setVehiclesVisible(source, commandName, name)
	local isDisplayed = false
    if getElementData(source, "isPlayerLoggedIn") == true then
		if not blips[source] then blips[source] ={} end
		if blipscreated[source] == true then
			for _, vehicle in ipairs(getElementsByType("vehicle")) do
				if blips[source][vehicle] ~= nil then
					destroyElement(blips[source][vehicle])
					blips[source][vehicle] = nil
				end	
			end
			blipscreated[source] = false
			outputChatBox("Deine Autos wurden auf der Karte wieder ausgeblendet.", source, 0,255,0)  
		else
			for _, vehicle in ipairs(getElementsByType("fakeVehicle")) do
				if getElementData ( vehicle, "owner" ) == getPlayerName(source) or tostring(getElementData(vehicle, "owner")) == tostring(getElementData(source, "job")) and getElementData(source, "rank") == 2 then
					if not name or string.lower(getVehicleNameFromModel ( tonumber(getElementData(vehicle, "model")) )) == string.lower(tostring(name)) then
						outputChatBox("Eines deiner Fahrzeuge befindet sich in der Verwahrungsstelle.", source, 255,255,0)	
						isDisplayed = true
					end
				end
			end	
			for _, vehicle in ipairs(getElementsByType("vehicle")) do
				if getElementData ( vehicle, "owner" ) == getPlayerName(source) or isVehicleOwner(source,  getElementData ( vehicle, "keys" )) then
					if not name or string.lower(getVehicleName ( vehicle )) == string.lower(tostring(name)) then
						blips[source][vehicle] = createBlipAttachedTo ( vehicle, 55, 2, 255, 0, 0, 255, 0, 99999.0, source )
						isDisplayed = true
					end
				end
			end	
			blipscreated[source] = true
			if not isDisplayed then
				outputChatBox("Es wurden keine Fahrzeuge mit diesem Namen gefunden.", source, 255,0,0)	
			else
				outputChatBox("Deine Autos werden nun auf der Karte angezeigt.", source, 0,255,0)	
			end
		end		
	end	
end	
addCommandHandler("autosanzeigen", setVehiclesVisible, false, false )

function toggleAFK(source, commandName)
    if getElementData(source, "isPlayerLoggedIn") == true then
		if getElementData(source, "afk") == true then
			setElementData(source, "afk", false)
			
			setElementFrozen(source, false)
			outputChatBox("Du bist nicht mehr AFK.", source, 0,255,0) 
		else
			if gHasPlayerHandschellen[source] == 1 then
				outputChatBox("Du kannst während du Handschellen hast nicht AFK gehen.", source, 255,0,0) 
				return
			end
			setElementData(source, "afk", true)
			outputChatBox("Du bist nun AFK.", source, 0,255,0) 
			setElementFrozen(source, true)
		end
	end
end
addCommandHandler("afk", toggleAFK, false, false)

function hideSpeedometer(source, commandName)
    if getElementData(source, "isPlayerLoggedIn") == true then
		if getElementData(source, "hideTacho") == true then
			setElementData(source, "hideTacho", false)
			outputChatBox("Du hast das Tacho angeschalten.", source, 0,255,0) 
		else
			setElementData(source, "hideTacho", true)
			outputChatBox("Du hast das Tacho ausgeschalten.", source, 0,255,0) 
		end
	end
end
addCommandHandler("hidetacho", hideSpeedometer, false, false)

local taxiStuff = {}
function callTaxi(source, commandName)
    if getElementData(source, "isPlayerLoggedIn") == true then
		if taxiStuff[source] and isTimer(taxiStuff[source]) then outputChatBox("ERROR: 3 Minuten Frist um den Befehl erneut zu nützen.",source, 255,0,0, true) return end
		local x, y, z = getElementPosition(source)
		local zone = getZoneName ( x, y, z )
		local city = getZoneName ( x, y, z, true )
		local onlinePlayers = 0
		for numb,ply in ipairs(getElementsByType("player")) do
			if getElementData(ply, "taxi") == true and getElementData(ply, "afk") ~= true then
				onlinePlayers = onlinePlayers+1
				callClientFunction(ply, "playDispatch", "An alle Fahrer: Fahrgast in "..zone..", "..city)
				triggerClientEvent ( ply, "addNotification", getRootElement(), 3, 255,255,0, getPlayerName(source).." benötigt ein Taxi.\n"..zone.." ("..city..")." )
				outputChatBox ( getPlayerName(source).." benötigt ein Taxi in "..zone.." ("..city..").", ply, 255, 255, 0, true )
				outputChatBox ( "Ein Icon ist für 3 Minuten auf der Karte sichtbar.", ply, 255, 255, 0, true )
				local blip = createBlipAttachedTo ( source, 0, 5, 0 ,0, 255, 255, 0, 99999.0, ply )
				setTimer(
					function(blip)
						destroyElement(blip)
					end
				,180000,1, blip)					
			end
		end
		if onlinePlayers == 0 then outputChatBox ( "Es ist im Moment kein Taxifahrer anwesend. Probiere es später nochmal.", source, 255, 0, 0, true ) return end
		taxiStuff[source] = setTimer(function() end, 180000, 1)
		outputChatBox ( "Du hast ein Taxi gerufen...", source, 0, 255, 0, true )
	end
end
addCommandHandler("taxi", callTaxi, false, false)

local fschuleStuff = {}
function callFschule(source, commandName, ...)
    if getElementData(source, "isPlayerLoggedIn") == true then
		if fschuleStuff[source] and isTimer(fschuleStuff[source]) then outputChatBox("ERROR: 3 Minuten Frist um den Befehl erneut zu nützen.",source, 255,0,0, true) return end
		local message = table.concat( { ... }, " " )
		if #message == 0 then outputChatBox("ERROR: Du musst eine Beschreibung bzw. einen Grund angeben.",source, 255,0,0, true) return end
		local x, y, z = getElementPosition(source)
		local zone = getZoneName ( x, y, z )
		local city = getZoneName ( x, y, z, true )
		local onlinePlayers = 0
		for numb,ply in ipairs(getElementsByType("player")) do
			if getElementData(ply, "job") == 10 and getElementData(ply, "dienst") == 1 and getElementData(ply, "afk") ~= true then
				onlinePlayers = onlinePlayers+1
				callClientFunction(ply, "playDispatch", "An alle Fahrerlehrer: Ein neuer Schüler in "..zone..", "..city)
				triggerClientEvent ( ply, "addNotification", getRootElement(), 3, 255,255,0, getPlayerName(source).." benötigt einen Fahrlehrer.\n"..zone.." ("..city..")." )
				outputChatBox ( getPlayerName(source).." benötigt einen Fahrlehrer in "..zone.." ("..city..").", ply, 255, 255, 0, true )
				outputChatBox ( "Du kannst den Einsatz mit '/annehmen auftrag "..getPlayerName(source).."' annehmen.", ply, 255, 255, 0, true )
				if #message > 0 then
					outputChatBox ( "Information: "..message.."", ply, 255, 255, 0, true )	
				end					
			end
		end
		if onlinePlayers == 0 then outputChatBox ( "Es ist im Moment kein Fahrlehrer anwesend. Probiere es später nochmal.", source, 255, 0, 0, true ) return end
		if #message > 0 then
			outputChatBox ( "Du hast einen Fahrlehrer gerufen. ("..message..")", source, 0, 255, 0, true )
		else
			outputChatBox ( "Du hast einen Fahrlehrer gerufen.", source, 0, 255, 0, true )
		end
		callAccepters[10][source] = true
		fschuleStuff[source] = setTimer(function() end, 180000, 1)	
	end
end
addCommandHandler("fschule", callFschule, false, false)


local adacStuff = {}
function callADAC(source, commandName, ...)
    if getElementData(source, "isPlayerLoggedIn") == true then
		if adacStuff[source] and isTimer(adacStuff[source]) then outputChatBox("ERROR: 3 Minuten Frist um den Befehl erneut zu nützen.",source, 255,0,0, true) return end
		local message = table.concat( { ... }, " " )
		if #message == 0 then outputChatBox("ERROR: Du musst eine Beschreibung bzw. einen Grund angeben.",source, 255,0,0, true) return end
		local x, y, z = getElementPosition(source)
		local zone = getZoneName ( x, y, z )
		local city = getZoneName ( x, y, z, true )
		local onlinePlayers = 0
		for numb,ply in ipairs(getElementsByType("player")) do
			if getElementData(ply, "job") == 4 and getElementData(ply, "dienst") == 1 and getElementData(ply, "afk") ~= true then
				onlinePlayers = onlinePlayers+1
				callClientFunction(ply, "playDispatch", "An alle Fahrer: Liegengebliebenes Fahrzeug in "..zone..", "..city)
				triggerClientEvent ( ply, "addNotification", getRootElement(), 3, 255,255,0, getPlayerName(source).." benötigt einen Mechaniker.\n"..zone.." ("..city..")." )
				outputChatBox ( getPlayerName(source).." benötigt einen Mechaniker in "..zone.." ("..city..").", ply, 255, 255, 0, true )
				outputChatBox ( "Du kannst den Einsatz mit '/annehmen auftrag "..getPlayerName(source).."' annehmen.", ply, 255, 255, 0, true )
				if #message > 0 then
					outputChatBox ( "Information: "..message.."", ply, 255, 255, 0, true )	
				end					
			end
		end
		if onlinePlayers == 0 then outputChatBox ( "Es ist im Moment kein AutoFix Mitarbeiter anwesend. Probiere es später nochmal.", source, 255, 0, 0, true ) return end
		if #message > 0 then
			outputChatBox ( "Du hast den AutoFix gerufen. ("..message..")", source, 0, 255, 0, true )
		else
			outputChatBox ( "Du hast den AutoFix gerufen.", source, 0, 255, 0, true )
		end
		callAccepters[4][source] = true
		adacStuff[source] = setTimer(function() end, 180000, 1)	
	end
end
addCommandHandler("autofix", callADAC, false, false)
addCommandHandler("adac", callADAC, false, false)

local polizeiStuff = {}
function callPolice(source, commandName, ...)
    if getElementData(source, "isPlayerLoggedIn") == true then
		if polizeiStuff[source] and isTimer(polizeiStuff[source]) then outputChatBox("ERROR: 3 Minuten Frist um den Befehl erneut zu nützen.",source, 255,0,0, true) return end
		local message = table.concat( { ... }, " " )
		if #message == 0 then outputChatBox("ERROR: Du musst eine Beschreibung bzw. einen Grund angeben.",source, 255,0,0, true) return end
		local x, y, z = getElementPosition(source)
		local zone = getZoneName ( x, y, z )
		local city = getZoneName ( x, y, z, true )
		local onlinePlayers = 0
		for numb,ply in ipairs(getElementsByType("player")) do
			if getElementData(ply, "job") == 3 and getElementData(ply, "dienst") == 1 and getElementData(ply, "afk") ~= true then
				onlinePlayers = onlinePlayers+1
				callClientFunction(ply, "playDispatch", "Achtung an alle Einheiten: Notfalleinsatz in "..zone..", "..city)
				triggerClientEvent ( ply, "addNotification", getRootElement(), 3, 255,255,0, getPlayerName(source).." benötigt die Polizei.\n"..zone.." ("..city..")." )
				outputChatBox ( getPlayerName(source).." benötigt die Polizei in "..zone.." ("..city..").", ply, 255, 255, 0, true )
				outputChatBox ( "Du kannst den Einsatz mit '/annehmen auftrag "..getPlayerName(source).."' annehmen.", ply, 255, 255, 0, true )
				if #message > 0 then
					outputChatBox ( "Information: "..message, ply, 255, 255, 0, true )		
				end			
			end
		end
		if onlinePlayers == 0 then outputChatBox ( "Es ist im Moment kein Polizist anwesend. Probiere es später nochmal.", source, 255, 0, 0, true ) return end
		polizeiStuff[source] = setTimer(function() end, 180000, 1)
		callAccepters[3][source] = true
		if #message > 0 then
			outputChatBox ( "Du hast die Polizei gerufen. ("..message..")", source, 0, 255, 0, true )
		else
			outputChatBox ( "Du hast die Polizei gerufen.", source, 0, 255, 0, true )
		end		
	end
end
addCommandHandler("110", callPolice, false, false)
addCommandHandler("police", callPolice, false, false)
addCommandHandler("polizei", callPolice, false, false)

local medicStuff = {}
function callMedic(source, commandName, ...)
    if getElementData(source, "isPlayerLoggedIn") == true then
		if medicStuff[source] and isTimer(medicStuff[source]) then outputChatBox("ERROR: 3 Minuten Frist um den Befehl erneut zu nützen.",source, 255,0,0, true) return end
		local message = table.concat( { ... }, " " )
		if #message == 0 then outputChatBox("ERROR: Du musst eine Beschreibung bzw. einen Grund angeben.",source, 255,0,0, true) return end
		local x, y, z = getElementPosition(source)
		local zone = getZoneName ( x, y, z )
		local city = getZoneName ( x, y, z, true )
		local onlinePlayers = 0
		for numb,ply in ipairs(getElementsByType("player")) do
			if getElementData(ply, "job") == 7 and getElementData(ply, "dienst") == 1 and getElementData(ply, "afk") ~= true then
				onlinePlayers = onlinePlayers+1
				callClientFunction(ply, "playDispatch", "Achtung an alle Einheiten: Notfalleinsatz in "..zone..", "..city)
				triggerClientEvent ( ply, "addNotification", getRootElement(), 3, 255,255,0, getPlayerName(source).." benötigt einen Sanitäter.\n"..zone.." ("..city..")." )
				outputChatBox ( getPlayerName(source).." benötigt einen Sanitäter in "..zone.." ("..city..").", ply, 255, 255, 0, true )
				outputChatBox ( "Du kannst den Einsatz mit '/annehmen auftrag "..getPlayerName(source).."' annehmen.", ply, 255, 255, 0, true )
				if #message > 0 then
					outputChatBox ( "Information: "..message, ply, 255, 255, 0, true )		
				end			
			end
		end
		if onlinePlayers == 0 then outputChatBox ( "Es ist im Moment kein Sanitäter anwesend. Probiere es später nochmal.", source, 255, 0, 0, true ) return end
		medicStuff[source] = setTimer(function() end, 180000, 1)		
		callAccepters[7][source] = true
		if #message > 0 then
			outputChatBox ( "Du hast einen Sanitäter gerufen. ("..message..")", source, 0, 255, 0, true )
		else
			outputChatBox ( "Du hast einen Sanitäter gerufen...", source, 0, 255, 0, true )
		end	
	end
end
addCommandHandler("sani", callMedic, false, false)
addCommandHandler("sanitater", callMedic, false, false)
addCommandHandler("sanitäter", callMedic, false, false)
addCommandHandler("112", callMedic, false, false)
addCommandHandler("01189998819991197253", callMedic, false, false)

local fireStuff = {}
function callFire(source, commandName, ...)
    if getElementData(source, "isPlayerLoggedIn") == true then
		if fireStuff[source] and isTimer(fireStuff[source]) then outputChatBox("ERROR: 3 Minuten Frist um den Befehl erneut zu nützen.",source, 255,0,0, true) return end
		local message = table.concat( { ... }, " " )
		if #message == 0 then outputChatBox("ERROR: Du musst eine Beschreibung bzw. einen Grund angeben.",source, 255,0,0, true) return end
		local x, y, z = getElementPosition(source)
		local zone = getZoneName ( x, y, z )
		local city = getZoneName ( x, y, z, true )
		local onlinePlayers = 0
		for numb,ply in ipairs(getElementsByType("player")) do
			if getElementData(ply, "job") == 7 and getElementData(ply, "dienst") == 1 and getElementData(ply, "afk") ~= true then
				onlinePlayers = onlinePlayers+1
				callClientFunction(ply, "playDispatch", "Achtung an alle Einheiten: Einsatz in "..zone..", "..city)
				triggerClientEvent ( ply, "addNotification", getRootElement(), 3, 255,255,0, getPlayerName(source).." benötigt eine Feuerwehr.\n"..zone.." ("..city..")." )
				outputChatBox ( getPlayerName(source).." benötigt eine Feuerwehr in "..zone.." ("..city..").", ply, 255, 255, 0, true )
				outputChatBox ( "Du kannst den Einsatz mit '/annehmen auftrag "..getPlayerName(source).."' annehmen.", ply, 255, 255, 0, true )
				if #message > 0 then
					outputChatBox ( "Information: "..message, ply, 255, 255, 0, true )		
				end			
			end
		end
		if onlinePlayers == 0 then outputChatBox ( "Es ist im Moment keine Feuerwehr anwesend. Probiere es später nochmal.", source, 255, 0, 0, true ) return end
		fireStuff[source] = setTimer(function() end, 180000, 1)		
		callAccepters[8][source] = true
		if #message > 0 then
			outputChatBox ( "Du hast die Feuerwehr gerufen. ("..message..")", source, 0, 255, 0, true )
		else
			outputChatBox ( "Du hast die Feuerwehr gerufen...", source, 0, 255, 0, true )
		end	
	end
end
addCommandHandler("feuer", callFire, false, false)
addCommandHandler("113", callFire, false, false)


--[[function changeAccountPassword(player, command, oldpassword, newpassword)
	if getElementData(player, "isPlayerLoggedIn") == true then
		if oldpassword ~= nil and oldpassword ~= "" then
			if newpassword ~= nil and newpassword ~= "" then
				if string.len(newpassword) > 5 then
					local xml = xmlLoadFile ( "xml/users.xml")
					local i = 0
					local name
					local playername = getPlayerName(player)
					local subnode
					if xml then
						while true do 
							subnode = xmlFindChild(xml,"account", i)
							if not subnode then
								break
							end
							name = xmlNodeGetAttribute ( subnode, "name" )
							if name == playername then
								local oldreadpass = tostring(xmlNodeGetAttribute ( subnode, "passwort"))
								if md5(oldpassword) == oldreadpass then
									xmlNodeSetAttribute( subnode, "passwort", md5(newpassword))
									outputChatBox("Du hast dein Passwort erfolgreicht geändert.", player,0,255,0)
									outputChatBox("Altes Passwort: "..oldpassword.." Neues Passwort: "..newpassword, player,0,255,0)
								else
									outputChatBox("Fehler: Das angegebene alte Passwort stimmt nicht mit dem vorhandenem überein.", player, 255,0,0)
								end
								break
							end
							i = i + 1
						end
						xmlSaveFile(xml)
						xmlUnloadFile(xml)
					end
				else
					outputChatBox("Fehler: Das neue Passwort muss mindestens 6 Zeichen lang sein.", player, 255,0,0)
				end
			else
				outputChatBox("Fehler: Neues Passwort muss angegeben werden.", player, 255,0,0)
			end
		else
			outputChatBox("Fehler: Altes Passwort muss angegeben werden.", player, 255,0,0)
		end
	end
end
addCommandHandler("passwort", changeAccountPassword, false, false)]]--

function abschleppen(source, command)
	local veh = getPedOccupiedVehicle(source)
	if veh and getElementModel(veh) == 525 then
		local posX, posY, posZ = getElementPosition( veh )
		local chatSphere = createColSphere( posX, posY, posZ, 10 )
		local vehicles = getElementsWithinColShape( chatSphere, "vehicle" )
		destroyElement( chatSphere )
		local trailer = false
		local dist = 10
		for i, v in ipairs( vehicles ) do
			if v ~= veh and getElementModel(v) ~= 435 and getElementModel(v) ~= 450 and getElementModel(v) ~= 591 and getVehicleType ( v ) ~= "Bike" and getVehicleType ( v ) ~= "Train" and getVehicleType ( v ) ~= "BMX" then --Remove truck trailers as they crash the client
				local x,y,z = getElementPosition(v)
				if getDistanceBetweenPoints3D ( posX, posY, posZ, x,y,z ) < dist and not getPedOccupiedVehicle(v) then
					dist = getDistanceBetweenPoints3D ( posX, posY, posZ, x,y,z )
					trailer = v
				end
			end
		end
		if trailer then
			attachTrailerToVehicle ( veh, trailer )
		else
			outputChatBox("Fehler: Es wurde kein Fahrzeug gefunden.", source, 255, 0, 0)
		end
	else
		outputChatBox("Fehler: Du bist in keinem Abschleppwagen.", source, 255, 0, 0)
	end
end
addCommandHandler("abschleppen", abschleppen, false, false)

function advertise(source, command, ...)
	local text = table.concat(arg, " ")
	if not text or text == "" then
		outputChatBox("Fehler: Kein Text angegeben. Werbung kostet pro Buchstabe 10 Vero.", source, 255, 0, 0)
		return
	end
	local price = 10 * text:len()
	if getPlayerMoneyEx(source) < price  then
		outputChatBox("Fehler: Nicht genug Geld. Du benötigst "..price.." Vero.", source, 255, 0, 0)
		return
	end
	
	outputChatBox("[Werbung] "..getPlayerName(source)..": "..text, getRootElement(), 0, 255, 0)
	outputChatBox("Die Werbung hat dich "..tostring(price).." Vero gekostet", source, 255, 255, 255)
	takePlayerMoneyEx(source, price)
	systemDeposit("Reporter", price)
end
addCommandHandler("werbung", advertise, false, false)