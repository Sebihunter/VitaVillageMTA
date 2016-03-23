--[[
Project: VitaOnline
File: autohaus-client.lua
Author(s):	Sebihunter
]]--

local music = playSound3D ( "http://www.top100station.de/switch/top100station_lq.asx", 1087.364,1751.748,10.8203, true )
setSoundMaxDistance ( music, 30 )

local zip1 = createObject(7901, 992.20001, 1732.9, 21.2,0,0,90)
replaceTexture(zip1, "bobobillboard1", "images/ares_neu.jpg")
setElementDoubleSided ( zip1, true)
setObjectScale(zip1,  2)
setElementCollisionsEnabled (zip1,false )		

AutokaufGUI_Window = {}
AutokaufGUI_Button = {}
AutokaufGUI_Label = {}

AutokaufGUI_Window[1] = guiCreateWindow(0.8542,0.8333,0.1363,0.1448,"Autokauf",true)
AutokaufGUI_Label[1] = guiCreateLabel(11,33,441,34,"Autoname:",false,AutokaufGUI_Window[1])
guiLabelSetColor(AutokaufGUI_Label[1],125,125,0)
guiLabelSetVerticalAlign(AutokaufGUI_Label[1],"top")
guiLabelSetHorizontalAlign(AutokaufGUI_Label[1],"left",false)
guiSetFont(AutokaufGUI_Label[1],"default-bold-small")
AutokaufGUI_Label[2] = guiCreateLabel(13,49,439,25,"Infernus",false,AutokaufGUI_Window[1])
guiLabelSetColor(AutokaufGUI_Label[2],255,255,255)
guiLabelSetVerticalAlign(AutokaufGUI_Label[2],"top")
guiLabelSetHorizontalAlign(AutokaufGUI_Label[2],"left",false)
guiSetFont(AutokaufGUI_Label[2],"default-small")
AutokaufGUI_Label[3] = guiCreateLabel(0.048,0.4408,0.9735,0.1115,"Autopreis:",true,AutokaufGUI_Window[1])
guiLabelSetColor(AutokaufGUI_Label[3],125,125,0)
guiLabelSetVerticalAlign(AutokaufGUI_Label[3],"top")
guiLabelSetHorizontalAlign(AutokaufGUI_Label[3],"left",false)
guiSetFont(AutokaufGUI_Label[3],"default-bold-small")
AutokaufGUI_Label[4] = guiCreateLabel(0.0568,0.5526,0.9691,0.082,"1337 Vero",true,AutokaufGUI_Window[1])
guiLabelSetColor(AutokaufGUI_Label[4],255,255,255)
guiLabelSetVerticalAlign(AutokaufGUI_Label[4],"top")
guiLabelSetHorizontalAlign(AutokaufGUI_Label[4],"left",false)
guiSetFont(AutokaufGUI_Label[4],"default-small")
AutokaufGUI_Button[1] = guiCreateButton(0.0524,0.75,0.4236,0.1513,"Auto Kaufen",true,AutokaufGUI_Window[1])
AutokaufGUI_Button[2] = guiCreateButton(0.5371,0.75,0.4236,0.1513,"Abbrechen",true,AutokaufGUI_Window[1])

guiSetVisible(AutokaufGUI_Window[1], false)

setTimer(function()
	if guiGetVisible(AutokaufGUI_Window[1]) == true or guiGetVisible(GWkaufGUI_Window[1]) == true then
		toggleAllControls ( false )
		showCursor(true)
	end
end, 500, 0)

function showAutokaufMenu()
	guiSetText ( AutokaufGUI_Label[2], getVehicleName ( getPedOccupiedVehicle(getLocalPlayer()) ) )
	guiSetText ( AutokaufGUI_Label[4], getElementData(getPedOccupiedVehicle(getLocalPlayer()), "preis").." Vero" )
    guiSetVisible(AutokaufGUI_Window[1], true)  
	toggleAllControls ( false )
	showCursor(true)
end

