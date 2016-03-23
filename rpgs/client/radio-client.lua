--[[
Project: VitaOnline
File: radio-client.lua
Author(s):	Sebihunter
			MuLTi
]]--

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
function()
	for index, radio in pairs(getElementsByType("object")) do
		createRadio(radio)
	end
end)

function createRadio(radio)
	if(getElementData(radio, "isRadio") == true)  then
		local x, y, z = getElementPosition(radio)
		local url = getElementData(radio, "radioStream" )
		if(url) then
			local sound = playSound3D(url, x, y, z)
			setElementInterior(sound, getElementInterior(radio))
			setElementDimension(sound, getElementDimension(radio))
			setSoundMaxDistance(sound, 20)
			setElementData(radio, "radioClientSound", sound, false)
		end	
		addEventHandler ( "onClientElementDataChange", radio,
		function ( dataName )
			if getElementType ( source ) == "object" and dataName == "radioStream" then
				if isElement(getElementData(radio, "radioClientSound")) then
					stopSound(getElementData(radio, "radioClientSound"))
				end
				local x, y, z = getElementPosition(source)
				local url = getElementData(source, "radioStream" )
				if(url) then
					local sound = playSound3D(url, x, y, z)
					setElementInterior(sound, getElementInterior(source))
					setElementDimension(sound, getElementDimension(source))
					setSoundMaxDistance(sound, 20)
					setElementData(radio, "radioClientSound", sound, false)
				end
			end
		end )		
	end
end

function deleteRadio(radio)
	if(getElementData(radio, "isRadio") == true) and isElement(getElementData(radio, "radioClientSound")) then
		stopSound(getElementData(radio, "radioClientSound"))
	end
end

-- Radio
local radioStations = {
	{name="Energy Wien 104.2",url="http://85.10.203.75:8000/vie.m3u"},
	{name="Energy Dance",url="http://radio.nrj.net/dance/radioat"},
	{name="Germany Top 100 Station",url="http://www.top100station.de/switch/top100station_lq.asx"},
	{name="Apres Ski 24/7",url="http://stream.laut.fm/partyundapresski.m3u"},
	{name="Blackbeats.FM", url="http://blackbeats.fm/listen.asx"},	
	{name="TechnoBase.FM", url="http://listen.technobase.fm/aacplus.pls"},
	{name="TranceBase.FM", url="http://listen.trancebase.fm/dsl.pls"},
	{name="HardBase.FM", url="http://listen.hardbase.fm/dsl.pls"},
	{name="Krone Hit", url="http://onair.krone.at/kronehit.mp3.m3u"},
	{name="Krone Hit Vollgas", url="http://onair.krone.at:80/kronehit-vollgas.mp3"},
	{name="Clubsoundz.FM",url="http://193.111.136.213:8000/listen.pls"},
	{name="Rautemusik Punk", url="http://12punks-high.rautemusik.fm/"}, 
	{name="Deutschrap Extreme", url="http://stream2.laut.fm/deutschrapxtreme"},
	{name="Radio Nora 80er", url="http://streams.radionora.de/nora-80er/mp3-128/surfmusik"},
	{name="I <3 RADIO",url="http://www.iloveradio.de/iloveradio.m3u"}
}

local myRadio = nil

RadioGUI_Window = {}
RadioGUI_Button = {}
RadioGUI_Grid = {}
RadioGUI_Column = {}

RadioGUI_Window[1] = guiCreateWindow(screenWidth/2-155,screenHeight/2-202,289,403,"Radio",false)
RadioGUI_Button[1] = guiCreateButton(179,379,101,15,"Schliessen",false,RadioGUI_Window[1])
RadioGUI_Grid[1] = guiCreateGridList(16,33,264,336,false,RadioGUI_Window[1])
guiGridListSetSelectionMode(RadioGUI_Grid[1],2)
RadioGUI_Column[1] = guiGridListAddColumn ( RadioGUI_Grid[1], "Sender", 0.9 )
guiSetVisible( RadioGUI_Window[1], false)
guiWindowSetSizable ( RadioGUI_Window[1], false )

for i,v in ipairs(radioStations) do
	local row = guiGridListAddRow(RadioGUI_Grid[1])
	guiGridListSetItemText ( RadioGUI_Grid[1], row, RadioGUI_Column[1], v.name, false, false )
	guiGridListSetItemData ( RadioGUI_Grid[1], row, RadioGUI_Column[1], v.url)
end

function showRadioGUI(radio)
	if not getElementData(getLocalPlayer(), "isPlayerLoggedIn") == true then return end
	if not getElementData(getLocalPlayer(), "isWaitingForDeath") == false then return end
	myRadio = radio
	guiSetVisible( RadioGUI_Window[1], true)
	showCursor(true)
end

function closeRadioGUI()
	guiSetVisible( RadioGUI_Window[1], false)
	showCursor(false)
end
addEventHandler ( "onClientGUIClick", RadioGUI_Button[1], closeRadioGUI )

function setRadio()
	local selectedRow, selectedCol = guiGridListGetSelectedItem( RadioGUI_Grid[1] )
	local itemtext = guiGridListGetItemText ( RadioGUI_Grid[1], selectedRow, selectedCol )
	local itemdata = guiGridListGetItemData ( RadioGUI_Grid[1], selectedRow, selectedCol )
	outputChatBox("Radiosender: "..itemtext, 0, 255, 0)
	setElementData(myRadio, "radioStream", itemdata)
	closeRadioGUI()
end
addEventHandler( "onClientGUIDoubleClick", RadioGUI_Grid[1], setRadio, false );