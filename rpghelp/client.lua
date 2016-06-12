root = getRootElement ()
local screenWidth,screenHeight = guiGetScreenSize()  -- Get screen resolution.

local showRules = false
local rulesAlpha = 0
local incDec = 0.1
local hideCursor = false

local grid = dxCreateGridList(screenWidth/2-315,screenHeight/2-215,185,440,false)
dxSetVisible(grid, false)
dxGridListAddRow(grid, "Befehle", false, true)
dxGridListAddRow(grid, "Klicksystem", false, false)
dxGridListAddRow(grid, "Binds", false, false)
dxGridListAddRow(grid, "Allgemein", false, false)
dxGridListAddRow(grid, "Gangs, Firmenchef, Autohaus", false, false)
dxGridListAddRow(grid, "AutoFix, InterTrans, Reporter", false, false)
dxGridListAddRow(grid, "Feuerwehr, Medics, Polizei #1", false, false)
dxGridListAddRow(grid, "Polizei #2", false, false)
dxGridListAddRow(grid, "Staatsverwaltung, Fahrschule", false, false)
dxGridListAddRow(grid, " ", false, true)

dxGridListAddRow(grid, "Einstiegsguide", false, true)
dxGridListAddRow(grid, "Erste Schritte", false, false)
dxGridListAddRow(grid, "Berufe", false, false)
dxGridListAddRow(grid, "Fahrzeuge #1", false, false)
dxGridListAddRow(grid, "Fahrzeuge #2", false, false)
dxGridListAddRow(grid, "Immobilien, Bedürfnisse", false, false)
dxGridListAddRow(grid, "Inventar, Waffen, Tod", false, false)
dxGridListAddRow(grid, "Rollenspiel, OOC, IC", false, false)
dxGridListAddRow(grid, " ", false, true)

dxGridListAddRow(grid, "Serverregeln", false, true)
dxGridListAddRow(grid, "Allgemeine Regeln (§1)", false, false)
dxGridListAddRow(grid, "Community (§2-3)", false, false)
dxGridListAddRow(grid, "Verbote (§5-8)", false, false)
dxGridListAddRow(grid, "Verbote, Firmen (§9-12)", false, false)
dxGridListAddRow(grid, "Gangs (§13)", false, false)
dxGridListAddRow(grid, "Gangwars (§14)", false, false)
dxGridListAddRow(grid, " ", false, true)

dxGridListAddRow(grid, "Gesetze", false, true)
dxGridListAddRow(grid, "Grundrechte #1 (§1)", false,false)
dxGridListAddRow(grid, "Grundrechte #2 (§1)", false,false)
dxGridListAddRow(grid, "Exekutive und Judikative (§2)", false,false)
dxGridListAddRow(grid, "Organisationen (§3)", false,false)
dxGridListAddRow(grid, "Sonstiges (§4-5) & Anh.", false,false)
dxGridListAddRow(grid, " ", false, true)

dxGridListAddRow(grid, "Straßenverkehrsordnung", false, true)
dxGridListAddRow(grid, "Grundregeln, Geschwindigkeit", false,false)
dxGridListAddRow(grid, "Überholen, Vorfahrt", false,false)
dxGridListAddRow(grid, "Halten, Parken, Licht", false,false)
dxGridListAddRow(grid, "Autobahn, Pflicht, Scheine", false,false)
dxGridListAddRow(grid, "Unfall, Sonstiges", false,false)
dxGridListAddRow(grid, " ", false, true)

dxGridListAddRow(grid, "Strafkatalog", false, true)
dxGridListAddRow(grid, "Allgemeine Straftaten", false,false)
dxGridListAddRow(grid, "Straftaten ggb. Staatsgew.", false,false)
dxGridListAddRow(grid, "Illegale Items, Diebstahl", false,false)
dxGridListAddRow(grid, "Demonstrationen, Sonstiges", false,false)
dxGridListAddRow(grid, "Verkehrsdelikte #1", false,false)
dxGridListAddRow(grid, "Verkehrsdelikte #2", false,false)
dxGridListAddRow(grid, "Verkehrsdelikte #3", false,false)

setElementData(getLocalPlayer(), "inHelp", false)

function updateCamera ()
	dxSetVisible(grid, false)
	if rulesAlpha ~= 0 or showRules == true then
		local sel = dxGridListGetSelectedItem(grid)
		dxSetVisible(grid, true	)
		if showRules == true and rulesAlpha+incDec <= 1 then rulesAlpha = rulesAlpha + incDec elseif showRules == true then rulesAlpha = 1 end
		if showRules == false and rulesAlpha-incDec >= 0 then rulesAlpha = rulesAlpha - incDec elseif showRules == false then rulesAlpha = 0 end
		dxDrawRectangle ( screenWidth/2-320, screenHeight/2-240, 640, 480, tocolor(0,0,0,200*rulesAlpha) )
		dxSetAlpha( grid, rulesAlpha )
		if sel and daRules[sel] then
			dxDrawText ( daRules[sel], screenWidth/2-120,screenHeight/2-215,  screenWidth/2+315, screenHeight/2+235, tocolor(255,255,255,255*rulesAlpha), 1, "default-bold", "left", "top", true, true)
		else
			dxDrawText (daStandartText, screenWidth/2-120,screenHeight/2-215,  screenWidth/2+315, screenHeight/2+235, tocolor(255,255,255,255*rulesAlpha), 1, "default-bold", "left", "top", true, true)
		end
		dxDrawShadowedText("The Vita Village - Hilfemenü",screenWidth/2-315,screenHeight/2-235, screenWidth, screenHeight, tocolor(240,240,180,255*rulesAlpha),tocolor(0,0,0,255*rulesAlpha), 1, "default-bold" , "left", "top", false, false, false, true)
	end
end
addEventHandler ( "onClientRender", root, updateCamera, true, "high+10" )


bindKey ( "F1", "down", function()
	if getElementData(getLocalPlayer(), "isPlayerLoggedIn") == true then
		showRules = not showRules
		setElementData(getLocalPlayer(), "inHelp", showRules)
		if showRules == true then
			if isCursorShowing() then
				hideCursor = false
			else
				showCursor(true)
				hideCursor = true
			end
		else
			if hideCursor == true then
				showCursor(false)
			end
		end
	else
		showRules = false
	end
end )

daStandartText = [[Herzlich Willkommen in der Hilfe von The Vita Village!
Gamemode erstellt von Sebastian 'Sebihunter' M. und dem Vita Team.

In dieser Hilfe findest du alle Informationen, die du zum Spielen auf unserem Server benötigst.

Solltest du weitere Fragen haben kannst du direkte Hilfe von einem unserer Teammitglieder über /report beantragen.

Forum: www.vita-online.eu
Teamspeak³: ts.vita-online.eu]]

