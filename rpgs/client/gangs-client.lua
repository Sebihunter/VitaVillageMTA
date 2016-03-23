--[[
Project: VitaOnline
File: gangs-client.lua
Author(s):	Sebihunter
]]--

GangGUI_Window = {}
GangGUI_TabPanel = {}
GangGUI_Tab = {}
GangGUI_Button = {}
GangGUI_Memo = {}
GangGUI_Label = {}
GangGUI_Edit = {}
GangGUI_Grid = {}

GangGUI_Window[1] = guiCreateWindow(screenWidth/2-802/2,screenHeight/2-441/2,802,441,"Ganguebersicht",false)
guiWindowSetSizable(GangGUI_Window[1],false)
GangGUI_TabPanel[1] = guiCreateTabPanel(9,21,784,382,false,GangGUI_Window[1])
GangGUI_Tab[1] = guiCreateTab("Mitglieder",GangGUI_TabPanel[1])

GangGUI_Grid[1] = guiCreateGridList(6,6,645,346,false,GangGUI_Tab[1])
guiGridListAddColumn(GangGUI_Grid[1],"Name",0.2)
guiGridListAddColumn(GangGUI_Grid[1],"Rang",0.2)

GangGUI_Button[1] = guiCreateButton(659,258,113,20,"Kicken",false,GangGUI_Tab[1])
GangGUI_Button[2] = guiCreateButton(659,172,113,20,"Befoerdern",false,GangGUI_Tab[1])
GangGUI_Button[3] = guiCreateButton(659,92,113,20,"Rekrutieren",false,GangGUI_Tab[1])
GangGUI_Edit[1] = guiCreateEdit(656,55,118,24,"Spielername...",false,GangGUI_Tab[1])
GangGUI_Label[1] = guiCreateLabel(655,116,126,37,"Fehler: Spieler nicht gefunden",false,GangGUI_Tab[1])
guiLabelSetColor(GangGUI_Label[1],255,0,0)
GangGUI_Button[4] = guiCreateButton(659,205,113,20,"Degradieren",false,GangGUI_Tab[1])

GangGUI_Tab[3] = guiCreateTab("Fahrzeuge",GangGUI_TabPanel[1])
GangGUI_Grid[3] = guiCreateGridList(6,6,645,346,false,GangGUI_Tab[3])
guiGridListAddColumn(GangGUI_Grid[3],"Fahrzeugname",0.2)
guiGridListAddColumn(GangGUI_Grid[3],"Besitzer",0.2)
guiGridListAddColumn(GangGUI_Grid[3],"Schluesselbesitzer",0.2)
guiGridListAddColumn(GangGUI_Grid[3],"KM",0.18)
guiGridListAddColumn(GangGUI_Grid[3],"TÜV",0.1)
guiGridListAddColumn(GangGUI_Grid[3],"Panne",0.1)

GangGUI_Button[6] = guiCreateButton(660,187,115,25,"Schluesselbesitzer",false,GangGUI_Tab[3])
GangGUI_Edit[3] = guiCreateEdit(659,144,114,25,"Spielername...",false,GangGUI_Tab[3])
GangGUI_Label[2] = guiCreateLabel(660,225,114,36,"Fehler: Spieler nicht gefunden",false,GangGUI_Tab[3])
guiLabelSetColor(GangGUI_Label[2],255,0,0)
GangGUI_Tab[4] = guiCreateTab("Notizen",GangGUI_TabPanel[1])
GangGUI_Memo[1] = guiCreateMemo(7,7,770,342,"This is SPARTAAAAAAAAA!!!!",false,GangGUI_Tab[4])
GangGUI_Button[7] = guiCreateButton(346,410,131,21,"Schliessen",false,GangGUI_Window[1])
guiSetVisible( GangGUI_Window[1], false)
guiSetVisible( GangGUI_Label[1], false)
guiSetVisible( GangGUI_Label[2], false)

local hasNotes = false

function showGang()
	if not getElementData(getLocalPlayer(), "isPlayerLoggedIn") == true then return end
	if not getElementData(getLocalPlayer(), "isWaitingForDeath") == false then return end
	if getElementData(getLocalPlayer(), "gang") == 0 then return end
	
	if guiGetVisible(GangGUI_Window[1]) == true then
		closeGang()
	else
		guiSetEnabled ( GangGUI_Button[1], false )
		guiSetEnabled ( GangGUI_Button[2], false )
		guiSetEnabled ( GangGUI_Button[3], false )
		guiSetEnabled ( GangGUI_Button[4], false )
		guiSetEnabled ( GangGUI_Button[6], false )
		guiSetEnabled ( GangGUI_Edit[1], false )
		guiSetEnabled ( GangGUI_Edit[3], false )
		if getElementData(getLocalPlayer(), "gangrank") == 2 then
			guiSetEnabled ( GangGUI_Button[1], true )
			guiSetEnabled ( GangGUI_Button[2], true )
			guiSetEnabled ( GangGUI_Button[3], true )
			guiSetEnabled ( GangGUI_Button[4], true )
			guiSetEnabled ( GangGUI_Button[6], true )
			guiSetEnabled ( GangGUI_Edit[1], true )
			guiSetEnabled ( GangGUI_Edit[3], true )
		end	
	
		refreshGangGridLists()
		guiSetVisible( GangGUI_Window[1], true)
		showCursor(true)
		guiSetInputEnabled ( true )
		callServerFunction("sendGangNoteToPlayer", getLocalPlayer())
		
		showTutorialMessage("gang_1", "Dieses Menü ermöglicht dir als Gangschef deine Fahrzeuge und Mitglieder zu organisieren.")
		showTutorialMessage("gang_2", "Die vom Gangchef festgelegte Notiz kann dir nützliche Informationen liefern.")
		
		hasNotes = false
	end
