local lauftimers = {}
local runAnim = {}
local blockFromEislauf = {}

--[[
THIS SCRIPT IS CURRENTLY DISABLED
]]

--local runCol = createColRectangle ( 2372.29,2312.422, 33, 21.0)

function laufen (thePlayer)
	if getElementType(thePlayer) ~= "player" then return end
	if getPedOccupiedVehicle(thePlayer) then return end
	if blockFromEislauf[thePlayer] then return end
	if lauftimers[thePlayer] and isTimer(lauftimers[thePlayer]) then return end
	local x, y, z = getElementPosition (thePlayer)
	local spawn = createRPGVehicle (441, x, y, z, 0, "EISLAUF", {{255,255,255},{255,255,255},{255,255,255},{255,255,255}}, true, false)
	local skin1 = getElementModel (thePlayer)
	local ped = createPed (skin1, x, y, z)
	local x2, y2, z2 = getElementPosition (ped)
	attachElementToElement (ped, spawn, 0, 0, 0.85)
	warpPlayerIntoVehicle (thePlayer, spawn)
	setElementData (spawn, "engine", true) 
	setVehicleEngineState (spawn, true)
	setElementAlpha (thePlayer, 0)
	setElementAlpha (spawn, 0)
	blockFromEislauf[thePlayer] = true
	
	local v = spawn
	setVehicleHandling ( v,"suspensionLowerLimit",-0.1)
	setVehicleHandling ( v,"engineInertia",10)
	setVehicleHandling ( v,"suspensionHighSpeedDamping",0)
	setVehicleHandling ( v,"centerOfMassY",0.2)
	setVehicleHandling ( v,"collisionDamageMultiplier",0)
	setVehicleHandling ( v,"suspensionDamping",0.15)
	setVehicleHandling ( v,"seatOffsetDistance",0.25)
	setVehicleHandling ( v,"headLight",0)
	setVehicleHandling ( v,"dragCoeff",2.2)
	setVehicleHandling ( v,"steeringLock",70)
	setVehicleHandling ( v,"suspensionUpperLimit",0.28)
	setVehicleHandling ( v,"suspensionAntiDiveMultiplier",0)
	setVehicleHandling ( v,"turnMass",850)
	setVehicleHandling ( v,"brakeBias",0.5)
	setVehicleHandling ( v,"tractionLoss",0.25)
	setVehicleHandling ( v,"monetary",500)
	setVehicleHandling ( v,"ABS",false)
	setVehicleHandling ( v,"suspensionFrontRearBias",0.5)
	setVehicleHandling ( v,"percentSubmerged",75)
	setVehicleHandling ( v,"tractionBias",0.5)
	setVehicleHandling ( v,"centerOfMassZ",-0.1)
	setVehicleHandling ( v,"centerOfMassX",0)
	setVehicleHandling ( v,"numberOfGears",5)
	setVehicleHandling ( v,"suspensionForceLevel",1.4)
	setVehicleHandling ( v,"animGroup",0)
	setVehicleHandling ( v,"engineAcceleration",15)
	setVehicleHandling ( v,"maxVelocity",25)
	setVehicleHandling ( v,"mass",2000)
	setVehicleHandling ( v,"driveType",4)
	setVehicleHandling ( v,"modelFlags",2804)
	setVehicleHandling ( v,"brakeDeceleration",5)
	setVehicleHandling ( v,"handlingFlags",4008803)
	setVehicleHandling ( v,"tractionMultiplier",0.4)
	setVehicleHandling ( v,"engineType","p")
	setVehicleHandling ( v,"tailLight",1)
	
	setElementData(thePlayer, "eislaufveh", spawn)
	setElementData(thePlayer, "eislaufped", ped)
	triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 0,255,0, "Zum beendes des Eislaufens drücke 'F'." )
	lauftimers[thePlayer] = setTimer(f_lauftimer, 100,0, thePlayer, spawn, ped)
	callClientFunction(thePlayer, "toggleEislaufClient", true)
end
--addEventHandler ( "onColShapeHit", runCol, laufen )

function f_lauftimer(ply, veh, ped)
	if not getPedOccupiedVehicle(ply) then warpPlayerIntoVehicle ( ply, veh ) end
	local vx, vy, vz = getElementVelocity ( veh )
	local speed = math.floor(  ((vx^2 + vy^2 + vz^2) ^ 0.7) * 50 * 3.6 )
	if speed ~= 0 and runAnim[ply] ~= true then
		runAnim[ply] = true
		setPedAnimation(ped, "skate", "skate_idle", -1, true, false, false, false)
	elseif speed == 0 then
		setPedAnimation(ped, false)
		runAnim[ply] = false
	end
	local _,_,rz = getElementRotation(veh)
	setPedRotation(ped, rz)
end

function onExit (ply)
	local veh = source
	local source = ply
	if lauftimers[source] and isTimer(lauftimers[source]) then
		setElementAlpha (source, 255)
		destroyElement (veh)
		local x,y,z = getElementPosition(getElementData(source, "eislaufped"))
		local rz = getPedRotation(getElementData(source, "eislaufped"))
		destroyElement (getElementData(source, "eislaufped"))	
		killTimer(lauftimers[source])
		lauftimers[source] = false
		runAnim[source] = false
		removePedFromVehicle ( source )
		setElementFrozen(source, true)
		setElementPosition(source, 2366.431,2309.5744,14.95906)
		setPedRotation(source,0)
		--setTimer(function(source)
		--setElementPosition(source, 2366.431,2309.5744,14.95906) setPedRotation(source,0) blockFromEislauf[source] = nil end, 100, 1, source)
		setElementData(source, "eislaufveh", false)
		setElementData(source, "eislaufped", false)
		callClientFunction(source, "toggleEislaufClient", false)
		setTimer(function(source)
			if isElement(source) then
				setElementPosition(source, 2366.431,2309.5744,14.95906)
				setPedRotation(source,0)
				setElementFrozen(source, false)
			end
			blockFromEislauf[source] = nil
		end, 1000, 1, source)
		--blockFromEislauf[source] = nil
	end
end
addEventHandler ("onVehicleStartExit", root, onExit)
addEvent("fakeEislaufQuit")
addEventHandler("fakeEislaufQuit", root, onExit)

function quitEislauf()
	if lauftimers[source] and isTimer(lauftimers[source]) then
		triggerEvent("fakeEislaufQuit", getElementData(source, "eislaufveh"), souce)
	end
end
addEventHandler ( "onPlayerQuit", getRootElement(), quitEislauf )