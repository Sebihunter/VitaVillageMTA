--[[
Project: VitaOnline
File: clicksystem-client.lua
Author(s):	Sebihunter
			CubedDeath
]]--

local theActionMissionTextInDraw = ""
local thexlowspeed = 0
theclickedelementped = {}
local ChooseClick_Button = {}


ChooseClick_Button[1] = guiCreateButton(0,screenHeight-100,450,100,"",false)
ChooseClick_Button[2] = guiCreateButton(screenWidth-450,screenHeight-100,450,100,"",false)

guiSetVisible(ChooseClick_Button[1],false)
guiSetVisible(ChooseClick_Button[2],false)

local inTankstelle = false

function renderCursor()
	if not isCursorShowing ( ) then return end
	if guiGetInputEnabled ( ) == true then return end
	inTankstelle = false
	for index, contentC in ipairs(getElementsByType("tankstelle")) do
		content = getElementData(contentC, "colCircle")
		if (isElementWithinColShape ( getLocalPlayer(), content )) then
			inTankstelle = contentC
		end
	end
	
	local mcx, mcy = getCursorPosition ( )
	mcx = screenWidth*mcx
	mcy = screenHeight*mcy
	if renderInfo == 1 then
		if inTankstelle and isElement(inTankstelle) then		
			dxDrawImage ( mcx+10, mcy-48, 32, 32, "images/m_left.png" )
			dxDrawShadowedText("Auf-/Abschließen", mcx+38, mcy-35, screenWidth, screenHeight, tocolor(255,255,255,255), tocolor(0,0,0,255), 1, "default")
			dxDrawImage ( mcx+10, mcy-16, 32, 32, "images/m_middle.png" )
			dxDrawShadowedText("Tanken", mcx+38, mcy-6, screenWidth, screenHeight, tocolor(255,255,255,255), tocolor(0,0,0,255), 1, "default")			
			dxDrawImage ( mcx+10, mcy+16, 32, 32, "images/m_right.png" )	
			dxDrawShadowedText("Autoinformationen", mcx+38, mcy+26, screenWidth, screenHeight, tocolor(255,255,255,255), tocolor(0,0,0,255), 1, "default")
		else
			if renderExtra == 1 then
				dxDrawImage ( mcx+10, mcy-48, 32, 32, "images/m_left.png" )
				dxDrawShadowedText("Auf-/Abschließen", mcx+38, mcy-35, screenWidth, screenHeight, tocolor(255,255,255,255), tocolor(0,0,0,255), 1, "default")
				dxDrawImage ( mcx+10, mcy-16, 32, 32, "images/m_middle.png" )
				dxDrawShadowedText("Kofferraum", mcx+38, mcy-6, screenWidth, screenHeight, tocolor(255,255,255,255), tocolor(0,0,0,255), 1, "default")			
				dxDrawImage ( mcx+10, mcy+16, 32, 32, "images/m_right.png" )	
				dxDrawShadowedText("Autoinformationen", mcx+38, mcy+26, screenWidth, screenHeight, tocolor(255,255,255,255), tocolor(0,0,0,255), 1, "default")
			else
				dxDrawImage ( mcx+10, mcy-25, 32, 32, "images/m_left.png" )
				dxDrawShadowedText("Auf-/Abschließen", mcx+38, mcy-15, screenWidth, screenHeight, tocolor(255,255,255,255), tocolor(0,0,0,255), 1, "default")
				dxDrawImage ( mcx+10, mcy+5, 32, 32, "images/m_right.png" )	
				dxDrawShadowedText("Autoinformationen", mcx+38, mcy+16, screenWidth, screenHeight, tocolor(255,255,255,255), tocolor(0,0,0,255), 1, "default")
			end			
		end
	elseif type(renderInfo) == "table" then
		if #renderInfo == 2 then
			dxDrawImage ( mcx+10, mcy-32, 32, 32, "images/m_left.png" )
			dxDrawShadowedText(renderInfo[1], mcx+38, mcy-22, screenWidth, screenHeight, tocolor(255,255,255,255), tocolor(0,0,0,255), 1, "default")
			dxDrawImage ( mcx+10, mcy+5, 32, 32, "images/m_right.png" )	
			dxDrawShadowedText(renderInfo[2], mcx+38, mcy+16, screenWidth, screenHeight, tocolor(255,255,255,255), tocolor(0,0,0,255), 1, "default")		
		else
			dxDrawImage ( mcx+10, mcy-10, 32, 32, "images/m_left.png" )
			dxDrawShadowedText(renderInfo[1], mcx+38, mcy, screenWidth, screenHeight, tocolor(255,255,255,255), tocolor(0,0,0,255), 1, "default")		
		end
	end
