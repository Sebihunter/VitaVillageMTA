--[[
Project: VitaOnline
File: tschein-client.lua
Author(s):	Lexlo
]]--
local counter = 0

local GUIEditor_Window = guiCreateWindow(642,237,661,695,"Willkommen zu dem Test für den Kurzzeit-Führerschein",false)
guiSetAlpha(GUIEditor_Window,0.89999997615814)

local Box1 = guiCreateCheckBox(16,89,14,13,"",false,false,GUIEditor_Window)
local Box2 = guiCreateCheckBox(16,117,14,13,"",false,false,GUIEditor_Window)
local Box3 = guiCreateCheckBox(16,144,14,13,"",false,false,GUIEditor_Window)
local Box4 = guiCreateCheckBox(16,201,14,13,"",false,false,GUIEditor_Window)
local Box5 = guiCreateCheckBox(16,230,14,13,"",false,false,GUIEditor_Window)
local Box6 = guiCreateCheckBox(16,257,14,13,"",false,false,GUIEditor_Window)
local Box7 = guiCreateCheckBox(16,324,14,13,"",false,false,GUIEditor_Window)
local Box8 = guiCreateCheckBox(16,355,14,13,"",false,false,GUIEditor_Window)
local Box9 = guiCreateCheckBox(16,382,14,13,"",false,false,GUIEditor_Window)
local Box10 = guiCreateCheckBox(16,437,14,13,"",false,false,GUIEditor_Window)
local Box11 = guiCreateCheckBox(16,465,14,13,"",false,false,GUIEditor_Window)
local Box12 = guiCreateCheckBox(16,489,14,13,"",false,false,GUIEditor_Window)
local Box13 = guiCreateCheckBox(16,538,14,13,"",false,false,GUIEditor_Window)
local Box14 = guiCreateCheckBox(16,566,14,13,"",false,false,GUIEditor_Window)
local Box15 = guiCreateCheckBox(16,593,14,13,"",false,false,GUIEditor_Window)

local GUIEditor_Edit1 = guiCreateEdit(36,87,277,22,"40 km/h",false,GUIEditor_Window)
guiEditSetReadOnly(GUIEditor_Edit1,true)
local GUIEditor_Edit2 = guiCreateEdit(36,114,277,22,"60 km/h",false,GUIEditor_Window)
guiEditSetReadOnly(GUIEditor_Edit2,true)
local GUIEditor_Edit3 = guiCreateEdit(36,141,277,22,"80 km/h",false,GUIEditor_Window)
guiEditSetReadOnly(GUIEditor_Edit3,true)
local GUIEditor_Edit4 = guiCreateEdit(36,196,277,22,"Die Polizei rufen",false,GUIEditor_Window)
guiEditSetReadOnly(GUIEditor_Edit4,true)
local GUIEditor_Edit5 = guiCreateEdit(36,224,277,22,"Weiter fahren",false,GUIEditor_Window)
guiEditSetReadOnly(GUIEditor_Edit5,true)
local GUIEditor_Edit6 = guiCreateEdit(36,251,277,22,"Panisch im Kreis rennen",false,GUIEditor_Window)
guiEditSetReadOnly(GUIEditor_Edit6,true)

local Box16 = guiCreateCheckBox(336,89,14,13,"",false,false,GUIEditor_Window)
local Box17 = guiCreateCheckBox(337,117,14,13,"",false,false,GUIEditor_Window)
local Box18 = guiCreateCheckBox(338,144,14,13,"",false,false,GUIEditor_Window)
local Box19 = guiCreateCheckBox(339,201,14,13,"",false,false,GUIEditor_Window)
local Box20 = guiCreateCheckBox(340,230,14,13,"",false,false,GUIEditor_Window)
local Box21 = guiCreateCheckBox(340,257,14,13,"",false,false,GUIEditor_Window)

