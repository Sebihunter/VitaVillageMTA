----------------------------------------------
--Resource: dynamic_lighting_headlights     --
--Author: Ren712                            --
--Contact: knoblauch700@o2.pl               --
----------------------------------------------

---------------------------------------------------------------------------------------------------
-- editable variables
---------------------------------------------------------------------------------------------------

local flashLiTable = { leftEN ={}, rightEN ={}, left={},right={}, color ={} }

local gWorldSelfShadow = false -- enables object self shadowing ( may be bugged for rotated objects on a custom map)
local gLightTheta = math.rad(6) -- Theta is the inner cone angle
local gLightPhi = math.rad(18) -- Phi is the outer cone angle
local gLightFalloff = 1.5 -- light intensity attenuation between the phi and theta areas
local flTimerUpdate = 200 -- the effect update time interval 

function getPositionFromElementOffset(element,offX,offY,offZ)
	local m = getElementMatrix ( element )  -- Get the matrix
	local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]  -- Apply transform
	local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
	local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
	return x, y, z                               -- Return the transformed point
end

addEventHandler("onClientPreRender", root, function()
	for index,this in ipairs(getElementsByType("vehicle")) do
		if flashLiTable.leftEN[this] or flashLiTable.rightEN[this] then
			local rx, ry, rz = getElementRotation(this, "ZXY")
			rx = rx - 4
			local x1,y1,z1 = getPositionFromElementOffset(this,-0.7,0.8,-0.1) -- (left,front,above)
			local x2,y2,z2 = getPositionFromElementOffset(this,0.7,0.8,-0.1) -- (left,front,above)
			local col = flashLiTable.color[this]
			if flashLiTable.leftEN[this] then
				exports.shader_lightning:setLightDirection(flashLiTable.left[this],rx,ry,rz,true)
				exports.shader_lightning:setLightPosition(flashLiTable.left[this],x1,y1,z1)
				exports.shader_lightning:setLightColor(flashLiTable.left[this],col[1],col[2],col[3],1) 
			end
			if flashLiTable.rightEN[this] then
				exports.shader_lightning:setLightDirection(flashLiTable.right[this],rx,ry,rz,true)
				exports.shader_lightning:setLightPosition(flashLiTable.right[this],x2,y2,z2)
				exports.shader_lightning:setLightColor(flashLiTable.right[this],col[1],col[2],col[3],1)  
			end
		end
	end
end
)

function createWorldLight()
	return exports.shader_lightning:createSpotLight(0,0,3,0,0,0,0,0,0,0,true,gLightFalloff,gLightTheta,gLightPhi,15,gWorldSelfShadow)
end

function destroyWorldLight(this)
	return exports.shader_lightning:destroyLight(this)
end

function isInNightTime()
    local hour, minutes = getTime()
   return (hour>=22 or hour<=5)
end

function lightEffectStop(thisVeh)
	if flashLiTable.leftEN[thisVeh] then
		destroyWorldLight(flashLiTable.left[thisVeh])
		flashLiTable.leftEN[thisVeh]=false
	end
	if flashLiTable.rightEN[thisVeh] then
		destroyWorldLight(flashLiTable.right[thisVeh])
		flashLiTable.rightEN[thisVeh]=false
	end
end

