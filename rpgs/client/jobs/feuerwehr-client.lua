--[[
Project: VitaOnline
File: feuerwehr-client.lua
Author(s):	Sebihunter
]]--
			
local zip = createObject(3335, 2617.900390625, 1190.7998046875, 3.7000000476837,0, 0, 270,true)
setObjectScale(zip, 4)
setElementCollisionsEnabled(zip, false)
replaceTexture(zip, "sw_roadsign", "images/fw.jpg")
		

--[[local zip = createObject( 4731, 2617.6000976563, 1184.9000244141, 11.699999809265, 0, 0, 300.25)
setElementCollisionsEnabled(zip, false)
setObjectScale(zip, 0.5)
replaceTexture(zip, "diderSachs01", "images/fw.jpg")]]

	
addEventHandler("onClientPlayerWeaponFire", root,
     function(weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement)
		if source == getLocalPlayer() and weapon == 42 and getElementData(getLocalPlayer(), "job") == 7 then
			if hitElement and isElement(hitElement) and getElementData(hitElement, "onFire") == true then
				if not getElementData(hitElement, "fireHealth") then setElementData(hitElement, "fireHealth", 1000) end
				if getElementData(hitElement, "fireHealth") - 5 >= 1 then
					setElementData(hitElement, "fireHealth",  getElementData(hitElement, "fireHealth")-5)
				else
					setElementData(hitElement, "fireHealth", nil)
					setElementData(hitElement, "onFire", false)
				end
			end
		end
     end
)
	
function fireTreeLoss(loss, attacker)
	if attacker ~= getLocalPlayer() then return end
	if getPedWeapon ( attacker ) == 9 and getElementType(source)== "object" and getElementData(source, "isTree") == true and getElementData(attacker, "job") == 7 then 
		local health = getElementData(source, "health")
		local rand = math.random(1,10)
		if health - rand >= 0 then
			setElementData(source, "health", health-rand)
		else
			setElementData(source, "health", 0)
		end
	end
end
addEventHandler("onClientObjectDamage", getRootElement(), fireTreeLoss)

local carFires = {}
setTimer(function()
	fireEffects = {}
	for i,v in ipairs(getElementsByType("vehicle"), getRootElement(), true) do
		local x,y,z = getElementPosition(v)
		if getElementData(v, "onFire") == true then
			if not carFires[v] then
				local flame = createEffect("fire_car", x,y,z,500)
				carFires[v] = flame
				attachEffect( flame, v, Vector3(0, 0, 0))
			end
		else
			if carFires[v] then
				destroyElement(carFires[v])
				carFires[v] = nil
			end
		end
	end
	for i,v in ipairs(getElementsByType("fireJob")) do
		if not getElementData(v, "fPos") then
			local fireEffects = {}
			local x,y,z = getElementPosition(v)
			fireEffects[#fireEffects+1] = createEffect ( "fire_large", x,y,z, 500 )
			fireEffects[#fireEffects+1] = createEffect ( "fire_large", x+2,y+2,z+1,0,0,0, 500 )
			fireEffects[#fireEffects+1] = createEffect ( "fire_large", x-2,y+2,z+1,0,0,0, 500 )
			fireEffects[#fireEffects+1] = createEffect ( "fire_large", x+2,y-2,z+1,0,0,0, 500 )
			fireEffects[#fireEffects+1] = createEffect ( "fire_large", x+2,y-2,z+1,0,0,0, 500 )
			fireEffects[#fireEffects+1] = createEffect ( "fire_large", x-2,y-2,z+1,0,0,0, 500 )
			fireEffects[#fireEffects+1] = createEffect ( "fire_large", x+2,y+2,z-1,0,0,0, 500 )
			fireEffects[#fireEffects+1] = createEffect ( "fire_large", x-2,y+2,z-1,0,0,0, 500 )
			fireEffects[#fireEffects+1] = createEffect ( "fire_large", x+2,y-2,z-1,0,0,0, 500 )
			fireEffects[#fireEffects+1] = createEffect ( "fire_large", x+2,y-2,z-1,0,0,0, 500 )
			fireEffects[#fireEffects+1] = createEffect ( "fire_large", x-2,y-2,z-1,0,0,0, 500 )	
			setElementData(v, "fPos", fireEffects, false)
		end
		if not getElementData(v, "fPeds") then
			local x,y,z = getElementPosition(v)
			local firePeds = {}
			firePeds[#firePeds+1] = createPed(0, x,y,z)
			firePeds[#firePeds+1] = createPed(0, x+2,y+2,z+1)
			firePeds[#firePeds+1] = createPed(0, x-2,y+2,z+1)
			firePeds[#firePeds+1] = createPed(0, x+2,y-2,z+1)
			firePeds[#firePeds+1] = createPed(0, x+2,y-2,z+1)
			firePeds[#firePeds+1] = createPed(0, x-2,y-2,z+1)
			firePeds[#firePeds+1] = createPed(0, x+2,y+2,z-1)
			firePeds[#firePeds+1] = createPed(0, x-2,y+2,z-1)
			firePeds[#firePeds+1] = createPed(0, x+2,y-2,z-1)
			firePeds[#firePeds+1] = createPed(0, x+2,y-2,z-1)
			firePeds[#firePeds+1] = createPed(0, x-2,y-2,z-1)				
			for i,ped in pairs(firePeds) do
				setElementAlpha(ped, 0)
				setElementFrozen(ped, true)
				setElementData(ped, "fFire", v, false)
			end
			setElementData(v, "fPeds", firePeds, false)
		end
	end
end, 1000, 0)

addEventHandler("onClientElementDestroy", getRootElement(), function ()
	v = source
	if getElementType(v) == "fireJob" then
		local peds = getElementData(v, "fPeds")
		local pos = getElementData(v, "fPos")
		if peds then
			for i,v2 in pairs(peds) do
				destroyElement(v2)
			end
		end
		if pos then
			for i,v2 in pairs(pos) do
				destroyElement(v2)
			end
		end		
	end
end)

function fireLoss(ped)
	if getVehicleOccupant(source) == getLocalPlayer() then
		local fire = getElementData(ped, "fFire")
		if fire and isElement(fire) then
			local health = getElementData(fire, "health")
			local rand = math.random(1,10)
			if health - rand >= 0 then
				setElementData(fire, "health", health-rand)
			else
				setElementData(fire, "health", 0)
			end		
		end
	end
end
addEventHandler("onClientPedHitByWaterCannon", getRootElement(), fireLoss)