----------------------------------------------------------------------
----------------------------------------------------------------------BEFEHLE
----------------------------------------------------------------------
daRules = {}
daRules[2] = [[Bei Vita gibt es im Gegensatz zu anderen Servern wenige Pickups

Du musst stattdessen öfters auf das wichtige Objekt oder Ped klicken, indem du mit der Taste 'm' die Maus aufrufst.

Im Anhang eine kleine Liste, auf was du im Moment alles klicken kannst:
Fahrzeuge -> Für Informationen und zum Auf-/Absperren sowie Tanken
NPCs (z.B. Im Shop) -> Zum Ansprechen
ATM's (Geldautomaten) -> Zugriff aufs Konto
Abgelegte Items -> Zum Aufnehmen
Keypads -> Tore oder Hebebühnen
Dein Bild im HUD -> Inventar]]

daRules[3] = [[Tastenbelegung:
F1 - Hilfe
F11 - Karte
M - Klicksystem (Mauszeiger)
F - in Häusern bei Toilette oder Badewanne/Dusche um zu Benutzen!
F - Aufheben von Items
X - Gang Chat
Y - Teamchat / Jobfunk
B - Lokaler-OOC Chat 
N - Tempomat
I - Inventar
J - Firmen GUI
Z - Gang GUI
U - AutoFix LV Tor / Newschat

num_3 - Zentralverriegelung
num_7 - Anhänger abkuppeln (Custombind: /abkuppeln)
num_8 - Abblendlicht (Custombind: /licht)
num_4, num_5, num_6 - Blinker (links, Warnblinker, rechts) [Custombinds: /indicator_left,/indicator_both,/indicator_right)
num_1/ C - Motor
num_/, num_* - Sirenen (Custombinds: /siren_1,/siren_2,/sani_1,/sani_2,/feuer_1,/feuer_2,/afix)
num_+, num_-, num_entf - Megafon (Custombinds: /megaphone_1,/megaphone_2,/megaphone_3)
num_-, num_+, strg/ctrl - Heli-Magnet (Custombinds: /magnet_tow,/magnet_up,/magnet_down,/magnet_stop)]]


daRules[4] = [[Allgemein:
/abschleppen
/schlafen
/perso [Spielername]
/autoabgeben [Spielername]
/schluesselabgeben [Spielername1] [Spielername2] [Spielername3]...
/autosanzeigen ([Modellname])
/häuseranzeigen
/sende [Spielername] [Betrag]
/afk
/togooc
/togvi
/ego
/kuendigen
/hidetacho
/verkaufehaus [HausID] (80 Prozent des Preises wird zurückerstattet)
/setschluessel [HausID] [Bewohner 1],[Bewohner 2]
/setbesitzer [HausID] [Neuer Besitzer]
/stopmiete [HausID]
/passwort [Altes Passwort] [Neues Passwort]
/werbung [Text] (Preis = 10 Vero pro Buchstabe)
/telefonbuch [Name]
/anrufen [Nummer]
/sms [Nummer] [Text]
/110 [Grund] - Polizei
/112 [Grund] - Sanitäter
/113 [Grund] - Feuerwehr
/fschule [Grund] - Fahrlehrer
/taxi
/autofix [Grund] - Mechaniker]]
 
 daRules[5] = [[Firmenchef:
/entlassen [Spielername]
/einstellen [Spielername]
/rang [Spielername] [Rang ID (0=Azubi, 1=Mitarbeiter, 2=Chef)]
/autoanfirma

Gangs:
/gangverlassen
/rausausgang [Spielername]
/aufingang [Spielername]
/autoangang
/gangwar
/gangcall
/ausrauben (In Tankstelle)
 
Ares Automobiles:
/bestellen [Fahrzeug]
/verkaufe [Betrag]
/reserviere [Niemand/ Vorname.Nachname]
/rep
/checktuev
/tuev
 
Gebrauchtwagenhändler:
/autoanfirma
/gwverkauf [Preis] (Geht nur wenn das Auto der Firma gehört)
/reserviere [Niemand/ Vorname.Nachname]
/gwrep ]]

 daRules[6] = [[AutoFix:
/reparieren
/motorrep
/wasser
/oel
/batterie
/ab
/abdel
/magnet
/annehmen [Ereignis (Waffenschein,Führerschein,Rechnung,Heilung)]
/markierte
/einladen (DFT-30 und Pony)
/ausladen (DFT-30 und Pony)
/verwahrung
/abschleppen
 
InterTrans:
/auspacken
/checkausliefern
 
Reporter:
/news [TEXT]
/setinterview [Spielername] [0/1]
/lotto [status/preis/max] ]]
 
 daRules[7] = [[Sanitäter:
/heilen [Spielername] [Geld]
/wiederbeleben [Spielername]
/annehmen [Ereignis (Waffenschein,Führerschein,Rechnung,Heilung)]
/rtwlicht
 
Feuewehr:
/ab
/abdel
 
Polizei #1:
/blitzer [Geschwindigkeit 1-200]
/delblitzer [ID]
/wschein [Spielername] [WaffenscheinID] [Preis]
/pif [Spielername] [Punkte]
/ab
/abdel
/jailtime
/forceperso [Spielername] ]]
 
 daRules[8] = [[Polizei #2:
/handschellen [Spielername]
/einsperren [Spielername] [0/1] [Zelle 1-6] [Zeit in Minuten(bei null oder keiner eingabe unendlich)]
/fscheinweg [Spielername] [FscheinID (Auto-Führerschein=1, Motorradschein=2, Gefahrgutschein=3, Flugschein=4)]
/waffenabnehmen [Spielername]
/waffencheck [Spielername]
/grascheck [Spielername]
/grasabnehmen [Spielername]
/annehmen [Ereignis (Waffenschein,Fürhrerschein,Rechnung,Heilung)]
/tasertoggle
/zeigeakte
/mega [Text]
/addakte [Aktenname] [Text]
/wlevel [Aktenname] [0-6]
/removeeintrag [Aktenname] [Eintrag ID]
/removeakte [Aktenname]
/eskortlicht
/alkotest
/falschparker [Mindesttage zur Auslösung]
/pcall
/panote [0-100] ]]

daRules[9] = [[Staatsverwaltung:
 /haus
 /besitzer [HausID] [Besitzer1],[Besitzer2],[Besitzer3]...
 /miete [HausID] [Preis]
 /preis [HausID] [Preis] 
 /hausverlegen [HausID]
 /changeint [HausID] [Interior]
 /intliste
 /zeigeakte
 /addakte [Aktenname] [Text]
 /wlevel [Aktenname] [0-6]
 /removeeintrag [Aktenname] [Eintrag ID]
 /removeakte [Aktenname]
 /verwahrung
 /oeffneauto
 /falschparker
 
Fahrschule:
 /fschild
 /fschein [Spielername] [FscheinID (Auto-Führerschein=1, Motorradschein=2, Gefahrgutschein=3, Flugschein=4)] [0/1] [Preis]
 /pif [Spielername] [Punkte]
 ]]
 
