--[[
Project: VitaRP
File: login-client.lua
Author(s):	Sebihunter
]]--


lp = getLocalPlayer()

--[[ Funktion: 
	GUI 'Auswahlfenster' wird erzeugt und direkt wieder unsichtbar.
]]--
addEventHandler("onClientResourceStart", resourceRoot,
    function()
		setElementData(getLocalPlayer(), "isPlayerLoggedIn", false)
		guiSetInputEnabled(false)
		clickableLogin = clickableAreaCreate(screenWidth/2-352,screenHeight/2+13,335,158,false)
		clickableRegister = clickableAreaCreate(screenWidth/2+17,screenHeight/2+13,335,158,false)
		
		vitaBackgroundToggle(true)
		--showCursor(true)
		fadeCamera(true, 2)
		setCameraMatrix(1468.8785400391, -919.25317382813, 100.153465271, 1468.388671875, -918.42474365234, 99.881813049316)
		setElementInterior(lp, 0)
		setElementDimension(lp, 0)
		showPlayerHudComponent ( "radar", false )
		showPlayerHudComponent ( "ammo", false )
		showPlayerHudComponent ( "weapon", false )
		showPlayerHudComponent ( "breath", false )
		showPlayerHudComponent ( "clock", false )		
		showPlayerHudComponent ( "health", false )	
		showPlayerHudComponent ( "armour", false )
		showPlayerHudComponent ( "money", false )
		showPlayerHudComponent ( "area_name", false )
		
		showChat(false)
		addEventHandler ( "onClientRender", getRootElement(), renderInitialLogin )
		
		
		addEventHandler("onClickableAreaClick", clickableLogin, 
			function()
				playSound("sounds/click.mp3")
				removeEventHandler ( "onClientRender", getRootElement(), renderInitialLogin )		
				addEventHandler("onClientRender", getRootElement(), renderRealLogin)
				destroyElement(clickableLogin)
				destroyElement(clickableRegister)
				destroyElement(register_tabpanel)
				guiSetVisible(login_firstNameEdit, true)
				guiSetVisible(login_lastNameEdit, true)
				guiSetVisible(login_passwordEdit, true)		
				dxSetVisible(login_loginButton, true)
				guiSetVisible(login_checkboxSave, true)
				showCursor(true)	
			end, false)
			
		addEventHandler("onClickableAreaClick", clickableRegister, 
			function()
				if getElementData(lp, "isAlreadyRegistered") == true then return end
				playSound("sounds/click.mp3")
				vitaBackgroundToggle(false)
				
				fadeCamera(false, 1)
				
				destroyElement(clickableLogin)
				destroyElement(clickableRegister)				
				removeEventHandler ( "onClientRender", getRootElement(), renderInitialLogin )
				showCursor(false)
				setTimer(startSkinSelection, 1000, 1)
			end, false)
    end
)

--gets called from rpgmods
function startVitaLogin()
	showCursor(true)
end
addEvent("startVitaLogin", true)
addEventHandler("startVitaLogin", resourceRoot, startVitaLogin)

function renderRealLogin()
	if fileExists("images/login/login2.png") then
		dxDrawImage (screenWidth/2-256, screenHeight/2-128, 512, 256, "images/login/login2.png")
	end
	dxDrawShadowedText("Du kannst dich nun mit deinem Vor- /Nachnamen einloggen.",screenWidth/2-475/2+15,screenHeight/2-185/2+50, screenWidth, screenHeight, tocolor(255,255,255,255),tocolor(0,0,0,255), 1,"default-bold", "left", "top", false, false, false, true)	
	dxDrawShadowedText("Vorname:",screenWidth/2-475/2+15,screenHeight/2-185/2+77, screenWidth, screenHeight, tocolor(255,255,255,255),tocolor(0,0,0,255), 1,"default-bold", "left", "top", false, false, false, true)	
	dxDrawShadowedText("Nachname:",screenWidth/2-475/2+15,screenHeight/2-185/2+117, screenWidth, screenHeight, tocolor(255,255,255,255),tocolor(0,0,0,255), 1,"default-bold", "left", "top", false, false, false, true)
	dxDrawShadowedText("Passwort:",screenWidth/2-475/2+240,screenHeight/2-185/2+77, screenWidth, screenHeight, tocolor(255,255,255,255),tocolor(0,0,0,255), 1,"default-bold", "left", "top", false, false, false, true)	
	dxDrawShadowedText("Daten speichern?",screenWidth/2-475/2+35,screenHeight/2-185/2+148, screenWidth, screenHeight, tocolor(255,255,255,255),tocolor(0,0,0,255), 1,"default-bold", "left", "top", false, false, false, true)
