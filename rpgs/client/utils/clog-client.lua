--[[
Project: VitaOnline
File: clog-client.lua
Author(s):	ReWrite
]]--

local xmlFile = nil
local xmlNode = nil
local tag, stunde

local function openFile( )
	local zeit = getRealTime( )
	tag = zeit.yearday
	stunde = zeit.hour
	local fileName = ( "clog/%02d.%02d.%04d/%02d Uhr.html" ):format( zeit.monthday,zeit.month + 1,zeit.year + 1900, zeit.hour )
	xmlFile = xmlLoadFile( fileName )
	if not xmlFile then
		xmlFile = xmlCreateFile( fileName, "html" )
		local head = xmlCreateChild( xmlFile, "head" )
		local title = xmlCreateChild( head, "title" )
		xmlNodeSetValue( title, ( "Vita Online Log: %02d-%02d-%04d" ):format( zeit.monthday, zeit.month + 1, zeit.year + 1900 ) )
		local style = xmlCreateChild( head, "style" )
		xmlNodeSetAttribute( style, "type", "text/css" )
		xmlNodeSetValue( style, "body { font-family: Arial; font-size: 0.9em; background: #A9A9A9; }  p { padding: 0; margin: 0; } .v1 { color: #AAAAAA; } .v2 { color: #DDDDDD; } .v3 { white-space:pre; } .v4 { font-size: 0.0em; }" )
		xmlNode = xmlCreateChild( xmlFile, "body" )
		xmlSaveFile( xmlFile )
	else
		xmlNode = xmlFindChild( xmlFile, "body", 0 )
	end
end

local function closeFile( )
	if xmlFile then
		xmlUnloadFile( xmlFile )
		xmlFile = nil
		xmlNode = nil
	end
end

local function xmlNodeSetValue2( a, b )
	if b:match "^%s*(.-)%s*$" == "" then
		return xmlDestroyNode( a )
	else
		return xmlNodeSetValue( a, b )
	end
end

function logthechat( chat, r, g, b )
	--if getElementData(getLocalPlayer(),"logedin") == 1 then
	--local salt = getElementData(getLocalPlayer(), "salt")
	_G["sayername"] = nil
	local salt = 29345
	local playername = getPlayerName(getLocalPlayer())
	--------
	local zeit = getRealTime( )
	if not xmlFile or not xmlNode then
		openFile( )
	elseif zeit.yearday ~= tag or zeit.hour ~= stunde then
		closeFile( )
		openFile( )
	end
	local node = xmlCreateChild( xmlNode, "p" )
	local nodezeit = xmlCreateChild( node, "text" )
	xmlNodeSetValue( nodezeit, ( "%02d:%02d:%02d" ):format( zeit.hour, zeit.minute, zeit.second ) )
	xmlNodeSetAttribute( nodezeit, "class", "ver2" )
	local nodeDate = xmlCreateChild( node, "text" )
	xmlNodeSetValue( nodeDate, ( "%02d-%02d-%04d" ):format( zeit.monthday, zeit.month + 1, zeit.year + 1900 ) )
	xmlNodeSetAttribute( nodeDate, "class", "ver1" )
	local tab = { }
	local farbe = ("#%02x%02x%02x"):format( r, g, b )
	while true do
		local a, b = chat:find("#%x%x%x%x%x%x")
		local tab = xmlCreateChild( node, "text" )
		xmlNodeSetAttribute( tab, "class", "v3" )
		if a and b then
			xmlNodeSetAttribute( tab, "style", "color:" .. farbe )
			xmlNodeSetValue2( tab, chat:sub( 1, a - 1 ) )
			_G["sayername"] = chat:sub( 1, a - 1 )
			farbe = chat:sub( a, b )
			chat = chat:sub( b + 1 )
		else
			xmlNodeSetAttribute( tab, "style", "color:" .. farbe )
			xmlNodeSetValue2( tab, chat )
			local hash = xmlCreateChild( node, "text" )
			xmlNodeSetAttribute( hash, "class", "v4" )
			if _G["sayername"] == nil then
				xmlNodeSetValue2( hash, md5(chat..salt..playername) )
			else
				xmlNodeSetValue2( hash, md5(_G["sayername"]..chat..salt..playername) )
			end
			break
		end
	end
	xmlSaveFile( xmlFile )
	end
--end
addEventHandler( "onClientChatMessage", getRootElement( ), logthechat)

function openthelog( )
	openFile( )
end
addEventHandler( "onClientResourceStop", getResourceRootElement( ), openthelog)

function killthelog( )
	closeFile( )
end
addEventHandler( "onClientResourceStop", getResourceRootElement( ), killthelog)