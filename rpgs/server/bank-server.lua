--[[
Project: VitaOnline
File: bank2-server.lua
Author(s):	MrX
			Sebihunter
]]--


--TODO: Überprüfen ob das hier noch benötigt wurde...
--[[
bankMainPed = {}

bankMainPed[1] = createPed (172 , 359.7139, 173.5636, 1008.3893 ) 
setPedRotation(bankMainPed[1],-90)
setElementInterior(bankMainPed[1],3) 
setElementData(bankMainPed[1], "PedName", "Bankangestellte Laura")
setPedFrozen(bankMainPed[1],true)
]]--

function createBankAccount(name, btype, dispo)

	if mysql_ping ( g_mysql["connection"] ) == false then
		onResourceStopMysqlEnd()
		onResourceStartMysqlConnection()
	end
	
	name = string.gsub(tostring(name), " ", "_")
	
	local query = mysql_query(g_mysql["connection"], "INSERT INTO `bank` (`name`, `geld`, `type`, `dispo`) VALUES ('"..name.."','0', '"..btype.."', '"..dispo.."');")
	mysql_free_result(query)
	return { ["name"] = name, ["geld"] = 0, ["type"] = btype, ["dispo"] = dispo }
end

function getBankAccount(name)
	if mysql_ping ( g_mysql["connection"] ) == false then
		onResourceStopMysqlEnd()
		onResourceStartMysqlConnection()
	end
	name = string.gsub(tostring(name), " ", "_")

	for i,v in ipairs(delayedBankTable) do
		if v.name == name then
			return v
		end
	end
	
	local query = mysql_query(g_mysql["connection"],"SELECT * FROM `bank` WHERE name = '"..name.."';")
	
	if query and mysql_num_rows(query) > 0 then	
		local row = mysql_fetch_assoc(query)
		local account = {}
		account["name"] = name
		account["type"] = tonumber(row["type"])
		account["geld"] = tonumber(row["geld"])
		account["dispo"] = tonumber(row["dispo"])
		account["access"] = row["access"]
		mysql_free_result(query)
		return account		
	else
		return nil
	end
end

function deleteBankAccount(name)
	if mysql_ping ( g_mysql["connection"] ) == false then
		onResourceStopMysqlEnd()
		onResourceStartMysqlConnection()
	end
	
	name = string.gsub(tostring(name), " ", "_")
	local query = mysql_query(g_mysql["connection"],"SELECT * FROM `bank` WHERE name = '"..name.."';")
	if not query then return nil end
	mysql_free_result(query)
	local sql = "DELETE FROM `bank` WHERE `name` = '"..name.."' LIMIT 1 ;"		
	query = mysql_query(g_mysql["connection"],sql)
	if query then mysql_free_result(query) end	
end


