local v_table = {
{name = "DVP", votes = 0},
{name = "FPV", votes = 0},
{name = "AFV", votes = 0},
}
local v_players = {}

function checkExp()
	for i,v in ipairs(getElementsByType("player")) do
		if getElementData(v, "isPlayerLoggedIn") and not v_players[getPlayerName(v)] then
			outputChatBox ( "#99FFCC~PARLAMENTSWAHL~", v, 255, 255, 255, true )
			outputChatBox ( "#99FFCCDu hast noch nicht abgestimmt. Verwende /stimme [PARTEI] um deine Stimme abzugeben.", v, 255, 255, 255, true )
			local dastring = ""
			for i,v in ipairs(v_table) do
				if i ~= 1 then
					dastring = dastring..", "
				end
				dastring = dastring..""..v.name
			end
			outputChatBox ( "#99FFCCAntretende Parteien: "..dastring, v, 255, 255, 255, true )
			outputChatBox ( "#99FFCCInfos zu den Wahlprogrammen unter www.vita-online.eu", v, 255, 255, 255, true )
		end
	end
end
setTimer ( checkExp, 60000*2, 0, checkExp )
checkExp()

function abstimmen ( player, name, vote )
	if ( player and vote ) then
		if getElementData(player, "isPlayerLoggedIn") and not v_players[getPlayerName(player)] then
			for i,v in ipairs(v_table) do
				if v.name == tostring(vote) then
					v.votes = v.votes + 1
					v_players[getPlayerName(player)] = true
					outputChatBox ( "#99FFCCDu hast erfolgreich für die Partei '"..v.name.."' abgestimmt.",player, 255, 255, 255, true )
					return
				end
			end
			outputChatBox ( "#99FFCCPartei wurde nicht gefunden!", 255, 255, 255, true )
		end
	end
end
addCommandHandler ( "stimme",  abstimmen )


function ergebnis ( player, name, vote )
	if ( player and vote and vote == "88" ) then
		if getElementData(player, "isPlayerLoggedIn") then
			for i,v in ipairs(v_table) do
				outputChatBox ( "#99FFCCStimmen für '"..v.name.."': "..v.votes,player, 255, 255, 255, true )
			end
		end
	end
end
addCommandHandler ( "wahlergebnis",  ergebnis )