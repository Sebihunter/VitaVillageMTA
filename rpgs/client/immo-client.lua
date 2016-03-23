--[[
Project: VitaOnline
File: client-client.lua
Author(s):	Sebihunter
]]--

local atHouse = nil

HausGUI_1_Window = {}
HausGUI_1_Button = {}
HausGUI_1_Label = {}
HausGUI_2_Window = {}
HausGUI_2_Button = {}
HausGUI_2_Label = {}

HausGUI_1_Window[1] = guiCreateWindow(screenWidth/2-329/2,screenHeight/2-268/2,329,268,"Immobilien System",false)
HausGUI_1_Label[1] = guiCreateLabel(10,26,55,18,"Kaufpreis:",false,HausGUI_1_Window[1])
HausGUI_1_Label[2] = guiCreateLabel(9,65,52,18,"Immo-ID:",false,HausGUI_1_Window[1])
HausGUI_1_Button[1] = guiCreateButton(15,182,115,29,"Kaufen",false,HausGUI_1_Window[1])
HausGUI_1_Button[2] = guiCreateButton(206,182,104,29,"Mieten",false,HausGUI_1_Window[1])
HausGUI_1_Label[4] = guiCreateLabel(158,26,55,17,"Mietpreis:",false,HausGUI_1_Window[1])
HausGUI_1_Label[5] = guiCreateLabel(11,104,305,63,"Info: Die Miete wird Woechentlich automatisch von deinem Konto abgezogen. Wenn du die Immobilie kaufst dann kannst du bis zu zwei Untermieter bei dir einziehen lassen.",false,HausGUI_1_Window[1])
guiLabelSetHorizontalAlign(HausGUI_1_Label[5],"left",true)
HausGUI_1_Label[6] = guiCreateLabel(16,227,293,29,"Fehler: Du bist dein Terrorist",false,HausGUI_1_Window[1])
HausGUI_1_Button[3] = guiCreateButton(206,227,104,29,"Schliessen",false,HausGUI_1_Window[1])
guiLabelSetColor(HausGUI_1_Label[6],255,0,0)
guiLabelSetHorizontalAlign(HausGUI_1_Label[6],"left",true)
HausGUI_1_Label[7] = guiCreateLabel(66,66,54,18,"14",false,HausGUI_1_Window[1])
guiSetFont(HausGUI_1_Label[7],"default-bold-small")
HausGUI_1_Label[8] = guiCreateLabel(70,27,78,18,"12345678901",false,HausGUI_1_Window[1])
guiLabelSetColor(HausGUI_1_Label[8],0,255,0)
guiSetFont(HausGUI_1_Label[8],"default-bold-small")
HausGUI_1_Label[9] = guiCreateLabel(215,26,82,18,"12345678901",false,HausGUI_1_Window[1])
guiLabelSetColor(HausGUI_1_Label[9],0,255,0)
guiSetFont(HausGUI_1_Label[9],"default-bold-small")
guiSetVisible( HausGUI_1_Window[1], false)
guiSetVisible( HausGUI_1_Label[6], false)

HausGUI_2_Window[1] = guiCreateWindow(screenWidth/2-329/2,screenHeight/2-268/2,329,268,"Immobilien System",false)
HausGUI_2_Label[1] = guiCreateLabel(8,76,73,18,"Hausbesitzer:",false,HausGUI_2_Window[1])
HausGUI_2_Label[2] = guiCreateLabel(9,29,52,18,"Immo-ID:",false,HausGUI_2_Window[1])
HausGUI_2_Button[1] = guiCreateButton(15,182,115,29,"Schluessel",false,HausGUI_2_Window[1])
HausGUI_2_Button[2] = guiCreateButton(206,182,104,29,"Betreten",false,HausGUI_2_Window[1])
HausGUI_2_Label[4] = guiCreateLabel(8,112,68,17,"Bewohner:",false,HausGUI_2_Window[1])
HausGUI_2_Label[5] = guiCreateLabel(16,227,293,29,"Fehler: Du hast keinen Schluessel!",false,HausGUI_2_Window[1])
HausGUI_2_Button[3] = guiCreateButton(206,227,104,29,"Schliessen",false,HausGUI_2_Window[1])
guiLabelSetColor(HausGUI_2_Label[5],255,0,0)
guiLabelSetHorizontalAlign(HausGUI_2_Label[5],"left",true)
HausGUI_2_Label[6] = guiCreateLabel(66,30,54,18,"14",false,HausGUI_2_Window[1])
guiSetFont(HausGUI_2_Label[6],"default-bold-small")
HausGUI_2_Label[8] = guiCreateLabel(84,78,118,16,"Alex.Alex",false,HausGUI_2_Window[1])
guiSetFont(HausGUI_2_Label[8],"default-bold-small")
HausGUI_2_Label[9] = guiCreateLabel(78,114,229,49,"Alex.Alex und Hose.Voll und Kack.Tusevollerlangenamenundsoweiter",false,HausGUI_2_Window[1])
guiLabelSetHorizontalAlign(HausGUI_2_Label[9],"left",true)
guiSetFont(HausGUI_2_Label[9],"default-bold-small")
guiSetVisible( HausGUI_2_Window[1], false)
guiSetVisible( HausGUI_2_Label[5], false)

