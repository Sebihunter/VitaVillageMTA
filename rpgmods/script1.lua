screenWidth, screenHeight = guiGetScreenSize()
webBrowser = createBrowser(screenWidth, screenHeight, true, true)

if getElementData(getLocalPlayer(), "isPlayerLoggedIn") ~= true then
	elevatorMusic = playSound ( "http://vita-village.de/elevator_music.mp3", true )
end

gReplace = {}
downloadTable = false
allDownload = false
lTimer = false

function webBrowserRender()
	if getElementData(getLocalPlayer(), "isPlayerLoggedIn") ~= true then
		dxDrawImage(0, 0, screenWidth, screenHeight, webBrowser, 0, 0, 0, tocolor(255,255,255,255), false)
	else
		dxDrawText ( "Resourcen (Maps, Mods, etc.) werden geladen...", 0, screenHeight-100, screenWidth, screenHeight, tocolor(255,255,255,255), 3, "default-bold", "center")
	end
end
 
addEventHandler("onClientBrowserCreated", webBrowser, 
	function()
		loadBrowserURL(webBrowser, "http://mta/local/html/vita.html")
		addEventHandler("onClientRender",getRootElement(), webBrowserRender, true, "low-8844")
	end
)

function onClientResourceStart()
	triggerServerEvent("grabDownload", getLocalPlayer())
end
addEventHandler("onClientResourceStart", resourceRoot, onClientResourceStart)

function receiveFirst(data, left)

	local dataBack = {}
	for i,v in ipairs(left) do
		if fileExists(v) then 
			local file = fileOpen(v)
			local fileSize = fileGetSize(file)
			fileClose(file)	
			dataBack[i] = fileSize
		end
	end
	triggerServerEvent("checkFileSizes", getLocalPlayer(), dataBack)
	
	gReplace = data
end
addEvent("receiveFirst", true)
addEventHandler("receiveFirst", getRootElement(), receiveFirst)

function receiveSecond(left)
	downloadTable = left
	allDownload = #left
	downloadNextFile()
end
addEvent("receiveSecond", true)
addEventHandler("receiveSecond", getRootElement(), receiveSecond)

