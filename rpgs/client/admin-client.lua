--[[
Project: VitaOnline
File: admin-client.lua
Author(s):	Golf_R32
			CubedDeath
]]--


--MessageBox
MessageBox_Window = {}
MessageBox_Button = {}
MessageBox_Label = {}

MessageBox_Window[1] = guiCreateWindow(0.3974,0.4213,0.1964,0.1352,"Message Box",true)
guiWindowSetSizable(MessageBox_Window[1],false)
MessageBox_Label[1] = guiCreateLabel(0.0451,0.226,0.9098,0.4315,"Test",true,MessageBox_Window[1])
guiLabelSetColor(MessageBox_Label[1],255,255,255)
guiLabelSetVerticalAlign(MessageBox_Label[1],"top")
guiLabelSetHorizontalAlign(MessageBox_Label[1],"left",false)
MessageBox_Button[1] = guiCreateButton(0.0663,0.7466,0.2255,0.1781,"Nein",true,MessageBox_Window[1])
MessageBox_Button[2] = guiCreateButton(0.7109,0.7466,0.2255,0.1781,"Ja",true,MessageBox_Window[1])

guiSetVisible(MessageBox_Window[1],false)
g_MessageBoxGUI = "N/A"

function showMessageBox(windowname, labeltext)
	guiSetVisible(MessageBox_Window[1], true)
	guiSetText(MessageBox_Window[1], windowname)
	guiSetText(MessageBox_Label[1], labeltext)
	guiBringToFront(MessageBox_Window[1])
end


g_FreeMode = false

addEvent("onRPGPlayerGetStats",true)
addEventHandler("onRPGPlayerGetStats", getLocalPlayer(),
	function(data)
		guiGridListClear(AdminUserPanel_Grid[1])
		destroyElement(AdminUserPanel_Grid[1])
		AdminUserPanel_Grid[1] = guiCreateGridList(0.045,0.04,0.91,0.7,true,AdminUserPanel_Tab[1])
		guiGridListSetSelectionMode(AdminUserPanel_Grid[1],1)
		guiGridListAddColumn(AdminUserPanel_Grid[1],"Name",0.22)
		guiGridListAddColumn(AdminUserPanel_Grid[1],"Status",0.22)
		guiGridListAddColumn(AdminUserPanel_Grid[1],"Erstellt",0.15)
		guiGridListAddColumn(AdminUserPanel_Grid[1],"Zuletzt Online",0.18)
		guiGridListAddColumn(AdminUserPanel_Grid[1],"Skin",0.1)
		guiGridListAddColumn(AdminUserPanel_Grid[1],"Adminstatus",0.15)
		guiGridListAddColumn(AdminUserPanel_Grid[1],"Geschlecht",0.15)
		guiGridListAddColumn(AdminUserPanel_Grid[1],"Geburtstag",0.15)
		guiGridListAddColumn(AdminUserPanel_Grid[1],"Job",0.2)
		guiGridListAddColumn(AdminUserPanel_Grid[1],"Rang",0.2)
		guiGridListAddColumn(AdminUserPanel_Grid[1],"Geld",0.2)

		for i = 1, #data do
			local row = guiGridListAddRow ( AdminUserPanel_Grid[1] ) 
			guiGridListSetItemText ( AdminUserPanel_Grid[1], row, 1, tostring(data[i].name), false, false )
			guiGridListSetItemText ( AdminUserPanel_Grid[1], row, 2, tostring(getPlayerStatus(tonumber(data[i].activ))), false, false )
			guiGridListSetItemText ( AdminUserPanel_Grid[1], row, 3, tostring(data[i].erstellt), false, false )
			guiGridListSetItemText ( AdminUserPanel_Grid[1], row, 4, tostring(data[i].laston), false, false )
			guiGridListSetItemText ( AdminUserPanel_Grid[1], row, 5, tostring(data[i].skin), false, false )
			guiGridListSetItemText ( AdminUserPanel_Grid[1], row, 6, tostring(getPlayerRightsName(data[i].admin)), false, false )
			guiGridListSetItemText ( AdminUserPanel_Grid[1], row, 7, tostring(data[i].geschlecht), false, false )
			guiGridListSetItemText ( AdminUserPanel_Grid[1], row, 8, tostring(data[i].birth), false, false )
			guiGridListSetItemText ( AdminUserPanel_Grid[1], row, 9, tostring(getJobName(tonumber(data[i].job))), false, false )
			guiGridListSetItemText ( AdminUserPanel_Grid[1], row, 10, tostring(getJobRangName(tonumber(data[i].rank))), false, false )
			guiGridListSetItemText ( AdminUserPanel_Grid[1], row, 11, tostring(data[i].money).." Vero", false, false )
		end
		guiGridListSetSortingEnabled ( AdminUserPanel_Grid[1], true )
	end
)

function getPlayerStatus(activatedid)
	local activatedstatus
	if activatedid == 0 then
		activatedstatus = "Registriert" 
	elseif activatedid == 1 then
		activatedstatus = "Tutorial"
	elseif activatedid == 2 then
		activatedstatus = "Freigeschaltet"
	else
		return false
	end
	return activatedstatus
