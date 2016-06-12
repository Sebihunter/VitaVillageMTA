--[[
Project: VitaOnline
File: illegalweapons-client.lua
Author(s):	Sebihunter
]]--

-- Shop
WeaponGUI_Window = {}
WeaponGUI_Button = {}
WeaponGUI_Grid = {}
WeaponGUI_Column = {}

WeaponGUI_Window[1] = guiCreateWindow(screenWidth/2-155,screenHeight/2-202,289,403,"Illegaler Waffenhändler",false)
WeaponGUI_Button[1] = guiCreateButton(179,379,101,15,"Schliessen",false,WeaponGUI_Window[1])
WeaponGUI_Grid[1] = guiCreateGridList(16,33,264,336,false,WeaponGUI_Window[1])
guiGridListSetSelectionMode(WeaponGUI_Grid[1],2)
WeaponGUI_Column[1] = guiGridListAddColumn ( WeaponGUI_Grid[1], "Item", 0.9 )
guiSetVisible( WeaponGUI_Window[1], false)
guiWindowSetSizable ( WeaponGUI_Window[1], false )

local row = guiGridListAddRow(WeaponGUI_Grid[1])
guiGridListSetItemText ( WeaponGUI_Grid[1], row, WeaponGUI_Column[1], "Desert Eagle (900 Vero)", false, false )
row = guiGridListAddRow(WeaponGUI_Grid[1])
guiGridListSetItemText ( WeaponGUI_Grid[1], row, WeaponGUI_Column[1], "MP5 (1400 Vero)", false, false )
row = guiGridListAddRow(WeaponGUI_Grid[1])
guiGridListSetItemText ( WeaponGUI_Grid[1], row, WeaponGUI_Column[1], "Hanfsamen (2500 Vero)", false, false )
row = guiGridListAddRow(WeaponGUI_Grid[1])
guiGridListSetItemText ( WeaponGUI_Grid[1], row, WeaponGUI_Column[1], "Magische Miesmuschel (10 Vero)", false, false )

function showWeaponGUI()
	if not getElementData(getLocalPlayer(), "isPlayerLoggedIn") == true then return end
	if not getElementData(getLocalPlayer(), "isWaitingForDeath") == false then return end
	if getElementData(getLocalPlayer(), "gang") == 0 then outputChatBox("Verpiss dich! Du bekommst hier nichts.", 255, 0, 0) return end
	guiSetVisible( WeaponGUI_Window[1], true)
	showCursor(true)
	showTutorialMessage("hjoe_1", "Hinterzimmer Joe bietet dir eine Standartauswahl von Waffen, auch ohne einen Waffenschein. Du kannst bei ihm ebenfalls Hanfsamen zum Anpflanzen kaufen.")
end

function closeWeaponGUI()
	guiSetVisible( WeaponGUI_Window[1], false)
	showCursor(false)
end
addEventHandler ( "onClientGUIClick", WeaponGUI_Button[1], closeWeaponGUI )

function buyWeapon()
	local selectedRow, selectedCol = guiGridListGetSelectedItem( WeaponGUI_Grid[1] )
	local itemtext = guiGridListGetItemText ( WeaponGUI_Grid[1], selectedRow, selectedCol )
	if itemtext == "Desert Eagle (900 Vero)" then
		if checkMoney(900) == true then
			takePlayerMoneyEx(900)
			callServerFunction("giveItem", getLocalPlayer(), 9)
			--callServerFunction("giveWeapon", getLocalPlayer(), 24)
			outputChatBox("Du hast dir eine Desert Eagle gekauft (30 Schuss).", 0, 255, 0)
		end	
	end	
	if itemtext == "MP5 (1400 Vero)" then
		if checkMoney(1400) == true then
			takePlayerMoneyEx(1400)
			callServerFunction("giveItem", getLocalPlayer(), 10)
			--callServerFunction("giveWeapon", getLocalPlayer(), 29, 60)
			outputChatBox("Du hast dir eine MP5 gekauft (60 Schuss).", 0, 255, 0)
		end	
	end
	if itemtext == "Hanfsamen (2500 Vero)" then
		if checkMoney(2500) == true then
			takePlayerMoneyEx(2500)
			callServerFunction("giveItem", getLocalPlayer(), 61)
			outputChatBox("Du hast dir einen Hanfsamen gekauft.", 0, 255, 0)
		end	
	end	
	if itemtext == "Magische Miesmuschel (10 Vero)" then
		outputChatBox("Versuch's doch einfach nochmal.", 255, 0, 0)
	end		
	--closeWeaponGUI()
end
addEventHandler( "onClientGUIDoubleClick", WeaponGUI_Grid[1], buyWeapon, false );
