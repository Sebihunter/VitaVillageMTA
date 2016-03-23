--[[
Project: VitaOnline
File: hafen-server.lua
Author(s):	Sebihunter
]]--

function getTrailerPos()
	local trailerVeh = 0
	for _, vehicle in ipairs(getElementsByType("vehicle")) do
		if getElementData(vehicle, "isVehicleTemp") == false then
			if getElementData(vehicle, "eingepackt") == true then
				trailerVeh = trailerVeh + 1
			end
		end
	end
	if trailerVeh <= 20 then
		return 2670.9548 + 4 * trailerVeh,- 2392.4934, 11.0+4;
	else
		print("VitaOnline: Hafen voll!")
		return 0.0, 0.0, 0.0;
	end
end

function unpackVehicle(ply, command)
	if getElementData(ply, "job") == 2 and getElementData(ply, "dienst") == 1 then -- LKW-Fahrer
		local trailer = getVehicleTowedByVehicle ( getPedOccupiedVehicle ( ply ) )
		if trailer then
			if getElementData( trailer, "eingepackt" ) == true then
				detachTrailerFromVehicle ( getPedOccupiedVehicle ( ply ) )
				setElementModel( trailer, tonumber(getElementData ( trailer, "model" )))
				local x, y, z = getElementPosition(trailer)
				local rx, ry, rz = getElementRotation(trailer)
				x = x+ 5.5 * math.sin(math.rad(rz + 180))
				y = y+ 5.5 * math.cos(math.rad(rz + 180))
				setElementPosition(trailer, x, y, z+2)
				setElementData ( trailer, "eingepackt", false )
				systemTransfer("Autohaus", "Trucker", 800)
				setElementData(ply, "einnahmen", getElementData(ply, "einnahmen")+800)
				setElementData(ply, "einnahmen2", getElementData(ply, "einnahmen2")+800)
				--setElementFrozen(trailer, true)
				setVehicleDamageProof ( trailer, true )
				detachTrailerFromVehicle ( getPedOccupiedVehicle ( ply ) )
				setTimer(function(trailer) setElementFrozen(trailer, true) end, 5000, 1, trailer )
			end
		end
	end
end
addCommandHandler("auspacken",unpackVehicle, false, false)

function detachVehicle(ply, command)
	detachTrailerFromVehicle ( getPedOccupiedVehicle ( ply ) )
end
addCommandHandler("abkuppeln",detachVehicle, false, false)

function truckerwho(source, commandName)
	if getElementData(source, "job") == 2 then
		local isAusliefern = 0
		for _,veh in pairs(getElementsByType("vehicle")) do
			if getElementModel(veh) == 591 and getElementData (veh, "owner") == "Autohaus" then
				isAusliefern = isAusliefern +1
			end
		end
		for i,v in ipairs(adac_repair) do
			if getElementData(v, "repairs") < 3 then
				outputChatBox("Es sind Hebebühnen des AutoFix zu befüllen.",source,0,255,0)
				break
			end
		end
		if isAusliefern ~= 0 then outputChatBox("Es sind "..isAusliefern.." Fahrzeuge zum ausliefern vorhanden.",source,0,255,0) return end
		outputChatBox("Es sind keine Fahrzeuge zum ausliefern vorhanden.",source,255,0,0)	
	end
end	
addCommandHandler("checkausliefern", truckerwho )


--Toilette und Bad
createObject(2525,1591.1999511719, 2360.8000488281, 9.9750003814697, 0, 0, 0)
createObject( 2524,1589.6999511719, 2360.8000488281, 9.9750003814697,0, 0, 0)
createObject(2526,1590.8000488281, 2358.1999511719, 9.9750003814697, 0, 0, 0)
		
--- InterTrans - Haupttore (EInfahrt/Ausfahrt)

local tor1 = createObject( 988, 1577.5999755859, 2335.8999023438, 10.39999961853, 0, 0, 270 )
local tor2 = createObject( 988, 1577.5999755859, 2330.3999023438, 10.39999961853, 0, 0, 270 )
local tor1_key1 = createObject( 2886, 1577.4000244141, 2327.8999023438, 12, 0, 0, 270 )
local tor1_key2 = createObject( 2886, 1578.0999755859, 2338.6000976563, 12, 0, 0, 90 )
setElementData( tor1_key1, "cinfo", {"Tore öffnen/schließen"} )
setElementData( tor1_key2, "cinfo", {"Tore öffnen/schließen"} )
setElementDoubleSided(tor1, true)
setElementDoubleSided(tor2, true)


