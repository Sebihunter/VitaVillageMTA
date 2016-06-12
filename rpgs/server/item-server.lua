--[[
Project: VitaOnline
File: item-server.lua
Author(s):	Sebihunter
			MrX
]]--

function saveAllRootDroppedItems()
	fileDelete( "./xml/items.xml")
	local xml = xmlCreateFile ( "./xml/items.xml", "items" )
	for _, item in ipairs(getElementsByType("object")) do
		if getElementData(item, "isPickupableObj") == true then
			local x, y, z = getElementPosition(item)
			local ix, iy, iz = getElementRotation(item)
			local ii = getElementInterior(item)
			local id = getElementDimension(item)
			local model = getElementModel(item)
			local vehnode = xmlCreateChild ( xml, "item" )
			local itemData = getElementDataTable(item)
			xmlNodeSetAttribute(vehnode, "model", model)
			xmlNodeSetAttribute(vehnode, "x", x)
			xmlNodeSetAttribute(vehnode, "y", y)
			xmlNodeSetAttribute(vehnode, "z", z)
			xmlNodeSetAttribute(vehnode, "ix", ix)
			xmlNodeSetAttribute(vehnode, "iy", iy)
			xmlNodeSetAttribute(vehnode, "iz", iz)
			xmlNodeSetAttribute(vehnode, "ii", ii)
			xmlNodeSetAttribute(vehnode, "id", id)
			xmlNodeSetAttribute(vehnode, "data", table.save(itemData))
		end
	end
	xmlSaveFile ( xml )
	xmlUnloadFile ( xml )
end		
addEventHandler("onResourceStop", getResourceRootElement(getThisResource()),saveAllRootDroppedItems)


function loadAllRootRPGDroppedItems()
	local xml = xmlLoadFile("xml/items.xml")
	local i = 0
	
	if xml then
		while true do 
			local vehnode = xmlFindChild ( xml, "item", i)
			if not vehnode then
				break
			end
			if vehnode then
				local x = tonumber(xmlNodeGetAttribute(vehnode, "x"))
				local y = tonumber(xmlNodeGetAttribute(vehnode, "y"))
				local z = tonumber(xmlNodeGetAttribute(vehnode, "z"))
				local ix = tonumber(xmlNodeGetAttribute(vehnode, "ix"))
				local iy = tonumber(xmlNodeGetAttribute(vehnode, "iy"))
				local iz = tonumber(xmlNodeGetAttribute(vehnode, "iz"))
				local ii = tonumber(xmlNodeGetAttribute(vehnode, "ii"))
				local id = tonumber(xmlNodeGetAttribute(vehnode, "id"))
				local model = tonumber(xmlNodeGetAttribute(vehnode, "model"))
				local itemData = xmlNodeGetAttribute(vehnode, "data")
				local item = createObject(model, x, y, z, ix, iy, iz)
				setElementData(item, "cinfo", {"Item aufnehmen"})
				setElementInterior(item, ii)
				setElementDimension(item, id)
				
				itemData = table.load(itemData)
				setElementDataTable(item, itemData)
				createClickableElement(item, pickUpItem)
				if getElementData(item, "isRadio") == true then
					callClientFunction(getRootElement(), "createRadio", item)
				end	
			end
			i = i+1
		end
		xmlUnloadFile(xml)
		print("__~~*"..tonumber(i).."*Items/s*Loaded!*~~__")
		setTimer(saveAllRootDroppedItems, 1800000, 0)
	else
		print("__~~*Failed to load Houses*~~__")
	end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), loadAllRootRPGDroppedItems)
		
--Funktion um Spieler Items verwenden zu lassen
function useItem(player, slotid)
	if not getElementData(player, "isPlayerLoggedIn") == true then return end
	if not getElementData(player, "isWaitingForDeath") == false then return end
	local itemid = getItemInSlot(player, slotid)
	if not itemid then return end
	itemid = itemid.itemid
	
	if not itemid then return end
-----------------------------------------------------------------------------------------------------------------------------------------------
	--Wir haben eine Cola getrunken
	if itemid == 0 then
		local h = getElementData(player, "getPlayerHunger") + 15
		if( h > 100 ) then h = 100 end
		setElementData(player, "getPlayerHunger", h)
		
		outputChatBox("Du hast dich mit einer Cola erfrischt.",player,0,255,0)
		triggerEvent ( "onPlayerChat", player, "trinkt eine Cola.", 1)
		setElementData(player,"getPlayerHarndrang", getElementData(player,"getPlayerHarndrang")-15)
		removeItem(player, slotid)
-----------------------------------------------------------------------------------------------------------------------------------------------		
	--Wir haben eine Wurstsemmel gegessen
	elseif itemid == 1 then
		local h = getElementData(player, "getPlayerHunger") + 30
		if( h > 100 ) then h = 100 end
		setElementData(player, "getPlayerHunger", h)
		
		outputChatBox("Die Wurstsemmel hat deinen Hunger getilgt.",player,0,255,0)
		triggerEvent ( "onPlayerChat", player, "isst eine Wurstsemmel.", 1)
		setElementData(player,"getPlayerHygiene", getElementData(player,"getPlayerHygiene")-10)
		removeItem(player, slotid)
