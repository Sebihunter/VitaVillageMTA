---------------------------------------------------------------------------------------------------
-- sm version
---------------------------------------------------------------------------------------------------
function vCardPSVer()
 local info=dxGetStatus()
    for k,v in pairs(info) do
		if string.find(k, "VideoCardPSVersion") then
		smVersion=tostring(v)
		end
    end
	return smVersion
end

---------------------------------------------------------------------------------------------------
-- dxGetStatus for diag
---------------------------------------------------------------------------------------------------
addCommandHandler( "dxGetStatus",
function()
	local info=dxGetStatus()
	local ver = getVersion ().sortable
	local outStr = 'MTAVersion:'..ver..'dxGetStatus: '
	for k,v in pairs(info) do
		outStr = outStr..' '..k..': '..tostring(v)..'  ,'
	end
	--outputDebugString(outStr)
	setClipboard(outStr)
	outputChatBox('---dxGetStatus copied to clipboard---' )
end
)

---------------------------------------------------------------------------------------------------
-- debug lights
---------------------------------------------------------------------------------------------------
local lightDebugSwitch = false

addCommandHandler( "debugDynamicLights",
function()
	lightDebugSwitch = switchDebugLights(not lightDebugSwitch)
end
)

function switchDebugLights(switch)
	if switch then
		addEventHandler("onClientRender",root,renderDebugLights)
	else
		--outputDebugString('Debug mode: OFF')
		removeEventHandler("onClientRender",root,renderDebugLights)
	end
	return switch
end

