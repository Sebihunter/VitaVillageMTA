--[[
Project: VitaOnline
File: jobcommands-server.lua
Author(s):	Sebihunter
			CubedDeath
]]--

-- Einige Jobs
g_AcceptEvents = {}
amtimer = {}

function accept( source, commandName, eventname, ...)
	if(eventname ~= "" and eventname ~= nil) then	
		local acceptEvents = getElementData(source, "pAcceptEvents")
		if not acceptEvents then acceptEvents = {} end
		eventname = string.lower(eventname)
		local selectedEvent = acceptEvents[eventname]
		
		if not selectedEvent then
			outputChatBox("Fehler: Ereignis Ungültig.",source,255,0,0)
			return
		end
		if not g_AcceptEvents[eventname] then
			outputChatBox("Fehler: Ereignis Ungültig.",source,255,0,0)
			return
		end
		g_AcceptEvents[eventname](source, unpack(arg))
		return
	else
		outputChatBox("Fehler: /annehmen [Ereignis]",source,255,0,0)
	end
end
addCommandHandler("annehmen", accept)
addCommandHandler("accept", accept)

function addAcceptCommand(player, event)
	local acceptEvents = getElementData(player, "pAcceptEvents")
	if not acceptEvents then acceptEvents = {} end
	acceptEvents[event] = true
	setElementData(player, "pAcceptEvents", acceptEvents)
end

function removeAcceptCommand(player, event)
	local acceptEvents = getElementData(player, "pAcceptEvents")
	if not acceptEvents then acceptEvents = {} end
	acceptEvents[event] = nil
	setElementData(player, "pAcceptEvents", acceptEvents)
end

function g_AcceptEvents.auftrag(source, playername)
	if getElementData(source, "dienst") == 1 then
		local player = getPlayerFromName2 ( playername )
		if player and callAccepters[getElementData(source,"job")][player] == true then
			if type(player) == "table" then
				outputChatBox("Fehler: Mehrere Spieler gefunden!",source,255,0,0)
				return
			end
			callAccepters[getElementData(source,"job")][player] = nil
			playername = getPlayerName(player)
			for numb,ply in ipairs(getElementsByType("player")) do
				if getElementData(ply, "job") == getElementData(source, "job") and getElementData(ply, "dienst") == 1 then
					outputChatBox ( "#aaaa00[Funk] Leitstelle: Anfrage ("..playername..") wurde von "..getPlayerName(source).." übernommen.", ply, 200, 200, 0, true )
				end
			end
			
			outputChatBox ( "Ein Icon ist für 3 Minuten auf der Karte sichtbar.", source, 255, 255, 0, true )
			local blip = createBlipAttachedTo ( player, 0, 5, 0 ,0, 255, 255, 0, 99999.0, source )
			setTimer(
				function(blip)
					destroyElement(blip)
				end
			,180000,1, blip)				
			outputChatBox(getPlayerName(source).." hat deine Anfrage angenommen.", player,0,255,255)
		else
			outputChatBox("Dieser Spieler existiert nicht.",source,255,0,0)
		end
	end
end

function g_AcceptEvents.waffenschein(source)
	local wschein = getElementData(source, "pWScheinData")
	if not wschein then
		outputChatBox("Fehler: Dir wurde kein Waffenschein angeboten.", source, 255, 0, 0)
		return
	end
	if getPlayerMoneyEx(source) < wschein.price then
		outputChatBox("Fehler: Du hast nicht genug Geld bei dir. Der Waffenschein kostet "..tostring(wschein.price).." Vero.", source, 255, 0, 0)
		return
	end
	local playername = getPlayerName(source)
	triggerClientEvent ( wschein.giver, "addNotification", getRootElement(), 3, 15,150,190, getPlayerName(source).." hat seine Rechnung über "..tostring(wschein.price).." Vero bezahlt." )
	outputChatBox("Du hast den Waffenschein der Stufe "..tostring(wschein.schein).." "..playername.." gegeben.", wschein.giver,0,255,0)
	outputChatBox("Du hast den Waffenschein der Stufe "..tostring(wschein.schein).." von "..getPlayerName(wschein.giver).." erhalten.", source,0,255,0)
	setElementData(source, "wschein", wschein.schein)
	removeElementData(source, "pWScheinData")
	removeAcceptCommand(source, "waffenschein")
	systemDeposit("Polizei", wschein.price)
	setElementData(wschein.giver, "einnahmen", getElementData(wschein.giver, "einnahmen")+wschein.price)
	setElementData(wschein.giver, "einnahmen2", getElementData(wschein.giver, "einnahmen2")+wschein.price)
	takePlayerMoneyEx(source, wschein.price)
end

