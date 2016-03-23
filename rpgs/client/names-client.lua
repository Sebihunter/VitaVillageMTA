--[[
Project: VitaOnline
File: names-client.lua
Author(s):	Golf_R32
			Sebihunter
]]--
setTimer(function()
	local sx = screenWidth/2
    local sy = screenHeight/2
    local x, y, z = getWorldFromScreenPosition(sx, sy, 10)
	setElementData(getLocalPlayer(), "lookAt", {x,y,z})
	
	if isConsoleActive() or isChatBoxInputActive () then
		setElementData(getLocalPlayer(), "isChat", true)
	else
		setElementData(getLocalPlayer(), "isChat", false)
	end
	
	for i,v in ipairs(getElementsByType("player", true)) do
		if type(getElementData(v, "lookAt")) == "table" and not getPedOccupiedVehicle(v) and not getPedControlState(v, "aim_weapon") and v~= getLocalPlayer() then
			local lookAt = getElementData(v, "lookAt")
			setPedAimTarget(v,lookAt[1], lookAt[2], lookAt[3]) --Workaround
			setPedLookAt(v, lookAt[1], lookAt[2], lookAt[3])
		end
	end
end, 500,0)

setTimer(function()
	local sx = screenWidth/2
    local sy = screenHeight/2
	local x, y, z = getWorldFromScreenPosition(sx, sy, 10)
	setPedLookAt(getLocalPlayer(), x,y,z)
end, 100, 0)

local is_u_bound = false
local datime = {}
g_ReversGear = {}

local isHigh = false
local drunkEffects = false
local drugSound = nil
local default_bold_big = false
local default_bold_smaller = false
local default_stars = false

local self_alpha = 0
local self_hover = false
local star_x = 0

local playerColor = {}

function isHovingSkinImage()
	return self_hover
end

