--[[
Project: VitaOnline
File: inventory-client.lua
Author(s):	Sebihunter
]]--


--Kisten
CrateGUI_Window = {}
CrateGUI_Button = {}
CrateGUI_Grid = {}
CrateGUI_Column = {}

CrateGUI_Window[1] = guiCreateWindow(screenWidth/2-155,screenHeight/2-202,289,403,"Gegenstände verwahren",false)
CrateGUI_Button[1] = guiCreateButton(179,379,101,15,"Schliessen",false,CrateGUI_Window[1])
CrateGUI_Button[2] = guiCreateButton(16,379,55,15,"Nehmen",false,CrateGUI_Window[1])
CrateGUI_Button[3] = guiCreateButton(16+60,379,55,15,"Lagern",false,CrateGUI_Window[1])
CrateGUI_Grid[1] = guiCreateGridList(16,33,264,336,false,CrateGUI_Window[1])
guiGridListSetSelectionMode(CrateGUI_Grid[1],1)
CrateGUI_Column[1] = guiGridListAddColumn ( CrateGUI_Grid[1], "Item", 0.5 )
CrateGUI_Column[2] = guiGridListAddColumn ( CrateGUI_Grid[1], "Inventar", 0.2 )
CrateGUI_Column[3] = guiGridListAddColumn ( CrateGUI_Grid[1], "Kiste", 0.2 )
guiSetVisible( CrateGUI_Window[1], false)
guiWindowSetSizable ( CrateGUI_Window[1], false )

local crateElem = false
local crateItems = {}
function showCrate(elem)
	if not getElementData(getLocalPlayer(), "isPlayerLoggedIn") == true then return end
	if not getElementData(getLocalPlayer(), "isWaitingForDeath") == false then return end
	if guiGetVisible(InvGUI_Window[1]) then return end
	if guiGetVisible(CrateGUI_Window[1]) then return end
	if not elem and not isElement(elem) then return end
	local inv = getElementData(elem, "inventory")
	if not inv then return end
	if getElementData(elem, "crateUsed") then addNotification(1, 255, 0, 0, "Das Objekt wird bereits von jemandem verwendet.") return end
	setElementData(elem, "crateUsed", true)
	crateElem = elem
	crateItems = {}
	if getElementType(crateElem) == "vehicle" then
		callServerFunction( "setVehicleDoorOpenRatio", crateElem, 1, 1, 500)
	end
	refreshCrate()
	showCursor(true)
	guiSetVisible( CrateGUI_Window[1], true)
	showTutorialMessage("inv_1", "Dieses Objekt dient als Kiste, in welche du Gegenstände ablegen kannst, die du nicht immer mit dir mitschleppen möchtest.")
end

function refreshCrate()
	if not crateElem and not isElement(crateElem) then return end
	if not getElementData(getLocalPlayer(), "isPlayerLoggedIn") == true then return end
	guiGridListClear ( CrateGUI_Grid[1] )
	crateItems = {}
	local itemTable = getElementData(getLocalPlayer(), "items")
	for k,v in pairs(itemTable) do
		if tonumber(v.itemid) >= 0 and tonumber(v.itemid) <= #gItemData then
			if not crateItems[v.itemid] then crateItems[v.itemid] = {} crateItems[v.itemid].i = 0 crateItems[v.itemid].k = 0 end
			if v.count then
				crateItems[v.itemid].i = crateItems[v.itemid].i + v.count
			else
				crateItems[v.itemid].i = crateItems[v.itemid].i + 1
			end
		end	
	end
	itemTable = getElementData(crateElem, "inventory")
	for i,v in pairs(itemTable) do
		if not crateItems[i] then crateItems[i] = {} crateItems[i].i = 0 crateItems[i].k = 0 end
		if v.count then
			crateItems[i].k = crateItems[i].k + v.count
		else
			crateItems[i].k = crateItems[i].k + 1
		end
	end	
	
	for k,v in pairs(crateItems) do
		local row = guiGridListAddRow(CrateGUI_Grid[1])
		guiGridListSetItemText ( CrateGUI_Grid[1], row, CrateGUI_Column[1], gItemData[tonumber(k)].name, false, false )
		guiGridListSetItemText ( CrateGUI_Grid[1], row, CrateGUI_Column[2], tostring(v.i), false, false )
		guiGridListSetItemText ( CrateGUI_Grid[1], row, CrateGUI_Column[3], tostring(v.k), false, false )
		guiGridListSetItemData ( CrateGUI_Grid[1], row, CrateGUI_Column[1], tostring(k) )	
	end
end

function closeCrate(button, state)
	if button ~= "left" and state ~= "down" then return end
	if not crateElem and not isElement(crateElem) then return end
    guiGridListClear ( CrateGUI_Grid[1] )
	guiSetVisible( CrateGUI_Window[1], false)
	if getElementType(crateElem) == "vehicle" then
		callServerFunction( "setVehicleDoorOpenRatio", crateElem, 1, 0, 500)
	end
	setElementData(crateElem, "crateUsed", false)
	crateElem = false
	crateItems = {}
	showCursor(false)
