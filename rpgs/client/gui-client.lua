--[[
Project: VitaOnline
File: gui-client.lua
Author(s):	Golf_R32
			CubedDeath
			Sebihunter
]]--

--Versionslabel
--[[versionLabelShadow = guiCreateLabel(screenWidth-74, screenHeight-24, screenWidth, screenHeight, "VitaOnline "..g_version,false)
versionLabel = guiCreateLabel(screenWidth-75, screenHeight-25, screenWidth, screenHeight, "VitaOnline "..g_version,false)
guiLabelSetColor(versionLabel,20,125,20)
guiLabelSetColor(versionLabelShadow,0,0,0)
guiSetFont(versionLabel,"default-small")
guiSetFont(versionLabelShadow,"default-small")]]
--Testlabel
--[[versionLabelShadow = guiCreateLabel(screenWidth-129, screenHeight-34, screenWidth, screenHeight,"FOR TEST PURPOSES ONLY",false,getRootElement())
versionLabel = guiCreateLabel(screenWidth-130, screenHeight-35, screenWidth, screenHeight,"FOR TEST PURPOSES ONLY",false,getRootElement())
guiLabelSetColor(versionLabel,150,20,20)
guiLabelSetColor(versionLabelShadow,0,0,0)
guiSetFont(versionLabel,"default-small")
guiSetFont(versionLabelShadow,"default-small")]]--

-- Admin Panel Window und Spieler Tab
AdminUserPanel_Window = {}
AdminUserPanel_Button = {}
AdminUserPanel_Grid = {}
AdminUserPanel_Edit= {}
AdminUserPanel_TabPanel = {}
AdminUserPanel_Tab = {}

AdminUserPanel_Window[1] = guiCreateWindow(0.3,0.2,0.4,0.6,"Admin Panel",true)
guiWindowSetSizable(AdminUserPanel_Window[1],false)
AdminUserPanel_TabPanel[1] = guiCreateTabPanel(0.01,0.04,0.98,0.95,true,AdminUserPanel_Window[1])
AdminUserPanel_Tab[1] = guiCreateTab("Spieler",AdminUserPanel_TabPanel[1])
AdminUserPanel_Tab[2] = guiCreateTab("Fahrzeuge",AdminUserPanel_TabPanel[1])
AdminUserPanel_Tab[3] = guiCreateTab("Fake-Fahrzeuge",AdminUserPanel_TabPanel[1])
AdminUserPanel_Tab[4] = guiCreateTab("Support",AdminUserPanel_TabPanel[1])
--AdminUserPanel_Tab[4] = guiCreateTab("Einstellungen",AdminUserPanel_TabPanel[1])

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

AdminUserPanel_Button[1] = guiCreateButton(0.05,0.75,0.4,0.05,"Aktivieren",true,AdminUserPanel_Tab[1])
AdminUserPanel_Button[2] = guiCreateButton(0.05,0.81,0.4,0.05,"Deaktivieren",true,AdminUserPanel_Tab[1])
AdminUserPanel_Button[3] = guiCreateButton(0.05,0.87,0.2,0.05,"Job",true,AdminUserPanel_Tab[1])
AdminUserPanel_Button[4] = guiCreateButton(0.26,0.87,0.2,0.05,"Rang",true,AdminUserPanel_Tab[1])
AdminUserPanel_Button[5] = guiCreateButton(0.56,0.75,0.4,0.05,"Tutorial Wiederholen",true,AdminUserPanel_Tab[1])
AdminUserPanel_Button[6] = guiCreateButton(0.56,0.81,0.4,0.05,"Admin Status aendern",true,AdminUserPanel_Tab[1])
AdminUserPanel_Button[7] = guiCreateButton(0.56,0.87,0.4,0.05,"Loeschen",true,AdminUserPanel_Tab[1])
AdminUserPanel_Button[8] = guiCreateButton(0.56,0.93,0.4,0.05,"Freier Modus AN",true,AdminUserPanel_Tab[1])

guiSetVisible(AdminUserPanel_Window[1],false)




-- Fahrzeug Panel Tab
AdminVehiclePanel_Button = {}
AdminVehiclePanel_Label = {}
AdminVehiclePanel_Edit = {}
AdminVehiclePanel_Image = {}
AdminVehiclePanel_Grid = {}


