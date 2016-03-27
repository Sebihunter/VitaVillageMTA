--[[
Project: VitaRP
File: intro-client.lua
Author(s):	Nitaco
]]--

--[[ Funktion:
	Einführung wird gestartet und zudem der entsprechende Kinomodus, 
	Dazu werden serverseitig Peds usw. erstellt
]]--

addEvent("startIntro", true)
addEventHandler("startIntro", getRootElement(), 
	function()
		addEventHandler("onClientRender", getRootElement(), startCinemaMode)
	end)
	
addEvent("finishedIntro", true)
addEventHandler("finishedIntro", getRootElement(),
	function()
		removeEventHandler("onClientRender", getRootElement(), startCinemaMode)
	end)

function startCinemaMode()
	local sW, sH = guiGetScreenSize()
	if not sX and sY then return false end
	dxDrawRectangle (0, 0, sW, 170/1080*sH, tocolor(0, 0, 0, 255), false)
	dxDrawRectangle (0, 170/1080*sH, sW, 740/1080*sH, tocolor(127,127,127,83),false)
	dxDrawRectangle (0, 910/1080*sH, sW, 170/1080*sH, tocolor(0, 0, 0, 255),false)
end

local pedActors2 = {}	
addEvent("startStoryPart2", true)
addEventHandler("startStoryPart2", getRootElement(),
	function()
		local dimVar = 0
		thePlayer = lp
		
		pedActors2[thePlayer] = {}
		local dimVar = dimVar + 1
		triggerEvent("startIntro", thePlayer)
		fadeCamera(true, 3)
		setElementDimension(thePlayer, 0)
		setElementInterior(thePlayer, 3)
		setCameraMatrix(369.29998779297, 335.79998779297, 1019.700012207, 370.5, 338.89999389648, 1020.700012207)
		
		local sound = playSound("sounds/arzt.mp3", false)
		
		pedActors2[thePlayer]["doctorActorsPed"] = createPed(70, 370.39999389648, 338.89999389648, 1020, 148.501708)
		
		setElementInterior(pedActors2[thePlayer]["doctorActorsPed"], 3)
		setElementDimension(pedActors2[thePlayer]["doctorActorsPed"], 0)
		setPedAnimation(pedActors2[thePlayer]["doctorActorsPed"] , "ped", "factalk")
		
		setTimer(
			function(thePlayer)
				setPedRotation(pedActors2[thePlayer]["doctorActorsPed"], 270)
				setPedAnimation(pedActors2[thePlayer]["doctorActorsPed"] , "ped", "WALK_fatold")
				setTimer(
					function(thePlayer)
						destroyElement(pedActors2[thePlayer]["doctorActorsPed"])
						triggerEvent("finishedIntro", thePlayer)
						triggerEvent("openRegisterWindowAfterStory", thePlayer)
					end, 7500, 1, thePlayer)		
		end, 9000, 1, thePlayer)
end)