end
addEventHandler ( "onClientRender", getRootElement(), renderCursor)
function cursorMove ( cx, cy, x, y, wx, wy, wz )
	if not isCursorShowing ( ) then return end
	wx, wy, wz = getWorldFromScreenPosition ( x, y, 10)
	local px, py, pz = getElementPosition(getLocalPlayer())
    local camx, camy, camz = getCameraMatrix()
	local hit, _, _, _, hitElement = processLineOfSight(camx, camy, camz, wx, wy, wz, true, true, true, true, true, true, false, true, nil, false, false)
	renderInfo = 0
	renderExtra = 0
	if hit and hitElement and isElement(hitElement) and getElementData(getLocalPlayer(), "inHelp") ~= true then
		local px, py, pz = getElementPosition(getLocalPlayer())
		if getDistanceBetweenPoints3D (px, py, pz, camx, camy, camz ) < 10 then
			if getElementType(hitElement) == "vehicle" and getElementData(hitElement, "isVehicleTemp") ~= true then 
				renderInfo = 1
				if getVehicleType ( hitElement ) == "Automobile" and getElementData(hitElement, "inventory") then
					renderExtra = 1
				end
			elseif getElementData(hitElement, "cinfo") and type(getElementData(hitElement, "cinfo")) == "table" then
				renderInfo = getElementData(hitElement, "cinfo")
			elseif getElementType( hitElement ) == "object" and getElementModel(hitElement) == 2942 then
				renderInfo = {"ATM verwenden"}
			end
		end
	end
end
addEventHandler( "onClientCursorMove", getRootElement( ), cursorMove)


