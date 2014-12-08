-- main menu contains 3 buttons, buttons direct users to scenes
-- Create the game scene
mainMenuScene = director:createScene()
-- UI
local playButton
local playText

local settingsButton
local settingsText

local aboutButton
local aboutText

director:createLabel(0, 0, 'this is the main menu')

function goToBarn(event)
  -- check if settings is present, if not, remember to settings
  switchToScene("barn")
end

function goToSettings(event)
  switchToScene("settings")
end

function goToLeaderboard(event)
  switchToScene("leaderboard")
end

-- Create menu background
local background = director:createSprite(director.displayCenterX, director.displayCenterY, "asset/bkg.jpg")
background.xAnchor = 0.5
background.yAnchor = 0.5
-- Fit background to screen size
background.xScale = director.displayWidth / 768
background.yScale = director.displayHeight / 1136

-- playButton redirects to barn
playButton = director:createSprite(director.displayCenterX, director.displayCenterY + 100, "asset/button_bg.png")
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
  text="play"
})
playButton:addChild(playText)


-- settingsBtn
settingsButton = director:createSprite(director.displayCenterX, director.displayCenterY , "asset/button_bg.png")
local atlas = settingsButton:getAtlas()
local atlas_w, atlas_h = atlas:getTextureSize()
settingsButton.xAnchor = 0.5
settingsButton.yAnchor = 0.5
settingsButton.xScale = 0.5
settingsButton.yScale = 0.5
settingsButton:addEventListener("touch", goToSettings)
-- Create Continue Game button text
local settingsText = director:createLabel( {
  x = 0, y = 0, 
  w = atlas_w, h = atlas_h, 
  hAlignment="centre", vAlignment="middle", 
  textXScale = 2, textYScale = 2, 
  text="Settings"
})
settingsButton:addChild(settingsText)

-- aboutBtn
aboutButton = director:createSprite(director.displayCenterX, director.displayCenterY -100, "asset/button_bg.png")
local atlas = aboutButton:getAtlas()
local atlas_w, atlas_h = atlas:getTextureSize()
aboutButton.xAnchor = 0.5
aboutButton.yAnchor = 0.5
aboutButton.xScale = 0.5
aboutButton.yScale = 0.5
aboutButton:addEventListener("touch", goToLeaderboard)
-- Create Continue Game button text
local aboutText = director:createLabel( {
  x = 0, y = 0, 
  w = atlas_w, h = atlas_h, 
  hAlignment="centre", vAlignment="middle", 
  textXScale = 2, textYScale = 2, 
  text="Leaderboard"
})
aboutButton:addChild(aboutText)