end

local selectedLogin = false
function renderInitialLogin ()
	local oldSelected = selectedLogin
	if clickableAreaIsHovering(clickableLogin) then
		if getElementData(lp, "isAlreadyRegistered") then 
			if fileExists("images/login/login_loginonlylogin.png") then
				dxDrawImage (screenWidth/2-512, screenHeight/2-256, 1024, 512, "images/login/login_loginonlylogin.png")
			end
		else
			if fileExists("images/login/login_login.png") then 
				dxDrawImage (screenWidth/2-512, screenHeight/2-256, 1024, 512, "images/login/login_login.png")
			end
		end
		selectedLogin = clickableLogin
	elseif clickableAreaIsHovering(clickableRegister) and getElementData(lp, "isAlreadyRegistered") == false then
		selectedLogin = clickableRegister
			if fileExists("images/login/login_register.png") then 
			dxDrawImage (screenWidth/2-512, screenHeight/2-256, 1024, 512, "images/login/login_register.png")
		end
	else
		selectedLogin = false
		if getElementData(lp, "isAlreadyRegistered") == true then
			if fileExists("images/login/login_onlylogin.png") then
				dxDrawImage (screenWidth/2-512, screenHeight/2-256, 1024, 512, "images/login/login_onlylogin.png")
			end
		else
			if fileExists("images/login/login_no.png") then
				dxDrawImage (screenWidth/2-512, screenHeight/2-256, 1024, 512, "images/login/login_no.png")
			end
		end
	end
	
	if selectedLogin ~= oldSelected and selectedLogin ~= false then
		playSound("sounds/hover.mp3")
	end
	
	if screenWidth < 1024 or screenHeight < 768 then
		dxDrawText("ACHTUNG: Deine Auflösung ist nicht vollkommen unterstützt.\nDein Spielerlebnis könnte benachteiligt sein.", 1, screenHeight-99, screenWidth, screenHeight, tocolor(0,0,0,100), 3, "default-bold", "center",  "top", false, false, true)
		dxDrawText("ACHTUNG: Deine Auflösung ist nicht vollkommen unterstützt.\nDein Spielerlebnis könnte benachteiligt sein.", 0, screenHeight-100, screenWidth, screenHeight, tocolor(255,0,0,255), 3, "default-bold", "center", "top", false, false, true)
	end
end

	
--[[Funktion:
	GUI 'Registrierung wird erzeugt und entsprechende zusätzliche Funktionen
]]--
currentTab = 0

