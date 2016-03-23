--[[
Project: VitaOnline
File: notify-client.lua
Author(s):	Sebihunter
]]--
local screenWidth, screenHeight = guiGetScreenSize()
local movingSpace = 0
gNotifications = {}

function addNotification(id, r, g, b, text)
	local number = 1
	for i = 1, #gNotifications+1 do
		if gNotifications[number] then
			number = number +1
		else
			gNotifications[number] = {}
			gNotifications[number].alpha = 0
			gNotifications[number].id = id
			gNotifications[number].r = r
			gNotifications[number].g = g
			gNotifications[number].b = b
			gNotifications[number].text = text
			gNotifications[number].starttick = getTickCount ()
			playSound("sounds/notify.mp3")
			if isEventHandlerAdded( "onClientRender", getRootElement(), renderNotifications ) == false then
				movingSpace = 0
				addEventHandler("onClientRender", getRootElement(), renderNotifications, true, "low-2")
			end				
			outputConsole("Notification: "..text)
			break
		end
	end
end
addEvent("addNotification", true)
addEventHandler("addNotification", getRootElement(), addNotification)


function renderNotifications()
	if #gNotifications == 0 then removeEventHandler("onClientRender", getRootElement(), renderNotifications) end
	if movingSpace > 0 then movingSpace = movingSpace-5 end
	local startMoving = movingSpace
	for i,v in pairs(gNotifications) do
		iDraw = i-1
		if (getTickCount() - v.starttick) <= 8000 then
			if v.alpha < 255 then
				v.alpha = v.alpha+15
			end
			
			
			local width = dxGetTextWidth ( v.text, 1, "default-bold")
			local doubleLined = split(v.text, "\n") 
			if doubleLined[2] ~= nil then
				local lineOne = dxGetTextWidth ( doubleLined[1], 1, "default-bold")
				local lineTwo = dxGetTextWidth ( doubleLined[2], 1, "default-bold")
				if lineOne > lineTwo then width = lineOne else width = lineTwo end
			end
			
		
			dxDrawImage(screenWidth-width-64,10+60*iDraw+movingSpace, width+64,49, "images/notify/notification.png",0,0,0, tocolor(v.r, v.g, v.b, v.alpha), true)
			dxDrawImage(screenWidth-width-54,10+8+60*iDraw+movingSpace, 32,32, "images/notify/notify"..v.id..".png",0,0,0, tocolor(255,255,255,v.alpha), true)
			
			if doubleLined[2] ~= nil then
				dxDrawText ( doubleLined[1], screenWidth-width-14, 10+16+60*iDraw-6+movingSpace, screenWidth, screenHeight, tocolor ( 255, 255, 255, v.alpha ), 1, "default-bold", "left", "top", false, false, true )	
				dxDrawText ( doubleLined[2], screenWidth-width-14, 10+16+60*iDraw+7+movingSpace, screenWidth, screenHeight, tocolor ( 255, 255, 255, v.alpha ), 1, "default-bold", "left", "top", false, false, true )	
			else
				dxDrawText ( v.text, screenWidth-width-14, 10+16+60*iDraw+movingSpace, screenWidth, screenHeight, tocolor ( 255, 255, 255, v.alpha ), 1, "default-bold", "left", "top", false, false, true )	
			end
		else
			if v.alpha > 0 then
				v.alpha = v.alpha-15
				local width = dxGetTextWidth ( v.text, 1, "default-bold")
				
				local doubleLined = split(v.text, "\n") 
				if doubleLined[2] ~= nil then
					local lineOne = dxGetTextWidth ( doubleLined[1], 1, "default-bold")
					local lineTwo = dxGetTextWidth ( doubleLined[2], 1, "default-bold")
					if lineOne > lineTwo then width = lineOne else width = lineTwo end
				end	
	
				dxDrawImage(screenWidth-width-64,10+60*iDraw+movingSpace, width+64,49, "images/notify/notification.png",0,0,0, tocolor(v.r, v.g, v.b, v.alpha), true)
				dxDrawImage(screenWidth-width-54,10+8+60*iDraw+movingSpace, 32,32, "images/notify/notify"..v.id..".png",0,0,0, tocolor(255,255,255,v.alpha), true)
				
				if doubleLined[2] ~= nil then
					dxDrawText ( doubleLined[1], screenWidth-width-14, 10+16+60*iDraw-6+movingSpace, screenWidth, screenHeight, tocolor ( 255, 255, 255, v.alpha ), 1, "default-bold", "left", "top", false, false, true )	
					dxDrawText ( doubleLined[2], screenWidth-width-14, 10+16+60*iDraw+7+movingSpace, screenWidth, screenHeight, tocolor ( 255, 255, 255, v.alpha ), 1, "default-bold", "left", "top", false, false, true )	
				else
					dxDrawText ( v.text, screenWidth-width-14, 10+16+60*iDraw+movingSpace, screenWidth, screenHeight, tocolor ( 255, 255, 255, v.alpha ), 1, "default-bold", "left", "top", false, false, true )	
				end					
			else
				table.remove (gNotifications, i)
				movingSpace = movingSpace+60
				
				--Draw the one with this id again (otherwise its not drawn as the notification after this notification has now the same id as the one before)
				v = gNotifications[i]
				if v then
					v.alpha = v.alpha-15
					local width = dxGetTextWidth ( v.text, 1, "default-bold")
					
					local doubleLined = split(v.text, "\n") 
					if doubleLined[2] ~= nil then
						local lineOne = dxGetTextWidth ( doubleLined[1], 1, "default-bold")
						local lineTwo = dxGetTextWidth ( doubleLined[2], 1, "default-bold")
						if lineOne > lineTwo then width = lineOne else width = lineTwo end
					end	
		
					dxDrawImage(screenWidth-width-64,10+60*iDraw+movingSpace, width+64,49, "images/notify/notification.png",0,0,0, tocolor(v.r, v.g, v.b, v.alpha), true)
					dxDrawImage(screenWidth-width-54,10+8+60*iDraw+movingSpace, 32,32, "images/notify/notify"..v.id..".png",0,0,0, tocolor(255,255,255,v.alpha), true)
					
					if doubleLined[2] ~= nil then
						dxDrawText ( doubleLined[1], screenWidth-width-14, 10+16+60*iDraw-6+movingSpace, screenWidth, screenHeight, tocolor ( 255, 255, 255, v.alpha ), 1, "default-bold", "left", "top", false, false, true )	
						dxDrawText ( doubleLined[2], screenWidth-width-14, 10+16+60*iDraw+7+movingSpace, screenWidth, screenHeight, tocolor ( 255, 255, 255, v.alpha ), 1, "default-bold", "left", "top", false, false, true )	
					else
						dxDrawText ( v.text, screenWidth-width-14, 10+16+60*iDraw+movingSpace, screenWidth, screenHeight, tocolor ( 255, 255, 255, v.alpha ), 1, "default-bold", "left", "top", false, false, true )	
					end
				end
				
			end
		end
	end