delayedBankTimer = nil
delayedBankTable = {}
function updateBankAccount(account, delayed)
	if delayed then
		local hasFound = false
		for i,v in ipairs(delayedBankTable) do
			if v.name == account.name then
				hasFound = v
				v = account
			end
		end	
		if not hasFound then
			delayedBankTable[#delayedBankTable+1] = account
		end
		if not delayedBankTimer then
			delayedBankTimer = setTimer(function()
				if mysql_ping ( g_mysql["connection"] ) == false then
					onResourceStopMysqlEnd()
					onResourceStartMysqlConnection()
				end		
				local theaccount = delayedBankTable[1]
				theaccount["name"] = string.gsub(tostring(theaccount["name"]), " ", "_")
				local query = mysql_query(g_mysql["connection"],"SELECT * FROM `bank` WHERE name = '"..theaccount["name"].."';")
				if not query then return nil end
				
				mysql_free_result(query)
				local sql = "UPDATE `bank` SET `geld` = '"..theaccount["geld"].."',\
				`type` = '"..theaccount["type"].."',\
				`dispo` = '"..theaccount["dispo"].."'\
				WHERE `name` = '"..theaccount["name"].."' LIMIT 1 ;"		
				query = mysql_query(g_mysql["connection"],sql)
				if query then mysql_free_result(query) end			
				table.remove(delayedBankTable, 1)
				if #delayedBankTable == 0 then
					killTimer(delayedBankTimer)
					delayedBankTimer = nil
				end
			end, 50,0)
		end
	else
		if mysql_ping ( g_mysql["connection"] ) == false then
			onResourceStopMysqlEnd()
			onResourceStartMysqlConnection()
		end
		account["name"] = string.gsub(tostring(account["name"]), " ", "_")
		local query = mysql_query(g_mysql["connection"],"SELECT * FROM `bank` WHERE name = '"..account["name"].."';")
		if not query then return nil end
		mysql_free_result(query)
		local sql = "UPDATE `bank` SET `geld` = '"..account["geld"].."',\
		`type` = '"..account["type"].."',\
		`dispo` = '"..account["dispo"].."'\
		WHERE `name` = '"..account["name"].."' LIMIT 1 ;"	
		query = mysql_query(g_mysql["connection"],sql)
		if query then mysql_free_result(query) end	
	end
end

function hasPlayerBankAccess(source, account)
	if type(account) == "string" then
		account = getBankAccount(account)
	end
	
	if not account then return false end
	if account["type"] == 0 then		-- Userkonto
		if getPlayerName(source) ~= account["name"] then
			return false -- Zugriff Verweigert.
		end
	elseif account["type"] == 1 then 	-- Firmenkonto
		if getElementData(source, "rank") < 2 or string.gsub(tostring(getJobBankName(getElementData(source, "job"))), " ", "_") ~= account["name"] then
			return false -- Zugriff Verweigert.
		end
	elseif account["type"] == 2 then 	-- Gangkonto
		if getElementData(source, "gangrank") < 2 or string.gsub(tostring(gGangData[tonumber(getElementData(source, "gang"))].name), " ", "_") ~= account["name"] then
			return false -- Zugriff Verweigert.
		end
	elseif account["type"] == 3 then 	-- Private Unternehmen
		if not isVehicleOwner(source, account["access"]) then return false end --Wir klauen uns das aus den Vehicle-Funktionen
	end
	return true
end

function getBankAccountMoney(account)
	if type(account) == "string" then
		account = getBankAccount(account)
	end
	return account["geld"]
end

function addBankLog(account, amount, mtype, text)
	local xmlRoot = xmlCreateOrLoad("xml/kontenLog/"..account["name"]..".xml", "log")
	local accountRoot = xmlCreateChild(xmlRoot, "eintrag")
	xmlNodeSetAttribute(accountRoot, "type", mtype)
	xmlNodeSetAttribute(accountRoot, "text", text)
	xmlNodeSetAttribute(accountRoot, "amount", amount)
	xmlSaveFile(xmlRoot)
	xmlUnloadFile(xmlRoot)
end

function userWithdraw(source, account, amount, text)
	if type(account) == "string" then
		account = getBankAccount(account)
	end
	if hasPlayerBankAccess(source, account) == false then return -1 end
	
	if account["geld"] + account["dispo"] < amount then return -2 end
	
	if amount < 0 then return -4 end
	pLogger["konten"]:addEntry(getPlayerName(source).." hat "..tostring(amount).." vom Konto "..tostring(account["name"]).." abgehoben.")
	if text then
		systemWithdraw(account, amount, getPlayerName(source)..", "..text)
	else
		systemWithdraw(account, amount, getPlayerName(source)..", ATM")
	end
	givePlayerMoneyEx(source, amount)
	return 1
end

function getBankLogs(source,accname)
	accname = string.gsub(tostring(accname), " ", "_")
	local xmlRoot = xmlCreateOrLoad("xml/kontenLog/"..accname..".xml", "log")
	local tbl = {}
	for i,v in pairs(xmlNodeGetChildren ( xmlRoot )) do
		if tbl[10] then table.remove(tbl, 1) end
		tbl[#tbl+1] = {}
		tbl[#tbl].amount = xmlNodeGetAttribute(v, "amount")
		tbl[#tbl].typ = xmlNodeGetAttribute(v, "type")
		tbl[#tbl].info = xmlNodeGetAttribute(v, "text")
		if not tbl[#tbl].info then tbl[#tbl].info = "" end
	end
	callClientFunction(source, "receiveUberweisenData", tbl)

	xmlUnloadFile(xmlRoot)	
end

function userDeposit(source, account, amount, text)
	if type(account) == "string" then
		account = getBankAccount(account)
	end
	if hasPlayerBankAccess(source, account) == false then return -1 end
	
	if getPlayerMoneyEx(source) < amount then return -2 end
	
	if amount < 0 then return -4 end
	pLogger["konten"]:addEntry(getPlayerName(source).." hat "..tostring(amount).." in das Konto "..tostring(account["name"]).." eingezahlt.")
	if text then
		systemDeposit(account, amount, getPlayerName(source)..", "..text)
	else
		systemDeposit(account, amount, getPlayerName(source)..", ATM")
	end
	takePlayerMoneyEx(source, amount)
	return 1
end

function userTransfer(source, accountSource, accountTarget, amount, text,accname1,accname2)
	if type(accountSource) == "string" then
		accountSource = getBankAccount(accountSource)
	end
	if type(accountTarget) == "string" then
		accountTarget = getBankAccount(accountTarget)
	end
	if accountSource == accountTarget or ( accname1 and accname2 and string.lower(accname1) == string.lower(accname2)) then triggerClientEvent ( source, "addNotification", getRootElement(), 2, 255,0,0, "Überweisung fehlgeschlagen:\nEmpfänger ist Absender." ) return end
	if hasPlayerBankAccess(source, accountSource) == false then return -1 end
	
	if accountSource["geld"] + accountSource["dispo"] < amount then return -2 end
	
	if type(accountTarget) ~= "table" then return -3 end
	
	if amount < 0 then return -4 end
	
	pLogger["konten"]:addEntry(getPlayerName(source).." hat "..tostring(amount).." vom Konto "..tostring(accountSource["name"]).." zum Konto "..tostring(accountTarget["name"]).." überwiesen.")
	if text then
		systemTransfer(accountSource, accountTarget, amount, text, accname1,accname2)
	else
		systemTransfer(accountSource, accountTarget, amount, "", accname1,accname2)
	end
	return 1
end
--
-- Systemfunktionen
-- Aufrufen wenn eine Überweisung / Auszahlung usw. vom System aus geschehen soll
--
function systemWithdraw(account, amount, text, delayed)
	local rt = getRealTime( )
	rt.year = rt.year+1900
	rt.month = rt.month+1
	local timestring = rt.hour..":"..rt.minute..", "..rt.monthday.."."..rt.month.."."..rt.year
	
	if type(account) == "string" then
		account = getBankAccount(account)
	end
	account["geld"] = account["geld"] - amount
	updateBankAccount(account, delayed)
	if text then
		addBankLog(account, amount, "Auszahlung", text.." ("..timestring..")")
	end
end

function systemDeposit(account, amount, text, delayed)

	local rt = getRealTime( )
	rt.year = rt.year+1900
	rt.month = rt.month+1
	local timestring = rt.hour..":"..rt.minute..", "..rt.monthday.."."..rt.month.."."..rt.year
	
	if type(account) == "string" then
		account = getBankAccount(account)
	end
	account["geld"] = account["geld"] + amount
	updateBankAccount(account,delayed)
	if text then
		addBankLog(account, amount, "Einzahlung", text.." ("..timestring..")")
	end
end

function systemTransfer(accountSource, accountTarget, amount, text,accname1, accname2,delayed)
	if type(accountSource) == "string" then
		accountSource = getBankAccount(accountSource)
	end
	if type(accountTarget) == "string" then
		accountTarget = getBankAccount(accountTarget)
	end
	if accountSource == accountTarget or ( accname1 and accname2 and string.lower(accname1) == string.lower(accname2)) then return end
	local oldgeld = accountSource["geld"]
	accountSource["geld"] = accountSource["geld"] - amount
	accountTarget["geld"] = accountTarget["geld"] + amount
	updateBankAccount(accountSource, delayed)
	updateBankAccount(accountTarget, delayed)
	local rt = getRealTime( )
	rt.year = rt.year+1900
	rt.month = rt.month+1
	local timestring = rt.hour..":"..rt.minute..", "..rt.monthday.."."..rt.month.."."..rt.year
	if text then
		if accname1 and accname2 then
			addBankLog(accountSource, amount, "Ueberweisung AUS", "AN: "..accname2..", "..text.." ("..timestring..")")
			addBankLog(accountTarget, amount, "Ueberweisung EIN", "VON: "..accname1..", "..text.." ("..timestring..")")		
		else
			addBankLog(accountSource, amount, "Ueberweisung AUS", text.." ("..timestring..")")
			addBankLog(accountTarget, amount, "Ueberweisung EIN", text.." ("..timestring..")")
		end
	end
end

addEvent("bank2:openAccount", true)
addEventHandler("bank2:openAccount", getRootElement(), 
	function (accountS)
		local account = getBankAccount(accountS)
		if hasPlayerBankAccess(source, accountS) == false then
			triggerClientEvent(source, "bank2.client:openAccount:return", getRootElement(), -1)
			return
		end
		account["name"] = accountS
		triggerClientEvent(source, "bank2.client:openAccount:return", getRootElement(), account)
	end
)

addEvent("bank2:createNewAccount", true)
addEventHandler("bank2:createNewAccount", getRootElement(), 
	function (dispo)
		if getBankAccount(getPlayerName(source)) then 
			triggerClientEvent(source, "bank2.client:createAccount:return", getRootElement(), -1)
			return
		end
		local account = createBankAccount(getPlayerName(source), 0, dispo)
		triggerClientEvent(source, "bank2.client:createAccount:return", getRootElement(), account)
	end
)

addEvent("bank2:withdraw", true)
addEventHandler("bank2:withdraw", getRootElement(), 
	function (account, amount, betreff)
		account = getBankAccount(account["name"])                         
		local state = userWithdraw(source, account, amount, betreff)
		triggerClientEvent(source, "bank2.client:withdraw:return", getRootElement(), state)
	end
)

addEvent("bank2:deposit", true)
addEventHandler("bank2:deposit", getRootElement(), 
	function (account, amount, betreff)
		account = getBankAccount(account["name"])
		local state = userDeposit(source, account, amount, betreff)
		triggerClientEvent(source, "bank2.client:deposit:return", getRootElement(), state)
	end
)

addEvent("bank2:transfer", true)
addEventHandler("bank2:transfer", getRootElement(), 
	function (accountS, accountT, amount, betreff)
		local accname1 = accountS
		local accname2 = accountT
		local accountS = getBankAccount(accountS)
		local accountT = getBankAccount(accountT)
		if not accountS or not accountT then triggerClientEvent ( source, "addNotification", getRootElement(), 2, 255,0,0, "Überweisung fehlgeschlagen:\nEmpfänger nicht gefunden." ) return end
		local state = userTransfer(source, accountS, accountT, amount, betreff,accname1,accname2)
		if state == 1 then 
			triggerClientEvent ( source, "addNotification", getRootElement(), 2, 00,255,0, "Überweisung erfolgreich.\n"..amount.." Vero an "..accountT["name"].."." )
		else
			triggerClientEvent ( source, "addNotification", getRootElement(), 2, 255,0,0, "Überweisung fehlgeschlagen." )
		end
		--triggerClientEvent(source, "bank2.client:transfer:return", getRootElement(), state)
	end
)
addEventHandler( "onElementClicked", getRootElement(),
function( theButton, theState, thePlayer )
    if theButton == "left" and theState == "down" then
		local x,y,z = getElementPosition(source)
		local playerx, playery, playerz = getElementPosition(thePlayer)
        if getElementModel(source) == 2942 and getDistanceBetweenPoints3D(x,y,z, playerx, playery,playerz) < 10 then
			triggerClientEvent(thePlayer, "bank2.client:openWindow", getRootElement())
		end
    end
end
)

addEvent("addJobMoney", true)
addEventHandler("addJobMoney", getRootElement(), 
	function(account, amount)
		systemDeposit(account, amount)
	end
)