--[[
Project: VitaOnline
File: bahnhof-client.lua
Author(s):	Sebihunter
]]--


gStationData =  {
	[0] = {name = "Cranberry Station (SF)", x = -1973.5625, y = 117.8251953125, z = 26.6875},
	[1] = {name = "Fort Carson", x = -18.088935852051, y = 1287.9099121094, z = 17.203130722046},
	[2] = {name = "Yellow Bell Station (LV)", x = 1436.3583984375, y = 2620.404296875, z = 10.392614364624},
	[3] = {name = "Sobell Station (LV)", x = 2778.5322265625, y = 1768.9677734375, z = 10.392610549927},
	[4] = {name = "Linden Station (LV)", x = 2858.1123046875, y = 1266.6748046875, z = 10.390625},
	[5] = {name = "Unity Station (LS)", x = 1746.8671875, y = -1944.1953125, z = 12.567518234253},
	[6] = {name = "Market Station (LS)", x = 810.318359375, y = -1354.998046875, z = -1.5078125}
}

StationGUI_Window = {}
StationGUI_Button = {}
StationGUI_Grid = {}
StationGUI_Column = {}
StationGUI_Window[1] = guiCreateWindow(screenWidth / 2 - 155, screenHeight / 2 - 202, 289, 403, "Bahnhof", false)
StationGUI_Button[1] = guiCreateButton(179, 379, 101, 15, "Schliessen", false, StationGUI_Window[1])
StationGUI_Grid[1] = guiCreateGridList(16, 33, 264, 336, false, StationGUI_Window[1])
guiGridListSetSelectionMode(StationGUI_Grid[1], 2)
StationGUI_Column[1] = guiGridListAddColumn(StationGUI_Grid[1], "Station", 0.9)
guiSetVisible(StationGUI_Window[1], false)
guiWindowSetSizable(StationGUI_Window[1], false)

local hasStationGUI = false

function showStationGUI(hitPlayer)
	if hitPlayer ~= getLocalPlayer() then return end
	if not getElementData(getLocalPlayer(), "isPlayerLoggedIn") == true then return end
	if not getElementData(getLocalPlayer(), "isWaitingForDeath") == false then return end
	if not getPedOccupiedVehicle ( getLocalPlayer() ) == false then return end
	
	
	local disable = true --THIS IS DISABLED FROM NOW ON
	if disable == true then addNotification(3, 123, 153, 14, "Du kannst hier am Bahnhof auf den automatischen Zug warten.\nZüge kommen jede Minute und sind kostenlos.") return end
	if hasStationGUI == true then return end
	
	hasStationGUI = true
	setTimer(function()
		hasStationGUI = false
	end, 3000, 1)
	guiSetVisible(StationGUI_Window[1], true)
	showCursor(true)
end

function closeStationGUI()
	guiSetVisible(StationGUI_Window[1], false)
	showCursor(false)
end
addEventHandler("onClientGUIClick", StationGUI_Button[1], closeStationGUI)

for station = 0, #gStationData do
	local row = guiGridListAddRow(StationGUI_Grid[1])
	guiGridListSetItemText(StationGUI_Grid[1], row, StationGUI_Column[1], gStationData[station].name, false, false)
	local marker = createMarker(gStationData[station].x, gStationData[station].y, gStationData[station].z, "cylinder", 1, 125, 0, 125, 100)
	addEventHandler("onClientMarkerHit", marker, showStationGUI)
end	

function selectionStation()
	local selectedRow, selectedCol = guiGridListGetSelectedItem(StationGUI_Grid[1])
	local itemtext = guiGridListGetItemText(StationGUI_Grid[1], selectedRow, selectedCol)
	for station = 0, #gStationData do
		if itemtext == gStationData[station].name then
			if checkMoney(100) == true then
				takePlayerMoneyEx(100)
				setElementPosition(getLocalPlayer(), gStationData[station].x, gStationData[station].y, gStationData[station].z + 1)
				addNotification(2, 123, 153, 14, "Willkommen in " .. gStationData[station].name .. ".\nDiese Fahrt hat dich 100 Vero gekostet.")
			else
				addNotification(1, 255, 0, 0, "Fahrt nicht möglich. Du benötigst 100 Vero.")
			end
		else
		end
    end
    closeStationGUI()
end

addEventHandler("onClientGUIDoubleClick", StationGUI_Grid[1], selectionStation, false)