-----------------------------------------------------------------------------------------------------------------------------------------------		
	--Wir sehen uns unseren Personalausweiß an
	elseif itemid == 2 then	
		outputChatBox("Du hast den Leuten in deiner Nähe den Ausweiß gezeigt.",player,0,255,0)
		local posX, posY, posZ = getElementPosition( player )
		local chatSphere = createColSphere( posX, posY, posZ, 5 )
		local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
		destroyElement( chatSphere )
		triggerEvent ( "onPlayerChat", player, "zeigt seinen Personalausweiß.", 1)
		for index, nearbyPlayer in ipairs( nearbyPlayers ) do
			executeCommandHandler ( "perso", player, getPlayerName(nearbyPlayer) )
		end
-----------------------------------------------------------------------------------------------------------------------------------------------		
	--Wir verwenden unseren Tankkanister
	elseif itemid == 3 then	
		if isPedInVehicle ( player ) == true then
			removeItem(player, slotid)
			local veh = getPedOccupiedVehicle ( player )
			if getPedOccupiedVehicleSeat ( player ) == 0 then
				setElementData(veh, "fuel", getElementData(veh, "fuel")+10)
				if getElementData(veh, "fuel") > 100 then
					setElementData(veh, "fuel", 100)
				end
				callClientFunction(player, "setVehicleFuelFromServer", getElementData(veh, "fuel"))
				outputChatBox("Du hast 10 Liter Treibstoff in dein Fahrzeug gefüllt.",player,0,255,0)	
				triggerEvent ( "onPlayerChat", player, "füllt 10 Liter Treibstoff nach.", 1)
			else
				outputChatBox("Du musst der Fahrer sein um den Kanister zu verwenden.",player,255,0,0)
			end
		else
			outputChatBox("Du kannst den Kanister nur in einem Fahrzeug verwenden.",player,255,0,0)
		end
-----------------------------------------------------------------------------------------------------------------------------------------------				
	--Wir versuchen das GPS zu verwenden
	elseif itemid == 4 then	
		outputChatBox("Das GPS wird automatisch in Fahrzeugen aktiviert.",player,255,0,0)
-----------------------------------------------------------------------------------------------------------------------------------------------						
	--Ein Reifenwechsel mit dem Ersatzreifen wird durchgeführt
	elseif itemid == 5 then	
		if isPedInVehicle ( player ) == true then
			for i,v in ipairs(getElementsByType("player")) do
				if getElementData(v, "job") == 4 and getElementData(v, "dienst") == 1 and getElementData(v, "afk") ~= true then
					outputChatBox("Es ist im Moment ein Mechaniker online. Du kannst den Ersatzreifen nicht verwenden.",player,255,0,0)
					return
				end
			end		
			removeItem(player, slotid)
			local veh = getPedOccupiedVehicle ( player )
			local w1, w2, w3, w4 = getVehicleWheelStates ( veh )
			for w = 1, 5 do
				if w == 1 then
					if w1 == 1 or w1 == 2 then
						setVehicleWheelStates ( veh, 0, w2, w3, w4)
						outputChatBox("Du hast deinen Ersatzreifen verwendet.",player,0,255,0)	
						triggerEvent ( "onPlayerChat", player, "verwendet seinen Ersatzreifen.", 1)
						break
					end
				elseif w == 2 then
					if w2 == 1 or w2 == 2 then
						setVehicleWheelStates ( veh, w1, 0, w3, w4)
						outputChatBox("Du hast deinen Ersatzreifen verwendet.",player,0,255,0)	
						triggerEvent ( "onPlayerChat", player, "verwendet seinen Ersatzreifen.", 1)						
						break
					end				
				elseif w == 3 then
					if w3 == 1 or w3 == 2 then
						setVehicleWheelStates ( veh, w1, w2, 0, w4)
						outputChatBox("Du hast deinen Ersatzreifen verwendet.",player,0,255,0)	
						triggerEvent ( "onPlayerChat", player, "verwendet seinen Ersatzreifen.", 1)					
						break
					end				
				elseif w == 4 then
					if w4 == 1 or w4 == 2 then
						setVehicleWheelStates ( veh, w1, w2, w3, 0)
						outputChatBox("Du hast deinen Ersatzreifen verwendet.",player,0,255,0)	
						triggerEvent ( "onPlayerChat", player, "verwendet seinen Ersatzreifen.", 1)						
						break
					end				
				else
					outputChatBox("Alle deine Räder sind in einem einwandfreiem Zusand.",player,255,0,0)	
				end
			end
		else
			outputChatBox("Du kannst den Ersatzreifen nur in einem Fahrzeug verwenden.",player,255,0,0)
		end
-----------------------------------------------------------------------------------------------------------------------------------------------		
	--Wir versuchen das Handy zu verwenden
	elseif itemid == 6 then	
		outputChatBox("Deine Telefonnummer ist: "..tostring(getItemData(player, slotid, "nummer"))..". Nutze /anrufen [nummer] um jemanden anzurufen.",player,0,255,0)	
