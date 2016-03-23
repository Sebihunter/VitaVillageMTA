--[[
Project: VitaOnline
File: hanf-server.lua
Author(s):	Sebihunter
]]--

local gHanfSperrzonen = 
{
{1961.6999511719, 2323, 17}, --La Piedra
{1923.150390625, 960.2509765625, 10.8203125}, --Da Nangs
{260.10000610352, 1213.3000488281, 20.39999961853} -- Heaven Devils

}

local hanfTable = {}
function raucheHanf(source)
	if not hanfTable[source] then
		hanfTable[source] = {}
		hanfTable[source].ply = source
		hanfTable[source].times = 90
		hanfTable[source].noeffect = 10
	else
		hanfTable[source].times = hanfTable[source].times + 90
	end
end

setTimer(function()
	for i,v in pairs(hanfTable) do
		if isElement(v.ply) then
			v.times = v.times - 1
			if v.noeffect > 0 then v.noeffect = v.noeffect -1 end
			if v.times == 0 then
				setElementData(v.ply, "isHigh", false)
				hanfTable[i] = nil
			else
				if v.noeffect == 0 then
					setElementData(v.ply, "isHigh", true)
				end
			end
		else
			hanfTable[i] = nil
		end
	end
end, 1000,0)


function saveAllHanf()
	fileDelete( "./xml/hanf.xml")
	local xml = xmlCreateFile ( "./xml/hanf.xml", "hanf" )
	for _, item in ipairs(getElementsByType("object")) do
		if getElementData(item, "isHanf") == true then
			local x, y, z = getElementPosition(item)
			local ii = getElementInterior(item)
			local id = getElementDimension(item)
			local vehnode = xmlCreateChild ( xml, "hanf" )
			xmlNodeSetAttribute(vehnode, "x", x)
			xmlNodeSetAttribute(vehnode, "y", y)
			xmlNodeSetAttribute(vehnode, "z", z)
			xmlNodeSetAttribute(vehnode, "ii", ii)
			xmlNodeSetAttribute(vehnode, "id", id)
			xmlNodeSetAttribute(vehnode, "time", getElementData(item, "time"))
			xmlNodeSetAttribute(vehnode, "left", getElementData(item, "left"))
		end
	end
	xmlSaveFile ( xml )
	xmlUnloadFile ( xml )
end		
addEventHandler("onResourceStop", getResourceRootElement(getThisResource()),saveAllHanf)

function loadAllHanf()
	local xml = xmlLoadFile("xml/hanf.xml")
	local i = 0
	
	if xml then
		while true do
			local vehnode = xmlFindChild ( xml, "hanf", i)
			if not vehnode then
				break
			end
			if vehnode then
				local x = tonumber(xmlNodeGetAttribute(vehnode, "x"))
				local y = tonumber(xmlNodeGetAttribute(vehnode, "y"))
				local z = tonumber(xmlNodeGetAttribute(vehnode, "z"))
				local ii = tonumber(xmlNodeGetAttribute(vehnode, "ii"))
				local id = tonumber(xmlNodeGetAttribute(vehnode, "id"))
				local left = tonumber(xmlNodeGetAttribute(vehnode, "left"))
				local dtime = xmlNodeGetAttribute(vehnode, "time")
				if not dtime then dtime = left else dtime = tonumber(dtime) end
				createHanfpflanze(nil,x,y,z,ii,id,left, dtime)
			end
			i = i+1
		end
		xmlUnloadFile(xml)
		print("__~~*"..tonumber(i).." weed plants loaded!*~~__")
		setTimer(saveAllRootDroppedItems, 1800000, 0)
	else
		print("__~~*Failed to load weed plants*~~__")
	end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), loadAllHanf)
		

function checkSperrzone(x,y,z)
	for i,v in pairs(gHanfSperrzonen) do
		if getDistanceBetweenPoints3D ( x,y,z, v[1],  v[2], v[3]) < 200 then
			return true
		end
	end
	return false
end

function createHanfpflanze(ply,x,y,z,int,dim,left, dtime)
	if not left then left = 86400 end
	if not dtime then dtime = left end
	if not dim then dim = 0 end
	if not int then int = 0 end
	if not x or not y or not z then return false end
	if int ~= 0 or dim ~= 0 then
		if ply then triggerClientEvent ( ply, "addNotification", getRootElement(),  1, 255, 0, 0, "Du kannst in einem Interior kein Hanf anbauen." ) end
		return false
	end
	if checkSperrzone(x,y,z) then
		if ply then triggerClientEvent ( ply, "addNotification", getRootElement(),  1, 255, 0, 0, "Du kannst in dieser Gegend kein Hanf anbauen." ) end
		return
	end
	local obj = createObject(3409,x,y,z)
	setElementData(obj, "isHanf", true)
	setElementData(obj, "percent", 0)
	setElementData(obj, "time", dtime)
	setElementData(obj, "left", left)
	setObjectScale ( obj, 0.1 )
	local timer = nil
	if left ~= 0 then
		timer = setTimer(function(obj)
			if not isElement(obj) then return end
			if getElementData(obj, "timer") and isTimer(getElementData(obj, "timer")) then
				local _,left,_ = getTimerDetails ( getElementData(obj, "timer") )
				local all = getElementData(obj, "time")
				setElementData(obj, "left", left)
				setElementData(obj, "percent", math.round((all-left)/all,2)*100)
				if left == 1 then
					setElementData(obj, "left", 0)
					setElementData(obj, "erntbar", true)
				end
			end
		end, 1000, left, obj)
	else
		setElementData(obj, "erntbar", true)
		setElementData(obj, "percent", 100)
	end
	setElementData(obj, "timer", timer)
	if ply then
		triggerClientEvent ( ply, "addNotification", getRootElement(),  1, 0, 255, 0, "Hanfpflanze wurde erfolgreich angebaut.\nKomme in 24 Stunden wieder um es zu ernten." )
	end
	return obj
end

function pickUpHanf(player)
	local x, y, z = getElementPosition(player)
	local objs = getElementsByType("object")
	for theKey,obj in ipairs(objs) do 
		if getElementData(obj, "isHanf") == true then
			local x1, y1, z1 = getElementPosition(obj)
			if getDistanceBetweenPoints3D(x, y, z, x1, y1, z1) < 3 then
				if getElementData(player, "dienst") == 1 and getElementData(player, "job") == 3 then
					local timer = getElementData(obj, "timer")
					if isTimer(timer) then killTimer(timer) end
					destroyElement(obj)
					triggerClientEvent ( player, "addNotification", getRootElement(),  1, 0, 255, 0, "Hanfpflanze erfolgreich zerstört." )
				elseif getElementData(obj, "erntbar") == true then
					local timer = getElementData(obj, "timer")
					if isTimer(timer) then killTimer(timer) end				
					destroyElement(obj)
					local int = math.random(1,5) 
					for i=1, int do
						giveItem(player, 62)
					end
					setElementData(player, "exp", getElementData(player, "exp")+50)
					triggerClientEvent ( player, "addNotification", getRootElement(),  1, 0, 255, 0, "Du hast "..int.." Joints aus der Pflanze bauen können." )
				end
				break
			end
		end
	end 
end