addEventHandler("onClientResourceStart", resourceRoot,
    function()
		register_tabpanel = guiCreateTabPanel(638, 344, 539, 233, false)
       
		--
		register_StartTab = guiCreateTab("Anfang >>", register_tabpanel)
        --
		
		register_IntroductionTitleLabel = guiCreateLabel(10, 10, 64, 18, "Einleitung", false, register_StartTab)
			guiLabelSetColor(register_IntroductionTitleLabel, 0, 255, 0)
		register_intruductionInfoLabel = guiCreateLabel(10, 38, 519, 109, "Unter Verwendung der Datenschutzrichtlinien speichern wir bestimmte Daten, \nzur einzigen Verwendungen auf diesem Server, in unserer Datenbank, die zum \nSpielen auf diesem Server benötigt werden.\n\nPasswörter werden verschlüsselt gespeichert.\n\nKlicke auf den Button 'Fortfahren' und fahre mit der Registrierung fort!", false, register_StartTab)
		register_IntroductionForwardButton = guiCreateButton(10, 157, 114, 36, "Fortfahren", false, register_StartTab)
			guiSetProperty(register_IntroductionForwardButton, "NormalTextColour", "FFAAAAAA")
		
		--
		register_enterUserdataTab = guiCreateTab("Benutzerdaten eingeben >>", register_tabpanel)
        --
		
		register_enterUserdataTitleLabel = guiCreateLabel(10, 10, 186, 17, "Eingeben der Benutzerdaten", false, register_enterUserdataTab)
			guiLabelSetColor(register_enterUserdataTitleLabel, 0, 255, 0)
		register_enterUserdataErrorLabel = guiCreateLabel(200, 10, 220, 17, "", false, register_enterUserdataTab)
			guiLabelSetColor(register_enterUserdataErrorLabel, 200, 0, 0)
		register_enterUserdataFirstNameLabel = guiCreateLabel(10, 37, 64, 17, "Vorname:", false, register_enterUserdataTab)
		register_enterUserdataFirstNameEdit = guiCreateEdit(9, 59, 85, 25, "", false, register_enterUserdataTab)
			guiEditSetMaxLength(register_enterUserdataFirstNameEdit, 10)
		register_enterUserdataLastNameLabel = guiCreateLabel(104, 37, 73, 17, "Nachname:", false, register_enterUserdataTab)
		register_enterUserdataLastNameEdit = guiCreateEdit(101, 59, 76, 25, "", false, register_enterUserdataTab)
			guiEditSetMaxLength(register_enterUserdataLastNameEdit, 10)
		register_enterUserdataPasswordLabel = guiCreateLabel(186, 37, 101, 17, "Passwort:", false, register_enterUserdataTab)
		register_enterUserdataPasswordEdit = guiCreateEdit(186, 59, 125, 25, "", false, register_enterUserdataTab)
			guiEditSetMaxLength(register_enterUserdataPasswordEdit, 20)
			guiEditSetMasked(register_enterUserdataPasswordEdit, true)
		register_enterUserdataMail = guiCreateLabel(321, 37, 101, 17, "E-Mail Adresse:", false, register_enterUserdataTab)
		register_enterUserdataMailEdit = guiCreateEdit(321, 59, 125, 25, "", false, register_enterUserdataTab)
		register_enterUserdataBirthdayLabel = guiCreateLabel(10, 94, 101, 17, "Geburtsdatum:", false, register_enterUserdataTab)
		register_enterUserdataBirthdayDayEdit = guiCreateEdit(10, 121, 37, 25, "", false, register_enterUserdataTab)
			guiEditSetMaxLength(register_enterUserdataBirthdayDayEdit, 2)
		register_enterUserdataBirthdayMonthEdit = guiCreateEdit(57, 121, 37, 25, "", false, register_enterUserdataTab)
			guiEditSetMaxLength(register_enterUserdataBirthdayMonthEdit, 2)
		register_enterUserdataBirthdayYearEdit = guiCreateEdit(101, 121, 51, 25, "", false, register_enterUserdataTab)
			guiEditSetMaxLength(register_enterUserdataBirthdayYearEdit, 4)
		register_enterUserdataForwardButton = guiCreateButton(10, 161, 109, 37, "Fortfahren", false, register_enterUserdataTab)
			guiSetProperty(register_enterUserdataForwardButton, "NormalTextColour", "FFAAAAAA")
		register_enterUserdataIntroductionLabel = guiCreateLabel(171, 103, 358, 95, "Der Vorname, Nachname und das Geburtsdatum sind für \ndas Spiel gedacht. Denke dir einen Namen aus, aber\nnehme nicht deinen RL Namen. Bei dem Geburtsdatum\nist es nicht relevant, ist aber auch für das Spiel gedacht. \nAußerdem braucht du deinen Vornamen, Nachnamen \nund das Passwort um dich einzuloggen.", false, register_enterUserdataTab)
        
		--
		register_checkUserdataTab = guiCreateTab("Benutzerdaten überprüfen >>", register_tabpanel)
        --
		
		register_checkUserdataTitleLabel = guiCreateLabel(10, 10, 198, 17, "Überprüfen der Benutzerdaten", false, register_checkUserdataTab)
			guiLabelSetColor(register_checkUserdataTitleLabel, 0, 255, 0)
		register_checkUserdataFirstNameLabel = guiCreateLabel(10, 37, 65, 18, "Vorname:", false, register_checkUserdataTab)
		register_checkUserdataFirstNameEnterLabel = guiCreateLabel(10, 65, 126, 18, "", false, register_checkUserdataTab)
		register_checkUserdataLastNameLabel = guiCreateLabel(146, 37, 65, 18, "Name:", false, register_checkUserdataTab)
		register_checkUserdataLastNameEnterLabel = guiCreateLabel(146, 65, 126, 18, "", false, register_checkUserdataTab)
		register_checkUserdataBirthdayLabel = guiCreateLabel(282, 37, 99, 18, "Geburtsdatum:", false, register_checkUserdataTab)
		register_checkUserdataBirthdayEnterLabel = guiCreateLabel(282, 65, 126, 18, "", false, register_checkUserdataTab)
		register_checkUserdataBackwardsButton = guiCreateButton(6, 93, 116, 35, "Rückwärts", false, register_checkUserdataTab)
			guiSetProperty(register_checkUserdataBackwardsButton, "NormalTextColour", "FFAAAAAA")
		register_checkUserdataForwardButton = guiCreateButton(132, 93, 116, 35, "Fortfahren", false, register_checkUserdataTab)
			guiSetProperty(register_checkUserdataForwardButton, "NormalTextColour", "FFAAAAAA")
        
		--
		register_finishTab = guiCreateTab("Abschluss >>", register_tabpanel)
        --
		
		register_finishTitleLabel = guiCreateLabel(10, 10, 65, 16, "Abschluss", false, register_finishTab)
			guiLabelSetColor(register_finishTitleLabel, 0, 255, 0)
		register_finishIntroductionLabel = guiCreateLabel(10, 36, 359, 79, "Die Registrierung ist nun abgeschlossen.\n\nKlicke nun auf den Button 'Fertigstellen' und \ndie Registrierung ist damit vollständig abgeschlossen. \nViel Spaß!", false, register_finishTab)
		register_finishFinishButton = guiCreateButton(6, 128, 116, 36, "Fertigstellen", false, register_finishTab)
		register_checkUserdataBackwardsButton2 = guiCreateButton(132, 128, 116, 36, "Rückwärts", false, register_finishTab)
			guiSetProperty(register_checkUserdataBackwardsButton2, "NormalTextColour", "FFAAAAAA")		
			guiSetProperty(register_finishFinishButton, "NormalTextColour", "FFAAAAAA")
		
		--
		centerWindow(register_tabpanel)
		guiSetVisible(register_tabpanel, false)
		--
		
		local registerTabElements = {register_StartTab, register_enterUserdataTab, register_checkUserdataTab, register_finishTab}
			for _, element in ipairs(registerTabElements) do
				if element ~= register_StartTab then
					guiSetEnabled(element, false)
				end
			end
		
		local registerGUIElements = {register_IntroductionTitleLabel, register_intruductionInfoLabel, register_IntroductionForwardButton, register_enterUserdataTitleLabel, register_enterUserdataFirstNameLabel, register_enterUserdataPasswordLabel,
									register_enterUserdataMailEdit, register_enterUserdataBirthdayLabel, register_enterUserdataLastNameLabel, register_enterUserdataForwardButton, register_enterUserdataIntroductionLabel, register_checkUserdataTitleLabel,
									register_checkUserdataFirstNameLabel, register_checkUserdataFirstNameEnterLabel, register_checkUserdataLastNameLabel, register_checkUserdataLastNameEnterLabel, register_checkUserdataBirthdayLabel, register_checkUserdataBirthdayEnterLabel,
									register_checkUserdataBackwardsButton,register_checkUserdataBackwardsButton2, register_checkUserdataForwardButton, register_finishTitleLabel, register_finishIntroductionLabel, register_finishFinishButton, register_enterUserdataErrorLabel}
		
		for _, element in ipairs(registerGUIElements) do 
			guiSetFont(element, "clear-normal")
		end
		
		addEventHandler("onClientGUIClick", register_IntroductionForwardButton,
			function()
			-- Einführung - Fortfahren
				guiSetEnabled(register_enterUserdataTab, true)
				guiSetSelectedTab(register_tabpanel, register_enterUserdataTab)
				guiSetEnabled(register_StartTab, false)
				
				currentTab = 1
			end, false)
		
		addEventHandler("onClientGUIClick", register_enterUserdataForwardButton,
			function()
				-- Eingabe der Userdaten - Fortfahren
				registerFirstNameText = guiGetText(register_enterUserdataFirstNameEdit)
				registerLastNameText = guiGetText(register_enterUserdataLastNameEdit)
				registerPasswordText = guiGetText(register_enterUserdataPasswordEdit)
				registerMailText = guiGetText(register_enterUserdataMailEdit)
				registerBirthdayDayText = guiGetText(register_enterUserdataBirthdayDayEdit)
				registerBirthdayMonthText = guiGetText(register_enterUserdataBirthdayMonthEdit)
				registerBirthdayYearText = guiGetText(register_enterUserdataBirthdayYearEdit)
		
				if registerFirstNameText ~= "" and registerLastNameText ~= "" and registerPasswordText ~= "" and registerMailText ~= "" and registerBirthdayDayText ~= "" and registerBirthdayMonthText ~= "" and registerBirthdayYearText ~= "" then
					if tonumber(registerBirthdayDayText) <= 31 and tonumber(registerBirthdayMonthText) <= 12 and tonumber(registerBirthdayYearText) >= 1900 then
						if not string.find(registerMailText, '@') then return addNotification(1, 255, 0, 0, "Gib bitte eine richtige E-Mail Adresse an.") end
						guiSetEnabled(register_checkUserdataTab, true)
						guiSetSelectedTab(register_tabpanel, register_checkUserdataTab)
						guiSetEnabled(register_enterUserdataTab, false)
					
						guiSetText(register_checkUserdataFirstNameEnterLabel, registerFirstNameText)
						guiSetText(register_checkUserdataLastNameEnterLabel, registerLastNameText)
						guiSetText(register_checkUserdataBirthdayEnterLabel, registerBirthdayDayText.."."..registerBirthdayMonthText.."."..registerBirthdayYearText)
					else
						addNotification(1, 255, 0, 0, "Das Geburtsdatum ist im falschen Format.")
					end
				else
					addNotification(1, 255, 0, 0, "Es wurden nicht alle Felder ausgefüllt.")
				end
			end, false)
		

			addEventHandler("onClientGUIClick", register_checkUserdataForwardButton,
			function()
				-- Überprüfung der Userdaten - Fortfahren
				guiSetEnabled(register_finishTab, true)
				guiSetSelectedTab(register_tabpanel, register_finishTab)
				guiSetEnabled(register_checkUserdataTab, false)
			end, false)
				
		
		addEventHandler("onClientGUIClick", register_checkUserdataBackwardsButton, 
			function()
				-- Überprüfen der Userdaten - Rückwarts
				guiSetEnabled(register_enterUserdataTab, true)
				guiSetSelectedTab(register_tabpanel, register_enterUserdataTab)
				guiSetEnabled(register_checkUserdataTab, false)
				
				guiSetText(register_enterUserdataPasswordEdit, "")
			end, false)
		addEventHandler("onClientGUIClick", register_checkUserdataBackwardsButton2, 
			function()
				-- Überprüfen der Userdaten - Rückwarts
				guiSetEnabled(register_finishTab, false)
				guiSetSelectedTab(register_tabpanel, register_checkUserdataTab)
				guiSetEnabled(register_checkUserdataTab, true)
			end, false)			
		
		addEventHandler("onClientGUIClick", register_finishFinishButton,
			function()
				-- Abschluss - Fertigstellen
				triggerServerEvent("registerRPGPlayerToServer",getLocalPlayer(),registerFirstNameText, registerLastNameText,registerPasswordText,registrationGeschlecht,registrationSkinSelected, registerBirthdayDayText.."."..registerBirthdayMonthText.."."..registerBirthdayYearText, registerMailText)
			end, false)
		
		addEvent("registrationComplete", true)
		addEventHandler("registrationComplete", getRootElement(),
			function(thePlayer)
				destroyElement(register_tabpanel)
			end)
    end
)

