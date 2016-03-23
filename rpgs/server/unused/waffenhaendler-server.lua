--[[
Project: VitaOnline
File: waffenhaendler-server.lua
Author(s):	MrX
]]--

local haendler = {}
local haendlerPositions = {}

function updateHaendlerPositions()
	local x, y, z, rz
	for k, v in pairs(haendler) do
		x, y, z, rz = haendlerPositions[math.random(1, #haendlerPositions[k])]
		setElementPosition(v, x, y, z)
		setPedRotation(v, rz)
	end
end

function showHaendlerGUI(player)
	triggerClientEvent("onMarkerDoHit", player, test, 2)
end

addEventHandler("onResourceStart", getResourceRootElement(), 
	function()
		--[[
		haendler[#haendler+1] = createInvinciblePed()
		haendler[#haendler+1] = createInvinciblePed()
		haendler[#haendler+1] = createInvinciblePed()
		]]
		-- 
		for k, v in pairs(haendler) do
			createClickableElement(v, showHaendlerGUI)
		end
	end
)
		