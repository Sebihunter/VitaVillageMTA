--[[
Project: VitaRP
File: clickareas.lua
Author(s): Sebihunter
]]--

--Not sync anything related to the GUI wih other players to prevent exploiting
local _setElementData = setElementData
local function setElementData( element, key, value )
	return _setElementData( element, key, value, false )
end

function clickableAreaCreate(x,y,w,h,rel)
	local element = createElement("clickableArea")
	if rel == true then
		local sX, sY = guiGetScreenSize()
		x = sX*x
		y = sY*y
		w = sX*w
		h = sY*h
	end
	setElementData(element, "x", x)
	setElementData(element, "y", y)
	setElementData(element, "w", w)
	setElementData(element, "h", h)
	return element
end

function clickableAreaSetPosition(element,x,y,rel)
	if isElement(element) then
		if rel == true then
			local sX, sY = guiGetScreenSize()
			x = sX*x
			y = sX*y
		end	
	end
	setElementData(element, "x", x)
	setElementData(element, "y", y)	
end

function clickableAreaSetSize(element,w,h,rel)
	if isElement(element) then
		if rel == true then
			local sX, sY = guiGetScreenSize()
			w = sX*w
			h = sY*h
		end	
	end
	setElementData(element, "w", w)
	setElementData(element, "h", h)	
end

function clickableAreaIsHovering(element)
	if isElement(element) then
		local showing = isCursorShowing ()
		if showing then
			local ssX, ssY = guiGetScreenSize()
			local sx, sy = getCursorPosition()
			sx = ssX*sx
			sy = ssY*sy
			local x = getElementData(element, "x")
			local y = getElementData(element, "y")
			local w = getElementData(element, "w")
			local h = getElementData(element, "h")
			if sx >= x and sx <= x+w and sy >= y and sy <= y+h then
				return true
			end
		end
	end
	return false
end

function clickableAreaClicked( button, state, sx, sy)
    for i,v in pairs(getElementsByType("clickableArea")) do
		if isElement(v) then
			local x = getElementData(v, "x")
			local y = getElementData(v, "y")
			local w = getElementData(v, "w")
			local h = getElementData(v, "h")
			if sx >= x and sx <= x+w and sy >= y and sy <= y+h then
				triggerEvent ( "onClickableAreaClick", v, button, state )
			end	
		end		
	end
end
addEventHandler ( "onClientClick", getRootElement(), clickableAreaClicked )
addEvent("onClickableAreaClick")