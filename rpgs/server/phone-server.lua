--[[
Project: VitaOnline
File: phone-server.lua
Author(s):	MrX
			FrankZZ
]]--
local PHONE_NONE = 0
local PHONE_CALLING = 1
local PHONE_CALLED = 2
local PHONE_TALKING = 3
local PHONE_WAITING = 4

local numbersUsed = {}

function getPlayerPhoneNumber(player)
	if not player and not isElement(player) then return end
	local item = findItem(player, 6)
	if item == -1 then return false end
	return getItemData(player, item, "nummer")
end

function givePhone(player, slot)
	local slot = giveItem(player, 6)
	local num = getFreePhoneNumber()
	setItemData(player, slot, "nummer", num)
	setPhoneNumberUsed(num)
	triggerClientEvent ( player, "showTutorialMessage", getRootElement(), "phones_1", "Du hast dir ein Telefon gekauft und kannst nun mit '/anrufen [Nummer]' bzw. '/sms [Nummer] [Text]' mit anderen Leuten sprechen." )
end

function getFreePhoneNumber()
	local num
	num = math.random(100000, 999999)
	while isPhoneNumberFree(num) == false do
		num = math.random(100000, 999999)
	end
	
	return num
end

addEventHandler("onResourceStart", getResourceRootElement(),
	function()
		pFile = fileOpenOrCreate("xml/nummern.xml", true)
		local buffer = ""
		while not fileIsEOF(pFile) do
			buffer = buffer..fileRead(pFile, 1024)
		end
		numbersUsed = fromJSON(buffer) or {}
		fileClose(pFile)
	end
)

addEventHandler("onResourceStop", getResourceRootElement(),
	function()
		if isThereFailMySQL == true then return end
		numused = toJSON(numbersUsed)
		pFile = fileOpenOrCreate("xml/nummern.xml", false)
		fileWrite(pFile, numused)
		fileClose(pFile)
	end
)


function setPhoneNumberUsed(num)
	numbersUsed[tostring(num)] = true
end
function setPhoneNumberFree(num)
	numbersUsed[tostring(num)] = nil
end

function getPlayerFromPhoneNumber(number)
	--if isPhoneNumberFree(number) then
		--return 
	--end
	for k, v in pairs(getElementsByType("player")) do
		local items = getElementData(v, "items")
		if items then
			for itemk, itemv in pairs(items) do
				if itemv.itemid == 6 then -- Telefonobjekt
					if itemv.nummer == number then
						return v
					end
				end
			end
		end
	end
end

function isPhoneNumberFree(number)
	if getPlayerFromPhoneNumber(number) and not numbersUsed[tostring(number)] then
		setPhoneNumberUsed(number)
	end
	if numbersUsed[tostring(number)] then
		return false
	else
		return true
	end
end

function isPlayerCalling(player)
	return getElementData(player, "phoneState") == PHONE_CALLING or getElementData(player, "phoneState") == PHONE_WAITING
end
function isPlayerBeingCalled(player)
	return getElementData(player, "phoneState") == PHONE_CALLED or getElementData(player, "phoneState") == PHONE_WAITING
end

function isPlayerPhoning(player) 
	return getElementData(player, "phoneState") == PHONE_TALKING
end

function checkNumber(player, cmd, name)
	if not name then return
	
	end
	v = getPlayerFromName2 ( name )	
	if v then
		if type(v) == "table" then
			outputChatBox("Fehler: Mehrere Spieler gefunden!",player,255,0,0)
		return
		end
		name = getPlayerName(v)
		local number = getPlayerPhoneNumber(v)
		if not number then number = "Keine Nummer" end
		outputChatBox( "#0CFDF5Telefonbucheintrag von "..name..": "..number, player, 255,255,255,true  )
	else
		outputChatBox("Fehler: Der Spieler mit dem Namen "..name.." wurde nicht gefunden.", player, 255, 0, 0)
	end
end
addCommandHandler("telefonbuch",  checkNumber)

function writePlayer(player, cmd, number, ...)
	local text = table.concat(arg, " ")
	if not number or not text or text == "" or not tonumber(number) then
		return outputChatBox("Fehler: Benutzte /sms [nummer] [text]", player, 255, 0, 0)
	end
	number = tonumber(number)
	
	if not hasItem(player, 6) then
		outputChatBox("Fehler: Du hast kein Telefon!", player, 255, 0, 0)
		return
	end

	if isPlayerPhoning(player) or isPlayerCalling(player) then
		outputChatBox("Fehler: Du verwendest das Telefon bereits!", player, 255, 0, 0)
		return
	end
	
	if isPhoneNumberFree(number) then
		outputChatBox("Fehler: Die von Ihnen gewählte Rufnummer ist zurzeit nicht verfügbar. Bitte versuchen Sie es später erneut!", player, 255, 0, 0)
		return
	end

	local playerToCall = getPlayerFromPhoneNumber(number)
	if not playerToCall or isPlayerBeingCalled(playerToCall) or isPlayerPhoning(playerToCall) or isPlayerCalling(playerToCall) then
		outputChatBox("Fehler: Der gewünschte Gesprächspartner ist zurzeit nicht erreichbar!", player, 255, 0, 0)
		return
	end
	
	local money = getPlayerMoneyEx(player)
	if money < 5 then
		outputChatBox("Fehler: Du benötigst mindestens 5 Vero!", player, 255, 0, 0)
		return
	end
	takePlayerMoneyEx(player, 5)
	callClientFunction(playerToCall, "playSound", "sounds/sms.wav")
	outputChatBox( "#0CFCF4SMS an "..getPlayerName(playerToCall).." ("..number.."): #FFFFFF"..text, player, 255,255,255,true  )
	outputChatBox( "#0CFCF4SMS von "..getPlayerName(player).." ("..tostring(getPlayerPhoneNumber(player)).."): #FFFFFF"..text, playerToCall, 255,255,255,true  )
