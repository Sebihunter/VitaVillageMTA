--[[
Project: VitaRP
File: into-server.lua
Author(s):	Nitaco
			Sebihunter
]]--

local pedActors = {}

dimVar = 0
addEvent("clientIsReady", true)
addEventHandler("clientIsReady", getRootElement(), 
	function(thePlayer)
		if not isElement(thePlayer) then return false end
		pedActors[thePlayer] = {}
		dimVar = dimVar + 1
		triggerClientEvent(thePlayer, "startIntro", getRootElement())
		
		fadeCamera(thePlayer, true)
		setElementDimension(thePlayer, dimVar)
		
		setCameraMatrix(thePlayer, 2776.1, -2483.5, 12.7, 2779.1, -2487.2, 13.7)

		pedActors[thePlayer]["mainActorPed"] = createPed(107, 2779.1000976563, -2487.1999511719, 13.699999809265, 36.7525634)
		setTimer(giveWeapon,1000,1,pedActors[thePlayer]["mainActorPed"],22,1,true)
		setElementDimension(pedActors[thePlayer]["mainActorPed"] , dimVar)
		setPedAnimation(pedActors[thePlayer]["mainActorPed"] , "ped", "factalk")
		setTimer(
			function(thePlayer)
				callClientFunction( thePlayer, "playSound", "sounds/neger.mp3" )
				setPedAnimation(pedActors[thePlayer]["mainActorPed"] , "ped", "gang_gunstand")
			end, 5000, 1,thePlayer)
		setTimer(
			function(thePlayer)
				destroyElement(pedActors[thePlayer]["mainActorPed"] )

				if not isElement(thePlayer) then return false end
				fadeCamera(thePlayer, false, 0)
				callClientFunction( thePlayer, "playSound", "sounds/shot.mp3" )
				triggerClientEvent(thePlayer, "finishedIntro", getRootElement())
			end, 9000, 1,thePlayer)
		setTimer(
			function(thePlayer)
				if not isElement(thePlayer) then return false end
				
				triggerClientEvent(thePlayer, "startVitaCredits", getRootElement())
			end, 13000, 1,thePlayer)
end)