-----------------------------------------------------------------------------------------------------------------------------------------------				
	--Wir haben ein Bier getrunken
	elseif itemid == 7 then
		local h = getElementData(player, "getPlayerHunger") + 15
		if( h > 100 ) then h = 100 end
		setElementData(player, "getPlayerHunger", h)
		
		outputChatBox("Prost! Du kippst ein Bier runter!",player,0,255,0)
		triggerEvent ( "onPlayerChat", player, "trinkt Bier.", 1)
		setElementData(player,"getPlayerHarndrang", getElementData(player,"getPlayerHarndrang")-15)
		setElementData(player,"promillesoll", getElementData(player,"promillesoll")+0.2)
		removeItem(player, slotid)
-----------------------------------------------------------------------------------------------------------------------------------------------		
	--Wir haben einen Kaffee getrunken
	elseif itemid == 8 then
		local h = getElementData(player, "getPlayerEnergie") + 10
		if( h > 100 ) then h = 100 end
		setElementData(player, "getPlayerEnergie", h)
		
		outputChatBox("Du hast dich mit einem Kaffee aufgeputscht.",player,0,255,0)
		triggerEvent ( "onPlayerChat", player, "trinkt einen Kaffee.", 1)
		setElementData(player,"getPlayerHarndrang", getElementData(player,"getPlayerHarndrang")-20)
		removeItem(player, slotid)	
-----------------------------------------------------------------------------------------------------------------------------------------------					
	--Wir statten uns mit einer Desert Eagle aus
	elseif itemid == 9 then
		giveWeapon(player, 24)
		triggerEvent ( "onPlayerChat", player, "stattet sich mit einer Desert Eagle aus.", 1)
		removeItem(player, slotid)	
-----------------------------------------------------------------------------------------------------------------------------------------------				
	--Wir statten uns mit einer MP5 aus
	elseif itemid == 10 then
		giveWeapon(player, 29, 60)
		triggerEvent ( "onPlayerChat", player, "stattet sich mit einer MP5 aus.", 1)
		removeItem(player, slotid)				
-----------------------------------------------------------------------------------------------------------------------------------------------			
	--Wir statten uns mit einem Schlagring aus
	elseif itemid == 11 then
		giveWeapon(player, 1,1)
		triggerEvent ( "onPlayerChat", player, "stattet sich mit einem Schlagring aus.", 1)
		removeItem(player, slotid)			
-----------------------------------------------------------------------------------------------------------------------------------------------			
	--Wir statten uns mit einem Golfschläger aus
	elseif itemid == 12 then
		giveWeapon(player, 2,1)
		triggerEvent ( "onPlayerChat", player, "stattet sich mit einem Golfschläger aus.", 1)
		removeItem(player, slotid)	
-----------------------------------------------------------------------------------------------------------------------------------------------			
	--Wir statten uns mit einem Schlagstock aus
	elseif itemid == 13 then
		giveWeapon(player, 3,1)
		triggerEvent ( "onPlayerChat", player, "stattet sich mit einem Schlagstock aus.", 1)
		removeItem(player, slotid)			
-----------------------------------------------------------------------------------------------------------------------------------------------			
	--Wir statten uns mit einem Messer aus
	elseif itemid == 14 then
		giveWeapon(player, 4,1)
		triggerEvent ( "onPlayerChat", player, "stattet sich mit einem Messer aus.", 1)
		removeItem(player, slotid)			
-----------------------------------------------------------------------------------------------------------------------------------------------			
	--Wir statten uns mit einem Baseballschläger aus
	elseif itemid == 15 then
		giveWeapon(player, 5,1)
		triggerEvent ( "onPlayerChat", player, "stattet sich mit einem Baseballschläger aus.", 1)
		removeItem(player, slotid)					
-----------------------------------------------------------------------------------------------------------------------------------------------			
	--Wir statten uns mit einer Schaufel aus
	elseif itemid == 16 then
		giveWeapon(player, 6,1)
		triggerEvent ( "onPlayerChat", player, "stattet sich mit einer Schaufel aus.", 1)
		removeItem(player, slotid)	
-----------------------------------------------------------------------------------------------------------------------------------------------			
	--Wir statten uns mit einem Billiardstock aus		
	elseif itemid == 17 then
		giveWeapon(player, 7,1)
		triggerEvent ( "onPlayerChat", player, "stattet sich mit einem Billiardstock aus.", 1)
		removeItem(player, slotid)	
-----------------------------------------------------------------------------------------------------------------------------------------------			
	--Wir statten uns mit einer Kettensäge		
	elseif itemid == 18 then
		giveWeapon(player, 8,1)
		triggerEvent ( "onPlayerChat", player, "stattet sich mit einer Katana aus.", 1)
		removeItem(player, slotid)
-----------------------------------------------------------------------------------------------------------------------------------------------			
	--Wir statten uns mit einer Kettensäge aus	
	elseif itemid == 19 then
		giveWeapon(player, 9,1)
		triggerEvent ( "onPlayerChat", player, "stattet sich mit einer Kettensäge aus.", 1)
		removeItem(player, slotid)
