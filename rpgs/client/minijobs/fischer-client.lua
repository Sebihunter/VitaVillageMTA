--[[
Project: VitaOnline
File: fischer-client.lua
Author(s):	Golf_R32
			Sebihunter
]]--

local tourVehicle = false
local cooldown = false


local theMissiFischerMarker = {}
function starttheFischermarker()
	theMissiFischerMarkerMain = createMarker(-1686.5439453125, 1451.197265625, -0.34640163183212, "cylinder", 5, 245,158,9, 255)
					
    theMissiFischerMarker[1] = createMarker(-1587.2761230469, 1612.5944824219, 0, "checkpoint", 10, 245,158,9, 0)
    theMissiFischerMarker[2] = createMarker(-1286.3483886719, 1472.4879150391, 0, "checkpoint", 10, 245,158,9, 0)
    theMissiFischerMarker[3] = createMarker(-1217.1864013672, 984.06463623047, 0, "checkpoint", 10, 245,158,9, 0)
    theMissiFischerMarker[4] = createMarker(-1422.9135742188, 1157.8354492188, 0, "checkpoint", 10, 245,158,9, 0)
    theMissiFischerMarker[5] = createMarker(-1278.3187255859, 801.39245605469, 0, "checkpoint", 10, 245,158,9, 0)
    theMissiFischerMarker[6] = createMarker(-1001.3262939453, 797.20697021484, 0, "checkpoint", 10, 245,158,9, 0)
    theMissiFischerMarker[7] = createMarker(-1115.03515625, 701.140625, 0, "checkpoint", 10, 245,158,9, 0)
    theMissiFischerMarker[8] = createMarker(-1148.3835449219, 470.44064331055, 0, "checkpoint", 10, 245,158,9, 0)
    theMissiFischerMarker[9] = createMarker(-892.72381591797, 530.1328125, 0, "checkpoint", 10, 245,158,9, 0)
    theMissiFischerMarker[10] = createMarker(-677.67651367188, 489.87966918945, 0, "checkpoint", 10, 245,158,9, 0)
    theMissiFischerMarker[11] = createMarker(-1073.26171875, 161.7254486084, 0, "checkpoint", 10, 245,158,9, 0)
    theMissiFischerMarker[12] = createMarker(-1809.0780029297, 1752.9664306641, 0, "checkpoint", 10, 245,158,9, 0)
    theMissiFischerMarker[13] = createMarker(-2449.1669921875, 1474.4860839844, 0, "checkpoint", 10, 245,158,9, 0)
    theMissiFischerMarker[14] = createMarker(-1904.6411132813, 2109.8564453125, 0, "checkpoint", 10, 245,158,9, 0)
    theMissiFischerMarker[15] = createMarker(-2469.5495605469, 1850.9063720703, 0, "checkpoint", 10, 245,158,9, 0)
    theMissiFischerMarker[16] = createMarker( -2040.4636230469, 1705.9348144531, 0, "checkpoint", 10, 245,158,9, 0)
		for i = 1,#theMissiFischerMarker do
			if isElement(theMissiFischerMarker[i]) then
				setElementDimension(theMissiFischerMarker[i], 1234)
			end
		end
		addEventHandler("onClientMarkerHit", theMissiFischerMarkerMain,startminimissionFischer)
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), starttheFischermarker)

local theminiFischermissiontext = ""
local neuesgeldblub = 0
local erreichteziele = 0
function startmissifisch ()
	local x,y = guiGetScreenSize()

	dxDrawText(theminiFischermissiontext, 5,0,x,y*0.25,tocolor(0,0,0,255), 1.4, "bankgothic", "center", "center",true,true,true)
	dxDrawText(theminiFischermissiontext, 0,5,x,y*0.25,tocolor(0,0,0,255), 1.4, "bankgothic", "center", "center",true,true,true)
	dxDrawText(theminiFischermissiontext, 0,-5,x,y*0.25,tocolor(0,0,0,255), 1.4, "bankgothic", "center", "center",true,true,true)
	dxDrawText(theminiFischermissiontext, -5,0,x,y*0.25,tocolor(0,0,0,255), 1.4, "bankgothic", "center", "center",true,true,true)

	dxDrawText(theminiFischermissiontext, 5,5,x,y*0.25,tocolor(0,0,0,255), 1.4, "bankgothic", "center", "center",true,true,true)
	dxDrawText(theminiFischermissiontext, -5,5,x,y*0.25,tocolor(0,0,0,255), 1.4, "bankgothic", "center", "center",true,true,true)
	dxDrawText(theminiFischermissiontext, 5,-5,x,y*0.25,tocolor(0,0,0,255), 1.4, "bankgothic", "center", "center",true,true,true)
	dxDrawText(theminiFischermissiontext, -5,-5,x,y*0.25,tocolor(0,0,0,255), 1.4, "bankgothic", "center", "center",true,true,true)

	dxDrawText(theminiFischermissiontext, 0,0,x,y*0.25,tocolor(255,100,0,255), 1.4, "bankgothic", "center", "center",true,true,true)
