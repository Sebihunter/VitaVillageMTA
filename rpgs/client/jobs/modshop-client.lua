--[[
Project: VitaOnline
File: modshop-client.lua
Author(s):	Sebihunter
]]--

TuneGUI_Window = {}
TuneGUI_Button = {}
TuneGUI_Button_b = {}
TuneGUI_Label = {}
TuneGUI_Edit = {}
TuneGUI_Grid = {}
local screenx, screeny = guiGetScreenSize ()

TuneGUI_Window[1] = guiCreateWindow(screenx-367,screeny-352,367,352,"Tuning",false)
TuneGUI_Label[1] = guiCreateLabel(0.0339,0.074,0.2373,0.0562,"Var1, Var2:",true,TuneGUI_Window[1])
guiLabelSetColor(TuneGUI_Label[1],255,255,255)
guiLabelSetVerticalAlign(TuneGUI_Label[1],"center")
guiLabelSetHorizontalAlign(TuneGUI_Label[1],"left",false)
guiSetFont(TuneGUI_Label[1],"default-bold-small")
TuneGUI_Edit[1] = guiCreateEdit(0.2712,0.0769,0.2203,0.0562,"",true,TuneGUI_Window[1])
TuneGUI_Edit[2] = guiCreateEdit(0.5254,0.0769,0.2203,0.0562,"",true,TuneGUI_Window[1])
TuneGUI_Button_b[1] = guiCreateButton(0.0407,0.8846,0.9288,0.0858,"Beenden",true,TuneGUI_Window[1])
TuneGUI_Button_b[3] = guiCreateButton(0.5,0.1627,0.461,0.0651,"Variant (Var1, Var2)",true,TuneGUI_Window[1])
TuneGUI_Button_b[4] = guiCreateButton(0.5,0.2827,0.461,0.0651,"Paintjob (Var1)",true,TuneGUI_Window[1])

TuneGUI_Button_b[2] = guiCreateButton(0.1339,0.4627,0.361,0.0651,"Lackieren (Lack 1)",true,TuneGUI_Window[1])
TuneGUI_Button_b[5] = guiCreateButton(0.5339,0.4627,0.361,0.0651,"Lackieren (Lack 2)",true,TuneGUI_Window[1])
TuneGUI_Button_b[6] = guiCreateButton(0.1339,0.5627,0.361,0.0651,"Lackieren (Lack 3)",true,TuneGUI_Window[1])
TuneGUI_Button_b[7] = guiCreateButton(0.5339,0.5627,0.361,0.0651,"Lackieren (Lack 4)",true,TuneGUI_Window[1])
TuneGUI_Edit[3] = guiCreateEdit(0.1339,0.6769,0.3,0.0562,"",true,TuneGUI_Window[1])
TuneGUI_Button_b[8] = guiCreateButton(0.4639,0.6769,0.15,0.0562,"SET RGB",true,TuneGUI_Window[1])

guiSetPosition(TuneGUI_Window[1], screenx-367,screeny-652,false)
guiSetSize(TuneGUI_Window[1],367,652,false)

local gridlist
local column

gridlist = guiCreateGridList ( screenx-290, screeny-300, 100, 280, false )
column = guiGridListAddColumn( gridlist, "Tuning", 0.85 )


local fbtns = 2

function modVeh ( button )
		local therow = guiGridListGetSelectedItem (gridlist)
		if not (therow == -1) then
			local thetext = guiGridListGetItemText(gridlist,therow,1)
			if button == "left" then
				if tonumber(thetext) == 1109 then addNotification(1, 255, 0, 0, "Kann diese ID nicht setzen:\nVerdächtigt Spielabstürze zu verursachen.") return end
				callServerFunction("addVehicleUpgrade", getPedOccupiedVehicle ( getLocalPlayer() ), tonumber(  thetext ))
			else
				callServerFunction("removeVehicleUpgrade", getPedOccupiedVehicle ( getLocalPlayer() ), tonumber(  thetext ))
			end
		end
end 