-----------------------------------------------------------------------------------------------------------------------------------------------			
	--Wir statten uns mit einem Stock aus	
	elseif itemid == 20 then
		giveWeapon(player, 15,1)
		triggerEvent ( "onPlayerChat", player, "stattet sich mit einem Stock aus.", 1)
		removeItem(player, slotid)
-----------------------------------------------------------------------------------------------------------------------------------------------			
	--Wir statten uns mit einer Pistole aus	
	elseif itemid == 21 then
		giveWeapon(player, 22,30)
		triggerEvent ( "onPlayerChat", player, "stattet sich mit einer Pistole aus.", 1)
		removeItem(player, slotid)
-----------------------------------------------------------------------------------------------------------------------------------------------			
	--Wir statten uns mit einer Schallgedämpften Pistole aus	
	elseif itemid == 22 then
		giveWeapon(player, 23,23)
		triggerEvent ( "onPlayerChat", player, "stattet sich mit einer Schallgedämpften Pistole aus.", 1)
		removeItem(player, slotid)
-----------------------------------------------------------------------------------------------------------------------------------------------			
	--Wir statten uns mit einer Schrotflinte aus	
	elseif itemid == 23 then
		giveWeapon(player, 25,30)
		triggerEvent ( "onPlayerChat", player, "stattet sich mit einer Schrotflinte aus.", 1)
		removeItem(player, slotid)
-----------------------------------------------------------------------------------------------------------------------------------------------			
	--Wir statten uns mit einer Abgesägten Schrotflinte aus	
	elseif itemid == 24 then
		giveWeapon(player, 25,30)
		triggerEvent ( "onPlayerChat", player, "stattet sich mit einer Abgesägten Schrotflinte aus.", 1)
		removeItem(player, slotid)			
-----------------------------------------------------------------------------------------------------------------------------------------------			
	--Wir statten uns mit einer SPAZ-12 aus	
	elseif itemid == 25 then
		giveWeapon(player, 27,100)
		triggerEvent ( "onPlayerChat", player, "stattet sich mit einer SPAZ-12 aus.", 1)
		removeItem(player, slotid)
-----------------------------------------------------------------------------------------------------------------------------------------------			
	--Wir statten uns mit einer Uzi aus	
	elseif itemid == 26 then
		giveWeapon(player, 28,100)
		triggerEvent ( "onPlayerChat", player, "stattet sich mit einer Uzi aus.", 1)
		removeItem(player, slotid)		
-----------------------------------------------------------------------------------------------------------------------------------------------				
	--Wir statten uns mit einer TEC-9 aus	
	elseif itemid == 27 then
		giveWeapon(player, 32,100)
		triggerEvent ( "onPlayerChat", player, "stattet sich mit einer TEC-9 aus.", 1)
		removeItem(player, slotid)	
-----------------------------------------------------------------------------------------------------------------------------------------------				
	--Wir statten uns mit einer AK-47 aus	
	elseif itemid == 28 then
		giveWeapon(player, 30,100)
		triggerEvent ( "onPlayerChat", player, "stattet sich mit einer AK-47 aus.", 1)
		removeItem(player, slotid)		
-----------------------------------------------------------------------------------------------------------------------------------------------				
	--Wir statten uns mit einer M4 aus	
	elseif itemid == 29 then
		giveWeapon(player, 31,100)
		triggerEvent ( "onPlayerChat", player, "stattet sich mit einer M4 aus.", 1)
		removeItem(player, slotid)	
-----------------------------------------------------------------------------------------------------------------------------------------------				
	--Wir statten uns mit einer Country Rifle aus	
	elseif itemid == 30 then
		giveWeapon(player, 33,30)
		triggerEvent ( "onPlayerChat", player, "stattet sich mit einer Country Rifle aus.", 1)
		removeItem(player, slotid)			
-----------------------------------------------------------------------------------------------------------------------------------------------				
	--Wir statten uns mit einer Sniper aus	
	elseif itemid == 31 then
		giveWeapon(player, 34,30)
		triggerEvent ( "onPlayerChat", player, "stattet sich mit einer Sniper aus.", 1)
		removeItem(player, slotid)	
-----------------------------------------------------------------------------------------------------------------------------------------------				
	--Wir statten uns mit einem Flammenwerfer aus	
	elseif itemid == 32 then
		giveWeapon(player, 37,100)
		triggerEvent ( "onPlayerChat", player, "stattet sich mit einem Flammenwerfer aus.", 1)
		removeItem(player, slotid)	
-----------------------------------------------------------------------------------------------------------------------------------------------				
	--Wir statten uns mit Granaten aus	
	elseif itemid == 33 then
		giveWeapon(player, 16,5)
		triggerEvent ( "onPlayerChat", player, "stattet sich mit Granaten aus.", 1)
		removeItem(player, slotid)	
-----------------------------------------------------------------------------------------------------------------------------------------------				
	--Wir statten uns mit Tränengas aus	
	elseif itemid == 34 then
		giveWeapon(player, 17,5)
		triggerEvent ( "onPlayerChat", player, "stattet sich mit Tränengas aus.", 1)
		removeItem(player, slotid)