local scx,scy = guiGetScreenSize()
function renderDebugLights()
	dxDrawText(fpscheck()..' FPS',scx/2,25)
	if (#lightTable.outputLights<1) then 
		return
	end
	dxDrawText(lightTable.thisLight..' / 15',scx/2,10)
	for index,this in ipairs(lightTable.outputLights) do
		if this.enabled then
			local xVal,yVal,xStr,yStr,dist,sx,sy = getBoxScreenParams(scx,scy,this.pos[1],this.pos[2],this.pos[3],0.5,0.5)
			local col = tocolor(this.color[1]*255,this.color[2]*255,this.color[3]*255,this.color[4]*255)
			if xVal and yVal then
				dxDrawRectangle ( xVal,yVal,xStr,yStr,col)
			end
		end
	end
end

function getBoxScreenParams(szx,szy,hx,hy,hz,sizeX,sizeY)
	local sx,sy = getScreenFromWorldPosition(hx,hy,hz,0.25,true)
	if sx and sy then
		local cx,cy,cz,clx,cly,clz,crz,cfov = getCameraMatrix()
		local dist = getDistanceBetweenPoints3D(hx,hy,hz,cx,cy,cz)
		local xMult = szx/800/70*cfov*sizeX
		local yMult = szy/600/70*cfov*sizeY
		local xVal = sx-(100/dist)* xMult
		local yVal = sy-(100/dist)* yMult
		local xStr = (200/dist)* xMult
		local yStr = (200/dist)* yMult
		return xVal,yVal,xStr,yStr,dist,sx,sy
	else
		return false
	end
end

local frames,lastsec,fpsOut = 0,0,0
function fpscheck()
	local frameticks = getTickCount()
	frames = frames + 1
	if frameticks - 1000 > lastsec then
		local prog = (frameticks - lastsec)
		lastsec = frameticks
		fps = frames / (prog / 1000)
		frames = fps * ((prog - 1000) / 1000)
		fpsOut = tostring(math.floor(fps))
	end
	return fpsOut
end

---------------------------------------------------------------------------------------------------
-- light sorting
---------------------------------------------------------------------------------------------------
function sortedLightOutput(inTable,isSo,distFade)
	local lightTable = {}
	for index,thisLight in ipairs(inTable) do
		local dist = getElementFromCameraDistance(thisLight.pos[1],thisLight.pos[2],thisLight.pos[3])
		if dist <= distFade then 
			local w = #lightTable + 1
			if not lightTable[w] then 
				lightTable[w] = {} 
			end
			lightTable[w].enabled = thisLight.enabled
			lightTable[w].lType = thisLight.lType
			lightTable[w].pos = thisLight.pos
			lightTable[w].dist = dist
			lightTable[w].color = thisLight.color	
			lightTable[w].attenuation = thisLight.attenuation
			lightTable[w].normalShadow = thisLight.normalShadow 
			if (thisLight.lType==2) then
				lightTable[w].dir = thisLight.dir				
				lightTable[w].falloff = thisLight.falloff			
				lightTable[w].theta = thisLight.theta			
				lightTable[w].phi = thisLight.phi		
			end
		end
	end
	if isSo then 
		lightTable = tableSort(lightTable)
	end
	return lightTable
end

function removeEmptyEntry(inTable)
	local outTable = {}
	for index,value in ipairs(inTable) do
		if inTable[index].enabled then
		local w = #outTable + 1
			outTable[w] = value
			----outputDebugString('inserted'..w..' of '..index)
		end
	end
	return outTable
end

function tableSort(inTable)
	if #inTable < 2 then return inTable end
		for i = 1, #inTable do 
			for j = 2, #inTable do
				if inTable[j].dist < inTable[j-1].dist then 
					local temp = inTable[j-1]
					inTable[j-1] = inTable[j]
					inTable[j] = temp
				end
			end
		end
	return inTable
end

function getElementFromCameraDistance(hx,hy,hz)
	local cx,cy,cz,clx,cly,clz,crz,cfov = getCameraMatrix()
	local dist = getDistanceBetweenPoints3D(hx,hy,hz,cx,cy,cz)
	return dist
end

---------------------------------------------------------------------------------------------------
-- config file creation for the light resource
---------------------------------------------------------------------------------------------------
function createLightConfigFile(currLightNr, isWrdLayer, isPedLayer, isWrdSobel, isNightMod, isPedDiffuse, isWrdShading)
	if isWrdLayer then isWrdLayer = '1' else isWrdLayer = '0' end
	if isPedLayer then isPedLayer = '1' else isPedLayer = '0' end
	if isWrdSobel then isWrdSobel = '1' else isWrdSobel = '0' end
	if isNightMod then isNightMod = '1' else isNightMod = '0' end
	if isPedDiffuse then isPedDiffuse = '1' else isPedDiffuse = '0' end
	if isWrdShading then isWrdShading = '1' else isWrdShading = '0' end	
	
	--outputDebugString('Created config for: '..currLightNr..' + 1 lights.')
	--outputDebugString('Effect layered WRD: '..isWrdLayer..' Effect layered PED: '..isPedLayer)
	--outputDebugString('Effect sobel WRD: '..isWrdSobel)
	--outputDebugString('Effect night mod: '..isNightMod)
	--outputDebugString('Effect diffuse PED: '..isPedDiffuse)
	--outputDebugString('Effect normal WRD: '..isWrdShading)	
	if writeToLightConfigFile("shaders/light_config.txt",
		"#define iLightNumber "..currLightNr.."\n"..
		" #define wrdLayered "..isWrdLayer.."\n"..
		" #define wrdSobel "..isWrdSobel.."\n"..
		" #define nightMod "..isNightMod.."\n"..
		" #define enableDiffuseLights "..isPedDiffuse.."\n"..
		" #define wrdNormalShading "..isWrdShading.."\n"..
		" #define pedLayered "..isPedLayer) then
		return true
	else
		return false
	end
end

function writeToLightConfigFile(filePath,fileText)
	local theFile = fileCreate(filePath)
	if (theFile) then
		fileWrite(theFile, fileText)
		fileClose(theFile)
		return true
	else
		return false
	end
end

---------------------------------------------------------------------------------------------------
-- vector stuff
---------------------------------------------------------------------------------------------------
function getVectorFromEuler(rotX, rotY, rotZ)
	local matrix = get3x3MatrixFromZXYEuler(rotX, rotY, rotZ)

	return matrix[2][1],matrix[2][2],matrix[2][3]
end

function get3x3MatrixFromZXYEuler(rrx, rry, rrz)
	local rx, ry, rz = math.rad(rrx), math.rad(rry), math.rad(rrz)
	local matrix = {}
	matrix[1] = {} -- up
	matrix[1][1] = math.cos(rz)*math.cos(ry) - math.sin(rz)*math.sin(rx)*math.sin(ry)
	matrix[1][2] = math.cos(ry)*math.sin(rz) + math.cos(rz)*math.sin(rx)*math.sin(ry)
	matrix[1][3] = -math.cos(rx)*math.sin(ry)
     
	matrix[2] = {} -- fw
	matrix[2][1] = -math.cos(rx)*math.sin(rz)
	matrix[2][2] = math.cos(rz)*math.cos(rx)
	matrix[2][3] = math.sin(rx)
     
	matrix[3] = {} -- left
	matrix[3][1] = math.cos(rz)*math.sin(ry) + math.cos(ry)*math.sin(rz)*math.sin(rx)
	matrix[3][2] = math.sin(rz)*math.sin(ry) - math.cos(rz)*math.cos(ry)*math.sin(rx)
	matrix[3][3] = math.cos(rx)*math.cos(ry)
     
	return matrix
end
