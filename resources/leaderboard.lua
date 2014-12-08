-- settingsMenu
local scene = director:createScene()
scene.name = "leaderboardScene"



function scene:setUp(event)
  dbg.print("setup leaderboardScene")

  -- Create menu background
  local background = director:createSprite(director.displayCenterX, director.displayCenterY, "asset/bkg.jpg")
  background.xAnchor = 0.5
  background.yAnchor = 0.5
  -- Fit background to screen size
  background.xScale = director.displayWidth / 768
  background.yScale = director.displayHeight / 1136


  -- BackButton saves and redirects to Main Menu
  BackButton = director:createSprite(director.displayCenterX, director.displayHeight * 0.10, "asset/button_bg.png")
  local atlas = BackButton:getAtlas()
  local atlas_w, atlas_h = atlas:getTextureSize()
  BackButton.xAnchor = 0.5
  BackButton.yAnchor = 0.5
  BackButton.xScale = 0.5
  BackButton.yScale = 0.5
  BackButton:addEventListener("touch", goToMain)
  -- Create Continue Game button text
  local backText = director:createLabel( {
    x = 0, y = 0, 
    w = atlas_w, h = atlas_h, 
    hAlignment="centre", vAlignment="middle", 
    textXScale = 2, textYScale = 2, 
    text="Back"
  })
  BackButton:addChild(backText)





end

function scene:enterPostTransition(event)
  print("leaderboardScene:enterPostTransition")

    -- this is where we will display the table
  local labelX = director:createLabel( {
        hAlignment="centre", vAlignment="middle",
        text="",
        } )

  local recTable ={}
   local a,b,c,d = http.request( {
    url = SERVER .. '/getLeaders',
    method = 'GET',
    sink = ltn12.sink.table(recTable)
    } )

  -- parse into response, only keep the inner table from result
  local recTable = json.decode(recTable[1])['result']

  local recStr = "Top 5 player......score\n"
  for i,v in pairs(recTable) do
    recStr =recStr .. v[1] .. "......" .. v[2] .. "\n"
  end
  
  labelX.text = recStr
  
end

scene:addEventListener({"setUp" , "enterPostTransition" }, scene)


return scene