-----------------------------------------------------------------------------------------------------------------------------------------------				
	--Wir statten uns mit Molotov Cocktails aus	
	elseif itemid == 35 then
		giveWeapon(player, 18,5)
		triggerEvent ( "onPlayerChat", player, "stattet sich mit Molotov Cocktails aus.", 1)
		removeItem(player, slotid)		
-----------------------------------------------------------------------------------------------------------------------------------------------				
	--Wir statten uns mit Rucksackbomben aus	
	elseif itemid == 36 then
		giveWeapon(player, 39,5)
		triggerEvent ( "onPlayerChat", player, "stattet sich mit Rucksackbomben aus.", 1)
		removeItem(player, slotid)		
-----------------------------------------------------------------------------------------------------------------------------------------------				
	--Wir statten uns mit einem Feuerlöscher aus	
	elseif itemid == 37 then
		giveWeapon(player, 42,500)
		triggerEvent ( "onPlayerChat", player, "stattet sich mit einem Feuerlöscher aus.", 1)
		removeItem(player, slotid)	
-----------------------------------------------------------------------------------------------------------------------------------------------				
	--Wir statten uns mit einem Nachtsichtgerät aus	
	elseif itemid == 38 then
		giveWeapon(player, 44,1)
		triggerEvent ( "onPlayerChat", player, "stattet sich mit einem Nachtsichtgerät aus.", 1)
		removeItem(player, slotid)	
-----------------------------------------------------------------------------------------------------------------------------------------------				
	--Wir statten uns mit einem Infrarotgerät aus	
	elseif itemid == 39 then
		giveWeapon(player, 45,1)
		triggerEvent ( "onPlayerChat", player, "stattet sich mit einem Infrarotgerät aus.", 1)
		removeItem(player, slotid)	
-----------------------------------------------------------------------------------------------------------------------------------------------				
	--Wir statten uns mit einem Fallschirm aus	
	elseif itemid == 40 then
		giveWeapon(player, 46,1)
		triggerEvent ( "onPlayerChat", player, "stattet sich mit einem Fallschirm aus.", 1)
		removeItem(player, slotid)
-----------------------------------------------------------------------------------------------------------------------------------------------						
	--Wir wollen eines der Strandtücher verwenden
	elseif itemid == 41 or itemid == 42 or itemid == 43 or itemid == 44 then
		outputChatBox("Bah du Ekelhafter! Willst du dein Strandtuch essen oder was!?!",player,255,0,0)
-----------------------------------------------------------------------------------------------------------------------------------------------				
	--Wir trinken Vodka
	elseif itemid == 45 then
		setElementData(player,"getPlayerHarndrang", getElementData(player,"getPlayerHarndrang")-15)
		setElementData(player,"promillesoll", getElementData(player,"promillesoll")+0.75)
		triggerEvent ( "onPlayerChat", player, "trinkt eine Flasche Vodka. Das wird Kopfschmerzen geben.", 1)
		removeItem(player, slotid)
-----------------------------------------------------------------------------------------------------------------------------------------------						
--Wir verwenden unser Radio
	elseif itemid == 46 then
		triggerEvent ( "onPlayerChat", player, "verwendet sein Radio.", 1)
		local item = dropItem(player, slotid)	
		setElementData(item, "isRadio", true)
		setElementData(item, "owner", getPlayerName(player))
		callClientFunction(getRootElement(), "createRadio", item)
		callClientFunction(player, "showRadioGUI", item)
-----------------------------------------------------------------------------------------------------------------------------------------------		
--Wir verwenden unser Verbandszeug
	elseif itemid == 48 then
		for i,v in ipairs(getElementsByType("player")) do
			if getElementData(v, "job") == 7 and getElementData(v, "dienst") == 1 and getElementData(v, "afk") ~= true then
				outputChatBox("Es ist im Moment ein Sanitäter online. Du kannst das Verbandszeug nicht verwenden.",player,255,0,0)
				return
			end
		end
		triggerEvent ( "onPlayerChat", player, "verwendet sein Verbandszeug.", 1)
		if getElementHealth(player) + 40 > 100 then
			setElementHealth(player, 100)
		else
			setElementHealth(player, getElementHealth(player)+40)
		end
		setElementData(player, "injured", nil)
		removeItem(player, slotid)
-----------------------------------------------------------------------------------------------------------------------------------------------				
		--Wir verwenden unser Reparaturkit
	elseif itemid == 49 then
		for i,v in ipairs(getElementsByType("player")) do
			if getElementData(v, "job") == 4 and getElementData(v, "dienst") == 1 and getElementData(v, "afk") ~= true then
				outputChatBox("Es ist im Moment ein Mechaniker online. Du kannst das Reparatur Kit nicht verwenden.",player,255,0,0)
				return
			end
		end
		local veh = getPedOccupiedVehicle ( player )
		if not veh then outputChatBox("Um das Reparatur Kit zu verwenden musst du im Fahrzeug sein.",player,255,0,0) return end
		if getElementData(veh, "panne") == false then outputChatBox("Dein Fahrzeug hat keinen Schaden.",player,255,0,0) return end
		triggerEvent ( "onPlayerChat", player, "verwendet sein Reparatur Kit.", 1)
		triggerClientEvent ( player, "showTutorialMessage", getRootElement(), "item_48", "Das Reparaturkit repariert dein Fahrzeug nur zu 50%. Du kannst dein Fahrzeug beim AutoFix oder einer Pay'N'Spray Anlage komplett reparieren." )
		setElementHealth(veh, 500)
		setElementData(veh, "panne", false)
		setVehicleDamageProof(veh, false)
		removeItem(player, slotid)