----------------------------------------------------------------------
----------------------------------------------------------------------EINSTIEGSGUIDE
----------------------------------------------------------------------

daRules[12] = [[The Vita Village basiert auf einem Selfmade-Script und ist daher anders, als der Großteil der übrigen Server in MTA:SA.
Um den Einstieg zu erleichtern hier einige Dinge, die du zuerst machen solltest:

-> Hole deinen temporären Führerschein bei der Fahrschule LV neben dem Stadion
-> Kaufe dir ein Auto beim Anfängerautohaus in San Fierro, dem Gebrauchtwagenhändler in LV oder Ares Automobiles
-> Verdiene Geld und steige im Level durch Minijobs oder Hauptberufe. Infos gibt es in der Stadthalle (gelber Punkt neben dem LVPD)
-> Mache bei der Polizei einen richtigen Führerschein
-> Kaufe eine Immobilie um einen Schlafplatz zu haben
-> Fragen direkt an die Administration (/report)
-> Komme wenn möglich auf unseren Teamspeak (IP: ts.vita-online.eu)
-> Habe Spaß auf The Vita Village
]]

daRules[13] = [[Du hast 2 verschiedene Möglichkeiten einen Beruf auszuüben. Einmal durch einen Hauptberuf und/oder mit einem Nebenjob.
	
Der Hauptberuf in einem Unternehmen (auch Fraktion genannt) kann der Autoverkäufer bei Ares Automobiles, Mechaniker beim Autofix, Trucker bei InterTrans, Polizist beim SAPD, Gebrauchtwagenhändler beim AUTOHUS, Reporter bei viNETWORK oder Sanitäter vom Krankenhaus sein.
	
Um bei einem Unternehmen zu arbeiten musst du dich im Forum (www.vita-online.eu) bei dem jeweiligen Chef in seinem Bereich bewerben.
Gehalt und Firmenfahrzeuge sind abhängig von der Gestaltung des Berufes und des Chefes. Einem Unternehmen beizutreten lohnt sich auf alle Fälle!
	
Um auch ohne Mitarbeit in einem Unternehmen Geld verdienen und im Level aufsteigen zu können gibt es Nebenberufe (auch Minijobs genannt).
Eine genaue Information zu allen verfügbaren Nebenberufen findest du in der Stadthalle. Diese befindet sich beim gelben Punkt auf der 'F11' Map in der Nähe der Polizeistation von Las Venturas.]]

daRules[14] = [[Fahrzeugkauf:
Du kannst dir dein Auto bei einem Autohändler beim Autohaus oder bei dem Gebrauchwagenhändler kaufen. Es gibt auch im Autohaus am San Fierro Bahnhof jederzeit eine Auswahl an netten Startfahrzeugen, die jedoch erhöte Preise haben.

Pannen & Reparatur:
Wenn du eine Panne hast und kein AutoFix online ist kannst du ein Reparaturkit verwenden (50% des Fahrzeugschadens wird maximal repariert). Ist ein AutoFix Mechaniker online so musst du diesen mit /adac um Hilfe bitten.
Du kannst dein Fahrzeug auch bei jedem Pay'N'Spray wieder funktionsfähig machen. Visueller Schaden (Deformierungen, Fenster, Türen) kann nur in einer der AutoFix Fillialen repariert werden.

Parken:
Du kannst dein Auto auf jedem Parkplatz parken. Wenn du wo anders parkst z.B. auf der Strasse, dann wird es kostenpflichtig abgeschleppt.
Sollte dein Auto abgeschleppt werden, weil du falsch geparkt hast, kannst du es in der Verwahrungsstelle neben der Fahrschule LV gegen eine kleine Gebühr abholen.

TÜV:
Fahrzeuge benötigen einen TÜV, wenn du sie im Straßenverkehr verwenden möchtest. Den TÜV gibt es für alle Fahrzeuge mit Kennzeichen bei AutoFix und muss alle 2 Wochen erneuert werden.]]

daRules[15] =   [[Tacho:
Sobald du in ein Auto steigst siehst du unten das Tacho welches du komplett mit den Num-Tasten steuern kannst. (Info in der Hilfe unter 'Binds')
Auch siehst du dort sobald dein Öl, Wasser oder die Batterie bei einem Mechaniker gewechselt werden muss.
	
Tanken:
Dein Auto muss nach einer weile auch mal aufgetankt werden. Das kannst du bei einer Tankstelle tun indem du mit der mittleren Maustaste auf das Fahrzeug klickst.

Führerschein:
Führerscheine machst du direkt bei einem Fahrlehrer (/fschule). Ist kein Fahrlehrer im Dienst kannst du den Kurzzeitführerschein für einer Woche in der alten Fahrschule Las Venturas nahe des Stadions machen.]]

daRules[16] =   [[Immobilien:
Du kannst dir dein Eigenes Haus mieten/kaufen wo du ein grünes Haus Icon vor dem Haus siehst. Sollte das nicht der Fall sein, so kann ein Admin dir eines erstellen.
In Häusern kannst du deinen Bedürfnissen nachgehen und Items sicher aufbewahren.
	
Bedürfnisse:
Du siehst oben rechts in deinem HUD deine Bedürfnisse. Wenn diese Bedürfnisse 0% erreichen kann es zu Problemen bei deinem Charakter kommen.

-Energie
	/schlafen füllt dieses wieder auf. Auch ein Kaffee aus einem Shop bewirkt Wunder.
	
-Harndrang
	Du kannst dich an jeder beliebigen Toilette bei dir zu Hause oder in einem Restaurant erleichtern.
	
-Hunger
	Diesen kannst du in einem Restaurant wieder stillen.
	
-Hygiene
	Du kannst dich behelfsweise an einem Spülbecken in einem Restaurant, in einem Seee oder bei dir zu Hause waschen.
	Ganz mutige Spieler können sich auch von Feuerwehr und Polizei mit Wasser bewerfen lassen.]]
	
