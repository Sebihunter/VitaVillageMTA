--[[
Project: VitaOnline
File: vehicles-server.lua
Author(s):	Golf_R32
			Sebihunter
]]--

local saveVehicleTimer = 0

local spawnBikes = {}
local wangVehicles = {}

addEvent("doCreateARootVehicle", true)
function createARootRPGVehicle(source,model,color,temp)
	local x, y, z = getElementPosition(source)
	local rz = getPedRotation(source)
	local name = getPlayerName(source)
	local veh = createRPGVehicle(model,x,y,z,rz,name,color,temp,false)
	warpPedIntoVehicle ( source, veh )
	if getElementModel(veh) == 502 then
		setVehicleDamageProof(veh, true)
	end
end
addEventHandler("doCreateARootVehicle", getRootElement(), createARootRPGVehicle)

function createRPGVehicle(model,x,y,z,rz,name,color,temp,eingepackt)
	local veh
	if eingepackt == true then
		local ex, ey, ez = getTrailerPos()
		veh = createVehicle(591, ex, ey, ez,0,0,180.0,name)
	else
		veh = createVehicle(tonumber(model), x,y,z+1.0,0,0,rz,name)
	end
	if veh then
		local thevehicle = veh
		name = tostring(name)
		setElementData ( thevehicle, "motor", false )
		setElementData ( thevehicle, "panne", false )
		setElementData ( thevehicle, "fuel", 100 )
		setElementData ( thevehicle, "oil", 100 )
		setElementData ( thevehicle, "battery", 100 )
		setElementData ( thevehicle, "water", 100 )
		setElementData ( thevehicle, "keys", name )
		setElementData ( thevehicle, "owner",name )
		setElementData ( thevehicle, "vstatus", false )
		setElementData ( thevehicle, "preis", 0 )
		setElementData ( thevehicle, "km", 0 )
		setElementData ( thevehicle, "eingepackt", eingepackt )
		setElementData ( thevehicle, "model", model )	
		setElementData ( thevehicle, "tuev", getRealTime().yearday )	
		setElementData ( thevehicle, "tuevpreis", 150 )
		setElementData ( thevehicle, "reserviert", "Niemand")
		setElementData ( thevehicle, "inventory", {})
		local rt = getRealTime()
		setElementData(veh, "herstelldatum", tostring(rt.monthday).."."..tostring(rt.month+1).."."..tostring(rt.year+1900))
		toggleVehicleRespawn ( thevehicle, false )
		setVehicleColor ( thevehicle ,color[1][1], color[1][2],color[1][3],color[2][1], color[2][2],color[2][3],color[3][1], color[3][2],color[3][3],color[4][1], color[4][2],color[4][3])
		setVehicleOverrideLights( thevehicle, 1 )
		if temp == false then
			setElementData(thevehicle, "isVehicleTemp", false)	
		elseif temp == true then
			setElementData(thevehicle, "isVehicleTemp", true)	
		end
		return thevehicle
	end
end

function loadAllRootRPGVehicles()
	setTimer(benzinVerbrauch, 60000*5, -1)
	
	if mysql_ping ( g_mysql["connection"] ) == false then
		onResourceStopMysqlEnd()
		hasPlayersLoaded = false
		onResourceStartMysqlConnection()
	end	
	local result = mysql_query(g_mysql["connection"], "SELECT * FROM `vehicles` ORDER BY `id` ASC")
	if result then
		local vehs = 0
		while true do
			local row = mysql_fetch_assoc(result)
			if not row then break end
				
			local isFake = row["isFake"]
			local inVerwarung = row["inVerwarung"]
			local model = tonumber(row["model"])
			local x = tonumber(row["x"])
			local y = tonumber(row["y"])
			local z = tonumber(row["z"])
			local rx = tonumber(row["rx"])
			local ry = tonumber(row["ry"])
			local rz = tonumber(row["rz"])
				
			local color = table.load(row["color"])
			local var1 = tonumber(row["var1"])
			local var2 = tonumber(row["var2"])
			local health = tonumber(row["health"])
			local panne = tostring(row["panne"])
			local km = tostring(row["km"])
			local fuel = tonumber(row["fuel"])
			local oil = tonumber(row["oil"])
			local battery = tonumber(row["battery"])
			local water = tonumber(row["water"])
			local locked = tostring(row["locked"])
			local keys = tostring(row["keys"])
			local owner = tostring(row["owner"])
			local vstatus = tostring(row["vstatus"])
			local preis = tonumber(row["preis"])
			local eingepackt = tostring(row["eingepackt"])
			local pj = tonumber(row["paintjob"])
			local marked = tostring(row["marked"])
			local herstelldatum = tostring(row["herstelldatum"])
			local reserviert = tostring(row["reserviert"])
			local tuev = tonumber(row["tuev"])
			local tuevpreis = tonumber(row["tuevpreis"])
			
			if var1 == nil or var1 == false then
				var1 = 0
			end
			if var2 == nil or var2 == false then
				var2 = 0
			end
				
			if isFake == "true" then
				local veh = createElement ( "fakeVehicle" )
				setElementData(veh, "model", model)
				setElementData(veh, "x", x)
				setElementData(veh, "y", y)
				setElementData(veh, "z", z)
				setElementData(veh, "rx", rx)
				setElementData(veh, "ry", ry)
				setElementData(veh, "rz", rz)
				setElementData(veh, "color", color)
				setElementData(veh, "var1", var1)
				setElementData(veh, "var2", var2)
				setElementData(veh, "health", health)
				setElementData(veh, "panne", panne)
				setElementData(veh, "km", km)
				setElementData(veh, "paintjob", pj)
				setElementData(veh, "fuel", fuel)
				setElementData(veh, "oil", oil)
				setElementData(veh, "battery", battery)
				setElementData(veh, "water", water)
				setElementData(veh, "locked", locked)
				setElementData(veh, "keys", tostring(keys))
				setElementData(veh, "owner", tostring(owner))
				setElementData(veh, "eingepackt", eingepackt)
				setElementData(veh, "vstatus", vstatus)
				setElementData(veh, "preis", preis)
				setElementData(veh, "paintjob", paintjob)	
				setElementData(veh, "mysqlID", tonumber(row["id"]))
				setElementData(veh, "upgrade", table.load(row["upgrade"]))
				setElementData(veh, "damage", table.load(row["damage"]))
				setElementData(veh, "doors", table.load(row["doors"]))
				setElementData(veh, "wheels", table.load(row["wheels"]))
				setElementData(veh, "lights", table.load(row["lights"]))
				setElementData(veh, "herstelldatum", herstelldatum)
				setElementData(veh, "reserviert", reserviert)
				setElementData(veh, "tuev", tuev)
				setElementData(veh, "tuevpreis", tuevpreis)
				setElementData(veh, "inventory", table.load(row["inventory"]))
				setElementData(veh, "vzeit", tonumber(row["vzeit"]))
				if inVerwarung == "true" then
					setElementData(veh, "inVerwarung", true)	
				else
					setElementData(veh, "inVerwarung", false)	
				end
			else
				local thevehicle
				if eingepackt == "true" then
					local ex, ey, ez = getTrailerPos()
					thevehicle = createVehicle(591, ex, ey, ez, 0, 0, 180,owner)
				else
					thevehicle = createVehicle(model, x,y,z,rx,ry,rz,owner)
				end
				local myDamage = table.load(row["damage"])
				for i,v in ipairs(myDamage) do
					setVehiclePanelState (thevehicle, i-1, tonumber(v))
				end
				setVehicleColor ( thevehicle ,color[1][1], color[1][2],color[1][3],color[2][1], color[2][2],color[2][3],color[3][1], color[3][2],color[3][3],color[4][1], color[4][2],color[4][3])
				if getVehicleType(thevehicle) ~= "Helicopter" and getVehicleType(thevehicle) ~= "Plane" and getVehicleType(thevehicle) ~= "Boat" then
					setElementHealth( thevehicle, health)
				end
				setVehicleEngineState ( thevehicle, false)
				setVehicleVariant( thevehicle, var1, var2)
				setElementData(thevehicle, "mysqlID", tonumber(row["id"]))
				
				local myUpgrade = table.load(row["upgrade"])
				for i,v in ipairs(myUpgrade) do
					addVehicleUpgrade (thevehicle, tonumber(v) )
				end
				setElementData(thevehicle, "isVehicleTemp", false)
				if locked == "true" and eingepackt ~= "true" or marked == "true" then
					setVehicleLocked ( thevehicle, true )
					setVehicleDamageProof(thevehicle, true)
					setElementFrozen( thevehicle, true)
				else
					setVehicleLocked ( thevehicle, false )
				end
				local myDoors = table.load(row["doors"])
				for i,v in ipairs(myDoors) do 
					setVehicleDoorState ( thevehicle, i-1, tonumber(v))
				end
				local myWheels = table.load(row["wheels"])
				for i,v in ipairs(myWheels) do 
					setVehicleDoorState ( thevehicle, i-1, tonumber(v))
				end				
				setVehicleWheelStates ( thevehicle, tonumber(myWheels[1]),tonumber(myWheels[2]),tonumber(myWheels[3]),tonumber(myWheels[4]))
				setVehiclePaintjob ( thevehicle, pj )
				toggleVehicleRespawn ( thevehicle, false )
				local myLights = table.load(row["lights"])
				for i,v in ipairs(myLights) do 
					setVehicleLightState (thevehicle, i-1, tonumber(v))
				end
				if keys == "Autohaus" or keys == "Autohus" or keys == "car4you" and eingepackt ~= "true"  then
					setElementFrozen(thevehicle, true)
					setVehicleDamageProof(thevehicle, true)
				end				
				if panne == "true" then
					setElementData ( thevehicle, "panne",true )
				else
					setElementData ( thevehicle, "panne",false )
				end
				
				if vstatus == "true" then
					setElementData ( thevehicle, "vstatus",true )
				else
					setElementData ( thevehicle, "vstatus",false )
				end

				if eingepackt == "true" then
					setElementData ( thevehicle, "eingepackt",true )
				else
					setElementData ( thevehicle, "eingepackt",false )
				end		
				if marked == "true" then
					setElementData ( thevehicle, "marked",true )					
				else
					setElementData ( thevehicle, "marked",false )					
				end
				if not km then
					setElementData ( thevehicle, "km", 0 )
				else
					setElementData ( thevehicle, "km", km )
				end
				setElementData ( thevehicle, "fuel", fuel )
				setElementData ( thevehicle, "oil", oil )
				setElementData ( thevehicle, "battery", battery )
				setElementData ( thevehicle, "water", water )
				setElementData ( thevehicle, "keys", tostring(keys) )
				setElementData ( thevehicle, "owner",tostring(owner) )
				setElementData ( thevehicle, "preis", preis )
				setElementData ( thevehicle, "motor", false )
				setElementData ( thevehicle, "model", model )
				setElementData ( thevehicle, "tuev", tuev )
				setElementData ( thevehicle, "tuevpreis", tuevpreis )
				setElementData(thevehicle, "herstelldatum", herstelldatum)
				setElementData(thevehicle, "reserviert", reserviert)	
				setElementData(thevehicle, "inventory", table.load(row["inventory"]))
				setElementData(thevehicle, "vzeit", tonumber(row["vzeit"]))
				setVehicleOverrideLights( thevehicle, 1 )
				if inVerwarung == "true" then
					setElementData(thevehicle, "inVerwarung", true)	
				else
					setElementData(thevehicle, "inVerwarung", false)	
				end					
			end
			vehs = vehs+1
		end
		mysql_free_result(result)
		print("__~~*"..tonumber(vehs).."*Vehicle/s*Loaded!*~~__")
	else
		print("VitaOnline: Failed to load vehicles")
	end	
	
	saveVehicleTimer = setTimer(saveAllRootRPGVehicles, 1800000, 0, true)
	spawnRPGPublicVehicles()
	spawnWangVehicles()
	--[[for k, v in pairs(getElementsByType("vehicle")) do
		if getElementData ( v, "keys" ) ~= "Niemand" and getElementData ( v, "keys" ) ~= "Autohaus" and getElementData ( v, "keys" ) ~= "Autohus" and getElementData ( v, "keys" ) ~= "MVB" and isVehicleLocked ( v ) == true then
			setElementData(v, "isProtected", true)
			setVehicleDamageProof(v, true)
			setElementFrozen(v, true)
		end
	end]]
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), loadAllRootRPGVehicles)