function g_AcceptEvents.fuehrerschein(source) 
	local fschein = getElementData(source, "pFScheinData")
	if not fschein then
		outputChatBox("Fehler: Dir wurde kein Führerschein angeboten.", source, 255, 0, 0)
		return
	end
	if getPlayerMoneyEx(source) < fschein.price then
		outputChatBox("Fehler: Du hast nicht genug Geld bei dir. Der "..fschein.name.." kostet "..tostring(fschein.price).." Vero.", source, 255, 0, 0)
		return
	end
	local playername = getPlayerName(source)
	triggerClientEvent ( fschein.giver, "addNotification", getRootElement(), 3, 15,150,190, getPlayerName(source).." hat seine Rechnung über "..tostring(fschein.price).." Vero bezahlt." )
	outputChatBox("Du hast den "..fschein.name.." von "..getPlayerName(fschein.giver).." bekommen.", source,0,255,0)
	outputChatBox(playername.." hat den "..fschein.name.." für "..tostring(fschein.price).." Vero angenommen.", fschein.giver,0,255,0)
	setElementData(source, fschein.element, true)
	removeElementData(source, "pFScheinData")
	removeAcceptCommand(source, "fuehrerschein")
	systemDeposit("Polizei", fschein.price)
	setElementData(fschein.giver, "einnahmen", getElementData(fschein.giver, "einnahmen")+fschein.price)
	setElementData(fschein.giver, "einnahmen2", getElementData(fschein.giver, "einnahmen2")+fschein.price)
	takePlayerMoneyEx(source, fschein.price)
end
function g_AcceptEvents.heilung(source) 
	local heal = getElementData(source, "pHealData")
	if not heal then
		outputChatBox("Fehler: Dir wurde keine Heilung angeboten.", source, source, 255, 0, 0)
		return
	end
	if getPlayerMoneyEx(source) < heal.price then
		outputChatBox("Fehler: Du hast nicht genug Geld bei dir um den Sanitäter zu bezahlen.", source, 255, 0, 0)
		return
	end
	
	local x,y,z = getElementPosition(heal.giver)
	local x1,y1,z1 = getElementPosition(source)
	local distance = getDistanceBetweenPoints2D ( x,y,x1,y1 ) 
	if(distance < 10) then
		triggerClientEvent ( heal.giver, "addNotification", getRootElement(), 3, 15,150,190, getPlayerName(source).." hat seine Rechnung über "..tostring(heal.price).." Vero bezahlt." )
		outputChatBox("Du hast "..tostring(getPlayerName(source)).." geheilt.",heal.giver,0,255,0)
		outputChatBox("Du wurdest geheilt. Kosten: "..tostring(heal.price).." Vero.",source,0,255,0)
		setElementHealth(source, 100)
		setElementData(source, "injured", nil)
		removeAcceptCommand(source, "heilung")
		systemDeposit("Krankenhaus", heal.price)
		setElementData(heal.giver, "einnahmen", getElementData(heal.giver, "einnahmen")+heal.price)
		setElementData(heal.giver, "einnahmen2", getElementData(heal.giver, "einnahmen2")+heal.price)
		takePlayerMoneyEx(source, heal.price)
	else
		outputChatBox("Fehler: Du bist zu weit vom Sanitäter entfernt.", source, 255, 0, 0)
		return
	end
end

function g_AcceptEvents.rechnung(source) 
	local rechnung = getElementData(source, "pRechnungData")
	if not rechnung then                                                                                                         
		outputChatBox("Fehler: Du hast keine Rechnung erhalten.", source, source, 255, 0, 0)
		return
	end
	if getPlayerMoneyEx(source) < rechnung.price and (getVehFK(source) ~= "1" or (getElementData(rechnung.giver, "job") ~= 4 and getElementData(rechnung.giver, "job") ~= 8 and getElementData(rechnung.giver, "job") ~= 1) or getElementData(source, "dienst") == 0) then
		outputChatBox("Fehler: Du hast nicht genug Geld bei dir um die Rechnung zu bezahlen. Kosten: "..tostring(rechnung.price).." Vero.", source, 255, 0, 0)
		return
	end
	
	triggerClientEvent ( rechnung.giver, "addNotification", getRootElement(), 3, 15,150,190, getPlayerName(source).." hat seine Rechnung über "..tostring(rechnung.price).." Vero bezahlt." )
	outputChatBox(getPlayerName(source).." hat seine Rechnung bezahlt.",rechnung.giver,0,255,0)
	pLogger["rechnungen"]:addEntry(getPlayerName(source).." hat die Rechnung von "..getPlayerName(rechnung.giver).." ueber "..tostring(rechnung.price).." Vero bezahlt.")
	removeAcceptCommand(source, "rechnung")
	setElementData(rechnung.giver, "einnahmen", getElementData(rechnung.giver, "einnahmen")+rechnung.price)
	setElementData(rechnung.giver, "einnahmen2", getElementData(rechnung.giver, "einnahmen2")+rechnung.price)	
	if getVehFK(source) ~= "1" or (getElementData(rechnung.giver, "job") ~= 4 and getElementData(rechnung.giver, "job") ~= 8 and getElementData(rechnung.giver, "job") ~= 1) or getElementData(source, "dienst") == 0 or getElementData(rechnung.giver, "job") == getElementData(source, "job") then
		outputChatBox("Du hast die Rechnung von "..getPlayerName(rechnung.giver).." über "..tostring(rechnung.price).." Vero bezahlt.",source,0,255,0)
		takePlayerMoneyEx(source, rechnung.price)
		systemDeposit(getJobBankName(getElementData(rechnung.giver, "job")), rechnung.price)
	else
		 systemTransfer(getJobBankName(getElementData(source, "job")), getJobBankName(getElementData(rechnung.giver, "job")), rechnung.price, "Firmen-Rechnung")
		 outputChatBox("Du hast die Rechnung von "..getPlayerName(rechnung.giver).." über "..tostring(rechnung.price).." Vero bezahlt. (Firmenkonto)",source,0,255,0)
	end