addEventHandler("onClientResourceStart", resourceRoot,
    function()
		login_firstNameEdit = guiCreateEdit(screenWidth/2-475/2+83, screenHeight/2-185/2+72, 140, 26, "", false)
		login_lastNameEdit = guiCreateEdit(screenWidth/2-475/2+83, screenHeight/2-185/2+110, 140, 26, "", false)
		login_passwordEdit = guiCreateEdit(screenWidth/2-475/2+300,screenHeight/2-185/2+72, 140, 26, "", false)
		login_checkboxSave = guiCreateCheckBox ( screenWidth/2-475/2+15, screenHeight/2-185/2+145, 20, 20, "", false, false )
		guiEditSetMasked(login_passwordEdit, true)
		guiSetVisible(login_firstNameEdit, false)
		guiSetVisible(login_lastNameEdit, false)
		guiSetVisible(login_passwordEdit, false)
		guiSetVisible(login_checkboxSave, false)
		login_loginButton = dxCreateButton(screenWidth/2-475/2+340,screenHeight/2-185/2+133,100,26,"Einloggen",false,false)
		dxSetVisible(login_loginButton, false)
		
		local vitaXML = xmlLoadFile("vita_settings.xml")
		if vitaXML then
			local vitaNode = xmlFindChild(vitaXML, "saved", 0)
			if xmlNodeGetValue(vitaNode) == "1" then
				vitaNode = xmlFindChild(vitaXML, "firstname", 0)
				guiSetText(login_firstNameEdit, xmlNodeGetValue(vitaNode))
				vitaNode = xmlFindChild(vitaXML, "lastname", 0)
				guiSetText(login_lastNameEdit, xmlNodeGetValue(vitaNode))				
				vitaNode = xmlFindChild(vitaXML, "password", 0)
				guiSetText(login_passwordEdit, xmlNodeGetValue(vitaNode))		
				guiCheckBoxSetSelected(login_checkboxSave, true)
			end
			xmlUnloadFile(vitaXML)
		else
			local vitaXML = xmlCreateFile("vita_settings.xml","settings")
			local vitaNode = xmlCreateChild(vitaXML, "saved")
			xmlNodeSetValue ( vitaNode, "0" )
			vitaNode = xmlCreateChild(vitaXML, "firstname")
			xmlNodeSetValue ( vitaNode, "" )
			vitaNode = xmlCreateChild(vitaXML, "lastname")
			xmlNodeSetValue ( vitaNode, "" )			
			vitaNode = xmlCreateChild(vitaXML, "password")
			xmlNodeSetValue ( vitaNode, "" )	
			xmlSaveFile(vitaXML)
			xmlUnloadFile(vitaXML)			
		end
	
		addEventHandler("onClientDXClick", login_loginButton,
		function()
				loginFirstNameText = guiGetText(login_firstNameEdit)
				loginLastNameText = guiGetText(login_lastNameEdit)
				loginPassword = guiGetText(login_passwordEdit)
				local vitaXML = xmlLoadFile("vita_settings.xml")
				if vitaXML then
					if guiCheckBoxGetSelected(login_checkboxSave) == true then
						local vitaNode = xmlFindChild(vitaXML, "saved", 0)
						xmlNodeSetValue ( vitaNode, "1")		
						vitaNode = xmlFindChild(vitaXML, "firstname", 0)
						xmlNodeSetValue ( vitaNode, loginFirstNameText)							
						vitaNode = xmlFindChild(vitaXML, "lastname", 0)
						xmlNodeSetValue ( vitaNode, loginLastNameText)
						vitaNode = xmlFindChild(vitaXML, "password", 0)
						xmlNodeSetValue ( vitaNode, loginPassword)				
					else
						local vitaNode = xmlFindChild(vitaXML, "saved", 0)
						xmlNodeSetValue ( vitaNode, "0")			
						vitaNode = xmlFindChild(vitaXML, "firstname", 0)
						xmlNodeSetValue ( vitaNode, "")
						vitaNode = xmlFindChild(vitaXML, "lastname", 0)
						xmlNodeSetValue ( vitaNode, "")							
						vitaNode = xmlFindChild(vitaXML, "password", 0)
						xmlNodeSetValue ( vitaNode, "")				
					end
					xmlSaveFile(vitaXML)
					xmlUnloadFile(vitaXML)
				end
						
				if loginFirstNameText ~= "" and loginLastNameText ~= "" and loginPassword ~= "" then
					triggerServerEvent("loginRPGPlayerToServer", getRootElement(), lp, loginFirstNameText, loginLastNameText, loginPassword)
				else
					addNotification(1, 255, 0, 0, "Es wurden nicht alle Felder ausgefüllt.")
				end
			end, false)
    end
)