-----------------------------------------------------------------------------------------------------------------------------------------------			
	--Wir haben einn Donutgegessen
	elseif itemid == 50 or itemid == 51 or itemid == 52 then
		local h = getElementData(player, "getPlayerHunger") + 15
		if( h > 100 ) then h = 100 end
		setElementData(player, "getPlayerHunger", h)
		
		outputChatBox("Der Donut hat deinen Magen befriedigt.",player,0,255,0)
		triggerEvent ( "onPlayerChat", player, "genießt einen Donut.", 1)
		setElementData(player,"getPlayerHygiene", getElementData(player,"getPlayerHygiene")-5)
		removeItem(player, slotid)
-----------------------------------------------------------------------------------------------------------------------------------------------
	--Wir statten uns mit einer Sprühdose aus	
	elseif itemid == 53 then
		giveWeapon(player, 41,250)
		triggerEvent ( "onPlayerChat", player, "stattet sich mit einem Pfefferspray aus.", 1)
		removeItem(player, slotid)
-----------------------------------------------------------------------------------------------------------------------------------------------
	--Wir statten uns mit einer Sprühdose aus	
	elseif itemid == 54 then
		giveWeapon(player, 10,250)
		triggerEvent ( "onPlayerChat", player, "stattet sich mit einem großen Dildo aus.", 1)
		removeItem(player, slotid)
-----------------------------------------------------------------------------------------------------------------------------------------------
	--Wir statten uns mit einer Sprühdose aus	
	elseif itemid == 55 then
		giveWeapon(player, 11,250)
		triggerEvent ( "onPlayerChat", player, "stattet sich mit einem kleinen Dildo aus.", 1)
		removeItem(player, slotid)
-----------------------------------------------------------------------------------------------------------------------------------------------
	--Wir statten uns mit einer Sprühdose aus	
	elseif itemid == 56 then
		giveWeapon(player, 12,250)
		triggerEvent ( "onPlayerChat", player, "stattet sich mit einem Vibrator aus.", 1)
		removeItem(player, slotid)		
-----------------------------------------------------------------------------------------------------------------------------------------------		
	--Wir trinken einen Glühwein
	elseif itemid == 57 then
		setElementData(player,"getPlayerHarndrang", getElementData(player,"getPlayerHarndrang")-15)
		setElementData(player,"promillesoll", getElementData(player,"promillesoll")+0.5)
		triggerEvent ( "onPlayerChat", player, "trinkt einen Glühwein. Es wird ihm wärmer.", 1)
		removeItem(player, slotid)		
-----------------------------------------------------------------------------------------------------------------------------------------------		
	--Wir haben eine Pizzaschnitte gegessen
	elseif itemid == 58 then
		local h = getElementData(player, "getPlayerHunger") + 30
		if( h > 100 ) then h = 100 end
		setElementData(player, "getPlayerHunger", h)
		
		outputChatBox("Die Pizzaschnitte hat deinen Hunger getilgt.",player,0,255,0)
		triggerEvent ( "onPlayerChat", player, "isst eine Pizzaschnitte.", 1)
		setElementData(player,"getPlayerHygiene", getElementData(player,"getPlayerHygiene")-10)
		removeItem(player, slotid)		
-----------------------------------------------------------------------------------------------------------------------------------------------		
	--Wir haben ein Hot-Dog gegessen
	elseif itemid == 60 then
		local h = getElementData(player, "getPlayerHunger") + 30
		if( h > 100 ) then h = 100 end
		setElementData(player, "getPlayerHunger", h)
		
		outputChatBox("Das Hot-Dog hat deinen Hunger getilgt.",player,0,255,0)
		triggerEvent ( "onPlayerChat", player, "isst ein Hot-Dog.", 1)
		setElementData(player,"getPlayerHygiene", getElementData(player,"getPlayerHygiene")-10)
		removeItem(player, slotid)	
-----------------------------------------------------------------------------------------------------------------------------------------------		
	--Wir haben Happy Noodles gegessen
	elseif itemid == 59 then
		local h = getElementData(player, "getPlayerHunger") + 30
		if( h > 100 ) then h = 100 end
		setElementData(player, "getPlayerHunger", h)
		
		outputChatBox("Die Happy Noodles haben deinen Hunger getilgt.",player,0,255,0)
		triggerEvent ( "onPlayerChat", player, "isst Happy Noodles.", 1)
		setElementData(player,"getPlayerHygiene", getElementData(player,"getPlayerHygiene")-10)
		removeItem(player, slotid)	