daRules[17] =   [[Inventar:
Du kannst verschiedene Items in Geschäften kaufen. Jedes Item wird in einem Inventar ('I') aufbewart.
Polizisten können verbotene Items in einem Inventar entdecken und gegebenenfalls auch entfernen
	
Waffen:
Für Waffen brauchst du einen Waffenschein, den du dir bei der Polizei über das Forum erwerben kannst.
Gangmitglieder können sich spezielle Wafen bei "Hinterzimmer Joe" kaufen. Für den Standort des Shops frage einen deiner Gangkollegen.
	
Tod:
Solltest du bei einer Reise durch Vita gestorben sein wirst du kostenfrei vom Sanitäterwieder wiederbelebt oder im Krankenhaus in Las Venturas geheilt und respawnt.
Beim Respawn im Krankenhaus verlierst du dein komplettes Geld, welches auf deinem Todesstandort von jedem aufgenommen werden kann. Um dem Vorzubeugen ist es ratsam, den Großteil des Geldes an einem ATM (Bankautomat) einzuzahlen.]]	

daRules[18] =   [[Roleplay:
Roleplay ist eine gewisse Spielart, wie der Name es schon sagt,  ein Rollenpiel. Man spielt eine bestimmte Rolle, zum Beispiel Polizist oder Mechaniker. Auf Vita ist es ungern gesehen, wenn deine Rolle nicht in unser realistisches Spielszenario passt (z.B. Superschurke).
 
Metagaming:
Metagaming ist das vermischen von IC und OOC. Dies kann sich darin zeigen, dass du OOC Informationen für IC Aktionen nutzt (z.B. hörst du als Polizist im Teamspeak wo sich die gerade verfolgten befinden und nutzt diese Information).

IC und OOC:
IC steht für In-Character, bedeutet du handelst als dein Rollenspielcharakter. OOC steht für Out-Of-Character, bedeutet, du handelst als du selber, der gerade vorm Computer sitzt und den Charakter steuert.
Ein Beispiel: Man sieht über einem Spieler den man im Rollenspiel noch nicht kennt einen Nametag mit seinem Namen, bedeutet du hast OOC Information. IC kennst du diesen Namen jedoch noch nicht und musst ihn erst fragen, wie er heißt.

Kein Powergaming:
Powergaming bedeutet den Spieler übermächtig zu machen. 
Beispiel: /me benutzt seine Hypnoseuhr und zwingt dich ihm all sein Geld zu geben]]

----------------------------------------------------------------------
----------------------------------------------------------------------SERVERREGELN
----------------------------------------------------------------------

daRules[21] = [[
Im Zweifelsfall gelten die Regeln, welche im Forum niedergeschrieben sind

..::VitaVillage Rollenspiel Regelwerk::..
29.11.2014

§1 Allgemeine Regeln
(1) Das Regelwerk ist zu jeder Zeit einzuhalten. Regeländerungen müssen von der Administration nicht angekündigt werden.
(2) Die Weitergabe von Accountdaten oder des gesamten Account ist verboten.
(2a) Ausnahmen des Absatzes 1 sind möglich, wenn die Projektleitung diesem Handeln zustimmt.
(3) Jeder ist für seinen Account selbst verantwortlich, Missbrauch durch Dritte entlastet nicht von Strafen.
(4) Bestrafungen, die dem ehemaligen Nutzer des Accounts zustehen, werden dennoch geltend gemacht.
(5) Das Einrichten von Doppelaccounts ist verboten. Beim Auffinden solcher Fälle werden alle betroffenen Accountsgebannt/gelöscht.
(6) Sollten mehrere Spieler eine gemeinsame Leitung in Anspruch nehmen und damit die selbe IP Adresse haben, sollte man die Projektleitung informieren.
(7) Sollte ein Datenverlust durch Serverprobleme jeder Art verursacht werden, wird von nichts ersetzt.
(8) Konflikte zwischen Membern sind zu vermeiden.
(9) Jedes Mitglied kann aus verschiedenen Gründen der Community verwiesen bzw. verwarnt und bestraft werden.
(10) Metagaming, Powergaming und Non-RP ist in IC Aktionen verboten.]]

daRules[22] = [[§2 Rechte und Pflichten der Mitglieder
(1) Jedes Mitglied hat das Recht, bei Umfragen über verschiedene Vita bezogene Themen seine Stimme abzugeben.
(2) Die Community wird von der Administration vertreten, welche die Communityleitung übernimmt.
(3) Es ist den Anweisungen der Administration sowie Moderation zu folgen. Die Administration ist nicht zu beleidigen, man soll sie mit Respekt behandeln. Letzteres gilt umgekehrt auch für die Administration.

§4 Bestrafungen
(1) Alle Ahndungen und Bestrafungen werden durch die Administration erhoben.
(2) Mündliche oder schriftliche Ermahnungen können in Sonderfällen oder bei leichten Vergehen vergeben werden.
(3) Timebanns verlieren ihre Wirkung mit dem Ablauf der festgelegten Zeit der Bannung.
(4) Permanentbanns gelten für immer. Bei dieser Art der Bannung wird es dem Spieler unmöglich gemacht, einen neuen Account zu erstellen.
(4a) Sollte es dem Spieler doch gelingen einen neuen Account zu erstellen kann der Account von einem Administrator ohne weitere Begründungen gesperrt werden.]]

daRules[23] = [[§5 Bugs/Bugusing
(1) Unter Bugusing versteht man das Ausnutzen von Programm- oder Scriptfehlern. Dabei ist es unerheblich, ob sich ein direkter Vorteil für den Spieler oder eines Dritten ergibt.
(2) Es ist die Pflicht eines jeden Users, Bugs im Forum zu melden.
(3) Bugusing ist in jeder Hinsicht verboten.

§6 Offlinefucht
(1) Unter Offlineflucht versteht man das Beenden der Verbindung zum Server in Situationen, die in erster Linie nachteilhaft für andere User sind.
(2) Offlineflucht ist untersagt.
(3) AFK-Flucht ist der Offlineflucht gleichgestellt.

§7 Serverwerbung
(1) Das Werben für andere MTA-Server sowie das Verbreiten von externen IP-Adressen wird mit einem permanenten Bann bestraft.
(2) Das Werben für Vita-online.eu im Bereich anderer MTA-Server ist ebenfalls verboten. Verstoß wird mit einem permanenten Bann bestraft.

§8 Beleidigungen, Provokation und Rassismus
(1) Beleidigungen und vor allem Drohungen sind strikt untersagt!
(2) Jegliche Art von Rassismus (Ausländerfeindlichkeit), Nationalsozialismus, Deutschfeindlichkeit und Feindlichkeiten gegen bestimmte ethnische, ideologische oder religiöse Gruppierungen wird mit einem permanenten Bann bestraft.
(2a) Späße und Witze werden dem gleichgestellt.
(3) Mobbing und Provokationen sind strikt untersagt.]]

