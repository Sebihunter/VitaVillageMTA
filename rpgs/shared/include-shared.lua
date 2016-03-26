--[[
Project: VitaOnline
File: include-shared.lua
Author(s):	Sebihunter
			Neon
]]--


--When adding new lines be sure to look at the teleports @ bus-client.lua
gBusLines = {
	[1] = {{1},3,7,9,57,13,15,16,18,20,22,23,{24},21,19,17,14,12,11,10,8,4},
	[2] = {{50},49,46,41,44,6,7,9,{43},10,8,5,45,42,47,48},
	[3] = {{42},40,38,17,29,31,32,35,{36},34,33,30,28,16,37,39},
	[4] = {{27},26,21,19,28,{16},18,20,25},
	[5] = {{56},54,52,19,17,14,{51},15,16,18,53,55},
	[6] = {{16},18,31,71,69,67,63,59,61,{65},58,62,60,64,66,68,70,30,28}
}

gBusLineColors = {
[1] = "#fb0d0d",
[2] = "#2d3bf7",
[3] = "#00ff2b",
[4] = "#fb951d",
[5] = "#f000ff",
[6] = "#492F2C"
}

gBusStops = {
[1] = {name = "Busdepot", def="Busdepot",  sound={"gong1.mp3", "stations/busdepot.mp3", "ziel.mp3", "gong2.mp3", "last_stop.mp3"}, obj={1052.5000000,2400.7000000,11.1000000,0.0000000,0.0000000,89.7500000}},
[2] = {name = "Busdepot", def="Busdepot", sound={"gong1.mp3", "stations/busdepot.mp3", "ziel.mp3", "gong2.mp3", "last_stop.mp3"}, obj={1085.0996,2385.7000000,11.1000000,0.0000000,0.0000000,269.5000000}},
[3] = {name = "Industriegebiet West", def="Industriegebiet_West", sound={"gong1.mp3", "stations/industriegebiet_west.mp3"}, obj={999.1000000,2148.1000000,11.1000000,0.0000000,0.0000000,180.5000000}},
[4] = {name = "Industriegebiet West", def="Industriegebiet_West", sound={"gong1.mp3", "stations/industriegebiet_west.mp3"}, obj={1015.1000000,2114.0000000,11.1000000,0.0000000,0.0000000,0.0000000}},
[5] = {name = "Whitewood Estates", def="Whitewood_Estates", sound={"gong1.mp3", "stations/whitewood_estates.mp3"}, obj={1083.8000000,2046.6000000,11.1000000,0.0000000,0.0000000,270.0000000}},
[6] = {name = "Whitewood Estates", def="Whitewood_Estates", sound={"gong1.mp3", "stations/whitewood_estates.mp3"}, obj={1061.3000000,2060.2000000,11.1000000,0.0000000,0.0000000,90.0000000}},
[7] = {name = "Autohaus", def="Autohaus", sound={"gong1.mp3", "stations/autohaus.mp3", "umsteigen_zu.mp3", "linie_1.mp3", "in_richtung.mp3", "stations/busdepot.mp3", "linie_2.mp3", "in_richtung.mp3", "stations/yellow_bell.mp3"}, obj={999.3000000,1778.6000000,11.2000000,0.0000000,0.0000000,180.0000000}},
[8] = {name = "Autohaus", def="Autohaus", sound={"gong1.mp3", "stations/autohaus.mp3", "umsteigen_zu.mp3", "linie_1.mp3", "in_richtung.mp3", "stations/busdepot.mp3", "linie_2.mp3", "in_richtung.mp3", "stations/yellow_bell.mp3"}, obj={1015.8000000,1778.8000000,11.2000000,0.0000000,0.0000000,0.0000000}},
[9] = {name = "Stadion", def="Stadion", sound={"gong1.mp3", "stations/stadion.mp3", "umsteigen_zu.mp3", --[["u_bahn.mp3",]] "linie_1.mp3", "in_richtung.mp3", "stations/lv_nord.mp3", "linie_2.mp3", "in_richtung.mp3", "stations/stadion_parkplatz.mp3"}, obj={998.7000000,1422.9000000,11.1000000,0.0000000,0.0000000,180.0000000}},
[10] = {name = "Stadion", def="Stadion", sound={"gong1.mp3", "stations/stadion.mp3", "umsteigen_zu.mp3", --[["u_bahn.mp3",]] "linie_1.mp3", "in_richtung.mp3", "stations/lv_nord.mp3", "linie_2.mp3", "in_richtung.mp3", "stations/stadion_parkplatz.mp3"}, obj={1014.5000000,1431.6000000,11.1000000,0.0000000,0.0000000,0.0000000}},
[11] = {name = "Universität", def="Universitaet", sound={"gong1.mp3", "stations/universitaet.mp3"}, obj={1076.3000000,1201.6000000,11.1000000,0.0000000,0.0000000,90.0000000}},
[12] = {name = "Flughafen Süd", def="Flughafen_Sued", sound={"gong1.mp3", "stations/flughafen_sued.mp3"}, obj={1408.3000000,1201.4000000,11.1000000,0.0000000,0.0000000,90.0000000}},
[13] = {name = "Flughafen Süd", def="Flughafen_Sued", sound={"gong1.mp3", "stations/flughafen_sued.mp3"}, obj={1410.2000000,1185.1000000,11.1000000,0.0000000,0.0000000,270.0000000}},
[14] = {name = "Frachtendepot", def="Frachtendepot", sound={"gong1.mp3", "stations/frachtendepot.mp3", "umsteigen_zu.mp3", "linie_1.mp3", "in_richtung.mp3", "stations/busdepot.mp3", "linie_5.mp3", "in_richtung.mp3", "stations/randolph.mp3"}, obj={1610.6000000,1140.4000000,11.1000000,0.0000000,0.0000000,90.0000000}},
[15] = {name = "Frachtendepot", def="Frachtendepot", sound={"gong1.mp3", "stations/frachtendepot.mp3", "umsteigen_zu.mp3", "linie_1.mp3", "in_richtung.mp3", "stations/busdepot.mp3", "linie_5.mp3", "in_richtung.mp3", "stations/randolph.mp3"}, obj={1605.4000000,1125.7000000,11.1000000,0.0000000,0.0000000,269.9945000}},
[16] = {name = "Flughafen, Zentralstation", def="Flughafen_Zentralstation", sound={"gong1.mp3", "stations/flughafen.mp3", "umsteigen_zu.mp3", --[["u_bahn.mp3",]] "linie_1.mp3", "linie_3.mp3","linie_4.mp3", "linie_5.mp3", "ziel.mp3", "gong2.mp3", "leave_airport.mp3", "last_stop.mp3"}, obj={1719.7000000,1422.8000000,10.9000000,0.0000000,0.0000000,6.0000000}},
[17] = {name = "Flughafen, Zentralstation", def="Flughafen_Zentralstation", sound={"gong1.mp3", "stations/flughafen.mp3", "umsteigen_zu.mp3", --[["u_bahn.mp3",]] "linie_1.mp3", "linie_3.mp3","linie_4.mp3", "linie_5.mp3", "ziel.mp3", "gong2.mp3", "leave_airport.mp3", "last_stop.mp3"}, obj={1706.2000000,1407.9000000,10.9000000,0.0000000,0.0000000,189.9985000}},
[18] = {name = "Strip Mitte", def="Strip_Mitte", sound={"gong1.mp3", "stations/strip_mitte.mp3", "umsteigen_zu.mp3"--[[,"u_bahn.mp3"]], "linie_5.mp3", "in_richtung.mp3", "stations/linden.mp3"}, obj={2026.0000000,1445.5000000,11.1000000,0.0000000,0.0000000,270.0000000}},
[19] = {name = "Strip Mitte", def="Strip_Mitte", sound={"gong1.mp3", "stations/strip_mitte.mp3", "umsteigen_zu.mp3"--[[,"u_bahn.mp3"]], "linie_5.mp3", "in_richtung.mp3", "stations/linden.mp3"}, obj={2033.9000000,1472.7000000,11.1000000,0.0000000,0.0000000,180.0000000}},
[20] = {name = "Palm Beach Club", def="Palm_Beach_Club", sound={"gong1.mp3", "stations/palm_beach.mp3", "umsteigen_zu.mp3", "linie_1.mp3","in_richtung.mp3", "stations/lv_nord.mp3", "linie_4.mp3","in_richtung.mp3", "stations/lv_ost.mp3"}, obj={2161.0000000,1876.7000000,11.1000000,0.0000000,0.0000000,0.0000000}},
[21] = {name = "Palm Beach Club", def="Palm_Beach_Club", sound={"gong1.mp3", "stations/palm_beach.mp3", "umsteigen_zu.mp3", "linie_1.mp3","in_richtung.mp3", "stations/lv_nord.mp3", "linie_4.mp3","in_richtung.mp3", "stations/lv_ost.mp3"}, obj={2113.2000000,1878.4000000,11.1000000,0.0000000,0.0000000,180.0000000}},
[22] = {name = "LVPD", def="LVPD", sound={"gong1.mp3", "stations/lvpd.mp3"}, obj={2269.8986816406,2275.6853027344,11.1,0.0000000,0.0000000,270.0000000}},
[23] = {name = "Staatsverwaltung", def="Staatsverwaltung", sound={"gong1.mp3", "stations/staatsverwaltung.mp3", "gong3.mp3", "sitzplatz.mp3"}, obj={2412.0710449219,2226.0695800781,11.1,0.0000000,0.0000000,270.0000000}},
[24] = {name = "Las Venturas Nord", def="Las_Venturas_Nord", sound={"gong1.mp3", "stations/lv_nord.mp3"}, obj={2079.0000000,2461.1000000,11.1000000,0.0000000,0.0000000,90.0000000}},
[25] = {name = "Old Venturas Strip", def="Old_Venturas_Strip", sound={"gong1.mp3", "stations/old_venturas_strip.mp3", "gong3.mp3", "sitzplatz.mp3"}, obj={2324.0000000,2125.4000000,11.1000000,0.0000000,0.0000000,270.0000000}},
[26] = {name = "Old Venturas Strip", def="Old_Venturas_Strip", sound={"gong1.mp3", "stations/old_venturas_strip.mp3", "gong3.mp3", "sitzplatz.mp3"}, obj={2372.3000000,2161.4000000,11.1000000,0.0000000,0.0000000,90.0000000}},
[27] = {name = "Las Venturas Ost", def="Las_Venturas_Ost", sound={"gong1.mp3", "stations/lv_ost.mp3", "ziel.mp3", "gong2.mp3", "last_stop.mp3"}, obj={2554.9000000,1962.2000000,11.1000000,0.0000000,0.0000000,270.0000000}},
[28] = {name = "The High Roller", def="The_High_Roller", sound={"gong1.mp3", "stations/high_roller.mp3", "umsteigen_zu.mp3", "linie_4.mp3", "in_richtung.mp3", "stations/lv_ost.mp3", "gong3.mp3", "sitzplatz.mp3"}, obj={1997.9000000,1281.5000000,11.1000000,0.0000000,0.0000000,90.0000000}},
[29] = {name = "The High Roller", def="The_High_Roller", sound={"gong1.mp3", "stations/high_roller.mp3", "umsteigen_zu.mp3", "linie_4.mp3", "in_richtung.mp3", "stations/lv_ost.mp3", "gong3.mp3", "sitzplatz.mp3"}, obj={2012.0000000,1265.6000000,11.1000000,0.0000000,0.0000000,270.0000000}},
[30] = {name = "Four Dragons Casino", def="Four_Dragons_Casino", sound={"gong1.mp3", "stations/four_dragons.mp3", "umsteigen_zu.mp3", "linie_3.mp3", "in_richtung.mp3", "stations/last_dime_motel.mp3", "linie_6.mp3", "in_richtung.mp3", "stations/FC_Krankenhaus.mp3"}, obj={2081.2000000,1016.8000000,11.1000000,0.0000000,0.0000000,0.0000000}},
[31] = {name = "Four Dragons Casino", def="Four_Dragons_Casino", sound={"gong1.mp3", "stations/four_dragons.mp3", "umsteigen_zu.mp3", "linie_3.mp3", "in_richtung.mp3", "stations/last_dime_motel.mp3", "linie_6.mp3", "in_richtung.mp3", "stations/FC_Krankenhaus.mp3"}, obj={2033.6000000,1019.5000000,11.1000000,0.0000000,0.0000000,180.0000000}},
[32] = {name = "Las Venturas Süd", def="Las_Venturas_Sued", sound={"gong1.mp3", "stations/lv_sued.mp3"}, obj={2139.0000000,925.3000000,11.1000000,0.0000000,0.0000000,180.0000000}},
[33] = {name = "Las Venturas Süd", def="Las_Venturas_Sued", sound={"gong1.mp3", "stations/lv_sued.mp3"}, obj={2155.4000000,956.3000000,11.1000000,0.0000000,0.0000000,0.0000000}},
[34] = {name = "Rockshore West", def="Rockshore_West", sound={"gong1.mp3", "stations/rockshore_west.mp3"}, obj={2075.3000000,744.5000000,11.1000000,0.0000000,0.0000000,269.9945000}},
[35] = {name = "Rockshore West", def="Rockshore_West", sound={"gong1.mp3", "stations/rockshore_west.mp3"}, obj={2061.7000000,761.6000000,11.1000000,0.0000000,0.0000000,90.0000000}},
[36] = {name = "Last Dime Motel", def="Last_Dime_Motel", sound={"gong1.mp3", "stations/last_dime_motel.mp3", "ziel.mp3", "gong2.mp3", "last_stop.mp3"}, obj={1951.8000000,625.6000000,11.1000000,0.0000000,0.0000000,270.0000000}},
[37] = {name = "Krankenhaus", def="Krankenhaus", sound={"gong1.mp3", "stations/krankenhaus.mp3", "gong3.mp3", "sitzplatz.mp3"}, obj={1575.3000000,1815.9000000,11.1000000,0.0000000,0.0000000,0.0000000}},
[38] = {name = "Krankenhaus", def="Krankenhaus", sound={"gong1.mp3", "stations/krankenhaus.mp3", "gong3.mp3", "sitzplatz.mp3"}, obj={1559.6000000,1805.6000000,11.1000000,0.0000000,0.0000000,180.0000000}},
[39] = {name = "Flughafen Nord", def="Flughafen_Nord", sound={"gong1.mp3", "stations/flughafen_nord.mp3"}, obj={1394.5000000,1922.6000000,11.1000000,0.0000000,0.0000000,0.0000000}},
[40] = {name = "Flughafen Nord", def="Flughafen_Nord", sound={"gong1.mp3", "stations/flughafen_nord.mp3"}, obj={1378.9000000,1914.3000000,11.1000000,0.0000000,0.0000000,180.0000000}},
[41] = {name = "Baseballstadion, Parkplatz", def="Baseballstadion_Parkplatz", sound={"gong1.mp3", "stations/baseballstadion_parkplatz.mp3", "umsteigen_zu.mp3", "linie_2.mp3", "linie_3.mp3","in_richtung.mp3", "stations/last_dime_motel.mp3", "ziel.mp3", "gong2.mp3", "last_stop.mp3"}, obj={1464.0000000,2061.4000000,11.1000000,0.0000000,0.0000000,90.0000000}},
[42] = {name = "Baseballstadion, Parkplatz", def="Baseballstadion_Parkplatz", sound={"gong1.mp3", "stations/baseballstadion_parkplatz.mp3", "umsteigen_zu.mp3", "linie_2.mp3", "linie_3.mp3","in_richtung.mp3", "stations/last_dime_motel.mp3", "ziel.mp3", "gong2.mp3", "last_stop.mp3"}, obj={1446.9000000,2044.9000000,11.1000000,0.0000000,0.0000000,270.0000000}},
[43] = {name = "Stadion, Parkplatz", def="Stadion_Parkplatz", sound={"gong1.mp3", "stations/stadion_parkplatz.mp3", "ziel.mp3", "gong2.mp3", "last_stop.mp3"}, obj={1097.1000000,1420.5000000,6.1000000,0.0000000,0.0000000,269.2500000}},
[44] = {name = "Redsands West", def="Redsands_West", sound={"gong1.mp3", "stations/redsands_west.mp3"}, obj={1318.5000000,2060.5000000,11.1000000,0.0000000,0.0000000,90.0000000}},
[45] = {name = "Redsands West", def="Redsands_West", sound={"gong1.mp3", "stations/redsands_west.mp3"}, obj={1281.6000000,2045.7000000,11.1000000,0.0000000,0.0000000,270.0000000}},
[46] = {name = "Baseballstadion", def="Baseballstadion", sound={"gong1.mp3", "stations/baseballstadion.mp3"}, obj={1559.3000000,2192.6000000,11.1000000,0.0000000,0.0000000,180.0000000}},
[47] = {name = "Baseballstadion", def="Baseballstadion", sound={"gong1.mp3", "stations/baseballstadion.mp3"}, obj={1549.9000000,2164.9000000,11.1000000,0.0000000,0.0000000,270.0000000}},
[48] = {name = "Redsands Industriegebiet", def="Redsands_Industriegebiet", sound={"gong1.mp3", "stations/redsands_industriegebiet.mp3"}, obj={1574.7000000,2366.7000000,11.1000000,0.0000000,0.0000000,0.0000000}},
[49] = {name = "Redsands Industriegebiet", def="Redsands_Industriegebiet", sound={"gong1.mp3", "stations/redsands_industriegebiet.mp3"}, obj={1559.1000000,2366.6000000,11.1000000,0.0000000,0.0000000,180.0000000}},
[50] = {name = "Bahnhof Yellow Bell", def="Bahnhof_Yellow_Bell", sound={"gong1.mp3", "stations/yellow_bell.mp3", "umsteigen_zu.mp3" , "regionalzuegen.mp3", "ziel.mp3", "gong2.mp3", "connections_to.mp3", "train_service.mp3", "last_stop.mp3"},  obj={1411.1000000,2611.5000000,11.1000000,0.0000000,0.0000000,90.0000000}},
[51] = {name = "Randolph Industriegebiet", def="Randolph_Industriegebiet", sound={"gong1.mp3", "stations/randolph.mp3", "ziel.mp3", "gong2.mp3", "last_stop.mp3"}, obj={1493.125,713.70001,11.1,0,0,85}},
[52] = {name = "Caligulas", def="Caligulas", sound={"gong1.mp3", "stations/caligulas.mp3"}, obj={2203.769,1541.072,11.1,0,0,90}},
[53] = {name = "Caligulas", def="Caligulas", sound={"gong1.mp3", "stations/caligulas.mp3"}, obj={2168.563,1524.8199,11.1,0,0,270}},
[54] = {name = "Pilgrim", def="Pilgrim", sound={"gong1.mp3", "stations/pilgrim.mp3"}, obj={2446.2361,1481.963,11.1,0,0,90}},
[55] = {name = "Pilgrim", def="Pilgrim", sound={"gong1.mp3", "stations/pilgrim.mp3"}, obj={2418.499,1491.049,11.1,0,0,180}},
[56] = {name = "Bahnhof Linden", def="Bahnhof_Linden", sound={"gong1.mp3", "stations/linden.mp3", "umsteigen_zu.mp3" , "regionalzuegen.mp3", "ziel.mp3", "gong2.mp3", "connections_to.mp3", "train_service.mp3", "last_stop.mp3"}, obj={2838.436,1303.671,11.67,0,0,0}},
[57] = {name = "Universität", def="Universitaet", sound={"gong1.mp3", "stations/universitaet.mp3"}, obj={1088.2000000,1185.3000000,11.1000000,0.0000000,0.0000000,271.2500000}},
[58] = {name = "Polizeirevier Fort Carson", def="FC_Polizei", sound={"gong1.mp3", "stations/FC_Polizei.mp3"}, obj={-209.57543945313,1010.860534668,19.9421875,0,0,270}, small = false},
[59] = {name = "Hauptstraße Fort Carson", def="FC_Hauptstrasse", sound={"gong1.mp3", "stations/FC_Hauptstrasse.mp3"}, obj={-200.7998046875,1145.5703125,20.301868438721,0,0,178.69262695313}, small = true},
[60] = {name = "Hauptstraße Fort Carson", def="FC_Hauptstrasse", sound={"gong1.mp3", "stations/FC_Hauptstrasse.mp3"}, obj={-185.15641784668,1170.9282226563,20.301868438721,0,0,0}, small = true},
[61] = {name = "Polizeirevier Fort Carson", def="FC_Polizei", sound={"gong1.mp3", "stations/FC_Polizei.mp3"}, obj={-202.38545227051,1037.1226806641,20.301868438721,0,0,180.67761230469}, small = true},
[62] = {name = "Rathaus Fort Carson", def="FC_Rathaus", sound={"gong1.mp3", "stations/FC_Rathaus.mp3", "gong3.mp3", "sitzplatz.mp3"}, obj={-183.2890625,1079.849609375,20.301868438721,0,0,354.17724609375}, small = true},
[63] = {name = "Bahnhof Fort Carson", def="FC_Bahnhof", sound={"gong1.mp3", "stations/FC_Bahnhof.mp3", "umsteigen_zu.mp3" , "regionalzuegen.mp3", "gong2.mp3", "connections_to.mp3", "train_service.mp3"}, obj={-21.73811340332,1271.1097412109,9.0024185180664,0,0,87.832153320313}, small = true},
[64] = {name = "Bahnhof Fort Carson", def="FC_Bahnhof", sound={"gong1.mp3", "stations/FC_Bahnhof.mp3", "umsteigen_zu.mp3" , "regionalzuegen.mp3", "gong2.mp3", "connections_to.mp3", "train_service.mp3"}, obj={-33.756282806396,1256.2471923828,9.561427116394,0,0,279.38043212891}, small = true},
[65] = {name = "Krankenhaus Fort Carson", def="FC_Krankenhaus", sound={"gong1.mp3", "stations/FC_Krankenhaus.mp3", "ziel.mp3", "gong2.mp3", "last_stop.mp3"}, obj={-306.02005004883,1073.27734375,20.29407119751,0,0,0}, small = true},
[66] = {name = "Tankstelle Fort Carson", def="FC_Tank", sound={"gong1.mp3", "stations/FC_Tank.mp3"}, obj={77.768737792969,1228.8468017578,19.796276092529,0,0,242.88494873047}, small = true},
[67] = {name = "Tankstelle Fort Carson", def="FC_Tank", sound={"gong1.mp3", "stations/FC_Tank.mp3"}, obj={84.284622192383,1240.7283935547,19.796276092529,0,0,59.544067382813}, small = true},
[68] = {name = "Autokino", def="Autokino", sound={"gong1.mp3", "stations/autokino.mp3"}, obj={182.55999755859,1080.2069091797,18.40059967041,0,0,180}, small = true},
[69] = {name = "Autokino", def="Autokino", sound={"gong1.mp3", "stations/autokino.mp3"}, obj={197.90544128418,1081.8486328125,18.582585525513,0,0,0}, small = true},
[70] = {name = "Schottergrube", def="Schottergrube", sound={"gong1.mp3", "stations/schottergrube.mp3"}, obj={287.63250732422,813.36767578125,16.571299743652,0,0,180}, small = true},
[71] = {name = "Schottergrube", def="Schottergrube", sound={"gong1.mp3", "stations/schottergrube.mp3"}, obj={264.31106567383,904.24450683594,23.678992462158,0,0,0}, small = true}
}
gWeekDays = { [0] = "Sonntag", "Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag" }


