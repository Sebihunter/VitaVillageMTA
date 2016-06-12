--[[
Project: VitaOnline
File: credits-client.lua
Author(s):	Sebihunter
]]--

local isAtCreditsPoint = 0
local isAtTextPoint = 0
local imageAlpha = 0
local imageAlpha2 = 0
local cameraChange = 0
local cameraChange2 = 0
local vitaCreditsTimer = false
local screenWidth, screenHeight = guiGetScreenSize()

function startVitaCredits()
	showChat ( false )
	addEventHandler ( "onClientRender", getRootElement(), renderVitaCredtis )
	setCreditsStatus(1)
	setWeather ( 10 )
	setTime(12,0)
end
addEvent("startVitaCredits", true)
addEventHandler("startVitaCredits", getRootElement(),startVitaCredits)


function setCreditsStatus(Creditsstatus)
	isAtCreditsPoint = Creditsstatus
	showCursor(false)
	vitaCreditsTimer = false
end

function renderVitaCredtis()
	if isAtCreditsPoint == 1 then
		isAtCreditsPoint = 2
		--playSound("sounds/intro.mp3") DISABLED DUE TO COPYRIGHT
		fadeCamera(true, 2)
		setCameraMatrix(-2518.841796875, 879.728515625, 150.20649719238, -1700.0751953125, 1056.9228515625, 208.40719604492, 0, 180)	-- SF
	elseif isAtCreditsPoint == 2 then
		dxDrawText( "VitaOnline präsentiert...", screenWidth/2 + screenWidth/8 + 1, screenHeight-screenHeight/4 + 1, screenWidth, screenHeight, tocolor ( 0, 0, 0, imageAlpha ), 1, "bankgothic" )
		dxDrawText( "VitaOnline präsentiert...", screenWidth/2 + screenWidth/8, screenHeight-screenHeight/4, screenWidth, screenHeight, tocolor ( 255, 255, 255, imageAlpha ), 1, "bankgothic" )
		if imageAlpha ~= 255 then
			imageAlpha = imageAlpha +5
		end
		if vitaCreditsTimer == false then
			setTimer ( setCreditsStatus, 1836, 1, 3 )
			vitaCreditsTimer = true
		end
	elseif isAtCreditsPoint == 3 then
		dxDrawText( "VitaOnline präsentiert...", screenWidth/2 + screenWidth/8 + 1, screenHeight-screenHeight/4 + 1, screenWidth, screenHeight, tocolor ( 0, 0, 0, imageAlpha ), 1, "bankgothic" )
		dxDrawText( "VitaOnline präsentiert...", screenWidth/2 + screenWidth/8, screenHeight-screenHeight/4, screenWidth, screenHeight, tocolor ( 255, 255, 255, imageAlpha ), 1, "bankgothic" )
		if imageAlpha ~= 0 then
			imageAlpha = imageAlpha -2.5
		end
		if vitaCreditsTimer == false then
			setTimer ( setCreditsStatus, 3672, 1, 4 )
			vitaCreditsTimer = true
		end
	elseif isAtCreditsPoint == 4 then
		dxDrawText( "...ein Vita Gemeinschaftsprojekt", screenWidth/2 + screenWidth/10 + 1, screenHeight-screenHeight/4 + 1, screenWidth, screenHeight, tocolor ( 0, 0, 0, imageAlpha ), 1, "bankgothic" )
		dxDrawText( "...ein Vita Gemeinschaftsprojekt", screenWidth/2 + screenWidth/10, screenHeight-screenHeight/4, screenWidth, screenHeight, tocolor ( 255, 255, 255, imageAlpha ), 1, "bankgothic" )
		if imageAlpha ~= 255 then
			imageAlpha = imageAlpha +5
		end
		if vitaCreditsTimer == false then
			setTimer ( setCreditsStatus, 1836, 1, 5 )
			vitaCreditsTimer = true
		end
	elseif isAtCreditsPoint == 5 then
		dxDrawText( "...ein Vita Gemeinschaftsprojekt", screenWidth/2 + screenWidth/10 + 1, screenHeight-screenHeight/4 + 1, screenWidth, screenHeight, tocolor ( 0, 0, 0, imageAlpha ), 1, "bankgothic" )
		dxDrawText( "...ein Vita Gemeinschaftsprojekt", screenWidth/2 + screenWidth/10, screenHeight-screenHeight/4, screenWidth, screenHeight, tocolor ( 255, 255, 255, imageAlpha ), 1, "bankgothic" )
		if imageAlpha ~= 0 then
			imageAlpha = imageAlpha -2.5
		end
		if vitaCreditsTimer == false then
			setTimer ( setCreditsStatus, 3672, 1, 6 )
			vitaCreditsTimer = true
		end
	elseif isAtCreditsPoint == 6 then
		dxDrawImage ( screenWidth/2 - 296/2, screenHeight/2 - 188/2, 296, 188, 'images/logo.png', 0, 0, 0, tocolor ( 255, 255, 255, imageAlpha ) )
		if imageAlpha ~= 255 then
			imageAlpha = imageAlpha +5
		end
		if vitaCreditsTimer == false then
			setTimer ( setCreditsStatus, 1836, 1, 7 )
			vitaCreditsTimer = true
		end
	elseif isAtCreditsPoint == 7 then
		dxDrawImage ( screenWidth/2 - 296/2, screenHeight/2 - 188/2, 296, 188, 'images/logo.png', 0, 0, 0, tocolor ( 255, 255, 255, imageAlpha ) )
		if imageAlpha ~= 0 then
			imageAlpha = imageAlpha -2.5
		end	
		if vitaCreditsTimer == false then
			setTimer ( setCreditsStatus, 3672, 1, 71 )
			vitaCreditsTimer = true
		end			
	elseif isAtCreditsPoint == 71 then	
		if vitaCreditsTimer == false then
			fadeCamera(false, 1, 0, 0, 0)
			setTimer ( setCreditsStatus, 1000, 1, 8 )
			vitaCreditsTimer = true
		end	
		elseif isAtCreditsPoint == 8 then	
			setCameraMatrix(1468.8785400391, -919.25317382813, 100.153465271, 1468.388671875, -918.42474365234, 99.881813049316)
			fadeCamera(true, 3, 0, 0, 0)
			isAtCreditsPoint = 9
			setTimer ( setCreditsStatus, 7000, 1, 10 )
			vitaCreditsTimer = true
		elseif isAtCreditsPoint == 9 then
			setCameraMatrix(1468.8785400391+cameraChange, -919.25317382813, 100.153465271, 1468.388671875+cameraChange, -918.42474365234, 99.881813049316)
			cameraChange = cameraChange + 0.15
			if imageAlpha ~= 255 then
				imageAlpha = imageAlpha+5
			else
				if imageAlpha2 ~= 255 then
					imageAlpha2 = imageAlpha2+5
				end
			end
			dxDrawText( "Projektleitung", screenWidth/2 - screenWidth/2.5 + 1, screenHeight/3 + 1, screenWidth, screenHeight, tocolor ( 0, 0, 0, imageAlpha ), 1, "bankgothic" )
			dxDrawText( "Projektleitung", screenWidth/2 - screenWidth/2.5, screenHeight/3, screenWidth, screenHeight, tocolor ( 255, 255, 255, imageAlpha ), 1, "bankgothic" )
			dxDrawText( "Sebastian 'Sebihunter' M.\nSilvio 'SickStar' S.\nRené 'Adlerauge' N.", screenWidth/2 - screenWidth/2.5 + 1, screenHeight/3 + 1 + 25, screenWidth, screenHeight, tocolor ( 0, 0, 0, imageAlpha2 ), 0.8, "bankgothic" )
			dxDrawText( "Sebastian 'Sebihunter' M.\nSilvio 'SickStar' S.\nRené 'Adlerauge' N.", screenWidth/2 - screenWidth/2.5, screenHeight/3 + 25, screenWidth, screenHeight, tocolor ( 200, 200, 200, imageAlpha2 ), 0.8, "bankgothic" )			
		elseif isAtCreditsPoint == 10 then
			setCameraMatrix(1468.8785400391+cameraChange, -919.25317382813, 100.153465271, 1468.388671875+cameraChange, -918.42474365234, 99.881813049316)
			cameraChange = cameraChange + 0.15
			if imageAlpha ~= 0 then
				imageAlpha2 = imageAlpha2-2.5
				imageAlpha = imageAlpha-2.5
			end
			if vitaCreditsTimer == false then
				setTimer ( setCreditsStatus, 3672, 1, 11 )
				vitaCreditsTimer = true
			end
		dxDrawText( "Projektleitung", screenWidth/2 - screenWidth/2.5 + 1, screenHeight/3 + 1, screenWidth, screenHeight, tocolor ( 0, 0, 0, imageAlpha ), 1, "bankgothic" )
		dxDrawText( "Projektleitung", screenWidth/2 - screenWidth/2.5, screenHeight/3, screenWidth, screenHeight, tocolor ( 255, 255, 255, imageAlpha ), 1, "bankgothic" )
		dxDrawText( "Sebastian 'Sebihunter' M.\nSilvio 'SickStar' S.\nRené 'Adlerauge' N.", screenWidth/2 - screenWidth/2.5 + 1, screenHeight/3 + 1 + 25, screenWidth, screenHeight, tocolor ( 0, 0, 0, imageAlpha2 ), 0.8, "bankgothic" )
		dxDrawText( "Sebastian 'Sebihunter' M.\nSilvio 'SickStar' S.\nRené 'Adlerauge' N.", screenWidth/2 - screenWidth/2.5, screenHeight/3 + 25, screenWidth, screenHeight, tocolor ( 200, 200, 200, imageAlpha2 ), 0.8, "bankgothic" )				
	elseif isAtCreditsPoint == 11 then
		if vitaCreditsTimer == false then
			setTimer ( setCreditsStatus, 7000, 1, 12 )
			vitaCreditsTimer = true
		end
		setCameraMatrix(1468.8785400391+cameraChange, -919.25317382813, 100.153465271, 1468.388671875+cameraChange, -918.42474365234, 99.881813049316)
		cameraChange = cameraChange + 0.15
		if imageAlpha ~= 255 then
			imageAlpha = imageAlpha+5
		else
			if imageAlpha2 ~= 255 then
				imageAlpha2 = imageAlpha2+5
			end
		end
		dxDrawText( "Script Entwicklung", screenWidth/2 + screenWidth/6 + 1, screenHeight-screenHeight/3 + 1, screenWidth, screenHeight, tocolor ( 0, 0, 0, imageAlpha ), 1, "bankgothic" )
		dxDrawText( "Script Entwicklung", screenWidth/2 + screenWidth/6, screenHeight-screenHeight/3, screenWidth, screenHeight, tocolor ( 255, 255, 255, imageAlpha ), 1, "bankgothic" )
		dxDrawText( "Sebastian 'Sebihunter' M.\nAlex 'Lexlo' B.\nPascal 'sbx320' S.\nPascal 'CubedDeath' S.\nThomas 'Tommi' W.", screenWidth/2 + screenWidth/6 + 1, screenHeight-screenHeight/3 + 1 + 25, screenWidth, screenHeight, tocolor ( 0, 0, 0, imageAlpha2 ), 0.8, "bankgothic" )
		dxDrawText( "Sebastian 'Sebihunter' M.\nAlex 'Lexlo' B.\nPascal 'sbx320' S.\nPascal 'CubedDeath' S.\nThomas 'Tommi' W.", screenWidth/2 + screenWidth/6, screenHeight-screenHeight/3 + 25, screenWidth, screenHeight, tocolor ( 200, 200, 200, imageAlpha2 ), 0.8, "bankgothic" )
	elseif isAtCreditsPoint == 12 then
		
		setCameraMatrix(1468.8785400391+cameraChange, -919.25317382813, 100.153465271, 1468.388671875+cameraChange, -918.42474365234, 99.881813049316)
		cameraChange = cameraChange + 0.15
		if imageAlpha ~= 0 then
			imageAlpha2 = imageAlpha2-2.5
			imageAlpha = imageAlpha-2.5
		else
			isAtCreditsPoint = 13
		end
		dxDrawText( "Script Entwicklung", screenWidth/2 + screenWidth/6 + 1, screenHeight-screenHeight/3 + 1, screenWidth, screenHeight, tocolor ( 0, 0, 0, imageAlpha ), 1, "bankgothic" )
		dxDrawText( "Script Entwicklung", screenWidth/2 + screenWidth/6, screenHeight-screenHeight/3, screenWidth, screenHeight, tocolor ( 255, 255, 255, imageAlpha ), 1, "bankgothic" )
		dxDrawText( "Sebastian 'Sebihunter' M.\nAlex 'Lexlo' B.\nPascal 'sbx320' S.\nPascal 'CubedDeath' S.\nThomas 'Tommi' W.", screenWidth/2 + screenWidth/6 + 1, screenHeight-screenHeight/3 + 1 + 25, screenWidth, screenHeight, tocolor ( 0, 0, 0, imageAlpha2 ), 0.8, "bankgothic" )
		dxDrawText( "Sebastian 'Sebihunter' M.\nAlex 'Lexlo' B.\nPascal 'sbx320' S.\nPascal 'CubedDeath' S.\nThomas 'Tommi' W.", screenWidth/2 + screenWidth/6, screenHeight-screenHeight/3 + 25, screenWidth, screenHeight, tocolor ( 200, 200, 200, imageAlpha2 ), 0.8, "bankgothic" )			
	elseif isAtCreditsPoint == 13 then
		if vitaCreditsTimer == false then
			setTimer ( setCreditsStatus, 7000, 1, 14 )
			vitaCreditsTimer = true
		end		
		setCameraMatrix(1468.8785400391+cameraChange, -919.25317382813, 100.153465271, 1468.388671875+cameraChange, -918.42474365234, 99.881813049316)
		cameraChange = cameraChange + 0.15
		if imageAlpha ~= 255 then
			imageAlpha = imageAlpha+5
		else
			if imageAlpha2 ~= 255 then
				imageAlpha2 = imageAlpha2+5
			end
		end
		dxDrawText( "Spielkonzept", screenWidth/2 - screenWidth/2.5 + 1, screenHeight/3 + 1, screenWidth, screenHeight, tocolor ( 0, 0, 0, imageAlpha ), 1, "bankgothic" )
		dxDrawText( "Spielkonzept", screenWidth/2 - screenWidth/2.5, screenHeight/3, screenWidth, screenHeight, tocolor ( 255, 255, 255, imageAlpha ), 1, "bankgothic" )
		dxDrawText( "Sebastian 'Sebihunter' M.\nBenedikt 'Tjong' A.\nSilvio 'SickStar' S.\nDaniel 'Sense' B.", screenWidth/2 - screenWidth/2.5 + 1, screenHeight/3 + 25 + 1, screenWidth, screenHeight, tocolor ( 0, 0, 0, imageAlpha2 ), 0.8, "bankgothic" )
		dxDrawText( "Sebastian 'Sebihunter' M.\nBenedikt 'Tjong' A.\nSilvio 'SickStar' S.\nDaniel 'Sense' B.", screenWidth/2 - screenWidth/2.5, screenHeight/3 + 25, screenWidth, screenHeight, tocolor ( 200, 200, 200, imageAlpha2 ), 0.8, "bankgothic" )
	elseif isAtCreditsPoint == 14 then
		
		setCameraMatrix(1468.8785400391+cameraChange, -919.25317382813, 100.153465271, 1468.388671875+cameraChange, -918.42474365234, 99.881813049316)
		cameraChange = cameraChange + 0.15
		if imageAlpha ~= 0 then
			imageAlpha2 = imageAlpha2-2.5
			imageAlpha = imageAlpha-2.5
		end
		if vitaCreditsTimer == false then
			setTimer ( setCreditsStatus, 3672, 1, 15 )
			vitaCreditsTimer = true
		end
		dxDrawText( "Spielkonzept", screenWidth/2 - screenWidth/2.5 + 1, screenHeight/3 + 1, screenWidth, screenHeight, tocolor ( 0, 0, 0, imageAlpha ), 1, "bankgothic" )
		dxDrawText( "Spielkonzept", screenWidth/2 - screenWidth/2.5, screenHeight/3, screenWidth, screenHeight, tocolor ( 255, 255, 255, imageAlpha ), 1, "bankgothic" )
		dxDrawText( "Sebastian 'Sebihunter' M.\nBenedikt 'Tjong' A.\nSilvio 'SickStar' S.\nDaniel 'Sense' B.", screenWidth/2 - screenWidth/2.5 +1, screenHeight/3 + 25 +1, screenWidth, screenHeight, tocolor ( 0, 0, 0, imageAlpha2 ), 0.8, "bankgothic" )
		dxDrawText( "Sebastian 'Sebihunter' M.\nBenedikt 'Tjong' A.\nSilvio 'SickStar' S.\nDaniel 'Sense' B.", screenWidth/2 - screenWidth/2.5, screenHeight/3 + 25, screenWidth, screenHeight, tocolor ( 200, 200, 200, imageAlpha2 ), 0.8, "bankgothic" )		
	elseif isAtCreditsPoint == 15 then
		if vitaCreditsTimer == false then
			setTimer ( setCreditsStatus, 7000, 1, 16 )
			vitaCreditsTimer = true
		end		
		setCameraMatrix(1468.8785400391+cameraChange, -919.25317382813, 100.153465271, 1468.388671875+cameraChange, -918.42474365234, 99.881813049316)
		cameraChange = cameraChange + 0.15
		if imageAlpha ~= 255 then
			imageAlpha = imageAlpha+5
		else
			if imageAlpha2 ~= 255 then
				imageAlpha2 = imageAlpha2+5
			end
		end
		dxDrawText( "Mapping", screenWidth/2 + screenWidth/6 + 1, screenHeight-screenHeight/3 + 1, screenWidth, screenHeight, tocolor ( 0, 0, 0, imageAlpha ), 1, "bankgothic" )
		dxDrawText( "Mapping", screenWidth/2 + screenWidth/6, screenHeight-screenHeight/3, screenWidth, screenHeight, tocolor ( 255, 255, 255, imageAlpha ), 1, "bankgothic" )
		dxDrawText( "Norman 'flash2go' W.\nMatthias 'MatzeGam1ngTv' K.\nSebastian 'Hustla' D.\nDavid 'Cartmen' B.\nRobert 'DozZ' T.\nMarcus 'Schlumpf' B.", screenWidth/2 + screenWidth/6 + 1, screenHeight-screenHeight/3 + 1 + 25, screenWidth, screenHeight, tocolor ( 0, 0, 0, imageAlpha2 ), 0.8, "bankgothic" )
		dxDrawText( "Norman 'flash2go' W.\nMatthias 'MatzeGam1ngTv' K.\nSebastian 'Hustla' D.\nDavid 'Cartmen' B.\nRobert 'DozZ' T.\nMarcus 'Schlumpf' B.", screenWidth/2 + screenWidth/6, screenHeight-screenHeight/3 + 25, screenWidth, screenHeight, tocolor ( 200, 200, 200, imageAlpha2 ), 0.8, "bankgothic" )
	elseif isAtCreditsPoint == 16 then
		
		setCameraMatrix(1468.8785400391+cameraChange, -919.25317382813, 100.153465271, 1468.388671875+cameraChange, -918.42474365234, 99.881813049316)
		cameraChange = cameraChange + 0.15
		if imageAlpha ~= 0 then
			imageAlpha2 = imageAlpha2-2.5
			imageAlpha = imageAlpha-2.5
		end
		if vitaCreditsTimer == false then
			setTimer ( setCreditsStatus, 3672, 1, 161 )
			vitaCreditsTimer = true
		end
		dxDrawText( "Mapping", screenWidth/2 + screenWidth/6 + 1, screenHeight-screenHeight/3 + 1, screenWidth, screenHeight, tocolor ( 0, 0, 0, imageAlpha ), 1, "bankgothic" )
		dxDrawText( "Mapping", screenWidth/2 + screenWidth/6, screenHeight-screenHeight/3, screenWidth, screenHeight, tocolor ( 255, 255, 255, imageAlpha ), 1, "bankgothic" )
		dxDrawText( "Norman 'flash2go' W.\nMatthias 'MatzeGam1ngTv' K.\nSebastian 'Hustla' D.\nDavid 'Cartmen' B.\nRobert 'DozZ' T.\nMarcus 'Schlumpf' B.", screenWidth/2 + screenWidth/6 + 1, screenHeight-screenHeight/3 + 1 + 25, screenWidth, screenHeight, tocolor ( 0, 0, 0, imageAlpha2 ), 0.8, "bankgothic" )
		dxDrawText( "Norman 'flash2go' W.\nMatthias 'MatzeGam1ngTv' K.\nSebastian 'Hustla' D.\nDavid 'Cartmen' B.\nRobert 'DozZ' T.\nMarcus 'Schlumpf' B.", screenWidth/2 + screenWidth/6, screenHeight-screenHeight/3 + 25, screenWidth, screenHeight, tocolor ( 200, 200, 200, imageAlpha2 ), 0.8, "bankgothic" )	
		elseif isAtCreditsPoint == 161 then
			if vitaCreditsTimer == false then
				isAtCreditsPoint = 17
				fadeCamera(false, 1, 0, 0, 0)
				vitaCreditsTimer = true
				setTimer ( setCreditsStatus, 1000, 1, 18 )
			end
		elseif isAtCreditsPoint == 17 then
			setCameraMatrix(1468.8785400391+cameraChange, -919.25317382813, 100.153465271, 1468.388671875+cameraChange, -918.42474365234, 99.881813049316)
			cameraChange = cameraChange + 0.15		
		elseif isAtCreditsPoint == 18 then
			cameraChange = 0
			imageAlpha2 = 0
			imageAlpha = 0
			setCameraMatrix(-2681.8708496094, 1920.7674560547, 181.23147583008, -2681.8708496094, 1900.7674560547, 183.23147583008)
			fadeCamera(true, 3, 0, 0, 0)
			isAtCreditsPoint = 19
		elseif isAtCreditsPoint == 19 then
			if vitaCreditsTimer == false then
				setTimer ( setCreditsStatus, 6000, 1, 20 )
				vitaCreditsTimer = true
			end		
			cameraChange = cameraChange + 0.08
			setCameraMatrix(-2681.8708496094, 1920.7674560547, 181.23147583008-cameraChange, -2681.8708496094, 1900.7674560547, 183.23147583008-cameraChange)
			if imageAlpha ~= 255 then
				imageAlpha = imageAlpha+5
			else
				if imageAlpha2 ~= 255 then
					imageAlpha2 = imageAlpha2+5
				end
			end
			dxDrawText( "Grafikdesign", screenWidth/2 - screenWidth/2.5 + 1, screenHeight/3 + 1, screenWidth, screenHeight, tocolor ( 0, 0, 0, imageAlpha ), 1, "bankgothic" )
			dxDrawText( "Grafikdesign", screenWidth/2 - screenWidth/2.5, screenHeight/3, screenWidth, screenHeight, tocolor ( 255, 255, 255, imageAlpha ), 1, "bankgothic" )
			dxDrawText( "Sebastian 'Sebihunter' M.\nNorman 'flash2go' W.\nAlex 'ReZ' B.", screenWidth/2 - screenWidth/2.5 + 1, screenHeight/3 + 1 + 25, screenWidth, screenHeight, tocolor ( 0, 0, 0, imageAlpha2 ), 0.8, "bankgothic" )
			dxDrawText( "Sebastian 'Sebihunter' M.\nNorman 'flash2go' W.\nAlex 'ReZ' B.", screenWidth/2 - screenWidth/2.5, screenHeight/3 + 25, screenWidth, screenHeight, tocolor ( 200, 200, 200, imageAlpha2 ), 0.8, "bankgothic" )	
	elseif isAtCreditsPoint == 20 then
		
		setCameraMatrix(-2681.8708496094, 1920.7674560547, 181.23147583008-cameraChange, -2681.8708496094, 1900.7674560547, 183.23147583008-cameraChange)
		cameraChange = cameraChange + 0.08
		if imageAlpha ~= 0 then
			imageAlpha2 = imageAlpha2-2.5
			imageAlpha = imageAlpha-2.5
		end	
		if vitaCreditsTimer == false then
			setTimer ( setCreditsStatus, 3672, 1, 21 )
			vitaCreditsTimer = true
		end
			dxDrawText( "Grafikdesign", screenWidth/2 - screenWidth/2.5 + 1, screenHeight/3 + 1, screenWidth, screenHeight, tocolor ( 0, 0, 0, imageAlpha ), 1, "bankgothic" )
			dxDrawText( "Grafikdesign", screenWidth/2 - screenWidth/2.5, screenHeight/3, screenWidth, screenHeight, tocolor ( 255, 255, 255, imageAlpha ), 1, "bankgothic" )
			dxDrawText( "Sebastian 'Sebihunter' M.\nNorman 'flash2go' W.\nAlex 'ReZ' B.", screenWidth/2 - screenWidth/2.5 + 1, screenHeight/3 + 1 + 25, screenWidth, screenHeight, tocolor ( 0, 0, 0, imageAlpha2 ), 0.8, "bankgothic" )
			dxDrawText( "Sebastian 'Sebihunter' M.\nNorman 'flash2go' W.\nAlex 'ReZ' B.", screenWidth/2 - screenWidth/2.5, screenHeight/3 + 25, screenWidth, screenHeight, tocolor ( 200, 200, 200, imageAlpha2 ), 0.8, "bankgothic" )		
		elseif isAtCreditsPoint == 21 then
			if vitaCreditsTimer == false then
				setTimer ( setCreditsStatus, 5000, 1, 22 )
				vitaCreditsTimer = true
			end		
			cameraChange = cameraChange + 0.08	
			setCameraMatrix(-2681.8708496094, 1920.7674560547, 181.23147583008-cameraChange, -2681.8708496094, 1900.7674560547, 183.23147583008-cameraChange)
			if imageAlpha ~= 255 then
				imageAlpha = imageAlpha+5
			else
				if imageAlpha2 ~= 255 then
					imageAlpha2 = imageAlpha2+5
				end
			end
		dxDrawText( "Serververwaltung", screenWidth/2 + screenWidth/6 + 1, screenHeight-screenHeight/3 + 1, screenWidth, screenHeight, tocolor ( 0, 0, 0, imageAlpha ), 1, "bankgothic" )
		dxDrawText( "Serververwaltung", screenWidth/2 + screenWidth/6, screenHeight-screenHeight/3, screenWidth, screenHeight, tocolor ( 255, 255, 255, imageAlpha ), 1, "bankgothic" )
		dxDrawText( "Silvio 'SickStar' S.\nRené 'Adlerauge' N.", screenWidth/2 + screenWidth/6 + 1, screenHeight-screenHeight/3 + 1 + 25, screenWidth, screenHeight, tocolor ( 0, 0, 0, imageAlpha2 ), 0.8, "bankgothic" )
		dxDrawText( "Silvio 'SickStar' S.\nRené 'Adlerauge' N.", screenWidth/2 + screenWidth/6, screenHeight-screenHeight/3 + 25, screenWidth, screenHeight, tocolor ( 200, 200, 200, imageAlpha2 ), 0.8, "bankgothic" )		
	elseif isAtCreditsPoint == 22 then
		
		setCameraMatrix(-2681.8708496094, 1920.7674560547, 181.23147583008-cameraChange, -2681.8708496094, 1900.7674560547, 183.23147583008-cameraChange)
		cameraChange = cameraChange + 0.08
		if imageAlpha ~= 0 then
			imageAlpha2 = imageAlpha2-2.5
			imageAlpha = imageAlpha-2.5
		end	
		if vitaCreditsTimer == false then
			setTimer ( setCreditsStatus, 3672, 1, 23 )
			vitaCreditsTimer = true
		end
		dxDrawText( "Serververwaltung", screenWidth/2 + screenWidth/6 + 1, screenHeight-screenHeight/3 + 1, screenWidth, screenHeight, tocolor ( 0, 0, 0, imageAlpha ), 1, "bankgothic" )
		dxDrawText( "Serververwaltung", screenWidth/2 + screenWidth/6, screenHeight-screenHeight/3, screenWidth, screenHeight, tocolor ( 255, 255, 255, imageAlpha ), 1, "bankgothic" )
		dxDrawText( "Silvio 'SickStar' S.\nRené 'Adlerauge' N.", screenWidth/2 + screenWidth/6 + 1, screenHeight-screenHeight/3 + 1 + 25, screenWidth, screenHeight, tocolor ( 0, 0, 0, imageAlpha2 ), 0.8, "bankgothic" )
		dxDrawText( "Silvio 'SickStar' S.\nRené 'Adlerauge' N.", screenWidth/2 + screenWidth/6, screenHeight-screenHeight/3 + 25, screenWidth, screenHeight, tocolor ( 200, 200, 200, imageAlpha2 ), 0.8, "bankgothic" )				
		elseif isAtCreditsPoint == 23 then
			if vitaCreditsTimer == false then
				setTimer ( setCreditsStatus, 5000, 1, 24 )
				vitaCreditsTimer = true
			end		
			cameraChange = cameraChange + 0.08	
			setCameraMatrix(-2681.8708496094, 1920.7674560547, 181.23147583008-cameraChange, -2681.8708496094, 1900.7674560547, 183.23147583008-cameraChange)
			if imageAlpha ~= 255 then
				imageAlpha = imageAlpha+5
			else
				if imageAlpha2 ~= 255 then
					imageAlpha2 = imageAlpha2+5
				end
			end
			dxDrawText( "Web Entwicklung", screenWidth/2 - screenWidth/2.5 + 1, screenHeight/3 + 1, screenWidth, screenHeight, tocolor ( 0, 0, 0, imageAlpha ), 1, "bankgothic" )
			dxDrawText( "Web Entwicklung", screenWidth/2 - screenWidth/2.5, screenHeight/3, screenWidth, screenHeight, tocolor ( 255, 255, 255, imageAlpha ), 1, "bankgothic" )
			dxDrawText( "Sebastian 'Sebihunter' M.", screenWidth/2 - screenWidth/2.5 + 1, screenHeight/3 + 1 + 25, screenWidth, screenHeight, tocolor ( 0, 0, 0, imageAlpha2 ), 0.8, "bankgothic" )
			dxDrawText( "Sebastian 'Sebihunter' M.", screenWidth/2 - screenWidth/2.5, screenHeight/3 + 25, screenWidth, screenHeight, tocolor ( 200, 200, 200, imageAlpha2 ), 0.8, "bankgothic" )	
	elseif isAtCreditsPoint == 24 then
		
		setCameraMatrix(-2681.8708496094, 1920.7674560547, 181.23147583008-cameraChange, -2681.8708496094, 1900.7674560547, 183.23147583008-cameraChange)
		cameraChange = cameraChange + 0.08
		if imageAlpha ~= 0 then
			imageAlpha2 = imageAlpha2-5
			imageAlpha = imageAlpha-5
		end
		if vitaCreditsTimer == false then
			isAtCreditsPoint = 25
			fadeCamera(false, 1, 0, 0, 0)
			setTimer ( setCreditsStatus, 1868, 1, 26 )
			vitaCreditsTimer = true
		end		
			dxDrawText( "Web Entwicklung", screenWidth/2 - screenWidth/2.5 + 1, screenHeight/3 + 1, screenWidth, screenHeight, tocolor ( 0, 0, 0, imageAlpha ), 1, "bankgothic" )
			dxDrawText( "Web Entwicklung", screenWidth/2 - screenWidth/2.5, screenHeight/3, screenWidth, screenHeight, tocolor ( 255, 255, 255, imageAlpha ), 1, "bankgothic" )
			dxDrawText( "Sebastian 'Sebihunter' M.", screenWidth/2 - screenWidth/2.5 + 1, screenHeight/3 + 1 + 25, screenWidth, screenHeight, tocolor ( 0, 0, 0, imageAlpha2 ), 0.8, "bankgothic" )
			dxDrawText( "Sebastian 'Sebihunter' M.", screenWidth/2 - screenWidth/2.5, screenHeight/3 + 25, screenWidth, screenHeight, tocolor ( 200, 200, 200, imageAlpha2 ), 0.8, "bankgothic" )					
	elseif isAtCreditsPoint == 25 then	
		setCameraMatrix(-2681.8708496094, 1920.7674560547, 181.23147583008-cameraChange, -2681.8708496094, 1900.7674560547, 183.23147583008-cameraChange)
		cameraChange = cameraChange + 0.08	
	elseif isAtCreditsPoint == 26 then
		cameraChange = 0
		imageAlpha2 = 0
		imageAlpha = 0
		setCameraMatrix(-2134.8439941406, 648.99450683594, 58.182228088379, -2190.6123046875, 565.98913574219, 48.198886871338)
		fadeCamera(true, 3, 0, 0, 0)
		isAtCreditsPoint = 27			
	elseif isAtCreditsPoint == 27 then
		cameraChange = cameraChange+0.02
		setCameraMatrix(-2134.8439941406-cameraChange, 648.99450683594-cameraChange, 58.182228088379, -2190.6123046875-cameraChange, 565.98913574219-cameraChange, 48.198886871338)
		if vitaCreditsTimer == false then
			setTimer ( setCreditsStatus, 7000, 1, 28 )
			vitaCreditsTimer = true
		end		
		if imageAlpha ~= 255 then
			imageAlpha = imageAlpha+5
		else
			if imageAlpha2 ~= 255 then
				imageAlpha2 = imageAlpha2+5
				end
		end
			dxDrawText( "Danke an", screenWidth/2 - screenWidth/2.5 + 1, screenHeight/3 + 1, screenWidth, screenHeight, tocolor ( 0, 0, 0, imageAlpha ), 1, "bankgothic" )
			dxDrawText( "Danke an", screenWidth/2 - screenWidth/2.5, screenHeight/3, screenWidth, screenHeight, tocolor ( 255, 255, 255, imageAlpha ), 1, "bankgothic" )
			dxDrawText( "x86\nNeon\nTjong\nEinstein\nWerni\nryden\nmabako\nFrankZZ\nNitaco\nSense", screenWidth/2 - screenWidth/2.5 + 1, screenHeight/3 + 1 + 25, screenWidth, screenHeight, tocolor ( 0, 0, 0, imageAlpha2 ), 0.8, "bankgothic" )
			dxDrawText( "x86\nNeon\nTjong\nEinstein\nWerni\nryden\nmabako\nFrankZZ\nNitaco\nSense", screenWidth/2 - screenWidth/2.5, screenHeight/3 + 25, screenWidth, screenHeight, tocolor ( 200, 200, 200, imageAlpha2 ), 0.8, "bankgothic" )		
	elseif isAtCreditsPoint == 28 then
	
		cameraChange = cameraChange + 0.02
		setCameraMatrix(-2134.8439941406-cameraChange, 648.99450683594-cameraChange, 58.182228088379, -2190.6123046875-cameraChange, 565.98913574219-cameraChange, 48.198886871338)
		if imageAlpha ~= 0 then
			imageAlpha2 = imageAlpha2-2.5
				imageAlpha = imageAlpha-2.5
		else
			isAtCreditsPoint = 29
			setTimer ( setCreditsStatus, 18500, 1, 30 )
			setTimer ( setCreditsStatus, 22500, 1, 31 )
			setTimer ( setCreditsStatus, 28500, 1, 32 )
			setTimer ( setCreditsStatus, 34000, 1, 33 )
			vitaCreditsTimer = true
		end
			dxDrawText( "Danke an", screenWidth/2 - screenWidth/2.5 + 1, screenHeight/3 + 1, screenWidth, screenHeight, tocolor ( 0, 0, 0, imageAlpha ), 1, "bankgothic" )
			dxDrawText( "Danke an", screenWidth/2 - screenWidth/2.5, screenHeight/3, screenWidth, screenHeight, tocolor ( 255, 255, 255, imageAlpha ), 1, "bankgothic" )
			dxDrawText( "x86\nNeon\nTjong\nEinstein\nWerni\nryden\nmabako\nFrankZZ\nNitaco\nSense", screenWidth/2 - screenWidth/2.5 + 1, screenHeight/3 + 1 + 25, screenWidth, screenHeight, tocolor ( 0, 0, 0, imageAlpha2 ), 0.8, "bankgothic" )
			dxDrawText( "x86\nNeon\nTjong\nEinstein\nWerni\nryden\nmabako\nFrankZZ\nNitaco\nSense", screenWidth/2 - screenWidth/2.5, screenHeight/3 + 25, screenWidth, screenHeight, tocolor ( 200, 200, 200, imageAlpha2 ), 0.8, "bankgothic" )				
	elseif isAtCreditsPoint == 29 then
		cameraChange2 = cameraChange2 + 0.1
		setCameraMatrix(-2134.8439941406-cameraChange, 648.99450683594-cameraChange, 58.182228088379+cameraChange2, -2190.6123046875-cameraChange, 565.98913574219-cameraChange, 48.198886871338+cameraChange2)	
	elseif isAtCreditsPoint == 30 then
		setCameraMatrix(-2134.8439941406-cameraChange, 648.99450683594-cameraChange, 58.182228088379+cameraChange2, -2190.6123046875-cameraChange, 565.98913574219-cameraChange, 48.198886871338+cameraChange2)	
		dxDrawImage ( screenWidth/2 - 296/2, screenHeight/2 - 188/2, 296, 188, 'images/logo.png', 0, 0, 0, tocolor ( 255, 255, 255, imageAlpha ) )
		if imageAlpha ~= 255 then
			imageAlpha = imageAlpha +5
		end	
	elseif isAtCreditsPoint == 31 then
		setCameraMatrix(-2134.8439941406-cameraChange, 648.99450683594-cameraChange, 58.182228088379+cameraChange2, -2190.6123046875-cameraChange, 565.98913574219-cameraChange, 48.198886871338+cameraChange2)	
		dxDrawImage ( screenWidth/2 - 296/2, screenHeight/2 - 188/2, 296, 188, 'images/logo.png', 0, 0, 0, tocolor ( 255, 255, 255, imageAlpha ) )
		fadeCamera(false, 2, 0, 0, 0)
	elseif isAtCreditsPoint == 32 then
		dxDrawImage ( screenWidth/2 - 296/2, screenHeight/2 - 188/2, 296, 188, 'images/logo.png', 0, 0, 0, tocolor ( 255, 255, 255, imageAlpha ) )
		if imageAlpha ~= 0 and imageAlpha > 0 then
			imageAlpha = imageAlpha-2.5
		else
			imageAlpha = 0
		end
	elseif isAtCreditsPoint == 33 then	
		setElementInterior(getLocalPlayer(), 0)
		isAtCreditsPoint = false
		removeEventHandler ( "onClientRender", getRootElement(), renderVitaCredtis )
		triggerEvent("startStoryPart2", getLocalPlayer(), getLocalPlayer())
	end					
end