--addEvent("InitKaufGui", true)
--addEventHandler( "InitKaufGui", getRootElement(), InitKaufGui) -- gibt ein warning!

function cancelKaufGui(button)
        if button == "left" then
			toggleAllControls ( true )
			makePlayerExitVehicle()
			
			showCursor( false )
			guiSetVisible(AutokaufGUI_Window[1], false)
        end
end
addEventHandler("onClientGUIClick", AutokaufGUI_Button[2], cancelKaufGui, false)

function buyKaufGui(button)
        if button == "left" then
			toggleAllControls ( true )
			
			local vehicle = getPedOccupiedVehicle(getLocalPlayer())
			local hasLicense = false
			if (getElementData(getLocalPlayer(), "aschein") and (getVehicleType(vehicle) == "Automobile" or getVehicleType(vehicle) == "Monster Truck")) then hasLicense = true end
			if (getElementData(getLocalPlayer(), "fschein") and (getVehicleType(vehicle) == "Plane" or getVehicleType(vehicle) == "Helicopter")) then hasLicense = true end
			if (getElementData(getLocalPlayer(), "bschein") and (getVehicleType(vehicle) == "Trailer")) then hasLicense = true end
			if (getElementData(getLocalPlayer(), "mschein") and (getVehicleType(vehicle) == "Bike" or getVehicleType(vehicle) == "Quad")) then hasLicense = true end
			if (getVehicleType(vehicle) == "BMX" or getVehicleType(vehicle) == "Train" or getVehicleType(vehicle) == "Boat") then hasLicense = true end
			if hasLicense == false then return addNotification(1, 255, 0, 0, "Du hast keinen Führerschein für diesen Fahrzeugtyp.")end
			
			if getElementData(getPedOccupiedVehicle(getLocalPlayer()), "preis") > getPlayerMoneyEx ( getLocalPlayer() ) then
				makePlayerExitVehicle()
				addNotification(1, 255, 0, 0, "Dieses Fahrzeug kostet zu viel.")
			else
				if getElementData(getPedOccupiedVehicle(getLocalPlayer()), "isWangVehicle") == true then
					takePlayerMoneyEx ( getElementData(getPedOccupiedVehicle(getLocalPlayer()), "preis") )
					triggerServerEvent("addJobMoney", getRootElement(), "Trucker", math.floor(getElementData(getPedOccupiedVehicle(getLocalPlayer()), "preis")/3))
					triggerServerEvent("addJobMoney", getRootElement(), "Autohus", math.floor(getElementData(getPedOccupiedVehicle(getLocalPlayer()), "preis")/3))
					triggerServerEvent("addJobMoney", getRootElement(), "Autohaus", math.floor(getElementData(getPedOccupiedVehicle(getLocalPlayer()), "preis")/3))
					addNotification(2, 0, 255, 0, "Fahrzeug erfolgreich gekauft.\nEs befindet sich an der äußeren Ausgabestelle im oberen Stockwerk.")
					local r1,g1,b1,r2,g2,b2,r3,g3,b3,r4,g4,b4 = getVehicleColor ( getPedOccupiedVehicle(getLocalPlayer()) )
					local colortable = {{r1,g1,b1}, {r2,g2,b2}, {r3,g3,b3},{r4,g4,b4}}					
					
					callServerFunction("createRPGVehicle", getElementModel(getPedOccupiedVehicle(getLocalPlayer())),-1920.6484375, 303.4150390625, 40.937034606934, 99.386596679688,getPlayerName(getLocalPlayer()),colortable,false, false)
					makePlayerExitVehicle()
				else
					takePlayerMoneyEx ( getElementData(getPedOccupiedVehicle(getLocalPlayer()), "preis") )
					local veh = getPedOccupiedVehicle(getLocalPlayer())
					triggerServerEvent ( "onclientbuyveh", getRootElement(), veh )
					setElementData( getPedOccupiedVehicle(getLocalPlayer()), "tuev", getRealTime().yearday)
					setElementData( getPedOccupiedVehicle(getLocalPlayer()), "vstatus", false)
					setElementData( getPedOccupiedVehicle(getLocalPlayer()), "owner", getPlayerName(getLocalPlayer()))
					setElementData( getPedOccupiedVehicle(getLocalPlayer()), "keys", getPlayerName(getLocalPlayer()))
					setElementData ( getPedOccupiedVehicle(getLocalPlayer()), "reserviert", "Niemand")
					triggerServerEvent("addJobMoney", getRootElement(), "Autohaus", getElementData(getPedOccupiedVehicle(getLocalPlayer()), "preis"))
					addNotification(2, 0, 255, 0, "Fahrzeug erfolgreich gekauft.")
				end
			end

			showCursor( false )
			guiSetVisible(AutokaufGUI_Window[1], false)  			
        end