AdminVehiclePanel_Button[1] = guiCreateButton(0.016,0.91,0.2644,0.0709,"Fahrzeug erstellen",true,AdminUserPanel_Tab[2])
AdminVehiclePanel_Button[3] = guiCreateButton(0.320,0.91,0.1,0.07,"Teleportieren",true,AdminUserPanel_Tab[2]) 
AdminVehiclePanel_Button[4] = guiCreateButton(0.43,0.91,0.1,0.07,"Loeschen",true,AdminUserPanel_Tab[2]) -- nur admin
AdminVehiclePanel_Button[5] = guiCreateButton(0.54,0.91,0.1,0.07,"Reparieren",true,AdminUserPanel_Tab[2]) -- nur admin
AdminVehiclePanel_Button[6] = guiCreateButton(0.65,0.91,0.1,0.07,"Besitzer",true,AdminUserPanel_Tab[2]) -- mod
AdminVehiclePanel_Button[7] = guiCreateButton(0.76,0.91,0.1,0.07,"Schluessel Besitzer",true,AdminUserPanel_Tab[2]) -- mod
AdminVehiclePanel_Button[8] = guiCreateButton(0.87,0.91,0.1,0.07,"Auf/Ab - Schliessen",true,AdminUserPanel_Tab[2])  -- admin


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

AdminVehiclePanel_Grid[2] = guiCreateGridList(0.045,0.04,0.91,0.7,true,AdminUserPanel_Tab[3])
guiGridListSetSelectionMode(AdminVehiclePanel_Grid[2],1)
guiGridListAddColumn(AdminVehiclePanel_Grid[2],"ID",0.1)
guiGridListAddColumn(AdminVehiclePanel_Grid[2],"Fahrzeug",0.2)
guiGridListAddColumn(AdminVehiclePanel_Grid[2],"Besitzer",0.2)
guiGridListAddColumn(AdminVehiclePanel_Grid[2],"Schluessel Besitzer",0.2)
guiGridListAddColumn(AdminVehiclePanel_Grid[2],"Panne",0.1)

AdminVehiclePanel_Grid[3] = guiCreateGridList(0.045,0.04,0.91,0.7,true,AdminUserPanel_Tab[4])
guiGridListSetSelectionMode(AdminVehiclePanel_Grid[3],1)
guiGridListAddColumn(AdminVehiclePanel_Grid[3],"ID",0.1)
guiGridListAddColumn(AdminVehiclePanel_Grid[3],"Spieler",0.2)
guiGridListAddColumn(AdminVehiclePanel_Grid[3],"Letzte Nachricht",0.5)

AdminVehicleChoosePanel_Window = {}
AdminVehicleChoosePanel_Button = {}
AdminVehicleChoosePanel_Label = {}
AdminVehicleChoosePanel_Edit = {}
AdminVehicleChoosePanel_Image = {}
AdminVehicleChoosePanel_Grid = {}

AdminVehicleChoosePanel_Grid[1] = guiCreateGridList(0.012,0.042,0.27,0.93,true,AdminUserPanel_Tab[2])
guiSetAlpha(AdminVehicleChoosePanel_Grid[1],1)
guiGridListAddColumn(AdminVehicleChoosePanel_Grid[1],"Benutzer",0.9)
guiSetVisible(AdminVehicleChoosePanel_Grid[1],false)

-- Support GUI
theReportLabel = guiCreateLabel ( 0.05,0.75,0.9,0.12, "Kein Report ausgewählt", true , AdminUserPanel_Tab[4] )
guiSetFont(theReportLabel, "default-small")
theReportBack = guiCreateButton(0.05,0.87,0.2,0.05,"<-",true,AdminUserPanel_Tab[4])
theReportForward = guiCreateButton(0.26,0.87,0.2,0.05,"->",true,AdminUserPanel_Tab[4])
theReportEdit = guiCreateEdit(0.56,0.87,0.2,0.05,"",true,AdminUserPanel_Tab[4])
theReportSend = guiCreateButton(0.77,0.87,0.2,0.05,"Senden",true,AdminUserPanel_Tab[4])


-- Fahrzeug erstellen GUI
AdminCreateVehicle_Window = {}
AdminCreateVehicle_Button = {}
AdminCreateVehicle_Label = {}
AdminCreateVehicle_Edit = {}
AdminCreateVehicle_Radio = {}