local vehSaveTable = {}
local theSaveTimer
function saveAllRootRPGVehicles(timer)
	if timer ~= true then timer = false else timer = true end
	if #vehSaveTable > 0 and timer == true then outputServerLog ( "DEBUG: Could not save vehicles" ) return end
	if theSaveTimer and isTimer(theSaveTimer) then killTimer(theSaveTimer) end
	vehSaveTable = {}
	for vi, vehicle in ipairs(getElementsByType("vehicle")) do
		if getElementData(vehicle, "isVehicleTemp") == false then
			vehSaveTable[#vehSaveTable+1] = {}
			vehSaveTable[#vehSaveTable].veh = vehicle
			vehSaveTable[#vehSaveTable].isFake = false
			vehSaveTable[#vehSaveTable].mid = getElementData(vehicle, "mysqlID")
			local x, y, z = getElementPosition(vehicle)
			vehSaveTable[#vehSaveTable].x = math.round( x, 5, "round" )
			vehSaveTable[#vehSaveTable].y = math.round( y, 5, "round" )
			vehSaveTable[#vehSaveTable].z = math.round( z, 5, "round" )
			local rx, ry, rz = getVehicleRotation(vehicle)
			vehSaveTable[#vehSaveTable].rx = math.round( rx, 5, "round" )
			vehSaveTable[#vehSaveTable].ry = math.round( ry, 5, "round" )
			vehSaveTable[#vehSaveTable].rz = math.round( rz, 5, "round" )
			
			local r1,g1,b1,r2,g2,b2,r3,g3,b3,r4,g4,b4 = getVehicleColor ( vehicle,true )
			vehSaveTable[#vehSaveTable].colortable = table.save({{r1,g1,b1}, {r2,g2,b2}, {r3,g3,b3},{r4,g4,b4}})
			
			vehSaveTable[#vehSaveTable].var1, vehSaveTable[#vehSaveTable].var2 = getVehicleVariant( vehicle )
			
			
			local myUpgrade = {}
			for i=1, 17 do
				local upgrade = getVehicleUpgradeOnSlot ( vehicle, i-1 )
				if ( upgrade ) then
					myUpgrade[i] = upgrade
				else
					myUpgrade[i] = false
				end
			end		
			vehSaveTable[#vehSaveTable].myUpgrade = table.save(myUpgrade)
			
			local myDamage = {}
			for i = 1,7 do
				myDamage[i] = getVehiclePanelState ( vehicle, i-1 )
			end
			vehSaveTable[#vehSaveTable].myDamage = table.save(myDamage)
			
			local myDoors = {}
			for i = 1,6 do
				myDoors[i] = getVehicleDoorState ( vehicle, i-1 )
			end
			vehSaveTable[#vehSaveTable].myDoors = table.save(myDoors)
			
			local myWheels = {}
			local w1,w2,w3,w4 = getVehicleWheelStates ( vehicle )
			myWheels[1] = w1
			myWheels[2] = w2
			myWheels[3] = w3
			myWheels[4] = w4
			vehSaveTable[#vehSaveTable].myWheels = table.save(myWheels)

			local myLights = {}
			for i = 1,4 do
				myLights[i] = getVehicleLightState ( vehicle, i-1 )
			end
			vehSaveTable[#vehSaveTable].myLights = table.save(myLights)
			vehSaveTable[#vehSaveTable].verwarung = getElementData(vehicle, "inVerwarung")
			vehSaveTable[#vehSaveTable].model = getElementData(vehicle, "model")
			vehSaveTable[#vehSaveTable].panne = getElementData(vehicle, "panne")
			vehSaveTable[#vehSaveTable].km = getElementData(vehicle, "km")
			vehSaveTable[#vehSaveTable].fuel = getElementData(vehicle, "fuel")
			vehSaveTable[#vehSaveTable].oil = getElementData(vehicle, "oil")
			vehSaveTable[#vehSaveTable].battery = getElementData(vehicle, "battery")
			vehSaveTable[#vehSaveTable].water = getElementData(vehicle, "water")
			vehSaveTable[#vehSaveTable].locked = isVehicleLocked(vehicle)
			vehSaveTable[#vehSaveTable].keys = getElementData(vehicle, "keys")
			vehSaveTable[#vehSaveTable].owner = getElementData(vehicle, "owner")
			vehSaveTable[#vehSaveTable].eingepackt = getElementData(vehicle, "eingepackt")
			vehSaveTable[#vehSaveTable].vstatus = getElementData(vehicle, "vstatus")
			vehSaveTable[#vehSaveTable].preis = getElementData(vehicle, "preis")
			vehSaveTable[#vehSaveTable].paintjob = getVehiclePaintjob(vehicle)
			vehSaveTable[#vehSaveTable].marked = getElementData(vehicle, "marked")
			vehSaveTable[#vehSaveTable].reserviert = getElementData(vehicle, "reserviert")
			vehSaveTable[#vehSaveTable].herstelldatum = getElementData(vehicle, "herstelldatum")
			vehSaveTable[#vehSaveTable].engine = getVehicleEngineState (vehicle)
			vehSaveTable[#vehSaveTable].health = getElementHealth(vehicle)
			vehSaveTable[#vehSaveTable].tuev = getElementData(vehicle, "tuev")
			vehSaveTable[#vehSaveTable].tuevpreis = getElementData(vehicle, "tuevpreis")
			if getElementData(vehicle, "vzeit") then
				vehSaveTable[#vehSaveTable].vzeit = getElementData(vehicle, "vzeit")
			else
				vehSaveTable[#vehSaveTable].vzeit = getRealTime().timestamp
			end
			if getElementData(vehicle, "inventory") and type(getElementData(vehicle, "inventory")) == "table" then
				vehSaveTable[#vehSaveTable].inventory = table.save(getElementData(vehicle, "inventory"))
			else
				vehSaveTable[#vehSaveTable].inventory = table.save({})
			end
		end
	end

	for _, vehicle in ipairs(getElementsByType("fakeVehicle")) do
		vehSaveTable[#vehSaveTable+1] = {}
		vehSaveTable[#vehSaveTable].veh = vehicle
		vehSaveTable[#vehSaveTable].isFake = true
		vehSaveTable[#vehSaveTable].mid = getElementData(vehicle, "mysqlID")
		vehSaveTable[#vehSaveTable].x = getElementData(vehicle, "x")
		vehSaveTable[#vehSaveTable].y = getElementData(vehicle, "y")
		vehSaveTable[#vehSaveTable].z = getElementData(vehicle, "z")
		vehSaveTable[#vehSaveTable].rx = getElementData(vehicle, "rx")
		vehSaveTable[#vehSaveTable].ry = getElementData(vehicle, "ry")
		vehSaveTable[#vehSaveTable].rz = getElementData(vehicle, "rz")
		vehSaveTable[#vehSaveTable].colortable = table.save(getElementData(vehicle, "color"))
		vehSaveTable[#vehSaveTable].var1 = getElementData(vehicle, "var1")
		vehSaveTable[#vehSaveTable].var2 = getElementData(vehicle, "var2")
		vehSaveTable[#vehSaveTable].myUpgrade = table.save(getElementData(vehicle, "upgrade"))
		vehSaveTable[#vehSaveTable].myDamage = table.save(getElementData(vehicle, "damage"))
		vehSaveTable[#vehSaveTable].myDoors = table.save(getElementData(vehicle, "doors"))
		vehSaveTable[#vehSaveTable].myWheels = table.save(getElementData(vehicle, "wheels"))
		vehSaveTable[#vehSaveTable].myLights = table.save(getElementData(vehicle, "lights"))
		vehSaveTable[#vehSaveTable].verwarung = getElementData(vehicle, "inVerwarung")
		vehSaveTable[#vehSaveTable].model = getElementData(vehicle, "model")
		vehSaveTable[#vehSaveTable].panne = getElementData(vehicle, "panne")
		vehSaveTable[#vehSaveTable].km = getElementData(vehicle, "km")
		vehSaveTable[#vehSaveTable].fuel = getElementData(vehicle, "fuel")
		vehSaveTable[#vehSaveTable].oil = getElementData(vehicle, "oil")
		vehSaveTable[#vehSaveTable].battery = getElementData(vehicle, "battery")
		vehSaveTable[#vehSaveTable].water = getElementData(vehicle, "water")
		vehSaveTable[#vehSaveTable].locked = getElementData(vehicle, "locked")
		vehSaveTable[#vehSaveTable].keys = getElementData(vehicle, "keys")
		vehSaveTable[#vehSaveTable].owner = getElementData(vehicle, "owner")
		vehSaveTable[#vehSaveTable].eingepackt = getElementData(vehicle, "eingepackt")
		vehSaveTable[#vehSaveTable].vstatus = getElementData(vehicle, "vstatus")
		vehSaveTable[#vehSaveTable].preis = getElementData(vehicle, "preis")
		vehSaveTable[#vehSaveTable].paintjob = getElementData(vehicle, "paintjob")
		vehSaveTable[#vehSaveTable].reserviert = getElementData(vehicle, "reserviert")
		vehSaveTable[#vehSaveTable].herstelldatum = getElementData(vehicle, "herstelldatum")
		vehSaveTable[#vehSaveTable].engine = false
		vehSaveTable[#vehSaveTable].marked = false
		vehSaveTable[#vehSaveTable].health = getElementData(vehicle, "health")		
		vehSaveTable[#vehSaveTable].tuev = getElementData(vehicle, "tuev")	
		vehSaveTable[#vehSaveTable].tuevpreis = getElementData(vehicle, "tuevpreis")
		vehSaveTable[#vehSaveTable].vzeit = getElementData(vehicle, "vzeit")
		if getElementData(vehicle, "inventory") and type(getElementData(vehicle, "inventory")) == "table" then
			vehSaveTable[#vehSaveTable].inventory = table.save(getElementData(vehicle, "inventory"))
		else
			vehSaveTable[#vehSaveTable].inventory = table.save({})
		end
	end
	if timer == true then
		outputServerLog ( "DEBUG: Saving vehicles TIMER" )
		saveVehTimer(timer)
	else
		outputServerLog ( "DEBUG: Saving vehicles INSTANT" )
		for i = 1, #vehSaveTable do
			saveVehTimer(timer)
		end
	end
end		
addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), saveAllRootRPGVehicles)

function saveVehTimer(timer)
	local i = 1
	if vehSaveTable[i] then
		if mysql_ping ( g_mysql["connection"] ) == false then
			onResourceStopMysqlEnd()
			onResourceStartMysqlConnection()
		end
		
		if not vehSaveTable[i].mid then
			mysql_query(g_mysql["connection"], "INSERT INTO `vehicles` (`isFake`) VALUES ('false');")
	
			local temp = mysql_query(g_mysql["connection"], "SELECT LAST_INSERT_ID(id) AS last FROM vehicles ORDER BY id DESC LIMIT 1;")
			vehSaveTable[i].mid = mysql_insert_id(g_mysql["connection"])
			setElementData(vehSaveTable[i].veh, "mysqlID", vehSaveTable[i].mid)
			mysql_free_result(temp)
		end	
			local sql = "UPDATE `vehicles` SET `isFake` = '"..tostring(vehSaveTable[i].isFake).."',\
														`inVerwarung` = '"..tostring(vehSaveTable[i].verwarung).."',\
														`model` = '"..tostring(vehSaveTable[i].model).."',\
														`x` = '"..tostring(vehSaveTable[i].x).."',\
														`y` = '"..tostring(vehSaveTable[i].y).."',\
														`z` = '"..tostring(vehSaveTable[i].z).."',\
														`rx` = '"..tostring(vehSaveTable[i].rx).."',\
														`ry` = '"..tostring(vehSaveTable[i].ry).."',\
														`rz` = '"..tostring(vehSaveTable[i].rz).."',\
														`color` = '"..tostring(vehSaveTable[i].colortable).."',\
														`var1` = '"..tostring(vehSaveTable[i].var1).."',\
														`var2` = '"..tostring(vehSaveTable[i].var2).."',\
														`upgrade` = '"..tostring(vehSaveTable[i].myUpgrade).."',\
														`damage` = '"..tostring(vehSaveTable[i].myDamage).."',\
														`doors` = '"..tostring(vehSaveTable[i].myDoors).."',\
														`wheels` = '"..tostring(vehSaveTable[i].myWheels).."',\
														`lights` = '"..tostring(vehSaveTable[i].myLights).."',\
														`health` = '"..tostring(vehSaveTable[i].health).."',\
														`engine` = '"..tostring(vehSaveTable[i].engine).."',\
														`panne` = '"..tostring(vehSaveTable[i].panne).."',\
														`km` = '"..tostring(vehSaveTable[i].km).."',\
														`fuel` = '"..tostring(vehSaveTable[i].fuel).."',\
														`oil` = '"..tostring(vehSaveTable[i].oil).."',\
														`battery` = '"..tostring(vehSaveTable[i].battery).."',\
														`water` = '"..tostring(vehSaveTable[i].water).."',\
														`locked` = '"..tostring(vehSaveTable[i].locked).."',\
														`keys` = '"..tostring(vehSaveTable[i].keys).."',\
														`owner` = '"..tostring(vehSaveTable[i].owner).."',\
														`eingepackt` = '"..tostring(vehSaveTable[i].eingepackt).."',\
														`vstatus` = '"..tostring(vehSaveTable[i].vstatus).."',\
														`preis` = '"..tostring(vehSaveTable[i].preis).."',\
														`paintjob` = '"..tostring(vehSaveTable[i].paintjob).."',\
														`marked` = '"..tostring(vehSaveTable[i].marked).."',\
														`herstelldatum` = '"..tostring(vehSaveTable[i].herstelldatum).."',\
														`reserviert` = '"..tostring(vehSaveTable[i].reserviert).."',\
														`tuev` = '"..tostring(vehSaveTable[i].tuev).."',\
														`tuevpreis` = '"..tostring(vehSaveTable[i].tuevpreis).."',\
														`inventory` = '"..tostring(vehSaveTable[i].inventory).."',\
														`vzeit` = '"..tostring(vehSaveTable[i].vzeit).."'\
												WHERE `id` = '"..vehSaveTable[i].mid.."' LIMIT 1 ;"
													
												
		local query = mysql_query(g_mysql["connection"], sql)
		if query then mysql_free_result(query) end			
			
		table.remove(vehSaveTable,1)
		if vehSaveTable[i] and timer == true then theSaveTimer = setTimer(saveVehTimer, 50,1, true) end
	end
end

addEvent("doDestroyTheRPGVehicle", true)
addEventHandler("doDestroyTheRPGVehicle", getRootElement(),
	function(player, id, drivername)
		for i,veh in ipairs(getElementsByType("vehicle")) do
			if tonumber(id) == i then
				local driver = getPlayerFromName(drivername)
				if veh then
					destroyElement(veh)
					if driver then
						if driver == player then
							outputChatBox("Du hast dein Fahrzeug geloescht!", player, 255,255,0)
						else
							outputChatBox(getPlayerName(player).." hat dein Fahrzeug geloescht!", driver, 255,255,0)
							outputChatBox("Du hast "..getPlayerName(driver).."s Fahrzeug geloescht!", player, 255,255,0)
						end
					else
						outputChatBox("Fahrzeug wurde erfolgreich geloescht!", player, 255,255,0)
					end
				end
				break
			end
		end
	end
)

addEvent("doRepairTheRPGVehicle", true)
addEventHandler("doRepairTheRPGVehicle", getRootElement(),
	function(player, id, drivername)
		for i,veh in ipairs(getElementsByType("vehicle")) do
			if tonumber(id) == i then
				local driver = getPlayerFromName(drivername)
				if veh then
					setElementHealth(veh, 1000)
					fixVehicle(veh)
					setElementData(veh, "panne", false)
					local rx,ry,rz = getElementRotation(veh)
					setElementRotation(veh,rx,0,rz)
					if driver then
						if driver == source then
							outputChatBox("Du hast dein Fahrzeug repariert!", player, 255,255,0)
						else
							outputChatBox(getPlayerName(source).." hat dein Fahrzeug repariert!", driver, 255,255,0)
							outputChatBox("Du hast "..getPlayerName(driver).."s Fahrzeug repariert!", player, 255,255,0)
						end
					else
						outputChatBox("Fahrzeug wurde erfolgreich repariert!", player, 255,255,0)
					end
				end
				break
			end
		end
	end
)

function enterVehicle ( vehicle, seat, jacked )
	local model = getElementModel(vehicle)
	refreshTreePositions(source)
	
	local keys = getElementData(vehicle, "keys")
	if (keys == "car4you" and getElementData(vehicle, "onFire") ~= true and getElementData(source,"job") == 11 and seat == 0) or (keys == "Autohaus" and getElementData(vehicle, "onFire") ~= true and getElementData(source,"job") == 1 and seat == 0) or (keys == "Autohus" and getElementData(vehicle, "onFire") ~= true and (getElementData(source,"job") == 5 or getElementData(source,"job") == 11) and seat == 0)  then
		setElementFrozen(vehicle, false)
	elseif getElementData(vehicle, "onFire") ~= true and isVehicleLocked(vehicle) ~= true and getElementData(vehicle, "blockUnfreeze") ~= true and getElementData(vehicle, "marked") ~= true and keys ~= "Autohaus" and keys ~= "Autohus" and keys ~= "car4you" then
		setElementFrozen(vehicle, false)
	end
	if ( model == 597 or model == 598 or model == 599 or model == 528 or model == 523 or model == 427 or model == 497 or model == 427 or model == 490 or model == 426 or model == 601 or model == 523) and seat == 0 then
		bindKey(source, "num_mul", "down", function () triggerClientEvent("toggleSiren", root, vehicle, 1) end)
		bindKey(source, "num_div", "down", function () triggerClientEvent("toggleSiren", root, vehicle, 2) end)
		bindKey(source, "num_dec", "down", function () triggerClientEvent("doMegaphone", root, vehicle, 1) end)
		bindKey(source, "num_sub", "down", function () triggerClientEvent("doMegaphone", root, vehicle, 2) end)
		bindKey(source, "num_add", "down", function () triggerClientEvent("doMegaphone", root, vehicle, 3) end)
		addCommandHandler ( "siren_1", function () triggerClientEvent("toggleSiren", root, vehicle, 1) end )
		addCommandHandler ( "siren_2", function () triggerClientEvent("toggleSiren", root, vehicle, 2) end )
		addCommandHandler ( "megaphone_1", function () triggerClientEvent("doMegaphone", root, vehicle, 1) end )
		addCommandHandler ( "megaphone_2", function () triggerClientEvent("doMegaphone", root, vehicle, 2) end )
		addCommandHandler ( "megaphone_3", function () triggerClientEvent("doMegaphone", root, vehicle, 3) end )
	end
end
addEventHandler ( "onPlayerVehicleEnter", getRootElement(), enterVehicle ) 

--And Firetruck and AutoFix
function enterVehicleSani ( vehicle, seat, jacked )
	local model = getElementModel(vehicle)
	refreshTreePositions(source)
	if ( model == 596 or model == 416) and seat == 0 then
		bindKey(source, "num_mul", "down", function () triggerClientEvent("toggleSiren", root, vehicle, 3) end)
		bindKey(source, "num_div", "down", function () triggerClientEvent("toggleSiren", root, vehicle, 4) end)
		addCommandHandler ( "sani_1", function () triggerClientEvent("toggleSiren", root, vehicle, 3) end )
		addCommandHandler ( "sani_2", function () triggerClientEvent("toggleSiren", root, vehicle, 4) end )
	elseif model == 407	and seat == 0 then
		bindKey(source, "num_mul", "down", function () triggerClientEvent("toggleSiren", root, vehicle, 5) end)
		bindKey(source, "num_div", "down", function () triggerClientEvent("toggleSiren", root, vehicle, 6) end)
		addCommandHandler ( "feuer_1", function () triggerClientEvent("toggleSiren", root, vehicle, 5) end )
		addCommandHandler ( "feuer_2", function () triggerClientEvent("toggleSiren", root, vehicle, 6) end )	
	elseif model == 525 and seat == 0 then
		bindKey(source, "num_mul", "down", function () triggerClientEvent("toggleSiren", root, vehicle, 7) end)
		bindKey(source, "num_div", "down", function () triggerClientEvent("toggleSiren", root, vehicle, 7) end)
		addCommandHandler ( "afix", function () triggerClientEvent("toggleSiren", root, vehicle, 7) end )
	end
end
addEventHandler ( "onPlayerVehicleEnter", getRootElement(), enterVehicleSani ) 

function exitVehicle ( vehicle, seat, jacked )
	-- special sounds for police cars
	local model = getElementModel(vehicle)
	if ( model == 597 or model == 598 or model == 599 or model == 528 or model == 523 or model == 427 or model == 497 or model ==407) and seat == 0 then
		unbindKey(source, "num_mul")
		unbindKey(source, "num_div")
		unbindKey(source, "num_dec")
		unbindKey(source, "num_sub")
		unbindKey(source, "num_add")
		removeCommandHandler ( "siren_1" )
		removeCommandHandler ( "siren_2" )
		removeCommandHandler ( "megaphone_1" )
		removeCommandHandler ( "megaphone_2" )
		removeCommandHandler ( "megaphone_3" )
	end
	keys = getElementData(vehicle, "keys")
	if (keys == "Autohaus" or keys == "Autohus" or keys == "car4you") and seat == 0 then
		setElementFrozen(vehicle, true)
	end
	if getVehicleOccupants ( vehicle ) and #getVehicleOccupants ( vehicle ) == 0 then
		setElementData(vehicle, "reverse", false)
	end
end
addEventHandler ( "onPlayerVehicleExit", getRootElement(), exitVehicle ) 

function exitVehicleSani ( vehicle, seat, jacked )
	-- special sounds for police cars
	local model = getElementModel(vehicle)
	if ( model == 596 or model == 416 or model == 525) and seat == 0 then
		unbindKey(source, "num_mul")
		unbindKey(source, "num_div")
		removeCommandHandler ( "sani_1" )
		removeCommandHandler ( "sani_2" )
		removeCommandHandler ( "feuer_1" )
		removeCommandHandler ( "feuer_2" )		
		removeCommandHandler ( "afix" )
	end
end
addEventHandler ( "onPlayerVehicleExit", getRootElement(), exitVehicleSani ) 

function spawnWangVehicles()
	wangVehicles[1] = createRPGVehicle(549,-1954.9130859375, 298.88671875, 39.637690734863, 99.386596679688, "AutoHaus",{{245,245,245},{134,68,110},{0,0,0},{0,0,0}}, true, false)
	setElementData(wangVehicles[1], "preis", 2700)
	wangVehicles[2] = createRPGVehicle(542,-1949.1787109375, 259.1416015625, 39.640036773682, 99.386596679688, "AutoHaus",{{215,142,16},{42,119,161},{0,0,0},{0,0,0}}, true, false)
	setElementData(wangVehicles[2], "preis", 2700)
	wangVehicles[3] = createRPGVehicle(542,-1946.509765625, 271.29296875, 34.265600585938, 99.386596679688, "AutoHaus",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false)
	setElementData(wangVehicles[3], "preis", 2700)
	wangVehicles[4] = createRPGVehicle(583,-1947.515625, 257.3837890625, 34.061736297607, 99.386596679688, "AutoHaus",{{76,117,183},{38,55,57},{0,0,0},{0,0,0}}, true, false)
	setElementData(wangVehicles[4], "preis", 3800)
	wangVehicles[5] = createRPGVehicle(462,-1953.9912109375, 304.1669921875, 34.0606300354, 99.386596679688, "AutoHaus",{{132,4,6},{189,190,198},{0,0,0},{0,0,0}}, true, false)
	setElementData(wangVehicles[5], "preis", 1900)
	for i = 1,#wangVehicles do
		setElementData( wangVehicles[i], "doNotLooseFuel", true)
		toggleVehicleRespawn( wangVehicles[i], true )
		setVehicleIdleRespawnDelay ( wangVehicles[i], 60000 )
		setElementFrozen(wangVehicles[i], true)
		setElementData(wangVehicles[i], "isWangVehicle", true)
	end	
end

function spawnRPGPublicVehicles()
	-- Bahnhof
	spawnBikes[1] = createRPGVehicle(510, 2825.3984375, 1307.103515625, 10.765548706055, 90, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false)
	spawnBikes[2] = createRPGVehicle(510, 2825.3212890625, 1304.9013671875, 10.765436172485, 90, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false)
	spawnBikes[3] = createRPGVehicle(510, 2825.3271484375, 1302.3037109375, 10.765444755554, 90, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false)
	spawnBikes[4] = createRPGVehicle(510, 2825.3330078125, 1299.9013671875, 10.765453338623, 90, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false)
	spawnBikes[5] = createRPGVehicle(510, 2825.3388671875, 1297.482421875, 10.765461921692, 90, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false)
	spawnBikes[6] = createRPGVehicle(510, 2825.345703125, 1294.728515625, 10.765471458435, 90, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false)
	spawnBikes[7] = createRPGVehicle(510, 2825.3525390625, 1291.5, 10.765482902527, 90, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false)
	spawnBikes[8] = createRPGVehicle(510, 2825.361328125, 1288.26953125, 10.765494346619, 90, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false)
	spawnBikes[9] = createRPGVehicle(510, 2825.369140625, 1285.248046875, 10.76550579071, 90, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false)
	spawnBikes[10] = createRPGVehicle(510, 2825.3759765625, 1282.314453125, 10.765516281128, 90, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false)
	-- Krankenhaus
	spawnBikes[11] = createRPGVehicle(510, 1614.896484375, 1832.400390625, 10.8203125, 0, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false)
	spawnBikes[12] = createRPGVehicle(510, 1613.0126953125, 1832.4365234375, 10.8203125, 0, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false) 
	spawnBikes[13] = createRPGVehicle(510, 1610.8662109375, 1832.478515625, 10.8203125, 0, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false)
	spawnBikes[14] = createRPGVehicle(510, 1608.7587890625, 1832.5185546875, 10.8203125, 0, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false) 
	spawnBikes[15] = createRPGVehicle(510, 1606.7373046875, 1832.5576171875, 10.8203125, 0, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false) 
	spawnBikes[16] = createRPGVehicle(510, 1604.5703125, 1832.599609375, 10.8203125, 0, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false) 
	spawnBikes[17] = createRPGVehicle(510, 1602.5234375, 1832.638671875, 10.8203125, 0, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false) 
	spawnBikes[18] = createRPGVehicle(510, 1600.126953125, 1832.685546875, 10.8203125, 0, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false) 
	spawnBikes[19] = createRPGVehicle(510, 1597.970703125, 1832.7265625, 10.8203125, 0, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false) 
	spawnBikes[20] = createRPGVehicle(510, 1596.10546875, 1832.7626953125, 10.8203125, 0, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false) 

	-- San Fierro Bahnhof
	spawnBikes[21] = createRPGVehicle(510, -1981.3876953125, 100.9814453125, 26.256044387817, 0, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false) 
	spawnBikes[22] = createRPGVehicle(510, -1982.3876953125, 100.9814453125, 26.256044387817, 0, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false) 
	spawnBikes[23] = createRPGVehicle(510, -1983.3876953125, 100.9814453125, 26.256044387817, 0, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false) 
	spawnBikes[24] = createRPGVehicle(510, -1984.3876953125, 100.9814453125, 26.256044387817, 0, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false) 
	spawnBikes[25] = createRPGVehicle(510, -1985.3876953125, 100.9814453125, 26.256044387817, 0, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false) 

	-- Sense make this, biatch!
	-- Fort Carson
	spawnBikes[26] = createRPGVehicle(510, -49.400001525879, 1278.9000244141, 10, 0, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false) 
	spawnBikes[27] = createRPGVehicle(510, -51.5, 1279.0999755859, 10.199999809265, 0, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false) 
	spawnBikes[28] = createRPGVehicle(510, -53.400001525879, 1279.8000488281, 10.39999961853, 0, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false) 
	spawnBikes[29] = createRPGVehicle(510, -55, 1280.5, 10.60000038147, 0, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false) 
	spawnBikes[30] = createRPGVehicle(510, -56.5, 1281.0999755859, 10.699999809265, 0, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false) 
	spawnBikes[31] = createRPGVehicle(510, -58, 1281.6999511719, 10.89999961853, 0, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false) 
	
	-- LS Market Station
	spawnBikes[32] = createRPGVehicle(510, 821.79998779297, -1355, 13.199999809265, 180, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false) 
	spawnBikes[33] = createRPGVehicle(510, 820.5, -1355.0999755859, 13.199999809265, 180, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false) 
	spawnBikes[34] = createRPGVehicle(510, 819.20001220703, -1355.0999755859, 13.199999809265, 180, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false) 
	spawnBikes[35] = createRPGVehicle(510, 817.59997558594, -1355.0999755859, 13.199999809265, 180, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false) 
	spawnBikes[36] = createRPGVehicle(510, 816.09997558594, -1355.0999755859, 13.199999809265, 180, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false) 
	spawnBikes[37] = createRPGVehicle(510, 814.59997558594, -1355.0999755859, 13.199999809265, 180, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false) 
	
	-- LS Unity Station
	spawnBikes[38] = createRPGVehicle(510, 1764, -1938, 13.300000190735, 0, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false) 
	spawnBikes[39] = createRPGVehicle(510, 1761.3994140625, -1938, 13.300000190735, 0, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false) 
	spawnBikes[40] = createRPGVehicle(510, 1762.7998046875, -1938, 13.300000190735, 0, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false) 
	spawnBikes[41] = createRPGVehicle(510, 1765.3000488281, -1938, 13.300000190735, 0, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false) 
	spawnBikes[42] = createRPGVehicle(510, 1766.6999511719, -1938, 13.300000190735, 0, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false) 
	spawnBikes[43] = createRPGVehicle(510, 1767.9000244141, -1938, 13.300000190735, 0, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false) 
	
	-- LV Yellow Bell Station
	spawnBikes[44] = createRPGVehicle(510, 1490.5999755859, 2680.8000488281, 10.5, 0, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false) 
	spawnBikes[45] = createRPGVehicle(510, 1487.5, 2680.6999511719, 10.5, 0, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false) 
	spawnBikes[46] = createRPGVehicle(510, 1489.1999511719, 2680.6999511719, 10.5, 0, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false) 
	spawnBikes[47] = createRPGVehicle(510, 1485.5999755859, 2680.6999511719, 10.5, 0, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false) 
	spawnBikes[48] = createRPGVehicle(510, 1483.9000244141, 2680.8000488281, 10.5, 0, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false) 
	spawnBikes[49] = createRPGVehicle(510, 1482.0999755859, 2680.8000488281, 10.5, 0, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false) 
	
	-- Stadthalle
	spawnBikes[50] = createRPGVehicle(510, 2435.630859375,2391.3530273438,10.335276603699,90, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false) 
	spawnBikes[51] = createRPGVehicle(510, 2435.630859375,2392.3530273438,10.335276603699,90, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false) 
	spawnBikes[52] = createRPGVehicle(510, 2435.630859375,2393.3530273438,10.335276603699,90, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false) 
	spawnBikes[53] = createRPGVehicle(510, 2435.630859375,2394.3530273438,10.335276603699,90, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false)
	
	-- LVPD
	spawnBikes[54] = createRPGVehicle(510, 2274.7814941406,2421.927734375,10.428644180298,180, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false)
	spawnBikes[55] = createRPGVehicle(510, 2273.7814941406,2421.927734375,10.428644180298,180, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false)
	spawnBikes[56] = createRPGVehicle(510, 2272.7814941406,2421.927734375,10.428644180298,180, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false)
	spawnBikes[57] = createRPGVehicle(510, 2271.7814941406,2421.927734375,10.428644180298,180, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false)


	-- AutoHus
	spawnBikes[58] = createRPGVehicle(510, 2085.5,1384.2,10.75,90, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false)
	spawnBikes[59] = createRPGVehicle(510, 2085.5,1385.2,10.75,90, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false)
	spawnBikes[60] = createRPGVehicle(510, 2085.5,1386.2,10.75,90, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false)
	spawnBikes[61] = createRPGVehicle(510, 2085.5,1387.2,10.75,90, "Niemand",{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}, true, false)	

	
	for i = 1,#spawnBikes do
		setElementData( spawnBikes[i], "doNotLooseFuel", true)
		toggleVehicleRespawn( spawnBikes[i], true )
		setVehicleIdleRespawnDelay ( spawnBikes[i], 180000 )
		setVehicleHandling ( spawnBikes[i], "maxVelocity", 50.0 )
	end
	
	
	--[[local baustelle = {}
	baustelle[#baustelle+1] =  createRPGVehicle(524, 2075.3,1476.9,10.7,0, "viostinkt",{{156,156,152},{81,84,89},{0,0,0},{0,0,0}}, true, false) 
	baustelle[#baustelle+1] =  createRPGVehicle(486, 2070,1464,9.8,143.992, "viostinkt",{{156,156,152},{81,84,89},{0,0,0},{0,0,0}}, true, false) 
	baustelle[#baustelle+1] =  createRPGVehicle(406, 2071.2002,1452.4004,10.8,0, "viostinkt",{{156,156,152},{81,84,89},{0,0,0},{0,0,0}}, true, false) 
	for i = 1,#baustelle do
		setElementFrozen(baustelle[i], true)
		setVehicleDamageProof (baustelle[i], true)
		setVehicleLocked (baustelle[i], true)
	end	]]
end
	
addEvent("changeTheVehiclesOwVeroRKeys", true)
addEventHandler("changeTheVehiclesOwVeroRKeys", getRootElement(),
	function(numb,name,id)
		for i,veh in ipairs(getElementsByType("vehicle")) do
			if tonumber(numb) == i then
				if tonumber(id) == 1 then
					setElementData(veh, "owner", tostring(name))
				end
				if tonumber(id) == 2 then
					setElementData(veh, "keys", tostring(name))
				end
				break
			end
		end
	end
)

addEvent("doUnLockTheVehicle", true)
addEventHandler("doUnLockTheVehicle", getRootElement(),
	function(numb)
	for i,veh in ipairs(getElementsByType("vehicle")) do
			if tonumber(numb) == i then
				setVehicleLocked(veh, not isVehicleLocked(veh))
				break
			end
		end
	end
)


function lockVehicle(player)
	if isPedInVehicle (player) then
		AutoAufZu(getPedOccupiedVehicle(player), player)
	end
end

function isVehicleOwner(ply, ownerstring)
	if not ownerstring then return end
	local ownerTable = split(ownerstring, string.byte(','))
	if not ownerTable or not type(ownerTable) == "table" then return end
	for k,v in ipairs(ownerTable) do
		if v == getPlayerName(ply) then
			return true
		end
	end
	return false
end

local aufZuTimer = {}
function timerAufZu(veh)
	if not veh or not isElement(veh) then return end
	local vx, vy, vz = getElementVelocity ( veh )
	local occupants = getVehicleOccupants ( veh )
	local hasInside = false
	if occupants then
		for i,v in pairs(occupants) do
			if v and getElementType(v) == "player" then
				hasInside = true
			end
		end
	end
	local speed = math.floor(  ((vx^2 + vy^2 + vz^2) ^ 0.7) * 50 * 3.6 )	
	if speed == 0 and hasInside == false then
		setElementFrozen(veh, true)
		setVehicleDamageProof(veh, true)
	else
		aufZuTimer[veh] = setTimer(timerAufZu, 1000, 1, veh)
	end
end

function AutoAufZu(veh, source)
	if isElement(veh) and isElement(source) then
		if getElementData(veh, "isVehicleTemp") == false then
			if isVehicleOwner(source,getElementData ( veh, "keys" )) == true then
				if isVehicleLocked ( veh ) == true then
					setVehicleLocked ( veh, false )
					if aufZuTimer[veh] and isTimer(aufZuTimer[veh]) then killTimer(aufZuTimer[veh]) end
					if getElementData(veh, "onFire") ~= true and getElementData(veh, "blockUnfreeze") ~= true and getElementData(veh, "marked") ~= true then
						setElementFrozen(veh, false)
					end
					if getElementData(veh, "blockUnfreeze") ~= true and getElementData(veh, "panne") ~= true then
						setVehicleDamageProof(veh, false)
					end
					outputChatBox("Zentralverriegelung deaktiviert!",source,0,255,0)
				else
					if aufZuTimer[veh] and isTimer(aufZuTimer[veh]) then killTimer(aufZuTimer[veh]) end
					timerAufZu(veh)
					setVehicleLocked ( veh, true )
					outputChatBox("Zentralverriegelung aktiviert!",source,0,255,0)
				end
				if getElementModel(veh) ~= 481 and getElementModel(veh) ~= 509 and getElementModel(veh) ~= 510 then
					local posx, posy, posz = getElementPosition(veh)
					local players = getElementsByType("player")
					for _,v in pairs(players) do
						callClientFunction(v, "playAttachedSound3D", "sounds/Pik pik.mp3", veh)
					end
				end
				if getVehicleOverrideLights(veh) == 1 then
					setVehicleOverrideLights( veh, 2 )
					setTimer(
						function()
						setVehicleOverrideLights( veh, 1 )
						end
					,250,1)
				else
					setVehicleOverrideLights( veh, 1 )
					setTimer(
						function()
						setVehicleOverrideLights( veh, 2 )
						end
					,250,1)
				end
			else
				outputChatBox("Du hast keine Schlüssel für dieses Fahrzeug!", source, 255, 0, 0)
			end	
		end
	end
end
addEvent( "AutoAufZu", true )
addEventHandler( "AutoAufZu", getRootElement(), AutoAufZu )

function repairVehicleAfterExplosion(veh)
	fixVehicle(veh)
	setElementHealth(veh, 250.0)
	setVehicleDamageProof(veh, true)
	local x,y,z = getElementRotation ( veh )
	setElementRotation( veh, 0, 0, z )
	setVehicleWheelStates ( veh, 1, 1, 1, 1 )
	setVehicleDoorState ( veh, 0, 4 )
	setVehicleDoorState ( veh, 1, 4 )
	setVehicleDoorState ( veh, 2, 4 )
	setVehicleDoorState ( veh, 3, 4 )
	setVehicleDoorState ( veh, 4, 4 )
	setVehicleDoorState ( veh, 5, 4 )
	setVehiclePanelState ( veh, 0, 3 )
	setVehiclePanelState ( veh, 1, 3 )
	setVehiclePanelState ( veh, 2, 3 )
	setVehiclePanelState ( veh, 3, 3 )
	setVehiclePanelState ( veh, 4, 3 )
	setVehiclePanelState ( veh, 5, 3 )
	setVehiclePanelState ( veh, 6, 3 )
	setVehicleOverrideLights( veh, 1 )
	local firemen = false
	for i,v in ipairs(getElementsByType("player")) do
		if getElementData(v, "job") == 7 and getElementData(v, "dienst") == 1 and getElementData(v, "afk") ~= true then
			firemen = true
			break
		end
	end
	if firemen and not isElementInWater ( source ) then
		setElementData(source, "onFire", true)
	end	
	setElementData(veh, "panne", true)
	setElementData(veh, "motor", false)	
end

function onVehicleExplode ()
	if getElementData(source, "isVehicleTemp") == false then
		local x, y, z = getElementPosition(source)
		setVehicleRespawnPosition ( source, x,y,z,0.0,0.0,rz )
		setTimer ( repairVehicleAfterExplosion, 1000, 1, source )	
	else
		if getElementData(source, "shallRespawn") ~= true then
			destroyElement(source)
		end
	end	
end
addEventHandler("onVehicleExplode", getRootElement(), onVehicleExplode)

function onVehicleDamage(loss)
	if getElementData(source, "isVehicleTemp") == false then
		if((getElementHealth(source) - loss) < 250.0) then
			local haspanne = getElementData(source, "panne")
			setElementHealth(source, 250.0)
			setVehicleDamageProof(source, true)
			setVehicleEngineState ( source, false )
			setElementData(source, "panne", true)
			setElementData(source, "motor", false)
			local int = math.random(1,3)
			if int == 1 then
				local firemen = false
				for i,v in ipairs(getElementsByType("player")) do
					if getElementData(v, "job") == 7 and getElementData(v, "dienst") == 1 and getElementData(v, "afk") ~= true then
						firemen = true
						break
					end
				end
				if firemen and haspanne == false and not isElementInWater ( source ) then
					setElementData(source, "onFire", true)
				end
			end
		end
	end
end
addEventHandler("onVehicleDamage", getRootElement(), onVehicleDamage)

function lightFunc(source)
	if isPedInVehicle ( source ) and getVehicleType (getPedOccupiedVehicle(source)) == "Automobile" or getVehicleType (getPedOccupiedVehicle(source)) == "Bike" or getVehicleType (getPedOccupiedVehicle(source)) == "Quad" then
		if getVehicleOccupant ( getPedOccupiedVehicle(source), 0 ) == source then 
			if getElementData(getPedOccupiedVehicle(source), "motor") == true then
				if getVehicleOverrideLights ( getPedOccupiedVehicle(source) ) == 1 then
					setVehicleOverrideLights(getPedOccupiedVehicle(source), 2)
					playSoundFrontEnd(source, 37)
				else
					setElementData(getPedOccupiedVehicle(source), "fernlicht", false)
					setVehicleOverrideLights(getPedOccupiedVehicle(source), 1)
					playSoundFrontEnd(source, 38)
				end
			end
		end
	end	
end
addCommandHandler ("licht", lightFunc )

function fernlichtFunc(source)
	--Deaktiviert weil Lags
	local deak = true
	if deak == true then return end
	if isPedInVehicle ( source ) and getVehicleType (getPedOccupiedVehicle(source)) == "Automobile" then
		if getVehicleOccupant ( getPedOccupiedVehicle(source), 0 ) == source then 
			if getElementData(getPedOccupiedVehicle(source), "motor") == true then
				if getElementData(getPedOccupiedVehicle(source), "fernlicht") == false then
					if getVehicleOverrideLights ( getPedOccupiedVehicle(source) ) == 1 then
						setVehicleOverrideLights(getPedOccupiedVehicle(source), 2)
					end
					setElementData(getPedOccupiedVehicle(source), "fernlicht", true)
					playSoundFrontEnd(source, 38)
				else
					setElementData(getPedOccupiedVehicle(source), "fernlicht", false)
					playSoundFrontEnd(source, 37)
				end
			end
		end	
	end	
end
addCommandHandler ("fernlicht", fernlichtFunc )

function refreshVehicleState(pname, v)
	if getElementData(v, "locked") then return 0 end
	
	local vkeys = getElementData ( v, "keys" )
	if not vkeys then return 0 end
	
	local owners = split(vkeys, string.byte(','))
	local otherPlayerHasKey = false
	local isOwnedBy = false
	for k, v in pairs(owners) do 
		if v == pname then
			isOwnedBy = true
		end
		if isPlayerOnline(v) and v ~= pname then
			otherPlayerHasKey = true
		end
	end
	if isOwnedBy == false or otherPlayerHasKey == true then
		return 0
	end
	if getElementData(v, "isProtected") == true then return -1
	else return 1
	end
end

--[[addEventHandler("onPlayerRPGLogin", getRootElement(), 
	function()
		if isElement(source) then
			local pname = getPlayerName(source)
			
			for k, v in pairs(getElementsByType("vehicle")) do
				if refreshVehicleState(pname, v) == -1 then
					setElementData(v, "isProtected", false)
					setVehicleDamageProof(v, false)
					setElementFrozen(v, false)
				end
			end
		end
	end	
)

addEventHandler("onPlayerQuit", getRootElement(),
	function()
		local pname = getPlayerName(source)
		
		for k, v in pairs(getElementsByType("vehicle")) do
			if refreshVehicleState(pname, v) == 1 and isVehicleLocked ( v ) == true then
				setElementData(v, "isProtected", true)
				setVehicleDamageProof(v, true)
				setElementFrozen(v, true)
			end
		end
	end
)]]


addEventHandler("onTrailerAttach", getRootElement(), 
	function(towtruck)
		if getElementModel(source) == 570 then return end
		--if not towtruck or getElementModel(towtruck) ~= 525 then return end
		local thePlayer = getVehicleOccupant(towtruck)
		if not thePlayer then return end		
		if getElementData(source, "onFire") == true then
			setElementFrozen(source, true)
			return false
		end
		pLogger["abschlepper"]:addEntry(getPlayerName(thePlayer).." hat einen "..getVehicleNameFromModel(getElementModel(source)).." (ID:"..tostring(getElementData(source, "model"))..") von "..tostring(getElementData(source, "owner")).." mit einem Abschleppwagen abgeschleppt.")
		if isVehicleLocked(source) == true or (isElementFrozen(source) and getVehicleType(source) == "Trailer") --[[and thePlayer and  getElementData(thePlayer, "job") == 4 and getElementData(thePlayer, "dienst") == 1]] then
			if getElementData(source, "blockUnfreeze") ~= true and (getElementModel(towtruck) == 525 or getVehicleType(source) == "Trailer") then --Mit dem Towtruck oder InterTrans Anhänger
				setElementFrozen(source, false)
			end
		end
	end
)
addEventHandler("onTrailerDetach", getRootElement(), 
	function()
		if isVehicleLocked(source) == true or getElementData(source, "marked") == true then
			--setTimer(
			--function(source)
			setElementFrozen(source, true)
			--end
			--,5000,1, source)
		elseif getElementData(source, "onFire") == true then
			setElementFrozen(source, false)
		end
	end
)

function benzinVerbrauch()
	local oldfuel
	for k, v in pairs(getElementsByType("vehicle")) do
		if getVehicleEngineState(v) == true and (getVehicleType (v) == "Automobile" or getVehicleType (v) == "Bike" or getVehicleType (v) ==  "Quad") and getElementModel(v) ~= 441 then
			if not getElementData( v, "doNotLooseFuel") == true then
				oldfuel = getElementData(v, "fuel")
				if not oldfuel then oldfuel = 100 end
				setElementData ( v, "fuel", oldfuel-0.5 )
				if getElementData(v, "fuel") <= 0 then
					setElementData ( v, "fuel", 0 )
					setVehicleEngineState(v, false)
				end
			end	
		end
	end
end

function alarmanlage ( demage )
	if isVehicleLocked ( source ) then
		if  getElementData ( source, "alerttimer" ) and  isTimer(getElementData ( source, "alerttimer" )) or getVehicleEngineState ( source ) then
		else
			local x1, y1, z1 = getElementPosition ( source )
			local veh = source
			triggerClientEvent ( getRootElement(), "onServerTriggerAlert", getRootElement(), x1, y1, z1, veh )
			setVehicleOverrideLights ( source, 1 )
			timer1 = setTimer ( function () setVehicleOverrideLights ( veh, 2 ) setTimer ( function () if isElement(veh) then setVehicleOverrideLights ( veh, 1 ) end end, 500, 1, veh ) end, 1000, 23 , veh )
			setElementData ( source, "alerttimer", timer1 )
		end
	end
end
addEventHandler ( "onVehicleDamage", getRootElement(), alarmanlage )

--Üzgür Autoverwertung
local verwerterMarker = createMarker ( 365.4619140625, 2537.1484375, 15.664260864258, "cylinder", 5, 125,125,125,125 )

function verwerterMarkerFunc( hitElement, matchingDimension )
	if getElementType(hitElement) == "player" then
		local veh = getPedOccupiedVehicle(hitElement)
		if veh then
			local vero = getElementData(veh, "preis")*0.35
			outputChatBox( "Hier ist Üzgür: Um mir das Fahrzeug für die Verwertung zu geben, gib /autoverwertung in deinen Chat ein.", hitElement, 255, 255, 0 )
			outputChatBox( "Du bekommscht für das Karre hier "..tostring(vero).." Vero!", hitElement, 255, 255, 0 )
		else
			outputChatBox( "Hier ist Üzgür: Komm mit Karre her das du verkaufen willscht.", hitElement, 255, 255, 0 )
		end
	end
end
addEventHandler( "onMarkerHit", verwerterMarker, verwerterMarkerFunc )

function verwerteAuto(player, command)
	if isPedInVehicle(player) then
		local veh = getPedOccupiedVehicle(player)
		if isElementWithinMarker(veh, verwerterMarker) then
			if getElementData(veh, "isVehicleTemp") == false then
				if (getElementData(veh, "owner") == getPlayerName(player)) or (getElementData(veh, "owner") == tostring(getElementData(player, "job")) and getElementData(player, "rank") == 2) or (getElementData(veh, "owner") == "g"..getElementData(player, "gang") and getElementData(player, "gangrank") == 2)  then
					if getElementData(veh, "owner") == "11" or getElementData(veh, "owner") == "5" or getElementData(veh, "owner") == "1" then
						return outputChatBox( "Ey das Karre is nisch verkauft und isch Eigentum vom Händlah. Dat nimm ich nücht! ", player, 255, 0, 0 )
					end
					local vero = getElementData(veh, "preis")*0.35
					givePlayerMoneyEx(player, vero)
					systemDeposit("Autohus", math.floor(vero/2))
					systemDeposit("car4you", math.floor(vero/2))
					outputChatBox( "Kollegah! Auto ist auf Flugzeug auf Weg zu mein Familie. Hier dein Geld!", player, 0, 255, 0 )
					outputChatBox( "Du bekommscht dafür "..tostring(vero).." Vero!", player, 0, 255, 0 )
					destroyElement(veh)
				else
					outputChatBox( "Ey was gibscht du mir scheiß Karre ohne Papiere. Dat nimm ich nücht!", player, 255, 0, 0 )
				end
			end
		end
	end
end	
addCommandHandler("autoverwertung", verwerteAuto)

local veh_syncer = {}
 
 
 
-- EVENT HANDLERS --
 
addEventHandler("onTrailerAttach", getRootElement(), function(theVehicle)
	if getElementModel(source) == 570 then return end
	setElementData(theVehicle, "theTrailer",source)
end)
 
addEventHandler("onTrailerDetach", getRootElement(), function(theVehicle)
	if getElementModel(source) == 570 then return end
    setElementData(theVehicle, "theTrailer",false)
end)