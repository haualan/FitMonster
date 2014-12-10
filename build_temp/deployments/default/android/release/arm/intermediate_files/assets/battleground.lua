-- battlegroundScene = director:createScene()
-- director:createLabel(0, 0, 'this is the battleground')
local dw = director.displayWidth
local dh = director.displayHeight
local myLon = 100
local myLat = 100

physics:setGravity(0, 0)
 
-- Touch listener to drag monster
function dragBat(event)
    local bat = event.target
    if event.phase == "began" then
        bat.yTouchLast = event.y
        bat.xTouchLast = event.x
    elseif event.phase == "moved" then
        -- move X and Y coords
        bat.yVel = event.y - bat.yTouchLast;
        bat.yTouchLast = event.y
        bat.y = bat.y + bat.yVel

        bat.xVel = event.x - bat.xTouchLast;
        bat.xTouchLast = event.x
        bat.x = bat.x + bat.xVel
    end
end

-- Collision listener
function hit(event)
    if event.phase == "began" then
      print("battle sprite collision...determine outcome")
          -- Outcome = 0
        local Outcome = battleOutcome(neighbors[chosenMonsterIndex].monster.currentlvl)
          -- local Outcome = battleOutcome(event.target.monster.currentlvl)




        local bat, ball
        if event.nodeA.radius then
            bat = event.nodeB
            ball = event.nodeA
        else
            ball = event.nodeB
            bat = event.nodeA
        end
        -- if ball.vx < 0 then
        --     ball.x = bat.x + (bat.w + ball.w)/2
        -- else
        --     ball.x = bat.x - (bat.w + ball.w)/2
        -- end

            -- ball.vx = -ball.vx
            -- ball.vy = -ball.vy

            -- bat.x = bat.x + ball.xVel
            bat.xVel = math.random(10)

            --bat.y = bat.y + ball.yVel
            bat.yVel = math.random(10)

            ball.x = bat.x + bat.xVel
            ball.y = bat.y + bat.yVel
        return true
    end
end

function updateBattleSprite(event)
    -- Are we simply waiting for the ball to appear again?
    -- if ball.inTimer > 0 then
    --     ball.inTimer = ball.inTimer - system.deltaTime
    --     if ball.inTimer < 0 then
    --         ball.inTimer = 0
    --         ball.isVisible = true
    --     end
    -- end
 
    -- -- Bounce off top/bottom of display?
    -- if ball.y < ball.radius then
    --     ball.y = ball.radius
    --     ball.vy = -ball.vy
    -- elseif ball.y > dh - ball.radius then
    --     ball.y = dh - ball.radius
    --     ball.vy = -ball.vy
    -- end
 
    -- -- Move ball: add velocity to position
    -- ball.x = ball.x + ball.vx
    -- ball.y = ball.y + ball.vy
 
    -- -- Ball out of play (off left/right)? If so, re-center
    -- if ball.x < 0 or ball.x > dw then
    --     ball.x = dw/2
    --     ball.y = dh/2
    --     ball.vx = ballSpeed
    --     ball.vy = 0
    --     ball.inTimer = 2 -- count down from 2 seconds before starting ball again
    --     ball.isVisible = false
    -- end

    -- when battle begins, enemy should be chasing your monster
    -- print("battleupdate")

    opponentSprite.inTimer = 2
    -- on the left, generate right Vel, on the right, generate left Vel
    if opponentSprite.x >= dw then 
	opponentSprite.xVel = math.random(8)-16
    elseif opponentSprite.x <= 0 then
	opponentSprite.xVel = math.random(8)
    else 
	opponentSprite.xVel = math.random(8)-4.5
    end
    opponentSprite.x = opponentSprite.xVel + opponentSprite.x
    
    -- on the top, generate neg Vel, on the bottom, generate pos Vel
    if opponentSprite.y >= dh then 
	opponentSprite.yVel = math.random(8)-16
    elseif opponentSprite.y <= 0 then
	opponentSprite.yVel = math.random(8)
    else 
	opponentSprite.yVel = math.random(8)-4.5
    end
    opponentSprite.y = opponentSprite.yVel + opponentSprite.y
    --opponentSprite.x = math.random(0,dw)
    --opponentSprite.y = math.random(dh/2, dh)

    print("dw: "..dw.." dh: "..dh)
    print("oppornen coord x" ..opponentSprite.x .. "y" .. opponentSprite.y )

