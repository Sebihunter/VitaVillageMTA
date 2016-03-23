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
local gui = {}
local Anim = {}
local showit = 0

-- Edit able
Anim.Key = "." -- Key to open animation GUI.
Anim.Table =
{
	{name="Hands-up", group="ped", order="handsup", command="hsup", loop="false"},
	{name="Dance 1", group="DANCING", order="dance_loop", command="dance1", loop="true"},
	{name="Dance 2", group="DANCING", order="dan_down_A", command="dance2", loop="true"},
	{name="Dance 3", group="DANCING", order="dan_left_A", command="dance3", loop="true"},
	{name="Dance 4", group="DANCING", order="dnce_M_d", command="dance4", loop="true"},
	{name="WOHA", group="casino", order="manwind", command="win", loop="false"},
	{name="Wank", group="PAULNMAC", order="wank_loop", command="wank", loop="true"},
	{name="Cry", group="GRAVEYARD", order="mrnF_loop", command="cry", loop="true"},
	{name="Scream", group="STRIP", order="PUN_HOLLER", command="scream", loop="true"},
	{name="Fix", group="CAR", order="Fixn_Car_Loop", command="fix", loop="true"},
	{name="Carphone", group="CAR", order="carfone_loopA", command="carphone", loop="true"},
	{name="Wait", group="BEACH", order="SitnWait_loop_W", command="wait", loop="true"},
	{name="Crack", group="CRACK", order="crckdeth2", command="crack", loop="true"},
	{name="Laugh", group="RAPPING", order="Laugh_01", command="laugh", loop="true"},
	{name="Wave", group="ON_LOOKERS", order="wave_loop", command="wave", loop="true"},
	{name="Drunk", group="PED", order="WALK_drunk", command="drunk", loop="true"},
	{name="Dead", group="WUZI", order="CS_Dead_Guy", command="dead", loop="false"},
	{name="Sit", group="BEACH", order="ParkSit_M_loop", command="sit", loop="false"},
	{name="Lay", group="BEACH", order="Lay_Bac_Loop", command="lay", loop="false"},
	{name="Dance", group="DANCING", order="dnce_M_b", command="dance", loop="true"},
	{name="Chairsit 1", group="INT_OFFICE", order="OFF_Sit_In", command="sit1", loop="false"},
	{name="Chairsit 2", group="HAIRCUTS", order="BRB_Sit_In", command="sit2", loop="false"},
}


--[[
	Events
]]

addEventHandler("onClientResourceStart", resourceRoot,
	function()
		gui[1] = guiCreateGridList(0.8, 1.5, 0.2, 0.3, true)
		gui[2] = guiCreateButton(0.8, 1, 0.2, 0.05, "Animation Beenden (oder Leertaste)", true)
		guiGridListSetSelectionMode(gui[1], 1)
		guiGridListAddColumn(gui[1], "Animation", 0.45)
		guiGridListAddColumn(gui[1], "Command", 0.45)
	
		for _, anis in pairs(Anim.Table) do
			local row = guiGridListAddRow(gui[1])
			guiGridListSetItemText(gui[1], row, 1, anis.name, false, false)
			guiGridListSetItemText(gui[1], row, 2, "/a"..anis.command, false, false)
			addCommandHandler("a"..anis.command, Anim.CommandHandler)
		end

		addEventHandler("onClientGUIDoubleClick", gui[1], Anim.SelectAnimHandler, false)
		addEventHandler("onClientGUIClick", gui[2], Anim.StopAnimHandler, false)
		bindKey(Anim.Key, "both", Anim.KeyHandler)
	end
)

addEventHandler("onClientRender", root,
	function()
		if showit == 1 and getElementData(player, "einsperrzeit") == 0 then
			if not getElementData(getLocalPlayer(), "isPlayerLoggedIn") == true then return end
	
			if isPedInVehicle(getLocalPlayer()) then showit = 0 else
				local x, y = guiGetPosition(gui[2], true)
				if y >= 0.66 then
					guiSetPosition(gui[2], x, y-0.01, true)
					guiSetPosition(gui[1], x,(y+0.05)-0.01, true)
					showCursor(true)
				end
			end
		else 
			local x, y = guiGetPosition(gui[2], true)
			if y > 0 and y < 1 then
				guiSetPosition(gui[2], x, y+0.01, true)
				guiSetPosition(gui[1], x, (y+0.05)+0.01, true)
				showCursor(false)
			end
		end
	end
)

--[[
	Functions
]]
function Anim.KeyHandler(key, keystate)
	if keystate == "down" then
		showit = 1
	elseif keystate == "up" then
		showit = 0
	end
end

function Anim.CommandHandler(cmd)
	for i = 1, #Anim.Table do
		if Anim.Table[i].command == cmd then
			triggerServerEvent("startThePlayersAnimation", getLocalPlayer(), getLocalPlayer(), Anim.Table[i].group, Anim.Table[i].order, Anim.Table[i].loop)
			break
		end
	end
end

function Anim.SelectAnimHandler()
	local theselecteditem = guiGridListGetSelectedItem(gui[1])
	if theselecteditem ~= -1 then
		local daorder = theselecteditem+1
		triggerServerEvent("startThePlayersAnimation", getLocalPlayer(), getLocalPlayer(), Anim.Table[daorder].group, Anim.Table[daorder].order, Anim.Table[daorder].loop)
	end
end

function Anim.StopAnimHandler()
	triggerServerEvent("startThePlayersAnimation", getLocalPlayer(), getLocalPlayer(), "anistop")
end