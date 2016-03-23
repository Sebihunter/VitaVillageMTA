--[[
Project: VitaOnline
File: shop-client.lua
Author(s):	Sebihunter
]]--

local lottoTable = {
	state = false,
	money = 0,
	players = {},
	maximum = 1,
	price = 100
}


-- Shop
ShopGUI_Window = {}
ShopGUI_Button = {}
ShopGUI_Grid = {}
ShopGUI_Column = {}

ShopGUI_Window[1] = guiCreateWindow(screenWidth/2-155,screenHeight/2-202,289,403,"Shop",false)
ShopGUI_Button[1] = guiCreateButton(179,379,101,15,"Schliessen",false,ShopGUI_Window[1])
ShopGUI_Grid[1] = guiCreateGridList(16,33,264,336,false,ShopGUI_Window[1])
guiGridListSetSelectionMode(ShopGUI_Grid[1],2)
ShopGUI_Column[1] = guiGridListAddColumn ( ShopGUI_Grid[1], "Item", 0.9 )
guiSetVisible( ShopGUI_Window[1], false)
guiWindowSetSizable ( ShopGUI_Window[1], false )

function showAdminGUI()
	if guiGetVisible(ShopGUI_Window[1]) == true then return end
	if not getElementData(getLocalPlayer(), "isPlayerLoggedIn") == true then return end
	if not getElementData(getLocalPlayer(), "isWaitingForDeath") == false then return end
	guiGridListClear ( ShopGUI_Grid[1] )
	
	local row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Großer Dildo (30 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Kleiner Dildo (20 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Vibrator (40 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Glühwein (4 Vero)", false, false )	
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Schokodonut (3 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Vanilledonut (3 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Erdbeerdonut (3 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Cola (5 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Bier (6 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Wurstsemmel (7 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Hot-Dog (6 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Happy Noodles (9 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Pizzaschnitte (8 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Kaffee (8 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Vodka (23 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Kamera (150 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Tankkanister [10L] (20 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Strandtuch A (10 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Strandtuch B (10 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Strandtuch C (10 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Strandtuch D (10 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Fahrzeugradar (200 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Ersatzreifen (100 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Handy (200 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Tragbares Radio (80 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Verbandszeug (400 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Reparatur Kit (600 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Duchifal Tablette (120 Vero)", false, false )
	
	triggerServerEvent ( "checkLotto", getLocalPlayer() )	
	
	guiSetVisible( ShopGUI_Window[1], true)
	showCursor(true)
end

function receiveLotto(tab)
	lottoTable = tab
	if tab.state == true then
		row = guiGridListAddRow(ShopGUI_Grid[1])
		guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Lottoschein ("..tab.price.." Vero)", false, false )	
		showTutorialMessage("shop_2", "Im Moment ist es möglich einen Lottoschein für die nächste viNETWORK Ziehung zu kaufen. Du kannst beim Lotto mit ein bisschen Glück viel Geld gewinnen.")
	end
end
function showGluehweinGUI()
	if guiGetVisible(ShopGUI_Window[1]) == true then return end
	if not getElementData(getLocalPlayer(), "isPlayerLoggedIn") == true then return end
	if not getElementData(getLocalPlayer(), "isWaitingForDeath") == false then return end
	guiGridListClear ( ShopGUI_Grid[1] )
	
	local row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Glühwein (4 Vero)", false, false )
	guiSetVisible( ShopGUI_Window[1], true)
	showCursor(true)
end

function showSexGUI()
	if guiGetVisible(ShopGUI_Window[1]) == true then return end
	if not getElementData(getLocalPlayer(), "isPlayerLoggedIn") == true then return end
	if not getElementData(getLocalPlayer(), "isWaitingForDeath") == false then return end
	guiGridListClear ( ShopGUI_Grid[1] )
	
	local row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Großer Dildo (30 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Kleiner Dildo (20 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Vibrator (40 Vero)", false, false )
	guiSetVisible( ShopGUI_Window[1], true)
	showCursor(true)
end

function showDonutGUI()
	if guiGetVisible(ShopGUI_Window[1]) == true then return end
	if not getElementData(getLocalPlayer(), "isPlayerLoggedIn") == true then return end
	if not getElementData(getLocalPlayer(), "isWaitingForDeath") == false then return end
	guiGridListClear ( ShopGUI_Grid[1] )
	
	local row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Schokodonut (3 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Vanilledonut (3 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Erdbeerdonut (3 Vero)", false, false )
	guiSetVisible( ShopGUI_Window[1], true)
	showCursor(true)
end

function showPizzaGUI()
	if guiGetVisible(ShopGUI_Window[1]) == true then return end
	if not getElementData(getLocalPlayer(), "isPlayerLoggedIn") == true then return end
	if not getElementData(getLocalPlayer(), "isWaitingForDeath") == false then return end
	guiGridListClear ( ShopGUI_Grid[1] )
	
	local row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Cola (5 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Pizzaschnitte (8 Vero)", false, false )	
	guiSetVisible( ShopGUI_Window[1], true)
	showCursor(true)
end

function showNoodlesGUI()
	if guiGetVisible(ShopGUI_Window[1]) == true then return end
	if not getElementData(getLocalPlayer(), "isPlayerLoggedIn") == true then return end
	if not getElementData(getLocalPlayer(), "isWaitingForDeath") == false then return end
	guiGridListClear ( ShopGUI_Grid[1] )
	
	local row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Cola (5 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Happy Noodles (9 Vero)", false, false )
	guiSetVisible( ShopGUI_Window[1], true)
	showCursor(true)
end

function showHotdogGUI()
	if guiGetVisible(ShopGUI_Window[1]) == true then return end
	if not getElementData(getLocalPlayer(), "isPlayerLoggedIn") == true then return end
	if not getElementData(getLocalPlayer(), "isWaitingForDeath") == false then return end
	guiGridListClear ( ShopGUI_Grid[1] )
	
	local row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Cola (5 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Hot-Dog (6 Vero)", false, false )	
	guiSetVisible( ShopGUI_Window[1], true)
	showCursor(true)
end

function showFFGUI()
	if guiGetVisible(ShopGUI_Window[1]) == true then return end
	if not getElementData(getLocalPlayer(), "isPlayerLoggedIn") == true then return end
	if not getElementData(getLocalPlayer(), "isWaitingForDeath") == false then return end
	guiGridListClear ( ShopGUI_Grid[1] )
	
	local row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Cola (5 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Bier (6 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Wurstsemmel (7 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Hot-Dog (6 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Happy Noodles (9 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Pizzaschnitte (8 Vero)", false, false )	
	guiSetVisible( ShopGUI_Window[1], true)
	showCursor(true)
end

function showShopGUI()
	if guiGetVisible(ShopGUI_Window[1]) == true then return end
	if not getElementData(getLocalPlayer(), "isPlayerLoggedIn") == true then return end
	if not getElementData(getLocalPlayer(), "isWaitingForDeath") == false then return end
	guiGridListClear ( ShopGUI_Grid[1] )
	showTutorialMessage("shop_1", "In diesem Shop kannst du verschiedenste Items für deinen Charakter kaufen. Es gibt verschiedenste Läden wie Essensverkäufer, Supermärkte oder sogar einen Sexshop.")
	
	local row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Cola (5 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Bier (6 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Wurstsemmel (7 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Kaffee (8 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Vodka (23 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Kamera (150 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Tankkanister [10L] (200 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Strandtuch A (10 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Strandtuch B (10 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Strandtuch C (10 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Strandtuch D (10 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Fahrzeugradar (200 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Ersatzreifen (100 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Handy (200 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Tragbares Radio (80 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Verbandszeug (400 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Reparatur Kit (600 Vero)", false, false )
	row = guiGridListAddRow(ShopGUI_Grid[1])
	guiGridListSetItemText ( ShopGUI_Grid[1], row, ShopGUI_Column[1], "Duchifal Tablette (120 Vero)", false, false )
	
	
	triggerServerEvent ( "checkLotto", getLocalPlayer() )
	
	guiSetVisible( ShopGUI_Window[1], true)
	showCursor(true)
end

function closeShopGUI()
	guiSetVisible( ShopGUI_Window[1], false)
	showCursor(false)
end
addEventHandler ( "onClientGUIClick", ShopGUI_Button[1], closeShopGUI )

function buyItem()
	local selectedRow, selectedCol = guiGridListGetSelectedItem( ShopGUI_Grid[1] )
	local itemtext = guiGridListGetItemText ( ShopGUI_Grid[1], selectedRow, selectedCol )
	if itemtext == "Cola (5 Vero)" then
		if checkMoney(5) == true then
			takePlayerMoneyEx(5)
			callServerFunction("giveItem", getLocalPlayer(), 0)
			addNotification(2, 0, 255, 0, "Du hast dir eine Cola gekauft.")
		else
			addNotification(1, 255, 0, 0, "Nicht genügend Geld.")
		end
	end
	if itemtext == "Bier (6 Vero)" then
		if checkMoney(6) == true then
			takePlayerMoneyEx(6)
			callServerFunction("giveItem", getLocalPlayer(), 7)
			addNotification(2, 0, 255, 0, "Du hast dir ein Bier gekauft.")
		else
			addNotification(1, 255, 0, 0, "Nicht genügend Geld.")
		end
	end		
	if itemtext == "Wurstsemmel (7 Vero)" then
		if checkMoney(7) == true then
			takePlayerMoneyEx(7)
			callServerFunction("giveItem", getLocalPlayer(), 1)
			addNotification(2, 0, 255, 0, "Du hast dir eine Wurstsemmel gekauft.")
		else
			addNotification(1, 255, 0, 0, "Nicht genügend Geld.")
		end
	end
	if itemtext == "Kaffee (8 Vero)" then
		if checkMoney(8) == true then
			takePlayerMoneyEx(8)
			callServerFunction("giveItem", getLocalPlayer(), 8)
			addNotification(2, 0, 255, 0, "Du hast dir einen Kaffee gekauft.")
		else
			addNotification(1, 255, 0, 0, "Nicht genügend Geld.")
		end
	end	
	if itemtext == "Vodka (23 Vero)" then
		if checkMoney(23) == true then
			takePlayerMoneyEx(23)
			callServerFunction("giveItem", getLocalPlayer(), 45)
			addNotification(2, 0, 255, 0, "Du hast dir einen Vodka gekauft.")
		else
			addNotification(1, 255, 0, 0, "Nicht genügend Geld.")
		end
	end	
	if itemtext == "Kamera (150 Vero)" then
		if checkMoney(150) == true then
			takePlayerMoneyEx(150)
			callServerFunction("giveWeapon", getLocalPlayer(), 43)
			addNotification(2, 0, 255, 0, "Du hast dir eine Kamera gekauft.")
		else
			addNotification(1, 255, 0, 0, "Nicht genügend Geld.")
		end
	end
	if itemtext == "Strandtuch A (10 Vero)" then
		if checkMoney(10) == true then
			takePlayerMoneyEx(10)
			callServerFunction("giveItem", getLocalPlayer(), 41)
			addNotification(2, 0, 255, 0, "Du hast dir ein Strandtuch gekauft.")
		else
			addNotification(1, 255, 0, 0, "Nicht genügend Geld.")
		end
	end	
	if itemtext == "Strandtuch B (10 Vero)" then
		if checkMoney(10) == true then
			takePlayerMoneyEx(10)
			callServerFunction("giveItem", getLocalPlayer(), 42)
			addNotification(2, 0, 255, 0, "Du hast dir ein Strandtuch gekauft.")
		else
			addNotification(1, 255, 0, 0, "Nicht genügend Geld.")
		end
	end	
	if itemtext == "Strandtuch C (10 Vero)" then
		if checkMoney(10) == true then
			takePlayerMoneyEx(10)
			callServerFunction("giveItem", getLocalPlayer(), 43)
			addNotification(2, 0, 255, 0, "Du hast dir ein Strandtuch gekauft.")
		else
			addNotification(1, 255, 0, 0, "Nicht genügend Geld.")
		end
	end	
	if itemtext == "Strandtuch D (10 Vero)" then
		if checkMoney(10) == true then
			takePlayerMoneyEx(10)
			callServerFunction("giveItem", getLocalPlayer(), 44)
			addNotification(2, 0, 255, 0, "Du hast dir ein Strandtuch gekauft.")
		else
			addNotification(1, 255, 0, 0, "Nicht genügend Geld.")
		end
	end		
	if itemtext == "Tankkanister [10L] (200 Vero)" then
		if checkMoney(200) == true then
			takePlayerMoneyEx(200)
			callServerFunction("giveItem", getLocalPlayer(), 3)
			addNotification(2, 0, 255, 0, "Du hast dir einen Tankkanister [10L] gekauft.")
		else
			addNotification(1, 255, 0, 0, "Nicht genügend Geld.")
		end
	end		
	if itemtext == "Fahrzeugradar (200 Vero)" then
		if checkMoney(200) == true then
			takePlayerMoneyEx(200)
			callServerFunction("giveItem", getLocalPlayer(), 4)
			addNotification(2, 0, 255, 0, "Du hast dir ein Fahrzeugradar.")
		else
			addNotification(1, 255, 0, 0, "Nicht genügend Geld.")
		end
	end		
	if itemtext == "Ersatzreifen (100 Vero)" then
		if checkMoney(100) == true then
			takePlayerMoneyEx(100)
			callServerFunction("giveItem", getLocalPlayer(), 5)
			addNotification(2, 0, 255, 0, "Du hast dir einen Ersatzreifen gekauft.")
		else
			addNotification(1, 255, 0, 0, "Nicht genügend Geld.")
		end
	end	
	if itemtext == "Handy (200 Vero)" then
		if checkMoney(200) == true then
			if not hasItem(6) then
				takePlayerMoneyEx(200)
				callServerFunction("givePhone", getLocalPlayer())
				addNotification(2, 0, 255, 0, "Du hast dir ein Handy gekauft.")
			else
				addNotification(1, 255, 0, 0, "Du hast bereits ein Handy.")
			end
		else
			addNotification(1, 255, 0, 0, "Nicht genügend Geld.")
		end
	end		
	if itemtext == "Tragbares Radio (80 Vero)" then
		if checkMoney(80) == true then
			takePlayerMoneyEx(80)
			callServerFunction("giveItem", getLocalPlayer(), 46)
			addNotification(2, 0, 255, 0, "Du hast dir ein tragbares Radio gekauft.")
		else
			addNotification(1, 255, 0, 0, "Nicht genügend Geld.")
		end
	end		
	if itemtext == "Verbandszeug (400 Vero)" then
		if checkMoney(400) == true then
			takePlayerMoneyEx(400)
			callServerFunction("giveItem", getLocalPlayer(), 48)
			addNotification(2, 0, 255, 0, "Du hast dir Verbandszeug gekauft.")
		else
			addNotification(1, 255, 0, 0, "Nicht genügend Geld.")
		end
	end	
	if itemtext == "Reparatur Kit (600 Vero)" then
		if checkMoney(600) == true then
			takePlayerMoneyEx(600)
			callServerFunction("giveItem", getLocalPlayer(), 49)
			addNotification(2, 0, 255, 0, "Du hast dir ein Reparatur Kit gekauft.")
		else
			addNotification(1, 255, 0, 0, "Nicht genügend Geld.")
		end
	end		
	if itemtext == "Schokodonut (3 Vero)" then
		if checkMoney(3) == true then
			takePlayerMoneyEx(3)
			callServerFunction("giveItem", getLocalPlayer(), 50)
			addNotification(2, 0, 255, 0, "Du hast dir einen Schokodonut gekauft.")
		else
			addNotification(1, 255, 0, 0, "Nicht genügend Geld.")
		end
	end		
	if itemtext == "Vanilledonut (3 Vero)" then
		if checkMoney(3) == true then
			takePlayerMoneyEx(3)
			callServerFunction("giveItem", getLocalPlayer(), 51)
			addNotification(2, 0, 255, 0, "Du hast dir einen Vanilledonut gekauft.")
		else
			addNotification(1, 255, 0, 0, "Nicht genügend Geld.")
		end
	end		
	if itemtext == "Erdbeerdonut (3 Vero)" then
		if checkMoney(3) == true then
			takePlayerMoneyEx(3)
			callServerFunction("giveItem", getLocalPlayer(), 52)
			addNotification(2, 0, 255, 0, "Du hast dir einen Erdbeerdonut gekauft.")
		else
			addNotification(1, 255, 0, 0, "Nicht genügend Geld.")
		end
	end	
	if itemtext == "Großer Dildo (30 Vero)" then
		if checkMoney(30) == true then
			takePlayerMoneyEx(30)
			callServerFunction("giveItem", getLocalPlayer(), 54)
			addNotification(2, 0, 255, 0, "Du hast dir einen großen Dildo gekauft.")
		else
			addNotification(1, 255, 0, 0, "Nicht genügend Geld.")
		end
	end	
	if itemtext == "Kleiner Dildo (20 Vero)" then
		if checkMoney(20) == true then
			takePlayerMoneyEx(20)
			callServerFunction("giveItem", getLocalPlayer(), 55)
			addNotification(2, 0, 255, 0, "Du hast dir einen kleinen Dildo gekauft.")
		else
			addNotification(1, 255, 0, 0, "Nicht genügend Geld.")
		end
	end	
	if itemtext == "Vibrator (40 Vero)" then
		if checkMoney(40) == true then
			takePlayerMoneyEx(40)
			callServerFunction("giveItem", getLocalPlayer(), 56)
			addNotification(2, 0, 255, 0, "Du hast dir einen Vibrator gekauft.")
		else
			addNotification(1, 255, 0, 0, "Nicht genügend Geld.")
		end
	end
	if itemtext == "Glühwein (4 Vero)" then
		if checkMoney(4) == true then
			takePlayerMoneyEx(4)
			callServerFunction("giveItem", getLocalPlayer(), 57)
			addNotification(2, 0, 255, 0, "Du hast dir einen Glühwein gekauft.")
		else
			addNotification(1, 255, 0, 0, "Nicht genügend Geld.")
		end
	end	
	if itemtext == "Pizzaschnitte (8 Vero)" then
		if checkMoney(8) == true then
			takePlayerMoneyEx(8)
			callServerFunction("giveItem", getLocalPlayer(), 58)
			addNotification(2, 0, 255, 0, "Du hast dir eine Pizzaschnitte gekauft.")
		else
			addNotification(1, 255, 0, 0, "Nicht genügend Geld.")
		end
	end	
	if itemtext == "Happy Noodles (9 Vero)" then
		if checkMoney(9) == true then
			takePlayerMoneyEx(9)
			callServerFunction("giveItem", getLocalPlayer(), 59)
			addNotification(2, 0, 255, 0, "Du hast dir Happy Noodles gekauft.")
		else
			addNotification(1, 255, 0, 0, "Nicht genügend Geld.")
		end
	end		
	if itemtext == "Hot-Dog (6 Vero)" then
		if checkMoney(6) == true then
			takePlayerMoneyEx(6)
			callServerFunction("giveItem", getLocalPlayer(), 60)
			addNotification(2, 0, 255, 0, "Du hast dir ein Hot-Dog gekauft.")
		else
			addNotification(1, 255, 0, 0, "Nicht genügend Geld.")
		end
	end		
	if itemtext == "Duchifal Tablette (120 Vero)" then
		if checkMoney(120) == true then
			takePlayerMoneyEx(120)
			callServerFunction("giveItem", getLocalPlayer(), 63)
			addNotification(2, 0, 255, 0, "Du hast dir eine Duchifal Tablette gekauft.")
		else
			addNotification(1, 255, 0, 0, "Nicht genügend Geld.")
		end
	end	
	if itemtext == "Lottoschein ("..lottoTable.price.." Vero)" then
		triggerServerEvent("buyLotto", getLocalPlayer())
	end		
	showTutorialMessage("shop_3", "Das Item befindet sich nach dem Kauf in deinem Inventar 'I'. Manche Items können nicht beutzt werden, sondern schalten durch Besitz automatisch Funktionen frei (z.B.Fahrzeugradar)")
	--closeShopGUI()
end
addEventHandler( "onClientGUIDoubleClick", ShopGUI_Grid[1], buyItem, false );

function checkMoney(money)
	if getPlayerMoneyEx(getLocalPlayer()) >= money then return true else return false end
end