addEventHandler( "onClientRender", getRootElement(),
	function(  )
		if not default_bold_big then default_bold_big = dxCreateFont ( "Tahoma.ttf", 10, true ) end
		if not default_bold_smaller then default_bold_smaller = dxCreateFont ( "Tahoma.ttf", 7, true ) end
		if not default_stars then default_stars = dxCreateFont ( "Tahoma.ttf", 5, false) end
		if getElementData(getLocalPlayer(), "isPlayerLoggedIn") ~= true then return false end
		if getElementData(getLocalPlayer(), "isPlayerLoggedIn") == true then
			local time = getRealTime()
			datime[1],datime[2],datime[3],datime[4],datime[5],datime[6] = time.monthday,time.month,time.year , time.hour, time.minute, time.second
			for i = 1, #datime do
				if string.len(datime[i]) == 1 then
					datime[i] = "0"..datime[i]
				end
			end
			
			for i,v in ipairs(getElementsByType("vehicle", true)) do
				if getElementData(v, "reverse") == true then
					if not g_ReversGear[v] or not isElement(g_ReversGear[v]) then
						local x,y,z = getElementPosition(v)
						g_ReversGear[v] = playSound3D ( "sounds/rueckwaertsfahrsound.mp3",x,y,z, true )
						setSoundMaxDistance( g_ReversGear[v],40 )
						attachElements(g_ReversGear[v],v)
					end
				else
					if g_ReversGear[v] and isElement(g_ReversGear[v]) then
						stopSound(g_ReversGear[v])
					end
				end
			end
			
			if getElementData(getLocalPlayer(), "promille") > 1.5 and drunkEffects == false then
				drunkEffects = true
				setBlurLevel(90000)
				setSkyGradient()
				setSunSize(25)
				setSunColor(125,0,0,0,0,0)
				setWindVelocity(25,25,25)
				if not isHigh then
					enableContrast()
				end
			elseif drunkEffects == true and getElementData(getLocalPlayer(), "promille") < 1.5 then
				drunkEffects = false
				resetSunSize()
				setBlurLevel(0)
				resetSkyGradient()
				resetSunColor()
				resetWindVelocity()
				if not isHigh then
					disableContrast()
				end
			end
			
			if getElementData(getLocalPlayer(), "isHigh") == true and isHigh == false then
				fadeCamera(false, 0.25, 255, 255, 255)
				setTimer(fadeCamera, 250, 1, true, 0.25)	
				isHigh = true
				setGravity ( 0.005 )
				setFogDistance ( 20 )
				setGameSpeed ( 0.7 )
				startBlockShader()
				if not drugSound then
					drugSound = playSound("sounds/drugs.mp3", true)
					setSoundVolume(drugSound, 0.05)
				end
				if not drunkEffects then
					enableContrast()
				end
			elseif not getElementData(getLocalPlayer(), "isHigh") and isHigh == true then
				isHigh = false
				if drugSound then stopSound(drugSound) drugSound = nil end
				fadeCamera(false, 0.25, 255, 255, 255)
				setTimer(fadeCamera, 250, 1, true, 0.25)				
				resetFogDistance()
				setGravity ( 0.008 )
				setGameSpeed ( 1 )
				stopBlockShader()
				if not drunkEffects then
					disableContrast()
				end
			end
			
			if getElementData(getLocalPlayer(), "afk") == true then
				dxDrawRectangle ( 0, 0 , screenWidth, screenHeight, tocolor ( 0,0,0,255 ))
				dxDrawText( "~AFK~",  0, 0, screenWidth, screenHeight, tocolor( 0,0,0, 255 ), 1.02, "bankgothic", "right", "bottom", false, false, false)
				dxDrawText( "~AFK~-",  0, 0, screenWidth, screenHeight, tocolor( 255, 127, 0, 255 ), 1.02, "bankgothic", "right", "bottom", false, false, false) 
			else
				--Wenn Hygiene unten -> Dann
				if getElementData(getLocalPlayer(), "getPlayerHygiene") <= 0 then
					dxDrawRectangle ( 0, 0 , screenWidth, screenHeight, tocolor ( 0,10,0,230 ))
					dxDrawText( "Du hast Dreck im Auge!\n Wasch dich um deine Sicht zu verbessern!",  0, 0, screenWidth, screenHeight, tocolor( 0,0,0, 255 ), 1.02, "bankgothic", "right", "bottom", false, false, false)
					dxDrawText( "Du hast Dreck im Auge!\n Wasch dich um deine Sicht zu verbessern!",  0, 0, screenWidth, screenHeight, tocolor( 255, 255, 255, 255 ), 1.02, "bankgothic", "right", "bottom", false, false, false) 
				end

				if getElementData(getLocalPlayer(), "amSchlafen") == true then
					dxDrawRectangle ( 0, 0 , screenWidth, screenHeight, tocolor ( 0,0,0,255 ))
					dxDrawText( "Du schläfst gerade!\n Druecke BACKSPACE um aufzuwachen.",  0, 0, screenWidth, screenHeight, tocolor( 0,0,0, 255 ), 1.02, "bankgothic", "right", "bottom", false, false, false)
					dxDrawText( "Du schläfst gerade!\n Druecke BACKSPACE um aufzuwachen.",  0, 0, screenWidth, screenHeight, tocolor( 255, 127, 0, 255 ), 1.02, "bankgothic", "right", "bottom", false, false, false) 
				end
			end
				
			if getElementData(getLocalPlayer(), "isWaitingForDeath") == true then
				dxDrawRectangle ( screenWidth/2-200, screenHeight/2-100, 400, 200, tocolor ( 0, 0, 0, 150 ) )
				dxDrawText ( "Schwer verletzt...", screenWidth/2-200+6, screenHeight/2-100+6, screenWidth, screenHeight, tocolor ( 0, 0, 0, 255 ), 1, "bankgothic" )
				dxDrawText ( "Schwer verletzt...", screenWidth/2-200+5, screenHeight/2-100+5, screenWidth, screenHeight, tocolor ( 255, 150, 0, 255 ), 1, "bankgothic" )
				dxDrawText ( "Warte bis ein Sanitäter dich wiederbelebt.", 1, screenHeight/2-50+1, screenWidth, screenHeight, tocolor ( 0, 0, 0, 255 ), 1, "clear", "center" )
				dxDrawText ( "Warte bis ein Sanitäter dich wiederbelebt.", 0, screenHeight/2-50, screenWidth, screenHeight, tocolor ( 255, 255, 255, 255 ), 1, "clear", "center" )
				if getElementData(getLocalPlayer(), "todestimer") then
					dxDrawText ( "Zeit bis zum Respawn am Krankenhaus:\n"..tostring(getElementData(getLocalPlayer(), "todestimer")), 1, screenHeight/2+50+1, screenWidth, screenHeight, tocolor ( 0, 0, 0, 255 ), 1, "sans", "center" )
					dxDrawText ( "Zeit bis zum Respawn am Krankenhaus:\n"..tostring(getElementData(getLocalPlayer(), "todestimer")), 0, screenHeight/2+50, screenWidth, screenHeight, tocolor ( 255, 255, 255, 255 ), 1, "sans", "center" )
				end
				setElementHealth(getLocalPlayer(), 100)
			end	
			if getElementData(getLocalPlayer(), "einsperrzeit") ~= 0 then
				dxDrawShadowedText( "Restliche Knastzeit: "..tostring(getElementData(getLocalPlayer(), "einsperrzeit")).." Minuten",  0, 30, screenWidth, screenHeight,tocolor( 255,255,0, 255 ), tocolor( 0,0,0, 255 ), 1.02, "bankgothic", "center", "top", false, false, false)
			end				
			------222
			------158
			if getElementData(getLocalPlayer(), "job") == 9 and getElementData(getLocalPlayer(), "dienst") == 1 or getElementData(getLocalPlayer(), "interview") == true then
				if is_u_bound == false then
					bindKey("u", "down", "chatbox", "viONAIR" )
					is_u_bound = true
				end
			else
				if is_u_bound == true then
					unbindKey("u", "down" )
					is_u_bound = false
				end			
			end	
			
			if getElementData(getLocalPlayer(), "hideTacho") ~= true  then
				--Benutzer UI Zeichnen		
				local stars = ""
				local akte = getElementData(getLocalPlayer(), "akte")
				if akte and isElement(akte) then
					local wanteds = getElementData(akte, "wantedLevel")
					if wanteds > 0 then
						for i=1,wanteds do
							stars = stars.."\n★"
						end
					end
				end				
				if stars ~= "" and star_x < 15 then
					star_x = star_x+0.5
				elseif stars == "" and star_x > 0 then
					star_x = star_x - 0.5
				end
				
				if star_x > 15 then star_x = 15 end
				if star_x < 0 then star_x = 0 end
				
				if star_x ~= 0 then
					dxDrawText(tostring(stars), screenWidth-star_x+1, 8, screenWidth, 41, tocolor(0,0,0,200), 1, default_stars, "left", "center")
					dxDrawText(tostring(stars), screenWidth-star_x, 7, screenWidth, 40, tocolor(255,255,0,255), 1, default_stars, "left", "center")
				end
				
				local cx, cy = getCursorPosition ( )
				if cx then
					cx = cx*screenWidth
					cy = cy*screenHeight
				end
				 
				self_hover = false
				if cx and cx >= screenWidth-53-star_x and cy >= 7 and cx <= screenWidth-53-star_x+43.5 and cy <= 47 then
					self_hover = true
				end
				
				
				if self_hover and self_alpha < 255 then
					self_alpha = self_alpha+30
					if self_alpha > 255 then self_alpha = 255 end
				elseif not self_hover and self_alpha > 0 then
					self_alpha = self_alpha - 30
					if self_alpha < 0 then self_alpha = 0 end
				end
				
				dxDrawRectangle ( screenWidth-53-star_x, 7, 43.5, 40, tocolor(255,255,255,150))
				dxDrawLine ( screenWidth-54-star_x, 7, screenWidth-54-star_x, 47, tocolor(255,255,255,255))
				dxDrawLine ( screenWidth-54-star_x, 7, screenWidth-9.5-star_x, 7, tocolor(255,255,255,255))
				dxDrawLine ( screenWidth-54-star_x, 47, screenWidth-9.5-star_x, 47, tocolor(255,255,255,255))
				dxDrawLine ( screenWidth-9.5-star_x, 7, screenWidth-9.5-star_x, 47, tocolor(255,255,255,255))
				if  fileExists("images/skins/"..tostring(getElementModel(getLocalPlayer()))..".png") then
					dxDrawImage(screenWidth-52-star_x, 8, 42.5, 39, "images/skins/"..tostring(getElementModel(getLocalPlayer()))..".png", 0, 0, 0, tocolor(255,255,255,255), false)
				end
				
				if self_alpha ~= 0 then
					dxDrawRectangle ( screenWidth-53-star_x, 7, 43.5, 40, tocolor(255,255,255,self_alpha*0.3))
					dxDrawText("Öffnen", screenWidth-54-star_x, 7, screenWidth-9.6-star_x, 46, tocolor(0,0,0,self_alpha*0.4), 1, default_bold_smaller, "center", "bottom", false, false, false, false, true)
					dxDrawText("Öffnen", screenWidth-53-star_x, 7, screenWidth-9.5-star_x, 45, tocolor(255,255,255,self_alpha), 1, default_bold_smaller, "center", "bottom", false, false, false, false, true)					
				end
				dxDrawText(getNameWithoutDots( getPlayerName(getLocalPlayer()) ), screenWidth, 12, screenWidth-57-star_x, screenHeight, tocolor(0,0,0,200), 1, default_bold_big, "right", "top", false, false, false, false, true)
				dxDrawText(getNameWithoutDots( getPlayerName(getLocalPlayer()) ), screenWidth, 11, screenWidth-58-star_x, screenHeight, tocolor(255,255,255,255), 1, default_bold_big, "right", "top", false, false, false, false, true)
			
				if math.round(getPlayerMoneyEx(getLocalPlayer())) ~= getPlayerMoneyEx(getLocalPlayer()) then setPlayerMoneyEx(math.round(getPlayerMoneyEx(getLocalPlayer()))) end
				if getPlayerMoneyEx(getLocalPlayer()) >= 0 then
					dxDrawText(tostring(getPlayerMoneyEx(getLocalPlayer())).." Vero", screenWidth, 28, screenWidth-57-star_x, screenHeight, tocolor(0,0,0,200), 1, "default-bold", "right", "top", false, false, false, false, true)
					dxDrawText(tostring(getPlayerMoneyEx(getLocalPlayer())).." Vero", screenWidth, 27, screenWidth-58-star_x, screenHeight, tocolor(0,255,0,255), 1, "default-bold", "right", "top", false, false, false, false, true)
				else
					dxDrawText(tostring(getPlayerMoneyEx(getLocalPlayer())).." Vero", screenWidth, 28, screenWidth-57-star_x, screenHeight, tocolor(0,0,0,200), 1, "default-bold", "right", "top", false, false, false, false, true)
					dxDrawText(tostring(getPlayerMoneyEx(getLocalPlayer())).." Vero", screenWidth, 27, screenWidth-58-star_x, screenHeight, tocolor(255,0,0,255), 1, "default-bold", "right", "top", false, false, false, false, true)
				end		
				
				local needed = getElementData(getLocalPlayer(), "neededScore")
				local last = getElementData(getLocalPlayer(), "lastScore")
				local xp = getElementData(getLocalPlayer(), "exp")
				dxDrawProgressBar(screenWidth-150, 60, 138, 20, tocolor(255, 255, 255, 150), tocolor(0, 221, 255, 200), tocolor(0, 221, 255, 200), (xp-last)/(needed-last), true)
				dxDrawText("Level "..getElementData(getLocalPlayer(), "level"), screenWidth-149, 61, screenWidth-12, 81, tocolor(0,0,0,150), 1, default_bold_smaller, "center", "center", false, false, false, false, true)
				dxDrawText("Level "..getElementData(getLocalPlayer(), "level"), screenWidth-150, 60, screenWidth-13, 80, tocolor(255,255,255,255), 1, default_bold_smaller, "center", "center", false, false, false, false, true)
				
				dxDrawProgressBar(screenWidth-150, 90, 138, 15, tocolor(255, 255, 255, 150), tocolor(168, 255, 18, 200), tocolor(168, 255, 18, 200), getElementData(getLocalPlayer(), "getPlayerEnergie")/100, true);
				dxDrawText("Energie", screenWidth-149, 91, screenWidth-12, 106, tocolor(0,0,0,150), 1, default_bold_smaller, "center", "center", false, false, false, false, true)
				dxDrawText("Energie", screenWidth-150, 90, screenWidth-13, 105, tocolor(255,255,255,255), 1, default_bold_smaller, "center", "center", false, false, false, false, true)				
				
				dxDrawProgressBar(screenWidth-150, 110, 138, 15, tocolor(255, 255, 255, 150), tocolor(255, 57, 31, 200), tocolor(255, 57, 31, 200), getElementData(getLocalPlayer(), "getPlayerHunger")/100, true);
				dxDrawText("Hunger", screenWidth-149, 111, screenWidth-12, 126, tocolor(0,0,0,150), 1, default_bold_smaller, "center", "center", false, false, false, false, true)
				dxDrawText("Hunger", screenWidth-150, 111, screenWidth-13, 125, tocolor(255,255,255,255), 1, default_bold_smaller, "center", "center", false, false, false, false, true)	

				dxDrawProgressBar(screenWidth-150, 130, 138, 15, tocolor(255, 255, 255, 150), tocolor(248, 255, 54, 200), tocolor(248, 255, 54, 200), getElementData(getLocalPlayer(), "getPlayerHarndrang")/100, true);
				dxDrawText("Harndrang", screenWidth-149, 131, screenWidth-12, 146, tocolor(0,0,0,150), 1, default_bold_smaller, "center", "center", false, false, false, false, true)
				dxDrawText("Harndrang", screenWidth-150, 130, screenWidth-13, 145, tocolor(255,255,255,255), 1, default_bold_smaller, "center", "center", false, false, false, false, true)	

				dxDrawProgressBar(screenWidth-150, 150, 138, 15, tocolor(255, 255, 255, 150), tocolor(143, 92, 255, 200), tocolor(143, 92, 255, 200), getElementData(getLocalPlayer(), "getPlayerHygiene")/100, true);
				dxDrawText("Hygiene", screenWidth-149, 151, screenWidth-12, 166, tocolor(0,0,0,150), 1, default_bold_smaller, "center", "center", false, false, false, false, true)
				dxDrawText("Hygiene", screenWidth-150, 150, screenWidth-13, 165, tocolor(255,255,255,255), 1, default_bold_smaller, "center", "center", false, false, false, false, true)	
				
				if getElementData(getLocalPlayer(), "oocMuted") then
					dxDrawText("OOC lokal deaktiviert", screenWidth-149, 181, screenWidth-12, 196, tocolor(0,0,0,150), 1, default_bold_smaller, "center", "center", false, false, false, false, true)
					dxDrawText("OOC lokal deaktiviert", screenWidth-150, 180, screenWidth-13, 195, tocolor(255,100,0,255), 1, default_bold_smaller, "center", "center", false, false, false, false, true)		
				end
				if getElementData(getLocalPlayer(), "viNetworkMuted") then
					dxDrawText("viNETWORK lokal deaktiviert", screenWidth-149, 191, screenWidth-12, 196, tocolor(0,0,0,150), 1, default_bold_smaller, "center", "center", false, false, false, false, true)
					dxDrawText("viNETWORK lokal deaktiviert", screenWidth-150, 190, screenWidth-13, 195, tocolor(255,100,0,255), 1, default_bold_smaller, "center", "center", false, false, false, false, true)		
				end				
				
				if tonumber(getElementData(getLocalPlayer(), "getPlayerSpecialRights")) ~= 0 then
					local supp = 0
					for i,v in ipairs(getElementsByType("report")) do
						if getElementData(v, "read") == false then
							supp = supp + 1		
						end
					end		
					if supp ~= 0 then
						dxDrawText(supp.." neue Supportanfrage(n)", screenWidth-149, 201, screenWidth-12, 206, tocolor(0,0,0,150), 1, default_bold_smaller, "center", "center", false, false, false, false, true)
						dxDrawText(supp.." neue Supportanfrage(n)", screenWidth-150, 200, screenWidth-13, 205, tocolor(255,0,100,255), 1, default_bold_smaller, "center", "center", false, false, false, false, true)	
					end
				end
				
				if fileExists("images/weapons/"..getPedWeapon(getLocalPlayer())..".png") then
					dxDrawImage(5, screenHeight-66, 64,64, "images/weapons/"..getPedWeapon(getLocalPlayer())..".png", 0, 0, 0, tocolor(255,255,255,255), false)
				end
					
				if getPedTotalAmmo(getLocalPlayer()) ~= 1 then
					dxDrawText(tostring(getPedAmmoInClip ( getLocalPlayer() )).." / "..tostring(getPedTotalAmmo( getLocalPlayer() )), 6, screenHeight-65, 65, screenHeight-64, tocolor(0,0,0,200), 1, default_bold_smaller, "center", "bottom", false, false, false, false, true)
					dxDrawText(tostring(getPedAmmoInClip ( getLocalPlayer() )).." / "..tostring(getPedTotalAmmo( getLocalPlayer() )), 5, screenHeight-65, 64, screenHeight-65, tocolor(255,255,255,255), 1, default_bold_smaller, "center", "bottom", false, false, false, false, true)
				end
				if getPedArmor(getLocalPlayer()) ~= 0 then
					dxDrawProgressBar(70, screenHeight-37, 80, 5, tocolor(255, 255, 255, 150), tocolor(125, 125, 125, 200), tocolor(125, 125, 125, 200),getPedArmor(getLocalPlayer())/100, true)
					if getPedOxygenLevel (getLocalPlayer() ) ~= 1000 then 
						dxDrawProgressBar(70, screenHeight-47, 80, 5, tocolor(255, 255, 255, 150), tocolor(0, 0, 255, 200), tocolor(0, 0, 255, 200),getPedOxygenLevel (getLocalPlayer() )/1000, true)
					end
				elseif getPedOxygenLevel (getLocalPlayer() ) ~= 1000 then 
					dxDrawProgressBar(70, screenHeight-37, 80, 5, tocolor(255, 255, 255, 150), tocolor(0, 0, 255, 200), tocolor(0, 0, 255, 200),getPedOxygenLevel (getLocalPlayer() )/1000, true)
				end
				dxDrawProgressBar(70, screenHeight-27, 80, 5, tocolor(255, 255, 255, 150), tocolor(255, 0, 0, 200), tocolor(255, 0, 0, 200),getElementHealth(getLocalPlayer())/100, true)
				
				dxDrawText(datime[4]..":"..datime[5]..":"..datime[6].."  "..datime[1].."."..(datime[2]+1).."."..(datime[3]+1900), 71, screenHeight-18, screenWidth, screenHeight, tocolor(0,0,0,200), 1, default_bold_smaller, "left", "top", false, false, false, false, true)
				dxDrawText(datime[4]..":"..datime[5]..":"..datime[6].."  "..datime[1].."."..(datime[2]+1).."."..(datime[3]+1900), 70, screenHeight-19, screenWidth, screenHeight, tocolor(255,255,255,255), 1, default_bold_smaller, "left", "top", false, false, false, false, true)
				--[[

				if getPedWeapon(getLocalPlayer()) ~= 0 then
					dxDrawText("Waffe:", screenWidth-98, 33, screenWidth, screenHeight, tocolor(255,255,255,255), 1, "default-bold")
					dxDrawText(getWeaponNameFromID(getPedWeapon(getLocalPlayer())), screenWidth-58, 33, screenWidth, screenHeight, tocolor(255,255,255,255), 1, "default-bold")
					if getPedTotalAmmo(getLocalPlayer()) ~= 1 then
						dxDrawText(tostring(getPedAmmoInClip ( getLocalPlayer() )).." / "..tostring(getPedTotalAmmo( getLocalPlayer() )), screenWidth-98, 45, screenWidth, screenHeight, tocolor(255,255,255,255), 0.8, "default-bold")
					end
				end

				
				dxDrawText(datime[4]..":"..datime[5]..":"..datime[6].."  "..datime[1].."."..(datime[2]+1).."."..(datime[3]+1900), screenWidth-217, 148, screenWidth, screenHeight, tocolor(255,255,255,255), 0.75, "clear", "right")

				--Beduerfnisse
				dxDrawText("Energie:", screenWidth-169, 58, screenWidth, screenHeight, tocolor(255,255,255,255), 0.75, "arial")
				dxDrawProgressBar(screenWidth-169, 73, 75, 10, tocolor(0, 255, 0, 75), tocolor(104, 255, 104, 255), tocolor(10, 200, 0, 255), getElementData(getLocalPlayer(), "getPlayerEnergie")/100);
				
				dxDrawText("Hunger:", screenWidth-169, 88, screenWidth, screenHeight, tocolor(255,255,255,255), 0.75, "arial")
				dxDrawProgressBar(screenWidth-169, 103, 75, 10, tocolor(255, 0, 0, 75), tocolor(255, 104, 104, 255), tocolor(200, 10, 0, 255), getElementData(getLocalPlayer(), "getPlayerHunger")/100);
				
				dxDrawText("Harndrang:", screenWidth-85, 58, screenWidth, screenHeight, tocolor(255,255,255,255), 0.75, "arial")
				dxDrawProgressBar(screenWidth-85, 73, 75, 10, tocolor(255, 255, 0, 75), tocolor(200, 200, 100, 255), tocolor(125, 125, 20, 255), getElementData(getLocalPlayer(), "getPlayerHarndrang")/100);
		
				dxDrawText("Hygiene:", screenWidth-85, 88, screenWidth, screenHeight, tocolor(255,255,255,255), 0.75, "arial")
				dxDrawProgressBar(screenWidth-85, 103, 75, 10, tocolor(0, 0, 255, 75), tocolor(75, 75, 255, 255), tocolor(50, 50, 200, 255), getElementData(getLocalPlayer(), "getPlayerHygiene")/100);
				
				dxDrawText("Leben/Schutzweste:", screenWidth-169, 118, screenWidth, screenHeight, tocolor(255,255,255,255), 0.75, "arial")
				dxDrawProgressBar(screenWidth-169, 133, 160, 5, tocolor(255, 0, 0, 75), tocolor(255, 75, 75, 255), tocolor(255, 75, 75, 255), getElementHealth(getLocalPlayer())/100);
				dxDrawProgressBar(screenWidth-169, 140, 160, 5, tocolor(200, 200, 200, 75), tocolor(125, 125, 125, 255), tocolor(125, 125, 125, 255), getPedArmor(getLocalPlayer())/100);
				]]
			end
			
			if getElementData(getLocalPlayer(), "gangText") ~= false then
				dxDrawText("Zeit bis zur Eroberung: "..getElementData(getLocalPlayer(), "gangText").." sec", 1, 11, screenWidth, screenHeight, tocolor(0,0,0,255), 0.8, "bankgothic", "center")
				dxDrawText("Zeit bis zur Eroberung: "..getElementData(getLocalPlayer(), "gangText").." sec", 0, 10, screenWidth, screenHeight, tocolor(255,0,255,255), 0.8, "bankgothic", "center")
			end
			
			
			
			if g_showTooltip == true then
				if g_tooltipPosY + 5 < 0 then 
					g_tooltipPosY = g_tooltipPosY + 5
				else
					g_tooltipPosY = 0
				end
				dxDrawRectangle ( screenWidth/2-200, 0+g_tooltipPosY , 400, 100, tocolor ( 255,255,255,150 ))
				dxDrawLine (  screenWidth/2-200, 0+g_tooltipPosY, screenWidth/2-200, 0+g_tooltipPosY+100, tocolor(255,255,255,255))
				dxDrawLine (  screenWidth/2+200, 0+g_tooltipPosY, screenWidth/2+200, 0+g_tooltipPosY+100, tocolor(255,255,255,255))
				dxDrawLine (  screenWidth/2-200, 0+g_tooltipPosY+100, screenWidth/2+200, 0+g_tooltipPosY+100, tocolor(255,255,255,255))
				dxDrawText("Wusstest du bereits?", screenWidth/2-195, 10+g_tooltipPosY, screenWidth/2+195, screenHeight, tocolor(51, 204, 255,255), 1, "default-bold", "left")
				dxDrawText(g_tooltipText, screenWidth/2-195, 25+g_tooltipPosY, screenWidth/2+195, 365, tocolor(30, 30, 30,255), 1, "default", "left", "top", true, true)	
			else
				if g_tooltipPosY - 5 > -100 then 
					g_tooltipPosY = g_tooltipPosY - 5
					dxDrawRectangle ( screenWidth/2-200, 0+g_tooltipPosY , 400, 100, tocolor ( 255,255,255,150 ))
					dxDrawLine (  screenWidth/2-200, 0+g_tooltipPosY, screenWidth/2-200, 0+g_tooltipPosY+100, tocolor(255,255,255,255))
					dxDrawLine (  screenWidth/2+200, 0+g_tooltipPosY, screenWidth/2+200, 0+g_tooltipPosY+100, tocolor(255,255,255,255))
					dxDrawLine (  screenWidth/2-200, 0+g_tooltipPosY+100, screenWidth/2+200, 0+g_tooltipPosY+100, tocolor(255,255,255,255))			
					dxDrawText("Wusstest du bereits?", screenWidth/2-195, 10+g_tooltipPosY, screenWidth/2+195, screenHeight, tocolor(51, 204, 255,255), 1, "default-bold", "left")
					dxDrawText(g_tooltipText, screenWidth/2-195, 25+g_tooltipPosY, screenWidth/2+195, 365, tocolor(30, 30, 30,255), 1, "default-", "left", "top", true, true)	
				else
					g_tooltipPosY = -100
				end
			end	
		end
		
		local sx = screenWidth/2
        local sy = screenHeight/2
        local x, y, z = getWorldFromScreenPosition(sx, sy, 10)
	
		
		local pBusData = {}
		local players = getElementsByType("player")
		for _,v in pairs(players) do
			local x, y, z = getElementPosition( v )
			local x1, y1, z1 = getElementPosition( getLocalPlayer() )
			local cx, cy, cz = getCameraMatrix()
			if getElementData(v, "busLine") then
				pBusData[#pBusData+1] = {}
				pBusData[#pBusData].line = getElementData(v, "busLine")
				pBusData[#pBusData].at = getElementData(v, "busAt")
			end
			z = z + 1.02
			setPlayerNametagShowing ( v, false )
			if isElementOnScreen( v ) and v ~= getLocalPlayer() and getDistanceBetweenPoints3D ( x, y, z, x1, y1, z1 ) <= 60.0 and isLineOfSightClear(cx, cy, cz, x,y,z, true, false, false) == true then
				if not playerColor[v] then playerColor[v] = {math.random(50,255),math.random(50,255),math.random(50,255)} end
				local posSmaller = getDistanceBetweenPoints3D ( x, y, z, x1, y1, z1 )/10
				if posSmaller < 1 then
					posSmaller = 1
				end
				local X, Y = getScreenFromWorldPosition( x, y, z )
				local fontDistance = dxGetFontHeight ( 2/posSmaller,"default-bold" )
				local fontDistance = dxGetFontHeight ( 1.5/posSmaller,"default-bold" )
				if X then			
					local namestring = getNameWithoutDots( getPlayerName(v) )
					local twidth = dxGetTextWidth ( namestring,  1.3/posSmaller, "default-bold", false )
					local x_start = X-twidth/2-fontDistance*1.5/2-2.5
					dxDrawImage ( x_start, Y-fontDistance*1.5/2, fontDistance*1.5, fontDistance*1.5, "images/circle.png", 0, 0,0, tocolor(playerColor[v][1],playerColor[v][2],playerColor[v][3],200) )
					dxDrawText( getElementData(v, "level"),  x_start, Y - 50+1, x_start+fontDistance*1.5, Y+50, tocolor( 255,255,255, 255 ), 1.3/posSmaller, "default-bold", "center", "center", false, false, false, false, true)
					dxDrawText( namestring, x_start+fontDistance*1.5+5+1, Y - fontDistance*1.5/2+1, screenWidth+1, screenHeight+1, tocolor( 0,0,0, 255 ), 1.2/posSmaller, "default-bold", "left", "top", false, false, false, false, true)
					dxDrawText( namestring, x_start+fontDistance*1.5+5+1, Y - fontDistance*1.5/2, screenWidth, screenHeight, tocolor( 255, 255, 255, 255 ), 1.2/posSmaller, "default-bold", "left", "top", false, false, false, false, true) 			
					
					local job = getElementData(v, "job")
					local linestring = ""

					if getElementData(v, "dienst") == 0 then
						if getElementData(v, "gang") == 1 then
							linestring = linestring.."#FF0000La Piedra"
						elseif getElementData(v, "gang") == 2 then
							linestring = linestring.."#00FF00Heaven Devils"				
						elseif getElementData(v, "gang") == 3 then
							linestring = linestring.."#FFFF00Da Nangs"				
						else
							linestring = "Zivilist"
						end
					else
						linestring = tostring(gJobData[job].bankname)
					end
					
					if getElementData(v, "afk") == true then
						linestring = linestring.."#FFFFFF AFK"
					else
						if getElementData(v, "isWaitingForDeath") == true then
							linestring = linestring.."#FFFFFF #990000†"
						end
						if getElementData(v, "getPlayerHygiene") <= 0 then
							linestring = linestring.."#FFFFFF #996633♨"
						end
					end
					
					if getElementData(v, "phoneState") == 3 then
						linestring = linestring.."#FFFFFF #81DAF5☎"
					end
					
					if getElementData(v, "isChat") == true then
						linestring = linestring.."#FFFFFF ✒"
					end
					
					local akte = getElementData(v, "akte")
					if akte and isElement(akte) then
						local wanteds = getElementData(akte, "wantedLevel")
						if wanteds and wanteds > 0 then
							linestring = linestring.."#FFFFFF #FFFF00★"..wanteds					
						end	
					end
					
					
					dxDrawText(removeColorCoding(linestring), x_start+fontDistance*1.5+5+1, Y - fontDistance*1.5/2+1+fontDistance*0.75, screenWidth+1, screenHeight+1, tocolor( 0,0,0, 255 ), 1/posSmaller, "default-bold", "left", "top", false, false, false, false, true)
					dxDrawText(linestring, x_start+fontDistance*1.5+5+1, Y - fontDistance*1.5/2+fontDistance*0.75, screenWidth, screenHeight, tocolor( 255, 255, 255, 255 ), 1/posSmaller, "default-bold", "left", "top", false, false, false, true, true) 

					
				end
				
					--dxDrawText( getNameWithoutDots( getPlayerName(v) ).." (LVL: "..getElementData(v, "level")..")",  X - 30+1, Y - 50+1, X + 30, Y+50, tocolor( 0,0,0, 255 ), 2/posSmaller, "default-bold", "center", "center", false, false, false)
					--dxDrawText( getNameWithoutDots( getPlayerName(v) ).." (LVL: "..getElementData(v, "level")..")",  X - 30, Y - 50, X + 30, Y+50, tocolor( 255, 255, 255, 255 ), 2/posSmaller, "default-bold", "center", "center", false, false, false) 
					
					--[[dxDrawText( getNameWithoutDots( getPlayerName(v) ).." (LVL: "..getElementData(v, "level")..")",  X - 30+1, Y - 50+1, X + 30, Y+50, tocolor( 0,0,0, 255 ), 0.5/posSmaller, "bankgothic", "center", "center", false, false, false)
					dxDrawText( getNameWithoutDots( getPlayerName(v) ).." (LVL: "..getElementData(v, "level")..")",  X - 30, Y - 50, X + 30, Y+50, tocolor( 255, 255, 255, 255 ), 0.5/posSmaller, "bankgothic", "center", "center", false, false, false) 
					if getElementData(v, "dienst") == 0 then
						if getElementData(v, "gang") == 1 then
							dxDrawText( getNameWithoutDots( "La Piedra" ),  X - 30+1, Y - 50+fontDistance+1, X + 30, Y+50, tocolor( 0,0,0, 255 ), 0.4/posSmaller, "bankgothic", "center", "center", false, false, false)
							dxDrawText( getNameWithoutDots( "La Piedra" ),  X - 30, Y - 50+fontDistance, X + 30, Y+50, tocolor( 255, 0, 0, 255 ), 0.4/posSmaller, "bankgothic", "center", "center", false, false, false) 
						elseif getElementData(v, "gang") == 2 then
							dxDrawText( getNameWithoutDots( "The Heaven Devils" ),  X - 30+1, Y - 50+fontDistance+1, X + 30, Y+50, tocolor( 0,0,0, 255 ), 0.4/posSmaller, "bankgothic", "center", "center", false, false, false)
							dxDrawText( getNameWithoutDots( "The Heaven Devils" ),  X - 30, Y - 50+fontDistance, X + 30, Y+50, tocolor( 0, 255, 0, 255 ), 0.4/posSmaller, "bankgothic", "center", "center", false, false, false) 					
						elseif getElementData(v, "gang") == 3 then
							dxDrawText( getNameWithoutDots( "Da Nangs" ),  X - 30+1, Y - 50+fontDistance+1, X + 30, Y+50, tocolor( 0,0,0, 255 ), 0.4/posSmaller, "bankgothic", "center", "center", false, false, false)
							dxDrawText( getNameWithoutDots( "Da Nangs" ),  X - 30, Y - 50+fontDistance, X + 30, Y+50, tocolor( 255, 255, 0, 255 ), 0.4/posSmaller, "bankgothic", "center", "center", false, false, false) 					
						end
					end
					
					if getElementData(v, "afk") == true then
						dxDrawText( "AFK",  X - 30+1, Y - 50-fontDistance*2+1, X + 30, Y+50, tocolor( 0,0,0, 255 ), 0.5/posSmaller, "bankgothic", "center", "center", false, false, false)
						dxDrawText( "AFK",  X - 30, Y - 50-fontDistance*2, X + 30, Y+50, tocolor( 125, 0, 0, 255 ), 0.5/posSmaller, "bankgothic", "center", "center", false, false, false) 
					else
						if getElementData(v, "isWaitingForDeath") == true then
							dxDrawText( "Dieser Charakter ist schwer verletzt!",  X - 30+1, Y - 50-fontDistance*2+1, X + 30, Y+50, tocolor( 0,0,0, 255 ), 0.5/posSmaller, "bankgothic", "center", "center", false, false, false)
							dxDrawText( "Dieser Charakter ist schwer verletzt!",  X - 30, Y - 50-fontDistance*2, X + 30, Y+50, tocolor( 125, 0, 0, 255 ), 0.5/posSmaller, "bankgothic", "center", "center", false, false, false) 
						elseif getElementData(v, "getPlayerHygiene") <= 0 then
							dxDrawText( "Dieser Charakter stinkt!",  X - 30+1, Y - 50-fontDistance*2+1, X + 30, Y+50, tocolor( 0,0,0, 255 ), 0.5/posSmaller, "bankgothic", "center", "center", false, false, false)
							dxDrawText( "Dieser Charakter stinkt!",  X - 30, Y - 50-fontDistance*2, X + 30, Y+50, tocolor( 0, 125, 0, 255 ), 0.5/posSmaller, "bankgothic", "center", "center", false, false, false) 
						end
					end
					local akte = getElementData(v, "akte")
					if akte and isElement(akte) then
						local wanteds = getElementData(akte, "wantedLevel")
						if wanteds and wanteds > 0 then
							local stars = ""
							for i=1,wanteds do
								stars = stars.."★"
							end
							dxDrawText(stars,  X - 30+1, Y - 50-fontDistance+1, X + 30, Y+50, tocolor( 0,0,0, 255 ), 0.5/posSmaller, "bankgothic", "center", "center", false, false, false)
							dxDrawText( stars,  X - 30, Y - 50-fontDistance, X + 30, Y+50, tocolor( 255,255, 0, 255 ), 0.5/posSmaller, "bankgothic", "center", "center", false, false, false) 						
						end	
					end]]
			end
		end
		players = getElementsByType("ped", getRootElement(), true)
		for _,v in pairs(players) do
			local x, y, z = getElementPosition( v )
			local x1, y1, z1 = getElementPosition( getLocalPlayer() )
			z = z + 0.82
			if isElementOnScreen( v ) and v ~= getLocalPlayer() and getDistanceBetweenPoints3D ( x, y, z, x1, y1, z1 ) <= 5 then
				local X, Y = getScreenFromWorldPosition( x, y, z )
				if X then
					if getElementData ( v , "PedName") then
						dxDrawText( getElementData ( v , "PedName"),  X - 30+2, Y - 50+2, X + 30, Y+50, tocolor( 0,0,0, 255 ), 1.02, "default", "center", "center", false, false, false)
						dxDrawText( getElementData ( v , "PedName"),  X - 30, Y - 50, X + 30, Y+50, tocolor( 255, 255, 255, 255 ), 1.02, "default", "center", "center", false, false, false) 
					end
				end
			end
		end
		players = getElementsByType("pickup", getRootElement(), true)
		for _,v in pairs(players) do
			local x, y, z = getElementPosition( v )
			local x1, y1, z1 = getElementPosition( getLocalPlayer() )
			z = z + 0.82
			if isElementOnScreen( v ) and v ~= getLocalPlayer() and getDistanceBetweenPoints3D ( x, y, z, x1, y1, z1 ) <= 5 and getElementData(v, "intType") == 1 then
				local X, Y = getScreenFromWorldPosition( x, y, z )
				if X then
					dxDrawText( "[Immobilie (ID: "..tostring(getElementData(v, "intID"))..")]",  X - 30+2, Y - 50+2, X + 30, Y+50, tocolor( 0,0,0, 255 ), 1.5, "default", "center", "center", false, false, false)
					dxDrawText( "[Immobilie (ID: "..tostring(getElementData(v, "intID"))..")]",  X - 30, Y - 50, X + 30, Y+50, tocolor( 0, 255, 0, 255 ), 1.5, "default", "center", "center", false, false, false) 
					if getElementData(v, "owner") == "Niemand" then
						dxDrawText( "Preis: "..getElementData(v, "preis").." Vero",  X - 30+2, Y - 30+2, X + 30, Y+50, tocolor( 0,0,0, 255 ), 1.2, "default", "center", "center", false, false, false)
						dxDrawText( "Preis: "..getElementData(v, "preis").." Vero",  X - 30, Y - 30, X + 30, Y+50, tocolor( 255, 255, 255, 255 ), 1.2, "default", "center", "center", false, false, false) 
						dxDrawText( "Miete: "..getElementData(v, "miete").." Vero",  X - 30+2, Y - 10+2, X + 30, Y+50, tocolor( 0,0,0, 255 ), 1.2, "default", "center", "center", false, false, false)
						dxDrawText( "Miete: "..getElementData(v, "miete").." Vero",  X - 30, Y - 10, X + 30, Y+50, tocolor( 255, 255, 255, 255 ), 1.2, "default", "center", "center", false, false, false)
					elseif getElementData(v, "owner") == "SASO" then
						dxDrawText( "Eigentum der SASO",  X - 30+2, Y - 30+2, X + 30, Y+50, tocolor( 0,0,0, 255 ), 1.2, "default", "center", "center", false, false, false)
						dxDrawText( "Eigentum der SASO",  X - 30, Y - 30, X + 30, Y+50, tocolor( 255, 255, 255, 255 ), 1.2, "default", "center", "center", false, false, false) 					
						dxDrawText( "Mieter: "..getElementData(v, "keys"),  X - 30+2, Y - 10+2, X + 30, Y+50, tocolor( 0,0,0, 255 ), 1.2, "default", "center", "center", false, false, false)
						dxDrawText( "Mieter: "..getElementData(v, "keys"),  X - 30, Y - 10, X + 30, Y+50, tocolor( 255, 255, 255, 255 ), 1.2, "default", "center", "center", false, false, false) 		
					else
						dxDrawText( "Besitzer: "..getElementData(v, "owner"),  X - 30+2, Y - 30+2, X + 30, Y+50, tocolor( 0,0,0, 255 ), 1.2, "default", "center", "center", false, false, false)
						dxDrawText( "Besitzer: "..getElementData(v, "owner"),  X - 30, Y - 30, X + 30, Y+50, tocolor( 255, 255, 255, 255 ), 1.2, "default", "center", "center", false, false, false) 	
						if getElementData(v, "keys") ~= "Niemand" then
							dxDrawText( "Mitbewohner: "..getElementData(v, "keys"),  X - 30+2, Y - 10+2, X + 30, Y+50, tocolor( 0,0,0, 255 ), 1.2, "default", "center", "center", false, false, false)
							dxDrawText( "Mitbewohner: "..getElementData(v, "keys"),  X - 30, Y - 10, X + 30, Y+50, tocolor( 255, 255, 255, 255 ), 1.2, "default", "center", "center", false, false, false) 	
						end	
					end
				end
			end
			if isElementOnScreen( v ) and v ~= getLocalPlayer() and getDistanceBetweenPoints3D ( x, y, z-0.3, x1, y1, z1 ) <= 5 and getElementData(v, "intType") == 2 then
				local X, Y = getScreenFromWorldPosition( x, y, z-0.3 )
				if X then
					dxDrawText( "'F' zum Verlassen",  X - 30+2, Y - 50+2, X + 30, Y+50, tocolor( 0,0,0, 255 ), 1, "default", "center", "center", false, false, false)
					dxDrawText( "'F' zum Verlassen",  X - 30, Y - 50, X + 30, Y+50, tocolor( 0, 255, 0, 255 ), 1, "default", "center", "center", false, false, false) 
				end
			end			
		end		
		
		players = getElementsByType("marker", getRootElement(), true)
		for i,v in pairs(players) do
			local repair = getElementData(v, "repairs")
			if repair and repair <= 3 then
				local x, y, z = getElementPosition( v )
				local x1, y1, z1 = getElementPosition( getLocalPlayer() )
				z = z + 0.1
				if getDistanceBetweenPoints3D ( x, y, z, x1, y1, z1 ) <= 15 then
					local X, Y = getScreenFromWorldPosition( x, y, z )
					if X then	
						if repair == 0 then
							dxDrawText( "[Hebebühne]\nMuss von InterTrans befüllt werden",  X - 30+2, Y - 50+2, X + 30, Y+50, tocolor( 0,0,0, 255 ), 1.3, "default", "center", "center", false, false, false)
							dxDrawText(  "[Hebebühne]\nMuss von InterTrans befüllt werden",  X - 30, Y - 50, X + 30, Y+50, tocolor( 200,0, 0, 255 ), 1.3, "default", "center", "center", false, false, false) 							
						else
							dxDrawText( "[Hebebühne]\nNur mehr "..repair.."x benutzbar",  X - 30+2, Y - 50+2, X + 30, Y+50, tocolor( 0,0,0,255 ), 1.3, "default", "center", "center", false, false, false)
							dxDrawText(  "[Hebebühne]\nNur mehr "..repair.."x benutzbar",  X - 30, Y - 50, X + 30, Y+50, tocolor( 200,50, 0, 255 ), 1.3, "default", "center", "center", false, false, false) 		
						end						
					end
				end
			end
		end
		
		local jb = getElementByID ( "jailbreak" )
		players = getElementsByType("object", getRootElement(), true)
		for _,v in pairs(players) do
			local x, y, z = getElementPosition( v )
			local x1, y1, z1 = getElementPosition( getLocalPlayer() )
			z = z + 0.1
			if isElementOnScreen( v ) and v ~= getLocalPlayer() and getDistanceBetweenPoints3D ( x, y, z, x1, y1, z1 ) <= 5 then
				local X, Y = getScreenFromWorldPosition( x, y, z )
				if X then
					if getElementData(v, "itemid") then
						if getElementData(v, "itemid") == 47 then -- Geld
							dxDrawText( "["..getElementData(v, "money").." Vero]",  X - 30+2, Y - 50+2, X + 30, Y+50, tocolor( 0,0,0, 255 ), 1.0, "default", "center", "center", false, false, false)
							dxDrawText( "["..getElementData(v, "money").." Vero]",  X - 30, Y - 50, X + 30, Y+50, tocolor( 0, 125, 125, 255 ), 1.0, "default", "center", "center", false, false, false) 					
						else
							if getElementData(v, "owner") then
								dxDrawText( "["..gItemData[tonumber(getElementData(v, "itemid"))].name.." von "..getElementData(v, "owner").."]",  X - 30+2, Y - 50+2, X + 30, Y+50, tocolor( 0,0,0, 255 ), 1.0, "default", "center", "center", false, false, false)
								dxDrawText( "["..gItemData[tonumber(getElementData(v, "itemid"))].name.." von "..getElementData(v, "owner").."]",  X - 30, Y - 50, X + 30, Y+50, tocolor( 0, 125, 125, 255 ), 1.0, "default", "center", "center", false, false, false) 							
							else
								dxDrawText( "["..gItemData[tonumber(getElementData(v, "itemid"))].name.."]",  X - 30+2, Y - 50+2, X + 30, Y+50, tocolor( 0,0,0, 255 ), 1.0, "default", "center", "center", false, false, false)
								dxDrawText( "["..gItemData[tonumber(getElementData(v, "itemid"))].name.."]",  X - 30, Y - 50, X + 30, Y+50, tocolor( 0, 125, 125, 255 ), 1.0, "default", "center", "center", false, false, false) 
							end
						end
					elseif getElementData(v, "isHanf") == true then
						if getElementData(v, "erntbar") == true then
							dxDrawText( "[Hanfpflanze]\nBereit zur Ernte",  X - 30+2, Y - 50+2, X + 30, Y+50, tocolor( 0,0,0, 255 ), 1.3, "default", "center", "center", false, false, false)
							dxDrawText( "[Hanfpflanze]\nBereit zur Ernte",  X - 30, Y - 50, X + 30, Y+50, tocolor( 0, 125, 0, 255 ), 1.3, "default", "center", "center", false, false, false) 							
						else
							dxDrawText( "[Hanfpflanze]\n"..getElementData(v, "percent").."%",  X - 30+2, Y - 50+2, X + 30, Y+50, tocolor( 0,0,0, 255 ), 1.3, "default", "center", "center", false, false, false)
							dxDrawText( "[Hanfpflanze]\n"..getElementData(v, "percent").."%",  X - 30, Y - 50, X + 30, Y+50, tocolor( 0, 125, 0, 255 ), 1.3, "default", "center", "center", false, false, false) 	
						end
					elseif getElementData(v, "isKnastTuer") and jb then
						local percent = getElementData(jb, "percent")
						dxDrawText( "Knastausbruch",  X - 30+2, Y - 50+2, X + 30, Y+50, tocolor( 0,0,0, 255 ), 1.0, "default-bold", "center", "center", false, false, false)
						dxDrawText( "Knastausbruch",  X - 30, Y - 50, X + 30, Y+50, tocolor( 255,255, 255, 255 ), 1.0, "default-bold", "center", "center", false, false, false)
						dxDrawProgressBar(X - 80, Y - 30, 160, 15, tocolor(255, 255, 255, 150), tocolor(51, 153, 255, 200), tocolor(51, 153, 255, 200),percent, true)
					elseif getElementData(v, "isBlitzer") == true and getElementData(getLocalPlayer(), "job") == 3 then
						dxDrawText( "[Blitzer von "..getElementData(v, "name").." (ID: "..getElementData(v, "id")..")]",  X - 30+2, Y - 50+2, X + 30, Y+50, tocolor( 0,0,0, 255 ), 1.0, "default", "center", "center", false, false, false)
						dxDrawText( "[Blitzer von "..getElementData(v, "name").." (ID: "..getElementData(v, "id")..")]",  X - 30, Y - 50, X + 30, Y+50, tocolor( 0, 125, 125, 255 ), 1.0, "default", "center", "center", false, false, false) 					
					end
				end
			end
		end			
		players = getElementsByType("vehicle", getRootElement(), true)
		for _,v in pairs(players) do
			local x, y, z = getElementPosition( v )
			local x1, y1, z1 = getElementPosition( getLocalPlayer() )
			z = z + 0.1
			if isElementOnScreen( v ) and v ~= getLocalPlayer() and getDistanceBetweenPoints3D ( x, y, z, x1, y1, z1 ) <= 15 then
				local X, Y = getScreenFromWorldPosition( x, y, z )
				if X then
					if getElementData(v, "marked") == true then
						if getElementData(v, "vzeit") > getRealTime().timestamp then
							local datime = getRealTime(getElementData(v, "vzeit"))
							dxDrawText( "-Zum Abschleppen markiert-\nRadkrallen angebracht - verwahrt bis "..datime.monthday.."."..(datime.month+1).." "..datime.hour..":"..datime.minute,  X - 30+2, Y - 50+2, X + 30, Y+50, tocolor( 0,0,0, 255 ), 1.0, "default-bold", "center", "center", false, false, false)
							dxDrawText( "-Zum Abschleppen markiert-\nRadkrallen angebracht - verwahrt bis "..datime.monthday.."."..(datime.month+1).." "..datime.hour..":"..datime.minute,  X - 30, Y - 50, X + 30, Y+50, tocolor( 150, 0, 0, 255 ), 1.0, "default-bold", "center", "center", false, false, false)						
						else
							dxDrawText( "-Zum Abschleppen markiert-\nRadkrallen angebracht",  X - 30+2, Y - 50+2, X + 30, Y+50, tocolor( 0,0,0, 255 ), 1.0, "default-bold", "center", "center", false, false, false)
							dxDrawText( "-Zum Abschleppen markiert-\nRadkrallen angebracht",  X - 30, Y - 50, X + 30, Y+50, tocolor( 150, 0, 0, 255 ), 1.0, "default-bold", "center", "center", false, false, false)
						end
					end
					if getElementData(v, "vstatus") == true then
						if getElementData(v, "reserviert") ~= "Niemand" then
							dxDrawText( getVehicleName ( v ).."\nPreis: "..getElementData(v, "preis").." Vero\nReserviert für: "..getElementData(v, "reserviert"),  X - 30+2, Y - 50+2, X + 30, Y+50, tocolor( 0,0,0, 255 ), 1.0, "default-bold", "center", "center", false, false, false)
							dxDrawText( getVehicleName ( v ).."\nPreis: "..getElementData(v, "preis").." Vero\nReserviert für: "..getElementData(v, "reserviert"),  X - 30, Y - 50, X + 30, Y+50, tocolor( 125, 125, 0, 255 ), 1.0, "default-bold", "center", "center", false, false, false)							
						else
							dxDrawText( getVehicleName ( v ).."\nPreis: "..getElementData(v, "preis").." Vero",  X - 30+2, Y - 50+2, X + 30, Y+50, tocolor( 0,0,0, 255 ), 1.0, "default-bold", "center", "center", false, false, false)
							dxDrawText( getVehicleName ( v ).."\nPreis: "..getElementData(v, "preis").." Vero",  X - 30, Y - 50, X + 30, Y+50, tocolor( 125, 125, 0, 255 ), 1.0, "default-bold", "center", "center", false, false, false)	
						end
					end
				end
			end
		end	

		players = getElementsByType("busStation", getRootElement(), true)
		for i,v in pairs(players) do
			local elem = getElementData(v, "obj")
			local id = getElementData(v, "id")
			local x, y, z = getElementPosition( elem )
			local x1, y1, z1 = getElementPosition( getLocalPlayer() )
			--z = z + 0.1
			if isElementOnScreen( elem ) and v ~= getLocalPlayer() and getDistanceBetweenPoints3D ( x, y, z, x1, y1, z1 ) <= 15 then
				local X, Y = getScreenFromWorldPosition( x, y, z )
				if X then
					local drawstring = getElementData(v, "name")
					for i2,v2 in ipairs(gBusLines) do
						for i3, v3 in ipairs(gBusLines[i2]) do
							local check = v3
							if type(v3) == "table" then
								check = v3[1]
							end
							if check == id then
								drawstring = drawstring.."\n"..gBusLineColors[i2].."■ Linie "..i2
								
								local theTime = 1337
								for i4,v4 in ipairs(pBusData) do
									if v4.line == i2 then
										if i3 > v4.at then
											local theTempTime = i3-v4.at
											if theTempTime < theTime then
												theTime = theTempTime
											end
										end
									end
								end
								if theTime ~= 1337 then
									theTime = math.round(theTime/2)
								end
								local rt = getRealTime()
								if rt.minute + theTime > 59 then
									rt.hour = rt.hour +1
									rt.minute = rt.minute+theTime-59
									if rt.hour == 24 then rt.hour = 0 end
								else
									rt.minute = rt.minute + theTime
								end
								if string.len(tostring(rt.hour)) == 1 then rt.hour = "0"..rt.hour end
								if string.len(tostring(rt.minute)) == 1 then rt.minute = "0"..rt.minute end
								if theTime ~= 1337 then
									drawstring = drawstring.." (Abfahrt: "..rt.hour..":"..rt.minute..")"
								end
							end
						end
					end
					dxDrawText(removeColorCoding(drawstring),  X - 30+2, Y - 50+2, X + 30, Y+50, tocolor( 0,0,0, 255 ), 1.1, "arial", "center", "center", false, false, false,true)
					dxDrawText(drawstring,  X - 30, Y - 50, X + 30, Y+50, tocolor( 200, 255, 255, 255 ), 1.1, "arial", "center", "center", false, false, false,true)
				end
			end
		end			
	
		local gTreeParent
		for i,v in ipairs(getElementsByType ( "treeJob" )) do
			gTreeParent = v
			break
		end
		players = getElementChildren(gTreeParent)
		for _,v in pairs(players) do
			local x, y, z = getElementPosition( v )
			local x1, y1, z1 = getElementPosition( getLocalPlayer() )
			z = z + 0.1
			if isElementOnScreen( v ) and v ~= getLocalPlayer() and getDistanceBetweenPoints3D ( x, y, z, x1, y1, z1 ) <= 15 then
				local X, Y = getScreenFromWorldPosition( x, y, z )
				if X then
					if getElementData(v, "health") then
						dxDrawText( "Baum ("..getElementData(v, "health").."/1000)",  X - 30+2, Y - 50+2, X + 30, Y+50, tocolor( 0,0,0, 255 ), 1.0, "default-bold", "center", "center", false, false, false)
						dxDrawText( "Baum ("..getElementData(v, "health").."/1000)",  X - 30+2, Y - 50+2, X + 30, Y+50, tocolor( 255,0,0, 255 ), 1.0, "default-bold", "center", "center", false, false, false)
					end
				end
			end
		end		
		--does not work :'(
		--[[players = getElementsByType("fireJob")
		for _,v in pairs(players) do
			local x, y, z = getElementPosition( v )
			local x1, y1, z1 = getElementPosition( getLocalPlayer() )
			z = z + 0.1
			if isElementOnScreen( v ) and v ~= getLocalPlayer() and getDistanceBetweenPoints3D ( x, y, z, x1, y1, z1 ) <= 50 then
				local X, Y = getScreenFromWorldPosition( x, y, z )
				if X then
					if getElementData(v, "health") then
						dxDrawText( "Feuer ("..getElementData(v, "health").."/1000)",  X - 30+2, Y - 50+2, X + 30, Y+50, tocolor( 0,0,0, 255 ), 1.0, "default-bold", "center", "center", false, false, false)
						dxDrawText( "Feuer ("..getElementData(v, "health").."/1000)",  X - 30+2, Y - 50+2, X + 30, Y+50, tocolor( 255,0,0, 255 ), 1.0, "default-bold", "center", "center", false, false, false)
					end
				end
			end
		end	]]		
	end
)