end
addCommandHandler("sms",  writePlayer)
addCommandHandler("pm",  writePlayer)

function callPlayer(player, cmd, number)
	if not hasItem(player, 6) then
		outputChatBox("Fehler: Du hast kein Telefon!", player, 255, 0, 0)
		return
	end

	if isPlayerPhoning(player) then
		outputChatBox("Fehler: Du telefonierst bereits!", player, 255, 0, 0)
		return
	end
	if isPlayerCalling(player) then
		outputChatBox("Fehler: Du rufst bereits jemanden an!", player, 255, 0, 0)
		return
	end
	local nnumber = tonumber(number)
	if not number or not nnumber then 
		outputChatBox("Fehler: Benutze /anrufen [nummer]!", player, 255, 0, 0)
		return
	end
	number = nnumber
	if isPhoneNumberFree(number) then
		outputChatBox("Fehler: Die von Ihnen gewählte Rufnummer ist zurzeit nicht verfügbar. Bitte versuchen Sie es später erneut!", player, 255, 0, 0)
		return
	end
	local playerToCall = getPlayerFromPhoneNumber(number)
	if not playerToCall or isPlayerBeingCalled(playerToCall) or isPlayerPhoning(playerToCall) or isPlayerCalling(playerToCall) then
		outputChatBox("Fehler: Der gewünschte Gesprächspartner ist zurzeit nicht erreichbar!", player, 255, 0, 0)
		return
	end
	
	if playerToCall == player then
		outputChatBox("Fehler: Du kannst dich nicht selber anrufen!", player, 255, 0, 0)
		--return	
	end
	
	setElementData(player, "phoneState", PHONE_WAITING)
	setElementData(playerToCall, "phoneState", PHONE_WAITING)
	setElementData(player, "phoneTarget", playerToCall)
	setElementData(playerToCall, "phoneTarget", player)
	outputChatBox(getPlayerName(player).." ("..getPlayerPhoneNumber(player)..") ruft an. Nutze /entgegennehmen oder /auflegen", playerToCall, 12,252,244)
	outputChatBox("Du rufst "..getPlayerName(playerToCall).." an. Warte, bis er den Anruf annimmt.", player, 12,252,244)
	
	triggerClientEvent(root, "phoneRing", playerToCall)
end
addCommandHandler("call", callPlayer)
addCommandHandler("anrufen", callPlayer)

function stopPhoning(player)
	if isPlayerPhoning(player) == false and isPlayerBeingCalled(player) == false then 
		outputChatBox("Fehler: Du telefonierst nicht!", player, 255, 0, 0)
		return
	end
	local playerCaller = getElementData(player, "phoneTarget")
	if getElementData(player, "phoneState") == PHONE_WAITING then
		outputChatBox("Du hast den Anruf von "..getPlayerName(playerCaller).." abgelehnt.", player, 12,252,244)
		outputChatBox(getPlayerName(player).." hat deinen Anruf abgelehnt.", playerCaller, 12,252,244)
	else
		outputChatBox("Du hast das Gespräch mit "..getPlayerName(playerCaller).." beendet.", player, 12,252,244)
		outputChatBox(getPlayerName(player).." hat das Gespräch beendet.", playerCaller, 12,252,244)
	end
	setElementData(player, "phoneState", PHONE_NONE)
	setElementData(playerCaller, "phoneState", PHONE_NONE)	
end
addCommandHandler("auflegen", stopPhoning)
function acceptCall(player)
	if isPlayerBeingCalled(player) == false then 
		outputChatBox("Fehler: Du wirst nicht angerufen!", player, 255, 0, 0)
		return
	end
	local playerToCall = getElementData(player, "phoneTarget")
	setElementData(player, "phoneState", PHONE_TALKING)
	setElementData(playerToCall, "phoneState", PHONE_TALKING)
	outputChatBox("Du hast den Anruf von "..getPlayerName(playerToCall).." entgegengenommen.", player, 12,252,244)
	outputChatBox(getPlayerName(player).." hat deinen Anruf entgegengenommen.", playerToCall, 12,252,244)
end
addCommandHandler("entgegennehmen", acceptCall)