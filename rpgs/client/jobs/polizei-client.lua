	--[[
Project: VitaOnline
File: polizei-client.lua
Author(s):	Sebihunter
]]--

local obj = createObject( 8331, 2354, 540.7001953125, 9.1999998092651, 0, 0, 110.74768066406)
setObjectScale( obj, 0.2 )
setElementDoubleSided ( obj, true )
setElementCollisionsEnabled ( obj, false )
replaceTexture(obj, "bobo_3", "images/wasserwacht.jpg")

obj = createObject( 8331, 2354.1005859375, 522.2001953125, 2.5, 0, 0, 290.99487304688)
setObjectScale( obj, 0.3 )
setElementDoubleSided ( obj, true )
setElementCollisionsEnabled ( obj, false )
replaceTexture(obj, "bobo_3", "images/wasserwacht.jpg")


tor1pad1 = createObject ( 2886, 2337.5466308594, 2447.3022460938, 6.7444658279419, 0, 0, 60)
tor1pad2 = createObject ( 2886, 2332.3127441406, 2440.2041015625, 6.2499747276306, 0, 0, 240)
tor2pad1 = createObject ( 2886, 2294.625, 2494.6691894531, 3.5414898395538, 0, 0, 90)
tor2pad2 = createObject ( 2886, 2293.7839355469, 2494.6730957031, 3.5414898395538, 0, 0, 270)
setElementData(tor1pad1, "cinfo", {"Tor Öffnen/Schließen"})
setElementData(tor1pad2, "cinfo", {"Tor Öffnen/Schließen"})
setElementData(tor2pad1, "cinfo", {"Tor Öffnen/Schließen"})
setElementData(tor2pad2, "cinfo", {"Tor Öffnen/Schließen"})

function onPoliceElementClick ( button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement )
	if clickedElement then
		if getElementType ( clickedElement ) == "object" then
			local playerx, playery,playerz = getElementPosition ( getLocalPlayer( ))
			local hitedx,hittedy,hittedz = getElementPosition(clickedElement)
			if getDistanceBetweenPoints3D(hitedx,hittedy,hittedz, playerx, playery,playerz) < 8 then
				if ( ((clickedElement == tor1pad1) or (clickedElement == tor1pad2)) and (state == "down")  ) then
					triggerServerEvent("movePolizeiTor", getLocalPlayer(),2,getLocalPlayer())
				elseif ( ((clickedElement == tor2pad1) or (clickedElement == tor2pad2)) and (state == "down")  ) then
					triggerServerEvent("movePolizeiTor", getLocalPlayer(),3,getLocalPlayer())	
				end				
			end
		end
	end
end
addEventHandler ( "onClientClick", getRootElement(), onPoliceElementClick)


addEventHandler("onClientPlayerDamage", getLocalPlayer(), 
	function(hitElement, weapon, bodypart, loss)
		if not isElement(hitElement) then return end
		if getElementType(hitElement) ~= "player" then return end
		if not weapon then return end
		if weapon ~= 24 then return end
		if getElementData(hitElement, "pTaserMode") ~= true or getElementData(hitElement, "job") ~= 3 then return end
		triggerServerEvent("onPlayerTasered", hitElement, getLocalPlayer())
		showTutorialMessage("taser_1", "Der Spieler wurde getasert und kann sich für einige Sekunden nicht bewegen.")
		cancelEvent()
	end
)

local isInTeleport = false
local police_marker1 = createMarker( 206.5,180.5, 1004, "arrow", 2.0, 255, 255, 255, 255, getRootElement())
setElementInterior(police_marker1, 3)
local police_marker2 = createMarker(2268.2421875, 2448.3046875, 4.53125, "arrow", 2.0, 255, 255, 255, 255, getRootElement())

function policeTeleport1 ( hitElement, matchingDimension )
	if hitElement ~= getLocalPlayer() then return false end
	if isPedInVehicle ( hitElement ) then return false end
	if isInTeleport == false then
		if getElementData(hitElement, "job") == 3 then
			isInTeleport = true
			callServerFunction( "setElementInterior", getLocalPlayer(), 0, 2268.2421875, 2448.3046875, 3.53125)
			setTimer ( function () isInTeleport = false end, 3000, 1 )
		end
	end
end

function policeTeleport2 ( hitElement, matchingDimension )
	if hitElement ~= getLocalPlayer() then return false end
	if isPedInVehicle ( hitElement ) then return false end
	if isInTeleport == false then
		isInTeleport = true
		callServerFunction( "setElementInterior", getLocalPlayer(), 3,  206.5,180.5, 1004)
		setTimer ( function () isInTeleport = false end, 3000, 1 )
	end
end

addEventHandler("onClientMarkerHit", police_marker1, policeTeleport1 )
addEventHandler("onClientMarkerHit", police_marker2, policeTeleport2 )