--NIX
function toggleEislaufClient(toggle)
	if toggle == true then
		addEventHandler ( "onClientPreRender", getRootElement(), drawEislauf)
	else
		removeEventHandler ( "onClientPreRender", getRootElement(), drawEislauf)
		setCameraTarget ( getLocalPlayer() )
	end
end

function drawEislauf()
	local x,y,z = getElementPosition(getLocalPlayer())
	setCameraMatrix(x, 2341.23828125, 18.125570297241, x, y, z)
end