function openModGrid ( button )
    if button == "left" then
		guiSetVisible(gridlist,false)
        local upgrades = getVehicleCompatibleUpgrades( getPedOccupiedVehicle ( getLocalPlayer() ) )
		destroyElement(gridlist)
		gridlist =guiCreateGridList ( screenx-290, screeny-300, 100, 280, false )
		column = guiGridListAddColumn( gridlist, "Tuning", 0.85 )
		for k, v in ipairs( upgrades ) do
			if i ~= 12 and getVehicleUpgradeSlotName( v ) == guiGetText( source ) then
				local shit = guiGridListAddRow ( gridlist )
				guiGridListSetItemText ( gridlist, shit, column, tostring(v), false, false )
				guiSetVisible(gridlist,true)
			end
		end
		addEventHandler ("onClientGUIClick", gridlist, modVeh, false )
    end
end		
local sin, cos, pi, rad, rasdd, lp, rfd = math.sin, math.cos, math.pi, math.rad, 0, getLocalPlayer(), 0
rotatingCamIsEnabled=false
function renderthearroundcamthere()
	if not rotatingCamIsEnabled then return end
	rasdd = rasdd + 0.6 -- rot speed
	if rasdd >= 360 then rasdd = 0 end
	local phi=rad(rasdd)
	local sx,sy,sz = getElementPosition(getLocalPlayer())
	local camX = sx + 3*distanceasdd*cos(phi)*cos(theta)
	local camY = sy + 3*distanceasdd*sin(phi)*cos(theta)
	local camZ = sz + 0.4*distanceasdd + 2*distanceasdd*sin(theta)
	--local hit, hitX, hitY, hitZ = processLineOfSight(sx, sy, sz, camX, camY, camZ, true, false, false,true,false,true,false,false,false,false)
 	--if hit then
	--	--camX, camY, camZ = sx + 0.9*(hitX-sx), sy + 0.9*(hitY-sy), sz + 0.9*(hitZ-sz)
   	--end
   -- setCameraMatrix(camX,camY,camZ,sx,sy,sz)
	setElementVelocity(getPedOccupiedVehicle(getLocalPlayer()),0,0,0)
end

for i = 1, 17 do
    local upName = getVehicleUpgradeSlotName( i-1 )
    -- slot 11 is "Unknown"
    if not TuneGUI_Button[i] and i ~= 12 then
        TuneGUI_Button[i] = guiCreateButton( 0.0339, 0.1827 + (fbtns*0.04), 0.461, 0.04, upName, true, TuneGUI_Window[1] )
        guiSetVisible( TuneGUI_Button[i], false )
		addEventHandler ("onClientGUIClick", TuneGUI_Button[i], openModGrid, false )

        fbtns = fbtns + 1
    end
end


guiWindowSetSizable ( TuneGUI_Window[1] , false )
guiWindowSetMovable ( TuneGUI_Window[1] , false )
guiSetVisible(TuneGUI_Window[1],false)
guiSetVisible(gridlist, false)


function showUpgradeButtons( )
    local upgrades = getVehicleCompatibleUpgrades( getPedOccupiedVehicle ( getLocalPlayer() ) )
    local alreadySet = { }
    local btns = 2
    for i = 1, 17 do
        for k, v in ipairs( upgrades ) do
            if i ~= 12 and alreadySet[ i ] ~= true and getVehicleUpgradeSlotName( v ) == guiGetText( TuneGUI_Button[i] ) then 
                guiSetVisible( TuneGUI_Button[i], true )
				guiSetPosition( TuneGUI_Button[i],0.53, 0.4827 + (btns*0.04), true )
                alreadySet[ i ] = true
                btns = btns + 1
            end
        end
    end
end


function hideModdingButtons( )
    for i = 1, 17 do
        guiSetVisible( TuneGUI_Button[i], false )
    end
end

function setColorFunc(button)
        if button == "left" then
				local r1,b1,g1,r2,g2,b2,r3,g3,b3,r4,b4,g4 = getVehicleColor(getPedOccupiedVehicle ( getLocalPlayer() ), true)
				local r,g,b = pickerTable[1]:getPickedColor()
				callServerFunction("setVehicleColor", getPedOccupiedVehicle ( getLocalPlayer() ), r,g,b,r2,g2,b2,r3,g3,b3,r4,b4,g4)
        end
end

