--[[
Project: VitaOnline
File: tacho-client.lua
Author(s):	Sebihunter
			Lexlo
]]--

TachoGUI_Label = {}
TachoGUI_Image = {}
--[[
TachoGUI_Image[1] = guiCreateStaticImage(screenWidth/2-(512/2)+364,screenHeight- 256+122,64,32,"images/tacho/blinkerLeftOff.png",false)
guiSetVisible(TachoGUI_Image[1], false)
TachoGUI_Image[2] = guiCreateStaticImage(screenWidth/2-(512/2)+408,screenHeight- 256+122,64,32,"images/tacho/blinkerRightOff.png",false)
guiSetVisible(TachoGUI_Image[2], false)
TachoGUI_Image[3] = guiCreateStaticImage(screenWidth/2-(512/2)+364,screenHeight- 256+149,64,32,"images/tacho/handbrakeOff.png",false)
guiSetVisible(TachoGUI_Image[3], false)
TachoGUI_Image[4] = guiCreateStaticImage(screenWidth/2-(512/2)+413,screenHeight- 256+148,64,32,"images/tacho/batteryOff.png",false)
guiSetVisible(TachoGUI_Image[4], false)
TachoGUI_Image[5] = guiCreateStaticImage(screenWidth/2-(512/2)+382,screenHeight- 256+180,32,32,"images/tacho/tankOff.png",false)
guiSetVisible(TachoGUI_Image[5], false)
TachoGUI_Image[6] = guiCreateStaticImage(screenWidth/2-(512/2)+367,screenHeight- 256+216,64,32,"images/tacho/oilOff.png",false)
guiSetVisible(TachoGUI_Image[6], false)
TachoGUI_Image[7] = guiCreateStaticImage(screenWidth/2-(512/2)+414,screenHeight- 256+179,64,32,"images/tacho/lightOff.png",false)
guiSetVisible(TachoGUI_Image[7], false)
TachoGUI_Image[8] = guiCreateStaticImage(screenWidth/2-(512/2)+423,screenHeight- 256+210,32,32,"images/tacho/temperatureOff.png",false)
guiSetVisible(TachoGUI_Image[8], false)]]


--TODO DOORS ON:
function createTachoImages()
	TachoGUI_Image[9] = guiCreateStaticImage(screenWidth-460, screenHeight-191, 455, 191,"images/tacho/blinkerLeftOn.png",false)
	guiSetVisible(TachoGUI_Image[9], false)
	TachoGUI_Image[10] = guiCreateStaticImage(screenWidth-460, screenHeight-191, 455, 191,"images/tacho/blinkerRightOn.png",false)
	guiSetVisible(TachoGUI_Image[10], false)
	TachoGUI_Image[11] = guiCreateStaticImage(screenWidth-460, screenHeight-191, 455, 191,"images/tacho/handbrakeOn.png",false)
	guiSetVisible(TachoGUI_Image[11], false)
	TachoGUI_Image[12] = guiCreateStaticImage(screenWidth-460, screenHeight-191, 455, 191,"images/tacho/batteryOn.png",false)
	guiSetVisible(TachoGUI_Image[12], false)
	TachoGUI_Image[13] = guiCreateStaticImage(screenWidth-460, screenHeight-191, 455, 191,"images/tacho/tankOn.png",false)
	guiSetVisible(TachoGUI_Image[13], false)
	TachoGUI_Image[14] = guiCreateStaticImage(screenWidth-460, screenHeight-191, 455, 191,"images/tacho/oilOn.png",false)
	guiSetVisible(TachoGUI_Image[14], false)
	TachoGUI_Image[15] = guiCreateStaticImage(screenWidth-460, screenHeight-191, 455, 191,"images/tacho/lightOn.png",false)
	guiSetVisible(TachoGUI_Image[15], false)
	TachoGUI_Image[16] = guiCreateStaticImage(screenWidth-460, screenHeight-191, 455, 191,"images/tacho/temperatureOn.png",false)
	guiSetVisible(TachoGUI_Image[16], false)
end

TachoGUI_Label[1] = guiCreateLabel(screenWidth-460+312,screenHeight-191+150,70,37,"500 KM",false)
guiLabelSetColor(TachoGUI_Label[1],255,255,255)
guiLabelSetVerticalAlign(TachoGUI_Label[1],"center")
guiLabelSetHorizontalAlign(TachoGUI_Label[1],"center",false)
guiSetFont(TachoGUI_Label[1],"default-bold-small")
guiSetVisible(TachoGUI_Label[1], false)
guiLabelSetColor ( TachoGUI_Label[1], 0, 0, 0)

--[[TachoGUI_Label[2] = guiCreateLabel(0.4839,0.8714,0.0423,0.0352,"0",true)
guiSetAlpha(TachoGUI_Label[2],0.75)
guiLabelSetColor(TachoGUI_Label[2],0,255,0)
guiLabelSetVerticalAlign(TachoGUI_Label[2],"center")
guiLabelSetHorizontalAlign(TachoGUI_Label[2],"center",false)
guiSetFont(TachoGUI_Label[2],"default-bold-small")
guiSetVisible(TachoGUI_Label[2], false)--]]


local MotorAmStarten = 0
local showrader = false
local hasPlayerLeftVeh = false
local lastVeh = nil

local vehicleKM = nil
local vehicleFuel = nil
local vehicleOil = nil
local vehicleWater = nil
local vehicleBattery = nil

local ownBlips = {}

function setVehicleFuelFromServer(fuel)
	vehicleFuel = fuel
end

function setVehicleBatteryFromServer(bat)
	vehicleBattery = bat
end

function setVehicleWaterFromServer(wat)
	vehicleWater = wat
end

function setVehicleOilFromServer(oil)
	vehicleOil = oil
end

function setVehicleEngineStateEx(vehicle, toggle)
	callServerFunction("setVehicleEngineState", vehicle, toggle)
end