end
bindKey ( "z", "down", showGang )

function recieveGangNote(text)
	guiSetText(GangGUI_Memo[1], text)
	if getElementData(getLocalPlayer(), "gangrank") == 2 then
		guiMemoSetReadOnly( GangGUI_Memo[1], false)
	else
		guiMemoSetReadOnly( GangGUI_Memo[1], true)
	end	
	hasNotes = true
end

function closeGang()
	guiSetInputEnabled ( false )
	guiSetVisible( GangGUI_Window[1], false)
	showCursor(false)
	if getElementData(getLocalPlayer(), "gangrank") == 2 and hasNotes == true then
		callServerFunction("saveGangNote", getLocalPlayer(), guiGetText(GangGUI_Memo[1]))
	end
end
addEventHandler ( "onClientGUIClick", GangGUI_Button[7], closeGang, false )

function addToGang()
	if getElementData(getLocalPlayer(), "gangrank") == 2 then
		callServerFunction("addToGang", getLocalPlayer(), "aufingang", tostring(guiGetText(GangGUI_Edit[1])))
		refreshGangGridLists()
	end	
end
addEventHandler ( "onClientGUIClick", GangGUI_Button[3], addToGang, false )

function kickFromGang()
	if getElementData(getLocalPlayer(), "gangrank") == 2 then
		local selectedRow, selectedCol = guiGridListGetSelectedItem( GangGUI_Grid[1] )
		local name = guiGridListGetItemText ( GangGUI_Grid[1], selectedRow, 1 )
		if selectedRow ~= -1 then
			callServerFunction("kickFromGang", getLocalPlayer(), "rausausgang", tostring(name))
		end	
		refreshGangGridLists()
	end	
end
addEventHandler ( "onClientGUIClick", GangGUI_Button[1], kickFromGang, false )
 
function increaseRank()
	if getElementData(getLocalPlayer(), "gangrank") == 2 then
		local selectedRow, selectedCol = guiGridListGetSelectedItem( GangGUI_Grid[1] )
		local name = guiGridListGetItemText ( GangGUI_Grid[1], selectedRow, 1 )
		local rank = guiGridListGetItemText ( GangGUI_Grid[1], selectedRow, 2 )
		if selectedRow ~= -1 then
			if tonumber(rank)+1 < 3 then
				callServerFunction("setPlayerUserFileData", name, "gangrank", tonumber(rank)+1)
			end
		end
		refreshGangGridLists()
	end
end
addEventHandler ( "onClientGUIClick", GangGUI_Button[2], increaseRank, false )

function decreaseRank()
	if getElementData(getLocalPlayer(), "gangrank") == 2 then
		local selectedRow, selectedCol = guiGridListGetSelectedItem( GangGUI_Grid[1] )
		local name = guiGridListGetItemText ( GangGUI_Grid[1], selectedRow, 1 )
		local rank = guiGridListGetItemText ( GangGUI_Grid[1], selectedRow, 2 )
		if selectedRow ~= -1 then
			if tonumber(rank)-1 > -1 then
				callServerFunction("setPlayerUserFileData", name, "gangrank", tonumber(rank)-1)
			end
		end
		refreshGangGridLists()
	end
end
addEventHandler ( "onClientGUIClick", GangGUI_Button[4], decreaseRank, false )


function setBesitzerGang()
	if getElementData(getLocalPlayer(), "gangrank") == 2 then
		local selectedRow, selectedCol = guiGridListGetSelectedItem( GangGUI_Grid[3] )
		local vehicle = guiGridListGetItemData (GangGUI_Grid[3], selectedRow, 1 )
		local name = guiGridListGetItemText ( GangGUI_Grid[3], selectedRow, 1 )
		local keys = guiGridListGetItemText ( GangGUI_Grid[3], selectedRow, 3 )
		
		if vehicle and isElement(vehicle) then		
			setElementData(vehicle, "keys", guiGetText(GangGUI_Edit[3]))
			addNotification(2, 0, 255, 0, "Schlüssel des Fahrzeugs erfolgreich geändert:\n"..guiGetText(GangGUI_Edit[3]))
		end	
		refreshGangGridLists()
	end
