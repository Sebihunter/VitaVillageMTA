--[[------------------------------------------------------------------------||--
								(<---Log--->)									
	15.02.2010
		22:20 - file created
	16.02.2010
		01:00 - added simple blood effect
	17.03.2010
		15:00 - further developping, stopped endless bleeding
				now bleeding as much as you lost health
--||------------------------------------------------------------------------]]--

local gInjured = { };

--[[------------------------------------------------------------------------||--
							(<---Callbacks--->)									
																				
--||------------------------------------------------------------------------]]--

function onPlayerGetsInjured(attacker, weapon, bodyPart, loss)
	--setElementData(source, "pTaserMode", true, true)
	outputDebugString(tostring(getPlayerName(source)))
	if(source == getLocalPlayer() and getElementData(source, "isPlayerLoggedIn") == true and getElementData(source, "AFK") ~= true and getElementData(source, "isDead") ~= true) and weapon ~= 41 and weapon ~= 42 then
		if weapon == 24 and attacker and getElementData(attacker, "pTaserMode") == true then return end
		local injureTable = getElementData(source, "injured");
		if(not injureTable) then injureTable = { }; end
		table.insert(injureTable, { part = gBodypartToBone[bodyPart], size = loss * 10 });
		setElementData(source, "injured", injureTable);
		setElementHealth(getLocalPlayer(), getElementHealth(getLocalPlayer())+loss/2)
		showTutorialMessage("blood_1", "Du wurdest verletzt und blutest nun für eine gewisse Zeit. Beachte, dass deine Gesundheit währenddessen sinkt.")
	end
end

addEventHandler("onClientElementDataChange", root,
	function (dataName)
		-- only synchronize when adding not when removing, as clients remove it themselves
		if(dataName == "injured") then
			if(not getElementData(source, "injured")) then
				gInjured[source] = nil;
			elseif(#gInjured < #getElementData(source, "injured")) then
				gInjured[source] = getElementData(source, "injured");
			end 
		end
	end
);

function addBloodEffectToAll()
	-- loop through players
	for player, table in next, gInjured do
		if getElementData(player, "isDead") == true then
			gInjured[player] = nil;
			setElementData(player, "injured", nil)
			break
		end
		for id, injurieInformation in next, table do
			local px, py, pz = getPedBonePosition(player, injurieInformation.part);
			if(px) and getElementData(player, "AFK") ~= true then
				-- if player is connected and not AFK create effect
				local wherex, wherey = getPointOnCircle(0.0, 0.0, 0.5, getPedRotation(player)-180.0);
				fxAddBlood(px, py, pz, wherex, wherey, 0.0, math.ceil(injurieInformation.size/100), 1.0);
				if(player == getLocalPlayer()) then
					setElementHealth(getLocalPlayer(), getElementHealth(getLocalPlayer())-0.05);
				end
			else
				-- remove the player as he is disconnected, remove him if you're first
				gInjured[player] = nil;
				if(getElementData(player, "injured")) then
					setElementData(player, "injured", nil);
				end
				break;
			end
			-- decrease bleeding if not afk
			if getElementData(player, "AFK") ~= true then
				injurieInformation.size = injurieInformation.size - 1;
			end
			-- if bleeding ended remove items
			if(injurieInformation.size <= 0) then
				gInjured[player][id] = nil;
				if(#table == 0) then
					-- if player hasn't got any injuries anymore, remove them, when localPlayer -> remove ElementData
					gInjured[player] = nil;
					if(player == getLocalPlayer()) then
						setElementData(player, "injured", gInjured[player]);
					end
				end
			end
		end
	end
end
setTimer(addBloodEffectToAll, 80, 0);


--[[------------------------------------------------------------------------||--
							(<---Event Handler--->)								
																				
--||------------------------------------------------------------------------]]--

addEvent("onClientPlayerDamageScript", true) --To make this also remotely callable
addEventHandler("onClientPlayerDamageScript", root, onPlayerGetsInjured);

addEventHandler("onClientPlayerDamage", root, onPlayerGetsInjured);

