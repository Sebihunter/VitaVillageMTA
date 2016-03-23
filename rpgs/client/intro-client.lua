--[[
Project: VitaRP
File: intro-client.lua
Author(s):	Sebihunter
]]--

addEvent("startIntro", true)
addEventHandler("startIntro", getRootElement(), 
	function()
		triggerEvent("openRegisterWindowAfterStory", thePlayer)
	end)
	