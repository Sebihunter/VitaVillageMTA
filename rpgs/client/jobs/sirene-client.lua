gMegaphone = {}
gMegaphoneSoundFiles = { "anhalten.mp3", "seite1.mp3", "seite2.mp3" }
gSiren = {}
gSirenSoundFiles = { "sirene_land.mp3", "sirene_stadt.mp3", "sani1.mp3", "sani2.mp3", "feuer1.wav", "feuer2.wav", "autofix.mp3" }
gSirenSoundLengths = { 1447, 1420, 1520, 1520  } -- 1489 1550

addEvent("doMegaphone", true)
addEventHandler("doMegaphone", root, function (vehicle, megaphoneType)
	if gMegaphone[vehicle] and isElement(gMegaphone[vehicle]) then return end
	local x,y,z = getElementPosition(vehicle)
	gMegaphone[vehicle] = playSound3D ( "sounds/"..gMegaphoneSoundFiles[megaphoneType], x,y,z, falsef	)
	setSoundMinDistance ( gMegaphone[vehicle] ,30 )
	setSoundMaxDistance ( gMegaphone[vehicle], 100 )
	attachElements ( gMegaphone[vehicle] , vehicle )
end)

addEvent("toggleSiren", true)
addEventHandler("toggleSiren", root, function (vehicle, sirenType)
	if gSiren[vehicle] then
		if isElement(gSiren[vehicle]) then stopSound(gSiren[vehicle]) end
		gSiren[vehicle] = nil
		gSiren[vehicle] = nil
		if getVehicleOccupant(vehicle) == getLocalPlayer() then
			setElementData(vehicle, "siren", false)
		end
	else
		local x,y,z = getElementPosition(vehicle)
		gSiren[vehicle] = playSound3D ( "sounds/"..gSirenSoundFiles[sirenType], x,y,z, true	)
		setSoundMinDistance ( gSiren[vehicle] ,30 )
		setSoundMaxDistance ( gSiren[vehicle], 100 )
		attachElements ( gSiren[vehicle] , vehicle )
		if getVehicleOccupant(vehicle) == getLocalPlayer() then
			setElementData(vehicle, "siren", sirenType)
		end
	end
end)

function playSoundAttachedToElement(element, soundFile)
	local x, y, z = getElementPosition(element)
	local distance = getDistanceBetweenPoints3D(x, y, z, getElementPosition(getLocalPlayer()))
	if getDistanceBetweenPoints3D(x, y, z, getElementPosition(getLocalPlayer())) <= 100 then
		gSiren[element].sound = playSound(soundFile)
	
	end
end

function playSoundAttachedToElementMegaphone(element, soundFile)
	local x, y, z = getElementPosition(element)
	local distance = getDistanceBetweenPoints3D(x, y, z, getElementPosition(getLocalPlayer()))
	if getDistanceBetweenPoints3D(x, y, z, getElementPosition(getLocalPlayer())) <= 100 then
		gMegaphone[element] = playSound(soundFile)
		if gMegaphone[element] and isElement(gMegaphone[element]) then setSoundVolume(gMegaphone[element], 1 - distance / 100) end
	end
end