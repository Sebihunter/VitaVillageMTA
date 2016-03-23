--[[
Project: VitaOnline
File: firmen-client.lua
Author(s):	Sebihunter
]]--


-- STADTHALLE
Stadthalle_Window = {}
Stadthalle_Button = {}
Stadthalle_Label = {}
Stadthalle_Grid = {}
Stadthalle_GridRow = {}
Stadthalle_GridColumn = {}
Stadthalle_Label_Firmen = {}
Stadthalle_Label_Firmen2 = {}

Stadthalle_Window[1] = guiCreateWindow(screenWidth/2-306,screenHeight/2-328/2,306,328,"Stadthalle - Nebenjobs",false)
guiWindowSetSizable(Stadthalle_Window[1],false)
Stadthalle_Grid[1] = guiCreateGridList(48,64,211,212,false,Stadthalle_Window[1])
guiGridListSetSelectionMode(Stadthalle_Grid[1],1)
Stadthalle_GridColumn[1] = guiGridListAddColumn(Stadthalle_Grid[1],"Jobname",0.8)

Stadthalle_GridRow[1] = guiGridListAddRow(Stadthalle_Grid[1])
guiGridListSetItemText ( Stadthalle_Grid[1], Stadthalle_GridRow[1], Stadthalle_GridColumn[1], "Busfahrer", false, false )
Stadthalle_GridRow[2] = guiGridListAddRow(Stadthalle_Grid[1])
guiGridListSetItemText ( Stadthalle_Grid[1], Stadthalle_GridRow[2], Stadthalle_GridColumn[1], "Fischer", false, false )
Stadthalle_GridRow[3] = guiGridListAddRow(Stadthalle_Grid[1])
guiGridListSetItemText ( Stadthalle_Grid[1], Stadthalle_GridRow[3], Stadthalle_GridColumn[1], "Gärtner", false, false )
Stadthalle_GridRow[4] = guiGridListAddRow(Stadthalle_Grid[1])
guiGridListSetItemText ( Stadthalle_Grid[1], Stadthalle_GridRow[4], Stadthalle_GridColumn[1], "Pizzalieferant", false, false )
Stadthalle_GridRow[5] = guiGridListAddRow(Stadthalle_Grid[1])
guiGridListSetItemText ( Stadthalle_Grid[1], Stadthalle_GridRow[5], Stadthalle_GridColumn[1], "Taxifahrer", false, false )
Stadthalle_GridRow[6] = guiGridListAddRow(Stadthalle_Grid[1])
guiGridListSetItemText ( Stadthalle_Grid[1], Stadthalle_GridRow[6], Stadthalle_GridColumn[1], "Lieferant", false, false )
Stadthalle_GridRow[6] = guiGridListAddRow(Stadthalle_Grid[1])
guiGridListSetItemText ( Stadthalle_Grid[1], Stadthalle_GridRow[6], Stadthalle_GridColumn[1], "Stadtwerke (Putztrupp)", false, false )

Stadthalle_Label[1] = guiCreateLabel(13,23,287,20,"Du kannst dir Marker zu den Nebenjobs setzen.",false,Stadthalle_Window[1])
guiLabelSetColor(Stadthalle_Label[1],255,255,255)
guiLabelSetVerticalAlign(Stadthalle_Label[1],"top")
guiLabelSetHorizontalAlign(Stadthalle_Label[1],"left",false)
Stadthalle_Button[1] = guiCreateButton(9,294,109,26,"Schliessen",false,Stadthalle_Window[1])
Stadthalle_Button[2] = guiCreateButton(189,294,108,26,"Setze Marker",false,Stadthalle_Window[1])

Stadthalle_Window[2] = guiCreateWindow(screenWidth/2,screenHeight/2-328/2,306,328,"Stadthalle - Firmen",false)
Stadthalle_Label[2] = guiCreateLabel(13,23,287,300,"In diesem GUI siehst du alle Berufe die\nim Moment auf The Vita Village existieren.\n\nDu kannst dich bei Firmen,\nwelche gerade Mitarbeiter suchen\nbei uns im Forum (www.vita-online.eu) bewerben.",false,Stadthalle_Window[2])