addEvent("loginComplete", true)
addEventHandler("loginComplete", getRootElement(),
	function()
	
		createTachoImages()
		createPerso()
		createCustomImages()
		for i,v in ipairs(preLoginTextures) do
			replaceTextureFunc(v.element, v.texture, v.file)
		end
		preLoginTextures = nil
		
		destroyElement(login_firstNameEdit)
		destroyElement(login_lastNameEdit)
		destroyElement(login_passwordEdit)
		destroyElement(login_loginButton)
		destroyElement(login_checkboxSave)
		vitaBackgroundToggle(false)
		showCursor(false)
		removeEventHandler ( "onClientRender", getRootElement(), renderRealLogin )			
	end)


addEvent("openRegisterWindowAfterStory", true)
addEventHandler("openRegisterWindowAfterStory", getRootElement(),
	function()
		guiSetVisible(register_tabpanel, true)
		
		showCursor(true)
	end)
	
local isSkinShop = false
function startSkinSelection(shop)
	if not shop then
		isSkinShop = false 
	else 
		isSkinShop = true
		bindKey("backspace", "down", function()
			useThisRPGSkin(true)
			unbindKey("backspace")
		end)
	end
	registrationSkinSelected = 1
	registrationGeschlecht = "Maennlich"
	setCameraMatrix(168.72750854492, -76.431747436523 , 1002.4771118164, 241.2407989502, -9.0272598266602, 988.3896484375)
	setElementInterior(getLocalPlayer(), 18)
	theChooseSkinPed = createPed(7,172.31,-73,1001.8)
	setElementInterior(theChooseSkinPed,18)
	setPedAnimation(theChooseSkinPed,"PLAYIDLES","shift",-1,true)
	addEventHandler ( "onClientRender", getRootElement(), renderSkinSelection )
	bindKey("arrow_l","down", choosePrevRPGSkin)
	bindKey("arrow_r","down", chooseNextRPGSkin)
	bindKey("arrow_u","down", chooseGeschlecht)
	bindKey("arrow_d","down", chooseGeschlecht)
	bindKey("enter", "down", useThisRPGSkin)
	bindKey("space", "down", useThisRPGSkin)
	bindKey("num_enter", "down", useThisRPGSkin)
	fadeCamera(true,1)