end

-- /rechnung
addCommandHandler("rechnung", 
	function (source, command, target, price)
	if getElementData(source, "job") ~= 0 and getElementData(source, "dienst") == 1 then
		target = getPlayerFromName2(target)
		if target then
			if type(target) == "table" then
				outputChatBox("Fehler: Mehrere Spieler gefunden!",source,255,0,0)
				return
			end
			if target == source then return end
			local targetname = getPlayerName(target)
			price = tonumber(price)
			if not price or price < 0 then
				outputChatBox("Fehler: /rechnung [Spielername] [Preis]",source,255,0,0)
				return
			end
			pLogger["rechnungen"]:addEntry("Rechnung über "..tostring(price).." von "..getPlayerName(source).." an "..targetname)
			outputChatBox("Du hast "..targetname.." eine Rechnung über "..tostring(price).." Vero ausgestellt.", source,0,255,0)
			triggerClientEvent ( target, "addNotification", getRootElement(), 3, 15,150,190, "Du hast eine neue Rechnung erhalten.\nVon "..getPlayerName(source).." über "..tostring(price).." Vero." )
			outputChatBox("Dir wurde von "..getPlayerName(source).." eine Rechnung über "..tostring(price).." Vero ausgestellt.",target,0,255,0)
			outputChatBox("Benutze '/annehmen Rechnung' um ihn anzunehmen.",target,0,255,0)
			addAcceptCommand(target, "rechnung")
			setElementData(target, "pRechnungData", { ["price"] = price, ["giver"] = source })
		else
			outputChatBox("Fehler: /rechnung [Spielername] [Preis]",source,255,0,0)
		end
	end
end
)

--[[
function addAdvert(player, command, text)
	if text ~= "" and text ~= nil then
		local textlen = string.len(text)
		local widthdrawmoney = textlen*10
		if getPlayerMoneyEx(player) >= widthdrawmoney then
			takePlayerMoney(player, widthdrawmoney)
			addJobMoney(getBankAccount("SASO"), widthdrawmoney)
			addAdvertText(text)
			outputChatBox("Du hast erfolgreich deine Werbung hinzugefügt!", player, 255, 0, 0)
		else
			outputChatBox("Du hast zu wenig Geld, ein Buchstabe kostet 10 Vero!", player, 255, 0, 0) 
		end
	else
		outputChatBox("Fehler: /werbung [Text]",player,255,0,0)
	end
end
addCommandHandler("werbung", addAdvert, false, false)
--]]

-- Autohaus Befehle
function vehicleOrder(ply, command, vehicleModel)
	if getElementData(ply, "job") == 1 and getElementData(ply, "dienst") == 1 and (vehicleModel ~= "" and vehicleModel ~= nil) then -- LKW-Fahrer
		local vehicleModelFixed = string.gsub(vehicleModel, "-", " ")
		local vmodel = getVehicleModelFromName ( vehicleModelFixed )
		local check
		if not vmodel then vmodel = getVehicleModelFromName ( vehicleModel ) end
		if vmodel then
			check = createVehicle(vmodel, 0,0,0,0,0,0, "Autohaus")
		end
		if check then
			destroyElement(check)
			local fgeld = getBankAccountMoney("Autohaus")
			if (fgeld - gVehicleData[vmodel].price) >= 0 then
				local ex, ey, ez = getTrailerPos()
				if ex ~= 0.0 and ey ~= 0.0  and ez ~= 0.0 then
					systemWithdraw("Autohaus", gVehicleData[vmodel].price)
					createRPGVehicle(vmodel, ex, ey, ez, 180, "Autohaus", {{255,255,255},{255,255,255},{255,255,255},{255,255,255}}, false, true)
					outputChatBox("Fahrzeug erfolgreich bestellt.",ply,0,255,0)
					pLogger["autobestellung"]:addEntry(getPlayerName(ply).." hat einen "..getVehicleNameFromModel(vmodel).." bestellt.")
				else
					outputChatBox("Du kannst dieses Fahrzeug nicht bestellen, da der Hafen voll ist.",ply,255,0,0)	
				end
			else
				outputChatBox("Du hast nicht genug Geld um dieses Fahrzeug zu bestellen.",ply,255,0,0)						
			end
		end	
	end
end
addCommandHandler("bestellen", vehicleOrder, false, false)

