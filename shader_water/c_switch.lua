--
-- c_switch.lua
--

----------------------------------------------------------------
----------------------------------------------------------------
-- Effect switching on and off
--
--	To switch on:
--			triggerEvent( "switchWaterShine", root, true )
--
--	To switch off:
--			triggerEvent( "switchWaterShine", root, false )
--
----------------------------------------------------------------
----------------------------------------------------------------

--------------------------------
-- onClientResourceStart
--		Auto switch on at start
--------------------------------
addEventHandler( "onClientResourceStart", getResourceRootElement( getThisResource()),
	function()
		outputDebugString('/sWaterShine to switch the effect')
		triggerEvent( "switchWaterShine", resourceRoot, true )
		addCommandHandler( "sWaterShine",
			function()
				triggerEvent( "switchWaterShine", resourceRoot, not wsEffectEnabled )
			end
		)
	end
)


--------------------------------
-- Switch effect on or off
--------------------------------
function switchWaterShine( wsOn )
	outputDebugString( "switchWaterShine: " .. tostring(wsOn) )
	if wsOn then
		startWaterShine()
	else
		stopWaterShine()
	end
end

addEvent( "switchWaterShine", true )
addEventHandler( "switchWaterShine", resourceRoot, switchWaterShine )