end

function useThisRPGSkin(backspace)
	playSoundFrontEnd(40)
	fadeCamera(false,1)
	if registrationGeschlecht == "Maennlich" then
		registrationSkinSelected = rpgPlayerSkinsM[registrationSkinSelected]
	else
		--Spieler ist also ein Untermensch
		registrationSkinSelected = rpgPlayerSkinsW[registrationSkinSelected]
	end
	unbindKey("arrow_l","down", choosePrevRPGSkin)
	unbindKey("arrow_r","down", chooseNextRPGSkin)
	unbindKey("arrow_u","down", chooseGeschlecht)
	unbindKey("arrow_d","down", chooseGeschlecht)
	unbindKey("enter", "down", useThisRPGSkin)	
	unbindKey("space", "down", useThisRPGSkin)	
	unbindKey("num_enter", "down", useThisRPGSkin)	
	removeEventHandler ( "onClientRender", getRootElement(), renderSkinSelection )
	if not isSkinShop then
		setTimer(function()
			destroyElement(theChooseSkinPed)
			setElementInterior(getLocalPlayer(), 0)
			triggerServerEvent("clientIsReady", lp, lp)
		end, 2000, 1)	
	else
		setTimer(function()
			destroyElement(theChooseSkinPed)
			setElementInterior(getLocalPlayer(), 0)
			triggerServerEvent("setBoughtSkin", lp, registrationGeschlecht, registrationSkinSelected, backspace)
		end, 2000, 1)	
	end	