function sellVehicle(ply, command, money)
    if getElementData(ply, "job") == 1 and getElementData(ply, "dienst") == 1 and (money ~= "" and money ~= nil) then
		vehicle = getPedOccupiedVehicle ( ply )
		if vehicle then
			if getElementData(vehicle, "owner") == "Autohaus" or getElementData(vehicle, "owner") == "1" then
				local vt = gVehicleData[getElementModel(vehicle)]
				if not vt then
					outputChatBox("Dieses Fahrzeug kann nicht zum Verkauf gestellt werden.",ply,255,0,0)	
					return
				end
				if tonumber(money) < vt.price + 800 then
					outputChatBox("Dieses Fahrzeug muss für Mindestens "..tostring(vt.price+800).." Vero zum Verkauf gestellt werden.",ply,255,0,0)	
					return
				end
				setElementData ( vehicle, "vstatus", true )	
				setElementData ( vehicle, "preis", tonumber(money) )
				pLogger["autoverkauf"]:addEntry(getPlayerName(ply).." hat einen "..getVehicleNameFromModel(getElementModel(vehicle)).." für "..money.." zum Verkauf gestellt")
				outputChatBox("Dieses Fahrzeug ist nun für "..money.." Vero zum Verkauf gestellt.",ply,0,255,0)
			else
				outputChatBox("Dieses Fahrzeug kann nicht zum Verkauf gestellt werden.",ply,255,0,0)	
			end
		end
	end
end
addCommandHandler("verkaufe", sellVehicle, false, false)

function sellVehicle(ply, command, money)
    if (getElementData(ply, "job") == 5 or getElementData(ply, "job") == 11) and getElementData(ply, "dienst") == 1 and (money ~= "" and money ~= nil) then
		vehicle = getPedOccupiedVehicle ( ply )
		if vehicle then
			if (getElementData(vehicle, "owner") == "5" and getElementData(ply, "job") == 5) or (getElementData(vehicle, "owner") == "11" and getElementData(ply, "job") == 11)  then
				local vt = gVehicleData[getElementModel(vehicle)]
				if not vt then
					outputChatBox("Dieses Fahrzeug kann nicht zum Verkauf gestellt werden.",ply,255,0,0)	
					return
				end
				setElementData ( vehicle, "vstatus", true )	
				setElementData ( vehicle, "preis", tonumber(money) )
				if (getElementData(ply, "job") == 5) then setElementData ( vehicle, "keys", "Autohus" ) else setElementData ( vehicle, "keys", "car4you" ) end	
				setVehicleDamageProof ( vehicle, true )
				pLogger["autoverkauf"]:addEntry(getPlayerName(ply).." hat einen "..getVehicleNameFromModel(getElementModel(vehicle)).." für "..money.." zum Gebrauchtwagenerkauf gestellt")
				outputChatBox("Dieses Fahrzeug ist nun für "..money.." Vero zum Verkauf gestellt.",ply,0,255,0)
			else
				outputChatBox("Dieses Fahrzeug kann nicht zum Verkauf gestellt werden.",ply,255,0,0)	
			end
		end
	end
end
addCommandHandler("gwverkauf", sellVehicle, false, false)

function reserveVehicle(ply, command, name)
    if (getElementData(ply, "job") == 1 or getElementData(ply, "job") == 5 or getElementData(ply, "job") == 11) and getElementData(ply, "dienst") == 1 and (name ~= "" and name ~= nil) then
		vehicle = getPedOccupiedVehicle ( ply )
		if vehicle then
			if getElementData(vehicle, "owner") == "Autohaus" or getElementData(vehicle, "owner") == "1" or getElementData(vehicle, "owner") == "5" or getElementData(vehicle, "owner") == "11" then
				local vt = gVehicleData[getElementModel(vehicle)]
				if not vt then
					outputChatBox("Dieses Fahrzeug kann nicht für einen Spieler reserviert werden.",ply,255,0,0)	
					return
				end
				setElementData ( vehicle, "reserviert", name )
				outputChatBox("Dieses Fahrzeug ist nun für "..name.." reserviert worden.",ply,0,255,0)
			else
				outputChatBox("Dieses Fahrzeug kann nicht für einen Spieler reserviert werden.",ply,255,0,0)	
			end
		end
	end
end
addCommandHandler("reserviere", reserveVehicle, false, false)


-- Fahrschul Befehle
gFscheinTyp = {
	[1] = { name = "Führerschein", element="aschein" },
	[2] = { name = "Motorradführerschein", element="mschein" },
	[3] = { name = "LKW-Schein", element="bschein" },
	[4] = { name = "Flugschein", element="fschein" }
}

function changePiF( source, commandName, playername, punkte ) --Auch Polizei
	if(playername ~= "" and playername ~= nil and punkte ~= "" and punkte ~= nil) then	
		if (getElementData(source, "job") == 3 or getElementData(source, "job") == 10) and getElementData(source, "dienst") == 1 and getElementData(source, "rank") >=  0 then
		    local player = getPlayerFromName2 ( playername )
			if player then
				if type(player) == "table" then
					outputChatBox("Fehler: Mehrere Spieler gefunden!",source,255,0,0)
					return
				end
				if tonumber(getElementData(player, "pif")) < tonumber(punkte) and getElementData(source, "job") == 10 then return outputChatBox("Du kannst als Fahrschullehrer Punkte nicht erhöhen.",source,255,0,0) end
