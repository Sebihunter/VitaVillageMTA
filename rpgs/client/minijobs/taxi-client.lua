--[[
Project: VitaOnline
File: taxi-client.lua
Author(s):	Golf_R32
			Sebihunter
]]--

thetaxitext = ""

TaxiFahrer_Window = {}

TaxiFahrer_Button = {}


TaxiFahrer_Window[1] = guiCreateWindow(0.3476,0.7314,0.275,0.1057,"Taxifahrt Starten?",true)

guiWindowSetMovable(TaxiFahrer_Window[1],false)

guiWindowSetSizable(TaxiFahrer_Window[1],false)

TaxiFahrer_Button[1] = guiCreateButton(0.0195,0.2523,0.4394,0.6036,"Fahren",true,TaxiFahrer_Window[1])

TaxiFahrer_Button[2] = guiCreateButton(0.5346,0.2523,0.4394,0.6036,"Abbrechen",true,TaxiFahrer_Window[1])

theTaxiMarker = createMarker(1083.9000244141, 2409.1000976563, 9.8000001907349, "cylinder", 1, 245,158,9, 255)

guiSetVisible(
TaxiFahrer_Window[1],false)
setElementData(getLocalPlayer(), "taxi", false)


local antiTaxiSpam = false
function hitTaxiMarker(player)
	if antiTaxiSpam == true then outputChatBox("Du musst kurz warten, um deinen Dienst erneut zu beginnen/beenden.", 255,0,0) return end
	if getLocalPlayer() == player then
		if getElementData(getLocalPlayer(), "taxi") == true then
			setElementData(getLocalPlayer(), "taxi", false)
			callServerFunction("outputChatBox", getPlayerName(getLocalPlayer()).." hat den Dienst als Taxifahrer beendet.", getRootElement(), 125,0,125)
			antiTaxiSpam = true
			setTimer(function() antiTaxiSpam = false end, 10000, 1)
		else
			if getElementData(getLocalPlayer(), "dienst") == 1 then addNotification(1, 255, 0, 0, "Du kannst keinen Nebenjob beginnen\nwenn du im Dienst bist.") return end
			callServerFunction("outputChatBox", getPlayerName(getLocalPlayer()).." hat den Dienst als Taxifahrer begonnen.", getRootElement(), 125,0,125)
			setElementData(getLocalPlayer(), "taxi", true)
			antiTaxiSpam = true
			setTimer(function() antiTaxiSpam = false end, 10000, 1)
		end
	end
end
addEventHandler("onClientMarkerHit", theTaxiMarker,hitTaxiMarker)

function start ()
	local x,y = guiGetScreenSize()

	dxDrawText(thetaxitext, 5,0,x,y*0.5,tocolor(0,0,0,255), 2, "sans", "center", "center")
	dxDrawText(thetaxitext, 0,5,x,y*0.5,tocolor(0,0,0,255), 2, "sans", "center", "center")
	dxDrawText(thetaxitext, 0,-5,x,y*0.5,tocolor(0,0,0,255), 2, "sans", "center", "center")
	dxDrawText(thetaxitext, -5,0,x,y*0.5,tocolor(0,0,0,255), 2, "sans", "center", "center")

	dxDrawText(thetaxitext, 5,5,x,y*0.5,tocolor(0,0,0,255), 2, "sans", "center", "center")
	dxDrawText(thetaxitext, -5,5,x,y*0.5,tocolor(0,0,0,255), 2, "sans", "center", "center")
	dxDrawText(thetaxitext, 5,-5,x,y*0.5,tocolor(0,0,0,255), 2, "sans", "center", "center")
	dxDrawText(thetaxitext, -5,-5,x,y*0.5,tocolor(0,0,0,255), 2, "sans", "center", "center")

	dxDrawText(thetaxitext, 0,0,x,y*0.5,tocolor(255,100,0,255), 2, "sans", "center", "center")
end

addEventHandler("onClientVehicleEnter", getRootElement(),
	function(thepalyer, seat)
		if thepalyer == getLocalPlayer() then
			if seat > 0 then
 				if getVehicleName(source) == "Taxi" or getVehicleName(source) == "Cabbie" then
					addEventHandler("onClientRender", getRootElement(), start)
					thetaxitext = ""
					derfahrererer = source
					triggerServerEvent("doTaxiWindowShowTheTaxler", getLocalPlayer(), source, getLocalPlayer())
				end
			else
				if getVehicleName(source) == "Taxi" or getVehicleName(source) == "Cabbie" then
					if getElementData(getLocalPlayer(), "taxi") == true then
						addEventHandler("onClientRender", getRootElement(), start)
						callServerFunction("setVehicleTaxiLightOn", source, true)
						showTutorialMessage("taxi_2", "Als Taxifahrer musst du Kunden von A nach B bringen. Wenn ein Spieler ein Taxi ruft, wirst du benachrichtigt.")
					else
						makePlayerExitVehicle()
						addNotification(1, 255, 0, 0, "Du kannst dieses Fahrzeug nur im Taxidienst fahren!")
					end
				end
			end
		end
	end
)