function lightEffectManage(thisVeh)
	if ((getVehicleLightState ( thisVeh, 0 )==1 or getVehicleOverrideLights(thisVeh)==1)) and flashLiTable.leftEN[thisVeh] then 
		destroyWorldLight(flashLiTable.left[thisVeh])
		flashLiTable.leftEN[thisVeh]=false		
	end

	if ((getVehicleLightState ( thisVeh, 1 )==1 or getVehicleOverrideLights(thisVeh)==1)) and flashLiTable.rightEN[thisVeh] then 
		destroyWorldLight(flashLiTable.right[thisVeh])
		flashLiTable.rightEN[thisVeh]=false	
	end	
	
	if getVehicleEngineState(thisVeh) then
		if (getVehicleLightState ( thisVeh, 0 )==0 and getVehicleOverrideLights(thisVeh)==0) then 
			if isInNightTime() then
				if flashLiTable.leftEN[thisVeh]~=true and getVehicleOccupant( thisVeh ,0 ) then
					flashLiTable.left[thisVeh] = createWorldLight()
					flashLiTable.leftEN[thisVeh]=true
				end
			else
				if flashLiTable.leftEN[thisVeh]==true then
					destroyWorldLight(flashLiTable.left[thisVeh])
					flashLiTable.leftEN[thisVeh]=false
				end
			end
		end
	
		if (getVehicleLightState ( thisVeh, 1 )==0 and getVehicleOverrideLights(thisVeh)==0) then
			if isInNightTime() then 
				if flashLiTable.rightEN[thisVeh]~=true and getVehicleOccupant( thisVeh ,0 ) then
					flashLiTable.right[thisVeh] = createWorldLight()
					flashLiTable.rightEN[thisVeh]=true
				end
			else
				if flashLiTable.rightEN[thisVeh]==true then
					destroyWorldLight(flashLiTable.right[thisVeh])
					flashLiTable.rightEN[thisVeh]=false
				end
			end
		end
	end

	if (getVehicleLightState ( thisVeh, 0 )==0 and getVehicleOverrideLights(thisVeh)==2) and flashLiTable.leftEN[thisVeh]~=true then 
		flashLiTable.left[thisVeh] = createWorldLight()
		flashLiTable.leftEN[thisVeh]=true
	end
	
	if (getVehicleLightState ( thisVeh, 1 )==0 and getVehicleOverrideLights(thisVeh)==2) and flashLiTable.rightEN[thisVeh]~=true then
		flashLiTable.right[thisVeh] = createWorldLight()
		flashLiTable.rightEN[thisVeh]=true		
	end

	if flashLiTable.rightEN[thisVeh] or flashLiTable.leftEN[thisVeh] then
		local r,g,b = getVehicleHeadLightColor(thisVeh)
		flashLiTable.color[thisVeh] = {r/255,g/255,b/255}
	end
end

local dirtShader = dxCreateShader("fx/texture.fx")
local datDirt = {}
addEventHandler( "onClientElementStreamIn", getRootElement( ),
    function ( )
        if getElementType( source ) == "vehicle" then
			if datDirt[source] then return end
			datDirt[source] = true
            --engineApplyShaderToWorldTexture(dirtShader, "vehiclegrunge256", source )
			--engineApplyShaderToWorldTexture(dirtShader, "?emap*", source )	
        end
    end
);

addEventHandler("onClientResourceStart", getResourceRootElement( getThisResource()), function()
	if FLenTimer then return end
	FLenTimer = setTimer(	function()
		for index,thisVeh in ipairs(getElementsByType("vehicle")) do
			if isElementStreamedIn(thisVeh) and (getVehicleType(thisVeh) == "Automobile") and getElementData(thisVeh, "fernlicht") == true then
				lightEffectManage(thisVeh)
			elseif not (isElementStreamedIn(thisVeh) and (getVehicleType(thisVeh) == "Automobile")) or ((getVehicleType(thisVeh) == "Automobile") and getElementData(thisVeh, "fernlicht") == false) then
				lightEffectStop(thisVeh)
			end
		end
	end
	,flTimerUpdate,0 )
end
)

addEventHandler("onClientElementDestroy", getRootElement(), function ()
	if getElementType(source) == "vehicle"  then
		if (getVehicleType(source) == "Automobile") then
			lightEffectStop(source)
		end
	end
end)

addEventHandler("onClientResourceStop", getResourceRootElement( getThisResource()), function()
	for index,thisVeh in ipairs(getElementsByType("vehicle")) do
		if (getVehicleType(thisVeh) == "Automobile") then
			lightEffectStop(thisVeh)
		end
	end
end
)
