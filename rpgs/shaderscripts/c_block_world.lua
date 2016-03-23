--
-- c_block_world.lua
--

local shaderList = {}
local colorizeOff = false

function startBlockShader()
	if #shaderList > 0 then return end
	-- Create shader to test for any errors
	local testShader, tec = dxCreateShader ( "fx/block_world.fx" )

	if testShader then
		destroyElement(testShader)
		-- Create 26 shaders and apply each one to some world textures
		for c=65,96 do
			local clone = dxCreateShader ( "fx/block_world.fx" )
			engineApplyShaderToWorldTexture ( clone, string.format( "%c*", c + 32 )  )
			engineRemoveShaderFromWorldTexture ( clone, "tx*" )	-- Skip doing the grass
			shaderList[#shaderList+1] = clone
			r,g,b = math.random(0.25,1.25),math.random(0.25,1.25),math.random(0.25,1.25)
			dxSetShaderValue ( clone, "COLORIZE", r,g,b )
		end
	end
end

function stopBlockShader()
	if #shaderList > 0 then
		for i,v in ipairs(shaderList) do
			destroyElement(v)
		end
		shaderList = {}
	end
end