function toggleMotor()
	if isPedInVehicle ( getLocalPlayer() ) and getElementModel(getPedOccupiedVehicle(getLocalPlayer())) ~= 441 and (getVehicleType (getPedOccupiedVehicle(getLocalPlayer())) == "Automobile" or getVehicleType (getPedOccupiedVehicle(getLocalPlayer())) == "Bike" or getVehicleType (getPedOccupiedVehicle(getLocalPlayer())) == "Quad") then
		if getVehicleOccupant ( getPedOccupiedVehicle(getLocalPlayer()), 0 ) == getLocalPlayer() then
			if getElementData(getPedOccupiedVehicle(getLocalPlayer()), "panne") == false then
				if getVehicleEngineState ( getPedOccupiedVehicle(getLocalPlayer()) ) then --(getElementData(getPedOccupiedVehicle(getLocalPlayer()), "panne") == false)
					setVehicleEngineStateEx ( getPedOccupiedVehicle(getLocalPlayer()), false )
					setElementData ( getPedOccupiedVehicle(getLocalPlayer()), "motor", false )
					disableTempomat()
				else
				
					if getElementData(getPedOccupiedVehicle(getLocalPlayer()), "vstatus") == true and getElementData(getPedOccupiedVehicle(getLocalPlayer()), "owner") == "Autohaus" and (getElementData(getLocalPlayer(), "job") ~= 1 or getElementData(getLocalPlayer(), "dienst") == 0) then return end
					if getElementData(getPedOccupiedVehicle(getLocalPlayer()), "vstatus") == true and getElementData(getPedOccupiedVehicle(getLocalPlayer()), "owner") == "5" and (getElementData(getLocalPlayer(), "job") ~= 5 or getElementData(getLocalPlayer(), "dienst") == 0) then return end
					
					if (MotorAmStarten == 0) and (getElementData(getPedOccupiedVehicle(getLocalPlayer()), "fuel") > 0) and (getElementData(getPedOccupiedVehicle(getLocalPlayer()), "battery") > 0)
					then
						MotorAmStarten = 1
						local sound = playSound("sounds/engine.mp3")
						setSoundVolume(sound, 0.5)
						setTimer ( setMotorStartStatus, 1000, 1, 2 )
						setTimer ( setMotorStartStatus, 1500, 1, 3 )
					end
				end
			end
		end
	end
end
bindKey ( "num_1", "down", toggleMotor )
bindKey ( "c", "down", toggleMotor )

function setMotorStartStatus(status)
	MotorAmStarten = status
end

function motorStartProzedur()
	if MotorAmStarten == 1 then
		for i = 9,16 do
			guiSetVisible(TachoGUI_Image[i], true)
		end
	elseif MotorAmStarten == 2 then
		for i = 11,14 do
			guiSetVisible(TachoGUI_Image[i], true)
		end
		guiSetVisible(TachoGUI_Image[16], true)
	elseif MotorAmStarten == 3 then
		MotorAmStarten = 0
		local veh = getPedOccupiedVehicle(getLocalPlayer())
			
		if getElementData(veh, "panne") == true then
			setVehicleEngineStateEx(veh, false)
			setElementData ( veh, "motor", false )
			showTutorialMessage("tacho_1", "Das Fahrzeug hat einen Motorschaden und kann nur mit einem Reparaturkit wieder in Gang gebracht werden. Wenn ein AutoFix Mitarbeiter online ist musst du ihn mit /adac rufen.")
		else
			setVehicleEngineStateEx ( veh, true )
			setElementData ( veh, "motor", true )
		end
	end
end

