--[[
Project: VitaOnline
File: root-server.lua
Author(s):	Golf_R32
			Sebihunter
			CubedDeath
]]--
theRPGPlayerSettings = {}

local playerNeedsTimer = nil
local immortalPedsTimer = nil

local advertText = {}

local playerInVehicle = {}

pLogger = {}
gJobTeams = {}

function onRPGResourceStart()
	for i=1, 200 do
	end
	createWater(703.381,1979.7365,3.8375, 723.381,1979.7365,3.8375,703.381,1999.7365,3.8375, 723.381,1999.7365,3.8375)
	for numb,play in ipairs(getElementsByType("player")) do
		setElementData(play, "isPlayerLoggedIn", false)
		getPlayerRegisteredSerial(play)
		setElementData(play, "getPlayerSpecialRights", 0)
		setElementData(play, "isTargetingAktiv",false)
		setElementData(play, "showMeTheGamingRules", false)
		setElementData(play, "pedIsDeadNowAnInHospital", false)
		setElementData(play, "fadeingTheActionMissionText", false)
		setElementData(play, "isBankIsAble",false)
		fadeCamera(play,true)
	end
		
	--Nutten für Rene
	local dancingNutten = {}
	ped = createInvinciblePed(152, 2384.8999023438, 1375.8000488281, 0.25) 
	setPedRotation(ped, 199.999984)
	setElementData(ped, "PedName", "Chantal Le Musche")
	setElementFrozen(ped,true)
	dancingNutten[#dancingNutten+1] = ped

	ped = createInvinciblePed(237, 2385, 1374.8000488281, 0.25) 
	setPedRotation(ped, 328.004577)
	setElementData(ped, "PedName", "Vicky Swallows")
	setElementFrozen(ped,true)
	dancingNutten[#dancingNutten+1] = ped

	ped = createInvinciblePed(138, 2385.5, 1382.6999511719, -0.15) 
	setPedRotation(ped, 220.004455)
	setElementData(ped, "PedName", "Jennifer Loveheart")
	setElementFrozen(ped,true)
	dancingNutten[#dancingNutten+1] = ped

	ped = createInvinciblePed(139, 2385.8999023438, 1378.6999511719, -0.15) 
	setPedRotation(ped, 280.004577)
	setElementData(ped, "PedName", "Ms. Blackbush")
	setElementFrozen(ped,true)
	dancingNutten[#dancingNutten+1] = ped
	
	ped = createInvinciblePed(87, 2389.8000488281, 1381.5, -0.15) 
	setPedRotation(ped, 160.004577)
	setElementData(ped, "PedName", "Natalie Anal")
	setElementFrozen(ped,true)
	dancingNutten[#dancingNutten+1] = ped	
	
	setTimer(function()
		for i,v in ipairs(dancingNutten) do
			if v and isElement(v) then
				if i == 1 then
					setPedAnimation( v, "STRIP", "STR_Loop_A", -1, true, false, false, false)
				elseif i == 2 then
					setPedAnimation( v, "STRIP", "STR_Loop_B", -1, true, false, false, false)
				elseif i == 3 then
					setPedAnimation( v, "STRIP", "STR_Loop_A", -1, true, false, false, false)
				elseif i == 4 then
					setPedAnimation( v, "STRIP", "STR_Loop_B", -1, true, false, false, false)		
				elseif i == 5 then
					setPedAnimation( v, "STRIP", "STR_Loop_A", -1, true, false, false, false)								
				end
			end
		end
	end,1000,0)	
	
	--Rest
	ped = createInvinciblePed (70,375.338, 325.949,1020.046, 180)
	setElementInterior(ped, 3)
	setElementDimension(ped, 0)
	setElementData(ped, "isSkinPed", true)
	setElementData(ped, "PedName", "Dr. Arthur Schnipp")
	setElementData(ped, "cinfo", {"Skinänderung"})
	
	ped = createInvinciblePed (168,2443.3000488281, 2401.6999511719, 12.10000038147,180)
	setElementData(ped, "isHotdogPed", true)
	setElementData(ped, "PedName", "Fred vom heißen Hund")
	
	
	ped = createInvinciblePed (168,380.883,-187.562,1000.632,90)
	setElementInterior(ped, 17)
	setElementDimension(ped, 2)
	setElementData(ped, "isDonutPed", true)
	setElementData(ped, "PedName", "Mr. Blackbush")
	
	ped = createInvinciblePed (168,380.883,-187.562,1000.632,90)
	setElementInterior(ped, 17)
	setElementDimension(ped, 1)
	setElementData(ped, "isDonutPed", true)
	setElementData(ped, "PedName", "Bobim Brown")	
	
	ped = createInvinciblePed (168,380.883,-187.562,1000.632,90)
	setElementInterior(ped, 17)
	setElementDimension(ped, 3)
	setElementData(ped, "isDonutPed", true)
	setElementData(ped, "PedName", "Herr Mohrenkopf")		
	
	ped = createInvinciblePed(197, 251.71875, -54.470703125, 1.5776442289352 , 0 )
	setPedRotation(ped, 191.54679870605)
	setElementData(ped, "isShopPed", true)
	setElementData(ped, "PedName", "Tante Emma")
	setElementData(ped, "cinfo", {"Einkaufen"})
	
	
	ped = createInvinciblePed(141, 311.2222,79.3356,1019.2393 , 270) 
	setElementInterior(ped, 3)
	setElementData(ped, "PedName", "Amtsrätin Hannah Greiser")
	setElementData(ped, "isStaatPed", true)
	setElementData(ped, "cinfo", {"Ansprechen"})


	ped = createInvinciblePed(164, 318.38,94.90,1019.23 , 180) 
	setElementInterior(ped, 3)
	setElementData(ped, "PedName", "Security Arnold Jäger")
	giveWeapon(ped, 3,30,true)

	ped = createInvinciblePed(166, 323.641,73.264,1019.2327 , 0) 
	setElementInterior(ped, 3)
	setElementData(ped, "PedName", "Security Umbabwe Black")
	giveWeapon(ped, 3,30,true)

	
	ped = createInvinciblePed(168, 1046.7, 2375.6001, 10.8, 270  )
	setElementData(ped, "isFFPed", true)
	setElementData(ped, "PedName", "Borin Juracic")
	setElementData(ped, "cinfo", {"Einkaufen"})	
	
	ped = createInvinciblePed(0, -105.900,-8.9124,1000.7, 180 )
	setElementInterior(ped, 3)
	addPedClothes(ped, "gimpleg", "gimpleg", 17)
	setElementData(ped, "isSexPed", true)
	setElementData(ped, "PedName", "Dreckiger Dan")
	setElementData(ped, "cinfo", {"Einkaufen"})			

	ped = createInvinciblePed(0, 2399.6999511719, 1390.1999511719, -0.15000000596046, 90.0041198 )
	setPedStat ( ped, 21, 1000 )	
	addPedClothes(ped, "gimpleg", "gimpleg", 17)
	setElementData(ped, "isAdminPed", true)
	setElementData(ped, "PedName", "Ganz Dreckiger Dan")
	setElementData(ped, "cinfo", {"Einkaufen"})		
	
	ped = createInvinciblePed(127, 244.60546875, -55.333984375, 1.5776442289352, 0 )
	setPedRotation(ped, 357.3)
	setElementData(ped, "isGangWeaponPed", true)
	setElementData(ped, "PedName", "Hinterzimmer Joe")
	setElementData(ped, "cinfo", {"Mit Joe sprechen"})
	for dim = 100,122 do
		ped = createInvinciblePed(11, -27.5849609375, -91.7783203125, 1003.546875, 0 )
		setElementInterior(ped, 18)
		setElementDimension(ped, dim)
		setElementData(ped, "isShopPed", true)
		setElementData(ped, "PedName", "Verkäuferin")
		setElementData(ped, "cinfo", {"Einkaufen"})
	end
	for dim = 130,146 do
		ped = createInvinciblePed(11, -30.716796875, -30.95703125, 1003.5572509766, 353.82833862305  )
		setElementInterior(ped, 4)
		setElementDimension(ped, dim)
		setElementData(ped, "isShopPed", true)
		setElementData(ped, "PedName", "Verkäuferin")
		setElementData(ped, "cinfo", {"Einkaufen"})
	end

	-- Logger
	pLogger["autobestellung"] = Logger.create("logs/autobestellung.log")
	pLogger["hauserstellung"] = Logger.create("logs/hauserstellung.log")
	pLogger["einsperren"] = Logger.create("logs/einsperren.log")
	pLogger["kill"] = Logger.create("logs/kill.log")
	pLogger["abschlepper"] = Logger.create("logs/abschlepper.log")
	pLogger["autoverkauf"] = Logger.create("logs/autoverkauf.log")
	pLogger["items"] = Logger.create("logs/items.log")
	pLogger["konten"] = Logger.create("logs/konten.log")
	pLogger["geld"] = Logger.create("logs/geld.log")
	pLogger["verwarung"] = Logger.create("logs/verwarung.log")
	pLogger["chat_normal"] = Logger.create("logs/chat_normal.log")
	pLogger["chat_ooc"] = Logger.create("logs/chat_occ.log")
	pLogger["chat_news"] = Logger.create("logs/chat_news.log")
	pLogger["megaphone"] = Logger.create("logs/megaphone.log")
	pLogger["chat_funk"] = Logger.create("logs/chat_funk.log")
	pLogger["afk"] = Logger.create("logs/afk.log")
	pLogger["rechnungen"] = Logger.create("logs/rechnungen.log")
	
	playerNeedsTimer = setTimer(BeduerfnisTimer, 1000, 0)
	playerDienstTimer = setTimer(DienstTimer, 60000, 0)
	checkRealTime = setTimer(checkRealTime, 1000, 0)
	createAccidentTimer = setTimer(createAccident, math.random(1,3)*1000*60, 1)
	createTreeJobTimer = setTimer(createTreeJob,math.random(1,3)*1000*60, 1)
	createFireJobTimer = setTimer(createFireJob,math.random(3,6)*1000*60, 1)

	setFPSLimit(48)
	initJobs()
	initGangs()
	print("__~~******************~~__")
	print("__~~****VitaOnline*Started***~~__")
	print("__~~******************~~__")
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()),onRPGResourceStart)

function checkRealTime()
	local realtime = getRealTime()
	local second = realtime.second
	local hours = realtime.hour
	local minutes = realtime.minute
	
	if mysql_ping ( g_mysql["connection"] ) == false then
		onResourceStopMysqlEnd()
		onResourceStartMysqlConnection()
	end	
	
	--GamemodeRestart
	if second == 0 and hours == 3 and minutes > 50 then
		outputChatBox ( "#FF0000Automatischer Gamemode-Restart um #00FF0004:00", getRootElement(), 255, 255, 255, true )
	end
	if second == 0 and hours == 4 and minutes == 0 then
		restartResource ( getThisResource ( ) )
	end
	
	--PayDay
	if second == 0 and hours == 18 and minutes == 0 or paytest == true then
		local visteuer = 0
		for i,v in ipairs(getElementsByType("vehicle")) do
			local tp = getElementData(v, "tuevpreis")
			if tp then
				setElementData(v, "tuevpreis", tp+25)
			end
		end
		
		paytest = false
		local result = mysql_query(g_mysql["connection"], "SELECT * FROM `users` ORDER BY `id` ASC")
		if result then
			outputChatBox(".:[Zahltag]:.", getRootElement(), 125,125,255)
			outputChatBox(".:Es kann zu einem kurzen Network Trouble kommen:.", getRootElement(), 125,125,255)
			while true do
				local row = mysql_fetch_assoc(result)
				if not row then break end
				name = row["name"]
				local ply = getPlayerFromName(name)
				if ply then
					local acc = getBankAccount(name)
					if acc and hasPlayerBankAccess(ply, acc) then
						if getElementData(ply, "job") ~= 0 then
							if getElementData(ply, "gehalt") == false then setElementData(ply, "gehalt", 0) end
							if getElementData(ply, "dienstzeit") == false then setElementData(ply, "dienstzeit", 0) end
							local gehalt = tonumber(getElementData(ply, "gehalt"))*tonumber(getElementData(ply, "dienstzeit"))
							if gehalt ~= 0 then
								local firmenkonto = getBankAccount(getJobBankName(getElementData(ply, "job")))
								if firmenkonto.geld < gehalt then
									outputChatBox("Du hast kein Gehalt bekommen, da dein Arbeitgeber nicht genug Geld hat.", ply, 125,125,125)
									callClientFunction(ply, "playSound", "sounds/fail.mp3")								
								else
									if gehalt >= 100 then
										visteuer = visteuer + 100
										gehalt = gehalt - 100
									end
									systemTransfer(firmenkonto, acc, gehalt, "Gehalt", false, false, true)
									outputChatBox("Gehalt: "..tostring(gehalt).." Vero.", ply, 125,125,125)
									callClientFunction(ply, "playSound", "sounds/win.ogg")
								end
							else
								outputChatBox("Du hast kein Gehalt bekommen.", ply, 125,125,125)
								callClientFunction(ply, "playSound", "sounds/fail.mp3")
							end
						else
							--systemDeposit(acc, 500, "Arbeitslosengeld", true)
							--outputChatBox("Arbeitslosengeld: 500 Vero.", ply, 125,125,125)
							--callClientFunction(ply, "playSound", "sounds/win.ogg")
							outputChatBox("Du bekommst kein Gehalt, da du nicht in einer Fraktion bist.", ply, 125,125,125)
							callClientFunction(ply, "playSound", "sounds/fail.mp3")
						end
						setElementData(ply, "dienstzeit", 0)
						setElementData(ply, "einnahmen", 0)
					else
						outputChatBox("Du besitzt kein Konto, daher fällt dein PayDay aus.", ply, 125,125,125)
						callClientFunction(ply, "playSound", "sounds/fail.mp3")
					end
				else
					local acc = getBankAccount(name)
					local gehalt = row["gehalt"]
					local dienstzeit = row["dienstzeit"]
					if not gehalt then gehalt = 0 end
					if not dienstzeit then dienstzeit = 0 end
					gehalt = tonumber(gehalt)*tonumber(dienstzeit)
					local job = row["job"]
					if acc then
						if tonumber(job) ~= 0 then
							if gehalt ~= 0 then
								visteuer = visteuer + math.ceil(gehalt*0.05)
								gehalt = math.ceil(gehalt*1.95)
								local firmenkonto = getBankAccount(getJobBankName(tonumber(job)))
								if firmenkonto.geld > gehalt then
									systemTransfer(firmenkonto, acc, gehalt, "Gehalt", false, false, true)
								end
							end
						else
							--systemDeposit(acc, 500, "Arbeitslosengeld", true)
						end
					end				
				end
			end
			mysql_free_result(result)					
		end
		systemDeposit("Reporter", visteuer, "Steuer")
		local sql = "UPDATE `users` SET `dienstzeit` = '0', `einnahmen` = '0';"
		local daquery = mysql_query(g_mysql["connection"], sql)
		if daquery then mysql_free_result(daquery) end
		sql = nil	
	end
	
	--Gangauszahlung
	if second == 0 and hours == 20 and minutes == 15 then
		local tempGangData = {}
		for gangZone = 0, #gGangZoneData do
			local zoneOwner = getElementData(gGangZones[gangZone],"gangZoneOwner")
			if zoneOwner ~= 0 then
				if gGangData[zoneOwner] then
					if gGangData[zoneOwner].name then
						if not tempGangData[tostring(gGangData[zoneOwner].name)] then tempGangData[tostring(gGangData[zoneOwner].name)]  = 0 end
						tempGangData[tostring(gGangData[zoneOwner].name)]  = tempGangData[tostring(gGangData[zoneOwner].name)] + 500
					end
				end
			end
		end	
		for i,v in pairs(tempGangData) do
			local acc = getBankAccount(i)
			systemDeposit(acc, v, "Gangzones", true)
		end
	end
	
	--Miete
	if second == 0 and hours == 20 and minutes == 0 and weekday == 5 then
		for _, house in ipairs(getElementsByType("pickup")) do
			if getElementData(house, "owner") == "SASO" then
				local acc = getBankAccount(getElementData(house, "keys"))
				if acc then
					systemTransfer(acc, getBankAccount(getJobBankName(6)), tonumber(getElementData(house, "miete")), "Miete", false, false, true)
					local ply = getPlayerFromName(getElementData(house, "keys"))
					if ply then
						outputChatBox(".:[Wöchentliche Abrechnung]:.", ply, 125,125,255)
						outputChatBox("Miete abgebucht: "..tostring(getElementData(house, "miete")).." Vero.", ply, 125,125,125)
					end
				end
			end
		end
	end
end

function onRPGPlayerJoin()
	addAcceptCommand(source, "auftrag")
	setElementData(source, "isPlayerLoggedIn", false)
	getPlayerRegisteredSerial(source)
	setElementData(source, "getPlayerSpecialRights", 0)
	fadeCamera(source,true)
end
addEventHandler("onPlayerJoin", getRootElement(), onRPGPlayerJoin)

function onRPGPlayerQuit(type,reason,element, player)
	if reason == "Restart" then source = player end
	setTimer(updatePlayerDuty, 60*1000*10, 1, getPlayerName(source))
	if getElementData(source,"playerRegisterStatus") == false then
		removeElementData(source, "playerRegisterStatus")
	end
	
	for i,v in ipairs(getElementsByType("support")) do
		if getElementData(v, "name") == getPlayerName(source) then
			destroyElement(v)
			break
		end
	end	
	if getElementData(source, "isPlayerLoggedIn") == true then
		if isPlayerPhoning(source) == true or isPlayerBeingCalled(source) == true then 
			stopPhoning(source)
		end
		outputChatBox(getPlayerName(source).." hat den Server verlassen! ("..type..")", getRootElement(),255,100,0)
		if cabinMoney and cabinMoney[source] then systemDeposit("Polizei", cabinMoney[source]) cabinMoney[source] = 0 end
		if tonumber(getElementData(source, "whichHospitalBed")) then
			if getElementData(rpgHospitalPostitionsElement[getElementData(source, "whichHospitalBed")], "isHospitalBedUsed") == true then 
				setElementData(rpgHospitalPostitionsElement[getElementData(source, "whichHospitalBed")], "isHospitalBedUsed",false)
			end
		end
	end
	
	savePlayer(source)
end
addEventHandler("onPlayerQuit", getRootElement(), onRPGPlayerQuit)

function savePlayer(player)
	outputDebugString("Saving Player "..getPlayerName(player))
	source = player
	if getElementData(source, "isPlayerLoggedIn") ~= true then return end 
	
	if mysql_ping ( g_mysql["connection"] ) == false then
		onResourceStopMysqlEnd()
		onResourceStartMysqlConnection()
	end	
	local name = getPlayerName(source)
	
	local query = mysql_query(g_mysql["connection"],"SELECT * FROM users WHERE name = '"..name.."';")
	if query and mysql_num_rows(query) > 0 then
		if tonumber(getElementData(source, "playerRegisterStatus")) == 1 or tonumber(getElementData(source, "playerRegisterStatus")) == 2 then
			local dim = getElementDimension(source)
			local int = getElementInterior(source)
			local x,y,z = getElementPosition(source)
			local cash = getPlayerMoneyEx(source)
			local armor = getPedArmor(source)
			local health = getElementHealth(source)
			
			local newitems = {}
			for i,v in pairs(getElementData(source,"items")) do
				if v ~= false and v ~= nil then
					newitems[#newitems+1] = v
				end
			end
			
			local sql = "UPDATE `users` SET `x` = '"..x.."',\
										`y` = '"..y.."',\
										`z` = '"..z.."',\
										`dimension` = '"..dim.."',\
										`interior` = '"..int.."',\
										`geld` = '"..cash.."',\
										`armour` = '"..armor.."',\
										`serial` = '"..getPlayerSerial(source).."',\
										`health` = '"..health.."',\
										`skin` = '"..tostring(getElementData(source, "skin")).."',\
										`energie` = '"..tostring(getElementData(source,"getPlayerEnergie")).."',\
										`hunger` = '"..tostring(getElementData(source,"getPlayerHunger")).."',\
										`harndrang` = '"..tostring(getElementData(source,"getPlayerHarndrang")).."',\
										`hygiene` = '"..tostring(getElementData(source,"getPlayerHygiene")).."',\
										`job` = '"..tostring(getElementData(source,"job")).."',\
										`rank` = '"..tostring(getElementData(source,"rank")).."',\
										`gang` = '"..tostring(getElementData(source,"gang")).."',\
										`gangrank` = '"..tostring(getElementData(source,"gangrank")).."',\
										`dienst` = '"..tostring(getElementData(source,"dienst")).."',\
										`aschein` = '"..tostring(getElementData(source,"aschein")).."',\
										`mschein` = '"..tostring(getElementData(source,"mschein")).."',\
										`fschein` = '"..tostring(getElementData(source,"fschein")).."',\
										`bschein` = '"..tostring(getElementData(source,"bschein")).."',\
										`wschein` = '"..tostring(getElementData(source,"wschein")).."',\
										`pif` = '"..tostring(getElementData(source,"pif")).."',\
										`einsperrzeit` = '"..tostring(getElementData(source,"einsperrzeit")).."',\
										`items` = '"..tostring(toJSON(newitems or {})).."',\
										`gehalt` = '"..tostring(getElementData(source,"gehalt")).."',\
										`einnahmen` = '"..tostring(getElementData(source,"einnahmen")).."',\
										`einnahmen2` = '"..tostring(getElementData(source,"einnahmen2")).."',\
										`dienstzeit` = '"..tostring(getElementData(source,"dienstzeit")).."',\
										`promille` = '"..tostring(getElementData(source,"promille")).."',\
										`promillesoll` = '"..tostring(getElementData(source,"promillesoll")).."',\
										`isDead` = '"..tostring(getElementData(source,"isDead")).."',\
										`time` = '"..getElementData(source, "playerWaitingAproval").."',\
										`cooldown` = '"..tostring(getElementData(source,"cooldown")).."',\
										`btime` = '"..tostring(getElementData(source,"btime")).."',\
										`exp` = '"..tostring(getElementData(source,"exp")).."',\
										`level` = '"..tostring(getElementData(source,"level")).."',\
										`panote` = '"..tostring(getElementData(source,"panote")).."',\
										`invehicle` = '"..tostring(isPedInVehicle(source)).."'\
										WHERE `name` = '"..name.."';"
			mysql_query(g_mysql["connection"], sql)			
			sql = nil
			
			if isPedInVehicle(source) then
				local seatid = getPedOccupiedVehicleSeat(source)		
				for d,veh in ipairs(getElementsByType("vehicle")) do
					if getPedOccupiedVehicle(source) == veh then
						sql = "UPDATE `users` SET `currentveh` = '"..tostring(d).."',\
							SET `seat` = '"..tostring(seatid).."'\
							WHERE `name` = '"..name.."';"
						mysql_query(g_mysql["connection"], sql)		
					end
				end
			end
		end
	end
	mysql_free_result(query)
end

function updatePlayerDuty(name)
	if mysql_ping ( g_mysql["connection"] ) == false then
		onResourceStopMysqlEnd()
		onResourceStartMysqlConnection()
	end	
	if getPlayerFromName(name) ~= false then print("fail") return end
	
	local query = mysql_query(g_mysql["connection"],"SELECT * FROM users WHERE name = '"..name.."';")
	if query and mysql_num_rows(query) > 0 then
		local sql = "UPDATE `users` SET `dienst` = '0'\
												WHERE `name` = '"..name.."';"
		mysql_query(g_mysql["connection"], sql)
		sql = nil
	end
	mysql_free_result(query)	
end

function getPlayerRegisteredSerial(source)
	if isElement(source) then	
		if mysql_ping ( g_mysql["connection"] ) == false then
			onResourceStopMysqlEnd()
			onResourceStartMysqlConnection()
		end	
		local query = mysql_query(g_mysql["connection"],"SELECT * FROM `users` WHERE `serial` = '"..getPlayerSerial ( source ).."';")
		if query and mysql_num_rows(query) > 0 then
			local row = mysql_fetch_assoc(query)
			setElementData(source, "isAlreadyRegistered", true)
		end
		mysql_free_result(query)
	end
end

function getPlayerRegisterStatus(source)
	if isElement(source) then	
		if mysql_ping ( g_mysql["connection"] ) == false then
			onResourceStopMysqlEnd()
			onResourceStartMysqlConnection()
		end	
		local name = getPlayerName(source)
		local query = mysql_query(g_mysql["connection"],"SELECT * FROM `users` WHERE `name` = '"..name.."';")
		if query and mysql_num_rows(query) > 0 then
			local row = mysql_fetch_assoc(query)
			setElementData(source, "playerRegisterStatus", row["aktivated"])
			setElementData(source, "skin", row["skin"])
		end
		mysql_free_result(query)
	end
end

function onRPGResourceStop()
	for i,e in ipairs(getElementsByType("player")) do
		if e then
			onRPGPlayerQuit("GameMode Restart!", "Restart", nil, e)
			fadeCamera(e,false)
		end
	end
	if isTimer(playerNeedsTimer) then killTimer(playerNeedsTimer) end
	if isTimer(immortalPedsTimer) then killTimer(immortalPedsTimer) end
end
addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), onRPGResourceStop)



addEvent("onPlayerRPGLogin", false)
addEvent("loginRPGPlayerToServer", true)
function loginRPGPlayer(player, vorname,nachname,pw)
	if isElement(player) then
		if string.match(vorname,"[%A-Z]") and string.match(vorname,"[%A-Z]") ~= "Z" or string.match(nachname,"[%A-Z]") and string.match(nachname,"[%A-Z]") ~= "Z" then
			triggerClientEvent ( player, "addNotification", getRootElement(),  1, 255, 0, 0, "Dein Name enthält ungültige Zeichen." )
			return
		end
		for i,v in ipairs(getElementsByType("player")) do
			if string.lower(getPlayerName(v)) == string.lower(vorname.."."..nachname) and v ~=player and getElementData(v, "isPlayerLoggedIn") == true then
				triggerClientEvent ( player, "addNotification", getRootElement(),  1, 255, 0, 0, "Es ist bereits jemand mit diesem Namen eingeloggt." )
				return
			end
		end
		vorname = string.gsub(vorname, "(%a)([%w_']*)", titleCase)
		nachname = string.gsub(nachname, "(%a)([%w_']*)", titleCase)
		local password = getPlayerUserFileData(vorname.."."..nachname, "passwort")
		local name = getPlayerUserFileData(vorname.."."..nachname, "name")
		if name then
			setPlayerName(player,name)
		end
		getPlayerRegisterStatus(player)
		local password = getPlayerUserFileData(vorname.."."..nachname, "passwort")
		if password and password == md5(pw) then
			local status = tonumber(getElementData(player, "playerRegisterStatus"))
			if status == 0 then
				triggerClientEvent ( player, "addNotification", getRootElement(),  1, 255, 0, 0, "Dein Account wurde deaktiviert." )
				return				
		--	if status == 1 then -- Tutorial
		--		triggerClientEvent("startTutorial", player, player, pw, tonumber(getElementData(player,"skin"))) -- tutorial muss erst abgeschlossen werden
		--		fadeCamera(player,false)
		--	elseif status == 2 then -- Freigeschaltet
			else
				successLoginPlayer(player)
				triggerEvent("onPlayerRPGLogin", player)
			end
		else
			triggerClientEvent ( player, "addNotification", getRootElement(),  1, 255, 0, 0, "Account wurde nicht gefunden\noder das Passwort falsch." )
		end
	end
end
addEventHandler("loginRPGPlayerToServer", getRootElement(),loginRPGPlayer)


function successLoginPlayer(player)
	if isElement(player) and getElementData(player, "isPlayerLoggedIn") == false then
		setElementData(player, "isPlayerLoggedIn", "logginin")
				local name = getPlayerName(player)
				local x
				local y
				local z
				local int
				local dim
				
				if mysql_ping ( g_mysql["connection"] ) == false then
					onResourceStopMysqlEnd()
					onResourceStartMysqlConnection()
				end	
				local query = mysql_query(g_mysql["connection"],"SELECT * FROM users WHERE name = '"..name.."';")
				if query and mysql_num_rows(query) > 0 then	
					local row = mysql_fetch_assoc(query)
					triggerClientEvent ( player, "addNotification", getRootElement(),  1, 0, 255, 0, "Erfolgreich eingeloggt." )
					triggerClientEvent ( player, "loginComplete", getRootElement() )
					setCameraTarget(player,player)
					setPlayerUserFileData(name, "serial", tostring(getPlayerSerial(player)))
					x = row["x"]
					y = row["y"]
					z = row["z"]
					int = row["interior"]
					dim = row["dimension"]
					arresttime = row["time"]
					setElementData(player, "playerWaitingAproval", arresttime)
					local skin = row["skin"]
					local energy = row["energie"]
					local geld = row["geld"]
					local pif = row["pif"]
					local hungry = row["hunger"]
					local pee = row["harndrang"]
					local hygiene = row["hygiene"]
					local health = row["health"]
					local armour = row["armour"]
					local bank = row["bank"]
					local job = row["job"]
					local rank = row["rank"]
					local gang = row["gang"]
					local gangrank = row["gangrank"]			
					local dienst = row["dienst"]
					local geb = row["geb"]
					local geschlecht = row["geschlecht"]
					local admin = row["admin"]
					local einsperrzeit = row["einsperrzeit"]
					local gehalt = row["gehalt"]
					local promille = row["promille"]
					local promillesoll = row["promillesoll"]
					local cooldown = row["cooldown"]
					local btime = row["btime"]
					local xp = row["exp"]
					local level = row["level"]
					local panote = row["panote"]
					
							
					if promille == false or promille == nil then
						promille = 0
					end
					setElementData(player, "promille", tonumber(promille))
							
					if promillesoll == false or promillesoll == nil then
						promillesoll = 0
					end
					setElementData(player, "promillesoll", tonumber(promillesoll))
					
														
					local dienstzeit = row["dienstzeit"]
					local einnahmen = row["einnahmen"]			
					local einnahmen2 = row["einnahmen2"]			
					local dead = row["isDead"]						
					if dead and dead == "true" or dead == true then
						setElementData(player, "isDead", true)
					else
						setElementData(player, "isDead", false)
					end
							
					local seatid = row["seat"]
					playerInVehicle[player] = row["invehicle"]
							
					if row["aschein"] == "true" or row["aschein"] == "1" then
						setElementData(player, "aschein", true) else setElementData(player, "aschein", false) end
					if row["mschein"] == "true" or row["mschein"] == "1" then
						setElementData(player, "mschein", true) else setElementData(player, "mschein", false) end
					if row["fschein"] == "true" or row["fschein"] == "1" then
						setElementData(player, "fschein", true) else setElementData(player, "fschein", false) end
					if row["bschein"] == "true" or row["bschein"] == "1" then
						setElementData(player, "bschein", true) else setElementData(player, "bschein", false) end		
					if row["wschein"] == nil or row["wschein"] == false or row["wschein"] == "false" or row["wschein"] == "nil" or row["wschein"] == "0" then
						setElementData(player, "wschein", 0)
					else
						setElementData(player, "wschein", tonumber(row["wschein"]))
					end
					setElementData(player, "items", "")
							
					if row["items"] == "0" then
						setElementData(player, "items", { [1] = { itemid = 2 } }) 
					else setElementData(player, "items", fromJSON(row["items"])) end
					local items = getElementData(player, "items")
					local itemn = {}

					for k, v in pairs(items) do
						itemn[tonumber(k)] = v
						items[k] = nil
					end
					setElementData(player, "level", tonumber(level))		
					setElementData(player, "exp", tonumber(xp))
					setElementData(player, "panote", tonumber(panote))
					
					setElementData(player, "items", itemn)
					setPlayerMoneyEx(player, tonumber(geld))
					if gehalt then
						setElementData(player, "gehalt", tonumber(gehalt))
					else 
						setElementData(player, "gehalt", 0)
					end		
					if einnahmen then
						setElementData(player, "einnahmen", tonumber(einnahmen))
					else 
						setElementData(player, "einnahmen", 0)
					end			
					if einnahmen2 then
						setElementData(player, "einnahmen2", tonumber(einnahmen2))
					else 
						setElementData(player, "einnahmen2", 0)
					end								
					if dienstzeit then
						setElementData(player, "dienstzeit", tonumber(dienstzeit))
					else 
						setElementData(player, "dienstzeit", 0)
					end								
					if einsperrzeit then
						setElementData(player, "einsperrzeit", tonumber(einsperrzeit))
						if einsperrzeit ~= "0" then
							toggleControl( player, "fire", false)
							toggleControl( player, "enter_exit", false)
							toggleControl( player, "aim_weapon", false)
						end
					else 
						setElementData(player, "einsperrzeit", 0)
					end
					setElementData(player, "pif", tonumber(pif))
					setElementData(player, "getMyBankAmount", tonumber(bank))
					setElementData(player, "getPlayerEnergie", tonumber(energy))
					setElementData(player, "getPlayerHunger", tonumber(hungry))
					setElementData(player, "getPlayerHarndrang", tonumber(pee))
					setElementData(player, "getPlayerHygiene", tonumber(hygiene))
					setElementData(player, "job", tonumber(job))
					setPlayerTeam(player, gJobTeams[tonumber(job)])
					if tonumber(job) == 3 or tonumber(job) == 4 or tonumber(job) == 7 then
						addAcceptCommand(player, "auftrag", acceptRequest)
					end
					setElementData(player, "rank", tonumber(rank))
					setElementData(player, "dienst", tonumber(dienst))
					if tonumber(gang) == nil or tonumber(gang) == false then
						setElementData(player, "gang", 0)
						setElementData(player, "gangrank", 0)							
					else
						setElementData(player, "gang", tonumber(gang))
						setElementData(player, "gangrank", tonumber(gangrank))
					end
					setElementData(player, "btime", tonumber(btime))
					if tonumber(btime) ~= 0 then
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
						end,60000,tonumber(btime),player)
					end
					setElementData(player, "cooldown", tonumber(cooldown))
					setElementData(player, "skin", tonumber(skin))
					setElementData(player, "geb", tostring(geb))
					setElementData(player, "phoneState", 0)
				
					setElementData(player, "geschlecht", tostring(geschlecht))
					setElementData(player, "getPlayerSpecialRights", tonumber(admin))
					setElementData(player,"amBeduerfnisseAufladen", false)
							
					if tonumber(dienst) == 0 then
						spawnPlayer ( player ,tonumber(x),tonumber(y),tonumber(z),0,tonumber(skin),tonumber(int),tonumber(dim))
						outputChatBox(getPlayerName(player).." hat den Server betreten!", getRootElement(),255,100,0)
						setPlayerBlurLevel(player,0)
						setPedStat ( player, 229, 999 )
						
						if playerInVehicle[player] == "true" then
							for i,veh in ipairs(getElementsByType("vehicle")) do
								if getElementData(veh,"owner") == getPlayerName(player) then
									if tonumber(row["currentveh"]) == i then
										warpPedIntoVehicle ( player, veh, tonumber(seatid) )
										break
									end
								end
							end
						end
					else
						outputChatBox(getPlayerName(player).." hat den Server betreten und beginnt seinen Dienst als "..gJobData[tonumber(job)].name.."!", getRootElement(),255,100,0)
						spawnPlayer ( player ,tonumber(x),tonumber(y),tonumber(z),0,gJobData[tonumber(job)].skin0,tonumber(int),tonumber(dim))
						if getElementData(player, "rank") == 0 then
							setElementModel ( player, gJobData[tonumber(job)].skin0 )
						elseif getElementData(player, "rank") == 1 then
							setElementModel ( player, gJobData[tonumber(job)].skin1 )
						elseif getElementData(player, "rank") == 2 then
							setElementModel ( player, gJobData[tonumber(job)].skin2 )
						end
						setPlayerBlurLevel(player,0)
						setPedStat ( player, 229, 999 )
						if playerInVehicle[player] == "true" then
							for i,veh in ipairs(getElementsByType("vehicle")) do
								if getElementData(veh,"owner") == getPlayerName(player) then
									if tonumber(row["currentveh"]) == i then
										warpPedIntoVehicle ( player, veh, tonumber(seatid) )
										break
									end
								end
							end
						end
					end
					local privv = false
					local frakv = false
					local gangv = false
					for _, vehicle in ipairs(getElementsByType("fakeVehicle")) do
						if getElementData ( vehicle, "owner" ) == getPlayerName(player) and privv == false  then
							privv = true
							triggerClientEvent ( player, "showTutorialMessage", getRootElement(), "join_verw", "Eines deiner privaten Fahrzeuge befindet sich in der Verwahrungsstelle an der Fahrschule Las Venturas.", false, true )
						elseif tostring(getElementData(vehicle, "owner")) == tostring(getElementData(player, "job")) and getElementData(player, "rank") == 2 and frakv == false then
							frakv = true
							triggerClientEvent ( player, "showTutorialMessage", getRootElement(), "join_verw", "Eines deiner Firmenfahrzeuge befindet sich in der Verwahrungsstelle an der Fahrschule Las Venturas.", false, true )		
						elseif tostring(getElementData(vehicle, "owner")) == "g"..tostring(getElementData(player, "gang")) and getElementData(player, "gangrank") == 2 and gangv == false then
							gangv = true
							triggerClientEvent ( player, "showTutorialMessage", getRootElement(), "join_verw", "Eines deiner Gangfahrzeuge befindet sich in der Verwahrungsstelle an der Fahrschule Las Venturas.", false, true )										
						end
					end					
					print("VitaOnline: "..getPlayerName(player).." joined the game ( Skin:"..tonumber(skin).." )")
					setPedArmor(player, armour)
					setElementHealth(player,health)
					setTimer(fadeCamera,500,1,player,true)
					setElementData(player, "isPlayerLoggedIn",true)
					showChat(player,true)
					setElementAlpha(player,255)
					setCameraTarget(player,player)
					setElementData(player, "isTargetingAktiv", false)
					
					--Bike Stat
					setPedStat(player, 230, 0)
					
					local time = getRealTime()
					local tag, monat, jahr, hour, minute = time.monthday,time.month,time.year , time.hour, time.minute
					setPlayerUserFileData(name, "laston", tostring(tag.."."..(tonumber(monat)+1).."."..(jahr+1900).." "..hour..":"..minute))
					
					local source = player
					setElementData(player, "pedIsDeadNowAnInHospital", false)
					for i=70,81 do
						setPedStat(player, i, 999)
					end
					bed_Reaktion1[source] = "false"
					bed_Reaktion2[source] = "false"
					bed_Reaktion3[source] = "false"
					bed_Reaktion4[source] = "false"
					
					for i,v in ipairs(getElementsByType("wanted")) do
						if string.lower(getElementData(v, "name")) == string.lower(getPlayerName(player)) then
							setElementData(player, "akte", v)
							break
						end
					end
					
					mysql_free_result(query)
					
					if not isKeyBound ( player,"o","down", toggleAdminPanel ) then
						bindKey(player,"o","down", toggleAdminPanel)
					end
					bindKey ( player, "backspace", "down", aufwachen, player )
					bindKey ( player, "num_8", "down", lightFunc, player ) 
					bindKey ( player, "num_9", "down", fernlichtFunc, player ) 
					bindKey ( player, "num_7", "down", detachVehicle, player ) 
					bindKey ( player, "num_3", "down", lockVehicle, player )
					bindKey ( player, "f", "down", useHausToilette, player )
					bindKey ( player, "f", "down", useHausBad, player )
					bindKey  (player, "f", "down", pickUpItemKey, player )
					bindKey  (player, "f", "down", pickUpHanf, player )
					bindKey ( player, "f", "down", useHausExit, player )
					setElementData(source, "isWaitingForDeath", false)
					if getElementData(player, "isDead") == true then
						killPed(player)
					end
					
					for i,v in ipairs(getElementsByType("pickup")) do
						if getElementData(v, "intType") == 1 then
							if (isOwner(player, getElementData(v, "keys")) and getElementData(v, "owner") == "SASO") or isOwner(player, getElementData(v, "owner")) then
								setElementData(player, "lastjoin", getRealTime().timestamp)
							end
						end
					end
				end
			end
end


addEvent("checkIfNameIsUsedInServer",true)
addEventHandler("checkIfNameIsUsedInServer", getRootElement(),
	function(name)
		local nameavailable = false
		if mysql_ping ( g_mysql["connection"] ) == false then
			onResourceStopMysqlEnd()
			onResourceStartMysqlConnection()
		end

		
		local time = getRealTime()
		local query = mysql_query(g_mysql["connection"],"SELECT * FROM users WHERE name = '"..name.."';")
		if mysql_num_rows(query) > 0 then
			nameavailable = true
		end
		local squery = mysql_query(g_mysql["connection"],"SELECT * FROM users WHERE serial = '"..getPlayerSerial(source).."';")
		if mysql_num_rows(squery) > 0 then
			nameavailable = true
		end	
		
		local invalidChars = {}
		for i = 32, 45 do
			invalidChars[i] = true
		end
		for i = 47, 64 do
			invalidChars[i] = true
		end		
		for i = 91, 96 do
			invalidChars[i] = true
		end

		for i = 123, 126 do
			invalidChars[i] = true
		end
			
		for i, index in pairs ( invalidChars ) do
			if not gettok ( name, 1, i ) or gettok ( name, 1, i ) ~= name then
				nameavailable = true
			end
		end
	
		triggerClientEvent("setPlayerInTutorial", source, nameavailable)
		
		mysql_free_result(squery)
		mysql_free_result(query)

	end
)


addEvent("registerRPGPlayerToServer",true)
function registerRPGPlayer(vorname,nachname,pass,geschlecht,skin,geburt, mail)
	if mysql_ping ( g_mysql["connection"] ) == false then
		onResourceStopMysqlEnd()
		onResourceStartMysqlConnection()
	end
	
	if string.match(vorname,"[%A-Z]") and string.match(vorname,"[%A-Z]") ~= "Z" or string.match(nachname,"[%A-Z]") and string.match(nachname,"[%A-Z]") ~= "Z" then
		triggerClientEvent ( source, "addNotification", getRootElement(),  1, 255, 0, 0, "Dein Name enthält ungültige Zeichen\nErlaubt:A-Z, nur 1. Buchstabe darf groß sein" )
		return
	end
	vorname = string.gsub(vorname, "(%a)([%w_']*)", titleCase)
	nachname = string.gsub(nachname, "(%a)([%w_']*)", titleCase)
	name = vorname.."."..nachname
	setPlayerName(source, name)
		
	local doesExist = false
	
	local time = getRealTime()
	local query = mysql_query(g_mysql["connection"],"SELECT * FROM users WHERE name = '"..name.."';")
	if mysql_num_rows(query) > 0 then
		triggerClientEvent ( source, "addNotification", getRootElement(),  1, 255, 0, 0, "Dieser Name ist bereits registriert." )
		doesExist = true
	end
	local squery = mysql_query(g_mysql["connection"],"SELECT * FROM users WHERE serial = '"..getPlayerSerial(source).."';")
	if mysql_num_rows(squery) > 0 then
		triggerClientEvent ( source, "addNotification", getRootElement(),  1, 255, 0, 0, "Diese Serial ist bereits registriert." )
		-- TDODO ENABLE THIS AGAIN!!!! doesExist = true
	end
	
	if doesExist == false then
		mysql_query(g_mysql["connection"], "INSERT INTO `users` (`name`) VALUES ('"..name.."');")
		
		local id = mysql_query(g_mysql["connection"], "SELECT LAST_INSERT_ID(id) AS last FROM users ORDER BY id DESC LIMIT 1;")
		local lastid = mysql_insert_id(g_mysql["connection"])
		mysql_free_result(id)	
	
		local aquery = mysql_query(g_mysql["connection"],"UPDATE `users` SET `passwort` = '"..md5(pass).."',\
														 `erstellt` = '"..tostring(time.monthday.."."..(tonumber(time.month)+1).."."..(time.year+1900)).."',\
														 `laston` = '"..tostring(time.monthday.."."..tonumber(time.month+1).."."..tonumber(time.year+1900).." "..time.hour..":"..time.minute).."',\
														 `name` = '"..tostring(name).."',\
														 `aktivated` = '2',\
														 `serial` = '"..tostring(getPlayerSerial(source)).."',\
														 `geb` = '"..tostring(geburt).."',\
														 `skin` = '"..tonumber(skin).."',\
														 `x` = '370',\
														 `y` = '309.3',\
														 `z` = '1020.3',\
														 `geschlecht` = '"..tostring(geschlecht).."',\
														 `interior` = '3',\
														 `dimension` = '0',\
														 `geld` = '1000',\
														 `admin` = '0',\
														 `aschein` = '"..tostring(false).."',\
														 `mschein` = '"..tostring(false).."',\
														 `fschein` = '"..tostring(false).."',\
														 `bschein` = '"..tostring(false).."',\
														 `job` = '0',\
														 `rank` = '0',\
														 `dienst` = '0',\
														 `energie` = '100',\
														 `hunger` = '30',\
														 `harndrang` = '40',\
														 `hygiene` = '50',\
														 `health` = '100',\
														 `armour` = '0',\
														 `pif` = '0',\
														 `promille` = '0',\
														 `time` = '0',\
														 `seat` = '0',\
														 `invehicle` = '"..tostring(false).."',\
														 `currentveh` = '0',\
														 `wschein` = '0',\
														 `einsperrzeit` = '0',\
														 `gehalt` = '0',\
														 `einnahmen` = '0',\
														 `dienstzeit` = '0',\
														 `items` = '0',\
														 `einnahmen2` = '0',\
														 `isDead` = '"..tostring(false).."',\
														 `gang` = '0',\
														 `gangrank` = '0',\
														 `promillesoll` = '0',\
														 `cooldown` = '0',\
														 `btime` = '0',\
														 `exp` = '1',\
														 `level` = '1',\
														 `panote` = '0',\
														 `time` = '0',\
														 `mail` = '"..escapeString(tostring(mail)).."'\
						WHERE `name` = '"..name.."' LIMIT 1 ;")
		triggerClientEvent ( source, "addNotification", getRootElement(),  2, 0, 255, 0, "Erolgreich registriert!\nErste Schritte: 'F1'" )	
		outputChatBox ( "Für Hilfe und Erste Schritte drücke 'F1'.", source, 0, 255, 0 )	
		showChat(source, true)						
		mysql_free_result(aquery)
		triggerClientEvent(source, "registrationComplete", getRootElement())
		getPlayerRegisterStatus(source)
		successLoginPlayer(source)
	end
	mysql_free_result(squery)
	mysql_free_result(query)
end
addEventHandler("registerRPGPlayerToServer",getRootElement(),registerRPGPlayer)


function setPlayerRegisterStatus(playername, param)
	if playername ~= nil and playername ~= "" then
		local player = getPlayerFromName(playername)
		if player then
			if getElementData(player, "playerInTutorial") ~= true then
				setElementData(player, "playerRegisterStatus", param)
				setPlayerUserFileData(playername, "aktivated", param)
				getPlayerRegisterStatus(player)
			end
		else
			setPlayerUserFileData(playername, "aktivated", param)
			getPlayerRegisterStatus(player)
		end
	end
end
addEvent("setPlayerRegisterStatus",true)
addEventHandler("setPlayerRegisterStatus", getRootElement(), setPlayerRegisterStatus)


function onRPGPlayerChangeNick(oldnick,newnick)
	if getElementData(source, "isPlayerLoggedIn") == true then
		cancelEvent()
	else
		getPlayerRegisterStatus(source)
	end
end
addEventHandler("onPlayerChangeNick", getRootElement(), onRPGPlayerChangeNick)

addEvent("changeRPGNickToServer",true)
function changeRPGPlayerName(name)
	setPlayerName(source,name)
	getPlayerRegisterStatus(source)
end
addEventHandler("changeRPGNickToServer", getRootElement(), changeRPGPlayerName)


function output()
	local root = xmlLoadFile( "xml/message.xml" )
	local mes = xmlNodeGetChildren ( root )

	local g_WelcomeMessages = {}
	for Jl,Value2 in ipairs(mes) do
		g_WelcomeMessages[Jl] = xmlNodeGetValue(Value2)
	end

	outputChatBox ( "Willkommen bei The Vita Village", source, 255, 0, 0 )	
    for i,value in ipairs(g_WelcomeMessages) do
		outputChatBox ( value, source, 255, 0, 0 )
	end
	xmlUnloadFile (root)
end

addEventHandler("onPlayerJoin", getRootElement(), output)

local saveQueue = createElement("queue")

addEventHandler("onPlayerQuit", root,
	function()
		local playerQueueEntry = getElementData(source, "saveQueue")
		if isElement(playerQueueEntry) then
			destroyElement(playerQueueEntry)
		end
	end
)

function updatePlayerSaveQueue()
	local entry = getElementChildren(saveQueue)[1]
	if not entry then
		for k, v in pairs(getElementsByType("player")) do
			local ent = createElement("queueEntry")
			setElementData(ent, "player", v)
			setElementData(v, "saveQueue", ent)
			setElementParent(ent, saveQueue)
		end
	else
		local player = getElementData(entry, "player")
		savePlayer(player)
		destroyElement(entry)
	end
	local pc = getPlayerCount()
	if pc == 0 then
		setTimer(updatePlayerSaveQueue, 1000*60*15, 1)
	else
		setTimer(updatePlayerSaveQueue, 1000*60*60/pc, 1)
	end
end

setTimer(updatePlayerSaveQueue, 1000*60*5, 1)
setTimer(updatePlayerSaveQueue, 10000, 1)

addEventHandler("onVehicleStartEnter", getRootElement(),
	function(player, seat)
		if getElementModel(source) == 502 then
			if not getElementData(player, "getPlayerSpecialRights") or  getElementData(player, "getPlayerSpecialRights") <= 0 and seat == 0 then
				cancelEvent()
			end
		elseif getElementModel(source) == 538 then
			cancelEvent()
		end
	end
)

function checkExp(dataName, oldValue)
	if getElementType(source) == "player" and dataName == "exp" and getElementData(source, "isPlayerLoggedIn") then 
		local xp = getElementData(source, "exp")
		local level = getElementData(source, "level")
		if level and xp then
			local neededScore = tonumber(level) * 50 * tonumber(level)
			local lastScore = tonumber(level-1) * 50 * tonumber(level-1)
			setElementData(source, "neededScore", neededScore)
			setElementData(source, "lastScore", lastScore)
			if xp > neededScore then
				callClientFunction(source,"showLevelUp", "Gratulation","Du bist nun Level "..level+1)
				setElementData(source, "level", level+1)
				local neededScore2 = tonumber(level+1) * 50 * tonumber(level+1)
				setElementData(source, "neededScore", neededScore2)
				setElementData(source, "lastScore", neededScore)
			end		
		end
	end
end
addEventHandler ( "onElementDataChange", getRootElement(), checkExp )

function afklogger( Name, OValue )
	if getElementData ( source, "afk" ) ==  true and OValue == false and Name == "afk" then
		pLogger["afk"]:addEntry( getPlayerName(source) .." ist afk gegangen.")
		else if getElementData ( source, "afk" ) ==  false and OValue == true and Name == "afk" then
			pLogger["afk"]:addEntry( getPlayerName ( source ).." ist wieder gekommen." )
		end
	end
end
addEventHandler ( "onElementDataChange", getRootElement(), afklogger )

function setBoughtSkin(gender, skin, abort)
	if abort ~= true then
		if getPlayerMoneyEx(source) >= 80000 then
			setPlayerMoneyEx(source, getPlayerMoneyEx(source)-80000)
			setElementData(source, "skin", skin)
			setElementData(source, "geschlecht", gender)
			if getElementData(source, "dienst") == 0 then
				setElementModel(source, skin)
			end
			triggerClientEvent ( source, "addNotification", getRootElement(),  1, 0, 255, 0, "Operation erfolgreich.\nWillkommen in deinem neuen Körper." )
		else
			triggerClientEvent ( source, "addNotification", getRootElement(),  1, 255, 0, 0, "Du benötigst 80000 Vero." )
		end
	end
	setCameraTarget(source)
	setElementInterior(source, 0) --FIX AS IT WONT SET THE INTERIOR BEFORE, IDK WHY
	setElementPosition(source, 375.715,322.8081,1020.04)
	setElementInterior(source, 3)
	fadeCamera(source, true)
end
addEvent("setBoughtSkin", true)
addEventHandler("setBoughtSkin", getRootElement(), setBoughtSkin)
--Funktioniert noch nicht ganz? kA
function checkElementDataChange(dataName, oldValue)
	if client ~= nil or client ~= false then
		if dataName == "admin" then
			setElementData(source, dataName, oldValue)
			--Gibt hier einen C++ Overflow, frag mich nicht wieso. Muss das Ganze nochmal umbauen um auch andere Sachen zu sperren.
			--Wenigstens Admin geben ist nun unmöglich
		end
	end
end
addEventHandler("onElementDataChange",getRootElement(),checkElementDataChange)