-----------------------------------------------------------------------------------------------------------------------------------------------				
	--Hanfsamen
	elseif itemid == 61 then 
		if getPedOccupiedVehicle(player) then return triggerClientEvent ( player, "addNotification", getRootElement(), 1, 255, 0, 0, "Du kannst Gras nicht im Fahrzeug anbauen.") end
		local x,y,z = getElementPosition(player)
		local int = getElementInterior(player)
		local dim = getElementDimension(player)
		local hanf = createHanfpflanze(player,x,y,z-1,int,dim)	
		if hanf then
			triggerEvent ( "onPlayerChat", player, "hat Hanf angebaut.", 1)
			removeItem(player, slotid)
		end
-----------------------------------------------------------------------------------------------------------------------------------------------				
	--Joint
	elseif itemid == 62 then
		triggerEvent ( "onPlayerChat", player, "hat einen Joint geraucht.", 1)
		raucheHanf(player)
		removeItem(player, slotid)
-----------------------------------------------------------------------------------------------------------------------------------------------				
	--Duchifal Tablette
	elseif itemid == 63 then
		local h = getElementData(player, "getPlayerHarndrang") + 10
		if( h > 100 ) then h = 100 end
		setElementData(player, "getPlayerHarndrang", h)
		triggerClientEvent(player, "onClientPlayerDamageScript", player, false, false, 4, 25)
		outputChatBox("Die Duchifal Tablette hat dich vom Durchfall befreit. Nebenwirkungen inkludieren Bluten aus dem Anus.",player,0,255,0)
		triggerEvent ( "onPlayerChat", player, "nimmt eine Duchifal Tablette.", 1)
		removeItem(player, slotid)			
-----------------------------------------------------------------------------------------------------------------------------------------------		
	--Item hat keine Funktion
	else
		outputChatBox(tostring(gItemData[itemid].name).." verwendet.",player,0,255,0)
		triggerEvent ( "onPlayerChat", player, "verwendet "..tostring(gItemData[itemid].name)..".", 1)
		removeItem(player, slotid)
	end
end


function decreaseItem(player, itemid)

	local slotid = findItem(player, itemid)
	if slotid == -1 then return end -- Nichts da, also auch nichts entfernen
	local item = getItemInSlot(player, slotid)
	if item.count and item.count > 1 then
		-- Neu setzen
		setItemData(player, slotid, "count", item.count-1)
	else
		-- Leer? Dann weg!
		removeItem(player, slotid, true)
		return
	end
end
function increaseItem(player, itemid)
	local slotid = findItem(player, itemid)
	if slotid == -1 then
		-- Nicht da, dann also erstellen
		slotid = giveItem(player, itemid, true)
		return
	end 
	local item = getItemInSlot(player, slotid)
	if not item.count or item.count < 1 then
		item.count = 1
	else
		item.count = item.count +1
	end
	-- Neu setzen
	setItemData(player, slotid, "count", item.count)
end

--Funktion um Spieler ein Item zu entziehen (z.B. nach Verwendung)
function removeItem(player, slotid, bEnforce)
	if not getElementData(player, "isPlayerLoggedIn") == true then return end
	
	local itemid = getItemInSlot(player, slotid).itemid
	if not bEnforce and gItemData[itemid].stackable then
		decreaseItem(player, itemid)
		return
	end
	local items = getElementData(player, "items")
	if not items then 
		items = {}
	end
	items[slotid] = nil
	setElementData(player, "items", items)
	
	pLogger["items"]:addEntry(getPlayerName(player).." hat ein Item mit der ID "..itemid.." verloren.")	
end

--Funktion um Item wieder aufzunehmen
function pickUpItem(item, player)
	if getElementData(item, "owner") then
		if getElementData(item, "owner") == getPlayerName(player) or (getElementData(player, "job") == 3 and getElementData(player, "dienst") == 1) then
			--gut
		else
			return triggerClientEvent ( player, "addNotification", getRootElement() ,1, 255, 0, 0, "Du kannst dieses Item nicht aufheben.\nEs gehört einem anderen Spieler.")
		end
	end
	if getElementData(item, "isRadio") == true then
		callClientFunction(getRootElement(), "deleteRadio", item)
		removeElementData(item, "isRadio")
		removeElementData(item, "radioStream")
		--setTimer(pickUpItem, 500, 1, item, player)
		--return
	end
	outputChatBox("Du hast ein Item aufgehoben.", player, 0,255,0)
	removeElementData(item, "isPickupableObj")
	if getElementData(item, "itemid") == 47 then --Geld
		givePlayerMoneyEx (player, math.floor(getElementData(item, "money")))
		triggerClientEvent ( player, "addNotification", getRootElement(), 1, 0,255,0, "Du hast Geld in Höhe von "..getElementData(item, "money").." Vero gefunden." )
	else
		local slot = giveItem(player, getElementData(item, "itemid"))
		-- Alte Werte kopieren, nur bei nicht stackbaren Sachen
		if gItemData[getElementData(item, "itemid")].stackable == false then
			local items = getElementData(player, "items")
			items[slot] = getElementDataTable(item)
			setElementData(player, "items", items)
		end
	end
	destroyElement(item)
end

