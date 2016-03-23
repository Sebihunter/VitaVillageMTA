addEvent("phoneRing", true)
addEventHandler("phoneRing", root,
	function()
		if source ~= getLocalPlayer() then
			local x, y, z = getElementPosition(source)
			local sound = playSound3D("sounds/telefon.mp3", x, y, z)
			attachElements(sound, source)
		else
			showTutorialMessage("handy_1", "Dein Telefon läutet zum ersten Mal. Du kannst das Gespräch mit /entgegennehmen beginnen.")
			playSound("sounds/telefon.mp3", false)
		end
	end
)