end
addEventHandler ( "onClientGUIClick", CrateGUI_Button[1], closeCrate, false )

function moveToPlayer(button, state)
	if button ~= "left" and state ~= "down" then return end
	if not crateElem and not isElement(crateElem) then return end
	local selectedRow, selectedCol = guiGridListGetSelectedItem( CrateGUI_Grid[1] )
	local itemdata = guiGridListGetItemData( CrateGUI_Grid[1], selectedRow, selectedCol )
	if not itemdata then return end
	local itemTable = getElementData(getLocalPlayer(), "items")
	local vehTable = getElementData(crateElem, "inventory")
	if not vehTable[tonumber(itemdata)] then return end 
	
	local x,y,z = getElementPosition(crateElem)
	local px, py, pz = getElementPosition(getLocalPlayer())
	if getDistanceBetweenPoints3D (px, py, pz, x,y,z) > 10 then return addNotification(1, 255, 0, 0, "Die Kiste ist zu weit von dir entfernt.") end
	
	vehTable[tonumber(itemdata)].count = vehTable[tonumber(itemdata)].count - 1
	if vehTable[tonumber(itemdata)].count <= 0 then vehTable[tonumber(itemdata)] = nil end
	local hasFound = false
	for i,v in pairs(itemTable) do
		if v.itemid == tonumber(itemdata) then
			v.count = v.count + 1
			hasFound = true
			break
		end
	end
	if not hasFound then
		itemTable[#itemTable+1] = {}
		itemTable[#itemTable].count = 1
		itemTable[#itemTable].itemid = tonumber(itemdata)
	end
	setElementData(crateElem, "inventory", vehTable)
	setElementData(getLocalPlayer(), "items", itemTable)
	refreshCrate()	
end
addEventHandler ( "onClientGUIClick", CrateGUI_Button[2], moveToPlayer, false )

function moveToCrate(button, state)
	if button ~= "left" and state ~= "down" then return end
	if not crateElem and not isElement(crateElem) then return end
	local selectedRow, selectedCol = guiGridListGetSelectedItem( CrateGUI_Grid[1] )
	local itemdata = guiGridListGetItemData( CrateGUI_Grid[1], selectedRow, selectedCol )
	if not itemdata then return end
	local itemTable = getElementData(getLocalPlayer(), "items")
	local vehTable = getElementData(crateElem, "inventory")
	
	local number = 0
	for i,v in pairs(vehTable) do
		number = number + v.count
	end
	if number >= 20 then return addNotification(1, 255, 0, 0, "Die Kiste ist bereits voll (max. 20 Items).") end

	local x,y,z = getElementPosition(crateElem)
	local px, py, pz = getElementPosition(getLocalPlayer())
	if getDistanceBetweenPoints3D (px, py, pz, x,y,z) > 10 then return addNotification(1, 255, 0, 0, "Die Kiste ist zu weit von dir entfernt.") end

	local hasFound = false
	for i,v in pairs(itemTable) do
		if v.itemid == tonumber(itemdata) then
			if v.count then
				if v.count - 1 > 0 then
					v.count = v.count - 1
				else
					table.remove(itemTable, i)
				end
			else
				return addNotification(1, 255, 0, 0, "Dieses Item kann nicht in die Kiste gelegt werden.")
			end
			hasFound = true
			break
		end
	end
	if not hasFound then return end
	if not vehTable[tonumber(itemdata)] then
		vehTable[tonumber(itemdata)] = {}
		vehTable[tonumber(itemdata)].count = 1
	else
		vehTable[tonumber(itemdata)].count = vehTable[tonumber(itemdata)].count + 1
	end
	setElementData(crateElem, "inventory", vehTable)
	setElementData(getLocalPlayer(), "items", itemTable)
	refreshCrate()
end
addEventHandler ( "onClientGUIClick", CrateGUI_Button[3], moveToCrate, false )


-- Inventar
InvGUI_Window = {}
InvGUI_Button = {}
InvGUI_Grid = {}
InvGUI_Column = {}

InvGUI_Window[1] = guiCreateWindow(screenWidth/2-155,screenHeight/2-202,289,403,"Inventar",false)
InvGUI_Button[1] = guiCreateButton(179,379,101,15,"Schliessen",false,InvGUI_Window[1])
InvGUI_Button[2] = guiCreateButton(16,379,101,15,"Ablegen",false,InvGUI_Window[1])
InvGUI_Grid[1] = guiCreateGridList(16,33,264,336,false,InvGUI_Window[1])
guiGridListSetSelectionMode(InvGUI_Grid[1],1)
InvGUI_Column[1] = guiGridListAddColumn ( InvGUI_Grid[1], "Item", 0.7 )
InvGUI_Column[2] = guiGridListAddColumn ( InvGUI_Grid[1], "Menge", 0.3 )
guiSetVisible( InvGUI_Window[1], false)
guiWindowSetSizable ( InvGUI_Window[1], false )

--GUI wird angezeigt
function showInventory()
	if not getElementData(getLocalPlayer(), "isPlayerLoggedIn") == true then return end
	if not getElementData(getLocalPlayer(), "isWaitingForDeath") == false then return end
	if guiGetVisible(InvGUI_Window[1]) then return end
	if guiGetVisible(CrateGUI_Window[1]) then return end
	showTutorialMessage("inv_2", "Das ist dein Inventar, welches alle deine Gegenstände anzeigt. Um einen Gegenstand zu verwenden doppelklicke auf ihn.")
	showTutorialMessage("inv_3", "Manche Objekte kannst du nicht verwenden, sondern bringen dir bei Besitz automatisch Boni oder neue Funktionen (z.B. Fahrzeugradar).")
	guiSetVisible( InvGUI_Window[1], true)
	showCursor(true)
	loadItems()
end
bindKey ( "i", "down", showInventory )

--Laedt die Items in das GUI
function loadItems()
	if not getElementData(getLocalPlayer(), "isPlayerLoggedIn") == true then return end
	guiGridListClear ( InvGUI_Grid[1] )
	local itemTable = getElementData(getLocalPlayer(), "items")
	for k,v in pairs(itemTable) do
		if tonumber(v.itemid) >= 0 and tonumber(v.itemid) <= #gItemData then
			local row = guiGridListAddRow(InvGUI_Grid[1])
			guiGridListSetItemText ( InvGUI_Grid[1], row, InvGUI_Column[1], gItemData[tonumber(v.itemid)].name, false, false )
			if v.count then
				guiGridListSetItemText ( InvGUI_Grid[1], row, InvGUI_Column[2], tostring(v.count), false, false )
			end
			guiGridListSetItemData ( InvGUI_Grid[1], row, InvGUI_Column[1], tostring(k) )
		end	
	end
end

--Verwendet das Item
function useItem(itemid)
	if getElementData(getLocalPlayer(), "einsperrzeit") ~= 0 then return addNotification(1, 255, 0, 0, "Du kannst im Gefängnis keine Items verwenden.") end
	callServerFunction("useItem", getLocalPlayer(), tonumber(itemid))
	closeInventory()
end	

--Item wurde mit Doppelklick angewaehlt 
function selectItemToUse()
	local selectedRow, selectedCol = guiGridListGetSelectedItem( InvGUI_Grid[1] )
	useItem(guiGridListGetItemData( InvGUI_Grid[1], selectedRow, selectedCol ))
end
addEventHandler( "onClientGUIDoubleClick", InvGUI_Grid[1], selectItemToUse, false );

--Schliesst das Inventar
function closeInventory()
    guiGridListClear ( InvGUI_Grid[1] )
	guiSetVisible( InvGUI_Window[1], false)
	showCursor(false)
end
addEventHandler ( "onClientGUIClick", InvGUI_Button[1], closeInventory, false )

--Legt das Item aus dem Inventar ab
function dropItem()
	local selectedRow, selectedCol = guiGridListGetSelectedItem( InvGUI_Grid[1] )
	local itemdata = guiGridListGetItemData( InvGUI_Grid[1], selectedRow, selectedCol )
	if not itemdata then return end
	if getElementData(getLocalPlayer(), "einsperrzeit") ~= 0 then return addNotification(1, 255, 0, 0, "Du kannst im Gefängnis keine Items ablegen.") end
	if getPedOccupiedVehicle(getLocalPlayer()) then return addNotification(1, 255, 0, 0, "Du kannst im Fahrzeug nichts ablegen.") end
	closeInventory()
	callServerFunction("dropItem", getLocalPlayer(), itemdata)
	outputChatBox("Item abgelegt.", 0,255,0)
	showTutorialMessage("inv_4", "Du hast dein erstes Objekt abgelegt. Um es wieder aufzunehmen stelle dich direkt darauf und drücke 'F'. Du kannst auch mit der Maus darauf klicken.")
end	
addEventHandler ( "onClientGUIClick", InvGUI_Button[2], dropItem, false)

--Funktion um zu ueberpruefen ob ein Spieler ein Item besitzt
function hasItem(itemid)
	-- Der Spieler ist gar nicht eingeloggt
	if not getElementData(getLocalPlayer(), "isPlayerLoggedIn") == true then return false end
	-- Items getten
	local items = getElementData(getLocalPlayer(), "items")
	-- Wir haben keine Items?
	if not items then return false end
	for k, v in pairs(items) do
		if v.itemid == itemid then
			return true
		end
	end
	return false
end

