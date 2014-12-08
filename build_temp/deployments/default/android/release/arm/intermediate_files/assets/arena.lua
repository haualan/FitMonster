
-- in the arena, you will see your neighbors kind of like in a dating site.
isLocationPostedAlready = false
local dw = director.displayWidth
local dh = director.displayHeight
local myLon = 100
local myLat = 100

-- local neighbors


-- director:createLabel(0, 0, 'this is the arena, fight your neighbors here: kddk')

local scene = director:createScene()
scene.name = "arenaScene"

function scene:setUp(event)
  dbg.print("setup arenaScene")

  -- Create menu background
  local background = director:createSprite(director.displayCenterX, director.displayCenterY, "asset/bkg.jpg")
  background.xAnchor = 0.5
  background.yAnchor = 0.5
  -- Fit background to screen size
  background.xScale = director.displayWidth / 768
  background.yScale = director.displayHeight / 1136


  self.obj0 = director:createLabel(0, 0, 'this is the arena, fight your neighbors here: ' .. location:getLocationType() )
  director:createLabel(0, 300, 'isReadingAvailable: ' .. tostring(location:isReadingAvailable()) )
  director:createLabel(0, 200,  'isLocationPostedAlready:' .. tostring(isLocationPostedAlready)  )


  -- playButton redirects to barn
  playButton = director:createSprite(director.displayCenterX, director.displayCenterY * 0.10, "asset/button_bg.png")
  local atlas = playButton:getAtlas()
  local atlas_w, atlas_h = atlas:getTextureSize()
  playButton.xAnchor = 0.5
  playButton.yAnchor = 0.5
  playButton.xScale = 0.5
  playButton.yScale = 0.5
  playButton:addEventListener("touch", goToBarn)
  -- Create Continue Game button text
  local playText = director:createLabel( {
    x = 0, y = 0, 
    w = atlas_w, h = atlas_h, 
    hAlignment="centre", vAlignment="middle", 
    textXScale = 2, textYScale = 2, 
    text="go back"
  })
  playButton:addChild(playText)






end

function scene:enterPreTransition(event)
  print("scene1:enterPreTransition")
end
function scene:enterPostTransition(event)
  print("scene1:enterPostTransition")
  isLocationPostedAlready = true
    -- getMyLocation()

  neighbors = postMyLonLat(myLon, myLat)

  -- print(json.encode(neighbors))

  -- for each neighbor, construct and return an icon
  local tempX = 0 
  local tempY = 0
  for key,neighbor in ipairs(neighbors) do 
   print(key .. json.encode(neighbor))
   print(neighbor.monster.imgSrc)

  if ((key % 4) == 0) then 
    tempX = 4 * (dw * 0.25) - (dw * .10)
  else
    tempX = (key % 4) * (dw * 0.25) - (dw * .10)
  end

   tempY = dh - (math.ceil(key / 4) * (dh /8) + (dh * .20))

   drawMonster(
    tempX,
    tempY, 
    neighbor,
    key)
   -- director:createSprite(key * 30 , key * 30 , "asset/".. neighbor.monster.imgSrc)
   -- director:createSprite(director.displayCenterX, director.displayCenterY , "asset/".. monsterState.imgSrc)


  end
end
function scene:exitPreTransition(event)
  print("scene1:exitPreTransition")
end
function scene:exitPostTransition(event)
  print("scene1:exitPostTransition")
end

function goToBattle(event)

  chosenMonsterIndex = event.target.index
  print(chosenMonsterIndex)
  switchToScene("battle")
end





-- intend to only post location once to the server per screen entry


-- 0. post my location (lon ,lat) to the server and the server will return the 50 closest users & their monsterstate object by distance
function postMyLonLat(lon, lat )
  local result = {}
  local myPayload = {'myUID',
      {
      lon = myLon,
      lat = myLat,
      monster = monsterState
    }
  }


  
  -- http post

