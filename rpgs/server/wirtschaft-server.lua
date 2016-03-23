--[[
Project: VitaOnline
File: wirtschaft-server.lua
Author(s):	MrX
			Sebihunter
]]--

--[[
>> TANKSTELLEN <<
]]--

tankstellen = {}
tankstellenBlip = createElement("container")
tankTrailer = {}
adacTrailer = {}
adacPickups = {}

addEventHandler("onResourceStart", getResourceRootElement(),
	function()
		local xmlRoot = xmlCreateOrLoad("xml/wirtschaft/tankstellen.xml", "tankstellen")
		local xmlChildren = xmlNodeGetChildren(xmlRoot)
		for k, v in pairs(xmlChildren) do 
			local id = xmlNodeGetAttribute(v, "id")
			local x = xmlNodeGetAttribute(v, "x")
			local y = xmlNodeGetAttribute(v, "y")
			local size = xmlNodeGetAttribute(v, "size")
			local fuel = xmlNodeGetAttribute(v, "fuel")
			tankstellen[tonumber(id)] = createElement("tankstelle")
			local colC = createColCircle(tonumber(x), tonumber(y), tonumber(size))
			setElementData(tankstellen[tonumber(id)], "colCircle", colC)
			setElementData(colC, "tankstelle", tankstellen[tonumber(id)])
			addEventHandler("onColShapeHit", colC, tankColshapeHit)
			if fuel ~= "nil" and fuel ~= "false" and fuel ~= false and fuel ~= nil then
				if tonumber(fuel) > 1000 then
					setElementData(tankstellen[tonumber(id)], "fuel", 1000)
					fuel = 1000	
				else
					setElementData(tankstellen[tonumber(id)], "fuel", tonumber(fuel))
				end
			else
				setElementData(tankstellen[tonumber(id)], "fuel", 1000)
				fuel = 1000
			end
			local r, g, b
			local x, y, z
			--									 | Rot        | Gelb         | Grün
			r, g, b = getGradient(tonumber(fuel)/100, {255, 0, 0}, {255, 255, 0}, {0, 255, 0})
			x, y, z = getElementPosition(colC)
			local blip = createBlip(x, y, z, 0, 2, r, g, b, 255, 0, 99999)
			setElementData(tankstellen[tonumber(id)], "blip", blip)
			setElementParent(blip, tankstellenBlip)
			
		end
		setElementVisibleTo(tankstellenBlip, getRootElement(), false)
		
		tankTrailer[1] = createRPGVehicle(584, 262.9189453125, 1403.92578125, 11.656366348267, 269.26528930664, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false)
		tankTrailer[2] = createRPGVehicle(584, 262.9189453125, 1408.92578125, 11.656366348267, 269.26528930664, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false)
		tankTrailer[3] = createRPGVehicle(584, 262.9189453125, 1413.92578125, 11.656366348267, 269.26528930664, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false)
		for i,v in ipairs(tankTrailer) do
			local x,y,z = getElementPosition(v)
			local _,_,rz = getElementRotation(v)
			setElementData(v, "spos", {x,y,z,rz})
			setElementData(v, "sid", i)
			setVehicleDamageProof ( v, true )
		end
		
		adacTrailer[1] = createRPGVehicle(591, -1728.78,60.932,3.16, 180, "Niemand",{{234,198,0},{234,198,0},{0,0,0},{0,0,0}}, true, false)
		adacTrailer[2] = createRPGVehicle(591, -1732.78,60.932,3.16, 180, "Niemand",{{234,198,0},{234,198,0},{0,0,0},{0,0,0}}, true, false)
		adacTrailer[3] = createRPGVehicle(591, -1736.78,60.932,3.16, 180, "Niemand",{{234,198,0},{234,198,0},{0,0,0},{0,0,0}}, true, false)
		for i,v in ipairs(adacTrailer) do
			local x,y,z = getElementPosition(v)
			local _,_,rz = getElementRotation(v)
			setElementData(v, "spos", {x,y,z,rz})
			setElementData(v, "sid", i)
			setElementData(v, "left", 2)
			setVehicleDamageProof ( v, true )
		end		
	end
)