function downloadNextFile()
	if downloadTable and #downloadTable ~= 0 then
		local progress = (1-#downloadTable/allDownload)*100
		
		local downloadFile = downloadTable[1]
		executeBrowserJavascript ( webBrowser, "setDownloadText('Daten werden geladen... ("..tostring(downloadFile)..")'); setProgressBar('"..progress.."');" )	
		local fileSize = 0
		if fileExists(downloadTable[1]) then 
			local file = fileOpen(downloadTable[1])
			fileSize = fileGetSize(file)
			fileClose(file)
		end
		triggerServerEvent("requestFile", getLocalPlayer(), downloadTable[1], fileSize)
	else
		executeBrowserJavascript ( webBrowser, "setDownloadText('Spieldaten werden initialisiert...'); setProgressBar('100');" )	
		onClientResourceStartVita()
		applyBreakableState()
		if elevatorMusic then stopSound(elevatorMusic) end
	end
end

addEvent("receiveFile", true)
addEventHandler("receiveFile", getRootElement(),
	function (file, fileData)
		if fileData ~= "piemel" then
			if string.find(file, ".map") then
				local newFile = fileCreate(file)
				fileWrite(newFile, fileData)		
				fileClose(newFile)
				local mapfile = xmlLoadFile ( file )
				if mapfile then
					local i2 = 0	
					while true do
						local mapfilenode = xmlFindChild ( mapfile, "object", i2)
						if not mapfilenode then
							break
						else
				
							local modelID = tonumber(xmlNodeGetAttribute(mapfilenode, "model"))
							local interiorID = tonumber(xmlNodeGetAttribute(mapfilenode, "interior"))
							local posX = tonumber(xmlNodeGetAttribute(mapfilenode, "posX"))
							local posY = tonumber(xmlNodeGetAttribute(mapfilenode, "posY"))
							local posZ = tonumber(xmlNodeGetAttribute(mapfilenode, "posZ"))
							local rotX = tonumber(xmlNodeGetAttribute(mapfilenode, "rotX"))
							local rotY = tonumber(xmlNodeGetAttribute(mapfilenode, "rotY"))
							local rotZ = tonumber(xmlNodeGetAttribute(mapfilenode, "rotZ"))
							local doublesided = xmlNodeGetAttribute(mapfilenode, "doublesided")
							local scale = (xmlNodeGetAttribute(mapfilenode, "scale") or 1.0)
							local alpha = (xmlNodeGetAttribute(mapfilenode, "alpha") or 255)	
							local collisions = (xmlNodeGetAttribute(mapfilenode, "collisions") or "true")
							local dim = tonumber(xmlNodeGetAttribute(mapfilenode, "dimension"))
							
							local object = createObject(modelID, posX, posY, posZ, rotX, rotY, rotZ)
								
							if interiorID then
								setElementInterior(object, interiorID)
							end
							if dim then
								setElementDimension(object, dim)
							end
							
							if doublesided == "true" then
								setElementDoubleSided(object, true)
							end
								
							if(collisions == "false" or collisions == false) then
								setElementCollisionsEnabled(object,false)
							else
								setElementCollisionsEnabled(object,true)
							end							
							setObjectScale(object,scale)
							setElementAlpha(object,alpha)
						end
						i2 = i2+1
					end

					i2 = 0
					while true do
						local mapfilenode = xmlFindChild ( mapfile, "marker", i2)
						if not mapfilenode then
							break
						else
							local theType = xmlNodeGetAttribute(mapfilenode, "type")
							local interiorID = tonumber(xmlNodeGetAttribute(mapfilenode, "interior"))
							local posX = tonumber(xmlNodeGetAttribute(mapfilenode, "posX"))
							local posY = tonumber(xmlNodeGetAttribute(mapfilenode, "posY"))
							local posZ = tonumber(xmlNodeGetAttribute(mapfilenode, "posZ"))
							local size = tonumber(xmlNodeGetAttribute(mapfilenode, "size"))
							local color = xmlNodeGetAttribute(mapfilenode, "color")
							local dim = tonumber(xmlNodeGetAttribute(mapfilenode, "dimension"))
								
							local r = 0
							local g = 0
							local b = 255							
							local a = 255
							if color then
								r,g,b,a = getColorFromString ( color )
							end

							local object = createMarker(posX,posY,posZ,theType,size,r,g,b,a )
								
							if dim then
								setElementDimension(object, dim)
							end
															
							if interiorID then
								setElementInterior(object, interiorID)
							end
						end
						i2 = i2+1
					end

					i2 = 0
					while true do
						local mapfilenode = xmlFindChild ( mapfile, "removeWorldObject", i2)
						if not mapfilenode then
							break
						else
							local radius = tonumber(xmlNodeGetAttribute(mapfilenode, "radius"))
							local interiorID = tonumber(xmlNodeGetAttribute(mapfilenode, "interior"))
							local posX = tonumber(xmlNodeGetAttribute(mapfilenode, "posX"))
							local posY = tonumber(xmlNodeGetAttribute(mapfilenode, "posY"))
							local posZ = tonumber(xmlNodeGetAttribute(mapfilenode, "posZ"))
							local model = tonumber(xmlNodeGetAttribute(mapfilenode, "model"))
							local lod = tonumber(xmlNodeGetAttribute(mapfilenode, "lodModel"))
								
							removeWorldModel ( model, radius, posX, posY, posZ, interiorID )
							if lod then
								removeWorldModel ( lod, radius, posX, posY, posZ, interiorID )
							end
						end
						i2 = i2+1

					end			
					xmlUnloadFile(mapfile)	
				end
				fileDelete(file)
			else
				local newFile = fileCreate(file)
				fileWrite(newFile, fileData)
				fileClose(newFile)
			end
		end
		table.remove(downloadTable, 1)
		downloadNextFile()
	end
)

function onClientResourceStartVita()
	createWater ( 1867.244140625, -1442.7158203125, 12.439189338684, 1966.8056640625, -1441.9091796875, 12.439189338684, 1862.9443359375, -1374.1611328125, 12.439189338684 , 1964.953125, -1373.8857421875, 12.439189338684  )
	setWaterColor ( 0, 50, 125, 150 )
	
	triggerServerEvent("requestLODsClient", resourceRoot)	
	
	local num = 0
	for i,v in pairs(gReplace) do
		num =  num+1
		setTimer(function(replace, modelid)
		  if (replace.texture) then
		   gReplace[modelid].txd = engineLoadTXD("replace/"..replace.texture)
		   if (not gReplace[modelid].txd) then outputChatBox("Unable to load TXD file '"..replace.texture.."'.")
		   elseif (not engineImportTXD(gReplace[modelid].txd, modelid)) then outputChatBox("Unable to replace the texture of model #"..modelid.." by TXD file '"..replace.texture.."'.") end
		  end
		  
		  if (replace.model) then
		   gReplace[modelid].dff = engineLoadDFF("replace/"..replace.model, modelid)
		   if (not gReplace[modelid].dff) then outputChatBox("Unable to load DFF file '"..replace.model.."'.")
		   elseif (not engineReplaceModel(gReplace[modelid].dff, modelid)) then outputChatBox("Unable to replace model #"..modelid.." by DFF file '"..replace.model.."'.") end
		  end
		  
		  if (replace.col) then
		   gReplace[modelid].col = engineLoadCOL("replace/"..replace.col)
		   if (not gReplace[modelid].col) then outputChatBox("Unable to load COL file '"..replace.col.."'.")
		   elseif (not engineReplaceCOL(gReplace[modelid].col, modelid)) then outputChatBox("Unable to replace model #"..modelid.." by COL file '"..replace.col.."'.") end
		  end		
		end, 100* num, 1, v, i)
	end
	removeEventHandler("onClientRender",getRootElement(), webBrowserRender)
	if getElementData(getLocalPlayer(), "isPlayerLoggedIn") ~= true then
		triggerEvent ( "startVitaLogin", getRootElement() )
	end	
end


function setLODsClient(lodTbl)
	if lodTbl then
		for i, model in ipairs(lodTbl) do
			if model then
				engineSetModelLODDistance(model, 300)
			end
		end
	end
end
addEvent("setLODsClient", true)
addEventHandler("setLODsClient", resourceRoot, setLODsClient)


function applyBreakableState()
	for k, obj in pairs(getElementsByType("object", resourceRoot)) do
		local breakable = getElementData(obj, "breakable")
		if breakable then
			setObjectBreakable(obj, breakable == "true")
		end
	end
end