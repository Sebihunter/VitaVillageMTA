--[[
Project: VitaOnline
File: taxi-server.lua
Author(s):	Golf_R32
			Sebihunter
]]--

local miniMissionTaxi = {}

function createTaxiJobVehicles()
	miniMissionTaxi[#miniMissionTaxi+1] = createRPGVehicle(420,1079.4000244141, 2406.8999023438, 10.60000038147, 0  ,"TAXI",{{215,142,16},{94,112,114},{0,0,0},{0,0,0}},true,false)
	miniMissionTaxi[#miniMissionTaxi+1] = createRPGVehicle(420,1076.1999511719, 2406.8999023438, 10.60000038147, 0  ,"TAXI",{{215,142,16},{94,112,114},{0,0,0},{0,0,0}},true,false)
	miniMissionTaxi[#miniMissionTaxi+1] = createRPGVehicle(420,1073, 2406.8999023438, 10.60000038147, 0  ,"TAXI",{{215,142,16},{94,112,114},{0,0,0},{0,0,0}},true,false)
	miniMissionTaxi[#miniMissionTaxi+1] = createRPGVehicle(420,1069.8000488281, 2406.8999023438, 10.60000038147, 0  ,"TAXI",{{215,142,16},{94,112,114},{0,0,0},{0,0,0}},true,false)
	miniMissionTaxi[#miniMissionTaxi+1] = createRPGVehicle(420,1066.5999755859, 2406.8999023438, 10.60000038147, 0  ,"TAXI",{{215,142,16},{94,112,114},{0,0,0},{0,0,0}},true,false)
	miniMissionTaxi[#miniMissionTaxi+1] = createRPGVehicle(438,1063.4000244141, 2406.8999023438, 10.60000038147, 0  ,"TAXI",{{215,142,16},{94,112,114},{0,0,0},{0,0,0}},true,false)
	miniMissionTaxi[#miniMissionTaxi+1] = createRPGVehicle(438,1060.0999755859, 2406.8999023438, 10.60000038147, 0  ,"TAXI",{{215,142,16},{94,112,114},{0,0,0},{0,0,0}},true,false)
	miniMissionTaxi[#miniMissionTaxi+1] = createRPGVehicle(438,1057, 2406.8999023438, 10.60000038147, 0  ,"TAXI",{{215,142,16},{94,112,114},{0,0,0},{0,0,0}},true,false)
	miniMissionTaxi[#miniMissionTaxi+1] = createRPGVehicle(438,1053.8000488281, 2406.8999023438, 10.60000038147, 0  ,"TAXI",{{215,142,16},{94,112,114},{0,0,0},{0,0,0}},true,false)
	miniMissionTaxi[#miniMissionTaxi+1] = createRPGVehicle(438,1050.5, 2406.8999023438, 10.60000038147, 0  ,"TAXI",{{215,142,16},{94,112,114},{0,0,0},{0,0,0}},true,false)
	miniMissionTaxi[#miniMissionTaxi+1] = createRPGVehicle(438,1047.3000488281, 2406.8999023438, 10.60000038147, 0  ,"TAXI",{{215,142,16},{94,112,114},{0,0,0},{0,0,0}},true,false)
	for i = 1,#miniMissionTaxi do
		setElementData( miniMissionTaxi[i], "doNotLooseFuel", true)
		toggleVehicleRespawn( miniMissionTaxi[i], true )
		setVehicleIdleRespawnDelay ( miniMissionTaxi[i], 60000 )
		setElementData( miniMissionTaxi[i], "shallRespawn", true)
	end		
end	
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), createTaxiJobVehicles)


addEvent("doTaxiWindowShowTheTaxler", true)
addEventHandler("doTaxiWindowShowTheTaxler", getRootElement(),
	function(taxler, passanger)
		local driver = getVehicleOccupant(taxler)
		if driver then
			triggerClientEvent("doShowTheWindowToTaxi", driver,passanger)
		end
	end
)
addEvent("startTheTaxiDrive", true)
addEventHandler("startTheTaxiDrive", getRootElement(),
	function(driver,passend)
		local veh = getPedOccupiedVehicle(driver)
		if veh then
			setVehicleTaxiLightOn(veh,true)
			triggerClientEvent("startthefuckntaxitimer", passend)
			triggerClientEvent("startthefuckntaxlertimer", driver)
		end
	end
)

addEventHandler("onVehicleExit", getRootElement(),
	function(thepalyer, seat)
		if isVehicleTaxiLightOn(source) == true then
			if seat == 0 then
 			if getVehicleName(source) == "Taxi" or getVehicleName(source) == "Cabbie" then
				triggerClientEvent("taxlerIstAusgestiegen", thepalyer)
				if getVehicleOccupant(source,1) then
					triggerClientEvent("taxlerIstAusgestiegen", getVehicleOccupant(source,1))
					triggerClientEvent("taxlerIstAusgestiegen", thepalyer)
				end
				if getVehicleOccupant(source,2) then
					triggerClientEvent("taxlerIstAusgestiegen", getVehicleOccupant(source,2))
					triggerClientEvent("taxlerIstAusgestiegen", thepalyer)
				end
				if getVehicleOccupant(source,3) then
					triggerClientEvent("taxlerIstAusgestiegen", getVehicleOccupant(source,3))
					triggerClientEvent("taxlerIstAusgestiegen", thepalyer)
				end
				if getVehicleOccupant(source,4) then
					triggerClientEvent("taxlerIstAusgestiegen", getVehicleOccupant(source,4))
					triggerClientEvent("taxlerIstAusgestiegen", thepalyer)
				end
				setVehicleTaxiLightOn(source,false)
			end
				end
		end
	end
)
addEvent("stopDenTimerFuerDenTaxler", true)
addEventHandler("stopDenTimerFuerDenTaxler", getRootElement(),
	function(source,sitz)
				dasasdasd = 0
				if sitz == 1 then
					triggerClientEvent("taxlerIstAusgestiegen", getVehicleOccupant(source,0))
					dasasdasd = dasasdasd +1
				elseif sitz == 2 then
					triggerClientEvent("taxlerIstAusgestiegen", getVehicleOccupant(source,0))
					dasasdasd = dasasdasd +1
				elseif sitz == 3 then
					triggerClientEvent("taxlerIstAusgestiegen", getVehicleOccupant(source,0))
					dasasdasd = dasasdasd +1
				elseif sitz == 4 then
					triggerClientEvent("taxlerIstAusgestiegen", getVehicleOccupant(source,0))
					dasasdasd = dasasdasd +1
				end
	end
)
addEvent("bezahleDasZeuch", true)
addEventHandler("bezahleDasZeuch", getRootElement(),
	function(derpasse, auto,zeit)
		local veh = getVehicleOccupant(auto)
		if veh then
			if getPlayerMoneyEx(derpasse) - zeit > 0 then
				takePlayerMoneyEx(derpasse, zeit)
				givePlayerMoneyEx(veh, zeit)
				setElementData(veh, "exp", getElementData(veh, "exp")+math.floor(zeit/10))
			else
				outputChatBox(getPlayerName(derpasse).." hat nicht genug Geld um die Fahrt zu bezahlen. (Fahrtkosten "..zeit.." Vero)", veh, 125, 125, 125)
				outputChatBox("Du hast nicht genug Geld um die Fahrt zu bezahlen. (Fahrtkosten "..zeit.." Vero)", derpasse, 125, 125, 125)
			end
		end
	end
)