local GUIEditor_Edit7 = guiCreateEdit(360,87,277,22,"Weiter fahren",false,GUIEditor_Window)
guiEditSetReadOnly(GUIEditor_Edit7,true)
local GUIEditor_Edit8 = guiCreateEdit(362,114,277,22,"Schneller fahren",false,GUIEditor_Window)
guiEditSetReadOnly(GUIEditor_Edit8,true)
local GUIEditor_Edit9 = guiCreateEdit(362,141,277,22,"Rechts ran ahren",false,GUIEditor_Window)
guiEditSetReadOnly(GUIEditor_Edit9,true)
local GUIEditor_Edit10 = guiCreateEdit(363,196,277,22,"Rechts vor links",false,GUIEditor_Window)
guiEditSetReadOnly(GUIEditor_Edit10,true)
local GUIEditor_Edit11 = guiCreateEdit(363,224,277,22,"Ich hab immer Vorfahrt",false,GUIEditor_Window)
guiEditSetReadOnly(GUIEditor_Edit11,true)
local GUIEditor_Edit12 = guiCreateEdit(364,251,277,22,"Ich bleib einfach stehen und schau was passiert",false,GUIEditor_Window)
guiEditSetReadOnly(GUIEditor_Edit12,true)
local GUIEditor_Edit13 = guiCreateEdit(36,321,277,22,"Halten und warten bis er drüben ist",false,GUIEditor_Window)
guiEditSetReadOnly(GUIEditor_Edit13,true)
local GUIEditor_Edit14 = guiCreateEdit(36,349,277,22,"Überfahren",false,GUIEditor_Window)
guiEditSetReadOnly(GUIEditor_Edit14,true)
local GUIEditor_Edit15 = guiCreateEdit(36,377,277,22,"Versuchen drumrum zufahren",false,GUIEditor_Window)
guiEditSetReadOnly(GUIEditor_Edit15,true)
local GUIEditor_Edit16 = guiCreateEdit(36,432,277,22,"Autohaus",false,GUIEditor_Window)
guiEditSetReadOnly(GUIEditor_Edit16,true)
local GUIEditor_Edit17 = guiCreateEdit(36,459,277,22,"Fahrschule",false,GUIEditor_Window)
guiEditSetReadOnly(GUIEditor_Edit17,true)
local GUIEditor_Edit18 = guiCreateEdit(36,487,277,22,"Polizei",false,GUIEditor_Window)
guiEditSetReadOnly(GUIEditor_Edit18,true)
local GUIEditor_Edit19 = guiCreateEdit(36,533,277,22,"Nebelscheinwerfer an machen",false,GUIEditor_Window)
guiEditSetReadOnly(GUIEditor_Edit19,true)
local GUIEditor_Edit20 = guiCreateEdit(36,562,277,22,"Motor aus",false,GUIEditor_Window)
guiEditSetReadOnly(GUIEditor_Edit20,true)
local GUIEditor_Edit21 = guiCreateEdit(36,590,277,22,"Rechts ranfahren",false,GUIEditor_Window)
guiEditSetReadOnly(GUIEditor_Edit21,true)

local Box22 = guiCreateCheckBox(340,323,14,13,"",false,false,GUIEditor_Window)
local Box23 = guiCreateCheckBox(340,352,14,13,"",false,false,GUIEditor_Window)
local Box24 = guiCreateCheckBox(340,382,14,13,"",false,false,GUIEditor_Window)
local Box25 = guiCreateCheckBox(340,433,14,13,"",false,false,GUIEditor_Window)
local Box26 = guiCreateCheckBox(340,465,14,13,"",false,false,GUIEditor_Window)
local Box27 = guiCreateCheckBox(340,492,14,13,"",false,false,GUIEditor_Window)
local Box28 = guiCreateCheckBox(340,537,14,13,"",false,false,GUIEditor_Window)
local Box29 = guiCreateCheckBox(340,566,14,13,"",false,false,GUIEditor_Window)
local Box30 = guiCreateCheckBox(340,592,14,13,"",false,false,GUIEditor_Window)