addEventHandler("onTrailerDetach", getRootElement(), 
	function(truck)
		for i,v in ipairs(adacTrailer) do
			if v == source then
				local player = getVehicleOccupant(truck)
				setBlipsAdac(player, false)
				break
			end
		end
		for i,v in ipairs(tankTrailer) do
			if v == source then
				setElementData(source, "oldtruck", truck)
				local player = getVehicleOccupant(truck)
				if player then
					setElementVisibleTo(tankstellenBlip, player, false)
				end			
				break
			end
		end
	end
)
addEventHandler("onTrailerAttach", getRootElement(), 
	function(truck)
		for i,v in ipairs(adacTrailer) do
			if v == source then
				local player = getVehicleOccupant(truck)
				setBlipsAdac(player, true)
				triggerClientEvent ( player, "showTutorialMessage", getRootElement(), "wirt_1", "Dieser Trailer muss an eine der AutoFix Firmensitze gefahren werden. Fahre dazu einfach zu den Markierungen auf der Karte." )
				break
			end
		end	
		for i,v in ipairs(tankTrailer) do
			if v == source then	
				local player = getVehicleOccupant(truck)
				if player then
					refreshTankstellenBlips()
					triggerClientEvent ( player, "showTutorialMessage", getRootElement(), "wirt_2", "Dieser Trailer muss an eine leere Tankstelle gebracht werden. Fahre dazu einfach zu den Markierungen auf der Karte." )
					setElementVisibleTo(tankstellenBlip, player, true)
				end
			end
		end
	end
)

function refreshTankstellenBlips()
	for i,v in ipairs(getElementsByType("tankstelle")) do
		local blip = getElementData(v, "blip") 
		local fuel = getElementData(v, "fuel")
		if blip and fuel then
			local r, g, b = getGradient(tonumber(fuel)/15, {255, 0, 0}, {255, 255, 0}, {0, 255, 0})
			setBlipColor ( blip, r,g,b, 255 )
		end
	end
end