end
addEventHandler("onClientGUIClick", AutokaufGUI_Button[1], buyKaufGui, false)



--Gebrauchtwagenhaendler Kopie

GWkaufGUI_Window = {}
GWkaufGUI_Button = {}
GWkaufGUI_Label = {}

GWkaufGUI_Window[1] = guiCreateWindow(0.8542,0.8333,0.1363,0.1448,"Gebrauchtwagen",true)
GWkaufGUI_Label[1] = guiCreateLabel(11,33,441,34,"Autoname:",false,GWkaufGUI_Window[1])
guiLabelSetColor(GWkaufGUI_Label[1],125,125,0)
guiLabelSetVerticalAlign(GWkaufGUI_Label[1],"top")
guiLabelSetHorizontalAlign(GWkaufGUI_Label[1],"left",false)
guiSetFont(GWkaufGUI_Label[1],"default-bold-small")
GWkaufGUI_Label[2] = guiCreateLabel(13,49,439,25,"Infernus",false,GWkaufGUI_Window[1])
guiLabelSetColor(GWkaufGUI_Label[2],255,255,255)
guiLabelSetVerticalAlign(GWkaufGUI_Label[2],"top")
guiLabelSetHorizontalAlign(GWkaufGUI_Label[2],"left",false)
guiSetFont(GWkaufGUI_Label[2],"default-small")
GWkaufGUI_Label[3] = guiCreateLabel(0.048,0.4408,0.9735,0.1115,"Autopreis:",true,GWkaufGUI_Window[1])
guiLabelSetColor(GWkaufGUI_Label[3],125,125,0)
guiLabelSetVerticalAlign(GWkaufGUI_Label[3],"top")
guiLabelSetHorizontalAlign(GWkaufGUI_Label[3],"left",false)
guiSetFont(GWkaufGUI_Label[3],"default-bold-small")
GWkaufGUI_Label[4] = guiCreateLabel(0.0568,0.5526,0.9691,0.082,"1337 Vero",true,GWkaufGUI_Window[1])
guiLabelSetColor(GWkaufGUI_Label[4],255,255,255)
guiLabelSetVerticalAlign(GWkaufGUI_Label[4],"top")
guiLabelSetHorizontalAlign(GWkaufGUI_Label[4],"left",false)
guiSetFont(GWkaufGUI_Label[4],"default-small")
GWkaufGUI_Button[1] = guiCreateButton(0.0524,0.75,0.4236,0.1513,"Auto Kaufen",true,GWkaufGUI_Window[1])
GWkaufGUI_Button[2] = guiCreateButton(0.5371,0.75,0.4236,0.1513,"Abbrechen",true,GWkaufGUI_Window[1])

guiSetVisible(GWkaufGUI_Window[1], false)

function showGWkaufMenu()
	guiSetText ( GWkaufGUI_Label[2], getVehicleName ( getPedOccupiedVehicle(getLocalPlayer()) ) )
	guiSetText ( GWkaufGUI_Label[4], getElementData(getPedOccupiedVehicle(getLocalPlayer()), "preis").." Vero" )
    guiSetVisible(GWkaufGUI_Window[1], true)  
	toggleAllControls ( false )
	showCursor(true)
end