end


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
  -- remove the event listner for monsters
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


  print("Outcome: "..result)


  if result == 1 then
    -- you've won
    Outcomelabel = director:createLabel(dw/2, dh/2, "You have won!")
    opponentSprite.isVisible = false
  else
    Outcomelabel = director:createLabel(dw/2, dh/2, "You have lost!")
    myMonsterSprite.isVisible = false
  end
  Outcomelabel.xAnchor = 0.5
  Outcomelabel.yAnchor = 0.5

  local myPayload = {
  UID = fitbitUID,
  score = result
}
  myPayload = json.encode(myPayload)
  -- send result to the server league table
  local a,b,c,d = http.request( {
  url = SERVER .. '/postOutcome',
  source = ltn12.source.string(myPayload),
  headers = {
          ["content-type"] = "text/plain",
          ["content-length"] = tostring(#myPayload)
      },
  method = 'POST'
  } )

  

  return result
end

function Attack(event)
      if event.phase == 'began' then


          -- draw sprite for user's monster and make it draggable
            local myMonsterSprite = director:createSprite(director.displayCenterX, dh * 0.25 , "asset/".. monsterState.imgSrc)
            myMonsterSprite.xAnchor = 0.5
            myMonsterSprite.yAnchor = 0.5
            tween:to(myMonsterSprite, {
            xScale=2,
            yScale=1.1,
            time=1,
            mode="mirror"
            } )
            physics:addNode(myMonsterSprite, {isSensor=true})
            myMonsterSprite:addEventListener("touch", dragBat)
            myMonsterSprite:addEventListener("collision", hit)

          -- Enemy starts chasing my monster
            system:addEventListener("update", updateBattleSprite)



          -- BattleButton.isVisible = false
          BattleButton:removeFromParent()



      end
      

end



function scene:enterPostTransition(event)
  print("Battlegroundscene:enterPostTransition")
  dbg.print("chosen monster: " .. chosenMonsterIndex .. json.encode(neighbors[chosenMonsterIndex]))
  -- neighbors[chosenMonsterIndex]

  opponentSprite = director:createSprite(director.displayCenterX, dh * 0.75 , "asset/".. neighbors[chosenMonsterIndex].monster.imgSrc)
  opponentSprite.xAnchor = 0.5
  opponentSprite.yAnchor = 0.5
  tween:to(opponentSprite, {
  xScale=2,
  yScale=1.1,
  time=1,
  mode="mirror"
  } )

  


  physics:addNode(opponentSprite, {isSensor=true})

  -- opponentSprite:addEventListener("touch", dragBat)
  opponentSprite:addEventListener("collision", hit)

  monsterStateLabel = director:createLabel(0, director.displayCenterY - 100, 
  'Name: ' .. neighbors[chosenMonsterIndex].monster.name .. "\n" ..
  'Level: ' .. neighbors[chosenMonsterIndex].monster.currentlvl .. "\n" 
  )

  chosenNeighbor = neighbors[chosenMonsterIndex]
  print("chosenNeighbor: " .. json.encode(chosenNeighbor))






    -- BattleButton finds outcome of battle
  BattleButton = director:createSprite(director.displayCenterX, director.displayCenterY *.45 , "asset/button_bg.png")
  local atlas = arenaButton:getAtlas()
  local atlas_w, atlas_h = atlas:getTextureSize()
  BattleButton.xAnchor = 0.5
  BattleButton.yAnchor = 0.5
  BattleButton.xScale = 0.5
  BattleButton.yScale = 0.5
  BattleButton:addEventListener("touch", Attack)
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
