 --[[
Project: VitaOnline
File: iteminfo-shared.lua
Author(s):	Sebihunter
			MrX
 ]]--

 gWeaponData = {
	{item = 9, id = 24}, --Deagle
	{item = 10, id = 29}, --MP5
	{item = 11, id = 1}, --Schlagring
	{item = 12, id = 2}, --Golfschläger
	{item = 13, id = 3}, --Schlagstock
	{item = 14, id = 24}, --Messer
	{item = 15, id = 5}, --Baseballschläger
	{item = 16, id = 6}, --Schaufel
	{item = 17, id = 7}, --Billiardstock
	{item = 18, id = 8}, --Katana
	{item = 19, id = 9}, --Kettensäge
	{item = 20, id = 15}, --Stock
	{item = 21, id = 22}, --Pistole
	{item = 22, id = 23}, --Schallgedämpfte
	{item = 23, id = 25}, --Schrotflinte
	{item = 24, id = 26}, --Abgesägte
	{item = 25, id = 27}, --SPAZ-12
	{item = 26, id = 28}, --Uzi
	{item = 27, id = 32}, --Tec-9
	{item = 28, id = 30}, --AK-47
	{item = 29, id = 31}, --M4
	{item = 30, id = 33}, --Country Rifle
	{item = 31, id = 34}, --Sniper
	{item = 32, id = 37}, --Flammenwerfer
	{item = 33, id = 16}, --Granaten
	{item = 34, id = 17}, --Tränengas
	{item = 35, id = 18}, --Molotov Cocktail
	{item = 36, id = 39}, --Rucksackbombe
	{item = 37, id = 42}, --Feuerlöscher
	{item = 38, id = 44}, --Nachtsichtgerät
	{item = 39, id = 45}, --Infrarotgerät
	{item = 40, id = 46} --Fallschirm
 }
 
 -- Definierung aller Items auf dem Vita Server
