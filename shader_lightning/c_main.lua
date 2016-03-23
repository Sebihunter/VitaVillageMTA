-------------------------------------
--Resource: Shader Dynamic lights  --
--Author: Ren712                   --
--Contact: knoblauch700@o2.pl      --
-------------------------------------

shaderTable = { worldShader = {} , smVersion = 0 , isStarted = false , isTimeOut = false, isError = false }
lightTable = { inputLights = {} , outputLights = {} , thisLight = 0 , isInNrChanged = false, isInValChanged = false }
funcTable = {}

---------------------------------------------------------------------------------------------------
-- editable variables
---------------------------------------------------------------------------------------------------

local isWrdEffectLayered = false -- set true if you want to use other shader world effects - like nightMod or shaderDetail
								 -- (useful if changed shaderSettings.gBrightness, but eats up some FPS)
local isPedEffectLayered = false -- set true if you want to use other shader ped effects - like shaderPedNormal							
local edgeTolerance = 0.39 -- cull the lights that are off the screen
local effectRange = 240 -- effect max range
local isEffectForcedOn = false -- set true to force the effects to stay on despite no light sources 
								-- (useful if changed shaderSettings.gBrightness)
local effectTimeOut = 4 -- how much time does the effect turn off after 0 lights synced (in seconds)
local shaderSettings = {
				gDistFade = {230, 200}, -- [0]MaxEffectFade,[1]MinEffectFade
				gMaxLights = 15, -- how many light effects can be streamed in at once (max 15)
				gWorldNormalShading = true, -- enables object self shadowing ( may be bugged for rotated objects on a custom map)
				gNormalShadingAmount = 1, -- ( 1 - standard , 0 - none )
				gGenerateBumpNormals = false, -- generate bump normals from color texture (hogs few fps)
				gTextureSize = 512.0, -- generated normat texture size (256 or 512 recomended)
				gNormalStrength = {1,1}, -- Bump strength (0-1)
				gBrightness = 1, -- modify texture brightness 0 - fully obscured 1 - normal brightness
				gNightMod = false, -- enable nightMod effect - requires proper manipulation of setTextureBrightness and SetShaderDayTime, 
									-- also some additional shaders.
				gDayTime = 1, -- another additional variable to control texture colors - requires setShaderNightMod(true)
				gPedDiffuse = true, -- enable or disable gta directional lights for ped.
				dirLight = { enabled = false, dir = {0,0,-1}, col = {0,0,0,0} }	-- this is a single directional light table (stould stay unaltered)			
				}

---------------------------------------------------------------------------------------------------
-- texture lists
---------------------------------------------------------------------------------------------------
local removeList = {
						"",												-- unnamed
						"basketball2","skybox_tex",	"flashlight_*",     -- other
						"muzzle_texture*",								-- guns
						"font*","radar*","sitem16","snipercrosshair",	-- hud
						"siterocket","cameracrosshair",					-- hud
						"fireba*","wjet6",								-- flame
						"vehiclegeneric256","vehicleshatter128", 		-- vehicles
						"*shad*",										-- shadows
						"coronastar","coronamoon","coronaringa","headlight*",
						"coronaheadlightline",							-- coronas
						"lunar",										-- moon
						"tx*",											-- grass effect
						"lod*",											-- lod models
						"cj_w_grad",									-- checkpoint texture
						"*cloud*",										-- clouds
						"*smoke*",										-- smoke
						"sphere_cj",									-- nitro heat haze mask
						"particle*",									-- particle skid and maybe others
						"water*","newaterfal1_256",
						"boatwake*","splash_up","carsplash_*",
						"boatsplash",
						"gensplash","wjet4","bubbles","blood*",			-- splash
						"fist","*icon",
						"unnamed",	
						"sl_dtwinlights*","nitwin01_la","sfnite*","shad_exp",
						"vgsn_nl_strip","blueshade*",
						"royaleroof01_64","flmngo05_256","flmngo04_256",
						"casinolights6lit3_256",						-- some shinemaps and anims
					}

local reApplyList = {
					"ws_tunnelwall2smoked", "shadover_law",
					"greenshade_64", "greenshade2_64", "venshade*", 
					"blueshade2_64",
					}

