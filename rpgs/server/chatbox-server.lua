--[[
Project: VitaOnline
File: chatbox-server.lua
Author(s):	Golf_R32
			Sebihunter
]]--

function blockPM(msg,r)
	outputChatBox("/msg wurde deaktiviert: Verwende /sms [tel].",source,255,0,0)
	cancelEvent()
	return false
end
addEventHandler("onPlayerPrivateMessage",getRootElement(),blockPM)

function onPlayerChat( message, messageType )
	local player = source
	if getElementData(source, "isPlayerLoggedIn") == true and getElementData(source, "isWaitingForDeath") == false then
		if setPlayerMuted ( source, true ) == false then
			outputChatBox( "Error: Du bist gemutet.", source, 255,0,0,true  )
			cancelEvent()
			return false
		end
		setPlayerMuted ( source, false )
	
		if messageType == 0 then
			local posX, posY, posZ = getElementPosition( source )
			local chatSphere = createColSphere( posX, posY, posZ, 20 )
			local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
			destroyElement( chatSphere )
			print("VitaOnline: "..getPlayerName(source)..": "..message)
			for index, nearbyPlayer in ipairs( nearbyPlayers ) do
				if getElementData(nearbyPlayer, "isPlayerLoggedIn") == true then
					if getElementData(source, "promille") > 1.5 then
						message = string.gsub(message, "K", "G")
						message = string.gsub(message, "k", "g")
						message = string.gsub(message, "P", "B")
						message = string.gsub(message, "p", "b")
						message = string.gsub(message, "F", "V")
						message = string.gsub(message, "f", "v")
					end
					local x,y,z = getElementPosition(nearbyPlayer)
					local distance = getDistanceBetweenPoints3D ( posX, posY, posZ,x,y,z  )
					local r = 255-200*distance/20
					local g = 255-200*distance/20
					local b = 255-200*distance/20
					if tonumber(getElementData(source, "getPlayerSpecialRights")) == 0 then
						message = removeColorCoding(message)
					end
					outputChatBox( getPlayerName(source).." sagt: "..message, nearbyPlayer, r,g,b,true  )
					
					--[[if tonumber(getElementData(source, "getPlayerSpecialRights")) == 2 then
						outputChatBox( "#FF0000"..getPlayerName(source).." sagt: #FFFFFF"..message, nearbyPlayer, 255,255,255,true  )
					elseif tonumber(getElementData(source, "getPlayerSpecialRights")) == 1 then
						outputChatBox( "#00FF00"..getPlayerName(source).." sagt: #FFFFFF"..message, nearbyPlayer, 255,255,255,true  )
					elseif tonumber(getElementData(source, "getPlayerSpecialRights")) == 0 then
						outputChatBox( getPlayerName(source).." sagt: "..message, nearbyPlayer, 255,255,255,true  )
					end]]
				end
			end
			if isPlayerPhoning(source) then
				local tplayer = getElementData(source, "phoneTarget")
				outputChatBox( "#0CFCF4(Handy) "..getPlayerName(source).." sagt: #FFFFFF"..message, tplayer, 255,255,255,true  )
			end
			pLogger["chat_normal"]:addEntry(getPlayerName(source)..": "..message)
		elseif messageType == 1 then
			local posX, posY, posZ = getElementPosition( source )
			local chatSphere = createColSphere( posX, posY, posZ, 20 )
			local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
			destroyElement( chatSphere )
			if tonumber(getElementData(source, "getPlayerSpecialRights")) == 0 then
				message = removeColorCoding(message)
			end			
			print("/me VitaOnline: "..getPlayerName(source)..": "..message)			
			for index, nearbyPlayer in ipairs( nearbyPlayers ) do
				if getElementData(nearbyPlayer, "isPlayerLoggedIn") == true then
					outputChatBox( getPlayerName(source).." "..message, nearbyPlayer, 150,0,150,true  )
				end
			end	
			pLogger["chat_normal"]:addEntry("/me "..getPlayerName(source)..": "..message)
		elseif messageType == 2 then
			local team = getPlayerTeam(source)
			if tonumber(getElementData(source, "getPlayerSpecialRights")) == 0 then
				message = removeColorCoding(message)
			end			
			if team and getElementData(source, "dienst") == 1 then
				for k, v in pairs(getPlayersInTeam(team)) do
					if getElementData(v, "dienst") == 1 then
						outputChatBox("#aaaa00[Funk] "..getPlayerName(source)..": #ffffff"..message, v, 0, 0, 0, true)
					end
				end
				pLogger["chat_funk"]:addEntry("["..getTeamName(team).."] "..getPlayerName(source)..": "..message)
			end
		end
	end	
	cancelEvent()