daRules[24] = [[§9 Betrug
(1) Betrügereien und das Hintergehen sind auf jede Art untersagt.

§10 Deathmatch
(1) Unter Deathmatch (DM/SDM) ist das sinnlose Angreifen oder Töten von Dritten zu verstehen.
(2) Deathmatch (Töten, Angreifen) ist grundsätzlich verboten:

§11 Drive-By
()1) Unter Drive-By versteht man:
1. das Schießen aus einem Fahrzeug auf Zivilisten
2. das Töten eines Dritten mit den Rotoren eines Flugobjektes als Fahrzeugführer,
3. das Tot parken eines Dritten als Fahrer oder direkter Verursacher,
4. das Anrichten eines nicht unerheblichen Schadens an einen Dritten durch ein Fahrzeug als Fahrzeugführer.
(2) Z1 und Z4 sind solange man zuerst attackiert wird erlaubt.
(3) Polizisten dürfen nach erfolglosem Anhalteversuch das Fahrzeug mit Schüssen auf die Reifen stoppen. Das Verbot des Drive-By wird hier nicht beachtet.

§12 Firmen
(1) Firmenchefs müssen sich bei Inaktivität (nicht aktiv im Forum) in deren Organisationsforum abmelden um missverständnissen entgegenzuwirken und einen Stellvertreter für diese Zeit ernennen.
(2) Die Administration hat kein Recht, Leute in Firmen einzustellen oder deren Rang zu ändern. Dies darf nur von den Firmenchefs gemacht werden.
(2b) Ist eine Organisation Cheflos, so ist diese Regel revidiert.
(3) Firmenchefs dürfen von der Administration unter gegebenen Umständen ausgetauscht werden.]]

daRules[25] =[[§13 Gangs
(1) Gangleader müssen sich bei Inaktivität (nicht aktiv im Forum) in deren Gangforum abmelden um missverständnissen entgegenzuwirken und einen Stellvertreter für diese Zeit ernennen.
(2) Die Administration hat kein Recht, Leute in Gangs einzustellen oder deren Rang zu ändern. Dies darf nur von den Gangleadern gemacht werden.
(2b) Ist eine Gang leaderlos, so ist diese Regel revidiert.
(3) Gangleader dürfen von der Administration unter gegebenen Umständen ausgetauscht werden.
(4) Zivilisten dürfen während eines Gangwars nicht angegriffen werden, solange diese nicht selbst Gewalt anwenden.
(5) Die Basis einer Gang ist ihr Hochheitsgebiet. In diesen gilt das Gesetzbuch nicht.
(6) Der Gangleader muss seine Mitglieder am Gewinn der Bezirkseroberung teilhaben lassen. Er hat die Waffen für Gangwars mit den Einnahmen der Gang zu bezahlen.
(7) Polizisten dürfen Gangaktionen nicht in ihrer Uniform betreiben. Auch von anderen Gangs sind sie während sie im Dienst sind nicht als feindliche Gangmitglieder zu sehen.
(8) Gangs dürfen sich nur in Gebieten in denen ein Gangwar stattfindet gegenseitig angreifen.
(9) Ausgeschlossene Vehicle welche im Gangwar nicht erlaubt sind: Helikopter
(10) Es sind nur Waffen der Waffenstufe 2 und vom Hinterzimmer Joe erlaubt
(11) Keine Gang hat das Recht eine Blacklist zu erstellen!
(12) Jegliche Interaktionen zwischen Gangs, Zivilisten und Unternehmen, ausgenommen der Polizei, sind Verboten und zu unterlassen.]]

daRules[26] =[[§14 Gangwar Regeln
(1) Die Mitgliederanzahl der teilnehmenden Gangs muss nicht exakt die Selbe sein.
(2) Es dürfen Autos zum verstecken (dahinter ducken) benutzt werden.
(3) Bei einem Gang War darf man keine Fahrzeuge verwenden. (Drive-By, Flüchten etc.)
(4) Nachdem ein Gangwar beendet worden ist, darf die Gang sofort einen weiteren starten.
(5) Nach Respawn am Krankenhaus darf das Gebiet, in dem der Gangwar statt findet, bis zum Ende nicht mehr betreten werden.
(6) Helikopter sind bei Gangwars nicht erlaubt. Ausgenommen von dieser Regelungen sind Ganggebiete, die nur per Wasser oder zu Luft erreicht werden können.
(7) Während eines Gangwars darf man nicht von Sanitätern geheilt werden. Verbandszeug ist gestattet.
(8) Es ist verboten im Dienst bei einem Gangwar mitzuarbeiten.
(9) Zivilisten sowie Polizisten dürfen sich nicht in Gangwars einmischen. Falls jemand das Ganggebiet während eines Gangwars betritt, darf er erschossen werden, ohne dass der Mörder, solange er ein Gangmitglied welches sich gerade im Gangwar befindet ist, mit Konsequenzen rechnen muss.
(10) Ein Kampf, der direkt einem Gangwar anschließt und im selben Gebiet stattfindet, wird nicht als SDM gewertet. 
(11) Während eines Gangwars darf kein Gebiet der Angreifer von einer anderen Gang angegriffen werden, um sie damit zum Rückzug zu zwingen. Diese Regel gilt nicht, wenn mehr als 5 Mitglieder der angreifenden Gang am Server sind.]]
----------------------------------------------------------------------
----------------------------------------------------------------------GESETZE
----------------------------------------------------------------------


daRules[29] = [[§1 Grundrechte #1
(a) Die Würde des Menschen ist unantastbar. Sie zu achten und zu schützen ist Verpflichtung aller staatlichen Gewalt.
(b) Jeder hat das Recht auf die freie Entfaltung seiner Persöhnlichkeit, soweit er nicht die Rechte anderer verletzt und nicht gegen die verfassungsmässige Ordnung oder das Sittengesetz verstösst.
(c) Jeder hat das Recht auf Leben und körperliche Unversehrtheit. Die Freiheit der Person ist unverletzlich. In diese Rechte darf nur auf Grund eines Gesetzes eingegriffen werden.
(d) Alle Menschen sind vor dem Gesetz gleich.
(e) Männer und Frauen sind gleichberechtigt. Der Staat fördert die tatsächliche Durchsetzung der Gleichberechtigung von Frauen und Männern und wirkt auf die Beseitigung bestehender Nachteile hin.
(f) Niemand darf wegen seines Geschlechtes, seiner Abstammung, seiner Rasse, seiner Sprache, seiner Heimat und Herkunft, seines Glaubens, seiner religiösen oder politischen Anschauungen benachteiligt oder bevorzugt werden. Niemand darf wegen seiner Behinderung benachteiligt werden.
(g) Jeder hat das Recht, seine Meinung in Wort, Schrift und Bild frei zu äussern und zu verbreiten und sich aus allgemein zugänglichen Quellen ungehindert zu unterrichten. Die Pressefreiheit und die Freiheit der Berichterstattung durch Rundfunk und Film werden gewährleistet. Eine Zensur findet nicht statt.
(h) Diese Rechte finden ihre Schranken in den Vorschriften der allgemeinen Gesetze, den gesetzlichen Bestimmungen zum Schutze der Jugend und in dem Recht der persönlichen Ehre.
(i) Alle Bürger haben das Recht, sich ohne Anmeldung oder Erlaubnis friedlich und ohne Waffen zu versammeln.
(j) Für Versammlungen unter freiem Himmel kann dieses Recht durch Gesetz oder auf Grund eines Gesetzes beschraenkt werden.]]