function pickUpItemKey(player)
	local x, y, z = getElementPosition(player)
	local objs = getElementsByType("object")
	for theKey,obj in ipairs(objs) do 
		if getElementData(obj, "isPickupableObj") == true then
			local x1, y1, z1 = getElementPosition(obj)
			if getDistanceBetweenPoints3D(x, y, z, x1, y1, z1) < 3 and getElementDimension(player) == getElementDimension(obj) then
				pickUpItem(obj, player)
				break
			end
		end
	end
end

function dropItem(player, slotid)
	local olditem = getItemInSlot(player, slotid)
	if olditem.itemid == 2 then
		outputChatBox("Du kannst deinen Personalausweiß nicht ablegen.", player, 255,0,0)
		return
	end
	if olditem.itemid == 6 then
		outputChatBox("Du kannst dein Handy nicht ablegen.", player, 255,0,0)
		return
	end	
	removeItem(player, slotid)
	olditem.count = nil -- Anzahl löschen. Man kann nur 1 Ablegen
	local x, y, z = getElementPosition(player)
	local itemid = olditem.itemid
	
	local item = createObject ( gItemData[itemid].model, x, y, z+gItemData[itemid].zo - 0.9, gItemData[itemid].rx, gItemData[itemid].ry, getPedRotation(player)+180 )
	setElementData(item, "cinfo", {"Item aufnehmen"})
	setElementDataTable(item, olditem)
	setElementData(item, "isPickupableObj", true)
	createClickableElement(item, pickUpItem)
	setElementInterior(item, getElementInterior(player))
	setElementDimension(item, getElementDimension(player))
	pLogger["items"]:addEntry(getPlayerName(player).." hat ein Item mit der ID "..itemid.." abgelegt.")
	return item
end

function giveItem(player, itemid, bEnforce)
	if not getElementData(player, "isPlayerLoggedIn") == true then return end
	if not bEnforce and gItemData[itemid].stackable then
		increaseItem(player, itemid)
		return findItem(player, itemid)
	end
	local items = getElementData(player, "items")
	if not items then 
		items = {}
	end
	local slot = #items+1
	if gItemData[itemid].stackable then
		items[slot] = { itemid = itemid, count = 1 }
	else
		items[slot] = { itemid = itemid }
	end
	setElementData(player, "items", items)
	pLogger["items"]:addEntry(getPlayerName(player).." hat ein Item mit der ID "..itemid.." erhalten.")
	-- Slotid zurückgeben
	return slot
end

function findItem(player, itemid)
	-- Der Spieler ist gar nicht eingeloggt
	if not getElementData(player, "isPlayerLoggedIn") == true then return -1 end
	-- Items getten
	local items = getElementData(player, "items")
	-- Wir haben keine Items?
	if not items then return -1 end
	for k, v in pairs(items) do
		if v.itemid == itemid then
			return k
		end
	end
	return -1
end

function getItemInSlot(player, slotid)
	-- Der Spieler ist gar nicht eingeloggt
	if not getElementData(player, "isPlayerLoggedIn") == true then return false end
	-- Items getten
	local items = getElementData(player, "items")
	-- Wir haben keine Items?
	if not items then return false end
	-- Slot zurückgeben

	return items[slotid]
end

function setItemSlot(player, slotid, newitem)
	local items = getElementData(player, "items")
	items[slotid] = newitem
	setElementData(player, "items", items)
end

function hasItem(player, itemid)
	return findItem(player, itemid) ~= -1
end

function setItemData(player, slotid, key, value)
	local item = getItemInSlot(player, slotid)
	item[key] = value
	setItemSlot(player, slotid, item)
end

function getItemData(player, slotid, key)
	local item = getItemInSlot(player, slotid)
	return item[key]
end

function getItemName(id)
	if not gItemData[id] then return end
	return gItemData[id].name
end

function buyInventWeapon(wep)
	local id = 0
	if wep == 24 then id = 9 end
	if wep == 29 then id = 10 end
	if wep == 1 then id = 11 end
	if wep == 2 then id = 12 end
	if wep == 3 then id = 13 end
	if wep == 4 then id = 14 end
	if wep == 5 then id = 15 end
	if wep == 6 then id = 16 end
	if wep == 7 then id = 17 end
	if wep == 8 then id = 18 end
	if wep == 9 then id = 19 end
	if wep == 15 then id = 20 end
	if wep == 22 then id = 21 end
	if wep == 23 then id = 22 end
	if wep == 25 then id = 23 end
	if wep == 26 then id = 24 end
	if wep == 27 then id = 25 end
	if wep == 28 then id = 26 end
	if wep == 32 then id = 27 end
	if wep == 30 then id = 28 end
	if wep == 31 then id = 29 end
	if wep == 33 then id = 30 end
	if wep == 34 then id = 31 end
	if wep == 37 then id = 32 end
	if wep == 16 then id = 33 end
	if wep == 17 then id = 34 end
	if wep == 18 then id = 35 end
	if wep == 39 then id = 36 end
	if wep == 41 then id = 53 end
	if wep == 42 then id = 37 end
	if wep == 44 then id = 38 end
	if wep == 45 then id = 39 end
	if wep == 46 then id = 40 end
	giveItem(source, id)
end
addEvent("buyInventWeapon", true)
addEventHandler ( "buyInventWeapon", getRootElement(), buyInventWeapon )