gItemData = {
	[0] = { name = "Cola", 				model=2647, rx=0, 	ry=0, 	rz=0, 	zo=0.12,	stackable=true	}, -- Eine leckere und erfrischende Cola
	[1] = { name = "Wurstsemmel", 		model=1575, rx=0, 	ry=0, 	rz=0, 	zo=0,		stackable=true	}, -- Der Leckerbissen f�r zwischendurch
	[2] = { name = "Personalausweis", 	model=0, 	rx=0, 	ry=0, 	rz=0, 	zo=0,		stackable=false	}, -- Der Personalauswei� von San Andreas
	[3] = { name = "Tankkanister", 		model=1650, rx=0, 	ry=0, 	rz=0, 	zo=0.15,	stackable=true	}, -- Ein Tankkanister mit 10 Liter
	[4] = { name = "Fahrzeugradar", 	model=2886, rx=270, ry=0, 	rz=0, 	zo=0.1,		stackable=false	}, -- Ein Radar f�r dein Fahrzeug
	[5] = { name = "Ersatzreifen", 		model=1327, rx=0, 	ry=90, 	rz=9, 	zo=0.1,		stackable=true	}, -- Ein Ersatzreifen f�r dein Fahrzeug
	[6] = { name = "Handy", 			model=330, 	rx=90, 	ry=90, 	rz=0, 	zo=-0.05,	stackable=false }, -- Ein Handy
	[7] = { name = "Bier", 				model=1520, rx=0, 	ry=0, 	rz=0, 	zo=0.15,	stackable=true	}, -- Das gute alte Bier
	[8] = { name = "Kaffee", 			model=2647, rx=0, 	ry=0, 	rz=0, 	zo=0.12,	stackable=true	}, -- Der Muntermacher
	[9] = { name = "Desert Eagle", 		model=348, rx=0, 	ry=0, 	rz=0, 	zo=0.0,		stackable=true	}, -- Die kleine, feine Pistole
	[10] = { name = "MP5", 				model=353, rx=0, 	ry=0, 	rz=0, 	zo=0.0,		stackable=true	}, -- Unsere standart Maschinenpistole
	[11] = { name = "Schlagring", 		model=331, rx=0, 	ry=0, 	rz=0, 	zo=0.0,		stackable=true	}, -- Waffe
	[12] = { name = "Golfschlaeger", 	model=333, rx=0, 	ry=0, 	rz=0, 	zo=0.0,		stackable=true	}, -- Waffe
	[13] = { name = "Schlagstock", 		model=334, rx=0, 	ry=0, 	rz=0, 	zo=0.0,		stackable=true	}, -- Waffe
	[14] = { name = "Messer", 			model=335, rx=0, 	ry=0, 	rz=0, 	zo=0.0,		stackable=true	}, -- Waffe
	[15] = { name = "Baseballschlaeger",model=336, rx=0, 	ry=0, 	rz=0, 	zo=0.0,		stackable=true	}, -- Waffe
	[16] = { name = "Schaufel", 		model=337, rx=0, 	ry=0, 	rz=0, 	zo=0.0,		stackable=true	}, -- Waffe
	[17] = { name = "Billiardstock", 	model=338, rx=0, 	ry=0, 	rz=0, 	zo=0.0,		stackable=true	}, -- Waffe
	[18] = { name = "Katana", 			model=339, rx=0, 	ry=0, 	rz=0, 	zo=0.0,		stackable=true	}, -- Waffe
	[19] = { name = "Kettensaege", 		model=341, rx=0, 	ry=0, 	rz=0, 	zo=0.0,		stackable=true	}, -- Waffe
	[20] = { name = "Stock", 			model=326, rx=0, 	ry=0, 	rz=0, 	zo=0.0,		stackable=true	}, -- Waffe
	[21] = { name = "Pistole", 			model=346, rx=0, 	ry=0, 	rz=0, 	zo=0.0,		stackable=true	}, -- Waffe
	[22] = { name = "Schallged. Pist.", model=347, rx=0, 	ry=0, 	rz=0, 	zo=0.0,		stackable=true	}, -- Waffe
	[23] = { name = "Schrotflinte",		model=349, rx=0, 	ry=0, 	rz=0, 	zo=0.0,		stackable=true	}, -- Waffe
	[24] = { name = "Abgesaegte",		model=350, rx=0, 	ry=0, 	rz=0, 	zo=0.0,		stackable=true	}, -- Waffe
	[25] = { name = "SPAZ-12",	 		model=351, rx=0, 	ry=0, 	rz=0, 	zo=0.0,		stackable=true	}, -- Waffe
	[26] = { name = "Uzi",				model=352, rx=0, 	ry=0, 	rz=0, 	zo=0.0,		stackable=true	}, -- Waffe
	[27] = { name = "TEC-9",			model=353, rx=0, 	ry=0, 	rz=0, 	zo=0.0,		stackable=true	}, -- Waffe
	[28] = { name = "AK-47",			model=355, rx=0, 	ry=0, 	rz=0, 	zo=0.0,		stackable=true	}, -- Waffe
	[29] = { name = "M4",				model=356, rx=0, 	ry=0, 	rz=0, 	zo=0.0,		stackable=true	}, -- Waffe
	[30] = { name = "Country Rifle",	model=357, rx=0, 	ry=0, 	rz=0, 	zo=0.0,		stackable=true	}, -- Waffe
	[31] = { name = "Sniper Rifle", 	model=358, rx=0, 	ry=0, 	rz=0, 	zo=0.0,		stackable=true	}, -- Waffe
	[32] = { name = "Flammenwerfer", 	model=361, rx=0, 	ry=0, 	rz=0, 	zo=0.0,		stackable=true	}, -- Waffe
	[33] = { name = "Granaten", 		model=342, rx=0, 	ry=0, 	rz=0, 	zo=0.0,		stackable=true	}, -- Waffe
	[34] = { name = "Traenengas", 		model=343, rx=0, 	ry=0, 	rz=0, 	zo=0.0,		stackable=true	}, -- Waffe
	[35] = { name = "Molotov Cocktail", model=344, rx=0, 	ry=0, 	rz=0, 	zo=0.0,		stackable=true	}, -- Waffe
	[36] = { name = "Rucksackbomben", 	model=363, rx=0, 	ry=0, 	rz=0, 	zo=0.0,		stackable=true	}, -- Waffe
	[37] = { name = "Feuerloescher", 	model=366, rx=0, 	ry=0, 	rz=0, 	zo=0.0,		stackable=true	}, -- Waffe
	[38] = { name = "Nachtsichtgeraet", model=368, rx=0, 	ry=0, 	rz=0, 	zo=0.0,		stackable=true	}, -- Waffe
	[39] = { name = "Infrarotgeraet", 	model=369, rx=0, 	ry=0, 	rz=0, 	zo=0.0,		stackable=true	}, -- Waffe
	[40] = { name = "Fallschirm", 		model=371, rx=0, 	ry=0, 	rz=0, 	zo=0.0,		stackable=true	}, -- Waffe
	[41] = { name = "Strandtuch A", 	model=1640, rx=0, 	ry=0, 	rz=0, 	zo=-0.1,	stackable=true	}, -- Strandtuch A
	[42] = { name = "Strandtuch B", 	model=1641, rx=0, 	ry=0, 	rz=0, 	zo=-0.1,	stackable=true	}, -- Strandtuch B
	[43] = { name = "Strandtuch C", 	model=1642, rx=0, 	ry=0, 	rz=0, 	zo=-0.1,	stackable=true	}, -- Strandtuch C
	[44] = { name = "Strandtuch D", 	model=1643, rx=0, 	ry=0, 	rz=0, 	zo=-0.1,	stackable=true	}, -- Strandtuch D
	[45] = { name = "Vodka", 			model=1517, rx=0, 	ry=0, 	rz=0, 	zo=0.15,	stackable=true	}, -- Vodka
	[46] = { name = "Tragbares Radio", 	model=2103, rx=0, 	ry=0, 	rz=0, 	zo=-0.1,	stackable=true	}, -- Vodka
	[47] = { name = "Geld", 			model=1212, rx=0, 	ry=0, 	rz=0, 	zo=-0.1,	stackable=false	}, -- Geld
	[48] = { name = "Verbandszeug", 	model=1578, rx=0, 	ry=0, 	rz=0, 	zo=-0.1,	stackable=true	}, -- Verbandszeug
	[49] = { name = "Reparatur Kit", 	model=1210, rx=0, 	ry=0, 	rz=0, 	zo=0,	stackable=true	}, -- Verbandszeug
	[50] = { name = "Schokodonut", 		model=1575, rx=0, 	ry=0, 	rz=0, 	zo=0,		stackable=true	}, --Donut
	[51] = { name = "Vanilledonut", 	model=1575, rx=0, 	ry=0, 	rz=0, 	zo=0,		stackable=true	}, --Donut
	[52] = { name = "Erbeerdonut", 		model=1575, rx=0, 	ry=0, 	rz=0, 	zo=0,		stackable=true	}, --Donut
	[53] = { name = "Pfefferspray", 	model=1210, rx=0, 	ry=0, 	rz=0, 	zo=0.0,		stackable=true	}, -- Waffe
	[54] = { name = "Großer Dildo", 	model=321 , rx=0, 	ry=0, 	rz=0, 	zo=0.0,		stackable=true	}, -- Waffe
	[55] = { name = "Kleiner Dildo", 	model=322 , rx=0, 	ry=0, 	rz=0, 	zo=0.0,		stackable=true	}, -- Waffe
	[56] = { name = "Vibrator", 	    model=323 , rx=0, 	ry=0, 	rz=0, 	zo=0.0,		stackable=true	}, -- Waffe
	[57] = { name = "Glühwein", 		model=2647, rx=0, 	ry=0, 	rz=0, 	zo=0.12,	stackable=true	}, -- Glühwein
	[58] = { name = "Pizzaschnitte", 	model=1575, rx=0, 	ry=0, 	rz=0, 	zo=0,		stackable=true	}, -- Pizzaschnitte
	[59] = { name = "Happy Noodles", 	model=1575, rx=0, 	ry=0, 	rz=0, 	zo=0,		stackable=true	}, -- Happy Noodles
	[60] = { name = "Hot-Dog", 			model=1575, rx=0, 	ry=0, 	rz=0, 	zo=0,		stackable=true	}, -- Hot Dog
	[61] = { name = "Hanfsamen", 		model=1575, rx=0, 	ry=0, 	rz=0, 	zo=0,	stackable=true	}, -- Hanfsamen
	[62] = { name = "Joint", 			model=1485, rx=0, 	ry=0, 	rz=0, 	zo=0,		stackable=true	}, -- Joint
	[63] = { name = "Duchifal Tablette", model=1575, rx=0, 	ry=0, 	rz=0, 	zo=0,		stackable=true	} -- Duchifal
}
