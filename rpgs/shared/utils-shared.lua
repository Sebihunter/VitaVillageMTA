--[[
Project: VitaOnline
File: utils-shared.lua
Author(s):	Sebihunter
]]--

gJobData = {
	[0] = { name = "Arbeitslos", skin0 =  0, skin1 =  0, skin2 =  0, px = 0.0, py = 0.0, pz = 0.0 },	
	[1] = { name = "Ares Mitarbeiter", skin0 =  187, skin1 =  187, skin2 =  187, px = 1089.3699951172, py = 1738.2020263672, pz = 10.800000190735, bankname = "Autohaus" },
	[2] = { name = "LKW-Fahrer", skin0 =  161, skin1 =  72, skin2 =  125, px =  1581.6999511719 , py = 2407.3000488281, pz =  10.800000190735, bankname = "Trucker" },
	[3] = { name = "Polizist", skin0 =  282, skin1 =  288, skin2 =  283, px = 196.963, py = 170.250, pz = 1003.023, bankname = "Polizei" },
	[4] = { name = "Mechaniker", skin0 =  268, skin1 = 305, skin2 =  50, px = 1696.5, py =  745.90002441406, pz = 10.300000190735, bankname = "Autofix" },
	[5] = { name = "Autohus Mitarbeiter", skin0 =  98, skin1 =  98, skin2 =  98, px = 2172.400390625, py = 1390.5, pz = 11, bankname = "Autohus" },
	[6] = { name = "Beamter", skin0 =  147, skin1 =  147, skin2 =  147, px = 307.049, py = 66.568, pz = 1019.228, bankname = "SASO" },
	[7] = { name = "Rettungskraft", skin0 =  277, skin1 =  278, skin2 =  279, px = 356.0695, py = 317.903411, pz = 1020.05371, bankname = "Krankenhaus" }, --274, 275, 276
	[8] = { name = "Feuerwehrmann", skin0 =  277, skin1 =  278, skin2 =  279, px = 0, py = 0, pz = 0, bankname = "Feuerwehr" },
	[9] = { name = "Reporter", skin0 =  93, skin1 =  188, skin2 =  186, px = 363.20001220703, py = 171.89999389648, pz = 1025.6999511719, bankname = "Reporter" },
	[10] = { name = "Fahrschullehrer", skin0 =  71, skin1 =  71, skin2 =  71, px = 1170.78, py = 1347.21, pz = 10.92, bankname = "Fahrschule" },
	[11] = { name = "car4you Mitarbeiter", skin0 =  98, skin1 =  98, skin2 =  98, px = 1640.1336669922, py = 2195.125, pz = 10.934868812561, bankname = "car4you" }
}

function removeColorCoding ( name, nocentiseconds )
	return type(name)=='string' and string.gsub ( name, '#%x%x%x%x%x%x', '' ) or name
end


function isOwner(name, ownerstring)
	if not ownerstring then return end
	local ownerTable = split(ownerstring, string.byte(','))
	if not ownerTable or not type(ownerTable) == "table" then return end
	for k,v in ipairs(ownerTable) do
		if v == name then
			return true
		end
	end
	return false
end


function getAttachedPosition(x, y, z, rx, ry, rz, distance, angleAttached, height)
 
    local nrx = math.rad(rx);
    local nry = math.rad(ry);
    local nrz = math.rad(angleAttached - rz);
    
    local dx = math.sin(nrz) * distance;
    local dy = math.cos(nrz) * distance;
    local dz = math.sin(nrx) * distance;
    
    local newX = x + dx;
    local newY = y + dy;
    local newZ = (z + height) - dz;
    
    return newX, newY, newZ;
end

function xmlSetNode(xmlfile, nodename, nodeval)
	local thenode = xmlFindChild(xmlfile, nodename, 0)
	if not thenode then
		local newnode = xmlCreateChild(xmlfile, nodename)
		xmlNodeSetValue(newnode, tostring(nodeval))
		return newnode
	else
		xmlNodeSetValue(thenode, tostring(nodeval))
		return thenode
	end	
	return false
end

function oneNodeEdit(xmlfile, nodename, nodeval)
	local xml = xmlLoadFile(xmlfile)
	xmlSetNode(xml, nodename, nodeval)
	xmlSaveFile(xml)
	xmlUnloadFile(xml)
end

function oneNodeGet(xmlfile, nodename)
	local xml = xmlLoadFile(xmlfile)
	local find = xmlFindChild(xml, nodename, 0)
	local val = xmlNodeGetValue(find)
	xmlSaveFile(xml)
	xmlUnloadFile(xml)
	return val
end

function xmlGetVal(xmlfile, nodename)
	local find = xmlFindChild(xmlfile, nodename, 0)
	local val = xmlNodeGetValue(find)
	if val then return val end
	return false