function inter_tor1_func ( button, state, player )
	if getElementData( player, "job" ) ~= 2 then return end
		if getElementData( tor1, "moving" ) and getElementData( tor2, "moving" ) == true then return end
			setElementData( tor1, "moving", true )
			setElementData( tor2, "moving", true )
			setTimer( setElementData, 2600, 1, tor1, "moving", false ) 
			setTimer( setElementData, 2600, 1, tor2, "moving", false )
		if getElementData( tor1, "state" ) and getElementData( tor2, "state" ) == "open" then
			moveObject( tor1, 2500, 1577.5999755859, 2335.8999023438, 10.39999961853 )
			moveObject( tor2, 2500, 1577.5999755859, 2330.3999023438, 10.39999961853 )
			setElementData( tor1, "state", "closed" )
			setElementData( tor2, "state", "closed" )
	else
		moveObject( tor2, 2500, 1577.5999755859, 2324.6000976563, 10.39999961853 )
		moveObject( tor1, 2500, 1577.5999755859, 2341.6999511719, 10.39999961853 )
		setElementData( tor1, "state", "open" )
		setElementData( tor2, "state", "open" )
	end
end
addEventHandler( "onElementClicked", tor1_key1, inter_tor1_func )
addEventHandler( "onElementClicked", tor1_key2, inter_tor1_func )

--

local tor3 = createObject( 988, 1604.6999511719, 2283.5, 10.39999961853, 0, 0, 0 )
local tor4 = createObject( 988, 1610.1999511719, 2283.5, 10.39999961853, 0, 0, 0 )
local tor2_key1 = createObject( 2886, 1612.8000488281, 2283.3000488281, 12, 0, 0, 0 )
local tor2_key2 = createObject( 2886, 1602, 2283.8999023438, 12, 0, 0, 180 )
setElementData( tor2_key1, "cinfo", {"Tore öffnen/schließen"} )
setElementData( tor2_key2, "cinfo", {"Tore öffnen/schließen"} )
setElementDoubleSided(tor3, true)
setElementDoubleSided(tor4, true)

function inter_tor2_func ( button, state, player )
	if getElementData( player, "job" ) ~= 2 then return end
		if getElementData( tor3, "moving" ) and getElementData( tor4, "moving" ) == true then return end
			setElementData( tor3, "moving", true )
			setElementData( tor4, "moving", true )
			setTimer( setElementData, 2600, 1, tor3, "moving", false ) 
			setTimer( setElementData, 2600, 1, tor4, "moving", false )
		if getElementData( tor3, "state" ) and getElementData( tor4, "state" ) == "open" then
			moveObject( tor3, 2500, 1604.6999511719, 2283.5, 10.39999961853 )
			moveObject( tor4, 2500, 1610.1999511719, 2283.5, 10.39999961853 )
			setElementData( tor3, "state", "closed" )
			setElementData( tor4, "state", "closed" )
	else
		moveObject( tor3, 2500, 1598.9000244141, 2283.5, 10.39999961853 )
		moveObject( tor4, 2500, 1616, 2283.5, 10.39999961853 )
		setElementData( tor3, "state", "open" )
		setElementData( tor4, "state", "open" )
	end
end
addEventHandler( "onElementClicked", tor2_key1, inter_tor2_func )
addEventHandler( "onElementClicked", tor2_key2, inter_tor2_func )

--

local tor5 = createObject( 988, 1724.6999511719, 2303.3000488281, 10.199999809265, 0, 0, 0 )
local tor6 = createObject( 988, 1730.1999511719, 2303.3000488281, 10.199999809265, 0, 0, 0 )
local tor3_key1 = createObject( 2886, 1732.5999755859, 2303.1000976563, 11.89999961853, 0, 0, 0 )
local tor3_key2 = createObject( 2886, 1722.1999511719, 2303.6999511719, 11.89999961853, 0, 0, 180 )
setElementData( tor3_key1, "cinfo", {"Garage öffnen/schließen"} )
setElementData( tor3_key2, "cinfo", {"Garage öffnen/schließen"} )
setElementDoubleSided(tor5, true)
setElementDoubleSided(tor6, true)