--				if tonumber(getElementData(player, "pif")) > tonumber(punkte) and getElementData(source, "job") == 3 then return outputChatBox("Du kannst als Polizist Punkte nicht verringern.",source,255,0,0) end
				playername = getPlayerName(player)
				outputChatBox("Du hast die PiF von "..playername.." auf "..punkte.." gesetzt.", source,0,255,0)
				outputChatBox("Deine PiF wurden von "..getPlayerName(source).." auf "..punkte.." gesetzt.", player,0,255,0)
				setElementData(player, "pif", punkte)
			else
				outputChatBox("Dieser Spieler existiert nicht.",source,255,0,0)
			end
		end
	else
		outputChatBox("Fehler: /pif [Spielername] [Punkte]",source,255,0,0)
	end
end
addCommandHandler("pif", changePiF, false, false)

function changeDrivingLicense( source, commandName, playername, fschein, preis)
	if(fschein ~= "" and fschein ~= nil and playername ~= "" and playername ~= nil ) then	
		if (getElementData(source, "job") == 3 and getElementData(source, "dienst") == 1 and getElementData(source, "rank") >= 0 ) then
		    local player = getPlayerFromName2( playername )
			if player then
				if type(player) == "table" then
					outputChatBox("Fehler: Mehrere Spieler gefunden!",source,255,0,0)
					return
				end
				playername = getPlayerName(player)
				fscheinstatus = tonumber(fscheinstatus)
				fschein = tonumber(fschein)
				if fschein == false or fschein > 4 or fschein < 1 then
					outputChatBox("Dieser Führerschein exisitiert nicht.",source,255,0,0)
					return
				end
		
				preis = tonumber(preis)
				if preis < 0 then return end
				
				if not preis then
					outputChatBox("Der Preis muss eine Zahl sein.",source,255,0,0)
					return
				end
				pLogger["rechnungen"]:addEntry("Führerschein über "..tostring(preis).." von "..getPlayerName(source).." an "..playername)
				outputChatBox("Du hast "..playername.." den "..tostring(gFscheinTyp[tonumber(fschein)].name).." für "..tostring(preis).." angeboten.", source,0,255,0)
				outputChatBox("Dir wurde der "..tostring(gFscheinTyp[tonumber(fschein)].name).." von "..getPlayerName(source).." für "..tostring(preis).." angeboten.",player,0,255,0)
				outputChatBox("Benutze '/annehmen Fuehrerschein' um ihn anzunehmen.",player,0,255,0)
				addAcceptCommand(player, "fuehrerschein")
				setElementData(player, "pFScheinData", { ["price"] = preis, ["fschein"] = fschein, ["element"] = tostring(gFscheinTyp[tonumber(fschein)].element), ["name"] = tostring(gFscheinTyp[tonumber(fschein)].name), ["giver"] = source })
			else
				outputChatBox("Dieser Spieler existiert nicht.",source,255,0,0)
			end
		end
	else
		outputChatBox("Fehler: /fschein [Spielername] [Typ] [Preis]",source,255,0,0)
	end
end
addCommandHandler("fschein", changeDrivingLicense, false, false)

local fvehs = {}
function makeFahrschule(ply,command)
	if getElementData(ply, "job") == 10 or getElementData(ply, "job") == 3 and getElementData(ply, "dienst") == 1 then
		local veh = getPedOccupiedVehicle(ply)
		if not veh or getElementModel(veh) ~= 405 then outputChatBox("Fehler: Du musst in einem Sentinel sein!",ply,255,0,0) return end
		if fvehs[veh] then
			destroyElement(fvehs[veh])
			fvehs[veh] = nil
			outputChatBox("Du hast das Fahrschulschild vom Dach abmontiert.",ply,0,255,0)
		else
			local x,y,z = getElementPosition(ply)
			local rx,ry,rz = getElementRotation(ply)
			fvehs[veh] = createObject(1253, x, y, z, 0.0, 0.0, rz)
			setElementCollisionsEnabled ( fvehs[veh], false )
			attachElements ( fvehs[veh], veh, 0,0,0.85,0,0,90 )
			outputChatBox("Du hast das Fahrschulschild aufs Dach angebracht.",ply,0,255,0)
		end
	end
end
addCommandHandler("fschild", makeFahrschule, false, false)

-- Sanitäter Befehle
function healPlayer(ply, command, playerToHeal, preis)
	if getElementData(ply, "job") == 7 and getElementData(ply, "dienst") == 1 then
		if playerToHeal ~= "" and playerToHeal ~= nil then
			thePersonToHeal = getPlayerFromName2 ( playerToHeal )
			if thePersonToHeal then
				if type(thePersonToHeal) == "table" then
					outputChatBox("Fehler: Mehrere Spieler gefunden!",ply,255,0,0)
					return
				end
				preis = tonumber(preis)
				if preis < 0 then return end
				
				if not preis then
					outputChatBox("Der Preis muss eine Zahl sein.",ply,255,0,0)
					return
				end
				
				if thePersonToHeal == ply then
					outputChatBox("Fehler: Du kannst dich nicht selbst heilen!",ply,255,0,0)
					return
				end
				
				playerToHeal = getPlayerName(thePersonToHeal)
				pLogger["rechnungen"]:addEntry("Heilung über "..tostring(preis).." von "..getPlayerName(ply).." an "..playerToHeal)
				outputChatBox("Du hast "..playerToHeal.." Angeboten ihn für "..tostring(preis).." zu heilen.", ply,0,255,0)
				outputChatBox("Dir wurde von "..getPlayerName(ply).." für "..tostring(preis).." eine Heilung angeboten.",thePersonToHeal,0,255,0)
				outputChatBox("Benutze '/annehmen Heilung' um ihn anzunehmen.",thePersonToHeal,0,255,0)
				addAcceptCommand(thePersonToHeal, "heilung")
				setElementData(thePersonToHeal, "pHealData", { ["price"] = preis, ["giver"] = ply })

			end
		else
			outputChatBox("Fehler: /heilen [Spielername] [Geld]",ply,255,0,0)
		end
	end