AdminCreateVehicle_Window[1] = guiCreateWindow(0.362,0.3231,0.2667,0.2889,"Fahrzeug erstellen",true)
guiWindowSetSizable(AdminCreateVehicle_Window[1],false)
AdminCreateVehicle_Label[1] = guiCreateLabel(0.0352,0.1026,0.9277,0.1058,"Hier kannst du ein neues Fahrzeug erstellen.",true,AdminCreateVehicle_Window[1])
guiLabelSetColor(AdminCreateVehicle_Label[1],0,255,0)
guiLabelSetVerticalAlign(AdminCreateVehicle_Label[1],"top")
guiLabelSetHorizontalAlign(AdminCreateVehicle_Label[1],"left",false)
AdminCreateVehicle_Edit[1] = guiCreateEdit(0.043,0.2917,0.3027,0.0994,"502",true,AdminCreateVehicle_Window[1])
AdminCreateVehicle_Label[2] = guiCreateLabel(0.043,0.2276,0.3008,0.0513,"Fahrzeugname:",true,AdminCreateVehicle_Window[1])
guiLabelSetColor(AdminCreateVehicle_Label[2],255,255,255)
guiLabelSetVerticalAlign(AdminCreateVehicle_Label[2],"top")
guiLabelSetHorizontalAlign(AdminCreateVehicle_Label[2],"left",false)
AdminCreateVehicle_Edit[2] = guiCreateEdit(0.043,0.4776,0.1172,0.0994,"0",true,AdminCreateVehicle_Window[1])
AdminCreateVehicle_Edit[3] = guiCreateEdit(0.2402,0.4776,0.1172,0.0994,"0",true,AdminCreateVehicle_Window[1])
AdminCreateVehicle_Edit[4] = guiCreateEdit(0.4531,0.4776,0.1172,0.0994,"0",true,AdminCreateVehicle_Window[1])
AdminCreateVehicle_Label[3] = guiCreateLabel(0.043,0.4231,0.123,0.0449,"R:",true,AdminCreateVehicle_Window[1])
guiLabelSetColor(AdminCreateVehicle_Label[3],255,255,255)
guiLabelSetVerticalAlign(AdminCreateVehicle_Label[3],"top")
guiLabelSetHorizontalAlign(AdminCreateVehicle_Label[3],"left",false)
AdminCreateVehicle_Label[4] = guiCreateLabel(0.2383,0.4231,0.123,0.0449,"G:",true,AdminCreateVehicle_Window[1])
guiLabelSetColor(AdminCreateVehicle_Label[4],255,255,255)
guiLabelSetVerticalAlign(AdminCreateVehicle_Label[4],"top")
guiLabelSetHorizontalAlign(AdminCreateVehicle_Label[4],"left",false)
AdminCreateVehicle_Label[5] = guiCreateLabel(0.4531,0.4231,0.123,0.0449,"B:",true,AdminCreateVehicle_Window[1])
guiLabelSetColor(AdminCreateVehicle_Label[5],255,255,255)
guiLabelSetVerticalAlign(AdminCreateVehicle_Label[5],"top")
guiLabelSetHorizontalAlign(AdminCreateVehicle_Label[5],"left",false)
AdminCreateVehicle_Radio[1] = guiCreateRadioButton(0.3984,0.6603,0.3301,0.0673,"Temporaer",true,AdminCreateVehicle_Window[1])
AdminCreateVehicle_Radio[2] = guiCreateRadioButton(0.3984,0.7532,0.3301,0.0673,"Permanent",true,AdminCreateVehicle_Window[1])
guiRadioButtonSetSelected(AdminCreateVehicle_Radio[2],true)
AdminCreateVehicle_Label[7] = guiCreateLabel(0.2363,0.5929,0.5391,0.0577,"Whaele aus wie das Fahrzeug erstellt werden soll",true,AdminCreateVehicle_Window[1])
guiLabelSetColor(AdminCreateVehicle_Label[7],255,255,255)
guiLabelSetVerticalAlign(AdminCreateVehicle_Label[7],"top")
guiLabelSetHorizontalAlign(AdminCreateVehicle_Label[7],"left",false)
AdminCreateVehicle_Button[2] = guiCreateButton(0.0176,0.875,0.2051,0.0929,"Schliessen",true,AdminCreateVehicle_Window[1])
AdminCreateVehicle_Button[1] = guiCreateButton(0.7813,0.875,0.2012,0.0929,"OK",true,AdminCreateVehicle_Window[1])
AdminCreateVehicle_Button[3] = guiCreateButton(0.7813,0.675,0.2012,0.0929,"Farbenliste",true,AdminCreateVehicle_Window[1])
guiEditSetMaxLength(AdminCreateVehicle_Edit[2],3)
guiEditSetMaxLength(AdminCreateVehicle_Edit[3],3)
guiEditSetMaxLength(AdminCreateVehicle_Edit[4],3)
guiEditSetMaxLength(AdminCreateVehicle_Edit[5],3)
guiSetVisible(AdminCreateVehicle_Window[1],false)


-- Fahrzeug Farbliste
ColorVehicleWindow_Window = {}
ColorVehicleWindow_Button = {}
ColorVehicleWindow_Image = {}