function setBlipsAdac(ply, toggle)
	if ply and isElement(ply) then
		if toggle == true then
			if not adacPickups[ply] then
				adacPickups[ply] = {}
				for i,v in ipairs(adac_repair) do
					if getElementData(v, "repairs") <= 3 then
						adacPickups[ply][#adacPickups[ply]+1] = createBlipAttachedTo ( v, 0, 2, 234, 198, 0, 255, 0, 999999, ply)
					end
				end
			end
		else
			if adacPickups[ply] then
				for i,v in ipairs(adacPickups[ply]) do
					destroyElement(v)
					adacPickups[ply] = false
				end
			end
		end
	end
end

function hideTankblips()
	setElementVisibleTo(tankstellenBlip, source, false)
	setBlipsAdac(source,false)
end
addEventHandler("onPlayerExitVehicle", getRootElement(), hideTankblips)
addEventHandler("onPlayerWasted", getRootElement(), hideTankblips)

addEventHandler("onPlayerEnterVehicle", getRootElement(),
	function(veh)
		local towedVehicle = getVehicleTowedByVehicle(veh)
		if not towedVehicle then return end
		for i,v in ipairs(adacTrailer) do
			if towedVehicle == v then
				setBlipsAdac(source,true)
				break
			end
		end		
		for k, v in pairs(tankTrailer) do
			if towedVehicle == v then
				setElementVisibleTo(tankstellenBlip, source, true)
			end
		end
	end
)
addEventHandler("onResourceStop", getResourceRootElement(),
	function()
		if isThereFailMySQL == true then return end
		local xmlRoot = xmlCreateOrLoad("xml/wirtschaft/tankstellen.xml", "tankstellen")
		local xmlChildren = xmlNodeGetChildren(xmlRoot)
		for k, v in pairs(xmlChildren) do 
			local id = xmlNodeGetAttribute(v, "id")
			id = tonumber(id)
			xmlNodeSetAttribute(v, "fuel", tostring(getElementData(tankstellen[id], "fuel")))
		end
		xmlSaveFile(xmlRoot)
		xmlUnloadFile(xmlRoot)
	end
)

function hitAdacTrucker( hitElement, matchingDimension ) -- define MarkerHit function for the handler
	if getElementType(hitElement) ~= "vehicle" then return end
	
	local isTrailer = false
	for k,v in pairs(adacTrailer) do
		if v == hitElement then isTrailer = k end
	end

	if not isTrailer then
		local ttrail = getVehicleTowedByVehicle ( hitElement )
		if ttrail then
			for k,v in pairs(adacTrailer) do
				if ttrail == v then isTrailer = k hitElement = v end
			end
		end
	end
	if isTrailer == false then return end
	
	for i,v in ipairs(adac_repair) do
		if v == source and matchingDimension then
			local roadtrain = getVehicleTowingVehicle ( hitElement )
			if not roadtrain then return end
			local player = getVehicleOccupant(roadtrain)
			if not player then return end
			if getElementData(player, "job") ~= 2 or getElementData(player, "dienst") ~= 1 then return end
			if getElementData(source, "repairs") > 3 then return end
			
			setElementData(source, "repairs", 10)
			systemWithdraw("Autofix", 1300, "InterTrans Lieferung")
			systemDeposit("Trucker", 800, "AutoFix Lieferung")
			setElementData(player, "einnahmen", getElementData(player, "einnahmen")+800)
			setElementData(player, "einnahmen2", getElementData(player, "einnahmen2")+800)	
			outputChatBox("InterTrans hat 800 Vero für die Befüllung bekommen.", player,0,255,0)
			setBlipsAdac(player, false)
			if getElementData(hitElement, "left") == 1 then
				setBlipsAdac(player, false)
				detachTrailerFromVehicle(hitElement)
				local spos = getElementData(hitElement, "spos")
				local sid = getElementData(hitElement, "sid")
				destroyElement(hitElement)
				adacTrailer[sid] = createRPGVehicle(591, spos[1], spos[2], spos[3], spos[4], "Niemand",{{234,198,0},{234,198,0},{0,0,0},{0,0,0}}, true, false)
				setElementData(adacTrailer[sid], "spos", spos)
				setElementData(adacTrailer[sid], "sid", sid)
				setElementData(adacTrailer[sid], "left", 2)
				setVehicleDamageProof ( adacTrailer[sid], true )
			else
				setBlipsAdac(player, true)
				setElementData(hitElement, "left", getElementData(hitElement, "left")-1)
			end
			
		end
	end
end
addEventHandler( "onMarkerHit", getRootElement(), hitAdacTrucker )
addEvent ( "adacTruck", true )
addEventHandler ( "adacTruck", getRootElement(), hitAdacTrucker)

function tankColshapeHit(hitEle, md)
	if not md then return end
	if getElementType(hitEle) ~= "vehicle" then return end
	local isTankTrailer = false
	for k, v in pairs(tankTrailer) do
		if v == hitEle then isTankTrailer = k end
	end
	if isTankTrailer == false then return end
	
	local roadtrain = getVehicleTowingVehicle ( hitEle )
	--local roadtrain = getElementData(hitEle, "oldtruck") -- Workaround für #6251 http:--bugs.mtasa.com/view.php?id=6251
	if not roadtrain then return end
	local player = getVehicleOccupant(roadtrain)
	if not player then return end
	if getElementData(player, "job") ~= 2 or getElementData(player, "dienst") ~= 1 then return end
	
	local tankstelle = getElementData(source, "tankstelle")
	local oldfuel = getElementData(tankstelle, "fuel")
	if oldfuel == 1000 then return end
	setElementData(tankstelle, "fuel", 1500)
	local refuel = 1000-oldfuel
	systemDeposit("Trucker", math.ceil(refuel*0.65), "Tankstelle")	
	
	setElementData(player, "einnahmen", getElementData(player, "einnahmen")+math.ceil(refuel*0.65))
	setElementData(player, "einnahmen2", getElementData(player, "einnahmen2")+math.ceil(refuel*0.65))
	
	outputChatBox("InterTrans hat "..tostring(math.ceil(refuel*0.65)).." Vero für "..tostring(refuel).." Liter Benzin bekommen.", player,0,255,0)
	refreshTankstellenBlips()
	
	detachTrailerFromVehicle(hitEle)
	local spos = getElementData(hitEle, "spos")
	local sid = getElementData(hitEle, "sid")
	destroyElement(hitEle)
	tankTrailer[sid] = createRPGVehicle(584, spos[1], spos[2], spos[3], spos[4], "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false)
	setElementData(tankTrailer[sid], "spos", spos)
	setElementData(tankTrailer[sid], "sid", sid)
	setVehicleDamageProof ( tankTrailer[sid], true )
	
	setElementVisibleTo(tankstellenBlip, player, false)
	--respawnVehicle(hitEle)
	--setElementPosition(hitEle, 262.9189453125, 1398+(isTankTrailer*5), 11.656366348267)
	--setElementRotation(hitEle, 0, 0, 270)
end