shops = {
{x=296.3,	y=-37.4,	z=1000.5,	int=1,	dim=0,	name="Ammu Nation"}, -- AMMU 1
{x=296.3,	y=-37.4,	z=1000.5,	int=1,	dim=1,	name="Ammu Nation"}, -- AMMU 1
{x=296.3,	y=-37.4,	z=1000.5,	int=1,	dim=2,	name="Ammu Nation"}, -- AMMU 1
{x=296.3,	y=-37.4,	z=1000.5,	int=1,	dim=3,	name="Ammu Nation"}, -- AMMU 1
{x=296.3,	y=-37.4,	z=1000.5,	int=1,	dim=4,	name="Ammu Nation"}, -- AMMU 1
{x=296.3,	y=-37.4,	z=1000.5,	int=1,	dim=5,	name="Ammu Nation"}, -- AMMU 1
{x=296.3,	y=-37.4,	z=1000.5,	int=1,	dim=6,	name="Ammu Nation"}, -- AMMU 1
{x=296.3,	y=-80.4,	z=1000.5,	int=4,	dim=0,	name="Ammu Nation"}, -- AMMU 2
{x=296.3,	y=-80.4,	z=1000.5,	int=4,	dim=1,	name="Ammu Nation"}, -- AMMU 2
{x=296.3,	y=-80.4,	z=1000.5,	int=4,	dim=2,	name="Ammu Nation"}, -- AMMU 2
{x=296.3,	y=-80.4,	z=1000.5,	int=4,	dim=3,	name="Ammu Nation"}, -- AMMU 2
{x=296.3,	y=-80.4,	z=1000.5,	int=4,	dim=4,	name="Ammu Nation"}, -- AMMU 2
{x=296.3,	y=-80.4,	z=1000.5,	int=4,	dim=5,	name="Ammu Nation"}, -- AMMU 2
{x=296.3,	y=-80.4,	z=1000.5,	int=4,	dim=6,	name="Ammu Nation"}, -- AMMU 2
{x=290.13,	y=-109.32,	z=1000.51,	int=6,	dim=1,	name="Ammu Nation"}, -- AMMU 3
{x=290.13,	y=-109.32,	z=1000.51,	int=6,	dim=2,	name="Ammu Nation"}, -- AMMU 3
{x=290.13,	y=-109.32,	z=1000.51,	int=6,	dim=3,	name="Ammu Nation"}, -- AMMU 3
{x=290.13,	y=-109.32,	z=1000.51,	int=6,	dim=4,	name="Ammu Nation"}, -- AMMU 3
{x=290.13,	y=-109.32,	z=1000.51,	int=6,	dim=5,	name="Ammu Nation"}, -- AMMU 3
{x=290.13,	y=-109.32,	z=1000.51,	int=6,	dim=6,	name="Ammu Nation"} -- AMMU 3
}
function start()
	for vv, mark in ipairs(shops) do
		x,y,z,int,dim,test = mark.x,mark.y,mark.z,mark.int,mark.dim,mark.name
		local marker =  createMarker(x,y,z,"cylinder", 1.5,255,0,0,255)
		setElementInterior(marker,int)
		setElementDimension(marker,dim)
		addEventHandler("onMarkerHit", marker, markerhit)
		addEventHandler("onMarkerLeave", marker, markerleave)
	end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), start)
function markerhit(source)
	triggerClientEvent("onMarkerDoHit", source, test)
end
function markerleave(source)
	triggerClientEvent("onMarkerDoLeave", source)
end
addEvent("doBuyTheWeap",true)
addEventHandler("doBuyTheWeap", getRootElement(),
	function(source, name,wepn,amnt, weprice)
		if getElementData(source, "geld") >= weprice then
			triggerClientEvent("boughta",source,"Gekauft (im Inventar): "..name.."(ID: "..wepn..") Preis: "..weprice.."!")
			triggerEvent ( "buyInventWeapon", source, wepn)
			--giveWeapon(source, wepn,amnt,true)
			setElementData(source, "geld", getElementData(source, "geld")-weprice)
		else
			triggerClientEvent("boughta",source,"Du hast nicht genug Geld um folgendes zu kaufen: "..name.."!")
		end
	end
)