--[[
Project: VitaRP
File: background.lua
Author(s):	Sebihunter
]]--

local vitaBackgroundAlpha = 0
local vitaBackgroundReach = 0
local isVitaBackground = false

local screenWidth, screenHeight = guiGetScreenSize()
function vitaBackgroundRender()
	if vitaBackgroundReach > vitaBackgroundAlpha and vitaBackgroundReach == 1 then vitaBackgroundAlpha = vitaBackgroundAlpha + 0.05 end
	if vitaBackgroundReach < vitaBackgroundAlpha and vitaBackgroundReach == 0 then vitaBackgroundAlpha = vitaBackgroundAlpha - 0.1 end
	if vitaBackgroundAlpha <= 0 and vitaBackgroundReach == 0 then vitaBackgroundAlpha = 0 removeEventHandler ( "onClientRender", getRootElement(), vitaBackgroundRender) end
	if fileExists("images/background.png") then
		dxDrawImageSection ( 0,0,  screenWidth, screenHeight, 1920/2-screenWidth/2, 1080/2-screenHeight/2, screenWidth, screenHeight, "images/background.png",0,0,0,tocolor(255,255,255,255*vitaBackgroundAlpha) )
	end
end

function vitaBackgroundToggle(toggle)
	if toggle == true and isVitaBackground == false then
		isVitaBackground = true
		vitaBackgroundReach = 1
		addEventHandler ( "onClientRender", getRootElement(), vitaBackgroundRender, true, "high+2")
	elseif toggle == false then
		isVitaBackground = false
		vitaBackgroundReach = 0
	end
end