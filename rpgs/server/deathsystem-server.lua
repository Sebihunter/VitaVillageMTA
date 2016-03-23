--[[
Project: VitaOnline
File: deathsystem-server.lua
Author(s):	Golf_R32
			Sebihunter
]]--

hospitalTimer = {}



function spawnAtHospital(player)
	if getElementData(player, "isWaitingForDeath") ~= true then return end
	setPlayerUserFileData(getPlayerName(player), "time", "1")
	setTimer(
		function()
			fadeCamera(player,false)
			setTimer(
				function()
					if player then
						for numb,ply in ipairs(getElementsByType("player")) do
							if getElementData(ply, "job") == 7 and getElementData(ply, "dienst") == 1 then
								outputChatBox ( getPlayerName(player).." wurde automatisch ins Krankenhaus gebracht.", ply, 125, 125, 0, true )	
							end
						end
						local x, y, z = getElementPosition(player)
						
						if getPlayerMoneyEx(player) ~= 0 then
							local itemid = 47 --Geld
							local item = createObject ( gItemData[itemid].model, x, y, z+gItemData[itemid].zo - 0.9, gItemData[itemid].rx, gItemData[itemid].ry, gItemData[itemid].rz )
							setElementData(item, "cinfo", {"Item aufnehmen"})
							setElementData(item, "isPickupableObj", true)
							setElementData(item, "itemid", itemid)
							setElementData(player, "injured", nil)
							createClickableElement(item, pickUpItem)
							setElementInterior(item, getElementInterior(player))
							setElementDimension(item, getElementDimension(player))			
							setElementData(item, "money", getPlayerMoneyEx(player))
							takePlayerMoneyEx ( player, getPlayerMoneyEx(player) )
							triggerClientEvent ( player, "addNotification", getRootElement(), 2, 245,089,151, "Du wurdest ins Krankenhaus gebracht und hast dabei dein Geld verloren\nMit etwas Glück findest du es wieder an deiner letzten Position." )
						end
					
						spawnPlayer(player, 370, 309.3,1020.3,0,getElementModel(player), 3,0)
						setPedStat(player, 230, 0)
						setElementData(player, "isDead", false)
						setElementData(player, "isWaitingForDeath", false)
						setCameraTarget(player,player)
						fadeCamera(player,true)
						setPedAnimation(player, false)
						toggleAllControls (player,true)
						setElementFrozen ( player, false )
					end
				end
			,2000,1)
		end
	,5000,1)
end

addEventHandler("onPlayerWasted", getRootElement(),
	function(ammo, attacker, weapon, bodypart)
		if g_FreeMode == false and getElementData(source, "einsperrzeit") == 0 and getElementData(source, "afk") ~= true then
			local player = source
			if attacker and isElement(attacker) then
				pLogger["kill"]:addEntry(tostring(getPlayerName(player)).." wurde von "..tostring(getPlayerName(attacker)).." mit einer Waffe (ID: "..tostring(weapon)..") getötet.")
			end
			hospitalTimer[player] = nil
			local isMedicOnline = false
			for numb,ply in ipairs(getElementsByType("player")) do
				if getElementData(ply, "job") == 7 and getElementData(ply, "dienst") == 1 and ply ~= source and getElementData(ply, "afk") ~= true then
					if not getElementData(ply, "einsperrzeit") or getElementData(ply, "einsperrzeit") == 0 then
						isMedicOnline = true
						break
					end
				end
			end
			setElementData(source, "isDead", true)
			setElementData(player, "injured", nil)
			setElementData(source, "promille", 0)
			setElementData(source, "promillesoll", 0)
			setElementData(source, "isWaitingForDeath", true)
			
			if playerHandcuffTimer[source] and isTimer(playerHandcuffTimer[source]) then
				killTimer(playerHandcuffTimer[source])
				toggleHandcuffs(source, getElementData(source, "handschellen"))
			end
			if isMedicOnline == true then
				local x, y, z = getElementPosition(player)
				spawnPlayer(player, x, y, z, 0,getElementModel(player), getElementInterior(player),getElementDimension(player))
				setElementFrozen ( player, true )
				toggleAllControls ( player, false )
				setPedAnimation ( player, "CRACK", "crckdeth2", -1, true, true, false, false )
				--setElementData(player, "isWaitingForDeath", true)
				hospitalTimer[player] = setTimer ( spawnAtHospital, 180000, 1, player )
				callAccepters[7][player] = true
				for numb,ply in ipairs(getElementsByType("player")) do
					if getElementData(ply, "job") == 7 and getElementData(ply, "dienst") == 1 then
						local x, y, z = getElementPosition(player)
						local zone = getZoneName ( x, y, z )
						local city = getZoneName ( x, y, z, true )
						callClientFunction(ply, "playDispatch", "Achtung an alle Einheiten: Notfalleinsatz in "..zone..", "..city)
						triggerClientEvent ( ply, "addNotification", getRootElement(), 2, 255,255,0, getPlayerName(player).." benötigt einen Sanitäter da er schwer verletzt ist.\n"..zone.." ("..city..")." )
						outputChatBox ( getPlayerName(player).." benötigt einen Sanitäter in "..zone.." ("..city..") da er schwer verletzt ist.", ply, 255, 255, 0, true )
						outputChatBox ( "Du kannst den Einsatz mit '/annehmen auftrag "..getPlayerName(source).."' annehmen.", ply, 255, 255, 0, true )	
					end
				end
			else
				spawnAtHospital(player)
			end
		else
			local x,y,z = getElementPosition(source)
			local dim = getElementDimension(source)
			local int = getElementInterior(source)
			spawnPlayer ( source, x, y, z, 0, getElementModel(source) )
			setElementInterior(source, int)
			setElementDimension(source, dim)
		end
	end
)


function togglePlayerFire(elm, state)
	toggleControl ( elm, "fire", state)
 	toggleControl ( elm, "aim_weapon", state )
 	toggleControl ( elm, "action", state )
 	toggleControl ( elm, "next_weapon", state )
 	toggleControl ( elm, "previous_weapon", state )
end