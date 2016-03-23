--[[
Project: VitaOnline
File: mower-client.lua
Author(s):	Golf_R32
			Sebihunter
]]--

local tourVehicle = false
local cooldown = false

local theMissiMowerMarker = {}
function starttheMowermarker()
	theMissiMowerMarkerMain = createMarker(1420.322265625, 2797.498046875, 9.392489433289, "cylinder", 1, 245,158,9, 255)
    theMissiMowerMarker[1] = createMarker(1398.8017578125, 2769.1787109375, 9.386212348938, "cylinder", 2, 245,158,9, 0)
    theMissiMowerMarker[2] = createMarker(1338.7216796875, 2747.5732421875, 9.33093547821, "cylinder", 2, 245,158,9, 0)
    theMissiMowerMarker[3] = createMarker(1297.333984375, 2782.126953125, 9.386290550232, "cylinder", 2, 245,158,9, 0)
    theMissiMowerMarker[4] = createMarker(1291.572265625, 2836.1005859375, 9.385961532593, "cylinder", 2, 245,158,9, 0)
    theMissiMowerMarker[5] = createMarker(1252.7412109375, 2850.9091796875,9.386207580566, "cylinder", 2, 245,158,9, 0)
    theMissiMowerMarker[6] = createMarker(1218.423828125, 2800.5244140625, 9.386260032654, "cylinder", 2, 245,158,9, 0)
    theMissiMowerMarker[7] = createMarker(1176.34375, 2748.05859375, 9.398736000061, "cylinder", 2, 245,158,9, 0)
    theMissiMowerMarker[8] = createMarker(1131.6240234375, 2745.8974609375, 9.386170387268, "cylinder", 2, 245,158,9, 0)
    theMissiMowerMarker[9] = createMarker(1139.8349609375, 2790.939453125, 9.386262893677, "cylinder", 2, 245,158,9, 0)
	theMissiMowerMarker[10] = createMarker(1118.8154296875, 2856.091796875, 9.386083602905, "cylinder", 2, 245,158,9, 0)
		for i = 1,#theMissiMowerMarker do
			if isElement(theMissiMowerMarker[i]) then
				setElementDimension(theMissiMowerMarker[i], 1234)
			end
		end
		addEventHandler("onClientMarkerHit", theMissiMowerMarkerMain,startminimission)
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), starttheMowermarker)

local theminiMowermissiontext = ""
local neuesgeldblub = 0
local erreichteziele = 0
function startmissi ()
	local x,y = guiGetScreenSize()

	dxDrawText(theminiMowermissiontext, 5,0,x,y*0.25,tocolor(0,0,0,255), 1.4, "bankgothic", "center", "center",true,true,true)
	dxDrawText(theminiMowermissiontext, 0,5,x,y*0.25,tocolor(0,0,0,255), 1.4, "bankgothic", "center", "center",true,true,true)
	dxDrawText(theminiMowermissiontext, 0,-5,x,y*0.25,tocolor(0,0,0,255), 1.4, "bankgothic", "center", "center",true,true,true)
	dxDrawText(theminiMowermissiontext, -5,0,x,y*0.25,tocolor(0,0,0,255), 1.4, "bankgothic", "center", "center",true,true,true)

	dxDrawText(theminiMowermissiontext, 5,5,x,y*0.25,tocolor(0,0,0,255), 1.4, "bankgothic", "center", "center",true,true,true)
	dxDrawText(theminiMowermissiontext, -5,5,x,y*0.25,tocolor(0,0,0,255), 1.4, "bankgothic", "center", "center",true,true,true)
	dxDrawText(theminiMowermissiontext, 5,-5,x,y*0.25,tocolor(0,0,0,255), 1.4, "bankgothic", "center", "center",true,true,true)
	dxDrawText(theminiMowermissiontext, -5,-5,x,y*0.25,tocolor(0,0,0,255), 1.4, "bankgothic", "center", "center",true,true,true)

	dxDrawText(theminiMowermissiontext, 0,0,x,y*0.25,tocolor(255,100,0,255), 1.4, "bankgothic", "center", "center",true,true,true)
