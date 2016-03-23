--[[
Project: VitaOnline
File: tankraub-server.lua
Author(s):	Tommi 
]]--

local Tankstelle = {
{2637.2033691406, 1129.0383300781, 10.694087028503}, 
{2151.1064453125, 2733.998046875, 10.690749168396}, 
{1600.8427734375, 2217.712890625, 11.0625}, 
{2191.5322265625, 2469.5380859375, 10.8203125}, 
{2117.7587890625, 896.88647460938, 10.694087028503}, 
{663.01000976563, 1716.6723632813, 6.7019000053406}, 
{-1320.1358642578, 2698.6208496094, 49.780681610107}, 
{-1465.7069091797, 1873.400390625, 32.147212982178},
{-2419.9138183594, 969.53680419922, 44.811275482178}, 
{-1675.9117431641, 431.97747802734, 6.6940875053406}, 
{-2231.7612304688, -2558.1184082031, 31.436275482178}, 
{-1623.5701904297, -2693.3859863281, 48.257061004639}, 
{-78.400489807129, -1169.8852539063, 1.6506208181381}, 
{661.3134765625, -573.52526855469, 15.850337028503}, 
{1383.1928710938, 465.6298828125, 19.70580291748}, 
{1929.267578125, -1776.5579833984, 13.061274528503}, 
{-1991.017578125, 212.015625, 26.679862976074}
}
local dims = {130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146}



function robtanke(player,cmd)
	local CopOnDuty = 0
	if getElementData(player, "gang") > 0 and getElementData(player,"job") ~= 3 and getElementData(player, "dienst") ~= 1 then
		if getElementData(player,"btime") == 0 then
			setElementData(player,"cooldown",0)
		end	
		if getElementData(player,"cooldown") == 1 then
			return outputChatBox("Du kannst erst wieder eine Tankstelle in "..tostring(getElementData(player,"btime")).." Minuten ausrauben!",player,200,0,0)
		end	
		for idx, play in ipairs(getElementsByType("player")) do
			if getElementData(play, "job") == 3 and getElementData(play, "dienst") == 1 then
				CopOnDuty = CopOnDuty+1
			end
		end
		if getElementInterior(player) == 4 then
			if CopOnDuty < 1 then
				return outputChatBox("Du kannst keinen Überfall machen wenn kein Polizist Online ist!", player, 255, 0, 0)
			end
			for index, spieler in ipairs(getElementsByType("player")) do
				if getElementData(spieler, "job") == 3 and getElementData(spieler, "dienst") == 1 then
					outputChatBox("Eine Tankstelle wird überfallen.Sie ist auf der Karte markiert!", spieler, 255, 0, 0)
					triggerClientEvent(player,"drawBankrobTimerClient",root)
					setElementData(player,"btime",180)
					setElementData(player,"cooldown",1)
					
					for i = 1, #Tankstelle do
						for _, k in ipairs(dims) do
							if getElementDimension (player) == dims[i] then
								if _G["robBlip"..tostring(dims[i])] == nil then
									_G["robBlip"..tostring(dims[i])] = createBlip(Tankstelle[i][1], Tankstelle[i][2], Tankstelle[i][3], 0, 5, 255, 0, 0, 255, 0, 99999.0, spieler)
								end
							end
						end
					end
						
					setTimer(function(player)
						if not player or not isElement(player) then return end
						if getElementData(player, "isPlayerLoggedIn") == true then
							if getElementData(player,"btime") > 0 then
								setElementData(player,"btime",(getElementData(player,"btime")-1))
							end
							
							if getElementData(player,"btime") == 0 then
								setElementData(player,"cooldown",0)
							end
						end
					end,60000,180,player)
						
					setTimer(function(spieler)
						if not spieler or not isElement(spieler) then return end
						if isElement(_G["robBlip"..tostring(getElementDimension(player))]) then
							destroyElement(_G["robBlip"..tostring(getElementDimension(player))])
						end
					end,120000,1,spieler)
						
				end
			end
		elseif getElementData(player, "job") == 3 then
			outputChatBox("Du Depp kannst doch nicht als Polizist eine Tankstelle ausrauben!", player, 255, 0, 0)
		elseif getElementData(player,"gang") == 0 then
			outputChatBox ("Du bist kein Mitglied einer Gang.", player, 255, 0, 0 )
		elseif getElementData(player, "dienst") == 1 then
			outputChatBox ("Du bist gerade im Dienst.", player, 255, 0, 0 )
		end
	end
end
addCommandHandler("ausrauben",robtanke)

addEvent("giveTankstelleServer",true)
addEventHandler("giveTankstelleServer",root,
	function(player)
		local money = math.random(2000,5000)
		local moneyPickup = createPickup (-30.724609375, -28.4638671875, 1003.5572509766, 3, 1274 )
		setElementInterior(moneyPickup, 4, -30.724609375, -28.4638671875, 1003.5572509766)
		setElementDimension(moneyPickup, getElementDimension(player))
		addEventHandler ("onPickupHit", moneyPickup, function()
			outputChatBox ("Du hast "..tostring(money).."Vero erbeutet.", player, 0, 255, 0 )
			setElementData(player,"geld",getElementData(player,"geld")+money)
			destroyElement(moneyPickup)
		end)
	end
)