--[[
Project: VitaOnline
File: verwarung-client.lua
Author(s):	Sebihunter
]]
local screenx, screeny = guiGetScreenSize ()

VerwarungGUI_Window = {}
VerwarungGUI_Button = {}
VerwarungGUI_Label = {}
VerwarungGUI_Grid = {}
VerwarungGUI_Column = {}

VerwarungGUI_Window[1] = guiCreateWindow(screenx/2-348/2,screeny/2-339/2,348,339,"SASO KFZ-Verwahrstelle",false)
VerwarungGUI_Button[1] = guiCreateButton(38,281,88,22,"Ausloesen",false,VerwarungGUI_Window[1])
VerwarungGUI_Button[2] = guiCreateButton(225,281,88,22,"Schliessen",false,VerwarungGUI_Window[1])
VerwarungGUI_Grid[1] = guiCreateGridList(17,66,312,199,false,VerwarungGUI_Window[1])

VerwarungGUI_Column[1] = guiGridListAddColumn(VerwarungGUI_Grid[1],"Fahrzeug",0.2)
VerwarungGUI_Column[2] = guiGridListAddColumn(VerwarungGUI_Grid[1],"Schluesselbesitzer",0.4)
VerwarungGUI_Column[3] = guiGridListAddColumn(VerwarungGUI_Grid[1],"Auslösbar",0.3)

VerwarungGUI_Label[1] = guiCreateLabel(17,312,315,20,"Fehler: Du hast zu wenig Geld!",false,VerwarungGUI_Window[1])
guiLabelSetColor(VerwarungGUI_Label[1],255,0,0)
VerwarungGUI_Label[2] = guiCreateLabel(20,32,31,19,"Preis:",false,VerwarungGUI_Window[1])
guiLabelSetHorizontalAlign(VerwarungGUI_Label[2],"left",true)
VerwarungGUI_Label[3] = guiCreateLabel(57,33,91,17,"600 Vero",false,VerwarungGUI_Window[1])
guiLabelSetColor(VerwarungGUI_Label[3],0,255,0)
guiSetFont(VerwarungGUI_Label[3],"default-bold-small")
guiWindowSetSizable ( VerwarungGUI_Window[1], false )
guiSetVisible( VerwarungGUI_Label[1], false)
guiSetVisible( VerwarungGUI_Window[1], false)

function showVerwarung()
	if not getElementData(getLocalPlayer(), "isPlayerLoggedIn") == true then return end
	if not getElementData(getLocalPlayer(), "isWaitingForDeath") == false then return end
	
	guiSetVisible( VerwarungGUI_Window[1], true)
	showCursor(true)
	loadVerwarung()
end

function isJobVehicle(vehicle)
	if getElementData(getLocalPlayer(), "rank") == 2 then
		if tostring(getElementData(vehicle, "owner")) == tostring(getElementData(getLocalPlayer(), "job")) then
			return true
		end
	end
	return false
end


function isGangVehicle(vehicle)
	if getElementData(getLocalPlayer(), "gangrank") == 2 then
		if tostring(getElementData(vehicle, "owner")) == "g"..tostring(getElementData(getLocalPlayer(), "gang")) then
			return true
		end
	end
	return false
end

function loadVerwarung()
	if not getElementData(getLocalPlayer(), "isPlayerLoggedIn") == true then return end
	showTutorialMessage("verwahrung_2", "Hier siehst du alle deine Fahrzeuge (oder die deiner Fraktion), die von der Polizei verwahrt wurden. Manche Fahrzeuge kannst du erst ab einem bestimmten Datum auslösen.")
	guiGridListClear ( VerwarungGUI_Grid[1] )
	guiSetVisible( VerwarungGUI_Label[1], false)
	for _, vehicle in ipairs(getElementsByType("fakeVehicle")) do
		if getElementData(vehicle, "owner") == getPlayerName(getLocalPlayer()) or isJobVehicle(vehicle) == true or isGangVehicle(vehicle) == true then
			local row = guiGridListAddRow(VerwarungGUI_Grid[1])
			guiGridListSetItemText ( VerwarungGUI_Grid[1], row, VerwarungGUI_Column[1], getVehicleNameFromModel ( getElementData(vehicle, "model") ), false, false )
			guiGridListSetItemText ( VerwarungGUI_Grid[1], row, VerwarungGUI_Column[2], getElementData(vehicle, "keys"), false, false )	
			if getElementData(vehicle, "vzeit") > getRealTime().timestamp then
				local datime = getRealTime(getElementData(vehicle, "vzeit"))
				guiGridListSetItemText ( VerwarungGUI_Grid[1], row, VerwarungGUI_Column[3], datime.monthday.."."..(datime.month+1).." "..datime.hour..":"..datime.minute, false, false )	
			else
				guiGridListSetItemText ( VerwarungGUI_Grid[1], row, VerwarungGUI_Column[3], "Jetzt", false, false )	
			end
		end
	end