function showImmo1(house)
	atHouse = house
	guiSetText(HausGUI_1_Label[7], getElementData(atHouse, "intID"))
	guiSetText(HausGUI_1_Label[8], getElementData(atHouse, "preis").." Vero")
	guiSetText(HausGUI_1_Label[9], getElementData(atHouse, "miete").." Vero")
	guiSetVisible( HausGUI_1_Window[1], true)
	guiSetVisible( HausGUI_1_Label[6], false)
	showTutorialMessage("haus_2", "Dieses Haus ist noch frei und kann gekauft oder gemietet werden. Die Miete wird ein Mal wöffentlich von deinem Konto abgezogen.")
	showTutorialMessage("haus_3", "Wenn du 2 Monate nicht am Server spielst wird deine Immobilie automatisch ohne Geldretournierung vom Staat gepfändet.")
	showCursor(true)
end

function closeImmo1()
	guiSetVisible( HausGUI_1_Window[1], false)
	showCursor(false)
end
addEventHandler ( "onClientGUIClick", HausGUI_1_Button[3], closeImmo1 )

function buyImmo()
	if getElementData(atHouse, "owner") == "Niemand" then
		if getPlayerMoneyEx(getLocalPlayer()) >= getElementData(atHouse, "preis") then
			takePlayerMoneyEx(getElementData(atHouse, "preis"))
			setElementData(atHouse, "owner", getPlayerName(getLocalPlayer()))
			outputChatBox("Immobilie erfolgreich gekauft.", 0, 255, 0)
			callServerFunction( "systemDeposit", "SASO", getElementData(atHouse, "preis") )
			setTimer(
				function()
					callServerFunction( "refreshHousePickup", atHouse)
				end
			,500,1)
			closeImmo1()
			showImmo2(atHouse)
		else
			guiSetText(HausGUI_1_Label[6], "Fehler: Zu wenig Geld auf der Hand.")
			guiSetVisible( HausGUI_1_Label[6], true)
		end
	end
end
addEventHandler ( "onClientGUIClick", HausGUI_1_Button[1], buyImmo )

function rentImmo()
	--outputChatBox("Immobilien koennen im Moment noch nicht gemietet werden.", 255, 0, 0)
	--guiSetVisible( HausGUI_1_Window[1], false)
	--showCursor(false)
	if getElementData(atHouse, "owner") == "Niemand" then
		callServerFunction( "rentHouse", getLocalPlayer(), atHouse )
	end
end
addEventHandler ( "onClientGUIClick", HausGUI_1_Button[2], rentImmo )

function showImmo2(house)
	showTutorialMessage("haus_1", "Dieses Haus gehört bereits jemanden. Wenn es nicht abgeschlossen ist, kannst du es betreten und auch im abgeschlossenen Zustand wieder verlassen.")
	atHouse = house
	guiSetText(HausGUI_2_Label[6], getElementData(atHouse, "intID"))
	guiSetText(HausGUI_2_Label[8], getElementData(atHouse, "owner"))
	guiSetText(HausGUI_2_Label[9], getElementData(atHouse, "keys"))
	guiSetVisible( HausGUI_2_Window[1], true)
	guiSetVisible( HausGUI_2_Label[5], false)
	showCursor(true)
end

function lockImmo()
	if isHouseOwner(getLocalPlayer(), getElementData(atHouse, "keys")) == true or isHouseOwner(getLocalPlayer(), getElementData(atHouse, "owner")) == true then
		if getElementData(atHouse, "locked") == true then
			outputChatBox("Haus aufgesperrt.",0,255,0)
			setElementData(atHouse, "locked", false)
		else
			outputChatBox("Haus abgesperrt.",0,255,0)
			setElementData(atHouse, "locked", true)
		end
	else
		guiSetText(HausGUI_2_Label[5], "Fehler: Du hast keinen Schluessel.")
		guiSetVisible( HausGUI_2_Label[5], true)	
	end
end
addEventHandler ( "onClientGUIClick", HausGUI_2_Button[1], lockImmo )

function enterImmo()
	if (getElementData(atHouse, "locked") == false) or (isHouseOwner(getLocalPlayer(), getElementData(atHouse, "keys")) == true or isHouseOwner(getLocalPlayer(), getElementData(atHouse, "owner")) == true) then
		local x, y, z = getElementPosition(getElementData(atHouse, "ref"))
		local int = getElementInterior(getElementData(atHouse, "ref"))
		local dim = getElementDimension(getElementData(atHouse, "ref"))
		callServerFunction("setElementPosition", getLocalPlayer(), x, y, z)
		callServerFunction("setElementInterior", getLocalPlayer(), int)
		callServerFunction("setElementDimension", getLocalPlayer(), dim)
		guiSetVisible( HausGUI_2_Window[1], false)
		showCursor(false)
	else
		guiSetText(HausGUI_2_Label[5], "Fehler: Haus abgesperrt.")
		guiSetVisible( HausGUI_2_Label[5], true)
	end
end
addEventHandler ( "onClientGUIClick", HausGUI_2_Button[2], enterImmo )

function closeImmo2()
	guiSetVisible( HausGUI_2_Window[1], false)
	showCursor(false)	
end
addEventHandler ( "onClientGUIClick", HausGUI_2_Button[3], closeImmo2 )

function isHouseOwner(ply, ownerstring)
	local ownerTable = split(ownerstring, string.byte(','))
	for k,v in ipairs(ownerTable) do
		if v == getPlayerName(ply) then
			return true
		end
	end
	return false
end