local GUIEditor_Edit22 = guiCreateEdit(364,320,277,22,"/11833",false,GUIEditor_Window)
guiEditSetReadOnly(GUIEditor_Edit22,true)
local GUIEditor_Edit23 = guiCreateEdit(364,348,277,22,"/110",false,GUIEditor_Window)
guiEditSetReadOnly(GUIEditor_Edit23,true)
local GUIEditor_Edit24 = guiCreateEdit(364,375,277,22,"/123",false,GUIEditor_Window)
guiEditSetReadOnly(GUIEditor_Edit24,true)
local GUIEditor_Edit25 = guiCreateEdit(364,432,277,22,"Unbegrenzt",false,GUIEditor_Window)
guiEditSetReadOnly(GUIEditor_Edit25,true)
local GUIEditor_Edit26 = guiCreateEdit(364,460,277,22,"140 km/h",false,GUIEditor_Window)
guiEditSetReadOnly(GUIEditor_Edit26,true)
local GUIEditor_Edit27 = guiCreateEdit(364,487,277,22,"160 km/h",false,GUIEditor_Window)
guiEditSetReadOnly(GUIEditor_Edit27,true)
local GUIEditor_Edit28 = guiCreateEdit(364,534,277,22,"Auf der Strasse",false,GUIEditor_Window)
guiEditSetReadOnly(GUIEditor_Edit28,true)
local GUIEditor_Edit29 = guiCreateEdit(364,563,277,22,"Auf Parkplätzen",false,GUIEditor_Window)
guiEditSetReadOnly(GUIEditor_Edit29,true)
local GUIEditor_Edit30 = guiCreateEdit(364,590,277,22,"Auf dem Bürgersteig",false,GUIEditor_Window)
guiEditSetReadOnly(GUIEditor_Edit30,true)

local backbutton = guiCreateButton(9,661,205,24,"Beenden",false,GUIEditor_Window)
local gobutton = guiCreateButton(447,661,205,24,"Akzeptieren",false,GUIEditor_Window)

local GUIEditor_Label1 = guiCreateLabel(17,65,320,21,"Wie schnell dürfen Sie in der Stadt fahren?",false,GUIEditor_Window)
local GUIEditor_Label2 = guiCreateLabel(336,65,291,21,"Was tun sie wenn sie eine Sirene hören?",false,GUIEditor_Window)
local GUIEditor_Label3 = guiCreateLabel(336,172,291,21,"Was tun Sie bei einer Kreuzung ohne Ampeln?",false,GUIEditor_Window)
local GUIEditor_Label4 = guiCreateLabel(336,293,291,21,"Wie rufen Sie die Polizei?",false,GUIEditor_Window)
local GUIEditor_Label5 = guiCreateLabel(336,405,291,21,"Wie schnell dürfen Sie auf dem Highway fahren?",false,GUIEditor_Window)
local GUIEditor_Label6 = guiCreateLabel(336,512,291,21,"Wo dürfen Sie ihr Auto parken?",false,GUIEditor_Window)
local GUIEditor_Label7 = guiCreateLabel(17,174,291,21,"Was tun Sie wenn Sie einen Unfall bauen?",false,GUIEditor_Window)
local GUIEditor_Label8 = guiCreateLabel(17,297,291,21,"",false,GUIEditor_Window)
local GUIEditor_Label9 = guiCreateLabel(17,297,304,21,"Was tun Sie wenn Sie einen Fussgänger gehen sehen?",false,GUIEditor_Window)
local GUIEditor_Label10 = guiCreateLabel(17,409,305,21,"Wo können Sie ihren Langzeit-Führerschein machen?",false,GUIEditor_Window)
local GUIEditor_Label11 = guiCreateLabel(17,511,291,21,"Was tun sie bei schlechten Wetterbedingungen?",false,GUIEditor_Window)

local message = guiCreateLabel(27,626,614,26,"",false,GUIEditor_Window)
guiLabelSetHorizontalAlign(message,"center",false)

local GUIEditor_Label12 = guiCreateLabel(14,33,629,23,"Sie brauchen einen fehlerfreien Test und 300 Vero um zu bestehen",false,GUIEditor_Window)
guiLabelSetColor(GUIEditor_Label12,200,250,250)
guiLabelSetVerticalAlign(GUIEditor_Label12,"center")
guiLabelSetHorizontalAlign(GUIEditor_Label12,"center",false)
guiSetFont(GUIEditor_Label12,"default-bold-small")