---------------------------------------------------------------------------------------------------
-- main light functions
---------------------------------------------------------------------------------------------------
function funcTable.create(lType,posX,posY,posZ,colorR,colorG,colorB,colorA,dirX,dirY,dirZ,isEuler,falloff,theta,phi,attenuation,normalShadow)
	local w = #lightTable.inputLights + 1
	if not lightTable.inputLights[w] then lightTable.inputLights[w] ={}	end
	lightTable.inputLights[w].enabled = true
	lightTable.inputLights[w].lType = lType
	lightTable.inputLights[w].pos = {posX,posY,posZ}
	lightTable.inputLights[w].color = {colorR,colorG,colorB,colorA}	
	lightTable.inputLights[w].attenuation = attenuation
	lightTable.inputLights[w].normalShadow = normalShadow
	if (lType > 1) then 
		if isEuler then 
			local eul2vecX,eul2vecY,eul2vecZ = getVectorFromEuler(dirX,dirY,dirZ) 
			lightTable.inputLights[w].dir = {eul2vecX,eul2vecY,eul2vecZ}
		else
			lightTable.inputLights[w].dir = {dirX,dirY,dirZ}
		end
		lightTable.inputLights[w].falloff = falloff
		lightTable.inputLights[w].theta = theta
		lightTable.inputLights[w].phi = phi
	end
	--outputDebugString('Created Light TYPE: '..lType..' ID:'..w)
	lightTable.isInNrChanged = true
	return w
end

function funcTable.destroy(w)
	if lightTable.inputLights[w] then
		lightTable.inputLights[w].enabled = false
		lightTable.isInNrChanged = true
		--outputDebugString('Destroyed Light ID:'..w)
		return true
	else
		--outputDebugString('Have Not Destroyed Light ID:'..w)
		return false 
	end
end

function funcTable.setMaxLights(maxLights)
	shaderSettings.gMaxLights = maxLights
	funcTable.refreshSettings()
	if isEffectForcedOn then
		if funcTable.forceStop() then 
			return funcTable.forceStart()
		end
	else
		return funcTable.forceStop() or funcTable.forceStart()		
	end
end

function funcTable.setWorldNormalShading(isGenerated)
	shaderSettings.gWorldNormalShading = isGenerated
	funcTable.refreshSettings()
	if isEffectForcedOn then
		if funcTable.forceStop() then 
			return funcTable.forceStart()
		end
	else
		return funcTable.forceStop() or funcTable.forceStart()		
	end
end

function funcTable.setNormalShadingAmount(w)
	if ((w <= 1) and (w >= 0)) then
		shaderSettings.gNormalShadingAmount = w
		if shaderTable.isStarted then
			return funcTable.refreshGlobalShaderValues()
		else
			return true
		end
	else
		return false
	end
end

function funcTable.setTextureBrightness(w)
	if ((w <= 1) and (w >= 0)) then
		shaderSettings.gBrightness = w
		if shaderTable.isStarted then
			return funcTable.refreshGlobalShaderValues()
		else
			return true
		end
	else
		return false
	end
end

function funcTable.setDistFade(w,v)
	if ((w <= effectRange) and (w >= v)) then
		shaderSettings.gDistFade = {w,v}
		if shaderTable.isStarted then
			return funcTable.refreshGlobalShaderValues()
		else
			return true
		end
	else
		return false
	end
end

function funcTable.setEffectRange(w)
	if (w > 0) then
		effectRange = w
		funcTable.refreshSettings()
		if isEffectForcedOn then
			if funcTable.forceStop() then 
				return funcTable.forceStart()
			end
		else
			return funcTable.forceStop() or funcTable.forceStart()		
		end
	else
		return false
	end
end

function funcTable.generateBumpNormals(isGenerated,texSize,stX,stY)
	shaderSettings.gGenerateBumpNormals = isGenerated
	shaderSettings.gTextureSize = texSize
	shaderSettings.gNormalStrength = {stX,stY}
	funcTable.refreshSettings()
	if isEffectForcedOn then
		if funcTable.forceStop() then 
			return funcTable.forceStart()
		end
	else
		return funcTable.forceStop() or funcTable.forceStart()		
	end
end

function funcTable.setShadersForcedOn(w)
	if type(w)=="boolean" then
		isEffectForcedOn = w
		--outputDebugString('Pixel Lighting: shaders forced '..tostring(isEffectForcedOn) )
		if isEffectForcedOn then
			return funcTable.forceStart()
		else
			return true
		end
	else
		return false
	end
end

function funcTable.setShadersTimeOut(w)
	if type(w)=="number" then
		effectTimeOut = w
		--outputDebugString('Pixel Lighting: effect timeout '..tostring(effectTimeOut)..' sec' )
		return true
	else
		return false
	end
