numb2 = 0
numb3 = 0
text = ""

--[[
weps = { [1] = {
{name = "Brass Knuckles", 	id = 1,ammo = 1, 	price= 30,	cid=331, ws=1},
{name = "Golfschlaeger", 		id = 2,ammo = 1, 	price= 50,	cid=333, ws=1},
{name = "Schlagstock", 		id = 3,ammo = 1, 	price= 65,	cid=334, ws=1},
{name = "Messer", 		id = 4,ammo = 1, 	price= 500,	cid=335, ws=1},
{name = "Baseballschlaeger", 	id = 5,ammo = 1, 	price= 100,	cid=336, ws=1},
{name = "Schaufel", 		id = 6,ammo = 1, 	price= 40,	cid=337, ws=0},
{name = "Billiardstock", 		id = 7,ammo = 1, 	price= 45,	cid=338, ws=1},
{name = "Katana", 		id = 8,ammo = 1, 	price= 500,	cid=339, ws=1},
{name = "Kettensege", 		id = 9,ammo = 1, 	price= 300,	cid=341, ws=2},
{name = "Stock", 		id = 15,ammo = 1, 	price= 60,	cid=326, ws=1},
{name = "Pistole",		id = 22,ammo = 30, 	price= 300,	cid=346, ws=2},
{name = "Schallgedaempfte Pistole", 	id = 23,ammo = 45, 	price= 400,	cid=347, ws=2},
{name = "Desert Eagle", 	id = 24,ammo = 30, 	price= 600,	cid=348, ws=2},
{name = "Schrotflinte", 		id = 25,ammo = 30, 	price= 400,	cid=349, ws=3},
{name = "Abegaegte Schrotflinte", 	id = 26,ammo = 30, 	price= 500,	cid=350, ws=3},
{name = "SPAZ-12", 		id = 27,ammo = 40, 	price= 700,	cid=351, ws=3},
{name = "Uzi/s", 		id = 28,ammo = 100, 	price= 700,	cid=352, ws=3},
{name = "MP5",			id = 29,ammo = 120, 	price= 900,	cid=353, ws=3},
{name = "TEC-9", 		id = 32,ammo = 100, 	price= 1400,	cid=372, ws=3},
{name = "AK-47", 		id = 30,ammo = 100, 	price= 1000,	cid=355, ws=3},
{name = "M4", 			id = 31,ammo = 100, 	price= 1200,	cid=356, ws=3},
{name = "Country Rifle", 	id = 33,ammo = 30, 	price= 1100,	cid=357, ws=3},
{name = "Scharfschuetzengewehr", 	id = 34,ammo = 30, 	price= 1500,	cid=358, ws=3},
{name = "Flammenwerfer", 	id = 37,ammo = 100, 	price= 500,	cid=361, ws=3},
{name = "Granaten", 		id = 16,ammo = 5, 	price= 500,	cid=342, ws=3},
{name = "Traenengas", 		id = 17,ammo = 5, 	price= 400,	cid=343, ws=2},
{name = "Molotov Cocktails", 	id = 18,ammo = 5, 	price= 450,	cid=344, ws=3},
{name = "Rucksagbomben", 	id = 39,ammo = 5, 	price= 600,	cid=363, ws=3},
{name = "Feuerloescher", 	id = 42,ammo = 500, 	price= 20,	cid=366, ws=1},
{name = "Nachtsichtgeraet", id = 44,ammo = 1, 	price= 1000,	cid=368, ws=0},
{name = "Infrarotgeraet", 	id = 45,ammo = 1, 	price= 1000,	cid=369, ws=0},
{name = "Fallschirm", 		id = 46,ammo = 1, 	price= 500,	cid=371, ws=0}
}
}]]
weps = { [1] = {
--WS 0
{name = "Fallschirm", id = 46,ammo = 1, price= 500,	cid=371, ws=0},
--WS 1
{name = "Pfefferspray", 	id = 41,ammo = 100, 	price= 30,	cid=365, ws=1},
{name = "Schlagring", 	id = 1,ammo = 1, 	price= 30,	cid=331, ws=1},
{name = "Baseballschläger", 	id = 5,ammo = 1, 	price= 100,	cid=336, ws=1},
--WS 2
{name = "Schlagstock", 	id = 3,ammo = 1, 	price= 65,	cid=334, ws=2},
{name = "Tränengas", 	id = 17,ammo = 5, 	price= 400,	cid=343, ws=2},
{name = "Deagle", 	id = 24,ammo = 30, 	price= 600,	cid=348, ws=2},
{name = "MP5",	id = 29,ammo = 120, 	price= 900,	cid=353, ws=2}
}
}

addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),
	function()
		local x,y = guiGetScreenSize()
		button = guiCreateButton( x/2.35, y/1.6, x/6, y/15, "Kaufen", false )
		guiSetProperty(button, "HoverTextColour", "FF00FF00" ) 
		levbutton = guiCreateButton( x/1.5, y/1.3, x/12, y/30, "Verlassen", false )
		guiSetProperty( levbutton, "HoverTextColour", "FFFF0000" )
		guiSetVisible(button,false)
		guiSetVisible(levbutton,false)
		nextbtn = guiCreateLabel(0.66,0.63,0.03,0.05,"", true)
		prevbtn = guiCreateLabel(0.33,0.63,0.03,0.05,"", true)
		guiSetVisible(nextbtn,false)
		guiSetVisible(prevbtn,false)
	end
)
local isHit = false
addEvent("onMarkerDoHit",true)
addEventHandler("onMarkerDoHit", getLocalPlayer(),
	function(name, wp)
		if isHit == true then return end
			isHit = true
			if wp then
				weaptable = wp
			else
				weaptable = 1
			end
			numb = 1
			addEventHandler("onClientRender", getRootElement(), doShowTheWeapons)
			showCursor(true)
			bindKey("arrow_l", "down", prev)
			bindKey("arrow_r", "down", next)
			bindKey("enter", "down", buyit)
			bindKey("mouse_wheel_down", "down", prev)
			bindKey("mouse_wheel_up", "down", next)
			bindKey("delete", "down", leavethemark)
			guiSetVisible(button,true)
			guiSetVisible(nextbtn,true)
			guiSetVisible(prevbtn,true)
			guiSetVisible(levbutton,true)
			addEventHandler("onClientGUIClick", nextbtn, next,false)
			addEventHandler("onClientGUIClick", prevbtn, prev,false)
			addEventHandler("onClientGUIClick", button, buyit,false)
			addEventHandler("onClientGUIClick", levbutton, leavethemark,false)
	end
)
addEvent("onMarkerDoLeave",true)
function leavethemark()
	if isHit == false then return end
	isHit = false
	removeEventHandler("onClientRender", getRootElement(), doShowTheWeapons)
	showCursor(false)
	unbindKey("arrow_l", "down", prev)
	unbindKey("arrow_r", "down", next)
	unbindKey("enter", "down", buyit)
	unbindKey("mouse_wheel_down", "down", prev)
	unbindKey("mouse_wheel_up", "down", next)
	unbindKey("delete", "down", leavethemark)
	guiSetVisible(button,false)
	guiSetVisible(levbutton,false)
	guiSetVisible(nextbtn,false)
	guiSetVisible(prevbtn,false)
	removeEventHandler("onClientGUIClick", nextbtn, next,false)
	removeEventHandler("onClientGUIClick", prevbtn, prev,false)
	removeEventHandler("onClientGUIClick", button, buyit,false)
	removeEventHandler("onClientGUIClick", levbutton, leavethemark,false)
end
addEventHandler("onMarkerDoLeave", getLocalPlayer(),leavethemark)
addEvent("boughta", true)
addEventHandler("boughta", getLocalPlayer(),
	function(texts)
		text = texts
		if timertoweaps == 1 then
			killTimer(tmrtowep)
		end
		tmrtowep = setTimer(timertowep,5000,1)
		timertoweaps = 1
	end
)
function timertowep()
	timertoweaps = 0
	text = ""