end
setElementData(getLocalPlayer(), "isMiniMissionActivated", false)
exports.customblips:createCustomBlip(1420.322265625, 2797.498046875, 16, 16, "images/blips/rasenmaeherjob.png")
function startminimission(player)
	if getLocalPlayer() == player then
		veh = getPedOccupiedVehicle(player)
		if not veh then addNotification(1, 255, 0, 0, "Du kannst den Minijob nur in einem 'Mower' beginnen.") return end
		if cooldown == true then return end
		if getElementData(getLocalPlayer(), "dienst") == 1 then addNotification(1, 255, 0, 0, "Du kannst keinen Nebenjob beginnen\nwenn du im Dienst bist.") return end
		if veh then
			if getVehicleOccupant(veh) == getLocalPlayer() then
				if getVehicleName(veh) ==  "Mower" then
				if getElementData(getLocalPlayer(), "isMiniMissionActivatedMower") ~= true then
					if getElementData(getLocalPlayer(), "isMiniMissionActivated") == false then
							if killermission and isTimer(killermission) then killTimer(killermission) end
							if isTimer(theverdienstgeldtimer) then killTimer(theverdienstgeldtimer) end
							neuesgeldblub = 0
							addEventHandler("onClientRender", getRootElement(), startmissi)
							theminiMowermissiontext = "Mähvorgang wurde gestartet!"
							showTutorialMessage("mower_1", "Zum Mähen musst du den Checkpoint am Golfplatz erreichen. Du kannst den Job am Startpunkt jederzeit beenden.")
							tourVehicle = veh
							setElementData(getLocalPlayer(), "isMiniMissionActivated", true)
							showPlayerHudComponent ( "radar", true )
							thebishergestartedtimer = setTimer(
														function()
															theminiMowermissiontext = "Bisher erreichte Checkpoints: "..erreichteziele
														end
														,3000,1)
							damarkerdenduhittenmsusst = math.random(1,#theMissiMowerMarker)
							setMarkerColor(theMissiMowerMarker[damarkerdenduhittenmsusst], 95, 255, 0,100)
							setElementDimension(theMissiMowerMarker[damarkerdenduhittenmsusst], 0)
							theMowermissionblip = createBlip(getElementPosition(theMissiMowerMarker[damarkerdenduhittenmsusst]))
							addEventHandler("onClientMarkerHit", theMissiMowerMarker[damarkerdenduhittenmsusst], markerhitofitititi)
						elseif getElementData(getLocalPlayer(), "isMiniMissionActivated") == "neuensuchen" then
							if isTimer(theverdienstgeldtimer) then killTimer(theverdienstgeldtimer) end
							setElementData(getLocalPlayer(), "isMiniMissionActivated", true)
							damarkerdenduhittenmsusst = math.random(1,#theMissiMowerMarker)
							setMarkerColor(theMissiMowerMarker[damarkerdenduhittenmsusst], 95, 255, 0,100)
							setElementDimension(theMissiMowerMarker[damarkerdenduhittenmsusst], 0)
							theMowermissionblip = createBlip(getElementPosition(theMissiMowerMarker[damarkerdenduhittenmsusst]))
							addEventHandler("onClientMarkerHit", theMissiMowerMarker[damarkerdenduhittenmsusst], markerhitofitititi)
						else
							if isTimer(thebishergestartedtimer) then killTimer(thebishergestartedtimer) end
								setElementData(getLocalPlayer(), "isMiniMissionActivated", false)
								theminiMowermissiontext = "Mähvorgang wurde abgebrochen!"
								if killermission and isTimer(killermission) then killTimer(killermission) end
								destroyElement(theMowermissionblip)
								setMarkerColor(theMissiMowerMarker[damarkerdenduhittenmsusst], 95, 255, 0,0)
								setElementDimension(theMissiMowerMarker[damarkerdenduhittenmsusst], 1234)
								removeEventHandler("onClientMarkerHit", theMissiMowerMarker[damarkerdenduhittenmsusst], markerhitofitititi)
								cooldown = true
								setTimer(function() cooldown = false end, 15000, 1)
								theverdienstgeldtimer = setTimer(
								function()
									neuesgeldblub = math.floor(neuesgeldblub)
									theminiMowermissiontext = "Du hast "..neuesgeldblub.. " Vero verdient!"
									triggerServerEvent("giveTheMiniMissionPrize", getLocalPlayer(),getLocalPlayer(), neuesgeldblub)
									erreichteziele = 0
									showPlayerHudComponent ( "radar", false )
									theverdienstgeldtimer = setTimer(function() theminiMowermissiontext = ""  neuesgeldblub = 0 removeEventHandler("onClientRender", getRootElement(), startmissi)  end , 2000,1)
								end
								,3000,1)
			
					end
					end
								else
				theminiMowermissiontext = "Du brauchst einen 'Mower' um diesen Golfplatz zu mähen!"
				if isTimer(theshitcarisfalschtimer) then
					killTimer(theshitcarisfalschtimer)
				end
				theshitcarisfalschtimer = setTimer(
				function()
					theminiMowermissiontext = ""
					end
				,3000,1)
				end
			end
		end
	end
end

function markerhitofitititi(player)
	if player == getLocalPlayer() then
		veh = getPedOccupiedVehicle(player)
		if veh then
			if getVehicleName(veh) ==  "Mower" then
				acceptthedurin(player)
			end
		end
	end
end
function acceptthedurin(source)
	destroyElement(theMowermissionblip)
	setMarkerColor(theMissiMowerMarker[damarkerdenduhittenmsusst], 95, 255, 0,0)
	removeEventHandler("onClientMarkerHit", theMissiMowerMarker[damarkerdenduhittenmsusst], markerhitofitititi)
	erreichteziele = erreichteziele+1
	local theveh = getElementHealth(veh)
	neuesgeldblub = neuesgeldblub+((theveh/1000)*15)
	theminiMowermissiontext = "Bisher erreichte Checkpoints: "..erreichteziele
	setElementData(getLocalPlayer(), "isMiniMissionActivated", "neuensuchen")
	startminimission(getLocalPlayer())	
end


addEventHandler("onClientVehicleExit", getRootElement(),
	function(thePlayer,seat)
		if thePlayer == getLocalPlayer() and seat == 0 and getElementData(getLocalPlayer(), "isMiniMissionActivated") == true then
			if source == tourVehicle then
				timemissi = 30
				theminiMowermissiontext = "Mahen wird beendet in 30 Sekunden"
				killermission = setTimer(function()
				timemissi = timemissi-1
				theminiMowermissiontext = "Mähen wird beendet in "..timemissi.." Sekunden"
				if timemissi == 0 then
					killTimer(killermission)
					theminiMowermissiontext = "Mähen fehlgeschlagen!"
					setTimer(function()
							removeEventHandler("onClientRender", getRootElement(), startmissi)
							theminiMowermissiontext = ""
							timemissi = 30
							erreichteziele = 0
							neuesgeldblub = 0
							destroyElement(theMowermissionblip)
							setMarkerColor(theMissiMowerMarker[damarkerdenduhittenmsusst], 95, 255, 0,0)
							setElementDimension(theMissiMowerMarker[damarkerdenduhittenmsusst], 1234)
							removeEventHandler("onClientMarkerHit", theMissiMowerMarker[damarkerdenduhittenmsusst], markerhitofitititi)
							setElementData(getLocalPlayer(), "isMiniMissionActivated", false)
							showPlayerHudComponent ( "radar", false )
						end 
					,3500,1)
				end
			end
			,1000,0)
			end
		end
	end
)
addEventHandler("onClientVehicleEnter", getRootElement(),
	function(theplayer,seat)
		if theplayer == getLocalPlayer() and seat == 0 and getElementData(getLocalPlayer(), "isMiniMissionActivated") == true then
			if source == tourVehicle then
				if isTimer(killermission) then
					killTimer(killermission)
					theminiMowermissiontext = "Tour wird fortgefahren!"
					setTimer(
							function()
								theminiMowermissiontext = "Bisher erreichte Checkpoints: "..erreichteziele
							end
						,3000,1)
				end
			end
		end
	end
)
addEventHandler("onClientPlayerWasted", getLocalPlayer(),
	function()
		if getElementData(getLocalPlayer(), "isMiniMissionActivated") == true then
			theminiMowermissiontext = "Tour fehlgeschlagen!"
			setTimer(
				function()
					removeEventHandler("onClientRender", getRootElement(), startmissi)
					theminiMowermissiontext = ""
					timemissi = 30
					erreichteziele = 0
					neuesgeldblub = 0
					destroyElement(theMowermissionblip)
					setMarkerColor(theMissiMowerMarker[damarkerdenduhittenmsusst], 95, 255, 0,0)
					removeEventHandler("onClientMarkerHit", theMissiMowerMarker[damarkerdenduhittenmsusst], markerhitofitititi)
					setElementData(getLocalPlayer(), "isMiniMissionActivated", false)
					showPlayerHudComponent ( "radar", false )
				end 
			,3500,1)
		end
	end
)




