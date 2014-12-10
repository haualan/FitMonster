barnMenuScene = director:createScene()
director:createLabel(0, 0, 'this is the barn')

-- UI 
local err

local mainMenuButton
local mainMenuText

local arenaButton
local arenaText

local evolveButton
local evolveText

local pathS = system:getFilePath("storage")
local chiPoints = 100

monsterState = 0

local newMonster = {
  name = "poopiePants",
  isAlive = 1,
  age = 0,
  -- element = nil,
  currentlvl = 0,
  -- floors of stairs required for next level
  nextlvl = 5,
  imgSrc = "lvl0.png" 
}

local monsterSprite
local monsterStateLabel
local chiPointsLabel

local http = require("socket.http")
local ltn12 = require("ltn12")


function goToMainMenu()
  switchToScene("main")
end

function goToArena()
  -- reset every listener
  system:removeEventListener("touch", Attack)
  system:removeEventListener("update", updateBattleSprite)
  system:removeEventListener("collision", hit)
  -- check monsterState 
  switchToScene("arena")
  -- switchToScene("test")
end

function killErr()
  err = err:removeFromParent()
end

function save()
    local file = io.open(pathS .. "gameData.txt", "w")
    file:write(json.encode(monsterState).."\n")
    file:close()
end
 
function load()
    local file = io.open(pathS .. "gameData.txt","r")
    -- Note: if io.open returned nil, the highscore file does not exist yet.
    if file ~= nil then
        monsterState = json.decode(file:read())
    else 
    -- you are a new player with no data, initialize new monster and save it
        monsterState = newMonster
        save()
    end



    return monsterState
end

function getChiPoints()
  local recTable ={}
  local result = 0
  local a,b,c,d = http.request( {
    url = SERVER .. '/getFloorsTimeSeries',
    method = 'GET',
    sink = ltn12.sink.table(recTable)
    } )

    -- parse into response, only keep the inner table from result
    recTable = json.decode(recTable[1])['result']

    for key,value in ipairs(recTable) do
      result = result + value[2]
    end

    return result
end

function updateSprite()
  local newSprite = director:createSprite(director.displayCenterX, director.displayCenterY , "asset/".. monsterState.imgSrc)
  newSprite.xAnchor = 0.5
  newSprite.yAnchor = 0.5
  tween:to(newSprite, {
  xScale=2,
  yScale=1.1,
  time=1,
  mode="mirror"
  } )

  return newSprite   
end

function evolve(event)
  -- evolves the current beast based on current stats
  if (event.phase == 'ended') then
    if monsterState.nextlvl <= chiPoints then
      -- deduct cost
      chiPoints = chiPoints - monsterState.nextlvl

      -- set new stats
      monsterState.currentlvl = monsterState.currentlvl + 1
      monsterState.nextlvl = math.floor(monsterState.nextlvl * 1.5)
      monsterState.imgSrc = "lvl" .. math.random(0,4) ..".png"

      -- Update UI sprites
      -- do 
        local newSprite = updateSprite()
        tween:dissolve(monsterSprite, newSprite, 1, 0)
        monsterSprite = newSprite
      -- end


      monsterStateLabel.text =
      'Name: ' .. monsterState.name .. "\n" ..
      'Level: ' .. monsterState.currentlvl .. "\n" ..
      'Next Level: ' .. monsterState.nextlvl .. "\n"
      

      chiPointsLabel.text =
      'Chi Points: ' .. chiPoints

      save()
      
    else
        err = director:createLabel(director.displayCenterX, director.displayCenterY, 'Not enough chi points...')
        err.xAnchor = 0.5 ; err.yAnchor = 0.5
        -- err.tween = tween:to(err, { time=1, delta=0.5, y=director.displayHeight ,  mode ='clamp', onComplete = err:removeFromParent() } )
        err.tween = tween:to(err, { time=1, delta=0.5, y=director.displayHeight ,  mode ='clamp' } )
    end
  end

end

-- Create menu background
local background = director:createSprite(director.displayCenterX, director.displayCenterY, "asset/bkg.jpg")
background.xAnchor = 0.5
background.yAnchor = 0.5
-- Fit background to screen size
background.xScale = director.displayWidth / 768
background.yScale = director.displayHeight / 1136


-- mainMenuButton redirects to main Menu
mainMenuButton = director:createSprite(director.displayCenterX, director.displayCenterY + 200, "asset/button_bg.png")
local atlas = mainMenuButton:getAtlas()
local atlas_w, atlas_h = atlas:getTextureSize()
mainMenuButton.xAnchor = 0.5
mainMenuButton.yAnchor = 0.5
mainMenuButton.xScale = 0.5
mainMenuButton.yScale = 0.5
mainMenuButton:addEventListener("touch", goToMainMenu)
-- Create button text
local mainMenuText = director:createLabel( {
  x = 0, y = 0, 
  w = atlas_w, h = atlas_h, 
  hAlignment="centre", vAlignment="middle", 
  textXScale = 2, textYScale = 2, 
  text="Back to Main Menu"
})
mainMenuButton:addChild(mainMenuText)

-- arenaButton redirects to arena for battles
arenaButton = director:createSprite(director.displayCenterX, director.displayCenterY + 100 , "asset/button_bg.png")
local atlas = arenaButton:getAtlas()
local atlas_w, atlas_h = atlas:getTextureSize()
arenaButton.xAnchor = 0.5
arenaButton.yAnchor = 0.5
arenaButton.xScale = 0.5
arenaButton.yScale = 0.5
arenaButton:addEventListener("touch", goToArena)
-- Create button text
local arenaText = director:createLabel( {
  x = 0, y = 0, 
  w = atlas_w, h = atlas_h, 
  hAlignment="centre", vAlignment="middle", 
  textXScale = 2, textYScale = 2, 
  text="Go to the Arena"
})
arenaButton:addChild(arenaText)


-- load Floors/chiPoints from FitBit:
chiPoints = getChiPoints()

-- show status for your monster and if you don't have monster, spawn one.
-- read local file to see if monster is loaded.
monsterState = load()

-- load monster image
monsterSprite = director:createSprite(director.displayCenterX, director.displayCenterY , "asset/".. monsterState.imgSrc)
monsterSprite.xAnchor = 0.5
monsterSprite.yAnchor = 0.5
tween:to(monsterSprite, {
    xScale=2,
    yScale=1.1,
    time=1,
    mode="mirror"
    } )

monsterStateLabel = director:createLabel(0, director.displayCenterY - 100, 
'Name: ' .. monsterState.name .. "\n" ..
'Level: ' .. monsterState.currentlvl .. "\n" ..
'Cost Next Level: ' .. monsterState.nextlvl .. "\n"
)

chiPointsLabel = director:createLabel(0, director.displayCenterY - 150,
'Chi Points: ' .. chiPoints
)




-- evolveButton evolves the beast
evolveButton = director:createSprite(director.displayCenterX, director.displayHeight * 0.10 , "asset/button_bg.png")
local atlas = evolveButton:getAtlas()
local atlas_w, atlas_h = atlas:getTextureSize()
evolveButton.xAnchor = 0.5
evolveButton.yAnchor = 0.5
evolveButton.xScale = 0.5
evolveButton.yScale = 0.5
evolveButton:addEventListener("touch", evolve)
-- Create button text
local evolveText = director:createLabel( {
  x = 0, y = 0, 
  w = atlas_w, h = atlas_h, 
  hAlignment="centre", vAlignment="middle", 
  textXScale = 2, textYScale = 2, 
  text="Evolve"
})
evolveButton:addChild(evolveText)