end
addCommandHandler("heilen",healPlayer, false, false)

function revivePlayer(ply, command, playerToHeal)
	if getElementData(ply, "job") == 7 and getElementData(ply, "dienst") == 1 then
		if playerToHeal ~= "" and playerToHeal ~= nil then
			thePersonToHeal = getPlayerFromName2 ( playerToHeal )
			if thePersonToHeal then
				if type(thePersonToHeal) == "table" then
					outputChatBox("Fehler: Mehrere Spieler gefunden!",ply,255,0,0)
					return
				end
				if thePersonToHeal == ply then
					outputChatBox("Fehler: Du kannst dich nicht selbst wiederbeleben!",ply,255,0,0)
					return
				end
				playerToHeal = getPlayerName(thePersonToHeal)
				local x,y,z = getElementPosition(ply)
				local x1,y1,z1 = getElementPosition(thePersonToHeal)
				local distance = getDistanceBetweenPoints2D ( x,y,x1,y1 ) 
				if(distance < 10) then
					if getElementData(thePersonToHeal, "isWaitingForDeath") == true then
						outputChatBox("Du hast "..tostring(playerToHeal).." wiederbelebt.",ply,0,255,0)
						outputChatBox("Du wurdest wiederbelebt.",thePersonToHeal,0,255,0)
						setElementHealth(thePersonToHeal, 100)
						setElementData(thePersonToHeal, "isWaitingForDeath", false)
						killTimer(hospitalTimer[thePersonToHeal])
						setPedAnimation(thePersonToHeal)
						toggleAllControls (thePersonToHeal,true)
						setElementFrozen ( thePersonToHeal, false )	
						setElementData(thePersonToHeal, "isDead", false)
						setElementData(ply, "einnahmen", getElementData(ply, "einnahmen")+500)
						setElementData(ply, "einnahmen2", getElementData(ply, "einnahmen2")+500)	
						systemDeposit("Krankenhaus", 500)
					else
						outputChatBox(tostring(playerToHeal).." kann nicht wiederbelebt werden, da er nicht tot ist.",ply,255,0,0)
					end
				end
			end
		else
			outputChatBox("Fehler: /wiederbeleben [Spielername]",ply,255,0,0)
		end
	end
end
addCommandHandler("wiederbeleben",revivePlayer, false, false)

function fixAutohaendlerVehicles(source)
	if getElementData(source, "job") == 1 and getElementData(source, "dienst") == 1 then
		for k, v in pairs(getElementsByType("vehicle")) do
			if getElementData ( v, "keys" ) == "Autohaus" then
				fixVehicle(v)
				setElementData(v, "panne", false)
			end
		end
		outputChatBox("Alle Aresfahrzeuge wurden repariert.", source, 255, 255, 255)
	end
end
addCommandHandler("rep", fixAutohaendlerVehicles, false, false)

function fixGWhaendlerVehicles(source)
	if (getElementData(source, "job") == 5 and getElementData(source, "dienst") == 1) then
		for k, v in pairs(getElementsByType("vehicle")) do
			if getElementData ( v, "keys" ) == "Autohus" then
				fixVehicle(v)
				setElementData(v, "panne", false)
			end
		end
		outputChatBox("Alle Autohusfahrzeuge wurden repariert.", source, 255, 255, 255)
	elseif (getElementData(source, "job") == 11 and getElementData(source, "dienst") == 1) then
			for k, v in pairs(getElementsByType("vehicle")) do
			if getElementData ( v, "keys" ) == "car4you" then
				fixVehicle(v)
				setElementData(v, "panne", false)
			end
		end
		outputChatBox("Alle car4youfahrzeuge wurden repariert.", source, 255, 255, 255)	
	end
end
addCommandHandler("gwrep", fixGWhaendlerVehicles, false, false)