end

function funcTable.setShaderNightMod(w)
	shaderSettings.gNightMod = w
	funcTable.refreshSettings()
	if isEffectForcedOn then
		if funcTable.forceStop() then 
			return funcTable.forceStart()
		end
	else
		return funcTable.forceStop() or funcTable.forceStart()		
	end
end

function funcTable.setShaderPedDiffuse(w)
	shaderSettings.gPedDiffuse = w
	funcTable.refreshSettings()
	if isEffectForcedOn then
		if funcTable.forceStop() then 
			return funcTable.forceStart()
		end
	else
		return funcTable.forceStop() or funcTable.forceStart()		
	end
end

function funcTable.setShaderDayTime(w)
	if ((w <= 1) and (w >= 0)) then
		shaderSettings.gDayTime = w
	else
		return false
	end
end

function funcTable.setDirLightEnable(isTrue)
	shaderSettings.dirLight.enabled = isTrue
	funcTable.addShaderLightDirSetings(shaderTable.worldShader[1])
	funcTable.addShaderLightDirSetings(shaderTable.worldShader[2])
	funcTable.addShaderLightDirSetings(shaderTable.worldShader[3])
end

function funcTable.setDirLightColor(colorR,colorG,colorB,colorA)
	shaderSettings.dirLight.col = {colorR,colorG,colorB,colorA}
	funcTable.addShaderLightDirSetings(shaderTable.worldShader[1])
	funcTable.addShaderLightDirSetings(shaderTable.worldShader[2])
	funcTable.addShaderLightDirSetings(shaderTable.worldShader[3])
end

function funcTable.setDirLightDirection(dirX,dirY,dirZ,isEuler)
	if isEuler then
		local eul2vecX,eul2vecY,eul2vecZ = getVectorFromEuler(dirX,dirY,dirZ) 
		shaderSettings.dirLight.dir =  {eul2vecX,eul2vecY,eul2vecZ}
	else
		shaderSettings.dirLight.dir =  {dirX,dirY,dirZ}
	end
	funcTable.addShaderLightDirSetings(shaderTable.worldShader[1])
	funcTable.addShaderLightDirSetings(shaderTable.worldShader[2])
	funcTable.addShaderLightDirSetings(shaderTable.worldShader[3])
end

---------------------------------------------------------------------------------------------------
-- disable all lights
---------------------------------------------------------------------------------------------------
function funcTable.clearLights()
	for v=0,shaderSettings.gMaxLights,1 do
		local lightEnableStr = 'gLight'..v..'Enable'
		dxSetShaderValue( shaderTable.worldShader[1],lightEnableStr, false )
		dxSetShaderValue( shaderTable.worldShader[2],lightEnableStr, false )
		dxSetShaderValue( shaderTable.worldShader[3],lightEnableStr, false )
	end
end

