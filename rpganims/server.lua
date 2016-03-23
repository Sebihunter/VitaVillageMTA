--[[
	-----------------------------------------------------
		Project: RP Animation system.
		Version: 08-03-2010
		Devs:    Sebas, Golf
		Info:
			- System by Golf_r32
	-----------------------------------------------------
]]

local root = getRootElement()
local resourceRoot = getResourceRootElement()
local Anim = {}

--[[
	Events
]]
addEvent("startThePlayersAnimation", true)

function Anim.EventHandler(player, groups, orders, loops)
	if groups == "anistop" or groups == "space" then
		setPedAnimation(player, false)
		unbindKey(player, "space", "down")
	else
		if isPedInVehicle(player) then return end
		if getElementData(player, "einsperrzeit") ~= 0 then return end

		if loops == "true" then
			setPedAnimation(player, groups, orders, -1, true, true, true)
		elseif loops == "false" then
			setPedAnimation(player, groups, orders, -1, false, true, true)
		end
	end
	if not isKeyBound(player, "space") then
		bindKey(player, "space", "down", Anim.EventHandler, "anistop")
	end
end
addEventHandler("startThePlayersAnimation", root, Anim.EventHandler)

--[[
	Commands
]]
addCommandHandler("stop",
	function(player)
		Anim.EventHandler(player, "anistop")
	end
)