ColorVehicleWindow_Window[1] = guiCreateWindow(0.3234,0.2185,0.3578,0.3917,"Farbliste",true)
guiWindowSetSizable(ColorVehicleWindow_Window[1],false)
ColorVehicleWindow_Button[1] = guiCreateButton(0.4236,0.8794,0.1368,0.0638,"Schliessen",true,ColorVehicleWindow_Window[1])
ColorVehicleWindow_Image[1] = guiCreateStaticImage(0.048,0.0969,0.917,0.7305,"images/farbpalette.png",true,ColorVehicleWindow_Window[1])
guiSetVisible(ColorVehicleWindow_Window[1],false)



-- Job GUI
AdminPlayerJob_Window = {}
AdminPlayerJob_Button = {}
AdminPlayerJob_Label = {}
AdminPlayerJob_Grid = {}
AdminPlayerJob_GridRow = {}
AdminPlayerJob_GridColumn = {}

AdminPlayerJob_Window[1] = guiCreateWindow(0.4161,0.3361,0.1594,0.3046,"Job",true)
guiWindowSetSizable(AdminPlayerJob_Window[1],false)
AdminPlayerJob_Grid[1] = guiCreateGridList(48,64,211,212,false,AdminPlayerJob_Window[1])
--guiGridListSetSelectionMode(AdminPlayerJob_Grid[1],1)
AdminPlayerJob_GridColumn[1] = guiGridListAddColumn(AdminPlayerJob_Grid[1],"Jobname",0.8)

for i = 1, 12 do -- "12" muss erhoeht werden wenn noch mehr jobs hinzukommen
    AdminPlayerJob_GridRow[1] = guiGridListAddRow(AdminPlayerJob_Grid[1])
	guiGridListSetItemText ( AdminPlayerJob_Grid[1], AdminPlayerJob_GridRow[1], AdminPlayerJob_GridColumn[1], JobNames[i], false, false )
end


AdminPlayerJob_Label[1] = guiCreateLabel(7,23,287,20,"Whaele einen Job aus.",false,AdminPlayerJob_Window[1])
guiLabelSetColor(AdminPlayerJob_Label[1],255,255,255)
guiLabelSetVerticalAlign(AdminPlayerJob_Label[1],"top")
guiLabelSetHorizontalAlign(AdminPlayerJob_Label[1],"left",false)
AdminPlayerJob_Button[1] = guiCreateButton(9,294,109,26,"Schliessen",false,AdminPlayerJob_Window[1])
AdminPlayerJob_Button[2] = guiCreateButton(189,294,108,26,"OK",false,AdminPlayerJob_Window[1])

guiSetVisible(AdminPlayerJob_Window[1],false)


-- Rang GUI

AdminPlayerRang_Window = {}
AdminPlayerRang_Button = {}
AdminPlayerRang_Label = {}
AdminPlayerRang_Grid = {}
AdminPlayerRang_GridRow = {}
AdminPlayerRang_GridColumn = {}

AdminPlayerRang_Window[1] = guiCreateWindow(0.4161,0.3361,0.1594,0.3046,"Rang",true)
guiWindowSetSizable(AdminPlayerRang_Window[1],false)
AdminPlayerRang_Grid[1] = guiCreateGridList(48,64,211,212,false,AdminPlayerRang_Window[1])
guiGridListSetSelectionMode(AdminPlayerRang_Grid[1],1)
AdminPlayerRang_GridColumn[1] = guiGridListAddColumn(AdminPlayerRang_Grid[1],"Jobname",0.8)

for i = 1, 3 do -- "3" muss erhoeht werden wenn noch mehr raenge hinzukommen
    AdminPlayerRang_GridRow[1] = guiGridListAddRow(AdminPlayerRang_Grid[1])
	guiGridListSetItemText ( AdminPlayerRang_Grid[1], AdminPlayerRang_GridRow[1], AdminPlayerRang_GridColumn[1], JobRang[i], false, false )
end


AdminPlayerRang_Label[1] = guiCreateLabel(7,23,287,20,"Whaele einen Rang aus.",false,AdminPlayerRang_Window[1])
guiLabelSetColor(AdminPlayerRang_Label[1],255,255,255)
guiLabelSetVerticalAlign(AdminPlayerRang_Label[1],"top")
guiLabelSetHorizontalAlign(AdminPlayerRang_Label[1],"left",false)
AdminPlayerRang_Button[1] = guiCreateButton(9,294,109,26,"Schliessen",false,AdminPlayerRang_Window[1])
AdminPlayerRang_Button[2] = guiCreateButton(189,294,108,26,"OK",false,AdminPlayerRang_Window[1])