addEventHandler("onClientVehicleExit", getRootElement(),
	function(thepalyer, seat)
		if thepalyer == getLocalPlayer() then
			thetaxitext = ""
			if seat > 0 then
				if getVehicleName(source) == "Taxi" or getVehicleName(source) == "Cabbie" then
					if isTimer(abzugstimer) then
						triggerServerEvent("stopDenTimerFuerDenTaxler", getLocalPlayer(), derfahrererer,seat)
						killTimer(abzugstimer)
						local source = getPedOccupiedVehicle(getLocalPlayer()) 
						if getVehicleName(source) == "Cabbie" or getVehicleName(source) == "Taxi" then
							thetaxitext = "Taxifahrt abgebrochen!"
							callServerFunction("setVehicleTaxiLightOn", source, true)
						end
						setTimer(function() thetaxitext = "" removeEventHandler("onClientRender", getRootElement(), start) end, 2000,1)
						taxitime = 0
					end
				end
			else
				if getElementData(getLocalPlayer(), "taxi") == true then
					if getVehicleName(source)  ~= "Cabbie" and getVehicleName(source) ~= "Taxi" then
						setElementData(getLocalPlayer(), "taxi", false)
						callServerFunction("outputChatBox", getPlayerName(getLocalPlayer()).." hat den Dienst als Taxifahrer beendet.", getRootElement(), 125,0,125)			
						removeEventHandler("onClientRender", getRootElement(), start)
					end
					callServerFunction("setVehicleTaxiLightOn", source, false)
				end
			end
		end
	end
)
addEvent("doShowTheWindowToTaxi",true)
addEventHandler("doShowTheWindowToTaxi", getLocalPlayer(),
	function(passe)
		if getElementData(getLocalPlayer(), "taxi") == true then
			guiSetVisible(TaxiFahrer_Window[1],true)
			showCursor(true)
			local source = getPedOccupiedVehicle(getLocalPlayer()) 
			if getVehicleName(source) == "Cabbie" or getVehicleName(source) == "Taxi" then
				guiSetText(TaxiFahrer_Window[1],"Taxifahrt Starten?")
			end
			derdergefahrenwerdenmuss = passe
		end
	end
)
addEvent("startthefuckntaxitimer", true)
addEventHandler("startthefuckntaxitimer", getLocalPlayer(),
	function(paser)
		taxitime = 0
		local source = getPedOccupiedVehicle(getLocalPlayer()) 
		if getVehicleName(source) == "Cabbie" or getVehicleName(source) == "Taxi" then
			thetaxitext = "Taxifahrt gestartet!"
			callServerFunction("setVehicleTaxiLightOn", source, false)
		end
		if not isTimer(abzugstimer) then
			abzugstimer = setTimer(geldabziehen, 2500,0)  
		end
	end
)

addEvent("startthefuckntaxlertimer", true)
addEventHandler("startthefuckntaxlertimer", getLocalPlayer(),
	function(paser)
		taxitime = 0
		local source = getPedOccupiedVehicle(getLocalPlayer()) 
		if getVehicleName(source) == "Cabbie" or getVehicleName(source) == "Taxi" then
			thetaxitext = "Taxifahrt gestartet!"
			callServerFunction("setVehicleTaxiLightOn", source, false)
		end
		if not isTimer(abzugstimer) then
			abzugstimer = setTimer(geldabziehenzeigen, 2500,0) 
		end
	end
)

function geldabziehenzeigen()
	if getVehicleOccupants (getPedOccupiedVehicle(getLocalPlayer())) and #getVehicleOccupants (getPedOccupiedVehicle(getLocalPlayer())) == 1 then
		thetaxitext = "Fehler: Nur eine Person im Fahrzeug."
		return false
	end
	local sx,sy,sz = getElementVelocity(getPedOccupiedVehicle(getLocalPlayer()))
	if ((sx^2 + sy^2 + sz^2) ^ 0.5) > 0 then
		taxitime = taxitime+3
		thetaxitext = "Bisheriger Verdienst: "..tostring(taxitime).." Vero."
	else
		thetaxitext = "Bisheriger Verdienst: "..tostring(taxitime).." Vero. Wagen angehalten!"
	end
end


addEvent("taxlerIstAusgestiegen", true)
addEventHandler("taxlerIstAusgestiegen", getLocalPlayer(),
	function()
		if isTimer(abzugstimer) then
			killTimer(abzugstimer)
		end
		local source = getPedOccupiedVehicle(getLocalPlayer()) 
		if source then
			if getVehicleName(source) == "Cabbie" or getVehicleName(source) == "Taxi" then
				thetaxitext = "Taxifahrt abgebrochen!"
			end
		end
		setTimer(function() thetaxitext = "" end, 2000,1)
		taxitime = 0
	end
)
function geldabziehen()
	local sx,sy,sz = getElementVelocity(getPedOccupiedVehicle(getLocalPlayer()))
	if ((sx^2 + sy^2 + sz^2) ^ 0.5) > 0 then
		taxitime = taxitime+3
		thetaxitext = "Bisherige Kosten: "..tostring(taxitime).." Vero."
		triggerServerEvent("bezahleDasZeuch", getLocalPlayer(), getLocalPlayer(),derfahrererer, 3)
		showTutorialMessage("taxi_3", "Das Geld wird während der Fahrt direkt bezahlt.")
	else
		thetaxitext = "Bisherige Kosten: "..tostring(taxitime).." Vero. Wagen angehalten!"
	end
end
addEventHandler("onClientGUIClick", getRootElement(),
	function()
		if source == TaxiFahrer_Button[1] then
			showTutorialMessage("taxi_1", "Der Kunde hat deine Taxifahrt angenommen. Bringe ihn zu seinem Ziel.")
			triggerServerEvent("startTheTaxiDrive", getLocalPlayer(),getLocalPlayer(), derdergefahrenwerdenmuss)
			guiSetVisible(TaxiFahrer_Window[1],false)
			showCursor(false)
		end
		if source == TaxiFahrer_Button[2] then
			guiSetVisible(TaxiFahrer_Window[1],false)
			showCursor(false)
		end
	end
)