addEventHandler("onClientRender", getRootElement(),
	function()
		if not getElementData(getLocalPlayer(), "isPlayerLoggedIn") == true then return end
		local veh = getPedOccupiedVehicle(getLocalPlayer())
		if veh then
			if getElementData(veh, "onFire") == true then
				local health = getElementHealth ( getLocalPlayer() )
				setElementHealth (getLocalPlayer(), health-0.1 )
			end
		end
		if veh and getVehicleOccupant ( veh, 0 ) == getLocalPlayer() then 
			if (getVehicleType (veh) == "Automobile" or getVehicleType (veh) == "Bike" or getVehicleType (veh) ==  "Quad") and getElementModel(veh) ~= 441 then					
				hasPlayerLeftVeh = true
				lastVeh = veh
				--Anzeigen Aktivieren/Deaktivieren
				for i = 9,16 do
					guiSetVisible(TachoGUI_Image[i], false)
				end
				--for i = 1,2 do
				guiSetVisible(TachoGUI_Label[1], true)
				--end			
				--Tachohintergrund malen und Nadel anpassen
				local isLight = false
				if (MotorAmStarten == 1) or (getVehicleOverrideLights(veh) == 2) then
					needle = "needleLight.png"
					isLight = true
					if getElementData(veh, "fernlicht") == true then
						guiSetVisible(TachoGUI_Image[15], true)
					end
				else
					needle = "needle.png"
				end
				if getElementData(getLocalPlayer(), "hideTacho")  ~= true then
					dxDrawImage(screenWidth-460, screenHeight-191, 455, 191, "images/tacho/background.png", 0, 0, 0, white, false)
					if isLight == true then
						dxDrawImage(screenWidth-460, screenHeight-191, 455, 191, "images/tacho/backgroundLight.png", 0, 0, 0, white, false)
					end
				end
				
				local doorOpen = false
				for i = 2,5 do
					if getVehicleDoorState(veh, i) ~= 0 and getVehicleDoorState(veh, i) ~= 2 then
						doorOpen = true
					end					
				end
				if (doorOpen == true or MotorAmStarten == 1) and getVehicleEngineState (veh) == true and getElementData(veh, "motor") == true and getElementData(getLocalPlayer(), "hideTacho") ~= true then
					dxDrawImage(screenWidth-460, screenHeight-191, 455, 191, "images/tacho/doorOn.png", 0, 0, 0, white, false)
				end
				
				--if getVehicleType(veh) ~= "Automobile" then --IM MOMENT KOMPLETT DISABLED DA LAGS
					guiSetVisible(TachoGUI_Image[15], false)
				--end
				--Gang rausfinden und auf das Tacho zeichnen
				local gear = getVehicleCurrentGear(veh)
				local vx,vy,vz =  getElementVelocity ( veh )
				if tonumber(gear) == 0 and (vx ~= 0 or vy ~= 0 or vz ~= 0) then
					gear = "R"
					if gVehicleData[getElementModel(veh)] and gVehicleData[getElementModel(veh)].reverse == true then
						ReversGear()
					end
				else
					NormalGears()
				end
				--dxDrawText(tostring(gear),(screenWidth/2)+1, screenHeight-140, screenWidth, screenHeight, tocolor(0,125,0,255), 0.5, "bankgothic")
				--guiSetText ( TachoGUI_Label[2], tostring(gear))
				
				--Geschwindigkeit berechnen und dann die Tachonadel drehen
				local vx,vy,vz = getElementVelocity(veh)
				local speed = math.floor(  ((vx^2 + vy^2 + vz^2) ^ 0.7) * 50 * 3.6 )	
				if getElementData(getLocalPlayer(), "hideTacho") ~= true then
				--TODO FIIIX
					dxDrawImage(screenWidth-460+282, screenHeight-148, 128, 128, "images/tacho/"..needle, speed-25, 0, 0, tocolor(255,255,255,255), true)
				end				
				
				--Kilometer ausrechnen und auf das Tacho projezieren
				local currentx, currenty, currentz = getElementPosition( getLocalPlayer() )	
				local weite
				if lastx ~= 0 then
					weite = (( getDistanceBetweenPoints2D ( lastx, lasty, currentx, currenty ))/1000)
				else
					weite = 0
				end
				
				if vehicleKM == nil then
					vehicleKM = tonumber(getElementData(veh, "km"))
					if vehicleKM == nil then
						callServerFunction("removePedFromVehicle", getLocalPlayer())
						outputChatBox("Vehicle Error: Kilometeraten konnten nicht geladen werden!")
						vehicleKM = 0
					end
				end
						
				if vehicleFuel == nil then
					vehicleFuel = getElementData(veh, "fuel")
					if vehicleFuel == nil then
						callServerFunction("removePedFromVehicle", getLocalPlayer())
						outputChatBox("Vehicle Error: Daten konnten nicht geladen werden!")
						vehicleFuel = 100
					end					
				end
						
				if vehicleOil == nil then
					vehicleOil = getElementData(veh, "oil")
					if vehicleOil == nil then
						callServerFunction("removePedFromVehicle", getLocalPlayer())
						outputChatBox("Vehicle Error: Öldaten konnten nicht geladen werden!")
						vehicleOil = 100
					end					
				end		
						
				if vehicleWater == nil then
					vehicleWater = getElementData(veh, "water")
					if vehicleWater == nil then
						callServerFunction("removePedFromVehicle", getLocalPlayer())
						outputChatBox("Vehicle Error: Wasserdaten konnten nicht geladen werden!")
						vehicleWater = 100
					end					
				end
					
				if vehicleBattery == nil then
					vehicleBattery = getElementData(veh, "battery")
					if vehicleBattery == nil then
						callServerFunction("removePedFromVehicle", getLocalPlayer())
						outputChatBox("Vehicle Error: Batteriedaten konnten nicht geladen werden!")
						vehicleBattery = 100
					end					
				end
						
				vehicleKM = tonumber(vehicleKM)+weite
				lastx, lasty, lastz = getElementPosition( getLocalPlayer() )
				
				
				--Benzinnadel setzen
				if getVehicleEngineState (veh) == true then
					if not getElementData( veh, "doNotLooseFuel") == true then					
						vehicleFuel = vehicleFuel-weite*0.65
						vehicleOil = vehicleOil-weite*2*0.1
						vehicleWater = vehicleWater-weite*2*0.075
						vehicleBattery = vehicleBattery-weite*2*0.05
					end	
					if vehicleBattery <= 0 then
						vehicleBattery = 0
						setElementData ( veh, "battery", 0 )
					end
				end	
	

				local kilometerstring = tostring(math.round(tonumber(vehicleKM),0,"round"))
				guiSetText ( TachoGUI_Label[1], kilometerstring.." KM" )	
				
				
				motorStartProzedur()
				 
				if getVehicleEngineState (veh) == true and getElementData(veh, "motor") == true then
					if getElementData(veh,"handbremse") == true then
						guiSetVisible(TachoGUI_Image[11], true)
					else
						guiSetVisible(TachoGUI_Image[11], false)
					end
					
					if getElementData(veh,"i:leftimg") == true then
						guiSetVisible(TachoGUI_Image[9], true)
					else
						guiSetVisible(TachoGUI_Image[9], false)
					end
					
					if getElementData(veh,"i:rightimg") == true then
						guiSetVisible(TachoGUI_Image[10], true)
					else
						guiSetVisible(TachoGUI_Image[10], false)
					end			
					
					--Benzinueberpruefung
					if vehicleFuel <= 0 then
						vehicleFuel = 0
						setElementData ( veh, "fuel", 0)
						setVehicleEngineStateEx ( veh, false )
						setElementData ( veh, "motor", false )
						showTutorialMessage("tacho_2", "Das Fahrzeug hat kein Benzin mehr. Du musst dich entweder vom AutoFix mit /adac zur nächsten Tankstelle schleppen lassen oder einen Tankkanister verwenden.")
					else
						if getElementData(getLocalPlayer(), "hideTacho")  ~= true then
							if 	vehicleFuel <= 20 then
								dxDrawImage(screenWidth-460, screenHeight-214, 455, 191, "images/tacho/20.png", 0, 0, 0, white, false)
								guiSetVisible(TachoGUI_Image[13], true)
							elseif vehicleFuel <= 40 then
								dxDrawImage(screenWidth-460, screenHeight-214, 455, 191, "images/tacho/20.png", 0, 0, 0, white, false)
								dxDrawImage(screenWidth-460, screenHeight-214, 455, 191, "images/tacho/40.png", 0, 0, 0, white, false)
							elseif vehicleFuel <= 60 then
								dxDrawImage(screenWidth-460, screenHeight-214, 455, 191, "images/tacho/20.png", 0, 0, 0, white, false)
								dxDrawImage(screenWidth-460, screenHeight-214, 455, 191, "images/tacho/40.png", 0, 0, 0, white, false)		
								dxDrawImage(screenWidth-460, screenHeight-214, 455, 191, "images/tacho/60.png", 0, 0, 0, white, false)	
							elseif vehicleFuel <= 80 then
								dxDrawImage(screenWidth-460, screenHeight-214, 455, 191, "images/tacho/20.png", 0, 0, 0, white, false)
								dxDrawImage(screenWidth-460, screenHeight-214, 455, 191, "images/tacho/40.png", 0, 0, 0, white, false)
								dxDrawImage(screenWidth-460, screenHeight-214, 455, 191, "images/tacho/60.png", 0, 0, 0, white, false)
								dxDrawImage(screenWidth-460, screenHeight-214, 455, 191, "images/tacho/80.png", 0, 0, 0, white, false)
							elseif vehicleFuel <= 100 then
								dxDrawImage(screenWidth-460, screenHeight-214, 455, 191, "images/tacho/20.png", 0, 0, 0, white, false)
								dxDrawImage(screenWidth-460, screenHeight-214, 455, 191, "images/tacho/40.png", 0, 0, 0, white, false)
								dxDrawImage(screenWidth-460, screenHeight-214, 455, 191, "images/tacho/60.png", 0, 0, 0, white, false)
								dxDrawImage(screenWidth-460, screenHeight-214, 455, 191, "images/tacho/80.png", 0, 0, 0, white, false)
								dxDrawImage(screenWidth-460, screenHeight-214, 455, 191, "images/tacho/100.png", 0, 0, 0, white, false)
							end
						end
					end
				
					--oelueberpruefung
					if vehicleOil <= 0 then
						vehicleOil = 0
						setElementData ( veh, "oil", 0)
						setVehicleEngineStateEx ( veh, false )
						setElementData ( veh, "motor", false )
						setElementData ( veh, "panne", true )
					else
						if getElementData(getLocalPlayer(), "hideTacho")  ~= true then
							if vehicleOil <= 5 then
								guiSetVisible(TachoGUI_Image[14], true)
								dxDrawImage(screenWidth-460, screenHeight-191, 455, 191, "images/tacho/20.png", 0, 0, 0, white, false)
							elseif 	vehicleOil <= 20 then
								dxDrawImage(screenWidth-460, screenHeight-191, 455, 191, "images/tacho/20.png", 0, 0, 0, white, false)
							elseif vehicleOil <= 40 then
								dxDrawImage(screenWidth-460, screenHeight-191, 455, 191, "images/tacho/20.png", 0, 0, 0, white, false)
								dxDrawImage(screenWidth-460, screenHeight-191, 455, 191, "images/tacho/40.png", 0, 0, 0, white, false)
							elseif vehicleOil <= 60 then
								dxDrawImage(screenWidth-460, screenHeight-191, 455, 191, "images/tacho/20.png", 0, 0, 0, white, false)
								dxDrawImage(screenWidth-460, screenHeight-191, 455, 191, "images/tacho/40.png", 0, 0, 0, white, false)		
								dxDrawImage(screenWidth-460, screenHeight-191, 455, 191, "images/tacho/60.png", 0, 0, 0, white, false)	
							elseif vehicleOil <= 80 then
								dxDrawImage(screenWidth-460, screenHeight-191, 455, 191, "images/tacho/20.png", 0, 0, 0, white, false)
								dxDrawImage(screenWidth-460, screenHeight-191, 455, 191, "images/tacho/40.png", 0, 0, 0, white, false)
								dxDrawImage(screenWidth-460, screenHeight-191, 455, 191, "images/tacho/60.png", 0, 0, 0, white, false)
								dxDrawImage(screenWidth-460, screenHeight-191, 455, 191, "images/tacho/80.png", 0, 0, 0, white, false)
							elseif vehicleOil <= 100 then
								dxDrawImage(screenWidth-460, screenHeight-191, 455, 191, "images/tacho/20.png", 0, 0, 0, white, false)
								dxDrawImage(screenWidth-460, screenHeight-191, 455, 191, "images/tacho/40.png", 0, 0, 0, white, false)
								dxDrawImage(screenWidth-460, screenHeight-191, 455, 191, "images/tacho/60.png", 0, 0, 0, white, false)
								dxDrawImage(screenWidth-460, screenHeight-191, 455, 191, "images/tacho/80.png", 0, 0, 0, white, false)
								dxDrawImage(screenWidth-460, screenHeight-191, 455, 191, "images/tacho/100.png", 0, 0, 0, white, false)
							end
						end
					end

					--Wasserueberpruefung
					if vehicleWater <= 5 then
						vehicleWater = 0
						setElementData ( veh, "water", 0)
						setVehicleEngineStateEx ( veh, false )
						setElementData ( veh, "motor", false )
						setElementData ( veh, "panne", true )
					else
						if getElementData(getLocalPlayer(), "hideTacho")  ~= true then
							if 	vehicleWater <= 20 then
								dxDrawImage(screenWidth-460, screenHeight-168, 455, 191, "images/tacho/20.png", 0, 0, 0, white, false)
								guiSetVisible(TachoGUI_Image[16], true)
							elseif vehicleWater <= 40 then
								dxDrawImage(screenWidth-460, screenHeight-168, 455, 191, "images/tacho/20.png", 0, 0, 0, white, false)
								dxDrawImage(screenWidth-460, screenHeight-168, 455, 191, "images/tacho/40.png", 0, 0, 0, white, false)
							elseif vehicleWater <= 60 then
								dxDrawImage(screenWidth-460, screenHeight-168, 455, 191, "images/tacho/20.png", 0, 0, 0, white, false)
								dxDrawImage(screenWidth-460, screenHeight-168, 455, 191, "images/tacho/40.png", 0, 0, 0, white, false)		
								dxDrawImage(screenWidth-460, screenHeight-168, 455, 191, "images/tacho/60.png", 0, 0, 0, white, false)	
							elseif vehicleWater <= 80 then
								dxDrawImage(screenWidth-460, screenHeight-168, 455, 191, "images/tacho/20.png", 0, 0, 0, white, false)
								dxDrawImage(screenWidth-460, screenHeight-168, 455, 191, "images/tacho/40.png", 0, 0, 0, white, false)
								dxDrawImage(screenWidth-460, screenHeight-168, 455, 191, "images/tacho/60.png", 0, 0, 0, white, false)
								dxDrawImage(screenWidth-460, screenHeight-168, 455, 191, "images/tacho/80.png", 0, 0, 0, white, false)
							elseif vehicleWater <= 100 then
								dxDrawImage(screenWidth-460, screenHeight-168, 455, 191, "images/tacho/20.png", 0, 0, 0, white, false)
								dxDrawImage(screenWidth-460, screenHeight-168, 455, 191, "images/tacho/40.png", 0, 0, 0, white, false)
								dxDrawImage(screenWidth-460, screenHeight-168, 455, 191, "images/tacho/60.png", 0, 0, 0, white, false)
								dxDrawImage(screenWidth-460, screenHeight-168, 455, 191, "images/tacho/80.png", 0, 0, 0, white, false)
								dxDrawImage(screenWidth-460, screenHeight-168, 455, 191, "images/tacho/100.png", 0, 0, 0, white, false)
							end
						end
					end
				 end
				 
				--Wenn Motor aus ist, Blinker deleten
				if getElementData(veh, "motor") == false then
					if INDICATOR_TYPE ~= 'both' then 
						setElementData( veh, "i:left", false )
						setElementData( veh, "i:right", false )
					end	
					callServerFunction("setVehicleOverrideLights", veh, 1)
				end
				
				if getElementData(getLocalPlayer(), "hideTacho") == true then
					for i = 9,16 do
						guiSetVisible(TachoGUI_Image[i], false)
					end
					--for i = 1,2 do
					guiSetVisible(TachoGUI_Label[1], false)
					--end
				end
			end
		elseif veh then 
			if ((getElementData(getLocalPlayer(), "job") == 3)) and getElementData(getLocalPlayer(), "dienst") == 1 then
				local speedx, speedy, speedz = getElementVelocity(veh)
				local speed = math.floor(  ((speedx^2 + speedy^2 + speedz^2) ^ 0.7) * 50 * 3.2 )	
				if getElementData(getLocalPlayer(), "hideTacho") ~= true then
					dxDrawText("~FAHRSCHULE~\n"..tostring(speed).."KM/H\nLeertaste zum Bremsen",0, screenHeight-50-1, screenWidth, screenHeight, tocolor(0,0,0,255), 0.5, "bankgothic", "center")	
					dxDrawText("~FAHRSCHULE~\n"..tostring(speed).."KM/H\nLeertaste zum Bremsen",0, screenHeight-50+1, screenWidth, screenHeight, tocolor(0,0,0,255), 0.5, "bankgothic", "center")	
					dxDrawText("~FAHRSCHULE~\n"..tostring(speed).."KM/H\nLeertaste zum Bremsen",1, screenHeight-50, screenWidth, screenHeight, tocolor(0,0,0,255), 0.5, "bankgothic", "center")	
					dxDrawText("~FAHRSCHULE~\n"..tostring(speed).."KM/H\nLeertaste zum Bremsen",-1, screenHeight-50, screenWidth, screenHeight, tocolor(0,0,0,255), 0.5, "bankgothic", "center")	
					dxDrawText("~FAHRSCHULE~\n"..tostring(speed).."KM/H\nLeertaste zum Bremsen",0, screenHeight-50, screenWidth, screenHeight, tocolor(255,255,255,255), 0.5, "bankgothic", "center")
				end
			end
			if vehicleKM == nil and veh and isElement(veh) then
				vehicleKM = tonumber(getElementData(veh, "km"))
				if vehicleKM == nil or vehicleKM == false then
					vehicleKM = 0
					outputChatBox("Kilometer Daten fehlerhaft: bitte Administrator melden!")
				end
			end
		else
			if hasPlayerLeftVeh == true and vehicleKM ~= nil and vehicleFuel ~= nil and vehicleOil ~= nil and vehicleWater ~= nil and vehicleBattery ~= nil and vehicleKM ~= false and vehicleFuel ~= false and vehicleOil ~= false and vehicleWater ~= false and vehicleBattery ~= false then		
				setElementData ( lastVeh, "km", vehicleKM )
				setElementData ( lastVeh, "fuel", vehicleFuel )
				setElementData ( lastVeh, "oil", vehicleOil )
				setElementData ( lastVeh, "water", vehicleWater )
				setElementData ( lastVeh, "battery", vehicleBattery )
				
				vehicleKM = nil
				vehicleFuel = nil
				vehicleOil = nil
				vehicleWater = nil
				vehicleBattery = nil			
				
				lastVeh = nil
				hasPlayerLeftVeh = false
			end
			if showradar == true then
				showPlayerHudComponent ( "radar", false )
				setElementData( getLocalPlayer(), "isRadarVisible", false)
				showradar = false
			end	
			for i = 9,16 do
				guiSetVisible(TachoGUI_Image[i], false)
			end
			--for i = 1,2 do
			guiSetVisible(TachoGUI_Label[1], false)
			--end
			lastx, lasty, lastz = 0
		end
	end
)