daRules[30] = [[§1 Grundrechte #2
(k) Alle Bewohner von San Andreas haben das Recht, Vereine und Gesellschaften zu bilden.
(l) Vereinigungen, deren Zwecke oder deren Tätigkeit den Strafgesetzen zuwiderlaufen oder die sich gegen die verfassungsmässige Ordnung oder gegen den Gedanken der Völkerverständigung richten, sind illegal und können Strafrechtlich verfolgt und gegebenenfalls von der Exekutive aufgelöst werden.
(m) Alle Bürger haben das Recht, Beruf, Arbeitsplatz und Ausbildungsstätte frei zu wählen. Die Berufsausübung kann durch Gesetz oder auf Grund eines Gesetzes geregelt werden.
(n) Niemand darf zu einer bestimmten Arbeit gezwungen werden, ausser im Rahmen einer herkoemmlichen allgemeinen, fuer alle gleichen oeffentlichen Dienstleistungspflicht.
(o) Zwangsarbeit ist nur bei einer gerichtlich angeordneten Freiheitsentziehung zulässig.
(p) Die Wohnung ist unverletzlich.
(q) Jedermann hat das Recht, sich einzeln oder in Gemeinschaft mit anderen schriftlich mit Bitten oder Beschwerden an die zuständigen Stellen und an die Volksvertretung zu wenden.
(r) Wer die Freiheit der Meinungsäusserung, insbesondere die Pressefreiheit, die Versammlungsfreiheit, die Vereinigungsfreiheit oder das Eigentum zum Kampfe gegen die freiheitliche demokratische Grundordnung missbraucht, verwirkt diese Grundrechte. Die Verwirkung und ihr Ausmass werden durch das Bundesverfassungsgericht ausgesprochen.]]

daRules[31] = [[§2 Exeku- Judikative
(a) Die Polizei ist die einzige Exekutive im Staat. Sie hat Recht Strafen zu verhängen und ist für die allgemeine Einhaltung aller Gesetze zuständig.
(b) Die Strafen richten sich nach dem Strafgesetzbuch, können jedoch unter gewissen Umständen auch vom Polizisten nach eigenem ermessen entschieden werden.
(c) Jeder Bürger hat das Recht auf sofortige Information über den Grund der Festnahme.
(d) Ein Verdächtiger hat einen richterlichen Prozess im Forum zu beantragen, wobei der von der SASO anerkannte Richter einen Gerichtstermin festlegt. Ab der Beantragung gilt es festzustellen, ob Untersuchungshaft angemessen ist und wird gegebenenfalls bis zum Gerichtstermin durchgeführt.
Es ist dem Verdächtigen bei bereits laufendem Prozess nicht gestattet einen weiteren Prozess zu beantragen, es sei denn es besteht eine ausdrückliche Erlaubnis der SASO. 
(e) Die maximale Zeit für einen Knastaufenthalt, ausgenommen der Untersuchungshaft, beträgt 2 Stunden.
(f) Hanschellen dürfen nur bei Gefahr und bei begründetem Fluchtverdacht angelegt werden.
(g) Während einer Fahrprüfung darf weder der zu Prüfende noch der Fahrlehrer von der Polizei angehalten, noch eine Strafe bekommen. Ausgenommen sind Unfälle mit Personen- oder Sachschaden, wobei hierbei der Fahrlehrer haftet.]]

daRules[32] = [[§3 Organisationen
(a) Jede Organisation hat einen quasi Monopolstatus. Daher hat der Leiter einer Organisation die Preise zu senken, wenn die Mehrheit der Bürgerschaft das verlangt und das SASO dem zustimmt. In schlimmen Fällen muss die Organisation einen Teil der überteuerten Preise an die Kunden zurückzahlen.
(b) Ansonsten hat jeder Chef das Recht, seine Preise zu ändern, ausser ihm wurde das Recht dazu vom SASO wegen Überteuerung einmal entzogen.
(c) Jede Organisation darf eigene Preise und Regeln aufstellen, die jedoch nicht über ihre Dienste und Grundstücke hinausgehen dürfen.]]

daRules[33] = [[§4 Abschleppwagengesetz
(a) Der Abschleppwagen ist ein Fahrzeug mit besonderen Fähigkeiten, welches zertifizierten Abschlepporganisationen (z.B. AutoFix) vorbehalten ist.
(b) Der Traktor, welcher ebenfalls zum Abschleppen verwendet werden kann, fällt nicht unter das Abschleppwagengesetz.
(c) Ein Verstoß gegen das Abschleppwagengesetz kann zu einer Geldstrafe von bis zu 150.000,- Vero führen.

§5 Parlamentsgesetz
(a) Aktive Parlamentarier dürfen kein Mitglied einer Gang sein.
(b) Wahlmanipulation, Wahlbetrug und Bestechung sind verboten.


Anhang:
Es gilt desweiteren das deutsche Gesetz, sofern es nicht in irgendeiner Weise durch die hier stehenden Regelungen und Gesetze überschrieben wird und es sich in das Spiel integrieren lässt. Es ist zu Rate zu ziehen, falls ein Fall eintritt, in dem keine Gerechtigkeit durch die hier stehenden Gesetze gewährleistet werden kann. ]]