end
addEventHandler ( "onClientGUIClick", GangGUI_Button[6], setBesitzerGang, false )

function refreshGangGridLists()
	guiGridListClear ( GangGUI_Grid[1] )
	guiGridListClear ( GangGUI_Grid[3] )
	destroyElement (  GangGUI_Grid[1] )
	destroyElement (  GangGUI_Grid[3] )
	
	GangGUI_Grid[1] = guiCreateGridList(6,6,645,346,false,GangGUI_Tab[1])
	guiGridListAddColumn(GangGUI_Grid[1],"Name",0.2)
	guiGridListAddColumn(GangGUI_Grid[1],"Rang",0.2)
	
	GangGUI_Grid[3] = guiCreateGridList(6,6,645,346,false,GangGUI_Tab[3])
	guiGridListAddColumn(GangGUI_Grid[3],"Fahrzeugname",0.2)
	guiGridListAddColumn(GangGUI_Grid[3],"Besitzer",0.2)
	guiGridListAddColumn(GangGUI_Grid[3],"Schluesselbesitzer",0.1)
	guiGridListAddColumn(GangGUI_Grid[3],"KM",0.18)
	guiGridListAddColumn(GangGUI_Grid[3],"TÜV",0.1)	
	guiGridListAddColumn(GangGUI_Grid[3],"Panne",0.1)	
	
	callServerFunction("getGangPlayers", getLocalPlayer())
	
	for _, vehicle in ipairs(getElementsByType("vehicle")) do
		if getElementData(vehicle, "owner") == "g"..tostring(getElementData(getLocalPlayer(), "gang")) then
			local row = guiGridListAddRow(GangGUI_Grid[3])
			guiGridListSetItemText ( GangGUI_Grid[3], row, 1, getVehicleNameFromModel ( getElementData(vehicle, "model") ), false, false )
			guiGridListSetItemText ( GangGUI_Grid[3], row, 2, getElementData(vehicle, "owner"), false, false )	
			guiGridListSetItemText ( GangGUI_Grid[3], row, 3, getElementData(vehicle, "keys"), false, false )	
			guiGridListSetItemData ( GangGUI_Grid[3], row, 1, vehicle )
			local km
			if getElementData(vehicle, "km") == nil or getElementData(vehicle, "km") == false or getElementData(vehicle, "km") == "false" or getElementData(vehicle, "km") == "nil" then
				km = 0
			else
				km = tonumber(getElementData(vehicle, "km"))
			end
			guiGridListSetItemText ( GangGUI_Grid[3], row, 4, tostring(math.round(km,0,"round")), false, false )
			local ttage = getElementData(vehicle,"tuev")+14-getRealTime().yearday
			if ttage >= 0 then
				guiGridListSetItemText ( GangGUI_Grid[3], row, 5, "Ja ("..ttage..")", false, false )
			else
				guiGridListSetItemText ( GangGUI_Grid[3], row, 5, "Nein", false, false )
			end	
			
			if getElementData(vehicle, "panne") == true then
				guiGridListSetItemText ( GangGUI_Grid[3], row, 6, "Ja", false, false )
			else
				guiGridListSetItemText ( GangGUI_Grid[3], row, 6, "Nein", false, false )
			end
		end
	end	
end

function changeVehicleGrid(button, state)
	if source ~= GangGUI_Grid[3] then return end
	if button ~= "left" and state ~= "down" then return end
	if getElementData(getLocalPlayer(), "rank") == 2 then
		local selectedRow, selectedCol = guiGridListGetSelectedItem( GangGUI_Grid[3] )
		local name = guiGridListGetItemText ( GangGUI_Grid[3], selectedRow, 1 )
		local keys = guiGridListGetItemText ( GangGUI_Grid[3], selectedRow, 3 )	
		for _, vehicle in ipairs(getElementsByType("vehicle")) do
			if getElementData(vehicle, "owner") == "g"..tostring(getElementData(getLocalPlayer(), "gang")) then
				if getVehicleNameFromModel ( getElementData(vehicle, "model") ) == name then
					if getElementData(vehicle, "keys") == keys then
						guiSetText(GangGUI_Edit[3], keys)
						break
					end
				end
			end
		end
	end
end
addEventHandler( "onClientGUIClick", getRootElement(), changeVehicleGrid )


function recieveGangPlayers(data)
	for i = #data,1,-1 do
		if tonumber(data[i].gang) == getElementData(getLocalPlayer(), "gang") then
			local row = guiGridListAddRow ( GangGUI_Grid[1] )
			guiGridListSetItemText ( GangGUI_Grid[1], row, 1, tostring(data[i].name), false, false )
			guiGridListSetItemText ( GangGUI_Grid[1], row, 2, tostring(data[i].gangrank), false, false )
		end
	end
end