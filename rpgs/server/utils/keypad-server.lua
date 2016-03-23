--[[
Project: VitaOnline
File: keypad-server.lua
Author(s):	MrX
]]--

local cobject = {}

function createClickableElement(element, func)
	cobject[element] = func
	addEventHandler("onElementClicked", element, onElementClickedHandler)
end

function onElementClickedHandler(mb, mbs, player)
	if mb == "left" and mbs == "down" then
		cobject[source](source, player)
	end
end