PaintnSprayIDTab={
	{ID=8, x=2064.2487792969, y=-1831.3826904297, z=9.546875},
	{ID=11, x=1024.8206787109, y=-1024.7711181641, z=28.1015625},
	{ID=12, x=487.80700683594, y=-1740.1962890625, z=7.142566680908},
	{ID=19, x=-1904.6048583984, y=284.50555419922, z=39.046875},
	{ID=24, x=-1786.7393798828, y=1215.8741455078, z=24.125},
	{ID=27, x=-2425.3518066406, y=1021.2296142578, z=48.397659301758},
	--{ID=32, x=2393.080078125, y=1490.654296875, z=10.827350616455},  --fail
	{ID=40, x=-1420.4449462891, y=2583.3293457031, z=53.84326171875},
	{ID=41, x=-99.828308105469, y=1118.7496337891, z=17.74169921875},
	{ID=47, x=720.02368164063, y=-457.25674438477, z=14.3359375}
	
}

--[[ void check( string funcname, var types1, var argument1, var argname1, ... )
	Checks if the passed arguments have one of the given types and outputs an error message if any doesn't.
	funcname: Name of the function in which check is called.
	types1-typesn: Type(s) that the corresponding argument should/may have. (pass a table with strings if more than one type is allowed, otherwise just a string)
	argument1-argumentn: Argument whose type should be checked.
	argname1-argnamen: Name of the corresponding argument. ]]