-- Autofix
addCommandHandler("einladen", 
	function(source)
		local veh = getPedOccupiedVehicle(source)
		if not veh then 
			outputChatBox("Fehler: Dieser Command funktioniert nur in einem 'Pony' oder in einem 'DFT-30'", source, 255, 0, 0)
			return
		end
		local model = getElementModel(veh)
		if model ~= 578 and model ~= 413 and model ~= 482 and model ~= 443 then 
			outputChatBox("Fehler: Dieser Command funktioniert nur in einem 'Pony' oder in einem 'DFT-30'", source, 255, 0, 0)
			return
		end
		-- DFT  = 578
		-- Pony = 413
		-- Packer = 443
		if model == 413 or model == 482 and getElementData(source, "job") == 5 then
			local vehiclesToAttach = {}
			-- Sind bereits Fahrzeuge im Pony?
			local containedVehicles = getElementData(veh, "containedVehicles")
			if containedVehicles then
				outputChatBox("Fehler: In dieses Fahrzeug passt maximal 1 Motorrad.", source, 255, 0, 0)
				return
			end
			-- Colshape erstellen
			local x, y, z = getElementWorldFromLocal(veh, -0.5, -5, 0)
			local cs = createColSphere(x, y, z, 3)
			for k, v in pairs(getElementsWithinColShape(cs, "vehicle")) do 
				-- Nur Fahrräder und Motorräder in den Pony
				if getVehicleType(v) == "BMX" or getVehicleType(v) == "Bike" then
					vehiclesToAttach[#vehiclesToAttach+1] = v
					break
				end
			end
			destroyElement(cs)
			-- Keine Fahrzeuge gefunden?
			if #vehiclesToAttach == 0 then
				outputChatBox("Fehler: Keine gültigen Fahrzeuge zum einladen gefunden.", source, 255, 0, 0)
				return					
			end
			
			-- Einladen
			for k, v in pairs(vehiclesToAttach) do 
				disableEntering(v, 0)
				disableEntering(v, 1)
				disableEntering(v, 3)
				disableEntering(v, 4)
				attachElements(v, veh,  0, -1, 0.287)
				setElementCollisionsEnabled ( v, false)
				pLogger["abschlepper"]:addEntry( getPlayerName ( source ).." hat eine(n) "..getVehicleName ( v ).." (ID:"..tostring(getElementData(v, "model"))..") von ".. (getElementData(v, "owner")) .." in einen Pony eingeladen." )
			end
			disableEntering(veh, 2)
			disableEntering(veh, 3)
			setElementData(veh, "containedVehicles", vehiclesToAttach)
		elseif model == 578 or model == 443 then
			local vehiclesToAttach = {}
			-- Sind bereits Fahrzeuge auf dem DFT?
			local containedVehicles = getElementData(veh, "containedVehicles")
			if containedVehicles then
				outputChatBox("Fehler: Du musst erst die Fahrzeuge ablegen.", source, 255, 0, 0)
				return
			end
			-- Colshape erstellen
			local x, y, z = getElementWorldFromLocal(veh, 0, -3, 2)

			local cs = createColSphere(x, y, z, 5)
			for k, v in pairs(getElementsWithinColShape(cs, "vehicle")) do 
				if getVehicleType(v) ~= "Plane" and getVehicleType(v) ~= "Train" and getVehicleType(v) ~= "Monster Truck" and v ~= veh then
					vehiclesToAttach[#vehiclesToAttach+1] = v
		
				end
			end
			destroyElement(cs)
			-- Keine Fahrzeuge gefunden?
			if #vehiclesToAttach == 0 then
				outputChatBox("Fehler: Keine gültigen Fahrzeuge zum einladen gefunden.", source, 255, 0, 0)
				return
			end
			
			-- Einladen
			local xoff, yoff, zoff
			local xroff, yroff, zroff
			local xr, yr, zr = getElementRotation(veh)
			for k, v in pairs(vehiclesToAttach) do 
				xoff, yoff, zoff = getElementLocalFromWorld(veh, getElementPosition(v))
				xroff, yroff, zroff = getElementRotation(v)
				xroff = xroff - xr
				yroff = yroff - yr
				zroff = zroff - zr
				disableEntering(v, 0)
				disableEntering(v, 1)
				disableEntering(v, 3)
				disableEntering(v, 4)
				attachElements(v, veh, xoff, yoff, zoff+0.1, xroff, yroff, zroff)
				setElementSyncer(v, source)
				pLogger["abschlepper"]:addEntry( getPlayerName ( source ).." hat eine(n) "..getVehicleName ( v ).." (ID:"..tostring(getElementData(v, "model"))..") von ".. (getElementData(v, "owner")) .." in einen DFT eingeladen." )
			end
			setElementData(veh, "containedVehicles", vehiclesToAttach)
		end
	end
)

addCommandHandler("ausladen", 
	function(source)
		local veh = getPedOccupiedVehicle(source)
		if not veh then 
			outputChatBox("Fehler: Dieser Command funktioniert nur in einem 'Pony' oder in einem 'DFT-30'", source, 255, 0, 0)
			return
		end
		local model = getElementModel(veh)
		if model ~= 578 and model ~= 413 and model ~= 482 and model ~= 443 then 
			outputChatBox("Fehler: Dieser Command funktioniert nur in einem 'Pony' oder in einem 'DFT-30'", source, 255, 0, 0)
			return
		end
		-- DFT  = 578
		-- Pony = 413
		if model == 413 or model == 482 and getElementData(source, "job") == 5 then
			-- Sind keine Fahrzeuge im Pony?
			local containedVehicles = getElementData(veh, "containedVehicles")
			if not containedVehicles then
				outputChatBox("Fehler: In dieses Fahrzeug ist kein Motorrad.", source, 255, 0, 0)
				return
			end
			for k, v in pairs(containedVehicles) do
				enableEntering(v, 0)
				enableEntering(v, 1)
				enableEntering(v, 3)
				enableEntering(v, 4)
				detachElements(v, veh)
				setElementPosition(v, getElementWorldFromLocal(veh, -0.5, -5, 0))
				setElementCollisionsEnabled ( v, true)
			end
			removeElementData(veh, "containedVehicles")
			enableEntering(veh, 2)
			enableEntering(veh, 3)
		elseif model == 578 or model == 443 then
			-- Sind keine Fahrzeuge im DFT?
			local containedVehicles = getElementData(veh, "containedVehicles")
			if not containedVehicles then
				outputChatBox("Fehler: Es sind keine Fahrzeuge aufgeladen.", source, 255, 0, 0)
				return
			end
			for k, v in pairs(containedVehicles) do
				enableEntering(v, 0)
				enableEntering(v, 1)
				enableEntering(v, 3)
				enableEntering(v, 4)
				detachElements(v, veh)
			end
			removeElementData(veh, "containedVehicles")
		end
	end
)

function abortEnter(player, seat)
	local seatBlocked = getElementData(source, "seatsBlocked")
	if seatBlocked and seatBlocked[seat] then
		cancelEvent()
	end
end

addEventHandler("onVehicleStartEnter", getRootElement(), abortEnter)

function disableEntering(vehicle, seat)
	local seatBlocked = getElementData(vehicle, "seatsBlocked")
	if not seatBlocked then
		seatBlocked = {}
	end
	seatBlocked[seat] = true
	setElementData(vehicle, "seatsBlocked", seatBlocked)
end
function enableEntering(vehicle, seat)
	local seatBlocked = getElementData(vehicle, "seatsBlocked")
	if not seatBlocked then
		seatBlocked = {}
	end
	seatBlocked[seat] = false
	setElementData(vehicle, "seatsBlocked", seatBlocked)
end

function getElementWorldFromLocal(element, x, y, z)
	local localEle = createObject(1301, 0, 0, 0)
	attachElements(localEle, element, x, y, z)
	x, y, z = getElementPosition(localEle)
	destroyElement(localEle)
	return x, y, z
end

function getElementLocalFromWorld(element, x, y, z)
    local toPosX, toPosY, toPosZ = getElementPosition( element )
    local toRotX, toRotY, toRotZ = getElementRotation( element )
    local offsetPosX = x - toPosX
    local offsetPosY = y - toPosY
    local offsetPosZ = z - toPosZ
    offsetPosX, offsetPosY, offsetPosZ = applyInverseRotation ( offsetPosX, offsetPosY, offsetPosZ, toRotX, toRotY, toRotZ )
	return offsetPosX, offsetPosY, offsetPosZ
end

function applyInverseRotation ( x,y,z, rx,ry,rz )
    -- Degress to radians
    local DEG2RAD = (math.pi * 2) / 360
    rx = rx * DEG2RAD
    ry = ry * DEG2RAD
    rz = rz * DEG2RAD
 
    -- unrotate each axis
    local tempY = y
    y =  math.cos ( rx ) * tempY + math.sin ( rx ) * z
    z = -math.sin ( rx ) * tempY + math.cos ( rx ) * z
 
    local tempX = x
    x =  math.cos ( ry ) * tempX - math.sin ( ry ) * z
    z =  math.sin ( ry ) * tempX + math.cos ( ry ) * z
 
    tempX = x
    x =  math.cos ( rz ) * tempX + math.sin ( rz ) * y
    y = -math.sin ( rz ) * tempX + math.cos ( rz ) * y
 
    return x, y, z
end

function Ambulancelicht( player )
	local vehk = getPedOccupiedVehicle ( player )
	local model = getElementModel ( vehk )
	if model == 416 or model == 596 then 
		if getElementData ( player, "job" ) == 7 and isPedInVehicle ( player )  then
			if getElementData ( vehk, "Ambulancelicht" ) and isTimer(getElementData ( vehk, "Ambulancelicht" )) then
				killTimer ( amtimer[vehk] )
				setVehicleLightState ( vehk, 0,  0 )
				setVehicleLightState ( vehk, 1,  0 )
				setVehicleHeadLightColor ( vehk, 255, 255, 255 )
				setVehicleOverrideLights ( vehk, 1 )
			else
				setVehicleHeadLightColor ( vehk, 255, 0, 0 )
				setVehicleOverrideLights ( vehk, 2 )
				amtimer[vehk] = setTimer ( function () setVehicleLightState ( vehk, 0, 1 ) setVehicleLightState ( vehk, 1, 0 )
				if isElement ( vehk ) == false or isElement ( vehk ) == nil then
					killTimer ( amtimer[vehk] )
				end
				setTimer ( function () setVehicleHeadLightColor ( vehk, 255, 0, 0 ) setVehicleLightState ( vehk, 0, 0 ) setVehicleLightState ( vehk, 1, 1 ) end, 500, 1, vehk ) end, 1000, 0 , vehk )
				setElementData ( vehk, "Ambulancelicht", amtimer[vehk] )
			end
		end
	end
end
addCommandHandler ( "rtwlicht", Ambulancelicht )