end

function showHideTheUserPanelMenu()
	if guiGetVisible(AdminUserPanel_Window[1]) == false then
		guiSetInputMode("no_binds_when_editing")
		showTutorialMessage("admin_1", "Herzlich Willkommen bei uns im 'The Vita Village' Team. Wir freuen uns auf die gemeinsame Zusammenarbeit! :-)")
		guiGridListClear(AdminUserPanel_Grid[1])
		triggerServerEvent("getRPGPlayersToRegister", getLocalPlayer(), getLocalPlayer())
		guiSetVisible(AdminUserPanel_Window[1],true)
		doRefreshTheADMVehicleList()
		doRefreshTheADMVehicleList2()
		doRefreshSupportList()
		showCursor(true)
		guiBringToFront(AdminUserPanel_Window[1])
		
		if tonumber(getElementData(getLocalPlayer(), "getPlayerSpecialRights")) >= 1 then
			guiSetProperty( AdminUserPanel_Button[3], "Disabled", "True" )
			guiSetProperty( AdminUserPanel_Button[4], "Disabled", "True" )
			guiSetProperty( AdminUserPanel_Button[6], "Disabled", "True" )
			guiSetProperty( AdminUserPanel_Button[7], "Disabled", "True" ) 
			guiSetProperty( AdminUserPanel_Button[8], "Disabled", "True" ) 
			guiSetProperty( AdminVehiclePanel_Button[1], "Disabled", "True" )
			guiSetProperty( AdminVehiclePanel_Button[4], "Disabled", "True" )
			guiSetProperty( AdminVehiclePanel_Button[5], "Disabled", "True" )
			guiSetProperty( AdminVehiclePanel_Button[7], "Disabled", "True" )
		end
		if tonumber(getElementData(getLocalPlayer(), "getPlayerSpecialRights")) >= 1 then -->= 2 then
			for i=1,#AdminUserPanel_Button do
				guiSetProperty( AdminUserPanel_Button[i], "Disabled", "False" )
			end
			guiSetProperty( AdminVehiclePanel_Button[1], "Disabled", "False" )
			guiSetProperty( AdminVehiclePanel_Button[4], "Disabled", "False" )
			guiSetProperty( AdminVehiclePanel_Button[5], "Disabled", "False" )
			guiSetProperty( AdminVehiclePanel_Button[7], "Disabled", "False" )
		end
	else
		guiSetInputEnabled(false)
		guiSetVisible(AdminUserPanel_Window[1],false)
		guiSetVisible(AdminVehicleChoosePanel_Grid[1],false)
		guiSetVisible(AdminPlayerJob_Window[1],false)
		guiSetVisible(AdminPlayerRang_Window[1],false)
		guiSetVisible(AdminPlayerRight_Window[1],false)
		guiSetVisible(MessageBox_Window[1],false)
		guiSetVisible(AdminCreateVehicle_Window[1],false)
		showCursor(false)
	end
end
addEvent("showTheAdminPlayerUserMenu", true)
addEventHandler("showTheAdminPlayerUserMenu", getLocalPlayer(), showHideTheUserPanelMenu)