end


function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
	if 
		type( sEventName ) == 'string' and 
		isElement( pElementAttachedTo ) and 
		type( func ) == 'function' 
	then
		local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
		if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then
			for i, v in ipairs( aAttachedFunctions ) do
				if v == func then
					return true
				end
			end
		end
	end
 
	return false
end


-- Ermöglicht Teilnamen anstelle von kompletten Namen
-- Rückgabewerte:
-- Spielerelement (Wenn nur 1 Spieler gefunden)
-- Table (Wenn mehrere Spieler gefunden)
-- nil (Wenn kein Spieler gefunden)

function getPlayerFromName2(name, rangeXorEle, rangeYorDistance, rangeZ, distance)
	if not name then return nil end
	local ptable = getElementsByType("player")
	
	if rangeXorEle then -- Reichweitenbeschränkung aktiv
		local col 
		if isElement(rangeXorEle) then
			col = createColSphere(getElementPosition(rangeXorEle), rangeYorDistance)
		else
			col = createColSphere(rangeXorEle, rangeYorDistance, rangeZ, distance)
		end
		ptable = getElementsWithinColShape(col, "player")
	end
	local player = getPlayerFromName(name)
	if player then
		return player 
	end
	name = string.lower(name) -- case insensitive :>
	local p = {}
	for index, player in pairs(getElementsByType("player")) do
		if string.find(string.lower(getPlayerName(player)), name) then
			p[#p+1] = player
		end
	end
	if #p == 0 then
		return nil
	elseif #p == 1 then
		return p[1]
	else
		return p
	end
end

-- Gibt zurück ob eine Position oder ein Element innerhalb einer bestimmten Reichweite ist.
-- Nutzungsbeispiele:
-- isInRange(5.0, player, 0, 0, 0) -- Gibt zurück ob ein Spieler innerhalb von 5m zum Nullpunkt ist
-- isInRange(5.0, player, player2) -- Gibt zurück ob zwei Spieler maximal 5m voneinander entfernt sind

function isInRange(range, x, y, z, x2, y2, z2)
	local xele
	local yele
	if isElement(x) then
		xele = x
	end
	if isElement(y) then
		yele = y
	end
	if xele then
		x, y, z = getElementPosition(xele)
	end
	if yele then 
		x2, y2, z2 = getElementPosition(yele)
	end
	return (getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) <= range)
end

-- Gibt zurück ob ein Spieler Online und eingeloggt ist
function isPlayerOnline(playername)
	local p = getPlayerFromName(playername)
	if not p then return false end
	return (getElementData(p, "isPlayerLoggedIn") == true)
end

-- Ermittelt den Job Rangnamen anhand der folgenden IDs
-- ID 0-2
function getJobRangNameFromID(jobid)
	local jobrang
	if jobid == 0 then
		jobrang = "Auszubildender"
	elseif jobid == 1 then
		jobrang = "Mitarbeiter"
	elseif jobid == 2 then       
		jobrang = "Chef"
	else
		jobrang = false
	end
	return jobrang
end

-- Datei erstellen oder laden
function fileOpenOrCreate(filepath, readonly)
	local pFile = fileOpen(filepath, readonly)
	if not pFile then
		pFile = fileCreate(filepath)
	end
	return pFile
end

-- XML Datei erstellen oder laden
function xmlCreateOrLoad(fname, rootnode)
	local node = xmlLoadFile(fname)
	if node == false then
		return xmlCreateFile(fname, rootnode)
	else 
		return node
	end
end

-- Elementdatas aus Table laden / schreiben
function setElementDataTable(element, datatable)
	for k, v in pairs(datatable) do
		setElementData(element, k, v)
	end
end

getElementDataTable = getAllElementData

--Punkte aus dem Namen entfernen
function getNameWithoutDots(name)
	return string.gsub(name,"%.", " ", 1)
end

--Gibt das Firmenkonto für eine JobID aus
function getJobBankName(jobid)
	local jobname = false
	if gJobData[jobid].bankname then jobname = gJobData[jobid].bankname end
	return jobname
end

function msToTimeStr(ms, nocentiseconds)
	if not ms then
		return ''
	end
	local centiseconds = tostring(math.floor(math.fmod(ms, 1000)/10))
	if #centiseconds == 1 then
		centiseconds = '0' .. centiseconds
	end
	local s = math.floor(ms / 1000)
	local seconds = tostring(math.fmod(s, 60))
	if #seconds == 1 then
		seconds = '0' .. seconds
	end
	local minutes = tostring(math.floor(s / 60))
	if nocentiseconds then
		return minutes .. ':' .. seconds
	else
		return minutes .. ':' .. seconds .. ':' .. centiseconds
	end
end