end
addEventHandler( "onPlayerChat", getRootElement(), onPlayerChat )
addEvent( "onPlayerChatRemote", true )
addEventHandler( "onPlayerChatRemote", getRootElement(), onPlayerChat )


local addCommandHandler_ = addCommandHandler
addCommandHandler = function( commandName, fn, restricted, caseSensitive )
	-- add the default command handlers
	if type( commandName ) ~= "table" then
		commandName = { commandName }
	end
	for key, value in ipairs( commandName ) do
		if key == 1 then
			addCommandHandler_( value, fn, restricted, caseSensitive )
		else
			addCommandHandler_( value,
				function( player, ... )
					-- check if he has permissions to execute the command, default is not restricted (aka if the command is restricted - will default to no permission; otherwise okay)
					if hasObjectPermissionTo( player, "command." .. commandName[ 1 ], not restricted ) then
						fn( player, ... )
					end
				end
			)
		end
	end
end

addCommandHandler( "mega",
	function( thePlayer, commandName, ... )
		if getElementData(thePlayer, "isPlayerLoggedIn") == true then
			if getElementData(thePlayer, "job") ~= 3 or getElementData(thePlayer, "dienst") ~= 1 then return end
			if setPlayerMuted ( thePlayer, true ) == false then
				outputChatBox( "Error: Du bist gemutet.", thePlayer, 255,0,0,true  )
				return false
			end			
			setPlayerMuted ( thePlayer, false )			
			local message = table.concat( { ... }, " " )
			if tonumber(getElementData(thePlayer, "getPlayerSpecialRights")) == 0 then
				message = removeColorCoding(message)
			end			
			local nearbyString = ""
			if #message > 0 then
				print("VitaOnline: [MEGAPHONE] "..getPlayerName(thePlayer)..": "..message)
				pLogger["megaphone"]:addEntry(getPlayerName(thePlayer)..": "..message)
				local posX, posY, posZ = getElementPosition( thePlayer )
				local chatSphere = createColSphere( posX, posY, posZ, 50 )
				local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
				destroyElement( chatSphere )
				for index, nearbyPlayer in ipairs( nearbyPlayers ) do
					if getElementData(nearbyPlayer, "isPlayerLoggedIn") == true then
						if getElementData(thePlayer, "promille") > 1.5 then
							message = string.gsub(message, "K", "G")
							message = string.gsub(message, "k", "g")
							message = string.gsub(message, "P", "B")
							message = string.gsub(message, "p", "b")
							message = string.gsub(message, "F", "V")
							message = string.gsub(message, "f", "v")
						end
						local x,y,z = getElementPosition(nearbyPlayer)
						local distance = getDistanceBetweenPoints3D ( posX, posY, posZ,x,y,z  )
						local r = 0
						local g = 0
						local b = 255-200*distance/50
						nearbyString = nearbyString.." "..getPlayerName(nearbyPlayer)
						outputChatBox( "[Megafon] "..getPlayerName(thePlayer).." sagt: "..message, nearbyPlayer, r,g,b,true  )
					end
					outputChatBox( "[Megafon-Angekommen]"..nearbyString, thePlayer, 0,255,255,true  )
				end			
			else
				outputChatBox( "Syntax: /" .. commandName .. " [text]", thePlayer, 255, 255, 255 )
			end
		end
	end
)

