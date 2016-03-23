--[[
Project: VitaOnline
File: reporter-server.lua
Author(s):	Sebihunter
]]--

local lottoTable = {
state = false,
money = 0,
players = {},
maximum = 1,
price = 100
}

function buyLotto()
	if getPlayerMoneyEx(source) < lottoTable.price then return triggerClientEvent ( source, "addNotification", getRootElement(),  1, 255, 0, 0, "Nicht genügend Geld." ) end
	local times = 0
	for i,v in ipairs(lottoTable.players) do
		if getPlayerName(source) == v then times = times +1 end
	end
	if times +1 > lottoTable.maximum and lottoTable.maximum ~= 0 then return triggerClientEvent ( source, "addNotification", getRootElement(),  1, 255, 0, 0, "Du kannst nicht mehr Tickets kaufen." ) end
	takePlayerMoneyEx(source, lottoTable.price)
	lottoTable.players[#lottoTable.players+1] = getPlayerName(source)
	lottoTable.money = lottoTable.money + lottoTable.price
	triggerClientEvent ( source, "addNotification", getRootElement(),  1, 0, 255, 0, "Du hast dir einen Lottoschein gekauft." )
end
addEvent("buyLotto", true)
addEventHandler("buyLotto", getRootElement(), buyLotto)


function checkLotto()
	callClientFunction(source, "receiveLotto", lottoTable)
end
addEvent("checkLotto", true)
addEventHandler("checkLotto", getRootElement(), checkLotto)


function lottoCMD(ply, command, text, text2)
	if getElementData(ply, "job") == 9 and getElementData(ply, "dienst") == 1 then
		if not text or text == "" then return outputChatBox("Fehler: /lotto [status/preis/max]",ply,255,0,0) end
		if text == "max" then
			if not text2 or text2 == "" or not tonumber(text2) then return outputChatBox("Fehler: /lotto max [maximale Tickets]",ply,255,0,0) end
			lottoTable.maximum = tonumber(text2)
			outputChatBox("Maximale Lottotickets auf "..text2.." gesetzt.", ply,0,255,0)
		elseif text == "preis" then
			if not text2 or text2 == "" or not tonumber(text2) then return outputChatBox("Fehler: /lotto preis [Ticketpreis]",ply,255,0,0) end
			lottoTable.price = tonumber(text2)
			outputChatBox("Ticketpreis auf "..text2.." gesetzt.", ply,0,255,0)
		elseif text == "status" then
			if (not text2 or text2 == "") and text2 ~= "start" and text2 ~= "stop" then return outputChatBox("Fehler: /lotto status [start/stop]",ply,255,0,0) end
			if text2 == "start" and lottoTable.state == false then
				lottoTable.state = true
				outputChatBox("Du hast die Lotterie gestartet. Spieler können nun im 24/7 Scheine kaufen.",ply,0,255,0)
			elseif text2 == "stop" and lottoTable.state == true then
				local newTable = {}
				for i,v in ipairs(lottoTable.players) do
					if getPlayerFromName(v) then
						newTable[#newTable+1] = getPlayerFromName(v)
					end
				end			
				if #newTable == 0 then
					outputChatBox("Du hast die Lotterie gestoppt: Da kein online Spieler ein Ticket gekauft hat wurde kein Los gezogen.",ply,0,255,0)
					lottoTable.state = false
					lottoTable.money = 0
					lottoTable.players = {}
					return
				end
				local tp = newTable[math.random(1, #newTable)]
				outputChatBox("Der Spieler "..getPlayerName(tp).." hat den Jackpot von "..(lottoTable.money*0.9).." Vero geknackt.",ply,0,255,0)
				outputChatBox("Die viNETWORK hat "..(lottoTable.money*0.1).." Vero eingenommen.",ply,0,255,0)
				outputChatBox("Du hast den Jackpot von "..(lottoTable.money*0.9).." Vero geknackt. Gratulation!",tp,0,255,0)
				givePlayerMoneyEx(tp,lottoTable.money*0.9)
				systemDeposit("Reporter", lottoTable.money*0.1, "Lotto")
				lottoTable.state = false
				lottoTable.money = 0
				lottoTable.players = {}				
			end
		end
	end
end
addCommandHandler("lotto", lottoCMD, false, false)


addCommandHandler( { "togvi"},
	function( thePlayer, commandName )
		if getElementData(thePlayer, "isPlayerLoggedIn") == true then
			if getElementData(thePlayer, "viNetworkMuted") == true then
				setElementData(thePlayer, "viNetworkMuted", false)
				triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 0,255,0, "Du hast die viNETWORK aktiviert." )
			else
				triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 0,255,0, "Du hast die viNETWORK deaktiviert." )
				setElementData(thePlayer, "viNetworkMuted", true)
			end
		end
	end
)

addCommandHandler( { "u", "news", "viONAIR"},
	function( thePlayer, commandName, ... )
		if getElementData(thePlayer, "isPlayerLoggedIn") == true then
			if setPlayerMuted ( thePlayer, true ) == false then
				outputChatBox( "Error: Du bist gemutet.", thePlayer, 255,0,0,true  )
				return false
			end
			setPlayerMuted ( thePlayer, false )		
			if getElementData(thePlayer, "job") == 9 and getElementData(thePlayer, "dienst") == 1 or getElementData(thePlayer, "interview") == true then
				local isNear = false
				local x,y,z = getElementPosition(thePlayer)
				for i,v in ipairs(getElementsByType("vehicle")) do
					if getElementModel(v) == 488 or getElementModel(v) == 582 then
						local x1,y1,z1 = getElementPosition(v)
						if getDistanceBetweenPoints3D ( x,y,z, x1,y1,z1 ) < 15 then
							isNear = true
						end
					end
				end
				if isNear == false then
					outputChatBox( "Error: Du musst in der Nähe eines Funkwagens sein.", thePlayer, 255,0,0,true  )
					return false
				end
				local message = table.concat( { ... }, " " )
				if #message > 0 then
					print("VitaOnline: [NEWS] "..getPlayerName(thePlayer)..": "..message)
					if getElementData(thePlayer, "interview") == true then
						for i,v in ipairs(getElementsByType("player")) do
							if getElementData(v, "viNetworkMuted") ~= true then
								outputChatBox("[viONAIR: Interview] "..getPlayerName(thePlayer)..": "..message, v, 173,255,47,true)
							end
						end
					else
						for i,v in ipairs(getElementsByType("player")) do
							if getElementData(v, "viNetworkMuted") ~= true then
								outputChatBox("[viONAIR] "..getPlayerName(thePlayer)..": "..message, v, 173,255,47,true)
							end
						end					
					end
					pLogger["chat_news"]:addEntry(getPlayerName(thePlayer)..": "..message)
				else
					outputChatBox( "Syntax: /" .. commandName .. " [news text]", thePlayer, 255, 255, 255 )
				end
			end
		end
	end
)

function setinterview(ply, command, playerToHeal, preis)
	if getElementData(ply, "job") == 9 and getElementData(ply, "dienst") == 1 then
		if playerToHeal ~= "" and playerToHeal ~= nil then
			thePersonToHeal = getPlayerFromName2 ( playerToHeal )
			if thePersonToHeal then
				if type(thePersonToHeal) == "table" then
					outputChatBox("Fehler: Mehrere Spieler gefunden!",ply,255,0,0)
					return
				end
				preis = tonumber(preis)
				
				if not preis then
					outputChatBox("Der Status muss entweder 1 oder 0 sein.",ply,255,0,0)
					return
				end
				if preis == 0 then
					setElementData(thePersonToHeal, "interview", false)
					outputChatBox("Du hast den Interview-Status von "..getPlayerName(thePersonToHeal).." auf 0 gestellt.", ply,0,255,0)
					outputChatBox("Dein Interview Status wurde auf 0 gestellt.", thePersonToHeal,0,255,0)
				elseif preis == 1 then
					setElementData(thePersonToHeal, "interview", true)
					outputChatBox("Dein Interview Status wurde auf 1 gestellt.", thePersonToHeal,0,255,0)
					outputChatBox("Du hast den Interview-Status von "..getPlayerName(thePersonToHeal).." auf 1 gestellt.", ply,0,255,0)
				else
					outputChatBox("Der Status muss entweder 1 oder 0 sein.",ply,255,0,0)
				end
			end
		else
			outputChatBox("Fehler: /setinterview [Spielername] [0/1]",ply,255,0,0)
		end
	end
end
addCommandHandler("setinterview",setinterview, false, false)