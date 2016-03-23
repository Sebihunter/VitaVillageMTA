--[[
Project: VitaOnline
File: tschein-server.lua
Author(s):	Lexlo
]]--
function writelicense ( name, hours, minutes, monthday, month, year )
    local xml = xmlLoadFile ( "xml/tschein.xml" )
    local i = 0
    if xml then
        while (true) do
			local subnode = xmlFindChild(xml,"user", i)
            if not subnode then
				local NewNode = xmlCreateChild ( xml, "user" )
				xmlNodeSetAttribute ( NewNode, "Name", name )
				xmlNodeSetAttribute ( NewNode, "Datum", monthday.."."..month.."."..year )
				xmlNodeSetAttribute ( NewNode, "Zeit", hours..":"..minutes )
                break
            end
            if ( name == xmlNodeGetAttribute ( subnode, "Name" )) then
                break
            end
            i = i + 1
        end
	xmlSaveFile ( xml )
    xmlUnloadFile(xml)
    end
end

function hasTempLicense(name)
    local xml = xmlLoadFile ( "xml/tschein.xml" )
    local i = 0
    if xml then
        while (true) do
			local subnode = xmlFindChild(xml,"user", i)
			if not subnode then 
				return false
			end
            if ( name == xmlNodeGetAttribute ( subnode, "Name" )) then
				local tscheinstring = xmlNodeGetAttribute(subnode, "Datum")--[[.." um "..xmlNodeGetAttribute(subnode, "Zeit")]]--
				return tscheinstring
            end
            i = i + 1			
        end
	xmlSaveFile ( xml )
    xmlUnloadFile(xml)
    end		
	return false
end

addEvent( "onplayerlicensefinish", true )
addEventHandler( "onplayerlicensefinish", getRootElement(), writelicense )