guiSetVisible ( GUIEditor_Window, false )

local marker = createMarker ( 1172.5443115234, 1358.7442626953, 9.9218826293945, "cylinder", 1, 0, 0, 255, 170 )
local marker2 = createMarker ( -2026.515625, -101.3857421875, 34.1640625, "cylinder", 1, 0, 0, 255, 170 )
local hasFehler = false

function enable (ele, dim)
	if ele ~= getLocalPlayer() or not dim then return end
	local isOn = false
	local x,y,z = getElementPosition(source)
	local x1,y1,z1 = getElementPosition(ele)
	if getDistanceBetweenPoints3D ( x1,y1,z1, x,y,z ) > 2 then return end
	for numb,ply in ipairs(getElementsByType("player")) do
		if getElementData(ply, "job") == 3 and getElementData(ply, "dienst") == 1 and getElementData(ply, "afk") ~= true then
			isOn = true
		end
	end
	if isOn then 
		showTutorialMessage("tschein_2", "Da zur Zeit ein Fahrlehrer im Dienst ist kannst du dein T-Schein leider nicht machen. Mit '/polizei Fahrschule' kannst du direkt einen Fahrlehrer kontaktieren.")
		return addNotification(1, 255, 0, 0, "Du kannst keinen temporären Führerschein machen,\nwenn ein Fahrlehrer im Dienst ist.")
	end
	showTutorialMessage("tschein_1", "Mit dem T-Schein kannst du zwei Wochen lang Autos fahren. Für andere Fahrzeugtypen oder nach dieser Probezeit benötigst du jedoch einen echten Führerschein von der Polizei.")
	guiSetVisible ( GUIEditor_Window, true )
	showCursor ( true )
end
addEventHandler ( "onClientMarkerHit", marker, enable )
addEventHandler ( "onClientMarkerHit", marker2, enable )


function disable ()
	guiSetVisible ( GUIEditor_Window, false )
	showCursor ( false )
end