end
function doShowTheWeapons()
	local x,y = guiGetScreenSize()
	numb2 = numb +1
	numb3 = numb -1
	if numb < 1 then
		numb = 1
	end
	if numb > #weps[1] then
		numb = #weps[1]
	end
	name,wp,amtn,prc = weps[weaptable][numb].name,weps[weaptable][numb].id,weps[weaptable][numb].ammo,weps[weaptable][numb].price
	dxDrawRectangle ( x/3.8, y/3.8, x/2.03, y/2, tocolor ( 0, 0, 0, 150 ) ) 
	dxDrawText ( "Wilkommen im Waffenladen", x/3.15, y/3.6, x, y, tocolor ( 255, 255, 255, 255 ), 1.5, "beckett" )
    dxDrawText ( "Wilkommen im Waffenladen", x/3.14, y/3.58, x, y, tocolor ( 0, 0, 0, 100 ), 1.5, "beckett" )
	dxDrawLine ( x/3.8, y/3.07, x/1.325, y/3.07, tocolor ( 255, 255, 255, 255 ), 2 )
	dxDrawLine ( x/3.8, y/3.8, x/1.325, y/3.8, tocolor ( 255, 255, 255, 255 ), 2 ) 



	dxDrawText ( "Binds: ", x/3.5, y/2.9, x, y, tocolor ( 255, 255, 255, 255 ), 1, "default" ) 
	dxDrawText ( "Enter - Kaufen ", x/3.5, y/2.8, x, y, tocolor ( 255, 255, 255, 255 ), 1, "default" ) 
	dxDrawText ( "Entf - Abbrechen", x/3.5, y/2.7, x, y, tocolor ( 255, 255, 255, 255 ), 1, "default" ) 
	dxDrawText ( "Pfeil Links - Naechste Waffe", x/3.5, y/2.55, x, y, tocolor ( 255, 255, 255, 255 ), 1, "default" ) 
	dxDrawText ( "Pfeil Rechts - Vorherige Waffe", x/3.5, y/2.47, x, y, tocolor ( 255, 255, 255, 255 ), 1, "pdefaultn" ) 



	dxDrawText ( "Waffe: "..name, x/2.5, y/2, x, y, tocolor ( 255, 255, 255, 255 ), 1, "pricedown" ) 
	dxDrawText ( "Munition: "..amtn, x/2.5, y/1.9, x, y, tocolor ( 255, 255, 255, 255 ), 1, "pricedown" )
	dxDrawText ( "Preis: "..prc, x/2.5, y/1.8, x, y, tocolor ( 255, 255, 255, 255 ), 1, "pricedown" )
	if numb3 >= 1 then
		dxDrawText ( "<", x/3, y/1.6, x, y, tocolor ( 255, 255, 255, 255 ), 3, "pricedown" )
	end
	if numb2 <= #weps[1] then
		dxDrawText ( ">", x/1.5, y/1.6, x, y, tocolor ( 255, 255, 255, 255 ), 3, "pricedown" )
	end
        dxDrawLine ( x/3.8, y/1.40, x/1.325, y/1.40, tocolor ( 255, 255, 255, 255 ), 2 )
	dxDrawLine ( x/3.8, y/1.31, x/1.325, y/1.31, tocolor ( 255, 255, 255, 255 ), 2 )
       -- dxDrawText ( "Waffenlobby von San Andreas", x/2.9, y/1.4, x, y, tocolor ( 200, 200, 200, 075 ), 1.5, "diploma" )
        dxDrawLine ( x/3.8, y/3.8, x/3.8, y/1.31, tocolor ( 255, 255, 255, 255 ), 2 )
	dxDrawLine ( x/1.325, y/3.8, x/1.325, y/1.31, tocolor ( 255, 255, 255, 255 ), 2 )
	dxDrawText ( text, 0, y/1.1, x, y, tocolor ( 255, 255, 255, 255 ), 1, "pricedown","center" )
	if numb > 0 or numb <= #weps[1] then
		dxDrawImage ( x/2 - 50, x/4,64, 64, "ammu/"..weps[weaptable][numb].id..".png", 0, 0, -120 )
	end
	if numb2 <= #weps[1] then
		dxDrawImage ( x/2 + 20 , x/4,64, 64, "ammu/"..weps[weaptable][numb2].id..".png", 0, 0, -120,tocolor(255,255,255,100) )
	end
	if numb3 ~= 0 then
		dxDrawImage ( x/2 - 120, x/4,64, 64, "ammu/"..weps[weaptable][numb3].id..".png", 0, 0, -120,tocolor(255,255,255,100) )
	end

end
function prev()
	numb = numb-1
	if numb == 0 then
		numb = 1
		playSoundFrontEnd(4)
	else
		playSoundFrontEnd(40)
	end
end
function next()
	numb = numb+1
	if numb > #weps[1] then
		playSoundFrontEnd(4)
		numb = #weps[1]
	else
		playSoundFrontEnd(40)
	end
end

function buyit()
	if weps[weaptable][numb].ws then
		if weps[weaptable][numb].ws > getElementData(getLocalPlayer(), "wschein") then
			text = "Du benötigst mindestens einen Waffenschein der Stufe "..tostring(weps[weaptable][numb].ws).." um eine "..weps[weaptable][numb].name.." zu kaufen."
			return
		end
	end
	name,wp,amtn,prc = weps[weaptable][numb].name,weps[weaptable][numb].id,weps[weaptable][numb].ammo,weps[weaptable][numb].price
	triggerServerEvent("doBuyTheWeap", getLocalPlayer(), getLocalPlayer(), name,wp,amtn,prc)
end