--addEvent("InitKaufGui", true)
--addEventHandler( "InitKaufGui", getRootElement(), InitKaufGui) -- gibt ein warning!

function cancelKaufGui2(button)
        if button == "left" then
			toggleAllControls ( true )
			makePlayerExitVehicle()
			
			showCursor( false )
			guiSetVisible(GWkaufGUI_Window[1], false)
        end
end
addEventHandler("onClientGUIClick", GWkaufGUI_Button[2], cancelKaufGui2, false)

function buyKaufGui2(button)
        if button == "left" then
			toggleAllControls ( true )
			
			local vehicle = getPedOccupiedVehicle(getLocalPlayer())
			local hasLicense = false
			if (getElementData(getLocalPlayer(), "aschein") and (getVehicleType(vehicle) == "Automobile" or getVehicleType(vehicle) == "Monster Truck")) then hasLicense = true end
			if (getElementData(getLocalPlayer(), "fschein") and (getVehicleType(vehicle) == "Plane" or getVehicleType(vehicle) == "Helicopter")) then hasLicense = true end
			if (getElementData(getLocalPlayer(), "bschein") and (getVehicleType(vehicle) == "Trailer")) then hasLicense = true end
			if (getElementData(getLocalPlayer(), "mschein") and (getVehicleType(vehicle) == "Bike" or getVehicleType(vehicle) == "Quad")) then hasLicense = true end
			if (getVehicleType(vehicle) == "BMX" or getVehicleType(vehicle) == "Train" or getVehicleType(vehicle) == "Boat") then hasLicense = true end
			if hasLicense == false then return addNotification(1, 255, 0, 0, "Du hast keinen Führerschein für diesen Fahrzeugtyp.")end
			
			if getElementData(getPedOccupiedVehicle(getLocalPlayer()), "preis") > getPlayerMoneyEx ( getLocalPlayer() ) then
				makePlayerExitVehicle()
				addNotification(1, 255, 0, 0, "Dieses Fahrzeug kostet zu viel.")
			else
				takePlayerMoneyEx ( getElementData(getPedOccupiedVehicle(getLocalPlayer()), "preis") )
				local veh = getPedOccupiedVehicle(getLocalPlayer())
				triggerServerEvent ( "onclientbuyveh", getRootElement(), veh )
				if getElementData(getPedOccupiedVehicle(getLocalPlayer()), "tuev") + 14 < getRealTime().yearday then
					local tuev = getRealTime().yearday-13
					if tuev < 0 then tuev = 365+tuev end
					setElementData( getPedOccupiedVehicle(getLocalPlayer()), "tuev", tuev)
					addNotification(2, 0, 255, 0, "Automatische 1-Tages-TÜV Plakette für dieses Fahrzeug bekommen.")
				end
				local owner = getElementData(getPedOccupiedVehicle(getLocalPlayer()), "owner")
				setElementData( getPedOccupiedVehicle(getLocalPlayer()), "vstatus", false)
				setElementData( getPedOccupiedVehicle(getLocalPlayer()), "owner", getPlayerName(getLocalPlayer()))
				setElementData( getPedOccupiedVehicle(getLocalPlayer()), "keys", getPlayerName(getLocalPlayer()))
				setElementData ( getPedOccupiedVehicle(getLocalPlayer()), "reserviert", "Niemand")
				if owner == "5" then
					triggerServerEvent("addJobMoney", getRootElement(), "Autohus", getElementData(getPedOccupiedVehicle(getLocalPlayer()), "preis"))
				elseif owner == "11" then
					triggerServerEvent("addJobMoney", getRootElement(), "car4you", getElementData(getPedOccupiedVehicle(getLocalPlayer()), "preis"))
				end
				addNotification(2, 0, 255, 0, "Fahrzeug erfolgreich gekauft.")
			end

			showCursor( false )
			guiSetVisible(GWkaufGUI_Window[1], false)  			
        end
end
addEventHandler("onClientGUIClick", GWkaufGUI_Button[1], buyKaufGui2, false)