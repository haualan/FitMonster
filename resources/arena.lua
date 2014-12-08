
-- in the arena, you will see your neighbors kind of like in a dating site.

local dw = director.displayWidth
local dh = director.displayHeight
local myLon = 100
local myLat = 100
local http = require("socket.http")
local ltn12 = require("ltn12")

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


  self.obj0 = director:createLabel(0, 100, 'this is the arena, fight your neighbors here' )


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

    -- start location services to collect lon and lat for user
  location:start()
  
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


local getLocationFunction = function(event)
-- this event listener will save lon and lat info for user to myLon and myLat
  -- print(string.format("Alt: %.3f\nLat: %.3f\nLong: %.3f", event.altitude, event.latitude, event.longitude))
  myLon = event.longitude
  myLat = event.latitude
  location:stop()

-- send the location coords to server and find neighbors
  neighbors = getNeighbors(myLon, myLat)

  -- for each neighbor, construct and return an icon
  local tempX = 0 
  local tempY = 0
  for key,neighbor in ipairs(neighbors) do 
   -- print(key .. json.encode(neighbor))
   -- print(neighbor.monster.imgSrc)

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

  end

end
system:addEventListener("location", getLocationFunction)


-- 0. post my location (lon ,lat) and monsterState to the server and the server will return the 10 closest users & their monsterstate object by distance
function getNeighbors(iLon, iLat)
  print('lon:'..iLon .. 'lat:'..iLat)
  local myPayload = {'myUID',
      {
      lon = iLon,
      lat = iLat,
      monster = monsterState
    }
  }

  dbg.printTable(myPayload)



  local recTable ={}
   local a,b,c,d = http.request( {
    url = SERVER .. '/getNeighbors?lon='.. iLon ..'&lat=' .. iLat,
    method = 'GET',
    sink = ltn12.sink.table(recTable)
    } )

    -- parse into response, only keep the inner table from result
    recTable = json.decode(recTable[1])['result']

    return recTable
    
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





scene:addEventListener({"setUp" , "enterPreTransition", "enterPostTransition", "exitPreTransition", "exitPostTransition" }, scene)

return scene