daRules[36] = [[§ 1 Grundregeln
(1) Die Teilnahme am Straßenverkehr erfordert ständige Vorsicht und gegenseitige Rücksicht.
(2) Wer am Verkehr teilnimmt hat sich so zu verhalten, dass kein Anderer geschädigt, gefährdet oder mehr, als nach den Umständen unvermeidbar, behindert oder belästigt wird.

§ 2 Straßenbenutzung durch Fahrzeuge
(1) Fahrzeuge müssen die Fahrbahnen benutzen, von zwei Fahrbahnen die Rechte. Seitenstreifen sind nicht Bestandteil der Fahrbahn.
(2) Mit Fahrrädern muss einzeln hintereinander gefahren werden; nebeneinander darf nur gefahren werden, wenn dadurch der Verkehr nicht behindert wird.

§ 3 Geschwindigkeit
(1) Wer ein Fahrzeug führt, darf nur so schnell fahren, dass das Fahrzeug ständig beherrscht wird. Die Geschwindigkeit ist insbesondere den Straßen-, Verkehrs-, Sicht- und Wetterverhältnissen sowie den persönlichen Fähigkeiten und den Eigenschaften von Fahrzeug und Ladung anzupassen.
(2) Ohne triftigen Grund dürfen Kraftfahrzeuge nicht so langsam fahren, dass sie den Verkehrsfluss behindern.
(3) Die zulässige Höchstgeschwindigkeit beträgt auch unter günstigsten Umständen
1. innerhalb geschlossener Ortschaften für alle Kraftfahrzeuge 80 km/h.
2. außerhalb geschlossener Ortschaften für alle Kraftfahrzeuge 150km/h
3. Auf Autobahnen ist die Geschwindigkeit nicht reglementiert
4. Auf Parkhäusern, Firmengeländen und Parkplätzen eine maximal Geschwindigkeit von 50km/h]]

daRules[37] = [[§ 4 Überholen
(1) Es ist links zu überholen.
(2) Überholen darf nur, wer übersehen kann, dass während des ganzen Überholvorgangs jede Behinderung des Gegenverkehrs ausgeschlossen ist. Überholen darf ferner nur, wer mit wesentlich höherer Geschwindigkeit als der zu Überholende fährt.
(3) Das Ausscheren zum Überholen und das Wiedereinordnen sind rechtzeitig und deutlich anzukündigen; dabei sind die Fahrtrichtungsanzeiger (Blinker) zu benutzen.
(4) Wer überholt wird, darf seine Geschwindigkeit nicht erhöhen. Wer ein langsameres Fahrzeug führt, muss die Geschwindigkeit an geeigneter Stelle ermäßigen, notfalls warten, wenn nur so mehreren unmittelbar folgenden Fahrzeugen das Überholen möglich ist.

§ 5 Vorfahrt
(1) An Kreuzungen und Einmündungen hat die Vorfahrt, wer von rechts kommt.
Das gilt nicht,
a) wenn die Vorfahrt durch Verkehrszeichen, nicht Ampeln, besonders geregelt ist oder
b) für Fahrzeuge, die aus einem Feld- oder Waldweg auf eine andere Straße kommen,
c) für ausparkente Fahrzeuge und Fahrzeuge, die von einem Grundstück kommen

§ 6 Abbiegen, Wenden und Rückwärtsfahren
Wer abbiegen will, muss dies rechtzeitig und deutlich ankündigen; dabei sind die Fahrtrichtungsanzeiger (Blinker) zu benutzen.]]

daRules[38] = [[§ 7 Halten und Parken
(1) Das Halten ist unzulässig
a) an engen und an unübersichtlichen Straßenstellen,
b) im Bereich scharfer Kurven,
c) auf Bahnübergängen.
(2) Wer sein Fahrzeug verlässt oder länger als drei Minuten hält, der parkt.
(3) Das Parken ist nur auf extraausgewiesenen Parkflächen zulässig.
(4) Fahrzeuge mit einer Panne sind von §7 nicht betroffen.

§ 8 Liegenbleiben von Fahrzeugen
Bleibt ein mehrspuriges Fahrzeug an einer Stelle liegen, an der es nicht rechtzeitig als stehendes Hindernis erkannt werden kann, ist sofort Warnblinklicht einzuschalten.

§ 9 Beleuchtung
Während der Dämmerung, bei Dunkelheit oder wenn die Sichtverhältnisse es sonst erfordern, sind die vorgeschriebenen Beleuchtungseinrichtungen zu benutzen. Die Beleuchtungseinrichtungen müssen intakt sein]]

daRules[39] = [[§ 10 Autobahnen
(1) Autobahnen dürfen nur mit Kraftfahrzeugen benutzt werden, deren durch die Bauart bestimmte Höchstgeschwindigkeit mehr als 90 km/h beträgt
(2) Auf Autobahnen darf nur an gekennzeichneten Anschlussstellen eingefahren werden
(3) Der Verkehr auf der durchgehenden Fahrbahn hat die Vorfahrt.
(4) Wenden und Rückwärtsfahren sind verboten.
(5) Halten, auch auf Seitenstreifen, ist verboten.
(6) Zu Fuß Gehende dürfen Autobahnen nicht betreten.

§ 11 Sonstige Pflichten von Fahrzeugführenden
(1) Das Fahrzeug muss ein Kennzeichen besitzen.
(2) Der Fahrzeugführer darf nicht unter Einfluss von Drogen stehen.

§ 12 Führerscheine
(1) Ohne einen Führerschein ist das Betreiben von Fahrzeugen verboten.
(2) Der temporäre Führerschein gilt für alle Führerscheinklassen außer dem Flugschein.
(3) Der LKW Führerschein wird für alle größeren Fahrzeuge wie Lieferwägen, Busse und LKWs benötigt.]]

daRules[40] = [[§ 12 Übermäßige Straßenbenutzung
(1) Rennen mit Kraftfahrzeugen sind verboten.

§ 13 Unfall
(1) Nach einem Verkehrsunfall hat jeder Beteiligte
1. unverzüglich zu halten,
2. sich über die Unfallfolgen zu vergewissern,
3. Verletzten zu helfen
4. Ggf. Polizei und/oder Rettungsdienst verständigen

§ 14 Sonderrechte
(1) Von den Vorschriften dieser Verordnung sind die Polizei, die Feuerwehr, der Rettungsdienst befreit, soweit das zur Erfüllung hoheitlicher Aufgaben dringend geboten ist.
(2) Die Sonderrechte dürfen nur unter gebührender Berücksichtigung der öffentlichen Sicherheit und Ordnung ausgeübt werden.

§ 15 Schlusssatz
(1) Die Straßenverkehrsordnung kann ggf. durch den Strafkatalog ergänzt werden.
(2) Änderungen bleiben dem San Andreas Police Department sowie dem San Andreas State Office vorbehalten.]]

----------------------------------------------------------------------
----------------------------------------------------------------------STRAFKATALOG
----------------------------------------------------------------------

daRules[43] = [[Allgemeine Straftaten:
Körperverletzung mit Faust
--> 5000 Vero
Körperverletzung mit Schlagwaffe
--> 7500 Vero
Körperverletzung mit Schusswaffe
--> 10000 Vero + 20 Minuten
Allgemeine Morde
--> 10000 Vero + 20 Minuten
Beleidigungen gegen Passanten
--> 250 Vero
Beleidigung gegen Polizeibeamte
--> 500 Vero
Betreten eines Sperrgebietes
--> 1500 Vero + 10 Minuten
Einbruch auf Firmengrundstücken
--> 750 Vero + 5 Minuten + 1 Stunde Hausverbot
Hausfriedensbruch
--> 1500 Vero
Ruhestörung
--> 500 Vero
Geiselnahme
--> 8000 Vero + 45 Minuten
Beihilfe zur Geiselnahme
--> 5000 Vero + 30 Minuten
Be-/Drohung
--> 800 Vero
allgemeine Waffennutzung
 --> 1200 Vero + Waffenscheinentzug]]
 