end

function buyVehicleBack()
	local selectedRow, selectedCol = guiGridListGetSelectedItem( VerwarungGUI_Grid[1] )
	local name = guiGridListGetItemText ( VerwarungGUI_Grid[1], selectedRow, VerwarungGUI_Column[1] )
	local keys = guiGridListGetItemText ( VerwarungGUI_Grid[1], selectedRow, VerwarungGUI_Column[2] )
	for _, vehicle in ipairs(getElementsByType("fakeVehicle")) do
		if getElementData(vehicle, "owner") == getPlayerName(getLocalPlayer()) or isJobVehicle(vehicle) == true or isGangVehicle(vehicle) == true then
			if getElementData(vehicle, "keys") == keys and getVehicleNameFromModel ( getElementData(vehicle, "model") ) == name then
				if getElementData(vehicle, "vzeit") > getRealTime().timestamp then
					addNotification(1, 255, 0, 0, "Dein Fahrzeug kann noch nicht freigekauft werden.")
					return
				end
				if getPlayerMoneyEx(getLocalPlayer()) >= 600 then
					takePlayerMoneyEx(600)
					local model = getElementData(vehicle, "model")
					local x = 1139.6999511719--getElementData(vehicle, "x")
					local y = 1360.4000244141--getElementData(vehicle, "y")
					local z = 10.800000190735--getElementData(vehicle, "z")
					local rz = getElementData(vehicle, "rz")
					local c1 = getElementData(vehicle, "c1")
					local c2 = getElementData(vehicle, "c2")
					local c3 = getElementData(vehicle, "c3")
					local c4 = getElementData(vehicle, "c4")
					local health = getElementData(vehicle, "health")
					local panne = getElementData(vehicle, "panne")
					local km = getElementData(vehicle, "km")
					local fuel = getElementData(vehicle, "fuel")
					local oil = getElementData(vehicle, "oil")
					local battery = getElementData(vehicle, "battery")
					local water = getElementData(vehicle, "water")
					local keys = getElementData(vehicle, "keys")
					local owner = getElementData(vehicle, "owner")
					local eingepackt = getElementData(vehicle, "eingepackt")
					local vstatus = getElementData(vehicle, "vstatus")
					local preis = getElementData(vehicle, "preis")
					local paintjob = getElementData(vehicle, "paintjob")
					local var1 = getElementData(vehicle, "var1")
					local var2 = getElementData(vehicle, "var2")
					local mysqlID = getElementData(vehicle, "mysqlID")
					local upgrade = getElementData(vehicle, "upgrade")
					local damage = getElementData(vehicle, "damage")
					local doors = getElementData(vehicle, "doors")
					local wheels = getElementData(vehicle, "wheels")
					local lights = getElementData(vehicle, "lights")
					local color = getElementData(vehicle, "color")
					local tuev = getElementData(vehicle, "tuev")
					local inventory = getElementData(vehicle, "inventory")
					local herstelldatum = getElementData(vehicle, "herstelldatum")
					local tuevpreis = getElementData(vehicle, "tuevpreis")
					callServerFunction( "buyVehicleBack", model, x, y, z, rz, color, health, panne, km, fuel, oil, battery, water, keys, tostring(owner), eingepackt, vstatus, preis, paintjob, var1, var2, mysqlID, upgrade, damage, doors, wheels, lights, tuev, tuevpreis, herstelldatum, inventory )
					callServerFunction( "systemDeposit", "SASO", 600 )
					callServerFunction( "_destroyElement", vehicle )
					outputChatBox("Fahrzeug freigekauft.", 255, 0, 0)
					showTutorialMessage("verwahrung_1", "Dein Fahrzeug wurde freigekauft und steht am Tor zum Einsteigen bereit.")
				else
					addNotification(1, 255, 0, 0, "Du hast zu wenig Geld (mind. 600 Vero) um dein Fahrzeug freizukaufen.")
					guiSetVisible( VerwarungGUI_Label[1], true)
				end
				closeVerwarung()
				break
			end
		end
	end	
end	
addEventHandler ( "onClientGUIClick", VerwarungGUI_Button[1], buyVehicleBack )


function closeVerwarung()
    guiGridListClear ( VerwarungGUI_Grid[1] )
	guiSetVisible( VerwarungGUI_Window[1], false)
	showCursor(false)
end
addEventHandler ( "onClientGUIClick", VerwarungGUI_Button[2], closeVerwarung )