addEventHandler("onClientVehicleEnter", getRootElement(),
    function(thePlayer, seat)
        if thePlayer == getLocalPlayer() then
		
			if hasItem(4) == true then
				showPlayerHudComponent ( "radar", true )
				setElementData( getLocalPlayer(), "isRadarVisible", true)
				showradar = true
			end
			
			if istAmTanken == true then
				StarteTankvorgang(getPedOccupiedVehicle(getLocalPlayer()))
			end
			if seat == 0 then
				showTutorialMessage("tacho_3", "Fahrzeuge haben auf 'The Vita Village' einige Zusatzfunktionen, die es auf anderen Servern oder im Singleplayer nicht gibt. Drücke 'num_1' oder 'c' um den Motor zu starten/stoppen.\nDas Licht kannst du mit 'num_8' betätigen.")
				showTutorialMessage("tacho_4", "Mit den Tasten 'num_4, num_5 und num_6' kannst du die Fahrzeugblinker bedienen. Mit 'n' kannst du den Tempomat festlegen.\nAchtung: Die Handbremse rastet automatisch ein und muss wieder manuell gelöst werden!")
				showTutorialMessage("tacho_5", "Um das Fahrzeug von innen abzusperren drücke 'num_3'. Um einen Anhänger abzuhängen musst du 'num_7' verwenden.\nDu kannst die Keybinds jederzeit in der Hilfe auf 'F1' nachlesen.")

				if (getElementData(source,"handbremse") == true) then
					setControlState ( "handbrake", false )
					setControlState ( "handbrake", true )
				else
					setControlState ( "handbrake", false )
				end
				if (getElementData(source, "motor") == false) then
					if( getVehicleType (source) == "Automobile" or getVehicleType (source) == "Bike" or getVehicleType (source) == "Quad") and getElementModel(source) ~= 441 then
						setVehicleEngineStateEx ( getPedOccupiedVehicle(getLocalPlayer()), false )
					else
						setVehicleEngineStateEx ( getPedOccupiedVehicle(getLocalPlayer()), true )
					end
				end
				
				
				if getElementData(source, "panne") == true then
					setVehicleEngineStateEx ( source, false )
					setElementData ( source, "motor", false )
					showTutorialMessage("tacho_1", "Das Fahrzeug hat einen Motorschaden und kann nur mit einem Reparaturkit wieder in Gang gebracht werden. Wenn ein AutoFix Mitarbeiter online ist musst du ihn mit /adac rufen.")
				else
					if getElementData(source, "motor") == true then
						setVehicleEngineStateEx ( source, true )
						setElementData ( source, "motor", true )
					end
				end
				
				if getElementData(source, "vstatus") == false and getElementData(source, "owner") == "Autohaus" and (getElementData(thePlayer, "job") ~= 1 or getElementData(getLocalPlayer(), "dienst") == 0) then
					makePlayerExitVehicle()
					addNotification(1, 255, 0, 0, "Dieses Fahrzeug steht noch nicht zum Verkauf!")
				elseif getElementData(source, "vstatus") == true and getElementData(source, "owner") == "Autohaus"  then
					if tonumber(getElementData(getLocalPlayer(), "job")) == 1 and getElementData(getLocalPlayer(), "dienst") == 1 then
						--if tonumber(getElementData(getLocalPlayer(), "dienst")) == 0 then
							--showAutokaufMenu()
						--end
					else
						if getElementData(source, "reserviert") ~= "Niemand" and getElementData(source, "reserviert") ~= getPlayerName(getLocalPlayer()) then
							makePlayerExitVehicle()
							addNotification(1, 255, 0, 0, "Dieses Fahrzeug ist für jemanden reserviert!")						
						else					
							showAutokaufMenu()
						end
					end
				elseif getElementData(source, "isWangVehicle") == true then
					showAutokaufMenu()
				end
				
				if getElementData(source, "owner") ~= "Autohaus" and getVehicleType(source) ~= "BMX" then
					if getElementData(source, "tuev") + 14 < getRealTime().yearday then
						addNotification(1, 255, 0, 0, "Die TÜV Plakette dieses Fahrzeuges ist abgelaufen.")
					elseif getElementData(source, "tuev") -100 > getRealTime().yearday then
						setElementData(source, "tuev", 0)
						addNotification(2, 0, 255, 0, "Die Staatsverwaltung wünscht ein frohes "..(getRealTime().year+1900)..":\nZum neuen Jahr wurde deine TÜV Plakette bis zum 14. Januar verlängert.")
					end
				end
				
				if getElementData(source, "vstatus") == false and getElementData(source, "owner") == "5" and (getElementData(thePlayer, "job") ~= 5 or getElementData(getLocalPlayer(), "dienst") == 0) then
					makePlayerExitVehicle()
					addNotification(1, 255, 0, 0, "Dieses Fahrzeug steht noch nicht zum Verkauf!")
				elseif getElementData(source, "vstatus") == true and (getElementData(source, "owner") == "5" or getElementData(source, "owner") == "11") then
					if tonumber(getElementData(getLocalPlayer(), "job")) == 5 and getElementData(getLocalPlayer(), "dienst") == 1 and getElementData(source, "owner") == "5" then
						--NIX
					elseif tonumber(getElementData(getLocalPlayer(), "job")) == 11 and getElementData(getLocalPlayer(), "dienst") == 1 and getElementData(source, "owner") == "11" then
						--NIX
					else
						if getElementData(source, "reserviert") ~= "Niemand" and getElementData(source, "reserviert") ~= getPlayerName(getLocalPlayer()) then
							makePlayerExitVehicle()
							addNotification(1, 255, 0, 0, "Dieses Fahrzeug ist für jemanden reserviert!")						
						else
							showGWkaufMenu()
						end
					end
				end
				
				if isVehicleLocked ( source ) == true then
					addNotification(1, 255, 0, 0, "Dieses Fahrzeug ist abgeschlossen!")
					makePlayerExitVehicle()
				end
		
			end
        end		
    end
)