daRules[44] = [[Straftaten gegenüber Staatsgewalt:
Befehlsverweigerung
--> 750 Vero
Falschaussage
--> 500 Vero
Flucht vor Beamten
--> 1500 Vero + 15 Minuten
Allgemeine Markerflucht
--> 2500 Vero + 30 Minuten
Allgemeine Offlineflucht
--> 4000 Vero + 45 Minuten
allgemeine Suizidflucht
--> 4000 Vero + 45 Minuten
Hausflucht
--> 2500 + 30 Minuten
Baseflucht (Fraktion+Gang)
--> 4000 + 60 Minuten
Beamtenbehinderung
--> 500 Vero
Beamtenbeleidung
--> 500 Vero
Knastausbruch (als Gefangener)
--> 2500 Vero
Beihilfe zum Knastausbruch (als Gangmitglied)
--> 5000 Vero + 15 Minuten
]]

daRules[45] = [[Besitz illegaler Gegenstände:
Besitz von illegalen Waffen
--> 5000 Vero + 10 Minuten
Verkauf von illegalen Waffen
--> 10000 Vero + 20 Minuten
Illegaler Besitz von Drogen
--> 3000 Vero
Illegales Anbauen/Abbauen von Drogen
--> 2000 Vero
Illegaler Verkauf von Drogen/Joints
--> 5000 Vero + 10 Minuten
	
Diebstahl:
Versuchter Diebstahl von Dienstfahrzeugen
--> 2000 Vero
Diebstahl von Dienstfahrzeugen
--> 4000 Vero + 30 Minuten
Diebstahl von Fahrzeugen
--> 2000 Vero + 10 Minuten
]]

daRules[46] = [[Illegale Demonstrationen:
Anstiftung von illegalen Demonstrationen
--> 3500 Vero + 10 Minuten
Teilnahme an illegalen Demonstrationen
--> 1500 Vero + 5 Minuten
	
Sonstige Verbrechen:
Versuchte Bestechung
--> 500 Vero
Missbrauch der Notrufnummer
--> 1000 Vero
Auf Fahrzeuge springen / laufen
--> 200 Vero
Sachbeschädigung
--> 1000 Vero
Betrug aller Art
--> 2000 Vero + 15 Minuten + Schaden
Raub und Überfall
--> 5000 Vero + 20 Minuten
Beihilfe zu einer Straftat
--> 25% der Straftat, bei der geholfen wurde
Beihilfe zu einem Mord
--> 25% der Straftat, bei der geholfen wurde
Erpressung
--> 3000 Vero + 15 Minuten

Sollte eine Geldsumme bei der jeweiligen Straftat nicht bezahlt werden können, so muss der Täter ins Gefängnis.
Die Arrestzeit wird wie folgt berechnet: 200 Vero = 1 Minute]]

daRules[47] = [[Verkehrsdelikte #1:
Fahren ohne sichtbaren Kennzeichen
--> 1000 Vero + 4 Punkte + 1 Tag Fahrverbot für jeglichen Fahrzeugtyp
nicht vorhandener TÜV
--> 500 Vero + 1 Punkt
Benutzung von Lachgaseinspritzung
--> 1000 Vero + 3 Punkte
Achtung: Der eingebaute Zustand ist nicht strafbar.
Fahren ohne Führerschein oder mit Führerscheinsperre
--> 4000 Vero + 6 Punkte + zusätzlich 3 Tage Fahrverbot
Wenden, Rückwärtsfahren, Fahren entgegen der Fahrtrichtung
--> 1000 Vero + 3 Punkte
Hinweis: Der Versuch diesbezüglich wird ebenso bestraft.
Fahren im abseits der Straße
--> 750 Vero
Unzulässiges Halten
--> 300 Vero
Unzulässiges Parken]]

daRules[48] = [[Verkehrsdelikte #2:
--> Fahrzeug wird durch AutoFix abgeschleppt, kosten muss der Fahrzeughalter tragen
Ein- oder Ausfahren an unzulässigen Stellen
--> 300 Vero + 1 Punkt
illegale Kraftfahrzeugrennen
--> als Teilnehmer
500 Vero + 4 Punkte + 1 Tag Fahrverbot
--> als Veranstalter
1000 Vero + 6 Punkte + 2 Tage Fahrverbot
Rechts überholen
--> 500 Vero + 1 Punkt
Unerlaubtes Entfernen vom Unfallort
--> 1000 Vero + 5 Punkte
Abbiegen, ohne Fahrzeug durchzulassen, oder ohne Rücksicht auf Fußgänger zu nehmen mit Gefährdung
--> 500 Vero + Schaden + 3 Punkte
Alkohol am Steuer
--> 0,6 bis 1,0
600 Vero + 3 Punkte
--> 1,1 bis 1,6
1200 Vero + 5 Punkte + 1 Tag Fahrverbot
--> 1,7 bis 2,3
1800 Vero + 8 Punkte + 2 Tage Fahrverbot + Führerscheinentzug
--> 2,4 bis 2,9
2400 Vero + 11 Punkte + 3 Tage Fahrverbot + Führerscheinentzug]]

daRules[49] = [[
Verkehrsdelikte #3:
Überschreiten der zulässigen/festgesetzten Höchstgeschwindigkeit
bis 10 km/h 100 Vero*
--> 11 bis 15 km/h
150 Vero
--> 16 bis 20 km/h
200 Vero
--> 21 bis 25 km/h
300 Vero + 1 Punkt
--> 26 bis 30 km/h
350 Vero + 3 Punkte
--> 31 bis 40 km/h
400 Vero + 3 Punkte + 1 Tag Fahrverbot
--> 41 bis 50 km/h
450 Vero + 4 Punkte + 1 Tag Fahrverbot
--> 51 bis 60 km/h
500 Vero + 5 Punkte + 2 Tage Fahrverbot
--> 61 bis 70 km/h
550 Vero + 7 Punkte + 3 Tage Fahrverbot
--> über 70 km/h
600 Vero + 4 Tage Fahrverbot + Führerscheinentzug


Information für das Abbauen von Punkten
Ihr könnt euch eure Punkte in Fleischberg (PiF) abbauen.
Dazu meldet ihr euch bei einem Polizeibeamten.

Der Preis wird wie folgt berechnet: 750 Vero = 1 PiF]]