addCommandHandler( { "x", "gangchat", "gc", "Gang"},
	function( thePlayer, commandName, ... )
		if getElementData(thePlayer, "isPlayerLoggedIn") == true then
			if setPlayerMuted ( thePlayer, true ) == false then
				outputChatBox( "Error: Du bist gemutet.", thePlayer, 255,0,0,true  )
				return false
			end
			setPlayerMuted ( thePlayer, false )		
			local message = table.concat( { ... }, " " )
			if tonumber(getElementData(thePlayer, "getPlayerSpecialRights")) == 0 then
				message = removeColorCoding(message)
			end			
			if #message > 0 then
				if getElementData(thePlayer, "gang") == 0 then return end
				local players = getElementsByType ( "player" )
				for theKey,player in ipairs(players) do
					if getElementData(player, "gang") == getElementData(thePlayer, "gang") then
						outputChatBox("[Gang] "..getPlayerName(thePlayer)..": #FFFFFF"..message, player, 100,165,80,true)
					end
				end
			else
				outputChatBox( "Syntax: /" .. commandName .. " [gangchat]", thePlayer, 255, 255, 255 )
			end
		end
	end
)


addCommandHandler( { "ac"},
	function( thePlayer, commandName, ... )
		if getElementData(thePlayer, "isPlayerLoggedIn") == true and tonumber(getElementData(thePlayer, "getPlayerSpecialRights")) ~= 0 then
			if setPlayerMuted ( thePlayer, true ) == false then
				outputChatBox( "Error: Du bist gemuted.", thePlayer, 255,0,0,true  )
				return false
			end
			setPlayerMuted ( thePlayer, false )				
			local message = table.concat( { ... }, " " )
			if tonumber(getElementData(thePlayer, "getPlayerSpecialRights")) == 0 then
				message = removeColorCoding(message)
			end			
			if #message > 0 then
				for i,v in ipairs(getElementsByType("player")) do
					if tonumber(getElementData(v, "getPlayerSpecialRights")) ~= 0 then
						outputChatBox("[AC] "..getPlayerName(thePlayer)..": #FFFFFF"..message, v, 165,255,0,true)
					end
				end
				print("VitaOnline: [AC] "..getPlayerName(thePlayer)..": "..message)
			else
				outputChatBox( "Syntax: /" .. commandName .. " [ac text]", thePlayer, 255, 255, 255 )
			end
		end
	end
)

local isDisabledOOC = true
addCommandHandler( { "atogooc"},
	function( thePlayer, commandName )
		if getElementData(thePlayer, "isPlayerLoggedIn") == true then
			if isDisabledOOC == true then
				isDisabledOOC = false
				outputChatBox("[OOC] "..getPlayerName(thePlayer).." hat den globalen OOC-Chat aktiviert.", getRootElement(), 255,255,0,true)
				triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 0,255,0, "Du hast den globalen OOC aktiviert." )
			else
				isDisabledOOC = true
				outputChatBox("[OOC] "..getPlayerName(thePlayer).." hat den globalen OOC-Chat deaktiviert.", getRootElement(), 255,255,0,true)
				triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 0,255,0, "Du hast den globalen OOC deaktiviert." )
			end
		end
	end
)

addCommandHandler( { "togooc"},
	function( thePlayer, commandName )
		if getElementData(thePlayer, "isPlayerLoggedIn") == true then
			if getElementData(thePlayer, "oocMuted") == true then
				setElementData(thePlayer, "oocMuted", false)
				triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 0,255,0, "Du hast deinen OOC Chat aktiviert." )
			else
				triggerClientEvent ( thePlayer, "addNotification", getRootElement(), 1, 0,255,0, "Du hast deinen OOC Chat deaktiviert." )
				setElementData(thePlayer, "oocMuted", true)
			end
		end
	end
)