mytable2 = {name = "bob", age=20, colour="orange"}

  -- sample result data
  local sampleUserJsonString = { lon= 100,
  lat= 101, 
   monster= 
     {nextlvl=109,
     isAlive=1,
     name="foopiePants",
     currentlvl=8,
     age=0,
     imgSrc="lvl0.png"}
 }

   local sampleUserJsonString2 = { lon= 110,
  lat= 101, 
   monster= 
     {nextlvl=109,
     isAlive=1,
     name="Dark Tomato",
     currentlvl=2,
     age=0,
     imgSrc="lvl1.png"}
 }

    local sampleUserJsonString3 = { lon= 110,
  lat= 101, 
   monster= 
     {nextlvl=109,
     isAlive=1,
     name="Lambtron",
     currentlvl=2,
     age=0,
     imgSrc="lvl2.png"}
 }

    local sampleUserJsonString4 = { lon= 110,
  lat= 101, 
   monster= 
     {nextlvl=109,
     isAlive=1,
     name="Shoe",
     currentlvl=2,
     age=0,
     imgSrc="lvl3.png"}
 }

  local sampleUserJsonString5 = { lon= 110,
  lat= 101, 
   monster= 
     {nextlvl=109,
     isAlive=1,
     name="Pengin",
     currentlvl=2,
     age=0,
     imgSrc="lvl4.png"}
 }



  -- local sampleUserJsonString2 = '{"lon": 110, "lat": 101, "monster": {"nextlvl":109,"isAlive":1,"name":"loopiePants","currentlvl":8,"age":0,"imgSrc":"lvl1.png"}}'

  -- local sampleUserJsonString = '{"nextlvl":109,"isAlive":1,"name":"poopiePants","currentlvl":8,"age":0,"imgSrc":"lvl1.png"}'
   

  -- local sampleUser = json.decode(sampleUserJsonString)

  local result = {
  sampleUserJsonString4,
  sampleUserJsonString2,
  sampleUserJsonString5,
  sampleUserJsonString3,
  sampleUserJsonString,
  sampleUserJsonString5,
  sampleUserJsonString2
}
  
  -- table.insert(result, sampleUserJsonString)
  -- table.insert(result, json.decode(sampleUserJsonString2))
  -- table.insert(result, json.decode(sampleUserJsonString3))
  
  
  -- print(json.encode(result))
  return result
end

function drawMonster(x , y , iNeighbor, key)
      -- load monster image
    print("X:" .. x .. "Y:" .. y)
    monsterSprite = director:createSprite(x, y , "asset/".. iNeighbor.monster.imgSrc)
    monsterSprite.xAnchor = 0.5
    monsterSprite.yAnchor = 0.5
    monsterSprite.index = key
    monsterSprite:addEventListener("touch", goToBattle)



end



function getDst(lon1, lat1, lon2, lat2 )
  -- finds the euclidean distance between 2 pairs of lon lat coordinates
  local result = math.abs(lon1 - lat1) + math.abs(lon2 - lat2)


  return result
end


--[[
Example: Show Location

Demonstrates location events. Sets up an event listeners
to update the text display of the location coordinates.

You can set the location value in the Simulator, using
the Configuration > Location dialog.
--]]

-- local dw = director.displayWidth
-- local dh = director.displayHeight

-- -- Display location coords as text
-- local labelX = director:createLabel( {
--         x=dw/2, y=dh*2/3, w=1, h=1,
--         hAlignment="centre",
--         text="",
--         } )

-- function labelX:location(event)
--     labelX.text = string.format("Alt: %.3f\nLat: %.3f\nLong: %.3f", event.altitude, event.latitude, event.longitude)
--     myLon = event.longitude
--     myLat = event.lat
-- end
-- labelX:addEventListener("location", labelX)


scene:addEventListener({"setUp" , "enterPreTransition", "enterPostTransition", "exitPreTransition", "exitPostTransition" }, scene)

return scene





