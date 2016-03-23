--[[
Project: VitaOnline
File: weather-server.lua
Author(s):	Golf_R32
]]--

local weather =
{
	sunny = { id = {0, 1, 10, 11, 17, 18}, chance = 6, sname = "Sonne" },
	clouds = { id =  {2, 3, 4, 5, 6, 7}, chance = 10, sname = "Bewölkt" },
	fog = { id = {9}, chance = 3, sname = "Nebel" },
	rainy = { id = {8, 16}, chance = 2, sname = "Regen" },
	dull = { id = {12, 13, 14, 15}, chance = 8, sname = "Trüb" },
}

local weather_ = { }
for key, value in pairs( weather ) do
	value.name = key
	for i = 1, ( value.chance or 5 ) do
		table.insert( weather_, value )
	end
end

local function updateWeather( )
	local weather = weather_[ math.random( 1, #weather_ ) ]
	setTimer(function(weather)
		weather = weather.id[ math.random( 1, #weather.id ) ]
		setWeather( weather )
	end, 10 * 60000,1, weather)
	local isOnline = false
	for numb,ply in ipairs(getElementsByType("player")) do
		if getElementData(ply, "job") == 9 and getElementData(ply, "dienst") == 1 then
			isOnline = true
			triggerClientEvent ( ply, "addNotification", getRootElement(), 3, 255,255,0, "Wettervorhersage:\nDas nächste Wetter wird: "..weather.sname.."." )
			outputChatBox ( "Wettervorhersage: Das nächste Wetter wird: "..weather.sname..".", ply, 255, 255, 0, true )	
		end
	end	
	if isOnline == false then
		for i,v in ipairs(getElementsByType("player")) do
			if getElementData(v, "viNetworkMuted") ~= true then
				outputChatBox("[viONAIR] Lilly die Wetterfee: Herzlich Willkommen zur Wettervorhersage.", v, 173,255,47,true)
				outputChatBox("[viONAIR] Lilly die Wetterfee: Das nächste Wetter wird '"..weather.sname.."'.", v, 173,255,47,true)
			end
		end
	end
end

addEventHandler( "onResourceStart", getResourceRootElement(getThisResource()),
	function( )
		updateWeather( )
		setTimer( updateWeather, 20 * 60000, 0 )
	end
)