-- settingsMenu
settingsMenuScene = director:createScene()

--UI
local saveButton
local saveText


function goToMain(event)
  -- save whatever is entered in the settings and go back to main menu
  switchToScene("main")
end

-- Create menu background
local background = director:createSprite(director.displayCenterX, director.displayCenterY, "asset/bkg.jpg")
background.xAnchor = 0.5
background.yAnchor = 0.5
-- Fit background to screen size
background.xScale = director.displayWidth / 768
background.yScale = director.displayHeight / 1136



director:createLabel(0, 0, 'this is the settings menu')


-- DoneButton saves and redirects to Main Menu
saveButton = director:createSprite(director.displayCenterX, director.displayHeight * 0.10, "asset/button_bg.png")
local atlas = saveButton:getAtlas()
local atlas_w, atlas_h = atlas:getTextureSize()
saveButton.xAnchor = 0.5
saveButton.yAnchor = 0.5
saveButton.xScale = 0.5
saveButton.yScale = 0.5
saveButton:addEventListener("touch", goToMain)
-- Create Continue Game button text
local saveText = director:createLabel( {
  x = 0, y = 0, 
  w = atlas_w, h = atlas_h, 
  hAlignment="centre", vAlignment="middle", 
  textXScale = 2, textYScale = 2, 
  text="Save"
})
saveButton:addChild(saveText)