end

function chooseGeschlecht()
	playSoundFrontEnd(40)
	if registrationGeschlecht == "Maennlich" then
		registrationGeschlecht = "Weiblich"
		registrationSkinSelected = math.random(1, #rpgPlayerSkinsW)
	else
		registrationGeschlecht = "Maennlich"
		registrationSkinSelected = math.random(1, #rpgPlayerSkinsM)
	end
	chooseNextRPGSkin()
end

function choosePrevRPGSkin()
	playSoundFrontEnd(40)
	if registrationGeschlecht == "Maennlich" then
		if registrationSkinSelected == 1 then
			registrationSkinSelected = #rpgPlayerSkinsM
		else
			registrationSkinSelected = registrationSkinSelected-1
		end
		setElementModel(theChooseSkinPed,rpgPlayerSkinsM[registrationSkinSelected])
	else
		if registrationSkinSelected == 1 then
			registrationSkinSelected = #rpgPlayerSkinsW
		else
			registrationSkinSelected = registrationSkinSelected-1
		end
		setElementModel(theChooseSkinPed,rpgPlayerSkinsW[registrationSkinSelected])
	end
end

function chooseNextRPGSkin()
	playSoundFrontEnd(40)
	if registrationGeschlecht == "Maennlich" then
		if registrationSkinSelected == #rpgPlayerSkinsM then
			registrationSkinSelected = 1
		else
			registrationSkinSelected = registrationSkinSelected+1
		end
		setElementModel(theChooseSkinPed,rpgPlayerSkinsM[registrationSkinSelected])
	else
		if registrationSkinSelected == #rpgPlayerSkinsW then
			registrationSkinSelected = 1
		else
			registrationSkinSelected = registrationSkinSelected+1
		end
		setElementModel(theChooseSkinPed,rpgPlayerSkinsW[registrationSkinSelected])
	end
end

function renderSkinSelection()
	local pedRot = getPedRotation(theChooseSkinPed)
	if pedRot + 1 > 360 then pedRot = 0 else pedRot = pedRot +1 end
	setPedRotation ( theChooseSkinPed, pedRot )
	if not isSkinShop then
		dxDrawShadowedText ( "← Skinauswahl →\n↑ Geschlechtsauswahl ↓\nAuswahl: ENTER / SPACE", 0, screenHeight-130, screenWidth, screenHeight, tocolor(255,255,255,255), tocolor(0,0,0,255), 1, "bankgothic", "center")
	else
		dxDrawShadowedText ( "← Skinauswahl →\n↑ Geschlechtsauswahl ↓\nAuswahl: ENTER / SPACE (80.000 Vero)\nAbbrechen BACKSPACE", 0, screenHeight-130, screenWidth, screenHeight, tocolor(255,255,255,255), tocolor(0,0,0,255), 1, "bankgothic", "center")	
	end
end