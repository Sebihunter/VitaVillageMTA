
local testsound

function trainHorn(key, keyState)
	if keyState == "down" then
		if isPedInVehicle(getLocalPlayer()) then
			if getElementModel(getPedOccupiedVehicle(getLocalPlayer())) == 538 then
				--testsound = playSound ( "sounds/horn.mp3", true )
				local x,y,z = getElementPosition(getLocalPlayer())
				testsound = playSound3D ( "sounds/horn.mp3", x, y, z, true)
				setSoundVolume(testsound, 0.5)
				setSoundMinDistance ( testsound, 80 )
			end
		end
	else
		if isPedInVehicle(getLocalPlayer()) then
			if getElementModel(getPedOccupiedVehicle(getLocalPlayer())) == 538 then
				stopSound ( testsound)
			end
		end
	end
end
bindKey( "h", "both", trainHorn)