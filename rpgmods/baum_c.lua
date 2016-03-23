-- Decompiled using luadec 2.1 UNICODE by sztupy (http://winmo.sztupy.hu) and viruscamp 
-- Command line was: test.luac 

local keyped_baumhaus = {}
keyped_baumhaus[1] = createObject(2886, -961.80908203125, -978.30999755859, 130.62380981445, 0, 0, 269.9951171875)
keyped_baumhaus[2] = createObject(2886, -958.6884765625, -978.03442382813, 130.62380981445, 0, 0, 269.99450683594)
keyped_baumhaus[3] = createObject(2886, -958.802734375, -978.0341796875, 151.42514038086, 0, 0, 269.99450683594)
keyped_baumhaus[4] = createObject(2886, -961.98187255859, -978.48077392578, 151.54403686523, 0, 0, 0)
setElementData(keyped_baumhaus[1], "cinfo", {"Lift benützen"})
setElementData(keyped_baumhaus[2], "cinfo", {"Lift benützen"})
setElementData(keyped_baumhaus[3], "cinfo", {"Lift benützen"})
setElementData(keyped_baumhaus[4], "cinfo", {"Lift benützen"})

basdasd = function(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement)
  -- upvalues: keyped_baumhaus
  if clickedElement and getElementType(clickedElement) == "object" then
    local playerx, playery, playerz = getElementPosition(getLocalPlayer())
    local hitedx, hittedy, hittedz = getElementPosition(clickedElement)
  if getDistanceBetweenPoints3D(hitedx, hittedy, hittedz, playerx, playery, playerz) < 8 then
    for i = 1, 4 do
      if clickedElement == keyped_baumhaus[i] and state == "down" then
        triggerServerEvent("moveTheTreeHouseObjects", getLocalPlayer())
      end
    end
  end
  end
end

addEventHandler("onClientClick", getRootElement(), basdasd)

