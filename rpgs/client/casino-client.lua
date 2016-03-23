--[[
Project: VitaOnline
File: root-client.lua
Author(s):	Tommi
			Sebihunter
]]--


local showSpace 		= 3
local casinoGUI 		= {
    button 				= {},
    window 				= {},
    staticimage 		= {}
}
casinoGUI.window[1] 	= guiCreateWindow(screenWidth/2 - 298/2, screenHeight/2 - 208/2, 298, 208, "Slotmaschine", false)
guiWindowSetSizable(casinoGUI.window[1], false)
--local gx,gy = guiGetSize(casinoGUI.window[1])
casinoGUI.button[1] 	= guiCreateButton(193, 161, 90, 30, "10 Vero", false, casinoGUI.window[1])
guiSetProperty(casinoGUI.button[1], "NormalTextColour", "FFAAAAAA")
casinoGUI.button[2] 	= guiCreateButton(259, 22, 29, 28, "X", false, casinoGUI.window[1])
guiSetProperty(casinoGUI.button[2], "NormalTextColour", "FFAAAAAA")
guiSetVisible ( casinoGUI.window[1], false )
guiWindowSetMovable(casinoGUI.window[1], false)
guiWindowSetSizable(casinoGUI.window[1], false)

local State = 0

function closeCasino ()
	if State == 1 then
		guiSetVisible ( casinoGUI.window[1], false )		
		for i = 1, 3 do 
			if isElement(casinoGUI.staticimage[i]) then
				destroyElement(casinoGUI.staticimage[i])
			end		
		end	
		setElementFrozen(getLocalPlayer(), false)
		showCursor (false)
		State = 0
	end
end
addEventHandler ( "onClientGUIClick", casinoGUI.button[2], closeCasino, false )

function openCasino (ply, dim)
	if ply ~= getLocalPlayer() or dim ~= true then return false end
	if State == 1 then
		return false
	end
	losung (1, 2, 3)
	setElementFrozen(getLocalPlayer(), true)
	guiSetVisible (casinoGUI.window[1], true)
	showCursor (true)
	State = 1
end

function blamierenoderkassieren ()
	if getElementData(getLocalPlayer(),"geld") < 10 then
		return addNotification(1, 255, 0, 0, "Du benötigst 10 Vero.")
	end
	guiSetText(casinoGUI.button[1],"Warten ("..tostring(showSpace).." sek.)")
	guiSetEnabled(casinoGUI.button[1],false)
	setTimer(resetShowSpace,1000,1)
	setElementData(getLocalPlayer(), "geld", getElementData(getLocalPlayer(), "geld")-10)

	local randomt1 = math.random ( 1, 3 )
	local randomt2 = math.random ( 1, 3 )
	local randomt3 = math.random ( 1, 3 )
	losung(randomt1, randomt2, randomt3)
	if randomt1 == randomt2 and randomt1 == randomt3 and randomt2 == randomt3 then
		if randomt1 == 1 then
			addNotification(4, 130, 45, 55, "Drei Gleiche, aber leider die Falschen.\nProbiere es doch gleich nochmal.")
		elseif randomt1 == 2 then
			setElementData(getLocalPlayer(),"geld",getElementData(getLocalPlayer(),"geld")+510)
			addNotification(4, 130, 45, 55, "Du hast 500 Vero gewonnen.\nGratulation.")
		elseif randomt1 == 3 then
			callServerFunction("giveItem", getLocalPlayer(), 1)
			addNotification(4, 130, 45, 55, "Du hast leider nur eine Wurstsemmel gewonnen.\nProbiere es doch gleich nochmal.")
		end
	else
		addNotification(4, 130, 45, 55, "Leider nichts gewonnen.\nProbiere es doch gleich nochmal.")
	end
end
addEventHandler ( "onClientGUIClick", casinoGUI.button[1], blamierenoderkassieren, false )

function resetShowSpace()
	if showSpace-1 >= 1 then
		showSpace = showSpace - 1
		guiSetText(casinoGUI.button[1],"Warten ("..tostring(showSpace).." sek.)")
		setTimer(resetShowSpace,1000,1)
	else
		guiSetText(casinoGUI.button[1],"10 Vero")
		guiSetEnabled(casinoGUI.button[1],true)
		showSpace = 3
	end
end

function losung (randomt1, randomt2, randomt3)
	for i = 1, 3 do 
		if isElement(casinoGUI.staticimage[i]) then
			destroyElement(casinoGUI.staticimage[i])
		end	
	end
	casinoGUI.staticimage[1] = guiCreateStaticImage(75-44/2, 70, 44, 55, "images/casino/"..tostring(randomt1)..".jpg", false, casinoGUI.window[1])
	casinoGUI.staticimage[2] = guiCreateStaticImage(149-44/2, 70, 44, 55, "images/casino/"..tostring(randomt2)..".jpg", false, casinoGUI.window[1])
	casinoGUI.staticimage[3] = guiCreateStaticImage(224-44/2, 70, 44, 55, "images/casino/"..tostring(randomt3)..".jpg", false, casinoGUI.window[1])
end
addEvent ( "Fortsetzung", true )
addEventHandler ( "Fortsetzung", root, losung )


local slotMachine = {
{1956.817,1047.399,992.468},
{1958.248,1049.10,992.468},
{1963.083,1044.086,992.468},
{1961.140,1043.009,992.468},
{1963.7595,1037.1968,992.468},
{1965.854,998.149,992.468},
{1963.605,998.732,992.468},
{1963.055,911.458,992.468},
{1958.1488,986.5627,992.468},
{1956.966,988.258,992.468}
}

for i,v in ipairs(slotMachine) do
	local marker = createMarker ( v[1],v[2], v[3] , "corona", 1, 0,0,0,0, getRootElement())
	addEventHandler("onClientMarkerHit", marker, openCasino)
end