function inter_tor3_func ( button, state, player )
	if getElementData( player, "job" ) ~= 2 then return end
		if getElementData( tor5, "moving" ) and getElementData( tor6, "moving" ) == true then return end
			setElementData( tor5, "moving", true )
			setElementData( tor6, "moving", true )
			setTimer( setElementData, 2600, 1, tor5, "moving", false ) 
			setTimer( setElementData, 2600, 1, tor6, "moving", false )
		if getElementData( tor5, "state" ) and getElementData( tor6, "state" ) == "open" then
			moveObject( tor5, 2500, 1724.6999511719, 2303.3000488281, 10.199999809265 )
			moveObject( tor6, 2500, 1730.1999511719, 2303.3000488281, 10.199999809265 )
			setElementData( tor5, "state", "closed" )
			setElementData( tor6, "state", "closed" )
	else
		moveObject( tor5, 2500, 1719.6999511719, 2303.3000488281, 10.199999809265 )
		moveObject( tor6, 2500, 1735.1999511719, 2303.3000488281, 10.199999809265 )
		setElementData( tor5, "state", "open" )
		setElementData( tor6, "state", "open" )
	end
end
addEventHandler( "onElementClicked", tor3_key1, inter_tor3_func )
addEventHandler( "onElementClicked", tor3_key2, inter_tor3_func )


--- Garagentore

local garage1 = createObject( 2938, 1595.9000244141, 2369.3999023438, 12.470000267029, 0, 0, 180 )
local garage1_key1 = createObject( 2886, 1595.9000244141, 2375.1000976563, 11.5, 0, 0, 90 )
local garage1_key2 = createObject( 2886, 1595.1999511719, 2375.1000976563, 11.5, 0, 0, 270 )
setElementData( garage1_key1, "cinfo", {"Garage öffnen/schließen"} )
setElementData( garage1_key2, "cinfo", {"Garage öffnen/schließen"} )

function inter_garage1_func ( button, state, player )
	if getElementData( player, "job" ) ~= 2 then return end
		if getElementData( garage1, "moving" ) == true then return end
			setElementData( garage1, "moving", true )
			setTimer( setElementData, 2600, 1, garage1, "moving", false ) 
		if getElementData( garage1, "state" ) == "open" then
			moveObject( garage1, 2500, 1595.9000244141, 2369.3999023438, 12.470000267029 )
			setElementData( garage1, "state", "closed" )
	else
		moveObject( garage1, 2500, 1595.9000244141, 2369.3999023438, 17 )
		setElementData( garage1, "state", "open" )
	end
end
addEventHandler( "onElementClicked", garage1_key1, inter_garage1_func )
addEventHandler( "onElementClicked", garage1_key2, inter_garage1_func )

local garage2 = createObject( 2938, 1595.9000244141, 2383.3999023438, 12.470000267029, 0, 0, 180 )
local garage2_key1 = createObject( 2886, 1595.9000244141, 2389.1999511719, 11.5, 0, 0, 90 )
local garage2_key2 = createObject( 2886, 1595.1999511719, 2389.1999511719, 11.5, 0, 0, 270 )
setElementData( garage2_key1, "cinfo", {"Garage öffnen/schließen"} )
setElementData( garage2_key2, "cinfo", {"Garage öffnen/schließen"} )

function inter_garage2_func ( button, state, player )
	if getElementData( player, "job" ) ~= 2 then return end
		if getElementData( garage2, "moving" ) == true then return end
			setElementData( garage2, "moving", true )
			setTimer( setElementData, 2600, 1, garage2, "moving", false ) 
		if getElementData( garage2, "state" ) == "open" then
			moveObject( garage2, 2500, 1595.9000244141, 2383.3999023438, 12.470000267029 )
			setElementData( garage2, "state", "closed" )
	else
		moveObject( garage2, 2500, 1595.9000244141, 2383.3999023438, 17 )
		setElementData( garage2, "state", "open" )
	end
end
addEventHandler( "onElementClicked", garage2_key1, inter_garage2_func )
addEventHandler( "onElementClicked", garage2_key2, inter_garage2_func )

local garage3 = createObject( 2938, 1595.9000244141, 2397.3999023438, 12.470000267029, 0, 0, 180 )
local garage3_key1 = createObject( 2886, 1595.9000244141, 2403.1999511719, 11.5, 0, 0, 90 )
local garage3_key2 = createObject( 2886, 1595.1999511719, 2403.1999511719, 11.5, 0, 0, 270 )
setElementData( garage3_key1, "cinfo", {"Garage öffnen/schließen"} )
setElementData( garage3_key2, "cinfo", {"Garage öffnen/schließen"} )

function inter_garage3_func ( button, state, player )
	if getElementData( player, "job" ) ~= 2 then return end
		if getElementData( garage3, "moving" ) == true then return end
			setElementData( garage3, "moving", true )
			setTimer( setElementData, 2600, 1, garage3, "moving", false ) 
		if getElementData( garage3, "state" ) == "open" then
			moveObject( garage3, 2500, 1595.9000244141, 2397.3999023438, 12.470000267029 )
			setElementData( garage3, "state", "closed" )
	else
		moveObject( garage3, 2500, 1595.9000244141, 2397.3999023438, 17 )
		setElementData( garage3, "state", "open" )
	end
