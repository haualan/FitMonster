-- battlegroundScene = director:createScene()
-- director:createLabel(0, 0, 'this is the battleground')
local dw = director.displayWidth
local dh = director.displayHeight
local myLon = 100
local myLat = 100
-- local chosenNeighbor

local scene = director:createScene()
scene.name = "battlegroundScene"

function scene:setUp(event)
  dbg.print("setup battlegroundScene")

  -- Create menu background
  local background = director:createSprite(director.displayCenterX, director.displayCenterY, "asset/bkg.jpg")
  background.xAnchor = 0.5
  background.yAnchor = 0.5
  -- Fit background to screen size
  background.xScale = director.displayWidth / 768
  background.yScale = director.displayHeight / 1136

  -- arenaButton redirects to arena for battles
  arenaButton = director:createSprite(director.displayCenterX, director.displayCenterY *.10 , "asset/button_bg.png")
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
    text="Back"
  })
  arenaButton:addChild(arenaText)

  -- load my own monster
  monsterState = load()




end




function battleOutcome(enemyLevel)
  local result = 0 
  local diff = enemyLevel - monsterState.currentlvl
  if (diff >= 3) then
    -- enemy every strong
    result = .9 
  elseif (diff < 3 and diff >= 2) then
    result = .75
  elseif (diff < 2 and diff >= 1) then
    result = .60
  elseif (diff < 1 and diff >= 0) then
    result = .50
  elseif (diff < 0 and diff >= -1) then
    result = .40
  elseif (diff < -1 and diff >= -2) then
    result = .25
  elseif (diff < -2) then
    result = .10
  end

  if (math.random() > result) then
    result = 1
  else
    result = 0
  end

  return result
end




function scene:enterPostTransition(event)
  print("Battlegroundscene:enterPostTransition")
  dbg.print("chosen monster: " .. chosenMonsterIndex .. json.encode(neighbors[chosenMonsterIndex]))
  -- neighbors[chosenMonsterIndex]

  local newSprite = director:createSprite(director.displayCenterX, dh * 0.75 , "asset/".. neighbors[chosenMonsterIndex].monster.imgSrc)
  newSprite.xAnchor = 0.5
  newSprite.yAnchor = 0.5
  tween:to(newSprite, {
  xScale=2,
  yScale=1.1,
  time=1,
  mode="mirror"
  } )

  monsterStateLabel = director:createLabel(0, director.displayCenterY - 100, 
  'Name: ' .. neighbors[chosenMonsterIndex].monster.name .. "\n" ..
  'Level: ' .. neighbors[chosenMonsterIndex].monster.currentlvl .. "\n" 
  )

  chosenNeighbor = neighbors[chosenMonsterIndex]
  print("chosenNeighbor: " .. json.encode(chosenNeighbor))



 function goToBattle(event)
      if event.phase == 'began' then
          -- Outcome = 0
          local Outcome = battleOutcome(neighbors[chosenMonsterIndex].monster.currentlvl)
          -- local Outcome = battleOutcome(event.target.monster.currentlvl)
          print("Outcome: "..Outcome)

          -- BattleButton.isVisible = false
          BattleButton:removeFromParent()

          if Outcome == 1 then
            -- you've won
            Outcomelabel = director:createLabel(director.displayCenterX, director.displayCenterY, "You have won!")
          else
            Outcomelabel = director:createLabel(director.displayCenterX, director.displayCenterY, "You have lost!")
          end
          Outcomelabel.xAnchor = 0.5
          Outcomelabel.yAnchor = 0.5
      end
      

  end


    -- BattleButton finds outcome of battle
  BattleButton = director:createSprite(director.displayCenterX, director.displayCenterY *.45 , "asset/button_bg.png")
  local atlas = arenaButton:getAtlas()
  local atlas_w, atlas_h = atlas:getTextureSize()
  BattleButton.xAnchor = 0.5
  BattleButton.yAnchor = 0.5
  BattleButton.xScale = 0.5
  BattleButton.yScale = 0.5
  BattleButton:addEventListener("touch", goToBattle)
  -- Create button text
  local BattleButtonText = director:createLabel( {
    x = 0, y = 0, 
    w = atlas_w, h = atlas_h, 
    hAlignment="centre", vAlignment="middle", 
    textXScale = 2, textYScale = 2, 
    text="Attack"
  })
  BattleButton:addChild(BattleButtonText)
  BattleButton.neighbor = chosenNeighbor



 



end

scene:addEventListener({"setUp", "enterPostTransition"}, scene)

return scene