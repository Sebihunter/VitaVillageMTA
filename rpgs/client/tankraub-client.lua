--[[
Project: VitaOnline
File: tankraub-client.lua
Author(s):	Tommi 
]]--

local screenW, screenH = guiGetScreenSize()
local second = 120
addEvent("drawBankrobTimerClient",true)
addEventHandler("drawBankrobTimerClient",root,
	function()
		addEventHandler("onClientRender",root, drawBankrobClientWindow)
		setTheTimer()
	end
)

function setTheTimer()
	setTimer(function()
		second = (second - 1)
	end, 1000, 120)
end

function drawBankrobClientWindow()
	if second > 0 then
		dxDrawText("Du musst "..tostring(second).." Sekunden warten um das Geld zu erhalten.", screenW/2 - 500/2, 10, (screenW/2 - 500/2) + 500, (10) + 100, tocolor(0, 255, 0, 255), 1.20, "sans", "center", "center", false, false, false, true, false)
	elseif second == 0 then
		removeEventHandler("onClientRender", root, drawBankrobClientWindow)
		triggerServerEvent("giveTankstelleServer", localPlayer, localPlayer)
	end
end