function setColorFunc2(button)
        if button == "left" then
				local r1,b1,g1,r2,g2,b2,r3,g3,b3,r4,b4,g4 = getVehicleColor(getPedOccupiedVehicle ( getLocalPlayer() ), true)
				local r,g,b = pickerTable[1]:getPickedColor()
				callServerFunction("setVehicleColor", getPedOccupiedVehicle ( getLocalPlayer() ), r1,g1,b1,r,g,b,r3,g3,b3,r4,b4,g4)
        end
end
function setColorFunc3(button)
        if button == "left" then
				local r1,b1,g1,r2,g2,b2,r3,g3,b3,r4,b4,g4 = getVehicleColor(getPedOccupiedVehicle ( getLocalPlayer() ), true)
				local r,g,b = pickerTable[1]:getPickedColor()
				callServerFunction("setVehicleColor", getPedOccupiedVehicle ( getLocalPlayer() ), r1,g1,b1,r2,g2,b2,r,g,b,r4,b4,g4)
        end
end
function setColorFunc4(button)
        if button == "left" then
				local r1,b1,g1,r2,g2,b2,r3,g3,b3,r4,b4,g4 = getVehicleColor(getPedOccupiedVehicle ( getLocalPlayer() ), true)
				local r,g,b = pickerTable[1]:getPickedColor()
				callServerFunction("setVehicleColor", getPedOccupiedVehicle ( getLocalPlayer() ), r1,g1,b1,r2,g2,b2,r3,g3,b3,r,b,g)
        end
end

function setVariantFunc(button)
        if button == "left" then
                callServerFunction("setVehicleVariant", getPedOccupiedVehicle ( getLocalPlayer() ), tonumber(guiGetText ( TuneGUI_Edit[1] )), tonumber(guiGetText ( TuneGUI_Edit[2] )), 0, 0)
        end
end

function setPaintjobFunc(button)
        if button == "left" then
                callServerFunction("setVehiclePaintjob", getPedOccupiedVehicle ( getLocalPlayer() ), tonumber(guiGetText ( TuneGUI_Edit[1] )), 0, 0)
        end
end

function setPickerColor(button)
        if button == "left" then
			updateViaHex(1, guiGetText ( TuneGUI_Edit[3] ))
        end
end
function stopTuneGUI(button)
        if button == "left" then               
                guiSetVisible(TuneGUI_Window[1],false)
				guiSetVisible(gridlist,false)
				closePicker(1)
                showCursor(false)
				rotatingCamIsEnabled=false
				removeEventHandler("onClientRender", getRootElement(), renderthearroundcamthere)
				setCameraTarget(getLocalPlayer(), getLocalPlayer())
        end
end

function startModshop ( )
	showTutorialMessage("modshop_1", "Im Tuning-Shop kannst du als AutoFix Mitarbeiter deinem Kunden das Fahrzeug modifizieren.")
	showTutorialMessage("modshop_2", "Du musst, nachdem du mit dem Tuning fertig bist, dem Spieler alle Modifikationen nach der Preisliste in Rechnung stellen.")

	rotatingCamIsEnabled=true
	theta = rad(5)
	distanceasdd = 4
	addEventHandler("onClientRender", getRootElement(), renderthearroundcamthere)
	hideModdingButtons( )
	showUpgradeButtons( )
	guiSetVisible(TuneGUI_Window[1],true)
	showCursor(true)
	openPicker(1, "#FFFFFF", "Farbe")
end


addEvent("startModshop", true)
addEventHandler( "startModshop", getRootElement(), startModshop)

addEventHandler("onClientGUIClick", TuneGUI_Button_b[1], stopTuneGUI, false)
addEventHandler("onClientGUIClick", TuneGUI_Button_b[2], setColorFunc, false)
addEventHandler("onClientGUIClick", TuneGUI_Button_b[5], setColorFunc2, false)
addEventHandler("onClientGUIClick", TuneGUI_Button_b[6], setColorFunc3, false)
addEventHandler("onClientGUIClick", TuneGUI_Button_b[7], setColorFunc4, false)
addEventHandler("onClientGUIClick", TuneGUI_Button_b[3], setVariantFunc, false)
addEventHandler("onClientGUIClick", TuneGUI_Button_b[4], setPaintjobFunc, false)
addEventHandler("onClientGUIClick", TuneGUI_Button_b[8], setPickerColor, false)