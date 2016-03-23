--[[
Project: VitaOnline
File: utils-client.lua
Author(s):	Golf_R32
			Sebihunter
			CubedDeath
]]--

local attachedEffects = {}
 
function playSound3DLoud(url, x,y,z)
	local sound = playSound3D(url, x,y,z)
	setSoundMinDistance ( sound, 40 )
	return sound
end 
 
function dxDrawCircle( posX, posY, radius, width, angleAmount, startAngle, stopAngle, color, postGUI )
	if ( type( posX ) ~= "number" ) or ( type( posY ) ~= "number" ) then
		return false
	end
 
	local function clamp( val, lower, upper )
		if ( lower > upper ) then lower, upper = upper, lower end
		return math.max( lower, math.min( upper, val ) )
	end
 
	radius = type( radius ) == "number" and radius or 50
	width = type( width ) == "number" and width or 5
	angleAmount = type( angleAmount ) == "number" and angleAmount or 1
	startAngle = clamp( type( startAngle ) == "number" and startAngle or 0, 0, 360 )
	stopAngle = clamp( type( stopAngle ) == "number" and stopAngle or 360, 0, 360 )
	color = color or tocolor( 255, 255, 255, 200 )
	postGUI = type( postGUI ) == "boolean" and postGUI or false
 
	if ( stopAngle < startAngle ) then
		local tempAngle = stopAngle
		stopAngle = startAngle
		startAngle = tempAngle
	end
 
	for i = startAngle, stopAngle, angleAmount do
		local startX = math.cos( math.rad( i ) ) * ( radius - width )
		local startY = math.sin( math.rad( i ) ) * ( radius - width )
		local endX = math.cos( math.rad( i ) ) * ( radius + width )
		local endY = math.sin( math.rad( i ) ) * ( radius + width )
 
		dxDrawLine( startX + posX, startY + posY, endX + posX, endY + posY, color, width, postGUI )
	end
 
	return true
end 
 
-- Taken from https://wiki.multitheftauto.com/wiki/GetElementMatrix example
function getPositionFromElementOffset(element,offX,offY,offZ)
	local m = getElementMatrix ( element )  -- Get the matrix
	local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]  -- Apply transform
	local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
	local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
	return x, y, z  -- Return the transformed point
end
 
function attachEffect(effect, element, pos)
	attachedEffects[effect] = { effect = effect, element = element, pos = pos }
	addEventHandler("onClientElementDestroy", effect, function() attachedEffects[effect] = nil end)
	addEventHandler("onClientElementDestroy", element, function() attachedEffects[effect] = nil end)
	return true
end
 
addEventHandler("onClientPreRender", root, 	
	function()
		for fx, info in pairs(attachedEffects) do
			local x, y, z = getPositionFromElementOffset(info.element, info.pos.x, info.pos.y, info.pos.z)
			setElementPosition(fx, x, y, z)
		end
	end
)

function centerWindow(center_window)
    local screenW,screenH = guiGetScreenSize()
    local windowW,windowH = guiGetSize(center_window,false)
    local x,y = (screenW-windowW)/2,(screenH-windowH)/2
    guiSetPosition(center_window,x,y,false)
end