guiSetVisible(AdminPlayerRang_Window[1],false)




-- Admin Right GUI

AdminPlayerRight_Window = {}
AdminPlayerRight_Button = {}
AdminPlayerRight_Label = {}
AdminPlayerRight_Grid = {}
AdminPlayerRight_GridRow = {}
AdminPlayerRight_GridColumn = {}

AdminPlayerRight_Window[1] = guiCreateWindow(0.4161,0.3361,0.1594,0.3046,"Adminstatus",true)
guiWindowSetSizable(AdminPlayerRight_Window[1],false)
AdminPlayerRight_Grid[1] = guiCreateGridList(48,64,211,212,false,AdminPlayerRight_Window[1])
guiGridListSetSelectionMode(AdminPlayerRight_Grid[1],1)
AdminPlayerRight_GridColumn[1] = guiGridListAddColumn(AdminPlayerRight_Grid[1],"Statusname",0.8)

for i = 1, 4 do -- "4" muss erhoeht werden wenn noch mehr rechte hinzukommen
    AdminPlayerRight_GridRow[1] = guiGridListAddRow(AdminPlayerRight_Grid[1])
	guiGridListSetItemText ( AdminPlayerRight_Grid[1], AdminPlayerRight_GridRow[1], AdminPlayerRight_GridColumn[1], AdminRang[i], false, false )
end


AdminPlayerRight_Label[1] = guiCreateLabel(7,23,287,20,"Whaele einen Status aus.",false,AdminPlayerRight_Window[1])
guiLabelSetColor(AdminPlayerRight_Label[1],255,255,255)
guiLabelSetVerticalAlign(AdminPlayerRight_Label[1],"top")
guiLabelSetHorizontalAlign(AdminPlayerRight_Label[1],"left",false)
AdminPlayerRight_Button[1] = guiCreateButton(9,294,109,26,"Schliessen",false,AdminPlayerRight_Window[1])
AdminPlayerRight_Button[2] = guiCreateButton(189,294,108,26,"OK",false,AdminPlayerRight_Window[1])

guiSetVisible(AdminPlayerRight_Window[1],false)

-- BusJob GUI
BusJob_Window = {}
BusJob_Button = {}
BusJob_Label = {}
BusJob_Grid = {}
BusJob_GridRow = {}
BusJob_GridColumn = {}

BusJob_Window[1] = guiCreateWindow(0.4161,0.3361,0.1594,0.3046,"Bus Linie",true)
guiWindowSetSizable(BusJob_Window[1],false)
BusJob_Grid[1] = guiCreateGridList(48,64,211,212,false,BusJob_Window[1])
guiGridListSetSelectionMode(BusJob_Grid[1],1)
BusJob_GridColumn[1] = guiGridListAddColumn(BusJob_Grid[1],"Jobname",0.8)

for i = 1, 4 do -- "4" muss erhoeht werden wenn noch mehr linien hinzukommen
    BusJob_GridRow[1] = guiGridListAddRow(BusJob_Grid[1])
	guiGridListSetItemText ( BusJob_Grid[1], BusJob_GridRow[1], BusJob_GridColumn[1], BusLines[i], false, false )
end


BusJob_Label[1] = guiCreateLabel(7,23,287,20,"Wähle eine Bus Linie aus.",false,BusJob_Window[1])
guiLabelSetColor(BusJob_Label[1],255,255,255)
guiLabelSetVerticalAlign(BusJob_Label[1],"top")
guiLabelSetHorizontalAlign(BusJob_Label[1],"left",false)
BusJob_Button[1] = guiCreateButton(9,294,109,26,"Schliessen",false,BusJob_Window[1])
BusJob_Button[2] = guiCreateButton(189,294,108,26,"OK",false,BusJob_Window[1])

guiSetVisible(BusJob_Window[1],false)

-- BusTimetable

BusTime_Window = {}
BusTime_Image = {}


BusTime_Window[1] = guiCreateWindow(screenWidth/2-353,screenHeight/2-462,705,918,"Netzkarte Las Venturas",false)
guiWindowSetSizable(BusTime_Window[1],false)
BusTime_Image[1] = guiCreateStaticImage( 0, 15, 705, 913, "images/mvb-lv.png", false, BusTime_Window[1] )
guiSetVisible(BusTime_Window[1],false)

function closeTimetable( )
    guiSetVisible(BusTime_Window[1],false)
end
addEventHandler( "onClientGUIDoubleClick", BusTime_Window[1], closeTimetable, false );