function handbrakeFunc()
	if isPedInVehicle ( getLocalPlayer() ) then
		if (getVehicleType (getPedOccupiedVehicle(getLocalPlayer())) == "Automobile" or getVehicleType (getPedOccupiedVehicle(getLocalPlayer())) == "Bike" or getVehicleType (getPedOccupiedVehicle(getLocalPlayer())) == "Quad") and getElementModel(getPedOccupiedVehicle(getLocalPlayer())) ~= 441 then
			if getVehicleOccupant ( getPedOccupiedVehicle(getLocalPlayer()), 0 ) == getLocalPlayer() then 
				if getElementData(getPedOccupiedVehicle(getLocalPlayer()),"handbremse") == false then
					toggleControl ( "handbrake", false )
					playSound("sounds/handbrakeOn.mp3")
					setControlState ( "handbrake", true )
					setElementData ( getPedOccupiedVehicle(getLocalPlayer()), "handbremse",true )
				else
					setControlState ( "handbrake", false )
					setElementData ( getPedOccupiedVehicle(getLocalPlayer()), "handbremse",false )
				end
			else
				if ((getElementData(getLocalPlayer(), "job") == 3)) and getElementData(getLocalPlayer(), "dienst") == 1 then
					local ply = getVehicleOccupant ( getPedOccupiedVehicle(getLocalPlayer()), 0 )
					if ply then
						if getElementData(getPedOccupiedVehicle(getLocalPlayer()),"handbremse") == false then
							callServerFunction("setControlState", ply, "handbrake", false)
							callServerFunction("callClientFunction", ply, "playSound", "sounds/handbrakeOn.mp3")
							playSound("sounds/handbrakeOn.mp3")
							callServerFunction("setControlState", ply, "handbrake", true)
							setElementData ( getPedOccupiedVehicle(getLocalPlayer()), "handbremse",true )
						else
							callServerFunction("setControlState", ply, "handbrake", false)
							setElementData ( getPedOccupiedVehicle(getLocalPlayer()), "handbremse",false )
						end
					end
				end
			end
		end
	end	