end	
	
--[[
Tutorial Messages
]]--


local tutorialMessages = {}

function showTutorialMessage(id, text, override, still)

	local buffer = ""
	if fileExists("tutorialMessages.vita") then
		local file = fileOpen("tutorialMessages.vita", true)
		buffer = fileRead(file, fileGetSize ( file ))
		fileClose(file)
	end
	local data = fromJSON(buffer) or {}
	
	if data[id] and still ~= true then return end
	data[id] = true
	
	fileDelete("tutorialMessages.vita")
	local file = fileCreate("tutorialMessages.vita")
	fileWrite(file, toJSON(data))
	fileClose(file)

	tutorialMessages[#tutorialMessages+1] = {}
	tutorialMessages[#tutorialMessages].text = text
	tutorialMessages[#tutorialMessages].soundPlayed = false
	tutorialMessages[#tutorialMessages].animStage = 1
	tutorialMessages[#tutorialMessages].alpha = 0
	tutorialMessages[#tutorialMessages].offsetY = 0
	
	

	if override and #tutorialMessages > 1 then
		table.remove(tutorialMessages, 1)
	end
end

addEvent("showTutorialMessage", true)
addEventHandler("showTutorialMessage", getRootElement(), showTutorialMessage)


local tick = 0
local function renderTutorialMessages()
	if #tutorialMessages >= 1 then	
		tick = tick + 1
		if tick > 30 then
			tick = 0
		end

		local message = tutorialMessages[1]

		if message.soundPlayed == false then
			playSound("sounds/tut_sound.mp3")
			message.soundPlayed = true
		end


		if message.animStage == 1 then
			if message.alpha + 0.1 >= 1 then
				message.alpha = 1
			else
				message.alpha = message.alpha + 0.1
			end
			
			if message.offsetY + 20 >= 250 then
				message.offsetY = 250
			else
				message.offsetY = message.offsetY + 20
			end
		else
			if (message.alpha - 0.1) <= 0 then
				message.alpha = 0
				table.remove(tutorialMessages, 1)
				return
			else 
				message.alpha = message.alpha - 0.1
			end
		end		
		
		dxDrawRectangle ( screenWidth/2-200, screenHeight-message.offsetY , 400, 100, tocolor ( 255,255,255,150*message.alpha ))
		dxDrawLine (  screenWidth/2-200, screenHeight-message.offsetY, screenWidth/2-200, screenHeight-message.offsetY+100, tocolor(255,255,255,255*message.alpha))
		dxDrawLine (  screenWidth/2+200, screenHeight-message.offsetY, screenWidth/2+200, screenHeight-message.offsetY+100, tocolor(255,255,255,255*message.alpha))
		dxDrawLine (  screenWidth/2-200, screenHeight-message.offsetY+100, screenWidth/2+200, screenHeight-message.offsetY+100, tocolor(255,255,255,255*message.alpha))
		dxDrawLine (  screenWidth/2-200, screenHeight-message.offsetY, screenWidth/2+200, screenHeight-message.offsetY, tocolor(255,255,255,255*message.alpha))
		

		dxDrawText( message.text,screenWidth/2-195, screenHeight-message.offsetY, screenWidth/2+195, screenHeight-message.offsetY+100,tocolor(30,30,30, 255*message.alpha), 1, "default", "center", "center", true, true, false, false, true)
		dxDrawText("Drücke #A8FF12F9 #1E1E1Eum fortzufahren" .. string.rep(".", math.ceil(tick / 10)), screenWidth/2-195, screenHeight-message.offsetY+85,screenWidth,screenHeight,tocolor(30,30,30, 255*message.alpha), 1, "default-bold", "left", "top", false, false, false, true, true)
	end
end
addEventHandler("onClientRender", getRootElement(), renderTutorialMessages, false, "low-9999")


bindKey("F9", "down",
function()
	if #tutorialMessages >= 1 then
		tutorialMessages[1].animStage = 2
	end
end)