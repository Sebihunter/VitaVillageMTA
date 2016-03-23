--[[
Project: VitaRP
File: dxgui.lua
Author(s): Sebihunter
]]--

--Not sync anything related to the GUI wih other players to prevent exploiting
local _setElementData = setElementData
local function setElementData( element, key, value )
	return _setElementData( element, key, value, false )
end

function removeColorCoding ( name, nocentiseconds )
	return type(name)=='string' and string.gsub ( name, '#%x%x%x%x%x%x', '' ) or name
end



function dxDrawShadowedText(text, x, y, x1, y1, color, colorshadow, scale, font, ax, ay, clip, wordBreak, postGUI, colorCoded, subPixel)
	if not x or not y or not x1 or not y1 or not text then return false end
	if not color then color = tocolor(255,255,255,255) end
	if not colorshadow then colorshadow = tocolor(0,0,0,255) end
	if not scale then scale = 1 end
	if not font then font = "default" end
	if not ax then ax = "left" end
	if not ay then ay = "top" end
	if not wordBreak then wordBreak = false end
	if not colorCoded then colorCoded = false end
	if not subPixel then subPixel = false end
	dxDrawText(removeColorCoding(text),x+1,y+1,x1+1,y1+1, colorshadow,scale, font, ax,ay,clip,wordBreak, postGUI, colorCoded, subPixel)
	dxDrawText(text,x,y,x1,y1,color,scale,font,ax,ay,clip,wordBreak,postGUI, colorCoded,subPixel)
end

function dxCreateGridList(x,y,w,h,rel)
	local element = createElement("h_dxGridList")
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
	setElementData(element, "horizontal", horizontal)
	setElementData(element, "isShown", true)
	setElementData(element, "scroll", 1)
	setElementData(element, "grid", {})
	setElementData(element, "alpha", 1)
	setElementData(element, "enabled", true)
	return element	
end

function dxGridListReplaceRows(element, rows)
	if isElement(element) then
		setElementData(element, "grid", rows)
	end
	return false
end