end
bindKey ( "space", "down", handbrakeFunc )  


function ReversGear()
	if getPedOccupiedVehicle(getLocalPlayer()) then
		setElementData(getPedOccupiedVehicle(getLocalPlayer()), "reverse", true)
	end
end

function NormalGears()
	if getPedOccupiedVehicle(getLocalPlayer()) then
		setElementData(getPedOccupiedVehicle(getLocalPlayer()), "reverse", false)
	end
end

function onClientPlayerVehicleExit()
NormalGears()
end
addEventHandler("onClientPlayerVehicleExit",getRootElement(),onClientPlayerVehicleExit)

function saveVehicleStuff()
	local veh = getPedOccupiedVehicle(getLocalPlayer())
	if veh and getVehicleOccupant ( veh, 0 ) == getLocalPlayer() then
		if vehicleKM ~= nil and vehicleFuel ~= nil and vehicleOil ~= nil and vehicleWater ~= nil and vehicleBattery ~= nil and vehicleKM ~= false and vehicleFuel ~= false and vehicleOil ~= false and vehicleWater ~= false and vehicleBattery ~= false then
			setElementData ( veh, "km", vehicleKM )
			setElementData ( veh, "fuel", vehicleFuel )
			setElementData ( veh, "oil", vehicleOil )
			setElementData ( veh, "water", vehicleWater )
			setElementData ( veh, "battery", vehicleBattery )
		end
	end