addCommandHandler( { "aca" },
	function( thePlayer, commandName, ... )
		if getElementData(thePlayer, "isPlayerLoggedIn") == true then
			if setPlayerMuted ( thePlayer, true ) == false then
				outputChatBox( "Error: Du bist gemutet.", thePlayer, 255,0,0,true  )
				return false
			end
			setPlayerMuted ( thePlayer, false )		
			if tonumber(getElementData(thePlayer, "getPlayerSpecialRights")) == 0 then
				return false
			end			
			local message = table.concat( { ... }, " " )
			if #message > 0 then
				print("VitaOnline: [ADMIN] "..getPlayerName(thePlayer)..": "..message)
				outputChatBox("#FF0000[ADMIN] "..getPlayerName(thePlayer)..": #FFFFFF"..message, getRootElement(), 255,165,0,true)
				pLogger["chat_ooc"]:addEntry("[ADMIN] "..getPlayerName(thePlayer)..": "..message)
			else
				outputChatBox( "Syntax: /" .. commandName .. " [text]", thePlayer, 255, 255, 255 )
			end
		end
	end
)

addCommandHandler( { "L-OOC", "LOOC", "l"},
	function( thePlayer, commandName, ... )
		if getElementData(thePlayer, "isPlayerLoggedIn") == true then
			if setPlayerMuted ( thePlayer, true ) == false then
				outputChatBox( "Error: Du bist gemutet.", thePlayer, 255,0,0,true  )
				return false
			end
			setPlayerMuted ( thePlayer, false )		
			if getElementData(thePlayer, "oocMuted") == true then
				return outputChatBox( "Error: Du hast den OOC lokal deaktiviert. Verwende zuerst /togooc.", thePlayer, 255,0,0,true  )
			end			
			local message = table.concat( { ... }, " " )
			if #message > 0 then
				local posX, posY, posZ = getElementPosition( thePlayer )
				local chatSphere = createColSphere( posX, posY, posZ, 20 )
				local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
				destroyElement( chatSphere )
				print("VitaOnline: [L-OOC] "..getPlayerName(thePlayer)..": "..message)
				for index, nearbyPlayer in ipairs( nearbyPlayers ) do
					if getElementData(nearbyPlayer, "isPlayerLoggedIn") == true and getElementData(thePlayer, "oocMuted") ~= true then
						local x,y,z = getElementPosition(nearbyPlayer)
						local distance = getDistanceBetweenPoints3D ( posX, posY, posZ,x,y,z  )
						local r = 255-200*distance/20
						local g = 212-157*distance/20
						local b = 113-58*distance/20
						outputChatBox( "[L-OOC] "..getPlayerName(thePlayer)..": #FFFFFF"..message, nearbyPlayer, r,g,b,true  )
					end		
				end
			else
				outputChatBox( "Syntax: /" .. commandName .. " [l-ooc text]", thePlayer, 255, 255, 255 )
			end			
		end
	end
)

addCommandHandler( { "O.O.C", "o", "ooc"},
	function( thePlayer, commandName, ... )
		if getElementData(thePlayer, "isPlayerLoggedIn") == true then
			if setPlayerMuted ( thePlayer, true ) == false then
				outputChatBox( "Error: Du bist gemutet.", thePlayer, 255,0,0,true  )
				return false
			end
			setPlayerMuted ( thePlayer, false )		
			if getElementData(thePlayer, "oocMuted") == true then
				return outputChatBox( "Error: Du hast den OOC lokal deaktiviert. Verwende zuerst /togooc.", thePlayer, 255,0,0,true  )
			end
			if isDisabledOOC == true then
				return outputChatBox( "Error: Der OOC wurde von der Administration temporär deaktiviert.", thePlayer, 255,0,0,true  )
			end
			if tonumber(getElementData(thePlayer, "getPlayerSpecialRights")) == 0 then
				message = removeColorCoding(message)
			end			
			local message = table.concat( { ... }, " " )
			if #message > 0 then
				print("VitaOnline: [OOC] "..getPlayerName(thePlayer)..": "..message)
				for i,v in ipairs(getElementsByType("player")) do
					if getElementData(v, "oocMuted") ~= true then
						outputChatBox("[OOC] "..getPlayerName(thePlayer)..": #FFFFFF"..message, v, 255,165,0,true)
					end
				end
				pLogger["chat_ooc"]:addEntry(getPlayerName(thePlayer)..": "..message)
			else
				outputChatBox( "Syntax: /" .. commandName .. " [ooc text]", thePlayer, 255, 255, 255 )
			end
		end
	end
)