for i = 1, #gJobData do
	Stadthalle_Label_Firmen2[#Stadthalle_Label_Firmen2+1] = guiCreateLabel(13,23+100+15*i,287,300,"SUCHT NICHT",false,Stadthalle_Window[2])
	guiLabelSetColor ( Stadthalle_Label_Firmen2[#Stadthalle_Label_Firmen2], 255,0,0 )
	Stadthalle_Label_Firmen[#Stadthalle_Label_Firmen+1] = guiCreateLabel(13+80,23+100+15*i,287,300,gJobData[i].name,false,Stadthalle_Window[2])
end

guiSetVisible(Stadthalle_Window[1],false)
guiSetVisible(Stadthalle_Window[2],false)

local minijobBlip = false
local minijobBlipTimer = false
function setFirmenMarker()
	local selectedRow, selectedCol = guiGridListGetSelectedItem( Stadthalle_Grid[1] )
	local itemtext = guiGridListGetItemText ( Stadthalle_Grid[1], selectedRow, selectedCol )
	if not itemtext then return end	
	
	if minijobBlip and isElement(minijobBlip) then destroyElement(minijobBlip) end
	if minijobBlipTimer and isTimer(minijobBlipTimer) then killTimer(minijobBlipTimer) end	
	local x,y,z = 0,0,0
	if itemtext == "Busfahrer" then
		x = 1047.5712890625
		y = 2395.5029296875	
	elseif itemtext == "Fischer" then
		x = -1686.5439453125
		y = 1451.197265625
	elseif itemtext == "Gärtner" then
		x = 1420.322265625
		y = 2797.498046875
	elseif itemtext == "Pizzalieferant" then
		x = 2290.26
		y = 2524.74
	elseif itemtext == "Taxifahrer" then
		x = 2455.794921875
		y = 1325.2998046875	
	elseif itemtext == "Lieferant" then
		x = 1051.328
		y = 2134.599
	elseif itemtext == "Stadtwerke (Putztrupp)" then
		x = 2408.965
		y = 1510.867
	end
	minijobBlip = createBlip ( x,y,z, 0, 5, 255 ,0, 0, 255, 0, 99999.0)
	minijobBlipTimer = setTimer(
		function(blip)
			destroyElement(blip)
		end
	,180000,1, minijobBlip)	
	addNotification(2, 0, 255, 0, "Dir wurde ein roter Marker auf die Karte (F11) gesetzt.\nAngezeigt für: 3 Minuten.")
	showCursor(false)
end
addEventHandler ( "onClientGUIClick", Stadthalle_Button[2], setFirmenMarker, false )



function showStadthalle()
	if not getElementData(getLocalPlayer(), "isPlayerLoggedIn") == true then return end
	if not getElementData(getLocalPlayer(), "isWaitingForDeath") == false then return end
	 callServerFunction("getFirmaBewerbungen", getLocalPlayer())
	guiSetVisible( Stadthalle_Window[2], true)
	guiSetVisible( Stadthalle_Window[1], true)
	showCursor(true)
	guiSetInputEnabled ( true )	
end

function closeStadthalle()
	guiSetInputEnabled ( false )
	guiSetVisible( Stadthalle_Window[2], false)
	guiSetVisible( Stadthalle_Window[1], false)
	showCursor(false)
end
addEventHandler ( "onClientGUIClick", Stadthalle_Button[1], closeStadthalle, false )

function receiveBewerbungen(tab)
	for i,v in ipairs(tab) do
		if Stadthalle_Label_Firmen2[i] then
			if v == "1" then
				guiSetText(Stadthalle_Label_Firmen2[i], "SUCHT")
				guiLabelSetColor ( Stadthalle_Label_Firmen2[i], 0,255,0 )				
			
			else
				guiSetText(Stadthalle_Label_Firmen2[i], "SUCHT NICHT")
				guiLabelSetColor ( Stadthalle_Label_Firmen2[i], 255,0,0 )				
			end
		end
	end
end
addEvent("receiveBewerbungen", true)
addEventHandler ( "receiveBewerbungen", getRootElement(), receiveBewerbungen)



--FIRMEN GUI

FirmenGUI_Window = {}
FirmenGUI_TabPanel = {}
FirmenGUI_Tab = {}
FirmenGUI_Button = {}
FirmenGUI_Checkbox = {}
FirmenGUI_Memo = {}
FirmenGUI_Label = {}
FirmenGUI_Edit = {}
FirmenGUI_Grid = {}

FirmenGUI_Window[1] = guiCreateWindow(screenWidth/2-802/2,screenHeight/2-441/2,802,441,"Firmenübersicht",false)
guiWindowSetSizable(FirmenGUI_Window[1],false)
FirmenGUI_TabPanel[1] = guiCreateTabPanel(9,21,784,382,false,FirmenGUI_Window[1])
FirmenGUI_Tab[1] = guiCreateTab("Mitarbeiter",FirmenGUI_TabPanel[1])

FirmenGUI_Grid[1] = guiCreateGridList(6,6,645,346,false,FirmenGUI_Tab[1])
guiGridListAddColumn(FirmenGUI_Grid[1],"Name",0.2)
guiGridListAddColumn(FirmenGUI_Grid[1],"Rang",0.05)
guiGridListAddColumn(FirmenGUI_Grid[1],"Dienstdauer",0.2)
guiGridListAddColumn(FirmenGUI_Grid[1],"Einnahmen",0.4)

FirmenGUI_Button[1] = guiCreateButton(659,258,113,20,"Entlassen",false,FirmenGUI_Tab[1])
FirmenGUI_Button[2] = guiCreateButton(659,172,113,20,"Befördern",false,FirmenGUI_Tab[1])
FirmenGUI_Button[3] = guiCreateButton(659,92,113,20,"Einstellen",false,FirmenGUI_Tab[1])
FirmenGUI_Edit[1] = guiCreateEdit(656,55,118,24,"Spielername...",false,FirmenGUI_Tab[1])
FirmenGUI_Label[1] = guiCreateLabel(655,116,126,37,"Fehler: Spieler nicht gefunden",false,FirmenGUI_Tab[1])
guiLabelSetColor(FirmenGUI_Label[1],255,0,0)
FirmenGUI_Button[4] = guiCreateButton(659,205,113,20,"Degradieren",false,FirmenGUI_Tab[1])
FirmenGUI_Button[9] = guiCreateButton(659,288,113,20,"Bewerbungsstatus",false,FirmenGUI_Tab[1])
FirmenGUI_Tab[2] = guiCreateTab("Löhne",FirmenGUI_TabPanel[1])

FirmenGUI_Grid[2] = guiCreateGridList(6,6,645,346,false,FirmenGUI_Tab[2])
guiGridListAddColumn(FirmenGUI_Grid[2],"Rang",0.2)
guiGridListAddColumn(FirmenGUI_Grid[2],"Verdienst",0.2)
guiGridListAddColumn(FirmenGUI_Grid[2],"Spielername",0.2)
guiGridListAddColumn(FirmenGUI_Grid[2],"Dienstdauer",0.2)
guiGridListAddColumn(FirmenGUI_Grid[2],"Einnahmen",0.2)

FirmenGUI_Button[5] = guiCreateButton(661,161,113,21,"Verdienst",false,FirmenGUI_Tab[2])
FirmenGUI_Edit[2] = guiCreateEdit(660,121,112,24,"Betrag...",false,FirmenGUI_Tab[2])
FirmenGUI_Tab[3] = guiCreateTab("Fahrzeuge",FirmenGUI_TabPanel[1])

FirmenGUI_Grid[3] = guiCreateGridList(6,6,645,346,false,FirmenGUI_Tab[3])
guiGridListAddColumn(FirmenGUI_Grid[3],"Fahrzeugname",0.2)
guiGridListAddColumn(FirmenGUI_Grid[3],"Besitzer",0.2)
guiGridListAddColumn(FirmenGUI_Grid[3],"Schlüsselbesitzer",0.2)
guiGridListAddColumn(FirmenGUI_Grid[3],"KM",0.18)
guiGridListAddColumn(FirmenGUI_Grid[3],"TÜV",0.1)
guiGridListAddColumn(FirmenGUI_Grid[3],"Panne",0.1)

FirmenGUI_Button[6] = guiCreateButton(660,187,115,25,"Schlüsselbesitzer",false,FirmenGUI_Tab[3])
FirmenGUI_Button[8] = guiCreateButton(660,217,115,25,"Rechnung/Tanken FK",false,FirmenGUI_Tab[3])
FirmenGUI_Edit[3] = guiCreateEdit(659,144,114,25,"Spielername...",false,FirmenGUI_Tab[3])
FirmenGUI_Label[2] = guiCreateLabel(660,225,114,36,"Fehler: Spieler nicht gefunden",false,FirmenGUI_Tab[3])
guiLabelSetColor(FirmenGUI_Label[2],255,0,0)
FirmenGUI_Tab[4] = guiCreateTab("Notizen",FirmenGUI_TabPanel[1])
FirmenGUI_Memo[1] = guiCreateMemo(7,7,770,342,"This is SPARTAAAAAAAAA!!!!",false,FirmenGUI_Tab[4])
FirmenGUI_Button[7] = guiCreateButton(346,410,131,21,"Schliessen",false,FirmenGUI_Window[1])
guiSetVisible( FirmenGUI_Window[1], false)
guiSetVisible( FirmenGUI_Label[1], false)
guiSetVisible( FirmenGUI_Label[2], false)

FirmenGUI_Tab[5] = guiCreateTab("Polizeiakte",FirmenGUI_TabPanel[1])
FirmenGUI_Grid[4] = guiCreateGridList(6,6,150,346,false,FirmenGUI_Tab[5])
FirmenGUI_Label[3] = guiCreateLabel(160,6,700,346,"",false,FirmenGUI_Tab[5])
guiGridListAddColumn(FirmenGUI_Grid[4],"Name",0.8)
FirmenGUI_Edit[4] = guiCreateEdit(160,297,150,25,"Aktenname...",false,FirmenGUI_Tab[5])
FirmenGUI_Edit[5] = guiCreateEdit(160,327,300,25,"Text/Eintrags ID",false,FirmenGUI_Tab[5])
FirmenGUI_Button[10] = guiCreateButton(315,297,150,25,"Neuer E. [Text]",false,FirmenGUI_Tab[5])
FirmenGUI_Button[11] = guiCreateButton(470,297,150,25,"E. Entfernen [ID]",false,FirmenGUI_Tab[5])
FirmenGUI_Button[12] = guiCreateButton(470,327,150,25,"A. Entfernen",false,FirmenGUI_Tab[5])
FirmenGUI_Button[13] = guiCreateButton(625,327,150,25,"Wanted Level [0-6]",false,FirmenGUI_Tab[5])
FirmenGUI_Checkbox[1] = guiCreateCheckBox ( 625, 300, 15,15, "",false, false, FirmenGUI_Tab[5] )
FirmenGUI_Label[4] = guiCreateLabel( 645, 300, 150,15,"Nur Online",false,FirmenGUI_Tab[5])

guiSetVisible( FirmenGUI_Tab[5], false)

addEventHandler ( "onClientGUIClick", FirmenGUI_Checkbox[1], function()
	refreshAkten()
end, false )



addEventHandler ( "onClientGUIClick", FirmenGUI_Button[10], function()
	executeServerCommandHandler("addakte", guiGetText(FirmenGUI_Edit[4]).." "..guiGetText(FirmenGUI_Edit[5]))
end, false )

addEventHandler ( "onClientGUIClick", FirmenGUI_Button[11], function()
	executeServerCommandHandler("removeeintrag", guiGetText(FirmenGUI_Edit[4]).." "..guiGetText(FirmenGUI_Edit[5]))
end, false )

addEventHandler ( "onClientGUIClick", FirmenGUI_Button[12], function()
	executeServerCommandHandler("removeakte", guiGetText(FirmenGUI_Edit[4]).." "..guiGetText(FirmenGUI_Edit[5]))
end, false )

addEventHandler ( "onClientGUIClick", FirmenGUI_Button[13], function()
	executeServerCommandHandler("wlevel", guiGetText(FirmenGUI_Edit[4]).." "..guiGetText(FirmenGUI_Edit[5]))
end, false )

function refreshAkten()
	guiGridListClear ( FirmenGUI_Grid[4] )
	local sel = guiCheckBoxGetSelected ( FirmenGUI_Checkbox[1] )
    local row = guiGridListAddRow ( FirmenGUI_Grid[4] )
	guiGridListSetItemText ( FirmenGUI_Grid[4], row, 1, "..", false, false )		
	for i,v in ipairs(getElementsByType("wanted")) do
		if sel == false or (sel == true and getPlayerFromName(getElementData(v, "name"))) then
			local row = guiGridListAddRow ( FirmenGUI_Grid[4] )
			guiGridListSetItemText ( FirmenGUI_Grid[4], row, 1, getElementData(v, "name"), false, false )
		end		
	end
end

local hasNotes = false
function showFirma()
	if not getElementData(getLocalPlayer(), "isPlayerLoggedIn") == true then return end
	if not getElementData(getLocalPlayer(), "isWaitingForDeath") == false then return end
	if getElementData(getLocalPlayer(), "job") == 0 then return end
	if guiGetVisible(FirmenGUI_Window[1]) == true then
		closeFirma()
	else
		guiSetVisible( FirmenGUI_Tab[5], false)
		guiSetEnabled ( FirmenGUI_Button[1], false )
		guiSetEnabled ( FirmenGUI_Button[2], false )
		guiSetEnabled ( FirmenGUI_Button[3], false )
		guiSetEnabled ( FirmenGUI_Button[4], false )
		guiSetEnabled ( FirmenGUI_Button[5], false )
		guiSetEnabled ( FirmenGUI_Button[6], false )
		guiSetEnabled ( FirmenGUI_Button[8], false )
		guiSetEnabled ( FirmenGUI_Button[9], false )
		guiSetEnabled ( FirmenGUI_Edit[1], false )
		guiSetEnabled ( FirmenGUI_Edit[2], false )
		guiSetEnabled ( FirmenGUI_Edit[3], false )
		if getElementData(getLocalPlayer(), "job") == 3 then --Polizei
			guiSetVisible( FirmenGUI_Tab[5], true)
			guiSetText(FirmenGUI_Label[3], "")
			refreshAkten()
		end
		if getElementData(getLocalPlayer(), "rank") == 2 then
			guiSetEnabled ( FirmenGUI_Button[1], true )
			guiSetEnabled ( FirmenGUI_Button[2], true )
			guiSetEnabled ( FirmenGUI_Button[3], true )
			guiSetEnabled ( FirmenGUI_Button[4], true )
			guiSetEnabled ( FirmenGUI_Button[5], true )
			guiSetEnabled ( FirmenGUI_Button[8], true )
			guiSetEnabled ( FirmenGUI_Button[9], true )
			guiSetEnabled ( FirmenGUI_Button[6], true )
			guiSetEnabled ( FirmenGUI_Edit[1], true )
			guiSetEnabled ( FirmenGUI_Edit[2], true )
			guiSetEnabled ( FirmenGUI_Edit[3], true )
		end	
	
		refreshGridLists()
		guiSetVisible( FirmenGUI_Window[1], true)
		showCursor(true)
		guiSetInputEnabled ( true )
		callServerFunction("sendJobNoteToPlayer", getLocalPlayer())
		showTutorialMessage("firmen_1", "Dieses Menü ermöglicht dir als Fraktionschef deine Fahrzeuge und Mitarbeiter zu organisieren.")
		showTutorialMessage("firmen_2", "Die vom Fraktionschef festgelegte Notiz kann dir nützliche Informationen zu deiner Tätigkeit liefern.")
		hasNotes = false
	end
end
bindKey ( "j", "down", showFirma )

addEventHandler("onClientGUIChanged",FirmenGUI_Edit[4], function() 
	if guiGetText(FirmenGUI_Edit[4]) ~= "Aktenname..." then
		for i = 1, guiGridListGetRowCount ( FirmenGUI_Grid[4] ) do
			if string.lower(guiGridListGetItemText ( FirmenGUI_Grid[4], i, 1 )) == string.lower(guiGetText(FirmenGUI_Edit[4])) then
				guiGridListSetSelectedItem ( FirmenGUI_Grid[4],i,1 )
				setAktenInfo(true)
				return
			end
		end
		guiGridListSetSelectedItem ( FirmenGUI_Grid[4],0,1 )
		setAktenInfo(true)
	end
end)

function setAktenInfo(noset)
	local selectedRow, selectedCol = guiGridListGetSelectedItem( FirmenGUI_Grid[4] )
	local name = guiGridListGetItemText ( FirmenGUI_Grid[4], selectedRow, 1 )
	if selectedRow ~= -1 and selectedRow ~= 0 and name then
		local akte = false
		for i,v in ipairs(getElementsByType("wanted")) do
			if string.lower(getElementData(v, "name")) == string.lower(name) then
				akte = v
				break
			end
		end
		
		if akte then
			local newtext = "Wanted Level: "..tostring(getElementData(akte, "wantedLevel")).." Sterne\n\nAkte:\n"
			for i,v in ipairs(getElementData(akte, "text")) do
				newtext = newtext..""..i..": "..v.."\n"
			end
			if noset ~= true then
				guiSetText(FirmenGUI_Edit[4], name)
			end
			guiSetText(FirmenGUI_Label[3], newtext)
			return
		end
	end
	if noset ~= true then
		guiSetText(FirmenGUI_Edit[4], "Aktenname...")
	end
	guiSetText(FirmenGUI_Label[3], "")
end
addEventHandler ( "onClientGUIClick", FirmenGUI_Grid[4], setAktenInfo, false )

--[[function recieveJobNote(text) 
	guiSetText(FirmenGUI_Memo[1], text)
end]]--


function recieveJobNote(text)
	guiSetText(FirmenGUI_Memo[1], text)
	hasNotes = true
	if getElementData(getLocalPlayer(), "rank") == 2 then
		guiMemoSetReadOnly( FirmenGUI_Memo[1], false)
	else
		guiMemoSetReadOnly( FirmenGUI_Memo[1], true)
	end
end

-- Gui Readonly test von sense
--[[function memoreadonly()
	if getElementData(getLocalPlayer(), "rank") < 2 then
    guiMemoSetReadOnly(FirmenGUI_Memo[1], true)--We made it read only.
	end
end
addEventHandler("onClientResourceStart", getRootElement(), memoreadonly)--We handle our memo.]]--


function closeFirma()
	guiSetInputEnabled ( false )
	guiSetVisible( FirmenGUI_Window[1], false)
	showCursor(false)
	if getElementData(getLocalPlayer(), "rank") == 2 and hasNotes == true then
		callServerFunction("saveJobNote", getLocalPlayer(), guiGetText(FirmenGUI_Memo[1]))
	end
end
addEventHandler ( "onClientGUIClick", FirmenGUI_Button[7], closeFirma, false )

function addToJob()
	if getElementData(getLocalPlayer(), "rank") == 2 then
		callServerFunction("addToJob", getLocalPlayer(), "entlassen", tostring(guiGetText(FirmenGUI_Edit[1])))
		addNotification(2, 0, 255, 0, "Du hast "..tostring(guiGetText(FirmenGUI_Edit[1])).." eingestellt.")
		refreshGridLists()
	end	
end
addEventHandler ( "onClientGUIClick", FirmenGUI_Button[3], addToJob, false )

function kickFromJob()
	if getElementData(getLocalPlayer(), "rank") == 2 then
		local selectedRow, selectedCol = guiGridListGetSelectedItem( FirmenGUI_Grid[1] )
		local name = guiGridListGetItemText ( FirmenGUI_Grid[1], selectedRow, 1 )
		if selectedRow ~= -1 then
			callServerFunction("kickFromJob", getLocalPlayer(), "entlassen", tostring(name))
			addNotification(2, 0, 255, 0, "Du hast "..tostring(name).." entlassen.")
		end	
		refreshGridLists()
	end	
end
addEventHandler ( "onClientGUIClick", FirmenGUI_Button[1], kickFromJob, false )
 
function increaseRank()
	if getElementData(getLocalPlayer(), "rank") == 2 then
		local selectedRow, selectedCol = guiGridListGetSelectedItem( FirmenGUI_Grid[1] )
		local name = guiGridListGetItemText ( FirmenGUI_Grid[1], selectedRow, 1 )
		local rank = guiGridListGetItemText ( FirmenGUI_Grid[1], selectedRow, 2 )
		if selectedRow ~= -1 then
			if tonumber(rank)+1 < 3 then
				callServerFunction("setPlayerUserFileData", name, "rank", tonumber(rank)+1)
				addNotification(2, 0, 255, 0, "Rank von "..name.." auf "..rank.." geändert.")
			end
		end
		refreshGridLists()
	end
end
addEventHandler ( "onClientGUIClick", FirmenGUI_Button[2], increaseRank, false )

function decreaseRank()
	if getElementData(getLocalPlayer(), "rank") == 2 then
		local selectedRow, selectedCol = guiGridListGetSelectedItem( FirmenGUI_Grid[1] )
		local name = guiGridListGetItemText ( FirmenGUI_Grid[1], selectedRow, 1 )
		local rank = guiGridListGetItemText ( FirmenGUI_Grid[1], selectedRow, 2 )
		if selectedRow ~= -1 then
			if tonumber(rank)-1 > -1 then
				callServerFunction("setPlayerUserFileData", name, "rank", tonumber(rank)-1)
				addNotification(2, 0, 255, 0, "Rank von "..name.." auf "..rank.." geändert.")
			end
		end
		refreshGridLists()
	end
end
addEventHandler ( "onClientGUIClick", FirmenGUI_Button[4], decreaseRank, false )

function setVerdienst()
	if getElementData(getLocalPlayer(), "rank") == 2 then
		local selectedRow, selectedCol = guiGridListGetSelectedItem( FirmenGUI_Grid[2] )
		local name = guiGridListGetItemText ( FirmenGUI_Grid[2], selectedRow, 3 )
		
		if selectedRow ~= -1 then
			local gehalt = tonumber(guiGetText(FirmenGUI_Edit[2]))
			if gehalt > 100 or gehalt < 0 then
				addNotification(1, 255, 0, 0, "Gehalt muss zwischen 0 und 100 liegen.")
			else
				callServerFunction("setPlayerUserFileData", name, "gehalt", gehalt)
				addNotification(2, 0, 255, 0, "Gehalt von "..name.." geändert:\n"..gehalt.." Vero")
			end
		end	
		refreshGridLists()
	end
end
addEventHandler ( "onClientGUIClick", FirmenGUI_Button[5], setVerdienst, false )

function changeVehicleGrid(button, state)
	if source ~= FirmenGUI_Grid[3] then return end
	if button ~= "left" and state ~= "down" then return end
	if getElementData(getLocalPlayer(), "rank") == 2 then
		local selectedRow, selectedCol = guiGridListGetSelectedItem( FirmenGUI_Grid[3] )
		local name = guiGridListGetItemText ( FirmenGUI_Grid[3], selectedRow, 1 )
		local keys = guiGridListGetItemText ( FirmenGUI_Grid[3], selectedRow, 3 )	
		for _, vehicle in ipairs(getElementsByType("vehicle")) do
			if getElementData(vehicle, "owner") == tostring(getElementData(getLocalPlayer(), "job")) then
				if getVehicleNameFromModel ( getElementData(vehicle, "model") ) == name then
					if getElementData(vehicle, "keys") == keys then
						guiSetText(FirmenGUI_Edit[3], keys)
						break
					end
				end
			end
		end
	end
end
addEventHandler( "onClientGUIClick", getRootElement(), changeVehicleGrid )

function setBesitzer()
	if getElementData(getLocalPlayer(), "rank") == 2 then
		local selectedRow, selectedCol = guiGridListGetSelectedItem( FirmenGUI_Grid[3] )
		local vehicle = guiGridListGetItemData ( FirmenGUI_Grid[3], selectedRow, 1 )
		local name = guiGridListGetItemText ( FirmenGUI_Grid[3], selectedRow, 1 )
		local keys = guiGridListGetItemText ( FirmenGUI_Grid[3], selectedRow, 3 )
		if vehicle and isElement(vehicle) then		
			setElementData(vehicle, "keys", guiGetText(FirmenGUI_Edit[3]))
			addNotification(2, 0, 255, 0, "Schlüssel des Fahrzeugs erfolgreich geändert:\n"..guiGetText(FirmenGUI_Edit[3]))
		end	
		refreshGridLists()
	end
end
addEventHandler ( "onClientGUIClick", FirmenGUI_Button[6], setBesitzer, false )

addEventHandler ( "onClientGUIClick", FirmenGUI_Button[8], function() callServerFunction("setVehFK", getLocalPlayer()) end, false )
addEventHandler ( "onClientGUIClick", FirmenGUI_Button[9], function() callServerFunction("setFirmaBewerbung", getLocalPlayer()) end, false )

function refreshGridLists()
	guiGridListClear ( FirmenGUI_Grid[1] )
	guiGridListClear ( FirmenGUI_Grid[2] )
	guiGridListClear ( FirmenGUI_Grid[3] )
	destroyElement ( FirmenGUI_Grid[1] )
	destroyElement ( FirmenGUI_Grid[2] )
	destroyElement ( FirmenGUI_Grid[3] )	
	
	FirmenGUI_Grid[1] = guiCreateGridList(6,6,645,346,false,FirmenGUI_Tab[1])
	guiGridListAddColumn(FirmenGUI_Grid[1],"Name",0.2)
	guiGridListAddColumn(FirmenGUI_Grid[1],"Rang",0.05)
	guiGridListAddColumn(FirmenGUI_Grid[1],"Dienstdauer",0.2)
	guiGridListAddColumn(FirmenGUI_Grid[1],"Einnahmen",0.4)
	
	FirmenGUI_Grid[2] = guiCreateGridList(6,6,645,346,false,FirmenGUI_Tab[2])
	guiGridListAddColumn(FirmenGUI_Grid[2],"Rang",0.05)
	guiGridListAddColumn(FirmenGUI_Grid[2],"Verdienst",0.2)
	guiGridListAddColumn(FirmenGUI_Grid[2],"Spielername",0.2)
	guiGridListAddColumn(FirmenGUI_Grid[2],"Dienstdauer",0.2)
	guiGridListAddColumn(FirmenGUI_Grid[2],"Einnahmen",0.35)	
	
	FirmenGUI_Grid[3] = guiCreateGridList(6,6,645,346,false,FirmenGUI_Tab[3])
	guiGridListAddColumn(FirmenGUI_Grid[3],"Fahrzeugname",0.2)
	guiGridListAddColumn(FirmenGUI_Grid[3],"Besitzer",0.2)
	guiGridListAddColumn(FirmenGUI_Grid[3],"Schluesselbesitzer",0.2)
	guiGridListAddColumn(FirmenGUI_Grid[3],"KM",0.18)
	guiGridListAddColumn(FirmenGUI_Grid[3],"TÜV",0.1)
	guiGridListAddColumn(FirmenGUI_Grid[3],"Panne",0.1)
	
	
	callServerFunction("getFirmenPlayers", getLocalPlayer())
	
	for _, vehicle in ipairs(getElementsByType("vehicle")) do
		if (getElementData(vehicle, "owner") == tostring(getElementData(getLocalPlayer(), "job"))) or (tostring(getElementData(getLocalPlayer(), "job")) == "1" and getElementData(vehicle, "owner") == "Autohaus") then
			local row = guiGridListAddRow(FirmenGUI_Grid[3])
			if getElementData(vehicle, "eingepackt") == true then
				guiGridListSetItemText ( FirmenGUI_Grid[3], row, 1, "Trailer ("..getVehicleNameFromModel ( getElementData(vehicle, "model") )..")", false, false)
			else
				guiGridListSetItemText ( FirmenGUI_Grid[3], row, 1, getVehicleNameFromModel ( getElementData(vehicle, "model") ), false, false )
			end
			guiGridListSetItemText ( FirmenGUI_Grid[3], row, 2, getElementData(vehicle, "owner"), false, false )	
			guiGridListSetItemText ( FirmenGUI_Grid[3], row, 3, getElementData(vehicle, "keys"), false, false )	
			guiGridListSetItemData ( FirmenGUI_Grid[3], row, 1, vehicle )
			local km
			if getElementData(vehicle, "km") == nil or getElementData(vehicle, "km") == false or getElementData(vehicle, "km") == "false" or getElementData(vehicle, "km") == "nil" then
				km = 0
			else
				km = tonumber(getElementData(vehicle, "km"))
			end
			guiGridListSetItemText ( FirmenGUI_Grid[3], row, 4, tostring(math.round(km,0,"round")), false, false )
			local ttage = getElementData(vehicle,"tuev")+14-getRealTime().yearday
			if ttage >= 0 then
				guiGridListSetItemText ( FirmenGUI_Grid[3], row, 5, "Ja ("..ttage..")", false, false )
			else
				guiGridListSetItemText ( FirmenGUI_Grid[3], row, 5, "Nein", false, false )
			end	
			
			if getElementData(vehicle, "panne") == true then
				guiGridListSetItemText ( FirmenGUI_Grid[3], row, 6, "Ja", false, false )
			else
				guiGridListSetItemText ( FirmenGUI_Grid[3], row, 6, "Nein", false, false )
			end
		end
	end	
end

function recieveFirmenPlayers(data)
	for i = #data,1,-1 do
		if tonumber(data[i].job) == getElementData(getLocalPlayer(), "job") then
			local row = guiGridListAddRow ( FirmenGUI_Grid[1] )
			guiGridListSetItemText ( FirmenGUI_Grid[1], row, 1, tostring(data[i].name), false, false )
			guiGridListSetItemText ( FirmenGUI_Grid[1], row, 2, tostring(data[i].rank), false, false )
			guiGridListSetItemText ( FirmenGUI_Grid[1], row, 3, tostring(data[i].dienstzeit).." Minuten", false, false )
			guiGridListSetItemText ( FirmenGUI_Grid[1], row, 4, tostring(data[i].einnahmen2).." Vero (Heute: "..tostring(data[i].einnahmen).." Vero)", false, false )
			
			row = guiGridListAddRow ( FirmenGUI_Grid[2] )
			guiGridListSetItemText ( FirmenGUI_Grid[2], row, 1, tostring(data[i].rank), false, false )
			guiGridListSetItemText ( FirmenGUI_Grid[2], row, 2, tostring(data[i].gehalt).." Vero", false, false )
			guiGridListSetItemText ( FirmenGUI_Grid[2], row, 3, tostring(data[i].name), false, false )
			guiGridListSetItemText ( FirmenGUI_Grid[2], row, 4, tostring(data[i].dienstzeit).." Minuten", false, false )
			guiGridListSetItemText ( FirmenGUI_Grid[2], row, 5, tostring(data[i].einnahmen2).." Vero (Heute: "..tostring(data[i].einnahmen).." Vero)", false, false )
		end
	end
end


local thebus = createObject(4731, 2078.2373046875, 2178.216796875, 20.11625289917,0,0,120.24533081055) -- Schild
replaceTexture(thebus, "diderSachs01", "images/zip_news.jpg")

thebus = createObject(4729, 2007.8460693359, 2179.0820312, 14.883358001709,0,0,290) --Schild
setObjectScale(thebus, 0.4)
replaceTexture(thebus, "bobo_2", "images/bobo_news.jpg")
setElementCollisionsEnabled (thebus,false )

thebus = createObject(4731, 1937.3751220703, 2179.0100097656, 20.11625289917,0,0,300.25) --Schild 
replaceTexture(thebus, "diderSachs01", "images/zip_news.jpg")

thebus = createObject(12814, 2037.865234375, 2171.4052734375, 9.8317403793335,0,0,270) --Gras
replaceTexture(thebus, "newgrnd1brn_128", "images/newgrnd1brn_128.png")

thebus = createObject(12814, 1977.7666015625, 2171.3017578125, 9.8317403793335,0,0,90) --Gras
replaceTexture(thebus, "newgrnd1brn_128", "images/newgrnd1brn_128.png")


--Krankenhaus Garage Port
local isInSaniTeleport = false

local sani_marker1 = createMarker(365.5401,326.232,1021.2468, "arrow", 2.0, 255, 255, 255, 255, getRootElement())
setElementInterior(sani_marker1, 3)
local sani_marker2 = createMarker(1612.908,1702.52,0.5484, "arrow", 2.0, 255, 255, 255, 255, getRootElement())

function saniTeleport1 ( hitElement, matchingDimension )
	if hitElement ~= getLocalPlayer() then return false end
	if isPedInVehicle ( hitElement ) then return false end
	if isInSaniTeleport == false then
		if getElementData(hitElement, "job") == 7 then
			isInSaniTeleport = true
			callServerFunction( "setElementInterior", getLocalPlayer(), 0, 1612.908,1702.52,0.7484)
			setTimer ( function () isInSaniTeleport = false end, 3000, 1 )
		end
	end
end

function saniTeleport2 ( hitElement, matchingDimension )
	if hitElement ~= getLocalPlayer() then return false end
	if isPedInVehicle ( hitElement ) then return false end
	if isInSaniTeleport == false then
		isInSaniTeleport = true
		callServerFunction( "setElementInterior", getLocalPlayer(), 3, 365.5401,326.232,1020.0468)
		setTimer ( function () isInSaniTeleport = false end, 3000, 1 )
	end
end

addEventHandler("onClientMarkerHit", sani_marker1, saniTeleport1 )
addEventHandler("onClientMarkerHit", sani_marker2, saniTeleport2 )

--
local isInTeleport = false
local vinetwork_marker1 = createMarker( 370.89999389648, 160.30000305176, 1026.8000488281, "arrow", 2.0, 255, 255, 255, 255, getRootElement())
setElementInterior(vinetwork_marker1, 3)
local vinetwork_marker2 = createMarker(1973.5999755859, 2186, 25.700000762939, "arrow", 2.0, 255, 255, 255, 255, getRootElement())

function vinetworkTeleport1 ( hitElement, matchingDimension )
	if hitElement ~= getLocalPlayer() then return false end
	if isPedInVehicle ( hitElement ) then return false end
	if isInTeleport == false then
		if getElementData(hitElement, "job") == 9 then
			isInTeleport = true
			callServerFunction( "setElementInterior", getLocalPlayer(), 0, 1973.5999755859, 2186, 25.700000762939)
			setTimer ( function () isInTeleport = false end, 3000, 1 )
		end
	end
end

function vinetworkTeleport2 ( hitElement, matchingDimension )
	if hitElement ~= getLocalPlayer() then return false end
	if isPedInVehicle ( hitElement ) then return false end
	if isInTeleport == false then
		isInTeleport = true
		callServerFunction( "setElementInterior", getLocalPlayer(), 3,  370.89999389648, 160.30000305176, 1026.8000488281)
		setTimer ( function () isInTeleport = false end, 3000, 1 )
	end
end

addEventHandler("onClientMarkerHit", vinetwork_marker1, vinetworkTeleport1 )
addEventHandler("onClientMarkerHit", vinetwork_marker2, vinetworkTeleport2 )

