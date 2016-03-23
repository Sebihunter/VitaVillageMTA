-- Decompiled using luadec 2.1 UNICODE by sztupy (http://winmo.sztupy.hu) and viruscamp 
-- Command line was: test.luac 

local elevator = createObject(16637, -960.21484375, -976.5791015625, 129.47128295898, 0, 90, 0)
setElementData(elevator, "state", "down")
local thegatedown = createObject(16637, -960.1962890625, -978.427734375, 133.82740783691, 90, 180.00549316406, 269.95056152344)
local thegateup = createObject(976, -967.61889648438, -978.4443359375, 150.12403869629, 0, 0, 0)

addEvent("moveTheTreeHouseObjects", true)
addEventHandler("moveTheTreeHouseObjects", getRootElement(), function(id)
  -- upvalues: elevator , thegatedown , thegateup
  if getElementData(elevator, "state") == "down" then
    moveObject(thegatedown, 3000, -960.1962890625, -978.427734375, 131.45115661621)
    setTimer(function()
      -- upvalues: elevator , thegateup
      moveObject(elevator, 18000, -960.21484375, -976.5791015625, 149.98846435547)
      setElementData(elevator, "state", "moveing")
      setTimer(setElementData, 25000, 1, elevator, "state", "up")
      setTimer(function()
        -- upvalues: thegateup
        moveObject(thegateup, 3000, -970, -978.4443359375, 150.12403869629)
      end, 18000, 1)
    end, 3000, 1)
  end
  if getElementData(elevator, "state") == "up" then
    moveObject(thegateup, 3000, -967.61889648438, -978.4443359375, 150.12403869629)
    setElementData(elevator, "state", "moveing")
    setTimer(setElementData, 25000, 1, elevator, "state", "down")
    setTimer(function()
      -- upvalues: elevator
      moveObject(elevator, 18000, -960.21484375, -976.5791015625, 129.47128295898)
    end, 3000, 1)
    setTimer(function()
      -- upvalues: thegatedown
      moveObject(thegatedown, 3000, -960.1962890625, -978.427734375, 133.82740783691)
    end, 22000, 1)
  end
end
)