function check(funcname, ...)
	local arg = {...}
	
	if (type(funcname) ~= "string") then
		error("Argument type mismatch at 'check' ('funcname'). Expected 'string', got '"..type(funcname).."'.", 2)
	end
	if (#arg % 3 > 0) then
		error("Argument number mismatch at 'check'. Expected #arg % 3 to be 0, but it is "..(#arg % 3)..".", 2)
	end
	
	for i=1, #arg-2, 3 do
		if (type(arg[i]) ~= "string" and type(arg[i]) ~= "table") then
			error("Argument type mismatch at 'check' (arg #"..i.."). Expected 'string' or 'table', got '"..type(arg[i]).."'.", 2)
		elseif (type(arg[i+2]) ~= "string") then
			error("Argument type mismatch at 'check' (arg #"..(i+2).."). Expected 'string', got '"..type(arg[i+2]).."'.", 2)
		end
		
		if (type(arg[i]) == "table") then
			local aType = type(arg[i+1])
			for _, pType in next, arg[i] do
				if (aType == pType) then
					aType = nil
					break
				end
			end
			if (aType) then
				error("Argument type mismatch at '"..funcname.."' ('"..arg[i+2].."'). Expected '"..table.concat(arg[i], "' or '").."', got '"..aType.."'.", 3)
			end
		elseif (type(arg[i+1]) ~= arg[i]) then
			error("Argument type mismatch at '"..funcname.."' ('"..arg[i+2].."'). Expected '"..arg[i].."', got '"..type(arg[i+1]).."'.", 3)
		end
	end
end

--[[ string formatDate( string format, string escaper = "'", timestamp = getTimestamp() )
	Formats a date. [ d: day of the month (1-31), h: hour (0-23), i: minute (0-59), m: month (1-12), s: second (0-59), w: shortened day of the week (su-mo), W: day of the week (Sunday-Monday), y: shortened year, Y: year ]
	format: Format string that determines how the date should be formatted.
	escaper: Escape character that can be used to set parts of format to be ignored concerning formatting.
	timestamp: Timestamp of the date that should be formatted. ]]
function formatDate(format, escaper, timestamp)
	escaper = (escaper or "'"):sub(1, 1)
	check("formatDate", "string", format, "format", "string", escaper, "escaper", {"nil","number"}, timestamp, "timestamp")
	
	local time = getRealTime(timestamp)
	local formattedDate = ""
	local escaped = false

	time.year = time.year + 1900
	time.month = time.month + 1
	
	local datetime = { d = ("%02d"):format(time.monthday), h = ("%02d"):format(time.hour), i = ("%02d"):format(time.minute), m = ("%02d"):format(time.month), s = ("%02d"):format(time.second), w = gWeekDays[time.weekday]:sub(1, 2), W = gWeekDays[time.weekday], y = tostring(time.year):sub(-2), Y = time.year }
	
	for char in format:gmatch(".") do
		if (char == escaper) then escaped = not escaped
		else formattedDate = formattedDate..(not escaped and datetime[char] or char) end
	end
	
	return formattedDate
end

--[[ string formatPosition( number x, number y, number z, [ [ number rotX, number rotY, ] number rotZ, int interior, [ int dimension ] ] )
	Formats a position.
	x, y, z: Coordinates.
	rotX, rotY, rotZ: Rotations.
	interior: Interior.
	dimension: Dimension. ]]
function formatPosition(x, y, z, rotX, rotY, rotZ, interior, dimension)
	if (not rotY) then rotZ, rotX = rotX
	elseif (not rotZ) then rotZ, interior, rotX, rotY = rotX, rotY
	elseif (not interior) then rotZ, interior, dimension, rotX, rotY, rotZ = rotX, rotY, rotZ end
	
	local formattedPosition = "Pos: ["..math.format(x, ",", 4, ".").."|"..math.format(y, ",", 4, ".").."|"..math.format(z, ",", 4, ".").."];"
	if (rotX) then formattedPosition = formattedPosition.." Rot: ["..math.format(rotX, ",", 2).."|"..math.format(rotY, ",", 2).."|"..math.format(rotZ, ",", 2).."];"
	elseif (rotZ) then formattedPosition = formattedPosition.." Rot: "..math.format(rotZ, ",", 2)..";" end
	if (interior) then formattedPosition = formattedPosition.." Int: "..math.round(interior)..";" end
	if (dimension) then formattedPosition = formattedPosition.." Dim: "..math.round(dimension)..";" end
	
	return formattedPosition
end

--[[ number, [number, number] getAngleBetweenPoints( number x1, number y1, [ number z1 , ] number x2, number y2, [ number z2 ] )
	Returns the angle between the two given points. If the z-coordinates are given it returns all three angles.
	x1: x-coordinate of the first point
	y1: y-coordinate of the first point
	z1: z-coordinate of the first point
	x2: x-coordinate of the second point
	y2: y-coordinate of the second point
	z2: z-coordinate of the second point ]]
function getAngleBetweenPoints(x1, y1, z1, x2, y2, z2)
	if (not y2) then
		x2, y2 = z1, x2
		check("getAngleBetweenPoints", "number", x1, "x1", "number", y1, "y1", "number", x2, "x2", "number", y2, "y2")
		return math.deg(math.atan2((y2 - y1), (x2 - x1))) - 90
	else
		check("getAngleBetweenPoints", "number", x1, "x1", "number", y1, "y1", "number", z1, "z1", "number", x2, "x2", "number", y2, "y2", "number", z2, "z2")
		local dx, dy, dz = x2 - x1, y2 - y1, z2 - z1
		return math.deg(math.atan2(dz, dy)), math.deg(math.atan2(dz, dx)), -math.deg(math.atan2(dx, dy))
	end
end

local RAD2DEG = 57.295779513082320876798154814105

function getAnglesBetweenPoints3D(x1, y1, z1, x2, y2, z2)
	x1 = x2 - x1
	y1 = y2 - y1
	
	x2 = math.atan2( x1, y1 ) * -RAD2DEG
	y2 = math.atan2( z2 - z1, math.sqrt( (x1 * x1) + (y1 * y1) ) ) * -RAD2DEG
	
	return
		x2 < 0 and x2 + 360 or x2,
		y2 < 0 and y2 + 360 or y2
end

--[[ int getBit( int integer, int index )
	Returns the value of the bit in the given integer with the index index.
	integer: The integer.
	index: Index of the bit whose value should be returned. ]]
function getBit(integer, index)
	check("getBit", "number", integer, "integer", "number", index, "index")
	return math.floor(integer / 2 ^ index) % 2
end

--[[ table getDateTime( [ int timestamp = getTimestamp() ] )
	Returns a table containing information to the given timestamp. Correction of getRealTime().
	timestamp: Timestamp of the datetime. ]]
function getDateTime(timestamp)
	check("getDateTime", {"nil","number"}, timestamp, "timestamp")
	local time = getRealTime(timestamp)
	time.year = time.year + 1900
	time.month = time.month + 1
	return time
end

--[[ number, number getPointOnCircle( number midX, number midY, number radius, number angle )
	Calculates the x- and y-coordinate on a circle with the given values.
	midX: x-coordinate of the circle's middle point.
	midY: y-coordinate of the circle's middle point.
	radius: The circle's radius.
	angle: Angle between the segment from the circle's middle point to the point that should be calculated and the world's y-axis. ]]
function getPointOnCircle(midX, midY, radius, angle)
	check("getPointOnCircle", "number", midX, "midX", "number", midY, "midY", "number", radius, "radius", "number", angle, "angle")
	angle = math.rad(angle)
	local distX = -radius * math.sin(angle)
	local distY = radius * math.cos(angle)
	return midX + distX, midY + distY
end

--[[ num, num, num getPointOnSphere ( num midX, num midY, num midZ, num radius, num angleZ, num angeXY )
 =: returns the desired position determined by two angles on a sphere with the given parameters
  midX, midY, midZ: the coordinates of the sphere's center
  radius: the sphere's radius
  angleZ: imagining the desired position being on a circle that is parallel to the global x/y-plane this is the z-angle the line from
   such a circle's center encloses with the global y-axis to hit the desired position on the circle (in degrees)
  angleXY: imagining a vertical circle now this angle determines the position on it whereas 90� is the top of the sphere and -90�
   the bottom; this value must be in the range [-90,90]; 0� causes the third returned value to be equal to midZ (in degrees)
 => the desired point's coordinates ]]
function getPointOnSphere(midX, midY, midZ, radius, angleZ, angleXY)
	check("getPointOnSphere", "number", midX, "midX", "number", midY, "midY", "number", midZ, "midZ", "number", radius, "radius", "number", angleZ, "angleZ", "number", angleXY, "angleXY")
	
	angleZ = math.rad(getValidAngle(angleZ))
	angleXY = math.rad(getValidAngle(angleXY))
	
	local d = radius / math.tan(math.abs(.5 * (math.pi - angleXY)))
	
	local px = midX - (radius - d) * math.sin(angleZ)
	local py = midY + (radius - d) * math.cos(angleZ)
	local pz = midZ + radius * math.sin(angleXY)
	
	return px, py, pz
end

--[[ int getTimestamp( [ int year = getRealTime().year + 1900, int month = getRealTime().month + 1, int day = getRealTime().day, int hour = getRealTime().hour, minute = getRealTime().minute, int second = getRealTime().second ] )
	Returns the UNIX timestamp of the given or the current date.
	year: The year. Must be greater than 1969.
	month: The month. (1-12)
	day: The day. (1-31)
	hour: The hour. (0-23)
	minute: The minute. (0-59)
	second: The second. (0-59) ]]
function getTimestamp(year, month, day, hour, minute, second)
	local timestamp = 0
	local time = getRealTime()
	local monthDays = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }
	
	year = year or time.year + 1900
	if (isYearALeapYear(year)) then monthDays[2] = 29 end
	month = month or time.month + 1
	day = day or time.monthday
	hour = hour or time.hour
	minute = minute or time.minute
	second = second or time.second
	
	check("getTimestamp", "number", year, "year", "number", month, "month", "number", day, "day", "number", hour, "hour", "number", minute, "minute", "number", second, "second")
	
	if (year < 1970) then year = time.year + 1900 end
	for i=1970, year-1 do
		timestamp = timestamp + 31536000
		if (isYearALeapYear(i)) then timestamp = timestamp + 86400 end
	end
	for i=1, month-1 do timestamp = timestamp + 86400 * monthDays[i] end
	timestamp = timestamp + 86400 * (day - 1) + 36000 * hour + 60 * minute + second
	
	return timestamp
end

--[[ number getValidAngle( number angle )
	Returns the corresponding angle between -1 and 361 to the given one.
	angle: Potentially out-of-range angle. ]]
function getValidAngle(angle)
	check("getValidAngle", "number", angle, "angle")
	angle = ((angle < 0 or angle >= 360) and angle - math.ceil(angle / 360) * 360 + 360 or angle)
	return (angle==360 and 0 or angle)
end

--[[ bool IsYealALeapYear( [ int year = getRealTime().year + 1900 ] )
	Returns true, if the given year was/is/will be a leap year, otherwise false.
	year: The year you want to check. ]]
function isYearALeapYear(year)
	year = year or getRealTime().year + 1900
	check("isYearALeapYear", "number", year, "year")
	return ((year % 4 == 0 and year % 100 ~= 0) or year % 400 == 0)
end

--[[ string math.format( number number, [ string comma = ".", int decimals = #({math.modf(number)}[2])-2, string separator = "", int digits = 0, string method = "round", string filler = "0" ] )
	Formats a number depending on the passed options.
	number: Number to be formatted.
	comma: String that should separate the integral from the fractional part of the number.
	decimals: Number of decimals that should be displayer after komma.
	separator: Thousands separator that will divide the integral part into triplets.
	digits: Number of digits the integral part should have. Empty space will be filled with zeroes. The integral part won't be cut if digits doesn't provide enough space.
	method: Method that should be used when rounding a number. ["round", "ceil", "floor"]
	filler: String to fill empty digits in front of the integral part. ]]
function math.format(number, comma, decimals, separator, digits, method, filler)
	comma = comma or "."
	
	check("math.format", "number", number, "number", "string", comma, "comma", {"nil","number"}, decimals, "decimals", {"nil","string"}, separator, "separator", {"nil","number"}, digits, "digits", {"nil","string"}, method, "method", {"nil","string"}, filler, "filler")
	
	local minus = (number < 0)
	local int, fract = math.modf(math.abs(number))
	if (decimals == 0 and (method == "ceil" or ((not method or method == "round") and fract >= .5)))
	then int = int + 1 end
	int = tostring(digits and ("%0"..digits.."d"):format(int) or int)
	if (filler) then
		rep = #int:match("^0*")
		int = filler:rep(rep)..int:sub(rep + 1)
	end
	if (minus and int:sub(1, 1) == (filler or "0")) then int = int:sub(2) end
	fract = tostring(decimals and math.round(fract, decimals, method) or fract):sub(3)
	
	if (decimals and #fract < decimals) then fract = fract..("0"):rep(decimals - #fract) end
	
	if (separator and #separator > 0) then
		local newfract = int:reverse():gsub("(%d%d%d)", "%1"..separator)
		local rest = #int % 3
		int = rest>0 and int:sub(1, rest)..newfract:reverse():sub(rest + 1) or newfract:reverse():sub(2)
	end
	
	int = (minus and "-" or "")..int
	if ((decimals and decimals == 0) or (not decimals and tonumber(fract) == 0)) then return int
	else return int..comma..fract end
end

--[[ number math.round( float number, [ int decimals = 0, string method = "round" ] )
	Returns the passed number rounded.
	number: Number that should be rounded.
	decimals: Number of decimals that should be kept.
	method: Round method. ["round", "floor" or "ceil"] ]]
function math.round(number, decimals, method)
	decimals = decimals or 0
	local factor = 10 ^ decimals
	if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
	else return tonumber(("%."..decimals.."f"):format(number)) end
end

--[[ int, int, int, int mixColors( var color1, [ ... ] )
	Mixes all passed colors and returns the result.
	color1-colorn: Either a table ({[1]=red, [2]=green, [3]=blue, [4]=alpha}) or a string (#RRGGBBAA) or an integer (color). ]]
function mixColors(...)
	local result = { 0, 0, 0, 0 }
	local arg = {...}
	local colorCount = #arg
	
	for index, color in next, arg do
		check("mixColors", {"table","string","number"}, color, "arg #"..index)
		
		if (type(color) ~= "table") then arg[index] = { getColorFromString(type(color)=="string" and color or ("#%8x"):format(color)) } end
		
		result[1] = result[1] + color[1]
		result[2] = result[2] + color[2]
		result[3] = result[3] + color[3]
		result[4] = result[4] + color[4]
	end
	
	result[1] = math.round(result[1] / colorCount)
	result[2] = math.round(result[2] / colorCount)
	result[3] = math.round(result[3] / colorCount)
	result[4] = math.round(result[4] / colorCount)
	
	return unpack(result)
end

--[[ int setBit( int integer, int index, int value )
	Sets the bit with the index index to value.
	integer: The integer.
	index: Index of the bit that should be set.
	value: New value of the bit. (0 or 1) ]]
function setBit(integer, index, value)
	check("setBit", "number", integer, "integer", "number", index, "index", "number", value, "value")
	if (getBit(integer, index) ~= value) then return integer - -value * 2 ^ index
	else return integer end
end

--[[ int string.adler32 ( string str )
	Encrypts the given string with tha adler32 algorithm.
	str: String to be encrypted. ]]
function string.adler32(str)
	check("string.adler32", "string", str, "str")
	
	local length = #str
	local s1, s2 = 0, 1
	
	for n=1, length do
		s1 = (s1 + str.byte(str:sub(n, n))) % 65521
		s2 = (s2 + s1) % 65521
	end
	
	return (s2 * 2^16) + s1
end

--[[ int string.count( string haystack, string needle, [ int offset = 1, bool plain = true ] }
	Returns how often needle is findable in haystack.
	haystack: String that should be searched through.
	needle: String that should be searched for.
	offset: Index at which should be started counting.
	plain: Boolean determining if the needle is a plain string (true) or a regular expression (false). ]]
function string.count(self, needle, offset, plain)
	offset = (offset or 1) - 1
	plain = (plain == nil) and true or plain
	local count = -1
	
	check("string.count", "string", self, "haystack", "string", needle, "needle", "number", offset, "offset", "boolean", plain, "plain")
	
	repeat
		count = count + 1
		offset = self:find(needle, offset + 1, plain)
	until (not offset)
	
	return count
end

--[[ table string.explode( string ensemble, string separator, bool plain = true )
	Splits the ensemble at each occurrence of separator storing the occurring pieces in a table, which is returned at the end.
	ensemble: String that should be split up at the given separator.
	separator: String at which the given ensemble should be split up. ]]
function string.explode(self, separator)
	check("string.explode", "string", self, "ensemble", "string", separator, "separator")
	if (#self == 0) then return {} end
	if (#separator == 0) then return { self } end
	return loadstring("return {\""..self:gsub(separator, "\",\"").."\"}")()
end

--[[ number string.unformat( string str, [ string comma = "%.", string separator = "" ] )
	Unformats a formatted number and returns the numerical value of it.
	str: Formatted number.
	comma: String used as comma.
	separator: String used as thousand separator. ]]
function string.unformat(self, comma, separator)
	check("string.unformat", "string", self, "str", {"nil","string"}, comma, "comma", {"nil","string"}, separator, "separator")

	if (separator) then self = self:gsub(separator, "") end
	if (comma) then self = self:gsub(comma, ".") end

	return tonumber(self)
end

--[[ bool strToBool( string str )
	Converts a string to a boolean.
	str: String to convert. ]]
function strToBool(str)
	check("strToBool", "string", str, "str")
	return (str == "true" or (tonumber(string) and tonumber(str) ~= 0))
end

--[[ var table.colsearch( table tab, var needle, var index, [ table compareParams = {} ] )
	Searches only one col in a twodimensional table.
	tab: Table to search through.
	needle: Value to search for.
	index: Index to search through.
	compareParams: Table containing the arguments for table.compare if two tables are compared. Format: [argname1] = value1, ... Use ["identical"] = true to search for similar pointers. ]]
function table.colsearch(tab, needle, index, compareParams)
	check("table.colsearch", "table", tab, "tab", {"boolean","number","string","table","function","userdata","thread"}, needle, "needle", {"boolean","number","string","table","function","userdata","thread"}, index, "index", {"nil","table"}, compareParams, "compareParams")
	
	for key, value in next, tab do
		local vType = type(value[index])
		
		if (vType == type(needle) and
			(vType ~= "table" or compareParams.identical or table.compare(value[index], needle, compareParams.subset, compareParams.ignoreTypes, compareParams.ignoreKeys, compareParams.ignoredOnly, compareParams.depthIndex)) and
			((vType == "table" and not compareParams.identical) or value[index] == needle))
		then return key end
	end
end

--[[ bool table.compare( table tab1, table tab2, [ bool subset = false, table ignoreTypes = {}, table ignoreKeys = {}, var ignoredOnly = false, var depthIndex = "_" ] )
	Compares two tables.
	tab1: The first table.
	tab2: The second table.
	subset: If set to true the function will check if the smaller table is a subset of the bigger one.
	ignoreTypes: Table containing information about which value types should be ignored for the comparison. If e.g. ignoreTypes = { table = true } all tables the tables are containing will be ignored for the comparison.
	ignoreKeys: Table containing information about which keys should be ignored for the comparison. If e.g. ignoreKeys = { [1] = true } the fields with the index 1 will be ignored for the comparison.
	ignoredOnly: Determines if either both, only the ignored types, only the ignored keys or none of them should be compared instead of ignoring them while ignoring all other types/keys. [true, false, "keys", "types"]
	depthIndex: Tables in the tables will be compared with table.compare. You may specify ignoreTypes and ignoreKeys for deeper levels by storing their ignore-tables in the top ones using the depth index. ]]
function table.compare(tab1, tab2, subset, ignoreTypes, ignoreKeys, ignoredOnly, depthIndex)
	ignoreTypes = ignoreTypes or {}
	ignoreKeys = ignoreKeys or {}
	depthIndex = depthIndex or "_"
	local onlyTypes = (ignoredOnly == "types" or ignoredOnly == true)
	local onlyKeys = (ignoredOnly == "keys" or ignoredOnly == true)
	
	check("table.compare", "table", tab1, "tab1", "table", tab2, "tab2", {"nil","subset"}, subset, "subset", "table", ignoreTypes, "ignoreTypes", "table", ignoreKeys, "ignoreKeys", {"boolean","string"}, ignoredOnly, "ignoredOnly")
	
	if (tab1 == tab2) then return true end
	if ((subset and table.size(tab1) > table.size(tab2)) or (not subset and table.size(tab1) < table.size(tab2))) then
		tab1, tab2 = tab2, tab1
	elseif (not subset and not ignoreTypes and not ignoreKeys and table.size(tab1) ~= table.size(tab2))
	then return false end
	
	if (onlyKeys) then
		for key, compare in next, ignoreKeys do
			if (compare) then
				local valueType = type(tab1[key])
				if (onlyTypes == not not ignoreTypes[valueType]) then
					if (tab2[key] == nil or (valueType == "table" and not table.compare(tab1[key], tab2[key], false, ignoreTypes[depthIndex], ignoreKeys[depthIndex], ignoredOnly) or tab1[key] ~= tab2[key])) then return false end
				end
			end
		end
	else
		for key, value in next, tab1 do
			local valueType = type(value)
			if (onlyTypes == not not ignoreTypes[valueType] and not ignoreKeys[key]) then
				if (tab2[key] == nil or (valueType == "table" and not table.compare(value, tab2[key], false, ignoreTypes[depthIndex], ignoreKeys[depthIndex], ignoredOnly) or value ~= tab2[key])) then return false end
			end
		end
	end
	
	return true
end

--[[ table table.convert( table tab, [ int depth = 0 ] )
	Converts all fields to their most fitting type at a time.
	tab: Table to be converted.
	depth: Integer determining how deep the conversion should go. E.g. 1 means that all tables in tab will be converted as well and so on. ]]
function table.convert(tab, depth)
	depth = depth or 0
	local ret = {}
	
	check("table.convert", "table", tab, "tab", {"nil","number"}, depth, "depth")
	
	for key, value in next, tab do
		if (type(value) == "string") then
			if (value == "true") then ret[key] = true
			elseif (value == "false") then ret[key] = false
			elseif (value == "nil") then ret[key] = nil
			else ret[key] = tonumber(value) or value end
		elseif (type(value) == "table" and depth ~= 0) then ret[key] = table.convert(value, depth - 1)
		else ret[key] = value end
	end
	
	return ret
end

--[[ table table.copy( table tab )
	Copies a table.
	tab: Table to copy. ]]
function table.copy(tab)
	check("table.copy", "table", tab, "tab")
	local ret = {}
	for key, value in next, tab do ret[key] = (type(value)=="table" and table.copy(value) or value) end
	return ret
end

--[[ string table.implode( table tab, string separator, [ table indexTypes = {["nil"]=true,boolean=true,number=true,string=true,table=true,function=true,userdata=true,thread=true}, table idxMin = nil, table idxMax = nil ] )
	Same like table.concat but with the option to limit the concatenated fields' indices.
	tab: Table to be concatenated.
	separator: String to insert between the table fields.
	indexTypes: Types of the fields that should be concatenated. E.g. { string = true } will concatenate all fields with strings as index.
	idxMin: Minimum of each index type. E.g. { number = 4 } will set the minimum for numerical indices to 4.
	idxMax: Maximum of each index type. E.g. { string = "x" } will set the maximum for string indices to "x". ]]
function table.implode(tab, separator, indexTypes, idxMin, idxMax)
	idxMin, idxMax = idxMin or {}, idxMax or {}
	local imploded = ""
	
	check("table.implode", "table", tab, "tab", "string", separator, "separator", {"nil","table"}, indexTypes, "indexTypes", "table", idxMin, "idxMin", "table", idxMax, "idxMax")
	
	for key, value in next, tab do
		local keytype = type(key)
		if ((not indexTypes or indexTypes[keytype]) and (not idxMin[keytype] or key >= idxMin[keytype]) and (not idxMax[keytype] or key <= idxMax[keytype]))
		then imploded = imploded..separator..tostring(value) end
	end
	
	return imploded:sub(#separator + 1)
end

--[[ table table.map( table tab, int depth, var func, [ var arg1, ... ] )
	Executes the given func for every field of tab and stores the returned value in it.
	tab: Table to map.
	depth: Integer determining how deep the mapping should go. E.g. 1 means that all tables in tab will be mapped as well and so on.
	func: Function to be executed for each field or table with types as index and functions as values where each function will be executed for the corresponding tye.
	arg1-argn: Arguments that should be passed to the function. ]]
function table.map(tab, depth, func, ...)
	check("table.map", "table", tab, "tab", "number", depth, "depth", {"table","function"}, func, "func")
	
	local ret = {}
	
	for key, value in next, tab do
		if (type(value) == "table" and depth ~= 0) then ret[key] = table.map(value, depth - 1, func, ...)
		elseif (type(func) == "table" and func[type(value)]) then ret[key] = func[type(value)](value, ...)
		elseif (type(func) == "table") then ret[key] = value
		elseif (type(func) == "function") then ret[key] = func(value, ...) end
	end
	
	return ret
end

--[[ table, table table.resort( table tab, [ bool sortByKey = false, function sortFunc = function (a, b) ... end, bool keysFirst = false ] )
	Resorts a table on the basis of sortFunc and returns two tables, at first the one containing the sorted field values, after that a table containing the keys of the fields in the right order.
	tab: Table to resort.
	sortByKey: Set sortByKey to true if you want the table to be resort on the basis of the field indices.
	sortFunc: Function which gets two arguments and should return true if they're in the right order, otherwise false.
	keysFirst: Boolean determining if the table containing the keys in the right order should be returned as first value (true) or as second (false).  ]]
function table.resort(tab, sortByKey, sortFunc, keysFirst)
	sortFunc = sortFunc or function (a, b)
		local ta, tb = type(a), type(b)
		if (ta == tb) then
			if (ta == "number" or ta == "string") then return a <= b
			elseif (ta == "boolean") then return a end
		elseif (ta == "number") then return (tb == "boolean") and true or false
		elseif (ta == "string") then return (tb ~= "boolean" and tb ~= "number") and true or false
		elseif (ta == "boolean") then return true end
		return false
	end
	local tab, kret, vret = table.copy(tab), {}, {}
	local first
	
	check("table.resort", "table", tab, "tab", {"nil","boolean"}, sortByKey, "sortByKey", "function", sortFunc, "sortFunc", {"nil","boolean"}, keysFirst)
	
	while (table.size(tab) > 0) do
		for key, value in next, tab do
			if (not first) then first = key
			elseif ((sortByKey and sortFunc(key, first)) or (not sortByKey and sortFunc(value, tab[first]))) then first = key end
		end
		table.insert(kret, first)
		table.insert(vret, tab[first])
		first, tab[first] = nil
	end
	
	if (keysFirst) then return kret, vret
	else return vret, kret end
end

--[[ var table.search( table tab, var needle, [ var limits = {}, table ignoreKeys = {}, table compareParams = {} ] )
	Searches a table.
	tab: Table to search through.
	needle: Value to search for.
	limits: Either a index offset or a table containing two fields min and max, which contain the index limits.
	ignoreKeys: Table containing keys that should be ignored in the search.
	compareParams: Table containing the arguments for table.compare if two tables are compared. Format: [argname1] = value1, ... Use ["identical"] = true to search for similar pointers. ]]
function table.search(tab, needle, limits, ignoreKeys, ignoredOnly, compareParams)
	limits = limits or {}
	ignoreKeys = ignoreKeys or {}
	compareParams = compareParams or {}
	if (type(limits) ~= "table") then limits = { min = limits } end
	
	check("table.search", "table", tab, "tab", {"boolean","number","string","table","function","userdata","thread"}, needle, "needle", {"nil","number","string"}, limits.min, "limits.min", {"nil","number","string"}, limits.max, "limits.max")
	
	if (ignoredOnly) then
		for key, check in next, ignoreKeys do
			
		end
	else
		for key, value in next, tab do
			local kType = type(key)
			local vType = type(value)
			
			if (vType == type(needle) and
				(kType ~= type(limits.min) or key > limits.min) and
				(kType ~= type(limits.max) or key < limits.max) and
				not ignoreKeys[key] and
				(vType ~= "table" or compareParams.identical or table.compare(value, needle, compareParams.subset, compareParams.ignoreTypes, compareParams.ignoreKeys, compareParams.ignoredOnly, compareParams.depthIndex)) and
				((vType == "table" and not compareParams.identical) or value == needle))
			then return key end
		end
	end
end

--[[ int table.size( table tab )
	Retrieves the absolute size of a table.
	tab: Table whose size should be retrieved. ]]
function table.size(tab)
	check("table.size", "table", tab, "tab")
	local length = 0
	for _ in next, tab do length = length + 1 end
	return length
end

--[[ string table.structure( table tab, [ int depth = 0 ] )
	Returns the table's structure as a string.
	tab: Table to return the structure of.
	depth: Integer determining how deep the structure should be displayed. E.g. 1 means that the structure of all tables in tab will be displayed as well and so on. ]]
function table.structure(tab, depth)
	if (table.size(tab) == 0) then return "{ }" end
	depth = depth or 0
	local structure = "{ "
	
	check("table.structure", "table", tab, "tab", "number", depth, "depth")
	
	for key, value in next, tab do
		structure = structure.."["..(type(key) == "string" and "\""..tostring(key).."\"" or tostring(key)).."] = "
		if (type(value) == "table" and depth ~= 0) then structure = structure..table.structure(value, depth - 1).." , "
		else structure = structure..(type(value) == "string" and "\""..tostring(value).."\"" or tostring(value))..", " end
	end
	
	return structure:sub(1, -3).." }"
end


function exportstring( s )
	s = string.format( "%q",s )

	s = string.gsub( s,"\\\n","\\n" )
	s = string.gsub( s,"\r","\\r" )
	s = string.gsub( s,string.char(26),"\"..string.char(26)..\"" )
	return s
end


function table.save(tbl)
	if tbl == nil then return "return {{},}--|" end
	
	local charS,charE = "   ","\n"
	local file,err
	local filename = nil

	file =  { write = function( self,newstr ) self.str = self.str..newstr end, str = "" }
	charS,charE = "",""

	local tables,lookup = { tbl },{ [tbl] = 1 }
	file:write( "return {"..charE )
	for idx,t in ipairs( tables ) do
		if filename and filename ~= true and filename ~= 1 then
			file:write( "-- Table: {"..idx.."}"..charE )
		end
		file:write( "{"..charE )
		local thandled = {}
		for i,v in ipairs( t ) do
			thandled[i] = true
			if type( v ) ~= "userdata" then
				if type( v ) == "table" then
					if not lookup[v] then
						table.insert( tables, v )
						lookup[v] = #tables
				end
				file:write( charS.."{"..lookup[v].."},"..charE )
            elseif type( v ) == "function" then
               file:write( charS.."loadstring("..exportstring(string.dump( v )).."),"..charE )
            else
               local value =  ( type( v ) == "string" and exportstring( v ) ) or tostring( v )
               file:write(  charS..value..","..charE )
            end
		end
	end
	for i,v in pairs( t ) do
         if (not thandled[i]) and type( v ) ~= "userdata" then
            if type( i ) == "table" then
               if not lookup[i] then
                  table.insert( tables,i )
                  lookup[i] = #tables
               end
               file:write( charS.."[{"..lookup[i].."}]=" )
            else
               local index = ( type( i ) == "string" and "["..exportstring( i ).."]" ) or string.format( "[%d]",i )
               file:write( charS..index.."=" )
            end
            if type( v ) == "table" then
               if not lookup[v] then
                  table.insert( tables,v )
                  lookup[v] = #tables
               end
               file:write( "{"..lookup[v].."},"..charE )
            elseif type( v ) == "function" then
               file:write( "loadstring("..exportstring(string.dump( v )).."),"..charE )
            else
               local value =  ( type( v ) == "string" and exportstring( v ) ) or tostring( v )
               file:write( value..","..charE )
            end
         end
		end
		file:write( "},"..charE )
	end
	file:write( "}" )

	return file.str.."--|"
end

function table.load( sfile )
	if not sfile then return {} end
	local tables, err = loadstring( sfile )
	if err then return _,err end
	tables = tables()
	for idx = 1,#tables do
		local tolinkv,tolinki = {},{}
		for i,v in pairs( tables[idx] ) do
			if type( v ) == "table" and tables[v[1]] then
				table.insert( tolinkv,{ i,tables[v[1]] } )
			end
			if type( i ) == "table" and tables[i[1]] then
				table.insert( tolinki,{ i,tables[i[1]] } )
			end
		end
		for _,v in ipairs( tolinkv ) do
			tables[idx][v[1]] = v[2]
		end
		for _,v in ipairs( tolinki ) do
			tables[idx][v[2]],tables[idx][v[1]] =  tables[idx][v[1]],nil
		end
	end
	return tables[1]
end

function getGradient(perc, ...)
	local rgbtable = arg
	--[[
		Prozentwert umrechnen
		->
			Beispiel: 
				2 Farben
				Zwischenraum A und B = 0-100%
				aPerc = 100
			
				3 Farben
				Zwischenraum A und B = 0-50%
				Zwischenraum B und C = 50-100%
				aPerc = 50
				
	]]
	local aPerc = 100 / (#rgbtable -1)
	local color1
	local color2
	local bPerc
	
	
	for i = 1, #rgbtable do
		if perc <= aPerc*i then
			bPerc = 100/(aPerc*i)*perc
			color1 = rgbtable[i]
			color2 = rgbtable[i+1]
			break
		end
	end
	
	
	return getSimpleGradient(bPerc, color1[1], color1[2], color1[3], color2[1], color2[2], color2[3])
end

function getSimpleGradient(perc, r, g, b, r2, g2, b2)
	-- Offsets berechnen
	local offR = r2-r
	local offG = g2-g
	local offB = b2-b
	-- Prozentuale R / G / B Offset Werte berechnen
	offR = offR / 100 * perc
	offG = offG / 100 * perc
	offB = offB / 100 * perc
	-- Grundwert addieren
	offR = r + offR
	offG = g + offG
	offB = b + offB
	return math.floor(offR+0.5), math.floor(offG+0.5), math.floor(offB+0.5)
end

function mkColor(r, g, b)
	return {r, g, b}
end

function getPointFromDistanceRotation(x, y, dist, angle)
    local a = math.rad(90-angle)
    local dx = math.cos(a)*dist
    local dy = math.sin(a)*dist

    return x+dx, y+dy
end