---------------------------------------------------------------------------------------------------
-- creating and sorting a table of active lights
---------------------------------------------------------------------------------------------------
local tempTable = nil
local tickCount = getTickCount()
addEventHandler("onClientPreRender",root, function()
	if (#lightTable.inputLights == 0) then
		return 
	end
	if lightTable.isInNrChanged then 
		tempTable = removeEmptyEntry(lightTable.inputLights)
		lightTable.outputLights = sortedLightOutput(tempTable,true,shaderSettings.gDistFade[1])		
		lightTable.isInNrChanged = false
		return
	end
		if lightTable.isInValChanged or ( tickCount + 200 < getTickCount() ) then 
			lightTable.outputLights = sortedLightOutput(tempTable,true,shaderSettings.gDistFade[1])
			lightTable.isInValChanged = false
			tickCount = getTickCount()
		end
end
,true ,"low-1")	
---------------------------------------------------------------------------------------------------
-- set shader values of active lights
---------------------------------------------------------------------------------------------------
addEventHandler("onClientPreRender", root, function()
	if ((#lightTable.outputLights == 0) and not isEffectForcedOn and not shaderTable.isTimeOut) then
		return
	end 
	if shaderTable.isStarted then 
		funcTable.clearLights() 
	else 
		return 
	end
	lightTable.thisLight = 0
	for index,this in ipairs(lightTable.outputLights) do
		if this.dist <= shaderSettings.gDistFade[1] and this.enabled and lightTable.thisLight < shaderSettings.gMaxLights then
			local isOnScrX, isOnScrY, isOnScrZ = getScreenFromWorldPosition ( this.pos[1], this.pos[2], this.pos[3], edgeTolerance, true )
			if (((isOnScrX and isOnScrY and isOnScrZ) or (this.dist <= shaderSettings.gDistFade[1]*0.13))) then
				local lightEnableStr = 'gLight'..lightTable.thisLight..'Enable'
				local lightTypeStr = 'gLight'..lightTable.thisLight..'Type'
				local lightColorStr = 'gLight'..lightTable.thisLight..'Diffuse'
				local lightAttenuStr = 'gLight'..lightTable.thisLight..'Attenuation'
				local lightSelfShadStr = 'gLight'..lightTable.thisLight..'NormalShadow'				
				local lightPositiStr = 'gLight'..lightTable.thisLight..'Position'
			
				dxSetShaderValue( shaderTable.worldShader[1],lightEnableStr,true )
				dxSetShaderValue( shaderTable.worldShader[1],lightTypeStr,this.lType)			
				dxSetShaderValue( shaderTable.worldShader[1],lightPositiStr,this.pos[1],this.pos[2],this.pos[3])
				dxSetShaderValue( shaderTable.worldShader[1],lightColorStr,this.color[1],this.color[2],this.color[3],this.color[4])
				dxSetShaderValue( shaderTable.worldShader[1],lightAttenuStr,this.attenuation)
				dxSetShaderValue( shaderTable.worldShader[1],lightSelfShadStr,this.normalShadow)
			
				dxSetShaderValue( shaderTable.worldShader[2],lightEnableStr,true )
				dxSetShaderValue( shaderTable.worldShader[2],lightTypeStr,this.lType)				
				dxSetShaderValue( shaderTable.worldShader[2],lightPositiStr,this.pos[1],this.pos[2],this.pos[3])
				dxSetShaderValue( shaderTable.worldShader[2],lightColorStr,this.color[1],this.color[2],this.color[3],this.color[4])
				dxSetShaderValue( shaderTable.worldShader[2],lightAttenuStr,this.attenuation)
			
				dxSetShaderValue( shaderTable.worldShader[3],lightEnableStr,true )
				dxSetShaderValue( shaderTable.worldShader[3],lightTypeStr,this.lType)				
				dxSetShaderValue( shaderTable.worldShader[3],lightPositiStr,this.pos[1],this.pos[2],this.pos[3])
				dxSetShaderValue( shaderTable.worldShader[3],lightColorStr,this.color[1],this.color[2],this.color[3],this.color[4])
				dxSetShaderValue( shaderTable.worldShader[3],lightAttenuStr,this.attenuation)
			
				if (this.lType==2) then
					local lightDirectStr = 'gLight'..lightTable.thisLight..'Direction'
					local lightFalloffStr = 'gLight'..lightTable.thisLight..'Falloff'
					local lightThetaStr = 'gLight'..lightTable.thisLight..'Theta'
					local lightPhiStr = 'gLight'..lightTable.thisLight..'Phi'
			
					dxSetShaderValue( shaderTable.worldShader[1],lightDirectStr,this.dir)
					dxSetShaderValue( shaderTable.worldShader[1],lightFalloffStr,this.falloff)
					dxSetShaderValue( shaderTable.worldShader[1],lightThetaStr,this.theta)
					dxSetShaderValue( shaderTable.worldShader[1],lightPhiStr,this.phi)

					dxSetShaderValue( shaderTable.worldShader[2],lightDirectStr,this.dir)
					dxSetShaderValue( shaderTable.worldShader[2],lightFalloffStr,this.falloff)
					dxSetShaderValue( shaderTable.worldShader[2],lightThetaStr,this.theta)
					dxSetShaderValue( shaderTable.worldShader[2],lightPhiStr,this.phi)

					dxSetShaderValue( shaderTable.worldShader[3],lightDirectStr,this.dir)
					dxSetShaderValue( shaderTable.worldShader[3],lightFalloffStr,this.falloff)
					dxSetShaderValue( shaderTable.worldShader[3],lightThetaStr,this.theta)
					dxSetShaderValue( shaderTable.worldShader[3],lightPhiStr,this.phi)

					dxSetShaderValue( shaderTable.worldShader[1],"gDayTime", shaderSettings.gDayTime)
					dxSetShaderValue( shaderTable.worldShader[3],"gDayTime", shaderSettings.gDayTime)
				end
				lightTable.thisLight = lightTable.thisLight + 1
			end
		end
	end
end
,true ,"low-2")
---------------------------------------------------------------------------------------------------
-- add or remove shader settings 
---------------------------------------------------------------------------------------------------
function funcTable.addShaderLightDirSetings(theShader)
	if shaderTable.isStarted then 
		dxSetShaderValue( theShader,"gDirLightEnable",shaderSettings.dirLight.enabled )
		dxSetShaderValue( theShader,"gDirLightDiffuse",shaderSettings.dirLight.col )
		dxSetShaderValue( theShader,"gDirLightDirection",shaderSettings.dirLight.dir )
	end
end

function funcTable.addShaderLightSettings(theShader)
	dxSetShaderValue( theShader,"gDistFade",shaderSettings.gDistFade )
	dxSetShaderValue( theShader,"gNormalShadingAmount",shaderSettings.gNormalShadingAmount )
	dxSetShaderValue( theShader,"gTextureSize",shaderSettings.gTextureSize )
	dxSetShaderValue( theShader,"gNormalStrength",shaderSettings.gNormalStrength )
	dxSetShaderValue( theShader,"gBrightness", shaderSettings.gBrightness )
	dxSetShaderValue( theShader,"gDirLightEnable",shaderSettings.dirLight.enabled )
	dxSetShaderValue( theShader,"gDirLightDiffuse",shaderSettings.dirLight.col )
	dxSetShaderValue( theShader,"gDirLightDirection",shaderSettings.dirLight.dir )
	engineApplyShaderToWorldTexture ( theShader, "*" )

	-- remove shader from world texture
	for _,removeMatch in ipairs(removeList) do
		engineRemoveShaderFromWorldTexture ( theShader, removeMatch )	
	end	
	-- reapply shader to world texture
	for _,applyMatch in ipairs(reApplyList) do
		engineApplyShaderToWorldTexture ( theShader, applyMatch )	
	end	
end

function funcTable.removeShaderSettings(theShader)
	engineRemoveShaderFromWorldTexture ( theShader, "*" )
	destroyElement ( theShader )
	theShader = nil
end

function funcTable.refreshGlobalShaderValues()
	if shaderTable.isStarted then
		for shNr=1,3,1 do
			dxSetShaderValue ( shaderTable.worldShader[shNr],"gDistFade",shaderSettings.gDistFade )
			dxSetShaderValue ( shaderTable.worldShader[shNr],"gNormalShadingAmount",shaderSettings.gNormalShadingAmount )
			dxSetShaderValue ( shaderTable.worldShader[shNr],"gTextureSize",shaderSettings.gTextureSize )
			dxSetShaderValue ( shaderTable.worldShader[shNr],"gNormalStrength",shaderSettings.gNormalStrength )
			dxSetShaderValue ( shaderTable.worldShader[shNr],"gBrightness", shaderSettings.gBrightness )
		end
		return true
	else
		return false
	end
end
---------------------------------------------------------------------------------------------------
-- create , destroy or refresh shaders 
---------------------------------------------------------------------------------------------------
function funcTable.createWorldLightShader(ligNumber,isWrdLayered,isPedLayered,isWrdSobel,isNightMod,isPedDiffuse,isWrdShading)
	if shaderTable.isStarted then return end
	if not createLightConfigFile(ligNumber,isWrdLayered,isPedLayered,isWrdSobel,isNightMod,isPedDiffuse,isWrdShading) then outputChatBox('Pixel Lighting: Config file not created!',255,0,0) return end
	local shadOption ="SM2"
	if ligNumber>0 then 
		shadOption ="SM3"
	end
	shaderTable.worldShader[1] = dxCreateShader ( "shaders/shader_lightSpotWrd"..shadOption..".fx",1,effectRange,isWrdLayered,"world,object")
	shaderTable.worldShader[2] = dxCreateShader ( "shaders/shader_lightSpotVeh"..shadOption..".fx",1,effectRange,true,"vehicle")
	shaderTable.worldShader[3] = dxCreateShader ( "shaders/shader_lightSpotPed"..shadOption..".fx",1,effectRange,isPedLayered,"ped")
	shaderTable.isStarted = shaderTable.worldShader[1] and shaderTable.worldShader[2] and shaderTable.worldShader[3]
	if not shaderTable.isStarted then 
		return false 
	else
		funcTable.addShaderLightSettings(shaderTable.worldShader[1])
		funcTable.addShaderLightSettings(shaderTable.worldShader[2])
		funcTable.addShaderLightSettings(shaderTable.worldShader[3])
		return true
	end
end

function funcTable.destroyWorldLightShader()
	if shaderTable.isStarted then
		funcTable.removeShaderSettings(shaderTable.worldShader[1])
		funcTable.removeShaderSettings(shaderTable.worldShader[2])
		funcTable.removeShaderSettings(shaderTable.worldShader[3])
		--outputDebugString('Pixel Lighting: Stopped the shader effects.')
		shaderTable.isStarted = false
		return true
	else
		return false
	end
end

function funcTable.refreshSettings()
	if shaderTable.isStarted then
		engineRemoveShaderFromWorldTexture ( shaderTable.worldShader[1], "*" )
		engineRemoveShaderFromWorldTexture ( shaderTable.worldShader[2], "*" )
		engineRemoveShaderFromWorldTexture ( shaderTable.worldShader[3], "*" )
		funcTable.addShaderLightSettings(shaderTable.worldShader[1])
		funcTable.addShaderLightSettings(shaderTable.worldShader[2])
		funcTable.addShaderLightSettings(shaderTable.worldShader[3])
		return true
	else
		return false
	end
end

---------------------------------------------------------------------------------------------------
-- onClientResourceStart 
---------------------------------------------------------------------------------------------------		
addEventHandler("onClientResourceStart", getResourceRootElement( getThisResource()), function()
	local ver = getVersion ().sortable
	local build = string.sub( ver, 9, 13 )
	if build<"04938" or ver < "1.3.1" then 
		outputChatBox('Pixel Lighting: is not compatible with this client version!',255,0,0)
		return
	end
	shaderTable.smVersion = vCardPSVer()
	if (shaderTable.smVersion~="3") then 
		outputChatBox('Pixel Lighting: shader model 3 not supported',255,0,0)
		shaderTable.isStarted = funcTable.createWorldLightShader(0, isWrdEffectLayered, isPedEffectLayered, false, shaderSettings.gNightMod,shaderSettings.gPedDiffuse,shaderSettings.gWorldNormalShading)
	else
		shaderTable.isStarted = funcTable.createWorldLightShader(shaderSettings.gMaxLights-1, isWrdEffectLayered, isPedEffectLayered, shaderSettings.gGenerateBumpNormals, shaderSettings.gNightMod,shaderSettings.gPedDiffuse,shaderSettings.gWorldNormalShading)
	end
	if not shaderTable.isStarted  then 
		outputChatBox('Pixel Lighting: failed to start shaders!',255,0,0)
		shaderTable.isError = true
		return
	else
		--outputChatBox('Pixel Lighting: started',0,255,0)			
	end
end
)

---------------------------------------------------------------------------------------------------
-- create or destroy shaders (depending on the number of synced lights) 
---------------------------------------------------------------------------------------------------
local currentCount = getTickCount ()

addEventHandler("onClientRender", root, function()
	if shaderTable.isError or isEffectForcedOn then 
		return 
	end
	if (#lightTable.outputLights == 0) then
		shaderTable.isTimeOut = true
		if (getTickCount () < (currentCount + effectTimeOut * 1000)) then 
			return 
		end
		shaderTable.isTimeOut = false
		funcTable.forceStop()
	else
		funcTable.forceStart()
		currentCount = getTickCount ()
	end
end	
,true ,"low-3")	


function funcTable.forceStart()
	if not shaderTable.isStarted then
		if (shaderTable.smVersion=="3") then 
			shaderTable.isStarted = funcTable.createWorldLightShader(shaderSettings.gMaxLights-1, isWrdEffectLayered, isPedEffectLayered, shaderSettings.gGenerateBumpNormals, shaderSettings.gNightMod,shaderSettings.gPedDiffuse,shaderSettings.gWorldNormalShading)
		elseif (shaderTable.smVersion=="2") then
			shaderTable.isStarted = funcTable.createWorldLightShader(0, isWrdEffectLayered, isPedEffectLayered, false, shaderSettings.gNightMod,shaderSettings.gPedDiffuse,shaderSettings.gWorldNormalShading)
		end
		if shaderTable.isStarted then 
			--outputDebugString('Pixel Lighting: started shaders' )			
		else
			shaderTable.isError = true
			--outputDebugString('Pixel Lighting: failed to start shaders!')
		end
	end
	return shaderTable.isStarted
end

function funcTable.forceStop()
	if shaderTable.isStarted then
		shaderTable.isStarted = not funcTable.destroyWorldLightShader()
		--outputDebugString('Pixel Lighting: stopped - no synced lights' )
	end
	return not shaderTable.isStarted
end