addEventHandler("onClientGUIClick", getRootElement(),
	function (btn)
		if btn == "left" then
			--Vehicle Tab
			if source == AdminVehiclePanel_Grid[3] then
				local theselecteditem = guiGridListGetSelectedItem(AdminVehiclePanel_Grid[3])
				if theselecteditem ~= -1 then
					for i,v in ipairs(getElementsByType("report")) do
						if guiGridListGetItemText ( AdminVehiclePanel_Grid[3], theselecteditem, 2) == getElementData(v, "name") then
							theReportACPnum = #getElementData(v, "table")
							theReportSelected = v
							local tab = getElementData(theReportSelected, "table")
							guiSetText(theReportLabel, "["..theReportACPnum.."] "..tab[theReportACPnum])
							setElementData(theReportSelected, "read", true)
							break
						end
					end
				end
			end
			if source == theReportSend then
				if theReportSelected then
					local text = guiGetText(theReportEdit)
					local tab = getElementData(theReportSelected, "table")
					tab[#tab+1] = ">SUPPORT< "..getPlayerName(getLocalPlayer())..": "..text
					addNotification(2, 0, 255, 0, "Supportnachricht versendet!")
					triggerServerEvent("sendSupportMessage", getLocalPlayer(), text, getElementData(theReportSelected, "name"))
					setElementData(theReportSelected, "table", tab)
					guiSetText(theReportLabel, "["..#tab.."] "..tab[#tab])
				end
			end			
			if source == theReportBack then
				if theReportSelected then
					theReportACPnum = theReportACPnum - 1
					if theReportACPnum <= 0 then
						theReportACPnum = #getElementData(theReportSelected, "table")
					end
					guiSetText(theReportLabel, "["..theReportACPnum.."] "..getElementData(theReportSelected, "table")[theReportACPnum])
				end
			end
			if source == theReportForward then
				if theReportSelected then
					theReportACPnum = theReportACPnum + 1
					if theReportACPnum > #getElementData(theReportSelected, "table") then
						theReportACPnum = 1
					end
					guiSetText(theReportLabel, "["..theReportACPnum.."] "..getElementData(theReportSelected, "table")[theReportACPnum])
				end
			end			
			if source == AdminVehiclePanel_Button[1] then
				guiSetVisible(AdminCreateVehicle_Window[1],true)
				guiBringToFront(AdminCreateVehicle_Window[1])
				guiSetInputEnabled (true)
			end
			if source == AdminVehiclePanel_Button[3] then
				local theselecteditem = guiGridListGetSelectedItem(AdminVehiclePanel_Grid[1])
				if theselecteditem ~= -1 then
					for i,veh in ipairs(getElementsByType("vehicle")) do
						if i == tonumber(guiGridListGetItemText ( AdminVehiclePanel_Grid[1], theselecteditem, 1)) then
							local x,y,z = getElementPosition(getLocalPlayer())
							callServerFunction("setElementPosition", veh, x, y, z)
							callServerFunction("setElementInterior", veh, 0)
							callServerFunction("setElementDimension", veh, 0)
							callServerFunction("warpPedIntoVehicle", getLocalPlayer(), veh)
							break
						end
					end
				end
			end
			if source == AdminVehiclePanel_Button[4] then
				local theselecteditem = guiGridListGetSelectedItem(AdminVehiclePanel_Grid[1])
				if theselecteditem ~= -1 then
					showMessageBox("Fahrzeug loeschen?", "Soll dieses Fahrzeug wirklich geloescht werden?")
					g_MessageBoxGUI = "deleteVehicle"
				end
			end
			if source == AdminVehiclePanel_Button[5] then
				local theselecteditem = guiGridListGetSelectedItem(AdminVehiclePanel_Grid[1])
				if theselecteditem ~= -1 then
					triggerServerEvent("doRepairTheRPGVehicle", getLocalPlayer(), getLocalPlayer(), guiGridListGetItemText ( AdminVehiclePanel_Grid[1], theselecteditem, 1), guiGridListGetItemText ( AdminVehiclePanel_Grid[1], theselecteditem, 3))
				end
			end
			if source == AdminVehiclePanel_Button[6] then
				local theselecteditem = guiGridListGetSelectedItem(AdminVehiclePanel_Grid[1])
				if theselecteditem ~= -1 then
					guiSetVisible(AdminVehicleChoosePanel_Grid[1],true)
					guiBringToFront(AdminVehicleChoosePanel_Grid[1])
					choosenbutton = 1
					triggerServerEvent("getRPGPlayersToRegister", getLocalPlayer(), getLocalPlayer())
					thechoooosenvehicle = theselecteditem
				end
			end
			if source == AdminVehiclePanel_Button[7] then
				local theselecteditem = guiGridListGetSelectedItem(AdminVehiclePanel_Grid[1])
				if theselecteditem ~= -1 then
					guiSetVisible(AdminVehicleChoosePanel_Grid[1],true)
					choosenbutton = 2
					triggerServerEvent("getRPGPlayersToRegister", getLocalPlayer(), getLocalPlayer())
					thechoooosenvehicle = theselecteditem
				end
			end
			if source == AdminVehiclePanel_Button[8] then
				local theselecteditem = guiGridListGetSelectedItem(AdminVehiclePanel_Grid[1])
				if theselecteditem ~= -1 then
					triggerServerEvent("doUnLockTheVehicle", getLocalPlayer(), guiGridListGetItemText ( AdminVehiclePanel_Grid[1], theselecteditem, 1))
					setTimer(doRefreshTheADMVehicleList,200,1)
				end
			end
			--
			if source == AdminCreateVehicle_Button[1] then -- OK Button
				local vehicle = guiGetText(AdminCreateVehicle_Edit[1])
				local r = guiGetText(AdminCreateVehicle_Edit[2])
				local g = guiGetText(AdminCreateVehicle_Edit[3])
				local b = guiGetText(AdminCreateVehicle_Edit[4])
				local daveh
				if vehicle ~= nil then
					if type(tonumber(vehicle)) == "number" then
						daveh = tonumber(vehicle)
					else
						daveh = getVehicleModelFromName ( vehicle )
					end
					if string.len(r) >= 0 and string.len(r) <= 255  and string.len(g) >= 0 and string.len(g) <= 255 and string.len(b) >= 0 and string.len(b) <= 255 then
						if daveh then
							triggerServerEvent("doCreateARootVehicle", getLocalPlayer(), getLocalPlayer(), daveh, {{r,g,b},{r,g,b},{0,0,0},{0,0,0}},guiRadioButtonGetSelected(AdminCreateVehicle_Radio[1]))
							guiSetVisible(AdminCreateVehicle_Window[1],false)
							guiSetVisible(ColorVehicleWindow_Window[1],false)
							guiBringToFront(AdminUserPanel_Window[1])
							guiSetInputEnabled (false)
							setTimer(doRefreshTheADMVehicleList,200,1)
						else
							--TODO: Message senden
						end
					else
						--TODO: Message senden
					end
				end
			end
			if source == AdminCreateVehicle_Button[2] then -- Schliessen Button
				guiSetVisible(ColorVehicleWindow_Window[1],false)
				guiSetVisible(AdminCreateVehicle_Window[1],false)
				guiBringToFront(AdminUserPanel_Window[1])
				guiSetInputEnabled (false)
			end
			if source == AdminCreateVehicle_Button[3] then
				guiSetVisible(ColorVehicleWindow_Window[1],true)
				guiBringToFront(ColorVehicleWindow_Window[1])
			end
			if source == ColorVehicleWindow_Button[1] then -- 
				guiSetVisible(ColorVehicleWindow_Window[1],false)
				guiBringToFront(AdminCreateVehicle_Window[1])
			end
			-- Job Tab
			if source == AdminUserPanel_Button[1] then
				local theselecteditem = guiGridListGetSelectedItem(AdminUserPanel_Grid[1])
				if theselecteditem ~= -1 then
					if guiGridListGetItemText ( AdminUserPanel_Grid[1], theselecteditem, 2) == "Registriert" then
						triggerServerEvent("setPlayerRegisterStatus",getLocalPlayer(),guiGridListGetItemText ( AdminUserPanel_Grid[1], theselecteditem, 1),1)
					end
				end
			end
			if source == AdminUserPanel_Button[2] then
				local theselecteditem = guiGridListGetSelectedItem(AdminUserPanel_Grid[1])
				if theselecteditem ~= -1 then
					if guiGridListGetItemText ( AdminUserPanel_Grid[1], theselecteditem, 2) ~= "Tutorial" then
						triggerServerEvent("setPlayerRegisterStatus",getLocalPlayer(),guiGridListGetItemText ( AdminUserPanel_Grid[1], theselecteditem, 1),0)
						--guiGridListSetItemText ( AdminUserPanel_Grid[1], theselecteditem, 2, "Deaktiviert")
					end
				end
			end
			if source == AdminUserPanel_Button[3] then -- Button Job
				local theselecteditem = guiGridListGetSelectedItem(AdminUserPanel_Grid[1])
				if theselecteditem ~= -1 then
					guiSetVisible(AdminPlayerJob_Window[1], true)
					guiBringToFront(AdminPlayerJob_Window[1])
				end
			end
			if source == AdminUserPanel_Button[4] then -- Button Rang
				local theselecteditem = guiGridListGetSelectedItem(AdminUserPanel_Grid[1])
				if theselecteditem ~= -1 then
					guiSetVisible(AdminPlayerRang_Window[1],true)
					guiBringToFront(AdminPlayerRang_Window[1])
				end
			end
			if source == AdminUserPanel_Button[5] then
				local theselecteditem = guiGridListGetSelectedItem(AdminUserPanel_Grid[1])
				if theselecteditem ~= -1 then
					if guiGridListGetItemText ( AdminUserPanel_Grid[1], theselecteditem, 2) == "Freigeschaltet" then
						triggerServerEvent("setPlayerRegisterStatus",getLocalPlayer(), guiGridListGetItemText ( AdminUserPanel_Grid[1], theselecteditem, 1),1)
					end
				end
			end
			if source == AdminUserPanel_Button[7] then
				local theselecteditem = guiGridListGetSelectedItem(AdminUserPanel_Grid[1])
				if theselecteditem ~= -1 then
					showMessageBox("Spieler loeschen?", "Soll dieser Spieler wirklich geloescht werden?")
					g_MessageBoxGUI = "deletePlayer"
				end
			end
			if source == AdminUserPanel_Button[8] then
				if g_FreeMode == true then
					guiSetText(AdminUserPanel_Button[8],"Freier Modus AN")
					triggerServerEvent("toggleFreemode", getLocalPlayer(), getLocalPlayer(), false)
					addNotification(2, 0, 255, 0, "Freier Modus wurde deaktiviert!")
					g_FreeMode = false
				else
					guiSetText(AdminUserPanel_Button[8],"Freier Modus AUS")
					triggerServerEvent("toggleFreemode", getLocalPlayer(), getLocalPlayer(), true)
					addNotification(2, 0, 255, 0, "Freier Modus wurde aktiviert!")
					g_FreeMode = true
				end
			end
			if source == AdminUserPanel_Button[6] then
				local theselecteditem = guiGridListGetSelectedItem(AdminUserPanel_Grid[1])
				if theselecteditem ~= -1 then
					--triggerServerEvent("setRPGPlayerRights",getLocalPlayer(),getLocalPlayer(), guiGridListGetItemText ( AdminUserPanel_Grid[1], theselecteditem, 1), tostring(guiGetText(AdminUserPanel_Edit[1])))
					if tonumber(getElementData(getLocalPlayer(), "getPlayerSpecialRights")) >= 1 then --== 2 then
						--triggerServerEvent("setPlayerUserFileData", getLocalPlayer(), guiGridListGetItemText ( AdminUserPanel_Grid[1], theselecteditem, 1), "admin", tonumber(guiGetText(AdminUserPanel_Edit[1])))
						guiSetVisible(AdminPlayerRight_Window[1],true)
						guiBringToFront(AdminPlayerRight_Window[1])
					end
				end
			end
			
			--Job Window
			if source == AdminPlayerJob_Button[1] then --Schliessen Button
				guiSetVisible(AdminPlayerJob_Window[1], false)
				guiBringToFront(AdminUserPanel_Window[1])
			end
			if source == AdminPlayerJob_Button[2] then --Ok Button
				local theselecteditem = guiGridListGetSelectedItem(AdminPlayerJob_Grid[1])
				local row = guiGridListGetSelectedItem(AdminUserPanel_Grid[1])
				if theselecteditem ~= -1 then
					local selectedjobname = guiGridListGetItemText ( AdminPlayerJob_Grid[1], theselecteditem, 1)
					if string.len(selectedjobname) ~= 0 then
						local jobid = 0
						if selectedjobname == "Arbeitslos" then
							jobid = 0
						elseif selectedjobname == "Autoverkaeufer" then
							jobid = 1
						elseif selectedjobname == "LKW-Fahrer" then
							jobid = 2
						elseif selectedjobname == "Polizist" then
							jobid = 3
						elseif selectedjobname == "Autofix Mechaniker" then
							jobid = 4
						elseif selectedjobname == "Gebrauchtwagenhandler" then
							jobid = 5
						elseif selectedjobname == "Beamter" then
							jobid = 6
						elseif selectedjobname == "Sanitaeter" then
							jobid = 7					
						elseif selectedjobname == "Feuerwehrmann" then
							jobid = 8		
						elseif selectedjobname == "Reporter" then
							jobid = 9
						end						
						local key = "job"
						triggerServerEvent("setPlayerUserFileData", getLocalPlayer(), guiGridListGetItemText ( AdminUserPanel_Grid[1], guiGridListGetSelectedItem(AdminUserPanel_Grid[1]), 1), key, jobid)
						guiSetVisible(AdminPlayerJob_Window[1], false)
						guiGridListSetItemText ( AdminUserPanel_Grid[1], row, 9, selectedjobname, false, false )
					end
				end
			end
			if source == AdminPlayerRang_Button[1] then -- Schliessen Button
				guiSetVisible(AdminPlayerRang_Window[1],false)
				guiBringToFront(AdminUserPanel_Window[1])
			end
			if source == AdminPlayerRang_Button[2] then -- OK Button
				local theselecteditem = guiGridListGetSelectedItem(AdminPlayerRang_Grid[1])
				local row = guiGridListGetSelectedItem(AdminUserPanel_Grid[1])
				if theselecteditem ~= -1 then
					local selectedrangname = guiGridListGetItemText ( AdminPlayerRang_Grid[1], theselecteditem, 1)
					if string.len(selectedrangname) ~= 0 then
						local rangid = 0
						if selectedrangname == "Auszubildender" then
							rangid = 0
						elseif selectedrangname == "Mitarbeiter" then
							rangid = 1
						elseif selectedrangname == "Chef" then
							rangid = 2
						end
						local key = "rank"
						triggerServerEvent("setPlayerUserFileData", getLocalPlayer(), guiGridListGetItemText ( AdminUserPanel_Grid[1], guiGridListGetSelectedItem(AdminUserPanel_Grid[1]), 1), key, rangid)
						guiSetVisible(AdminPlayerRang_Window[1], false)
						guiBringToFront(AdminUserPanel_Window[1])
						guiGridListSetItemText ( AdminUserPanel_Grid[1], row, 10, selectedrangname, false, false )
					end
				end
			end
			if source == AdminPlayerRight_Button[1] then -- Schliessen Button
				guiSetVisible(AdminPlayerRight_Window[1],false)
				guiBringToFront(AdminUserPanel_Window[1])
			end
			if source == AdminPlayerRight_Button[2] then -- OK Button
				local theselecteditem = guiGridListGetSelectedItem(AdminPlayerRight_Grid[1])
				local row = guiGridListGetSelectedItem(AdminUserPanel_Grid[1])
				if theselecteditem ~= -1 then
					local selectedrightname = guiGridListGetItemText ( AdminPlayerRight_Grid[1], theselecteditem, 1)
					if string.len(selectedrightname) ~= 0 then
						local rightid = 0
						if selectedrightname == "Benutzer" then
							rightid = 0
						elseif selectedrightname == "Supporter" then
							rightid = 0.5
						elseif selectedrightname == "Moderator" then
							rightid = 1
						elseif selectedrightname == "Administrator" then
							rightid = 2
						end
						local key = "admin"
						triggerServerEvent("setPlayerUserFileData", getLocalPlayer(), guiGridListGetItemText ( AdminUserPanel_Grid[1], guiGridListGetSelectedItem(AdminUserPanel_Grid[1]), 1), key, rightid)
						guiGridListSetItemText ( AdminUserPanel_Grid[1], row, 6, selectedrightname, false, false )
						guiSetVisible(AdminPlayerRight_Window[1], false)
						guiBringToFront(AdminUserPanel_Window[1])
					end
				end
			end
			if source == MessageBox_Button[1] then -- Nein Button
				guiSetVisible(MessageBox_Window[1],false)
				guiBringToFront(AdminUserPanel_Window[1])
			end
			if source == MessageBox_Button[2] then -- Ja Button
				if g_MessageBoxGUI == "deletePlayer" then
					local theselecteditem = guiGridListGetSelectedItem(AdminUserPanel_Grid[1])
					if theselecteditem ~= -1 then
						triggerServerEvent("loescheRPGPlayer",getLocalPlayer(), guiGridListGetItemText ( AdminUserPanel_Grid[1], theselecteditem, 1))
						guiSetVisible(MessageBox_Window[1],false)
						guiBringToFront(AdminUserPanel_Window[1])
					end
				end
				if g_MessageBoxGUI == "deleteVehicle" then
					local theselecteditem = guiGridListGetSelectedItem(AdminVehiclePanel_Grid[1])
					if theselecteditem ~= -1 then
						triggerServerEvent("doDestroyTheRPGVehicle", getLocalPlayer(), getLocalPlayer(), guiGridListGetItemText ( AdminVehiclePanel_Grid[1], theselecteditem, 1), guiGridListGetItemText ( AdminVehiclePanel_Grid[1], theselecteditem, 3))
						guiSetVisible(MessageBox_Window[1],false)
						guiBringToFront(AdminUserPanel_Window[1])
						setTimer(doRefreshTheADMVehicleList,200,1)
					end
				end
			end
		end
	end
)
addEventHandler("onClientGUIDoubleClick", getRootElement(),
	function(btn)
		if btn == "left" then
			if source == AdminVehicleChoosePanel_Grid[1] then
				local theselecteditem = guiGridListGetSelectedItem(AdminVehicleChoosePanel_Grid[1])
				if theselecteditem ~= -1 then
					if choosenbutton == 1 then
						local vehicleid = guiGridListGetItemText ( AdminVehiclePanel_Grid[1], thechoooosenvehicle, 1)
						local username = guiGridListGetItemText ( AdminVehicleChoosePanel_Grid[1], theselecteditem, 1)
						triggerServerEvent("changeTheVehiclesOwVeroRKeys", getLocalPlayer(), vehicleid, username,1)
						guiSetVisible(AdminVehicleChoosePanel_Grid[1],false)
						setTimer(doRefreshTheADMVehicleList,200,1)
					end
					if choosenbutton == 2 then
						local vehicleid = guiGridListGetItemText ( AdminVehiclePanel_Grid[1], thechoooosenvehicle, 1)
						local username = guiGridListGetItemText ( AdminVehicleChoosePanel_Grid[1], theselecteditem, 1)
						triggerServerEvent("changeTheVehiclesOwVeroRKeys", getLocalPlayer(), vehicleid, username,2)
						guiSetVisible(AdminVehicleChoosePanel_Grid[1],false)
						setTimer(doRefreshTheADMVehicleList,200,1)
					end
				else
					guiSetVisible(AdminVehicleChoosePanel_Grid[1],false)
				end
			end
			if source == AdminPlayerJob_Grid[1] then
				local theselecteditem = guiGridListGetSelectedItem(AdminPlayerJob_Grid[1])
				local row = guiGridListGetSelectedItem(AdminUserPanel_Grid[1])
				if theselecteditem ~= -1 then
					local selectedjobname = guiGridListGetItemText ( AdminPlayerJob_Grid[1], theselecteditem, 1)
					if string.len(selectedjobname) ~= 0 then
						local jobid = 0
						if selectedjobname == "Arbeitslos" then
							jobid = 0
						elseif selectedjobname == "Autoverkaeufer" then
							jobid = 1
						elseif selectedjobname == "LKW-Fahrer" then
							jobid = 2
						elseif selectedjobname == "Polizist" then
							jobid = 3
						elseif selectedjobname == "Autofix Mechaniker" then
							jobid = 4
						elseif selectedjobname == "Autohus" then
							jobid = 5
						elseif selectedjobname == "Beamter" then
							jobid = 6
						elseif selectedjobname == "Sanitaeter" then
							jobid = 7
						elseif selectedjobname == "Feuerwehrmann" then
							jobid = 8	
						elseif selectedjobname == "Reporter" then
							jobid = 9			
						elseif selectedjobname == "Fahrlehrer" then
							jobid = 10
						elseif selectedjobname == "car4you" then
							jobid = 11
						end					
						local key = "job"
						triggerServerEvent("setPlayerUserFileData", getLocalPlayer(), guiGridListGetItemText ( AdminUserPanel_Grid[1], guiGridListGetSelectedItem(AdminUserPanel_Grid[1]), 1), key, jobid)
						guiSetVisible(AdminPlayerJob_Window[1], false)
						guiBringToFront(AdminUserPanel_Window[1])
						guiGridListSetItemText ( AdminUserPanel_Grid[1], row, 9, selectedjobname, false, false )
					end
				end
			end
			if source == AdminPlayerRang_Grid[1] then
				local theselecteditem = guiGridListGetSelectedItem(AdminPlayerRang_Grid[1])
				local row = guiGridListGetSelectedItem(AdminUserPanel_Grid[1])
				if theselecteditem ~= -1 then
					local selectedrangname = guiGridListGetItemText ( AdminPlayerRang_Grid[1], theselecteditem, 1)
					if string.len(selectedrangname) ~= 0 then
						local rangid = 0
						if selectedrangname == "Auszubildender" then
							rangid = 0
						elseif selectedrangname == "Mitarbeiter" then
							rangid = 1
						elseif selectedrangname == "Chef" then
							rangid = 2
						end
						local key = "rank"
						triggerServerEvent("setPlayerUserFileData", getLocalPlayer(), guiGridListGetItemText ( AdminUserPanel_Grid[1], guiGridListGetSelectedItem(AdminUserPanel_Grid[1]), 1), key, rangid)
						guiSetVisible(AdminPlayerRang_Window[1], false)
						guiBringToFront(AdminUserPanel_Window[1])
						guiGridListSetItemText ( AdminUserPanel_Grid[1], row, 10, selectedrangname, false, false )
					end
				end
			end
			if source == AdminPlayerRight_Grid[1] then
				local theselecteditem = guiGridListGetSelectedItem(AdminPlayerRight_Grid[1])
				local row = guiGridListGetSelectedItem(AdminUserPanel_Grid[1])
				if theselecteditem ~= -1 then
					local selectedrightname = guiGridListGetItemText ( AdminPlayerRight_Grid[1], theselecteditem, 1)
					if string.len(selectedrightname) ~= 0 then
						local rightid = 0
						if selectedrightname == "Benutzer" then
							rightid = 0
						elseif selectedrightname == "Supporter" then
							rightid = 0.5
						elseif selectedrightname == "Moderator" then
							rightid = 1
						elseif selectedrightname == "Administrator" then
							rightid = 2
						end
						local key = "admin"
						triggerServerEvent("setPlayerUserFileData", getLocalPlayer(), guiGridListGetItemText ( AdminUserPanel_Grid[1], guiGridListGetSelectedItem(AdminUserPanel_Grid[1]), 1), key, rightid)
						guiGridListSetItemText ( AdminUserPanel_Grid[1], row, 6, selectedrightname, false, false )
						guiSetVisible(AdminPlayerRight_Window[1], false)
						guiBringToFront(AdminUserPanel_Window[1])
					end
				end
			end
		end
	end
)
function doRefreshTheADMVehicleList()
	guiGridListClear(AdminVehiclePanel_Grid[1])
	destroyElement(AdminVehiclePanel_Grid[1])
	AdminVehiclePanel_Grid[1] = guiCreateGridList(0.045,0.04,0.91,0.7,true,AdminUserPanel_Tab[2])
	guiGridListSetSelectionMode(AdminVehiclePanel_Grid[1],1)
	guiGridListAddColumn(AdminVehiclePanel_Grid[1],"ID",0.1)
	guiGridListAddColumn(AdminVehiclePanel_Grid[1],"Fahrzeug",0.2)
	guiGridListAddColumn(AdminVehiclePanel_Grid[1],"Besitzer",0.2)
	guiGridListAddColumn(AdminVehiclePanel_Grid[1],"Schluessel Besitzer",0.2)
	guiGridListAddColumn(AdminVehiclePanel_Grid[1],"Panne",0.1)
	guiGridListAddColumn(AdminVehiclePanel_Grid[1],"Tuer Status",0.2)
	guiGridListAddColumn(AdminVehiclePanel_Grid[1],"Motor Status",0.1)
	guiGridListAddColumn(AdminVehiclePanel_Grid[1],"Fahrzeug Status", 0.2)
	for d, veh in ipairs(getElementsByType("vehicle")) do
		if veh then
			local row = guiGridListAddRow (AdminVehiclePanel_Grid[1] )
			local panne,locked,enginestate,vehiclestatus
			if getElementData(veh, "panne") == true then
				panne = "Ja"
			else
				panne = "Nein"
			end
			if isVehicleLocked(veh) then
				locked = "Abgeschlossen"
			else
				locked = "Aufgeschlossen"
			end
			if getElementData(veh, "motor") == true then
				enginestate = "An"
			else
				enginestate = "Aus"
			end
			if getElementData(veh, "isVehicleTemp") == true then
				vehiclestatus = "Temporaer"
			else
				vehiclestatus = "Permanent"
			end
			guiGridListSetItemText ( AdminVehiclePanel_Grid[1], row, 1, tostring(d), false, false )
			guiGridListSetItemText ( AdminVehiclePanel_Grid[1], row, 2, tostring(getVehicleName(veh)).." ("..tostring(getElementModel(veh))..")", false, false )
			guiGridListSetItemText ( AdminVehiclePanel_Grid[1], row, 3, tostring(getElementData(veh, "owner")), false, false )
			guiGridListSetItemText ( AdminVehiclePanel_Grid[1], row, 4, tostring(getElementData(veh, "keys")), false, false )
			guiGridListSetItemText ( AdminVehiclePanel_Grid[1], row, 5, panne, false, false )
			guiGridListSetItemText ( AdminVehiclePanel_Grid[1], row, 6, locked, false, false )
			guiGridListSetItemText ( AdminVehiclePanel_Grid[1], row, 7, enginestate, false, false )
			guiGridListSetItemText ( AdminVehiclePanel_Grid[1], row, 8, vehiclestatus, false, false )
		end
	end
end

function doRefreshTheADMVehicleList2()
	guiGridListClear(AdminVehiclePanel_Grid[2])
	destroyElement(AdminVehiclePanel_Grid[2])
	AdminVehiclePanel_Grid[2] = guiCreateGridList(0.045,0.04,0.91,0.7,true,AdminUserPanel_Tab[3])
	guiGridListSetSelectionMode(AdminVehiclePanel_Grid[2],1)
	guiGridListAddColumn(AdminVehiclePanel_Grid[2],"ID",0.1)
	guiGridListAddColumn(AdminVehiclePanel_Grid[2],"Fahrzeug",0.2)
	guiGridListAddColumn(AdminVehiclePanel_Grid[2],"Besitzer",0.2)
	guiGridListAddColumn(AdminVehiclePanel_Grid[2],"Schluessel Besitzer",0.2)
	guiGridListAddColumn(AdminVehiclePanel_Grid[2],"Panne",0.1)	
	for d, veh in ipairs(getElementsByType("fakeVehicle")) do
		if veh then
			local row = guiGridListAddRow (AdminVehiclePanel_Grid[2] )
			local panne,locked,enginestate,vehiclestatus
			if getElementData(veh, "panne") == true then
				panne = "Ja"
			else
				panne = "Nein"
			end
			--[[if getElementData(veh, "isVehicleTemp") == true then
				vehiclestatus = "Temporaer"
			else
				vehiclestatus = "Permanent"
			end--]]
			guiGridListSetItemText ( AdminVehiclePanel_Grid[2], row, 1, tostring(d), false, false )
			guiGridListSetItemText ( AdminVehiclePanel_Grid[2], row, 2, tostring(getVehicleNameFromModel(getElementData(veh, "model"))).." ("..tostring(getElementData(veh, "model"))..")", false, false )
			guiGridListSetItemText ( AdminVehiclePanel_Grid[2], row, 3, tostring(getElementData(veh, "owner")), false, false )
			guiGridListSetItemText ( AdminVehiclePanel_Grid[2], row, 4, tostring(getElementData(veh, "keys")), false, false )
			guiGridListSetItemText ( AdminVehiclePanel_Grid[2], row, 5, panne, false, false )
		end
	end
end

function doRefreshSupportList()
	guiGridListClear(AdminVehiclePanel_Grid[3])
	destroyElement(AdminVehiclePanel_Grid[3])
	AdminVehiclePanel_Grid[3] = guiCreateGridList(0.045,0.04,0.91,0.7,true,AdminUserPanel_Tab[4])
	guiGridListSetSelectionMode(AdminVehiclePanel_Grid[3],1)
	guiGridListAddColumn(AdminVehiclePanel_Grid[3],"ID",0.1)
	guiGridListAddColumn(AdminVehiclePanel_Grid[3],"Spieler",0.2)
	guiGridListAddColumn(AdminVehiclePanel_Grid[3],"Letzte Nachricht",0.5)
	theReportACPnum = 0
	theReportSelected = false
	guiSetText(theReportLabel, "Kein Report ausgewählt")
	for i, v in ipairs(getElementsByType("report")) do
		if v then
			local row = guiGridListAddRow (AdminVehiclePanel_Grid[3] )
			local tab = getElementData(v,"table")
			local message = tab[#tab]
			guiGridListSetItemText ( AdminVehiclePanel_Grid[3], row, 1, tostring(i), false, false )
			guiGridListSetItemText ( AdminVehiclePanel_Grid[3], row, 2, tostring(getElementData(v, "name")), false, false )
			guiGridListSetItemText ( AdminVehiclePanel_Grid[3], row, 3, message, false, false )
		end
	end
end

addEvent("onRPGPlayerVehicleList",true)
addEventHandler("onRPGPlayerVehicleList", getLocalPlayer(),
	function(data)
		guiGridListClear(AdminVehicleChoosePanel_Grid[1])
		for i = #data,1,-1 do
			local row = guiGridListAddRow ( AdminVehicleChoosePanel_Grid[1] )
			guiGridListSetItemText ( AdminVehicleChoosePanel_Grid[1], row, 1, data[i].name, false, false )
		end
	end
)

addEvent("aircars", true)
addEventHandler("aircars", getLocalPlayer(), 
	function(state)
		setWorldSpecialPropertyEnabled("aircars", state)
	end
)