function ClickMouse ( button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement )
	if isHovingSkinImage() then 
		return showInventory()
	end
	
	if clickedElement and getElementData(getLocalPlayer(), "inHelp") ~= true then
		if guiGetInputEnabled ( ) == true then return end
		for i,v in ipairs(getElementsByType("gui-window")) do
			if guiGetVisible ( v ) == true then return end
		end
		if (state == "down") then
			local playerx, playery,playerz = getElementPosition ( getLocalPlayer( ))
			local hitedx,hittedy,hittedz = getElementPosition(clickedElement)		
			if getElementType ( clickedElement ) == "object" and button == "right" and getElementData( clickedElement, "isRadio") == true and getDistanceBetweenPoints3D(hitedx,hittedy,hittedz, playerx, playery,playerz) < 10 then
				showRadioGUI(clickedElement)
			elseif getElementType ( clickedElement ) == "vehicle" and button == "left"and getElementData(clickedElement, "isVehicleTemp") ~= true then
				if getDistanceBetweenPoints3D(hitedx,hittedy,hittedz, playerx, playery,playerz) < 10 then
					triggerServerEvent("AutoAufZu", getLocalPlayer(), clickedElement,getLocalPlayer())
				end
			elseif getElementType( clickedElement ) == "object" and getElementModel(clickedElement) == 2942 then
				bankGUI.loginWindow.open() --should be also triggered somewhere else? IDK where so added here
			elseif getElementType ( clickedElement ) == "vehicle" and button == "right" and getElementData(clickedElement, "isVehicleTemp") ~= true then		
				if getDistanceBetweenPoints3D(hitedx,hittedy,hittedz, playerx, playery,playerz) < 10 then
					outputChatBox("--Fahrzeugdaten--",255,255,0)
					outputChatBox("Modell: "..getVehicleName(clickedElement),255,255,0)
					outputChatBox("Besitzer: "..getElementData(clickedElement,"owner"),255,255,0)
					outputChatBox("Schlüsselbesitzer: "..getElementData(clickedElement,"keys"),255,255,0)
					outputChatBox("Kilometerstand: "..math.round(getElementData(clickedElement,"km"),2).."km",255,255,0)
					outputChatBox("Fahrzeugwert: "..math.round(getElementData(clickedElement,"preis"),2).." Vero",255,255,0)
					outputChatBox("Herstelldatum: "..getElementData(clickedElement,"herstelldatum"),255,255,0)
					if getElementData(clickedElement, "owner") ~= "Autohaus" and getVehicleType(clickedElement) ~= "BMX" then
						local ttage = getElementData(clickedElement,"tuev")+14-getRealTime().yearday
						if ttage >= 0 then
							outputChatBox("Verbleibende Dauer der TÜV Plakette: "..ttage.." Tage",255,255,0)
						else
							outputChatBox("TÜV Plakette abgelaufen seit: "..ttage*(-1).." Tag(en)",255,255,0)
						end
					end
					if getElementData(getLocalPlayer(), "job") == 4 and getElementData(getLocalPlayer(), "dienst") == 1 then
						outputChatBox("Schaden: "..tostring(getElementData(clickedElement,"panne")),255,255,0)
						outputChatBox("Benzin: "..math.round(getElementData(clickedElement,"fuel"),2).."% - Ölstand: "..math.round(getElementData(clickedElement,"oil"),2).."%",255,255,0)
						outputChatBox("Batterie: "..math.round(getElementData(clickedElement,"battery"),2).."% - Wasserstand: "..math.round(getElementData(clickedElement,"water"),2).."%",255,255,0)
					end
					if getElementData(clickedElement, "eingepackt") == true then
						outputChatBox("Anhänger-Inhalt: ".. getVehicleNameFromModel (tonumber(getElementData ( clickedElement, "model" ))),255,255,0)
					end
					outputChatBox("--Ende der Fahrzeugdaten--",255,255,0)
				end
			elseif getElementType ( clickedElement ) == "vehicle" and button == "middle" and inTankstelle and isElement(inTankstelle) and getDistanceBetweenPoints3D(hitedx,hittedy,hittedz, playerx, playery,playerz) < 10 then
				if isPedInVehicle ( getLocalPlayer( ) ) == false and getElementData(clickedElement, "isVehicleTemp") ~= true then
					StarteTankvorgang(clickedElement, inTankstelle)
				else
					addNotification(1, 255, 0, 0, "Du kannst beim Tanken nicht im Fahrzeug sein.")
				end
			elseif getElementType ( clickedElement ) == "vehicle" and button == "middle" and getDistanceBetweenPoints3D(hitedx,hittedy,hittedz, playerx, playery,playerz) < 10 and getVehicleType ( clickedElement ) == "Automobile" and getElementData(clickedElement, "isVehicleTemp") ~= true then
				if not getPedOccupiedVehicle( getLocalPlayer() ) then
					if isVehicleLocked ( clickedElement ) then 
						if getElementData(getLocalPlayer(), "dienst") == 1 and getElementData(getLocalPlayer(), "job") == 3 then
							triggerServerEvent( "onPlayerChatRemote", getLocalPlayer(), "hat einen abgeschlossenen Kofferraum (Fahrzeug: "..getVehicleName ( clickedElement)..") aufgebrochen.", 1)
						else
							return addNotification(1, 255, 0, 0, "Der Kofferaum ist abgesperrt.")
						end
					else
						triggerServerEvent( "onPlayerChatRemote", getLocalPlayer(), "hat einen Kofferraum (Fahrzeug: "..getVehicleName ( clickedElement )..") geöffnet.", 1)
					end
				else
					return addNotification(1, 255, 0, 0, "Du kannst den Kofferraum nicht in einem Fahrzeug benutzen.")
				end
				showCrate(clickedElement)
			elseif getElementType( clickedElement ) == "ped" then
				if getDistanceBetweenPoints3D(hitedx,hittedy,hittedz, playerx, playery,playerz) < 3 then
					if getElementData(clickedElement, "isAdminPed") == true then
						showAdminGUI()
					end					
					if getElementData(clickedElement, "isSkinPed") == true then
						startSkinSelection(true)
					end						
					if getElementData(clickedElement, "isShopPed") == true then
						showShopGUI()
					end
					if getElementData(clickedElement, "isDonutPed") == true then
						showDonutGUI()
					end		
					if getElementData(clickedElement, "isNoodlesPed") == true then
						showNoodlesGUI()
					end		
					if getElementData(clickedElement, "isHotdogPed") == true then
						showHotdogGUI()
					end		
					if getElementData(clickedElement, "isPizzaPed") == true then
						showPizzaGUI()
					end							
					if getElementData(clickedElement, "isSexPed") == true then
						showSexGUI()
					end						
					if getElementData(clickedElement, "isFFPed") == true then
						showFFGUI()
					end						
					if getElementData(clickedElement, "isStaatPed") == true then
						showStadthalle()
					end				
					if getElementData(clickedElement, "isGangWeaponPed") == true then
						showWeaponGUI()
					end
					if getElementData(clickedElement, "isGluehweinPed") == true then
						showGluehweinGUI()
					end					
					if getElementData(clickedElement, "isBarPed") == true then
						showBarGUI()
					end					
					if tonumber(getElementModel(clickedElement)) == 172 then
						bankGUI.loginWindow.open()
					end
				end
			end
		end
	end
end

addEventHandler ( "onClientClick", getRootElement(), ClickMouse)