end
setTimer ( saveVehicleStuff, 5000, 0 )

local lplayer = getLocalPlayer()	-- Local Player
local ltarget = nil					-- Target Speed
local lvehicle = nil				-- Current Vehicle

function enableTempomat()
	lvehicle = getPedOccupiedVehicle(lplayer)
	if lvehicle and lplayer == getVehicleOccupant(lvehicle) and getVehicleEngineState ( lvehicle )  then -- we're in a vehicle & we're the driver and its on
		if ltarget then -- tempomat is still active
			disableTempomat()
		end
		ltarget = math.floor(getElementSpeed(lvehicle))
		if ltarget < 4.0 then
			ltarget = nil
			return
		end
		addEventHandler("onClientPreRender", getRootElement(), tempomatCall)
	end
end
function disableTempomat()
	setControlState("accelerate", false)
	removeEventHandler("onClientPreRender", getRootElement(), tempomatCall)
	ltarget = nil
end

function tempomatCall()
	if not isElement(lvehicle) then -- vehicle destroyed / gone
		disableTempomat()
		return
	end
	if getControlState("brake_reverse") and getControlState("accelerate") then setControlState("accelerate", false) end
	if getControlState("brake_reverse") then return end
	local curspeed = getElementSpeed(lvehicle)
	if curspeed+0.1 < ltarget then -- too slow
		setControlState("accelerate", true)
	elseif curspeed-0.1 > ltarget then
		setControlState("accelerate", false)
	end
	
	
end

bindKey("n", "down", function()
	if ltarget then
		disableTempomat()
	else
		enableTempomat()
	end
end)

addEventHandler("onClientPlayerVehicleExit", lplayer, disableTempomat)
bindKey("handbrake", "down", disableTempomat)
--bindKey("brake_reverse", "down", disableTempomat)