function Checkbox (button, state, absoluteX, absoluteY)
	hasFehler = true
	local Check1 = guiCheckBoxGetSelected ( Box3 )
		if ( Check1 == true )
		then
			hasFehler = false
		end
	local Check2 = guiCheckBoxGetSelected ( Box4 )
		if ( Check2 == true )
		then
			hasFehler = false
		end
	local Check3 = guiCheckBoxGetSelected ( Box7 )
		if ( Check3 == true )
		then
			hasFehler = false
		end
	local Check4 = guiCheckBoxGetSelected ( Box12 )
		if ( Check4 == true )
		then
			hasFehler = false
		end
	local Check5 = guiCheckBoxGetSelected ( Box15 )
		if ( Check5 == true )
		then
			hasFehler = false
		end
	local Check6 = guiCheckBoxGetSelected ( Box18 )
		if ( Check6 == true )
		then
			hasFehler = false
		end
	local Check7 = guiCheckBoxGetSelected ( Box19 )
		if ( Check7 == true )
		then
			hasFehler = false
		end
	local Check8 = guiCheckBoxGetSelected ( Box23 )
		if ( Check8 == true )
		then
			hasFehler = false
		end
	local Check9 = guiCheckBoxGetSelected ( Box25 )
		if ( Check9 == true )
		then
			hasFehler = false
		end
	local Check10 = guiCheckBoxGetSelected ( Box29 )
		if ( Check10 == true )
		then
			hasFehler = false
		end
	--fehler
	local Check1 = guiCheckBoxGetSelected ( Box1 )
		if ( Check1 == true )
		then
			hasFehler = true
		end
	local Check1 = guiCheckBoxGetSelected ( Box2 )
		if ( Check1 == true )
		then
			hasFehler = true
		end
	local Check1 = guiCheckBoxGetSelected ( Box5 )
		if ( Check1 == true )
		then
			hasFehler = true
		end
	local Check1 = guiCheckBoxGetSelected ( Box6 )
		if ( Check1 == true )
		then
			hasFehler = true
		end
	local Check1 = guiCheckBoxGetSelected ( Box3 )
		if ( Check1 == true )
		then
			hasFehler = true
		end
	local Check1 = guiCheckBoxGetSelected ( Box8 )
		if ( Check1 == true )
		then
			hasFehler = true
		end
	local Check1 = guiCheckBoxGetSelected ( Box9 )
		if ( Check1 == true )
		then
			hasFehler = true
		end
	local Check1 = guiCheckBoxGetSelected ( Box10 )
		if ( Check1 == true )
		then
			hasFehler = true
		end
	local Check1 = guiCheckBoxGetSelected ( Box11 )
		if ( Check1 == true )
		then
			hasFehler = true
		end
	local Check1 = guiCheckBoxGetSelected ( Box13 )
		if ( Check1 == true )
		then
			hasFehler = true
		end
	local Check1 = guiCheckBoxGetSelected ( Box14 )
		if ( Check1 == true )
		then
			hasFehler = true
		end
	local Check1 = guiCheckBoxGetSelected ( Box16 )
		if ( Check1 == true )
		then
			hasFehler = true
		end
	local Check1 = guiCheckBoxGetSelected ( Box17 )
		if ( Check1 == true )
		then
			hasFehler = true
		end
	local Check1 = guiCheckBoxGetSelected ( Box20 )
		if ( Check1 == true )
		then
			hasFehler = true
		end
	local Check1 = guiCheckBoxGetSelected ( Box21 )
		if ( Check1 == true )
		then
			hasFehler = true
		end
	local Check1 = guiCheckBoxGetSelected ( Box22 )
		if ( Check1 == true )
		then
			hasFehler = true
		end
	local Check1 = guiCheckBoxGetSelected ( Box24 )
		if ( Check1 == true )
		then
			hasFehler = true
		end
	local Check1 = guiCheckBoxGetSelected ( Box26 )
		if ( Check1 == true )
		then
			hasFehler = true
		end
	local Check1 = guiCheckBoxGetSelected ( Box27 )
		if ( Check1 == true )
		then
			hasFehler = true
		end
	local Check1 = guiCheckBoxGetSelected ( Box28 )
		if ( Check1 == true )
		then
			hasFehler = true
		end
	local Check1 = guiCheckBoxGetSelected ( Box30 )
		if ( Check1 == true )
		then
			hasFehler = true
		end
	--ausgabe
	--if ( hasFehler == false) then
		if getPlayerMoneyEx(getLocalPlayer()) < 300 then guiSetText ( message, "Sie haben zu wenig Geld." ) outputChatBox("Sie haben zu wenig Geld.",255,0,0) return end
		counter = 0
		guiSetText ( message, "Herzlichen Glückwunsch, Sie haben bestanden! Dieser Schein ist einmalig. Die Prüfung zu wiederholen würde Ihnen nichts bringen." )
		outputChatBox("Herzlichen  Glückwunsch, Sie haben bestanden! Dieser Schein ist einmalig. Die Prüfung zu wiederholen würde Ihnen nichts bringen.",0,255,0)
		takePlayerMoneyEx(300)
		guiSetVisible(GUIEditor_Window, false)
		disable()
		local name = getPlayerName ( getLocalPlayer() )
		local time = getRealTime()
		local hours = time.hour
		local monthday = time.monthday
		local month = time.month + 1
		local year = time.year + 1900
		local minutes = time.minute
		triggerServerEvent ("onplayerlicensefinish", getRootElement(), name, hours, minutes, monthday, month, year )
		destroyElement ( marker )
	--else
		--	guiSetText ( message, "Sie haben leider nicht bestanden, versuchen Sie es gleich nochmal!" )
		--	outputChatBox("Sie haben leider nicht bestanden, versuchen Sie es gleich nochmal!",255,0,0)	
	--end
end
	addEventHandler ( "onClientGUIClick", gobutton, Checkbox, false )
	addEventHandler ( "onClientGUIClick", backbutton, disable, false )

