--[[
Project: VitaOnline
File: utils-server.lua
Author(s):	Sebihunter
]]--

_createVehicle = createVehicle
function createVehicle ( model, x, y, z, rx, ry, rz, numberplate, bDirection, variant1, variant2 )
	if not model then model = 411 end
	if not x then x = 0 end
	if not y then y = 0 end
	if not z then z = 0 end
	if not rx then rx = 0 end
	if not ry then ry = 0 end
	if not rz then rz = 0 end
	if not numberplate then numberplate = "Vita" end
	if not bDirection then bDirection = false end
	if not variant1 then variant1 = 0 end
	if not variant2 then variant2 = 0 end
	local vehicle = _createVehicle ( model, x, y, z, rx, ry, rz, numberplate, bDirection, variant1, variant2 )
	if not vehicle then return false end
	if ( model == 597) then --Polizei Sentinel
		removeVehicleSirens(vehicle)
		setVehicleHandling(vehicle, "engineAcceleration", 14)
		addVehicleSirens(vehicle, 2, 2, true, true, true, true)
		setVehicleSirens(vehicle, 1, 0.4, -0.5, 0.8, 0, 0, 255, 200, 200)
		setVehicleSirens(vehicle, 2, -0.4, -0.5, 0.8, 0, 0, 255, 200, 200)
	elseif model == 427 then -- Polizei Enforcer
		addVehicleSirens(vehicle, 2, 2, true, true, true, true)
		setVehicleSirens(vehicle, 1, -0.4, 1.1, 1.5, 0, 0, 255, 255, 255)
		setVehicleSirens(vehicle, 2, 0.4, 1.1, 1.5, 0, 0, 255, 255, 255)
	elseif model == 582 then -- Newsvan
		local theHandling = getOriginalHandling ( 542 )
		for i,v in pairs(theHandling) do
			setVehicleHandling ( vehicle, i, v )
		end
	elseif ( model == 598) then --Polizei Cheetah
		local theHandling = getOriginalHandling ( 411 )
		for i,v in pairs(theHandling) do
			if i == "engineAcceleration" then v = v + 2 end
			setVehicleHandling ( vehicle, i, v )
		end
		removeVehicleSirens(vehicle)
		--setVehicleHandling(vehicle, "engineAcceleration", 11)
		addVehicleSirens(vehicle, 2, 2, true, true, true, true)
		setVehicleSirens(vehicle, 1, 0.4, -0.5, 0.6, 0, 0, 255, 200, 200)
		setVehicleSirens(vehicle, 2, -0.4, -0.5, 0.6, 0, 0, 255, 200, 200)
	elseif model == 523	then --HPV Polizei Motorrad
		--FUNTKIONIERT HIER IRGENDWIE NICHT :(
	elseif model == 601 then 
		removeVehicleSirens(vehicle)
		addVehicleSirens(vehicle, 2, 2, true, true, true, true)
		setVehicleSirens(vehicle, 1, 0.4, -0.5, 0.6, 0, 0, 255, 200, 200)
		setVehicleSirens(vehicle, 2, -0.4, -0.5, 0.6, 0, 0, 255, 200, 200)			
	elseif ( model == 599) then --Polizei Rancher
		removeVehicleSirens(vehicle)
		addVehicleSirens(vehicle, 2, 2, true, true, true, true)
		setVehicleSirens(vehicle, 1, 0.4, 0, 1.2, 0, 0, 255, 200, 200)
		setVehicleSirens(vehicle, 2, -0.4, 0, 1.2, 0, 0, 255, 200, 200)	
	elseif ( model == 490) then --FBI
		removeVehicleSirens(vehicle)
		addVehicleSirens(vehicle, 5, 2, true, true, true, true)	
		setVehicleSirens(vehicle, 1, 0.8, 3.45, 0, 0, 0, 255, 255, 255)
		setVehicleSirens(vehicle, 2, -0.8, 3.45, 0, 0, 0, 255, 255, 255)
		setVehicleSirens(vehicle, 3, 0, 1.4, 0.6, 0, 0, 255, 255, 255)
		setVehicleSirens(vehicle, 4, 0.5, -3.3, 0.6, 0, 0, 255, 255, 255)
		setVehicleSirens(vehicle, 5, -0.5, -3.3, 0.6, 0, 0, 255, 255, 255)		
	elseif ( model == 525) then --Towtruck
		addVehicleSirens(vehicle, 3, 2, true, true, true, true)
		setVehicleSirens(vehicle, 1, -0.6, -0.5, 1.5, 255, 137.7, 0, 200, 200)
		setVehicleSirens(vehicle, 2, 0, -0.5, 1.5, 255, 255, 0, 198.9, 198.9)
		setVehicleSirens(vehicle, 3, 0.6, -0.5, 1.5, 255, 137.7, 0, 200, 200)	
	elseif ( model == 596) then --Sani
		local theHandling = getOriginalHandling ( 597 )
		for i,v in pairs(theHandling) do
			setVehicleHandling ( vehicle, i, v )
		end		
		setVehicleHandling(vehicle, "engineAcceleration", 14)
		removeVehicleSirens(vehicle)
		addVehicleSirens(vehicle, 2, 2, true, true, true, true)
		setVehicleSirens(vehicle, 1, 0.4, -0.5, 0.8, 255, 0, 0, 200, 200)
		setVehicleSirens(vehicle, 2, -0.4, -0.5, 0.8, 255, 0, 0, 200, 200)
	elseif ( model == 426) then --Polizei/SASO Premier
		local theHandling = getOriginalHandling ( 597 )
		for i,v in pairs(theHandling) do
			setVehicleHandling ( vehicle, i, v )
		end	
		setVehicleHandling(vehicle, "engineAcceleration", 14)
		removeVehicleSirens(vehicle)
		addVehicleSirens(vehicle, 5, 2, true, true, true, true)
		setVehicleSirens(vehicle, 1, -0.8, 2.54, 0, 0, 0, 255, 200, 200)
		setVehicleSirens(vehicle, 2, 0.8, 2.5, 0, 0, 0, 255, 200, 200)
		setVehicleSirens(vehicle, 3, 0, 1.1, 0.5, 0, 0, 255, 200, 200)
		setVehicleSirens(vehicle, 4, 0.6, -1.9, 0.4, 0, 0, 255, 200, 200)
		setVehicleSirens(vehicle, 5, -0.6, -1.9, 0.4, 0, 0, 255, 200, 200)	
	elseif ( model == 416 ) then ---Ambulance
		removeVehicleSirens(vehicle)
		addVehicleSirens(vehicle, 3, 2, true, true, true, true)
		setVehicleSirens(vehicle, 1, -0.5, 0.9, 1.3, 255, 0, 0, 255, 255)
		setVehicleSirens(vehicle, 2, 0, 0.9, 1.3, 255, 255, 255, 255, 255)
		setVehicleSirens(vehicle, 3, 0.4, 0.9, 1.3, 255, 0, 0, 255, 255)
		
		setVehicleHandling (vehicle, "engineAcceleration", 12 )
		setVehicleHandling (vehicle, "maxVelocity", 150)
		
	elseif model == 407 then -- vehicleruck
		removeVehicleSirens(vehicle)
		addVehicleSirens(vehicle, 8, 2, true, true, true, true)
		setVehicleSirens(vehicle, 1, -0.7, 3.2, 1.4, 255, 0, 0, 255, 255)
		setVehicleSirens(vehicle, 2, 0.7, 3.2, 1.4, 255, 0, 0, 255, 255)
		setVehicleSirens(vehicle, 3, 0.2, 3.2, 1.4, 255, 255, 255, 255, 255)
		setVehicleSirens(vehicle, 4, -0.2, 3.2, 1.4, 255, 255, 255, 255, 255)
		setVehicleSirens(vehicle, 5, 1.1, -3.65, 0.1, 255, 145.4, 0, 255, 112.2)
		setVehicleSirens(vehicle, 6, -1.1, -3.65, 0.1, 255, 145.4, 0, 255, 112.2)
		setVehicleSirens(vehicle, 7, -0.8, 4.2, 0.1, 255, 145.4, 0, 255, 112.2)
		setVehicleSirens(vehicle, 8, 0.8, 4.2, 0.1, 255, 145.4, 0, 255, 112.2)		
	end
	return vehicle
end

function executeServerCommandHandler(commandHandler, args)
	executeCommandHandler(commandHandler, source, args)
end
addEvent("executeServerCommandHandler", true)
addEventHandler("executeServerCommandHandler", getRootElement(), executeServerCommandHandler)

function titleCase( first, rest )
   return first:upper()..rest:lower()
end

_destroyElement = destroyElement
function destroyElement (element)
	if isElement(element) and getElementType(element) == "vehicle" then
		local id = getElementData(element, "mysqlID")
		if id then
			if mysql_ping ( g_mysql["connection"] ) == false then
				onResourceStopMysqlEnd()
				onResourceStartMysqlConnection()
			end
			local sql = "DELETE FROM `vehicles` WHERE `id` = '"..id.."' LIMIT 1 ;"											
			local query = mysql_query(g_mysql["connection"], sql)
			if query then mysql_free_result(query) end	
		end
	end
	return _destroyElement(element)
end

function callServerFunction(funcname, ...)
    local arg = { ... }
    if (arg[1]) then
        for key, value in next, arg do arg[key] = tonumber(value) or value end
    end
	
	if funcname == "callClientFunction" or funcname == "saveJobNote" or funcname == "sendJobNoteToPlayer" or funcname == "warpPedIntoVehicle"
	or funcname == "addToJob" or funcname == "kickFromJob" or funcname == "getFirmenPlayers" or funcname == "giveWeapon"
	or funcname == "setPlayerUserFileData" or funcname == "sendGangNoteToPlayer" or funcname == "saveGangNote"
	or funcname == "addToGang" or funcname == "kickFromGang" or funcname == "getGangPlayers" or funcname == "createRPGVehicle"
	or funcname == "systemDeposit" or funcname == "refreshHousePickup" or funcname == "setElementPosition" or funcname == "respawnBus"
	or funcname == "setElementInterior" or funcname == "setElementDimension" or funcname == "rentHouse"
	or funcname == "useItem" or funcname == "dropItem" or funcname == "kickPlayer" or funcname == "addVehicleUpgrade"
	or funcname == "removeVehicleUpgrade" or funcname == "setVehicleColor" or funcname == "setVehiclePaintjob"
	or funcname == "setVehicleVariant" or funcname == "giveItem" or funcname == "giveWeapon" or funcname == "givePhone" or funcname == "removePedFromVehicle"
	or funcname == "setVehicleEngineState" or funcname == "setVehicleOverrideLights" or funcname == "setControlState" or funcname == "_destroyElement"
	or funcname == "outputChatBox" or funcname == "setVehicleTaxiLightOn" or funcname == "buyVehicleBack" or funcname == "destroyElement"
	or funcname == "setVehFK" or funcname == "setVehicleDoorOpenRatio" or funcname == "setFirmaBewerbung" or funcname == "getFirmaBewerbungen" or funcname == "getBankLogs" then		

		if funcname == "callClientFunction" and arg[2] ~= "playSound" then return false end
		if funcname == "destroyElement" and getElementType ( arg[1] ) ~= "fakeVehicle" then return false end
		loadstring("return "..funcname)()(unpack(arg))
	else
		outputChatBox("Security Error: Exploitversuch - Code zu Server. ("..funcname..")")
	end
	
end
addEvent("onClientCallsServerFunction", true)
addEventHandler("onClientCallsServerFunction", resourceRoot , callServerFunction)

function callClientFunction(client, funcname, ...)
    local arg = { ... }
    if (arg[1]) then
        for key, value in next, arg do
            if (type(value) == "number") then arg[key] = tostring(value) end
        end
    end
    -- If the clientside event handler is not in the same resource, replace 'resourceRoot' with the appropriate element
    triggerClientEvent(client, "onServerCallsClientFunction", resourceRoot, funcname, unpack(arg or {}))
end

_addCommandHandler = addCommandHandler
function addCommandHandler(cmd, fn, res, cs)
	_addCommandHandler(cmd, 
		function(player, ...) 
		if getElementData(player, "isPlayerLoggedIn") ~= true then
			return
		end 
		return fn(player, ...)
	end, res, cs
	)
end

-- makePlayerExitVehicle
-- Lässt einen Spieler aussteigen
function makePlayerExitVehicle(player)
	setControlState(player, "enter_exit", true)
end


function createInvinciblePed(model, x, y, z, rz)
	local ped = createPed(model, x, y, z, rz)
	if ped then
		setElementData(ped, "isInvincible", true)
		local timer = setTimer(function(ped)
			if getElementHealth(ped) <= 0 then
				setElementHealth(ped, 100)
				setPedAnimation(ped, false)
				--[[local x, y, z = getElementPosition(ped)
				local rz = getPedRotation(ped)
				local timer = getElementData(ped, "pedTimer")
				removeElementData ( ped, "pedTimer" )
				local elementData = getElementDataTable(ped)
				local model = getElementModel(ped)
				local interior = getElementInterior(ped)
				local dimension = getElementDimension(ped)
				killTimer(timer)
				destroyElement(ped)
				ped = createInvinciblePed(model, x, y, z, rz)
				setElementDataTable(ped, elementData)
				setElementInterior(ped, interior)
				setElementDimension(ped, dimension)]]
			end
		end, 5000,0, ped)
		setElementData(ped, "pedTimer", timer)
	end
	return ped
end


function setPlayerMoneyEx(player, money)
	setElementData(player, "geld", money)
	return true
end

function givePlayerMoneyEx(player, money)
	setElementData(player, "geld", getElementData(player, "geld")+money)
	return true
end

function takePlayerMoneyEx(player, money)
	setElementData(player, "geld", getElementData(player, "geld")-money)
	return true
end

function getPlayerMoneyEx(player)
	local money = getElementData(player, "geld")
	return money
end

function isNameRegistered(name)
	if mysql_ping ( g_mysql["connection"] ) == false then
		onResourceStopMysqlEnd()
		onResourceStartMysqlConnection()
	end
	
	local query = mysql_query(g_mysql["connection"],"SELECT * FROM users WHERE name = '"..name.."';")
	if mysql_num_rows(query) > 0 then
		return true
	end	
	return false
end

--Leere Tabelle serialized: return {{},}--|

local function exportstring( s )
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

function escapeString(theString)
	if type(theString) ~= "string" then return theString end
	return mysql_escape_string(g_mysql["connection"], theString)
end