function createRadarMarker ( commandName, number )									--Commandfunktionzum createn von eigenen Blips
	local xmlRoot = xmlLoadFile("settings.xml")
	if xmlRoot == false then 
		xmlRoot = xmlCreateFile("settings.xml", "settings")
	end

	local x, y, z = getElementPosition ( getLocalPlayer() )
	if tonumber(number) == 1 then													--gleicher algorythmus wird 3 mal verwendet
		if ownBlips[1] then
			destroyElement(ownBlips[1])
		end
		ownBlips[1] = createBlip ( x, y, z, 0, 2, 255, 0, 0, 255 )
			
		curnode = xmlFindChild(xmlRoot, "Marker1", 0)
		if curnode == false then													--Abspeichern in Settings.xml
			curnode = xmlCreateChild(xmlRoot, "Marker1")
		end
		xmlNodeSetValue(curnode, "true")
		xmlNodeSetAttribute ( curnode, "X", x )
		xmlNodeSetAttribute ( curnode, "Y", y )
		xmlNodeSetAttribute ( curnode, "Z", z )
	elseif tonumber(number) == 2 then
		if ownBlips[2] then
			destroyElement(ownBlips[2])
		end
		ownBlips[2] = createBlip ( x, y, z, 0, 2, 0, 255, 0, 255 )
		
		curnode = xmlFindChild(xmlRoot, "Marker2", 0)
		if curnode == false then
			curnode = xmlCreateChild(xmlRoot, "Marker2")
		end
		xmlNodeSetValue(curnode, "true")
		xmlNodeSetAttribute ( curnode, "X", x )
		xmlNodeSetAttribute ( curnode, "Y", y )
		xmlNodeSetAttribute ( curnode, "Z", z )
	elseif tonumber(number) == 3 then
		if ownBlips[3] then
			destroyElement(ownBlips[3])
		end
		ownBlips[3] = createBlip ( x, y, z, 0, 2, 0, 0, 255, 255 )
			
		curnode = xmlFindChild(xmlRoot, "Marker3", 0)
		if curnode == false then
			curnode = xmlCreateChild(xmlRoot, "Marker3")
		end
		xmlNodeSetValue(curnode, "true")
		xmlNodeSetAttribute ( curnode, "X", x )
		xmlNodeSetAttribute ( curnode, "Y", y )
		xmlNodeSetAttribute ( curnode, "Z", z )
	else outputChatBox("ERROR: Usage /createMarker ([number1-3])", 255, 0, 0)
	end
	
	xmlSaveFile(xmlRoot)
	xmlUnloadFile(xmlRoot)
end
addCommandHandler("createMarker", createRadarMarker)

function deleteMarker ( commandName, number )											--um den eigenen Blip zu löschen
	local xmlRoot = xmlLoadFile("settings.xml")
	if xmlRoot == false then 
		xmlRoot = xmlCreateFile("settings.xml", "settings")
	end
	
	if tonumber(number) == 1 then
		curnode = xmlFindChild(xmlRoot, "Marker1", 0)
		if curnode == false then
			curnode = xmlCreateChild(xmlRoot, "Marker1"..number)
		end
		xmlNodeSetValue(curnode, "false")
		destroyElement(ownBlips[tonumber(number)])
		
	elseif tonumber(number) == 2 then
		curnode = xmlFindChild(xmlRoot, "Marker2", 0)
		if curnode == false then
			curnode = xmlCreateChild(xmlRoot, "Marker2"..number)
		end
		xmlNodeSetValue(curnode, "false")
		destroyElement(ownBlips[tonumber(number)])
		
	elseif tonumber(number) == 3 then
		curnode = xmlFindChild(xmlRoot, "Marker3", 0)
		if curnode == false then
			curnode = xmlCreateChild(xmlRoot, "Marker3"..number)
		end
		xmlNodeSetValue(curnode, "false")
		destroyElement(ownBlips[tonumber(number)])
	
	
	else outputChatBox("ERROR: Usage /deleteMarker ([number1-3])", 255, 0, 0)
	end
	xmlSaveFile(xmlRoot)
	xmlUnloadFile(xmlRoot)
end
addCommandHandler("deleteMarker", deleteMarker)

function loadRadarMarker ()																--wird bei spawnen geladen
	local xmlRoot = xmlLoadFile("settings.xml")
	if xmlRoot == false then 
		xmlRoot = xmlCreateFile("settings.xml", "settings")
	end
	
	curnode = xmlFindChild(xmlRoot, "Marker1", 0)
	if curnode == false then
		curnode = xmlCreateChild(xmlRoot, "Marker1")
	end
	if xmlNodeGetValue(curnode) == "true" then
		local x = xmlNodeGetAttribute ( curnode, "X" )
		outputChatBox(x)
		local y = xmlNodeGetAttribute ( curnode, "Y" )
		outputChatBox(y)
		local z = xmlNodeGetAttribute ( curnode, "Z" )
		outputChatBox(z)
		ownBlips[1] = createBlip ( tonumber(x), tonumber(y), tonumber(z), 0, 2, 255, 0, 0, 255 )
		outputChatBox(tostring(ownBlips[1]))
	end
	
		curnode = xmlFindChild(xmlRoot, "Marker2", 0)
	if curnode == false then
		curnode = xmlCreateChild(xmlRoot, "Marker2")
	end
	if xmlNodeGetValue(curnode) == "true" then
		local x = xmlNodeGetAttribute ( curnode, "X" )
		local y = xmlNodeGetAttribute ( curnode, "Y" )
		local z = xmlNodeGetAttribute ( curnode, "Z" )
		ownBlips[2] = createBlip ( tonumber(x), tonumber(y), tonumber(z), 0, 2, 0, 255, 0, 255 )
	end
	
		curnode = xmlFindChild(xmlRoot, "Marker3", 0)
	if curnode == false then
		curnode = xmlCreateChild(xmlRoot, "Marker3")
	end
	if xmlNodeGetValue(curnode) == "true" then
		local x = xmlNodeGetAttribute ( curnode, "X" )
		local y = xmlNodeGetAttribute ( curnode, "Y" )
		local z = xmlNodeGetAttribute ( curnode, "Z" )
		ownBlips[3] = createBlip ( tonumber(x), tonumber(y), tonumber(z), 0, 2, 0, 0, 255, 255 )
	end
	
	xmlUnloadFile(xmlRoot)
end

-- Wiki -> Useful Functions
function getElementSpeed(element)
	if (isElement(element)) then
		local x,y,z = getElementVelocity(element)
		return (x^2 + y^2 + z^2) ^ 0.5 * 1.61 * 100
	end
end