local dispatchQueue = {}
function playDispatch(text)
	if not dispatchQueue[1] then
		dispatchQueue = {}
		dispatchQueue[1] = text
		dispatchFunc(text)
	else
		dispatchQueue[#dispatchQueue+1] = text
	end
end
function dispatchFunc()
	if not dispatchQueue[1] then return end
	playSound("sounds/dispatch.mp3")
	setTimer ( function()
		local sound = playSound("http://translate.google.com/translate_tts?tl=de&q="..dispatchQueue[1])
		setSoundEffectEnabled(sound, "flanger", true)
		setSoundEffectEnabled(sound, "distortion", true)	
		setTimer(function()
			table.remove(dispatchQueue, 1)
			dispatchFunc()
		end, 10000, 1 )
	end, 1000, 1)
end

function playAttachedSound3D(sound, element, looped)
	if not looped then looped = false end
	if sound and isElement(element) then
		local x,y,z = getElementPosition(element)
		local soundA = playSound3D ( sound,x,y,z,loopied )
		if isElement(soundA) then
			attachElements(soundA, element)
		end
		return soundA
	end
	return false
end

gBodypartToBone = { [3] = 3, [4] = 1, [5] = 33, [6] = 23, [7] = 42, [8] = 52, [9] = 6 }

function executeServerCommandHandler(commandHandler, args)
	triggerServerEvent ( "executeServerCommandHandler", getLocalPlayer(), commandHandler, args )
end

screenWidth, screenHeight = guiGetScreenSize()
screenCenterX, screenCenterY = screenWidth/2, screenHeight/2 -- the screen center
lastx, lasty, lastz = 0


--JOBSKINS ENTFERNT DAVON
rpgPlayerSkinsM =
{
	7,15,17,18,19,20,21,22,23,24,25,26,28,29,30,31,32,33,35,36,37,43,44,45,46,47,48,49,51,52,57,58,59,60,62,66,67,68,72,73,78,79,82,83,84,94,95,96,97,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,120,121,122,123,124,125,126,127,128,132,133,134,135,136,137,142,143,144,146,153,154,156,158,159,160,161,162,163,164,165,166,170,173,174,175,176,177,180,181,182,183,184,185,188,200,201,202,206,210,212,213,217,220,221,222,223,227,228,229,230,234,235,236,239,241,242,247,248,250,254,258,259,261,262
}
rpgPlayerSkinsW = 
{
	10,11,12,13,38,39,40,41,53,54,55,56,69,75,76,77,88,89,90,91,92,93,129,130,131,141,148,150,151,157,169,190,191,192,193,195,196,197,198,199,207,211,214,215,216,218,219,224,225,226,231,232,233,251,263
}

BusLines = 
{
	"Linie 1",
	"Linie 2",
	"Linie 3",
	"Linie 4"
}

JobNames =
{
	"Arbeitslos",
	"Autoverkaeufer",
	"LKW-Fahrer",
	"Polizist",
	"Autofix Mechaniker",
	"Autohus",
	"Beamter",
	"Sanitaeter",
	"Feuerwehrmann",
	"Reporter",
	"Fahrlehrer",
	"car4you"
}

JobRang =
{
	"Auszubildender",
	"Mitarbeiter",
	"Chef"
}

AdminRang =
{
	"Benutzer",
	"Supporter",
	"Moderator",
	"Administrator"
}

function getJobName(jobid)
	local jobname = nil
	if jobid == 0 then
		jobname = "Arbeitslos"
	elseif jobid == 1 then
		jobname = "Autoverkaeufer"
	elseif jobid == 2 then
		jobname = "LKW-Fahrer"
	elseif jobid == 3 then
		jobname = "Polizist"
	elseif jobid == 4 then
		jobname = "Autofix Mechaniker"
	elseif jobid == 5 then
		jobname = "Gebrauchtwagenhandler"
	elseif jobid == 6 then
		jobname = "Beamter"
	elseif jobid == 7 then
		jobname = "Sanitaeter"		
	else
		jobname = false
	end
	return jobname
end

function getJobRangName(rangid)
	local rangname = nil
	if rangid == 0 then
		rangname = "Auszubildender"
	elseif rangid == 1 then
		rangname = "Mitarbeiter"
	elseif rangid == 2 then
		rangname = "Chef"
	else
		rangname = false
	end
	return rangname
end

function getPlayerRightsName(id)
	local name = nil
	if tonumber(id) == 0 then
		name = "Benutzer"
	elseif tonumber(id) == 0.5 then
		name = "Supporter"
	elseif tonumber(id) == 1 then
		name = "Moderator"
	elseif tonumber(id) == 2 then
		name = "Administrator"
	else
		name = false
	end
	return name
end


function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end


function dxDrawProgressBar(x, y, w, h, bgcolor, color, color2, value, white)

	if value > 1 then value = 1 end
	
	--Umriss zeichnen
	if not white then
		dxDrawRectangle ( x, y, w, 1 ,tocolor( 0,0,0,255 ), false )
		dxDrawRectangle ( x, y, 1, h+1 ,tocolor( 0,0,0,255 ), false )
		dxDrawRectangle ( x+w, y, 1, h+1 ,tocolor( 0,0,0,255 ), false )
		dxDrawRectangle ( x, y+h, w, 1 ,tocolor( 0,0,0,255 ), false )
	else
		dxDrawRectangle ( x, y, w, 1 ,tocolor( 255,255,255, 255 ), false )
		dxDrawRectangle ( x, y, 1, h+1 ,tocolor( 255,255,255, 255 ), false )
		dxDrawRectangle ( x+w, y, 1, h+1 ,tocolor( 255,255,255, 255 ), false )
		dxDrawRectangle ( x, y+h, w, 1 ,tocolor( 255,255,255, 255 ), false )	
	end
	
	--Hintergrund zeichnen
	dxDrawRectangle ( x, y, w, h ,bgcolor, false )
	
	x = x + 1;
	y = y + 1;
	w = w - 1;
	h = h - 1;
	
	local width = w*value
	local shade = 4;
	
	--Fuellung zeichnen
	dxDrawRectangle ( x, y, width, shade,color, false )
	dxDrawRectangle ( x, y + shade, width, h-shade,color2, false )	
end 

function dxDrawProgressBarBackwards(x, y, w, h, bgcolor, color, color2, value)
	
	if value > 1 then value = 1 end
	--Hintergrund zeichnen
	dxDrawRectangle ( x, y, w, h ,bgcolor, false )
	
	--Umriss zeichnen
	dxDrawRectangle ( x, y, w, 1 ,tocolor( 0,0,0, 255 ), false )
	dxDrawRectangle ( x, y, 1, h+1 ,tocolor( 0,0,0, 255 ), false )
	dxDrawRectangle ( x+w, y, 1, h+1 ,tocolor( 0,0,0, 255 ), false )
	dxDrawRectangle ( x, y+h, w, 1 ,tocolor( 0,0,0, 255 ), false )
	
	x = x + 1;
	y = y + 1;
	w = w - 1;
	h = h - 1;
	
	local width = w*value
	local shade = 4;
	
	--Fuellung zeichnen
	dxDrawRectangle ( (x+w)-width, y, width, shade,color, false )
	dxDrawRectangle ( (x+w)-width, y + shade, width, h-shade,color2, false )	
end

function setPlayerMoneyEx(money)
	setElementData(getLocalPlayer(), "geld", money)
	return true
end

function givePlayerMoneyEx(money)
	setElementData(getLocalPlayer(), "geld", tonumber(getElementData(getLocalPlayer(), "geld"))+money)
	return true
end

function takePlayerMoneyEx(money)
	setElementData(getLocalPlayer(), "geld", tonumber(getElementData(getLocalPlayer(), "geld"))-money)
	return true
end

function getPlayerMoneyEx(player)
	local money
	if isElement(player) then
		money = getElementData(player, "geld")
	end
	return money
end

function callServerFunction(funcname, ...)
    local arg = { ... }
    if (arg[1]) then
        for key, value in next, arg do
            if (type(value) == "number") then arg[key] = tostring(value) end
        end
    end
    -- If the serverside event handler is not in the same resource, replace 'resourceRoot' with the appropriate element
    triggerServerEvent("onClientCallsServerFunction", resourceRoot , funcname, unpack(arg))
end

function callClientFunction(funcname, ...)
    local arg = { ... }
    if (arg[1]) then
        for key, value in next, arg do arg[key] = tonumber(value) or value end
    end
    loadstring("return "..funcname)()(unpack(arg))
end
addEvent("onServerCallsClientFunction", true)
addEventHandler("onServerCallsClientFunction", resourceRoot, callClientFunction)

function showInfoMessage( title, message, type)
	exports.gui:hint(title, message, type)
end


preLoginTextures = {}
function replaceTexture(element, texture, file)
	if getElementData(getLocalPlayer(), "isPlayerLoggedIn") == true then
		replaceTextureFunc(element, texture, file)
	else
		--Store it for now until everything is properly downloaded
		preLoginTextures[#preLoginTextures+1] = {}
		preLoginTextures[#preLoginTextures].element = element
		preLoginTextures[#preLoginTextures].texture = texture
		preLoginTextures[#preLoginTextures].file = file
	end
end

local shaderTextures = {}
function replaceTextureFunc(element, texture, file)
	if element ~= nil and element ~= false and isElement(element) then
		if not shaderTextures[tostring(file)] then
			local texture = dxCreateTexture(file,"dxt3")
			if not texture then return false end
			local shader = dxCreateShader("fx/texture.fx")
			if not shader then return false end
			dxSetShaderValue(shader,"gTexture",texture)
			shaderTextures[tostring(file)] = shader
		end
	end
	return engineApplyShaderToWorldTexture(shaderTextures[tostring(file)],texture,element)
end


function dxDrawBackgroundedText(text, x, y, x1, y1, color, colorshadow, scale, font, ax, ay, clip, wordBreak, postGUI, colorCoded, subPixel)
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
	dxDrawText(removeColorCoding(text),x-1,y-1,x1-1,y1-1, colorshadow,scale, font, ax,ay,clip,wordBreak, postGUI, colorCoded, subPixel)
	dxDrawText(removeColorCoding(text),x-1,y+1,x1-1,y1+1, colorshadow,scale, font, ax,ay,clip,wordBreak, postGUI, colorCoded, subPixel)
	dxDrawText(removeColorCoding(text),x+1,y-1,x1+1,y1-1, colorshadow,scale, font, ax,ay,clip,wordBreak, postGUI, colorCoded, subPixel)
	dxDrawText(text,x,y,x1,y1,color,scale,font,ax,ay,clip,wordBreak,postGUI, colorCoded,subPixel)
end