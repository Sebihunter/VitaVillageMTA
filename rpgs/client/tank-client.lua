--[[
Project: VitaOnline
File: tank-client.lua
Author(s):	Sebihunter
]]--

istAmTanken = false
fuel = 0
local tankSperre = false

local howMuchCost = 0

function tankRender()
	if(istAmTanken == true) then
		dxDrawRectangle ( screenWidth/2-200, screenHeight/2-100, 400, 200, tocolor ( 0, 0, 0, 150 ) )
		dxDrawText ( "Tankvorgang", screenWidth/2-200+6, screenHeight/2-100+6, screenWidth, screenHeight, tocolor ( 0, 0, 0, 255 ), 1, "bankgothic" )
		dxDrawText ( "Tankvorgang", screenWidth/2-200+5, screenHeight/2-100+5, screenWidth, screenHeight, tocolor ( 255, 150, 0, 255 ), 1, "bankgothic" )
		dxDrawText ( "Zum Tankabbruch Fahrzeug erneut anklicken.", 1, screenHeight/2-50+1, screenWidth, screenHeight, tocolor ( 0, 0, 0, 255 ), 1, "clear", "center" )
		dxDrawText ( "Zum Tankabbruch Fahrzeug erneut anklicken.", 0, screenHeight/2-50, screenWidth, screenHeight, tocolor ( 255, 255, 255, 255 ), 1, "clear", "center" )
	
		dxDrawProgressBar( screenWidth/2-100, screenHeight/2+30, 200, 10, tocolor ( 0, 0, 0, 255 ), tocolor ( 125, 0, 125, 255 ), tocolor ( 100, 0, 100, 255 ), tonumber(fuel)/100)
		dxDrawText ( fuel.."/100%", 1, screenHeight/2+50+1, screenWidth, screenHeight, tocolor ( 0, 0, 0, 255 ), 1, "sans", "center" )
		dxDrawText ( fuel.."/100%", 0, screenHeight/2+50, screenWidth, screenHeight, tocolor ( 255, 255, 255, 255 ), 1, "sans", "center" )
	end
end
function StarteTankvorgang(veh, tankstelle,nodisplay)
	if(istAmTanken == true) then
		if nodisplay ~= true then
			addNotification(3, 255, 255, 0, "Tankvorgang beendet!")
		end
		removeEventHandler("onClientRender", getRootElement(),tankRender)
		istAmTanken = false
		tankSperre = true
		setTimer(function() tankSperre = false end, 500, 1)
		setElementFrozen(veh, false)
		setElementFrozen(getLocalPlayer(), false)
		triggerServerEvent ( "checkIfVehicleFK", getLocalPlayer(), veh, howMuchCost)
	elseif tankSperre == false then
		if nodisplay ~= true then
			addNotification(3, 255, 255, 0, "Fahrzeug wird aufgetankt...")
		end
		howMuchCost = 0
		setElementFrozen(veh, true)
		setElementFrozen(getLocalPlayer(), true)
		istAmTanken = true
		addEventHandler("onClientRender", getRootElement(), tankRender)
		setTimer ( TankAufTimer, 100, 1, veh, tankstelle)	
		showTutorialMessage("tank_1", "Das Fahrzeug wird nun automatisch aufgetankt. Um den Tankvorgang zu beenden klicke erneut auf dein Fahrzeug.")
	end
end
function TankAufTimer(veh, tankstelle)
	if(istAmTanken == true) then
	
		fuel = math.round(getElementData ( veh, "fuel" ), 0, "round")
		if ((tonumber(getElementData ( veh, "fuel" )) + 1) > 100) then
			addNotification(2, 0, 255, 0, "Fahrzeug voll getankt!")
			StarteTankvorgang(veh, tankstelle, false)
		else
			if(getPlayerMoneyEx(getLocalPlayer()) < 0) then
				addNotification(1, 255, 0, 0, "Du hast kein Geld mehr um weiterzutanken!")
				StarteTankvorgang(veh)
			elseif getElementData(tankstelle, "fuel") <= 0 then
				addNotification(1, 255, 0, 0, "Diese Tankstelle ist leer!")
				StarteTankvorgang(veh, tankstelle, false)
			else
				setElementData(veh, "fuel", tonumber(getElementData ( veh, "fuel" ))+1)
				setElementData(tankstelle, "fuel", getElementData(tankstelle, "fuel")-1)
				setTimer ( TankAufTimer, 500, 1, veh, tankstelle)
				takePlayerMoneyEx(1)
				howMuchCost = howMuchCost+1
			end
		end
	end
end
