--[[
Project: VitaOnline
File: bar-client.lua
Author(s):	Sebihunter
]]--

--Casino
local music = playSound3D("http://www.181.fm/tuner.php?station=181-chilled&file=181-chilled.asx", 1952.591,1010.466,992.468)
setElementInterior(music, 10)
setSoundMaxDistance ( music, 100 )

--Baumhaus
music = playSound3D ( "http://radio.nrj.net/dance/radioat", -955.643,-981.3700,151.055, true )
setSoundMaxDistance ( music, 40 )

--Freibad
playSound3D ( "http://www.top100station.de/switch/top100station_lq.asx", 1906.1958,-1358.2620,13.49796, true )

--Rocker Bude
music = playSound3D ( "http://starfm.de/streams/bln_m.pls", -220.3203125, 1212.8505859375, 19.735198974609, true )
setSoundMaxDistance ( music, 100 )

--Apres Ski beim Wilden Ösi
playSound3D ( "http://stream.laut.fm/partyundapresski.m3u", 886.24176025391, 1915.5100097656, 12.323812484741, true )

--PBC Terasse
local music = playSound3D ( "http://193.111.136.213:8000/listen.pls", 1904.712890625, 1916.2265625, 121.05862426758, true )
setSoundMaxDistance ( music, 100 )

--PBC
music = playSound3D ( "http://193.111.136.213:8000/listen.pls", -2658.9397,1407.0289,905.5734, true )
setSoundMaxDistance ( music, 100 )

--Werkstatt
music = playSound3D ( "http://radio.nrj.net/dance/radioat", -2042.5107421875, 163.583984375, 28.8359375, true )
setSoundMaxDistance ( music, 50 )


-- Shop
BarGUI_Window = {}
BarGUI_Button = {}
BarGUI_Grid = {}
BarGUI_Column = {}

BarGUI_Window[1] = guiCreateWindow(screenWidth/2-155,screenHeight/2-202,289,403,"Getraenke",false)
BarGUI_Button[1] = guiCreateButton(179,379,101,15,"Schliessen",false,BarGUI_Window[1])
BarGUI_Grid[1] = guiCreateGridList(16,33,264,336,false,BarGUI_Window[1])
guiGridListSetSelectionMode(BarGUI_Grid[1],2)
BarGUI_Column[1] = guiGridListAddColumn ( BarGUI_Grid[1], "Item", 0.9 )
guiSetVisible( BarGUI_Window[1], false)
guiWindowSetSizable ( BarGUI_Window[1], false )

local row = guiGridListAddRow(BarGUI_Grid[1])
guiGridListSetItemText ( BarGUI_Grid[1], row, BarGUI_Column[1], "Vodka Stamperl (3 Vero)", false, false )
local row = guiGridListAddRow(BarGUI_Grid[1])
guiGridListSetItemText ( BarGUI_Grid[1], row, BarGUI_Column[1], "Tequilla Stamperl (3 Vero)", false, false )
local row = guiGridListAddRow(BarGUI_Grid[1])
guiGridListSetItemText ( BarGUI_Grid[1], row, BarGUI_Column[1], "Schankgetraenk (5 Vero)", false, false )
local row = guiGridListAddRow(BarGUI_Grid[1])
guiGridListSetItemText ( BarGUI_Grid[1], row, BarGUI_Column[1], "Cocktail (6 Vero)", false, false )
local row = guiGridListAddRow(BarGUI_Grid[1])
guiGridListSetItemText ( BarGUI_Grid[1], row, BarGUI_Column[1], "Adios Motherfucker (10 Vero)", false, false )
local row = guiGridListAddRow(BarGUI_Grid[1])
guiGridListSetItemText ( BarGUI_Grid[1], row, BarGUI_Column[1], "Bier (8 Vero)", false, false )

function showBarGUI()
	if not getElementData(getLocalPlayer(), "isPlayerLoggedIn") == true then return end
	if not getElementData(getLocalPlayer(), "isWaitingForDeath") == false then return end
	
	guiSetVisible( BarGUI_Window[1], true)
	showCursor(true)
end

function closeBarGUI()
	guiSetVisible( BarGUI_Window[1], false)
	showCursor(false)
end
addEventHandler ( "onClientGUIClick", BarGUI_Button[1], closeBarGUI )

function buyDrink()
	local selectedRow, selectedCol = guiGridListGetSelectedItem( BarGUI_Grid[1] )
	local itemtext = guiGridListGetItemText ( BarGUI_Grid[1], selectedRow, selectedCol )
	if itemtext == "Vodka Stamperl (3 Vero)" then
		if checkMoney(3) == true then
			takePlayerMoneyEx(3)
			outputChatBox("Du hast ein Vodka Stamperl getrunken.", 0, 255, 0)
			setElementData(getLocalPlayer(),"promillesoll", getElementData(getLocalPlayer(),"promillesoll")+0.35)
		end	
	end			
	if itemtext == "Tequilla Stamperl (3 Vero)" then
		if checkMoney(3) == true then
			takePlayerMoneyEx(3)
			outputChatBox("Du hast ein Tequilla Stamperl getrunken.", 0, 255, 0)
			setElementData(getLocalPlayer(),"promillesoll", getElementData(getLocalPlayer(),"promillesoll")+0.3)
		end	
	end			
	if itemtext == "Schankgetraenk (5 Vero)" then
		if checkMoney(5) == true then
			takePlayerMoneyEx(5)
			outputChatBox("Du hast ein Schankgetraenk getrunken.", 0, 255, 0)
			setElementData(getLocalPlayer(),"promillesoll", getElementData(getLocalPlayer(),"promillesoll")+0.2)
		end	
	end	
	if itemtext == "Cocktail (6 Vero)" then
		if checkMoney(6) == true then
			takePlayerMoneyEx(6)
			outputChatBox("Du hast einen Cocktail getrunken.", 0, 255, 0)
			setElementData(getLocalPlayer(),"promillesoll", getElementData(getLocalPlayer(),"promillesoll")+0.25)
		end	
	end	
	if itemtext == "Adios Motherfucker (10 Vero)" then
		if checkMoney(10) == true then
			takePlayerMoneyEx(10)
			outputChatBox("PROST! Du hast einen Adios Motherfucker getrunken.", 0, 255, 0)
			setElementData(getLocalPlayer(),"promillesoll", getElementData(getLocalPlayer(),"promillesoll")+0.65)
		end	
	end		
	if itemtext == "Bier (8 Vero)" then
		if checkMoney(8) == true then
			takePlayerMoneyEx(8)
			outputChatBox("Du hast ein Bier getrunken.", 0, 255, 0)
			setElementData(getLocalPlayer(),"promillesoll", getElementData(getLocalPlayer(),"promillesoll")+0.15)
		end	
	end		
	closeBarGUI()
end
addEventHandler( "onClientGUIDoubleClick", BarGUI_Grid[1], buyDrink, false );
