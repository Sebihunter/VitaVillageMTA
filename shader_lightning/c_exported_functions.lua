function createPointLight(posX,posY,posZ,colorR,colorG,colorB,colorA,attenuation,...)
	local reqParam = {posX,posY,posZ,colorR,colorG,colorB,colorA,attenuation}
	local isThisValid = true
	local countParam = 0
	for m, param in ipairs(reqParam) do
		countParam = countParam + 1
		isThisValid = isThisValid and param~=nil and (type(param) == "number")
	end
	local optParam = {...}
	if not isThisValid or (#optParam > 1 or #reqParam ~= 8 ) or (countParam ~= 8) then 
		return false 
	end
	if (type(optParam[1]) ~= "boolean") then
		optParam[1] = true
	end
	local normalShadow =  optParam[1]
	local SHPelementID = funcTable.create(1,posX,posY,posZ,colorR*colorA,colorG*colorA,colorB*colorA,colorA,dirX,dirY,dirZ,false,0,0,0,attenuation,normalShadow)
	return createElement("SHPixelLight",tostring(SHPelementID))
end

function createSpotLight(posX,posY,posZ,colorR,colorG,colorB,colorA,dirX,dirY,dirZ,isEuler,falloff,theta,phi,attenuation,...)
	local reqParam = {posX,posY,posZ,colorR,colorG,colorB,colorA,dirX,dirY,dirZ,falloff,theta,phi,attenuation}
	local isThisValid = true
	local countParam = 0
	for m, param in ipairs(reqParam) do
		countParam = countParam + 1
		isThisValid = isThisValid and param~=nil and (type(param) == "number")
	end
	local optParam = {...}
	if not isThisValid or (#optParam > 1 or #reqParam ~= 14 ) or (countParam ~= 14) then
		return false 
	end
	if (type(optParam[1]) ~= "boolean") then
		optParam[1] = true
	end
	local normalShadow =  optParam[1]
	local SHPelementID = funcTable.create(2,posX,posY,posZ,colorR*colorA,colorG*colorA,colorB*colorA,colorA,dirX,dirY,dirZ,isEuler,falloff,theta,phi,attenuation,normalShadow)
	return createElement("SHPixelLight",tostring(SHPelementID))
end

function destroyLight(w)
	if not isElement(w) then 
		return false
	end
	local SHPelementID = tonumber(getElementID(w))
	if type(SHPelementID) == "number" then
		return destroyElement(w) and funcTable.destroy(SHPelementID)
	else
		return false
	end
end

function setLightDirection(w,dirX,dirY,dirZ,...)
	if not isElement(w) then 
		return false
	end
	local SHPelementID = tonumber(getElementID(w))
	local reqParam = {SHPelementID,dirX,dirY,dirZ}
	local isThisValid = true
	local countParam = 0
	for m, param in ipairs(reqParam) do
		countParam = countParam + 1
		isThisValid = isThisValid and param and (type(param) == "number")
	end
	if lightTable.inputLights[SHPelementID] and isThisValid then
		local optParam = {...}
		if (lightTable.inputLights[SHPelementID].lType == 2) and (#optParam <= 1) and (countParam == 4) then
			if optParam[1]==true then 
				local eul2vecX,eul2vecY,eul2vecZ = getVectorFromEuler(dirX,dirY,dirZ) 
				lightTable.inputLights[SHPelementID].dir = {eul2vecX,eul2vecY,eul2vecZ}
			else
				lightTable.inputLights[SHPelementID].dir = {dirX,dirY,dirZ}
			end
			lightTable.isInValChanged = true
			return true
		else
			return false
		end
	else
		return false
	end
end

function setLightPosition(w,posX,posY,posZ)
	if not isElement(w) then 
		return false
	end
	local SHPelementID = tonumber(getElementID(w))
	local reqParam = {SHPelementID,posX,posY,posZ}
	local isThisValid = true
	local countParam = 0
	for m, param in ipairs(reqParam) do
		countParam = countParam + 1
		isThisValid = isThisValid and param and (type(param) == "number")
	end
	if lightTable.inputLights[SHPelementID] and isThisValid  and (countParam == 4) then
		lightTable.inputLights[SHPelementID].pos = {posX,posY,posZ}
		lightTable.isInValChanged = true
		return true
	else
		return false
	end
end

function setLightColor(w,colorR,colorG,colorB,colorA)
	if not isElement(w) then 
		return false
	end
	local SHPelementID = tonumber(getElementID(w))
	local reqParam = {SHPelementID,colorR,colorG,colorB,colorA}
	local isThisValid = true
	local countParam = 0
	for m, param in ipairs(reqParam) do
		countParam = countParam + 1
		isThisValid = isThisValid and param and (type(param) == "number")
	end
	if lightTable.inputLights[SHPelementID] and isThisValid  and (countParam == 5)  then
		lightTable.inputLights[SHPelementID].color = {colorR*colorA,colorG*colorA,colorB*colorA,colorA}
		lightTable.isInValChanged = true
		return true
	else
		return false
	end
end

function setLightAttenuation(w,attenuation)
	if not isElement(w) then 
		return false
	end
	local SHPelementID = tonumber(getElementID(w))
	if lightTable.inputLights[SHPelementID] and (type(attenuation) == "number") then 
		lightTable.inputLights[SHPelementID].attenuation = attenuation
		lightTable.isInValChanged = true
		return true
	else
		return false
	end
end

function setLightNormalShading(w,normalShadow)
	if not isElement(w) then 
		return false
	end
	local SHPelementID = tonumber(getElementID(w))
	if lightTable.inputLights[SHPelementID] and (type(normalShadow) == "boolean") then
		lightTable.inputLights[SHPelementID].normalShadow = normalShadow
		lightTable.isInValChanged = true
		return true
	else
		return false
	end
end

function setLightFalloff(w,falloff)
	if not isElement(w) then 
		return false
	end
	local SHPelementID = tonumber(getElementID(w))
	if lightTable.inputLights[SHPelementID] and type(falloff) == "number" then	
		if (lightTable.inputLights[SHPelementID].lType == 2) then	
			lightTable.inputLights[SHPelementID].falloff = falloff
			lightTable.isInValChanged = true
			return true
		else
			return false
		end
	else
		return false
	end
end

function setLightTheta(w,theta)
	if not isElement(w) then 
		return false
	end
	local SHPelementID = tonumber(getElementID(w))
	if lightTable.inputLights[SHPelementID] and (type(theta) == "number") then 
		if (lightTable.inputLights[SHPelementID].lType == 2) then 
			lightTable.inputLights[SHPelementID].theta = theta
			lightTable.isInValChanged = true
			return true
		else
			return false
		end
	else
		return false
	end
end

function setLightPhi(w,phi)
	local SHPelementID = tonumber(getElementID(w))
	if lightTable.inputLights[SHPelementID] and (type(phi) == "number") then 
		if (lightTable.inputLights[SHPelementID].lType == 2) then 
			lightTable.inputLights[SHPelementID].phi = phi
			lightTable.isInValChanged = true
			return true
		else
			return false
		end
	else
		return false
	end
end	

function setMaxLights(maxLights)
	if (type(maxLights) == "number") then
		if ( maxLights >= 0 and maxLights <= 15 ) then
			return funcTable.setMaxLights(maxLights)
		else
			return false
		end
	else
		return false
	end
end

function setWorldNormalShading(isTrue)
	if (type(isTrue) == "boolean") then
		return funcTable.setWorldNormalShading(isTrue)
	else
		return false
	end
end

function setNormalShadingAmount(value)
	if (type(value) == "number") then
		return funcTable.setNormalShadingAmount(value)
	else
		return false
	end
end

function setGenerateBumpNormals(isGenerated,...)
	if (type(isGenerated) == "boolean") then
		local optParam = {...}
		if (#optParam > 3) then
			return false 
		end		
		local isThisValid = true
		if (#optParam > 0) then
			for m, param in ipairs(optParam) do
				isThisValid = isThisValid and param and (type(param) == "number")
			end
		end
		if not isThisValid then
			return false
		end
		texSize = optParam[1] or 512
		stX = optParam[2] or 1
		stY = optParam[3] or 1
		return funcTable.generateBumpNormals(isGenerated,texSize,stX,stY)
	else
		return false
	end
end

function setTextureBrightness(value)
	if (type(value) == "number") then
		return funcTable.setTextureBrightness(value)
	else
		return false
	end
end

function setLightsDistFade(dist1,dist2)
	if (type(dist1) == "number") and (type(dist2) == "number") then
		return funcTable.setDistFade(dist1,dist2)
	else
		return false
	end
end

function setLightsEffectRange(value)
	if type(value) == "number" then
		return funcTable.setEffectRange(value)
	else
		return false
	end
end

function setShaderForcedOn(value)
	if (type(value) == "boolean") then
		return funcTable.setShadersForcedOn(value)
	else
		return false
	end
end

function setShaderTimeOut(value)
	if (type(value) == "number") then
		return funcTable.setShadersTimeOut(value)
	else
		return false
	end
end

function setShaderNightMod(nMod)
	if (type(nMod) == "boolean") then
		return funcTable.setShaderNightMod(nMod)
	else
		return false
	end
end	

function setShaderPedDiffuse(nDif)
	if (type(nDif) == "boolean") then
		return funcTable.setShaderPedDiffuse(nDif)
	else
		return false
	end
end	

function setShaderDayTime(nMod)
	if (type(nMod) == "number") then
		return funcTable.setShaderDayTime(nMod)
	else
		return false
	end
end

function setDirLightEnable(isEnabled)
	if (type(isEnabled) == "boolean") then
		return funcTable.setDirLightEnable(isEnabled)
	else
		return false
	end
end

function setDirLightColor(colorR,colorG,colorB,colorA)
	local reqParam = {colorR,colorG,colorB,colorA}
	local isThisValid = true
	local countParam = 0
	for m, param in ipairs(reqParam) do
		countParam = countParam + 1
		isThisValid = isThisValid and param and (type(param) == "number")
	end
	if isThisValid  and (countParam == 4)  then
		funcTable.setDirLightColor(colorR*colorA,colorG*colorA,colorB*colorA,colorA)		
		return true
	else
		return false
	end
end

function setDirLightDirection(dirX,dirY,dirZ,...)
	local reqParam = {dirX,dirY,dirZ}
	local isThisValid = true
	local countParam = 0
	for m, param in ipairs(reqParam) do
		countParam = countParam + 1
		isThisValid = isThisValid and param and (type(param) == "number")
	end
	if isThisValid then
		local optParam = {...}
		if (#optParam <= 1) and (countParam == 3) then
			if optParam[1]==true then
				funcTable.setDirLightDirection(dirX,dirY,dirZ, true)
			else
				funcTable.setDirLightDirection(dirX,dirY,dirZ, false)
			end
			return true
		else
			return false
		end
	else
		return false
	end
end