function dxGridListAddRow(element, text, data, bold)
	if isElement(element) then
		local gridTable = getElementData(element, "grid")
		if not data then data = false end
		if not bold then bold = false end
		gridTable[#gridTable+1] = {}
		gridTable[#gridTable].text = text
		gridTable[#gridTable].data = data
		gridTable[#gridTable].selected = false
		if bold == true then
			gridTable[#gridTable].bold = true
		end
		setElementData(element, "grid", gridTable)		
		return #gridTable
	end
	return false
end

function dxGridListSetSelectedItem(element, id)
	if isElement(element) then
		setElementData(element, "selected", id)
		return true
	end
	return false
end


function dxGridListGetSelectedItem(element)
	if isElement(element) then
		return getElementData(element, "selected")
	end
	return false
end

function dxGridListClear(element)
	if isElement(element) then
		setElementData(element, "scroll", 1)
		setElementData(element, "grid", {})
		setElementData(element, "selected", false)
		return true
	end
	return false
end

function dxGridListGetItemData(element, rowid)
	if isElement(element) then
		local gridTable = getElementData(element, "grid")
		if gridTable[rowid] then
			return gridTable[rowid].data 
		end
	end
	return false
end

function dxGridListGetItemText(element, rowid)
	if isElement(element) then
		local gridTable = getElementData(element, "grid")
		if gridTable[rowid] then
			return gridTable[rowid].text 
		end
	end
	return false
end


function dxGridListSetItemText(element, rowid, text)
	if isElement(element) then
		local gridTable = getElementData(element, "grid")
		if gridTable[rowid] then
			gridTable[rowid].text = text
			setElementData(element, "grid", gridTable)
			return true
		end
	end
	return false
end

function dxGridListSetItemData(element, rowid, data)
	if isElement(element) then
		local gridTable = getElementData(element, "grid")
		if gridTable[rowid] then
			gridTable[rowid].data = data
			setElementData(element, "grid", gridTable)
			return true
		end
	end
	return false
end

function dxGridListGetRowCount(element)
	if isElement(element) then
		local gridTable = getElementData(element, "grid")
		return #gridTable
	end
	return false
end

function dxCreateButton(x,y,w,h,text,rel,smallfont)
	if not smallfont then smallfont = false end
	local element = createElement("h_dxButton")
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
	setElementData(element, "text", text)
	setElementData(element, "smallfont", smallfont)		
	setElementData(element, "isShown", true)
	setElementData(element, "alpha", 1)
	setElementData(element, "enabled", true)
	return element
end

function dxSetEnabled(element, toggle)
	if isElement(element) then
		setElementData(element, "enabled", toggle)
	end
end

function dxSetAlpha(element, alpha)
	if isElement(element) then
		if alpha > 1 then alpha = 1 end
		if alpha < 0 then alpha = 0 end
		setElementData(element, "alpha", alpha)
	end
end
function dxSetVisible(element, toggle)
	if isElement(element) then
		setElementData(element, "isShown", toggle)
	end
end

function dxGetVisible(element)
	if isElement(element) then
		return getElementData(element, "isShown")
	end
	return false
end

function dxSetPosition(element,x,y,rel)
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

function dxSetSize(element,w,h,rel)
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


bindKey("mouse_wheel_down","down",function() 
	 for i,v in pairs(getElementsByType("h_dxGridList")) do
		if dxIsHovering(v) and getElementData(v, "isShown") == true then
			local scroll = getElementData(v, "scroll")
			local gridTable = getElementData(v, "grid")
			local height = getElementData(v, "h")
			
			local changeScroll = height/20
			scroll = scroll + 5
			
			if scroll+changeScroll > #gridTable then scroll = #gridTable-changeScroll+1 end
			
			setElementData(v, "scroll", scroll)
		end
	 end	
end)
bindKey("mouse_wheel_up","down",function() 
	 for i,v in pairs(getElementsByType("h_dxGridList")) do
		if dxIsHovering(v) and getElementData(v, "isShown") == true then
			local scroll = getElementData(v, "scroll")
			local height = getElementData(v, "h")
			
			local changeScroll = height/20
			scroll = scroll - 5
			
			if scroll < 1 then scroll = 1 end

			setElementData(v, "scroll", scroll)
		end
	 end
end)

function dxIsHovering(element)
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

	if state == "down" then
		for id, v in ipairs (getElementsByType("h_dxGridList")) do
			if getElementData(v, "isShown") == true then
				local x = getElementData(v,"x")
				local y = getElementData(v,"y")
				local scroll = getElementData(v, "scroll")
				local gridTable = getElementData(v, "grid")
				local w = getElementData(v, "w")
				local h = getElementData(v, "h")
				local maxDisplay = math.floor(h/20)	
				local line = 0
				for i = scroll, maxDisplay+scroll-1 do
					if gridTable and gridTable[i] then
						local y1 = y + 20* line
						line = line+1
						if sx >= x and sx <= x+w+1 and sy >= y1 and sy <= y1+20-1 then		
							setElementData(v, "selected", i)
						end
					end
				end
				
				if sx >= x and sx <= x+w and sy >= y and sy <= y+h then
					triggerEvent ( "onClientDXClick", v, button, state )
				end
			end
		end
	end
	if state == "up" then
		for i,v in pairs(getElementsByType("h_dxButton")) do
			local x = getElementData(v, "x")
			local y = getElementData(v, "y")
			local w = getElementData(v, "w")
			local h = getElementData(v, "h")
			if sx >= x and sx <= x+w and sy >= y and sy <= y+h and getElementData(v, "isShown") == true and getElementData(v, "enabled") == true then
				triggerEvent ( "onClientDXClick", v, button, state )
				if button == "down" then
					setElementData(v, "clickedDown", true)
				else
					setElementData(v, "clickedDown", false)
				end
			else
				setElementData(v, "clickedDown", false)
			end		
		end
	end
end
addEventHandler ( "onClientClick", getRootElement(), clickableAreaClicked )
addEvent("onClientDXClick")


function dxDrawAllOfThis ()
	for id, v in ipairs (getElementsByType("h_dxGridList")) do
		if getElementData(v, "isShown") == true then
		
			local x = getElementData(v,"x")
			local y = getElementData(v,"y")
			local scroll = getElementData(v, "scroll")
			local gridTable = getElementData(v, "grid")
			local w = getElementData(v, "w")
			local h = getElementData(v, "h")
			local maxDisplay = math.floor(h/20)

			
			
			local line = 0
			local x2, y2, z2 = interpolateBetween ( 0, y, 0, 0, y+h-30, 0, ((scroll-1)/(#gridTable-maxDisplay)), "Linear")
			
			if maxDisplay < #gridTable and h > 30 then
				dxDrawRectangle(x, y, w-5, h, tocolor(5,5,5,150*getElementData(v,"alpha")))
				dxDrawRectangle(x+w-5, y, 5, h, tocolor(0,0,0,150*getElementData(v,"alpha")))
				dxDrawRectangle(x+w-5, y2, 5, 30, tocolor(50,50,50,150*getElementData(v,"alpha")))
			else
				dxDrawRectangle(x, y, w, h, tocolor(5,5,5,150*getElementData(v,"alpha")))
			end
			
			for i = scroll, maxDisplay+scroll-1 do
				if gridTable[i] then
					local ssX, ssY = guiGetScreenSize()
					local sx, sy = getCursorPosition()
					if not sx then sx = 0 end
					if not sy then sy = 0 end
					sx = ssX*sx
					sy = ssY*sy		
					local y1 = y + 20* line
					line = line+1
					if getElementData(v, "selected") == i then
						if maxDisplay < #gridTable and h > 30 then
							dxDrawRectangle(x, y1, w-5, 20, tocolor(214,219,145,30*getElementData(v,"alpha")), false)
						else
							dxDrawRectangle(x, y1, w, 20, tocolor(214,219,145,30*getElementData(v,"alpha")), false)
						end
					elseif sx >= x and sx <= x+w+1 and sy >= y1 and sy <= y1+20-1 then
						if maxDisplay < #gridTable and h > 30 then
							dxDrawRectangle(x, y1, w-5, 20, tocolor(214,219,145,50*getElementData(v,"alpha")), false)
						else
							dxDrawRectangle(x, y1, w, 20, tocolor(214,219,145,50*getElementData(v,"alpha")), false)
						end
					end
					if gridTable[i].bold then
						dxDrawText(tostring(gridTable[i].text), x+8, y1+3, x+w-5, y1+20, tocolor(255,255,255,255*getElementData(v,"alpha")), 1, "default-bold", "left", "top", true, false, false, false)
					else
						dxDrawText(tostring(gridTable[i].text), x+8, y1+3, x+w-5, y1+20, tocolor(255,255,255,255*getElementData(v,"alpha")), 1, "default", "left", "top", true, false, false, false)		
					end
				end
			end		
		end
	end


	--[[for id, v in ipairs (getElementsByType("h_dxScrollBar")) do
		if not getElementData(v,"horizontal") then
			dxDrawRectangle(getElementData(v,"x"), getElementData(v,"y"),getElementData(v,"w"), getElementData(v,"h"),tocolor(30,30,30,130))
			dxDrawRectangle(getElementData(v,"x")+1, getElementData(v,"y") + getElementData(v,"scroll")*getElementData(v,"h")/2,getElementData(v,"w")-1, getElementData(v,"h")/2,tocolor(50,50,50,200))
		else
			--Not working yet
		end		
	end	]]

	for i,v in pairs(getElementsByType("h_dxButton")) do
		if getElementData(v, "isShown") == true then
			if getElementData(v, "enabled") == true then
				if getElementData(v, "clickedDown") == true then
					dxDrawRectangle ( getElementData(v,"x")-1, getElementData(v,"y")-1, getElementData(v,"w")+2, getElementData(v,"h")+2, tocolor(0,0,0,100*getElementData(v,"alpha")) )
					dxDrawImageSection( getElementData(v,"x"), getElementData(v,"y"), getElementData(v,"w"), getElementData(v,"h"),0,0, getElementData(v,"w"), getElementData(v,"h"), "images/gui/buttonclicked.png", 0,0,0, tocolor(255,255,255,255*getElementData(v,"alpha")))
				else
					if dxIsHovering(v) then
						dxDrawRectangle ( getElementData(v,"x")-1, getElementData(v,"y")-1, getElementData(v,"w")+2, getElementData(v,"h")+2, tocolor(0,0,0,100*getElementData(v,"alpha")) )
						dxDrawImageSection( getElementData(v,"x"), getElementData(v,"y"), getElementData(v,"w"), getElementData(v,"h"),0,0, getElementData(v,"w"), getElementData(v,"h"), "images/gui/buttonhover.png", 0,0,0, tocolor(255,255,255,255*getElementData(v,"alpha")))						
					else
						dxDrawRectangle ( getElementData(v,"x")-1, getElementData(v,"y")-1, getElementData(v,"w")+2, getElementData(v,"h")+2, tocolor(0,0,0,100*getElementData(v,"alpha")) )
						dxDrawImageSection( getElementData(v,"x"), getElementData(v,"y"), getElementData(v,"w"), getElementData(v,"h"),0,0, getElementData(v,"w"), getElementData(v,"h"), "images/gui/button.png", 0,0,0, tocolor(255,255,255,255*getElementData(v,"alpha")))			
					end
				end
			else
				dxDrawRectangle ( getElementData(v,"x")-1, getElementData(v,"y")-1, getElementData(v,"w")+2, getElementData(v,"h")+2, tocolor(0,0,0,100*getElementData(v,"alpha")) )
				dxDrawImageSection( getElementData(v,"x"), getElementData(v,"y"), getElementData(v,"w"), getElementData(v,"h"),0,0, getElementData(v,"w"), getElementData(v,"h"), "images/gui/buttonclicked.png", 0,0,0, tocolor(150,150,150,255*getElementData(v,"alpha")))			
			end
			if getElementData(v, "smallfont") then
				dxDrawText(getElementData(v,"text"),getElementData(v,"x")+1, getElementData(v,"y")+1,getElementData(v,"x")+getElementData(v,"w")+1, getElementData(v,"y")+getElementData(v,"h")+1,tocolor(0,0,0,150*getElementData(v,"alpha")),0.8,"default-bold","center","center")
				dxDrawText(getElementData(v,"text"),getElementData(v,"x"), getElementData(v,"y"),getElementData(v,"x")+getElementData(v,"w"), getElementData(v,"y")+getElementData(v,"h"),tocolor(255,255,255,255*getElementData(v,"alpha")),0.8,"default-bold","center","center")				
			else
				dxDrawText(getElementData(v,"text"),getElementData(v,"x")+1, getElementData(v,"y")+1,getElementData(v,"x")+getElementData(v,"w")+1, getElementData(v,"y")+getElementData(v,"h")+1,tocolor(0,0,0,150*getElementData(v,"alpha")),1,"default-bold","center","center")
				dxDrawText(getElementData(v,"text"),getElementData(v,"x"), getElementData(v,"y"),getElementData(v,"x")+getElementData(v,"w"), getElementData(v,"y")+getElementData(v,"h"),tocolor(255,255,255,255*getElementData(v,"alpha")),1,"default-bold","center","center")	
			end			
		end
	end
end
addEventHandler ( "onClientRender", getRootElement(), dxDrawAllOfThis, false,  "low-1" )