end
addEventHandler( "onElementClicked", garage3_key1, inter_garage3_func )
addEventHandler( "onElementClicked", garage3_key2, inter_garage3_func )

		
local garage4 = createObject( 2938, 1602.1999511719, 2403.6999511719, 12.470000267029, 0, 0, 90 )
local garage4_key1 = createObject( 2886, 1596.4000244141, 2403.6999511719, 11.5, 0, 0, 0 )
local garage4_key2 = createObject( 2886, 1596.4000244141, 2404.3500976563, 11.5, 0, 0, 180 )
setElementData( garage4_key1, "cinfo", {"Garage öffnen/schließen"} )
setElementData( garage4_key2, "cinfo", {"Garage öffnen/schließen"} )

function inter_garage4_func ( button, state, player )
	if getElementData( player, "job" ) ~= 2 then return end
		if getElementData( garage4, "moving" ) == true then return end
			setElementData( garage4, "moving", true )
			setTimer( setElementData, 2600, 1, garage4, "moving", false ) 
		if getElementData( garage4, "state" ) == "open" then
			moveObject( garage4, 2500, 1602.1999511719, 2403.6999511719, 12.470000267029 )
			setElementData( garage4, "state", "closed" )
	else
		moveObject( garage4, 2500, 1602.1999511719, 2403.6999511719, 17 )
		setElementData( garage4, "state", "open" )
	end
end
addEventHandler( "onElementClicked", garage4_key1, inter_garage4_func )
addEventHandler( "onElementClicked", garage4_key2, inter_garage4_func )


local garage5 = createObject( 2938, 1616.1999511719, 2403.6999511719, 12.470000267029, 0, 0, 90 )
local garage5_key1 = createObject( 2886, 1610.4000244141, 2403.6999511719, 11.5, 0, 0, 0 )
local garage5_key2 = createObject( 2886, 1610.4000244141, 2404.3500976563, 11.5, 0, 0, 180 )
setElementData( garage5_key1, "cinfo", {"Garage öffnen/schließen"} )
setElementData( garage5_key2, "cinfo", {"Garage öffnen/schließen"} )

function inter_garage5_func ( button, state, player )
	if getElementData( player, "job" ) ~= 2 then return end
		if getElementData( garage5, "moving" ) == true then return end
			setElementData( garage5, "moving", true )
			setTimer( setElementData, 2600, 1, garage5, "moving", false ) 
		if getElementData( garage5, "state" ) == "open" then
			moveObject( garage5, 2500, 1616.1999511719, 2403.6999511719, 12.470000267029 )
			setElementData( garage5, "state", "closed" )
	else
		moveObject( garage5, 2500, 1616.1999511719, 2403.6999511719, 17 )
		setElementData( garage5, "state", "open" )
	end
end
addEventHandler( "onElementClicked", garage5_key1, inter_garage5_func )
addEventHandler( "onElementClicked", garage5_key2, inter_garage5_func )


local garage6 = createObject( 2938, 1630.3000488281, 2403.6999511719, 12.470000267029, 0, 0, 90 )
local garage6_key1 = createObject( 2886, 1624.4000244141, 2403.6999511719, 11.5, 0, 0, 0 )
local garage6_key2 = createObject( 2886, 1624.4000244141, 2404.3500976563, 11.5, 0, 0, 180 )
setElementData( garage6_key1, "cinfo", {"Garage öffnen/schließen"} )
setElementData( garage6_key2, "cinfo", {"Garage öffnen/schließen"} )

function inter_garage6_func ( button, state, player )
	if getElementData( player, "job" ) ~= 2 then return end
		if getElementData( garage6, "moving" ) == true then return end
			setElementData( garage6, "moving", true )
			setTimer( setElementData, 2600, 1, garage6, "moving", false ) 
		if getElementData( garage6, "state" ) == "open" then
			moveObject( garage6, 2500, 1630.3000488281, 2403.6999511719, 12.470000267029 )
			setElementData( garage6, "state", "closed" )
	else
		moveObject( garage6, 2500, 1630.3000488281, 2403.6999511719, 17 )
		setElementData( garage6, "state", "open" )
	end
end
addEventHandler( "onElementClicked", garage6_key1, inter_garage6_func )
addEventHandler( "onElementClicked", garage6_key2, inter_garage6_func )