end
setElementData(getLocalPlayer(), "isMiniMissionActivatedFischer", false)
function startminimissionFischer(player)
	if getLocalPlayer() == player then
		veh = getPedOccupiedVehicle(player)
		if not veh then addNotification(1, 255, 0, 0, "Du kannst den Minijob nur in einem 'Reefer' beginnen.") return end
		if veh then
			if cooldown == true then return end
			if getElementData(getLocalPlayer(), "dienst") == 1 then addNotification(1, 255, 0, 0, "Du kannst keinen Nebenjob beginnen\nwenn du im Dienst bist.") return end
			if getVehicleOccupant(veh) == getLocalPlayer() then
				if getVehicleName(veh) ==  "Reefer" then
				if getElementData(getLocalPlayer(), "isMiniMissionActivatedFischerFischer") ~= true then
					if getElementData(getLocalPlayer(), "isMiniMissionActivatedFischer") == false then
							if killermission and isTimer(killermission) then killTimer(killermission) end
							if isTimer(theverdienstgeldtimer) then killTimer(theverdienstgeldtimer) end
							addEventHandler("onClientRender", getRootElement(), startmissifisch)
							theminiFischermissiontext = "Tour wurde gestartet!"
							showTutorialMessage("fischer_1", "Fahre zu den Checkpoints im Meer um Fische einzuladen.")
							tourVehicle = veh
							neuesgeldblub = 0
							setElementData(getLocalPlayer(), "isMiniMissionActivatedFischer", true)
							showPlayerHudComponent ( "radar", true )
							thebishergestartedtimer = setTimer(
														function()
															theminiFischermissiontext = "Bisher gefangene Fische: "..neuesgeldblub
														end
														,3000,1)
							damarkerdenduhittenmsusst = math.random(1,#theMissiFischerMarker)
							setMarkerColor(theMissiFischerMarker[damarkerdenduhittenmsusst], 95, 255, 0,100)
							setElementDimension(theMissiFischerMarker[damarkerdenduhittenmsusst], 0)
							theFischermissionblip = createBlip(getElementPosition(theMissiFischerMarker[damarkerdenduhittenmsusst]))
							addEventHandler("onClientMarkerHit", theMissiFischerMarker[damarkerdenduhittenmsusst], markerhitofitititiFischer)
						elseif getElementData(getLocalPlayer(), "isMiniMissionActivatedFischer") == "neuensuchen" then
							if isTimer(theverdienstgeldtimer) then killTimer(theverdienstgeldtimer) end
							setElementData(getLocalPlayer(), "isMiniMissionActivatedFischer", true)
							damarkerdenduhittenmsusst = math.random(1,#theMissiFischerMarker)
							setMarkerColor(theMissiFischerMarker[damarkerdenduhittenmsusst], 95, 255, 0,100)
							setElementDimension(theMissiFischerMarker[damarkerdenduhittenmsusst], 0)
							theFischermissionblip = createBlip(getElementPosition(theMissiFischerMarker[damarkerdenduhittenmsusst]))
							addEventHandler("onClientMarkerHit", theMissiFischerMarker[damarkerdenduhittenmsusst], markerhitofitititiFischer)
						else
							if isTimer(thebishergestartedtimer) then killTimer(thebishergestartedtimer) end
								setElementData(getLocalPlayer(), "isMiniMissionActivatedFischer", false)
								theminiFischermissiontext = "Tour wurde abgebrochen!"
								if killermission and isTimer(killermission) then killTimer(killermission) end
								destroyElement(theFischermissionblip)
								setMarkerColor(theMissiFischerMarker[damarkerdenduhittenmsusst], 95, 255, 0,0)
								setElementDimension(theMissiFischerMarker[damarkerdenduhittenmsusst], 1234)
								removeEventHandler("onClientMarkerHit", theMissiFischerMarker[damarkerdenduhittenmsusst], markerhitofitititiFischer)
								cooldown = true
								setTimer(function() cooldown = false end, 15000, 1)
								theverdienstgeldtimer = setTimer(
								function()
									neuesgeldblub = math.floor(neuesgeldblub)
									theminiFischermissiontext = "Du hast "..neuesgeldblub.. " Vero verdient!"
									triggerServerEvent("giveTheMiniMissionPrize", getLocalPlayer(),getLocalPlayer(), neuesgeldblub)
									erreichteziele = 0
									showPlayerHudComponent ( "radar", false )
									theverdienstgeldtimer = setTimer(function() theminiFischermissiontext = ""  neuesgeldblub = 0 removeEventHandler("onClientRender", getRootElement(), startmissifisch) end , 2000,1)
								end
								,3000,1)
			
					end
					end
								else
				theminiFischermissiontext = "Du brauchst einen 'Reefer' um diese Tour zu starten!"
				if isTimer(theshitcarisfalschtimer) then
					killTimer(theshitcarisfalschtimer)
				end
				theshitcarisfalschtimer = setTimer(
				function()
					theminiFischermissiontext = ""
					end
				,3000,1)
				end
			end
		end
	end
end



function leftthemarkerofthemissiFischer(source)
	if source == getLocalPlayer() then
		if isTimer(theidletimerstart) then
			killTimer(theidletimerstart)
			theminiFischermissiontext = "Fangen unterbrochen! Bitte wiederholen!"
			removeEventHandler("onClientMarkerLeave", theMissiFischerMarker[damarkerdenduhittenmsusst],leftthemarkerofthemissiFischer)
		end
	end
end
function markerhitofitititiFischer(player)
	if player == getLocalPlayer() then
		veh = getPedOccupiedVehicle(player)
		if veh then
			if getVehicleName(veh) ==  "Reefer" then
				theminiFischermissiontext = "Fische werden gefangen!"
				theidletimerstart = setTimer(acceptthedurinFischer, 3000,1, player)
				addEventHandler("onClientMarkerLeave", theMissiFischerMarker[damarkerdenduhittenmsusst], leftthemarkerofthemissiFischer)
			end
		end
	end
end
function acceptthedurinFischer(source)
	destroyElement(theFischermissionblip)
	setMarkerColor(theMissiFischerMarker[damarkerdenduhittenmsusst], 95, 255, 0,0)
	setElementDimension(theMissiFischerMarker[damarkerdenduhittenmsusst], 1234)
	removeEventHandler("onClientMarkerHit", theMissiFischerMarker[damarkerdenduhittenmsusst], markerhitofitititiFischer)
	erreichteziele = erreichteziele+1
	local theveh = getElementHealth(veh)
	neuesgeldblub = neuesgeldblub+(10*math.random(0,60))
	theminiFischermissiontext = "Bisher gefangene Fische: "..neuesgeldblub
	setElementData(getLocalPlayer(), "isMiniMissionActivatedFischer", "neuensuchen")
	showTutorialMessage("fischer_2", "Du kannst nun an einem weiteren Checkpoint fischen oder deine Ware beim Hafen abgeben.")
	startminimissionFischer(getLocalPlayer())	
end


addEventHandler("onClientVehicleExit", getRootElement(),
	function(thePlayer,seat)
		if thePlayer == getLocalPlayer() and seat == 0 and getElementData(getLocalPlayer(), "isMiniMissionActivatedFischer") == true then
			if source == tourVehicle then
				timemissi = 30
				theminiFischermissiontext = "Tour wird beendet in 30 Sekunden"
				killermission = setTimer(function()
				timemissi = timemissi-1
				theminiFischermissiontext = "Tour wird beendet in "..timemissi.." Sekunden"
				if timemissi == 0 then
					killTimer(killermission)
					theminiFischermissiontext = "Tour fehlgeschlagen!"
					setTimer(function()
							removeEventHandler("onClientRender", getRootElement(), startmissifisch)
							theminiFischermissiontext = ""
							timemissi = 30
							erreichteziele = 0
							neuesgeldblub = 0
							destroyElement(theFischermissionblip)
							setMarkerColor(theMissiFischerMarker[damarkerdenduhittenmsusst], 95, 255, 0,0)
							setElementDimension(theMissiFischerMarker[damarkerdenduhittenmsusst], 1234)
							removeEventHandler("onClientMarkerHit", theMissiFischerMarker[damarkerdenduhittenmsusst], markerhitofitititiFischer)
							setElementData(getLocalPlayer(), "isMiniMissionActivatedFischer", false)
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
		if theplayer == getLocalPlayer() and seat == 0 and getElementData(getLocalPlayer(), "isMiniMissionActivatedFischer") == true then
			if source == tourVehicle then
				if isTimer(killermission) then
					killTimer(killermission)
					theminiFischermissiontext = "Tour wird fortgefahren!"
					setTimer(
							function()
								theminiFischermissiontext = "Bisher gefangene Fische: "..neuesgeldblub
							end
						,3000,1)
				end
			end
		end
	end
)
addEventHandler("onClientPlayerWasted", getLocalPlayer(),
	function()
		if getElementData(getLocalPlayer(), "isMiniMissionActivatedFischer") == true then
			theminiFischermissiontext = "Tour fehlgeschlagen!"
			setTimer(
				function()
					removeEventHandler("onClientRender", getRootElement(), startmissifisch)
					theminiFischermissiontext = ""
					timemissi = 30
					erreichteziele = 0
					neuesgeldblub = 0
					destroyElement(theFischermissionblip)
					setMarkerColor(theMissiFischerMarker[damarkerdenduhittenmsusst], 95, 255, 0,0)
					removeEventHandler("onClientMarkerHit", theMissiFischerMarker[damarkerdenduhittenmsusst], markerhitofitititiFischer)
					setElementData(getLocalPlayer(), "isMiniMissionActivatedFischer", false)
					showPlayerHudComponent ( "radar", false )
				end 
			,3500,1)
		end
	end
)




