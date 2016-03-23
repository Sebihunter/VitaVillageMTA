--[[
Project: VitaOnline
File: autoafk-client.lua
Author(s):	MrX
]]--
-- In 1.1 nicht mehr noetig
addEvent("onClientKey", false)
function key()
	triggerEvent("onClientKey", root)
end

local keyTable = { "mouse1", "mouse2", "mouse3", "mouse4", "mouse5", "mouse_wheel_up", "mouse_wheel_down", "arrow_l", "arrow_u",
 "arrow_r", "arrow_d", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k",
 "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "num_0", "num_1", "num_2", "num_3", "num_4", "num_5",
 "num_6", "num_7", "num_8", "num_9", "num_mul", "num_add", "num_sep", "num_sub", "num_div", "num_dec", "F1", "F2", "F3", "F4", "F5",
 "F6", "F7", "F8", "F9", "F10", "F11", "F12", "backspace", "tab", "lalt", "ralt", "enter", "space", "pgup", "pgdn", "end", "home",
 "insert", "delete", "lshift", "rshift", "lctrl", "rctrl", "[", "]", "pause", "capslock", "scroll", ";", ",", "-", ".", "/", "#", "\\", "=" }

addEventHandler("onClientResourceStart", getResourceRootElement(),
	function()
		for k, v in pairs(keyTable) do
			bindKey(v, "down", key)
		end
	end
)

local afktimer = nil

addEventHandler("onClientKey", getLocalPlayer(), 
	function()
		if isTimer(afktimer) then killTimer(afktimer) end
		afktimer = setTimer(setAutoafk, 1000*60*15, 1)
	end
)

function setAutoafk()
	showTutorialMessage("afk_1", "Du wurdest, da du dich für einige Zeit nicht bewegt hast, als AFK markiert.\nDu kannst den AFK-Modus mit /afk wieder verlassen.")
	setElementData(getLocalPlayer(), "afk", true)
end

addEventHandler("onClientPlayerDamage", getLocalPlayer(),
	function()
		if getElementData(getLocalPlayer(), "afk") == true then
			cancelEvent()
		end
	end
)