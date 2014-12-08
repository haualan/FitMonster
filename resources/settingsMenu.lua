-- settingsMenu
settingsMenuScene = director:createScene()

--UI
local saveButton
local saveText


function goToMain(event)
  -- save whatever is entered in the settings and go back to main menu
  switchToScene("main")
end

function showFitBitInput(event)
  if (event.phase == "ended") then
    fitbitUID = loadFitBitInput()
    fitbitUID = nui:readString("type in fitbit userID here", "url", fitbitUID)
    
    print("on fitbitUID:" .. fitbitUID )
    saveFitBitInput()
  end

end

function saveFitBitInput()
    local file = io.open(pathS .. "SettingsData.txt", "w")
    file:write(fitbitUID.."\n")
    file:close()
end
 
function loadFitBitInput()
    local file = io.open(pathS .. "SettingsData.txt","r")
    -- Note: if io.open returned nil, the highscore file does not exist yet.
    if file ~= nil then
        fitbitUID = file:read()
    else 
    -- you are a new player with no data, initialize new monster and save it
        fitbitUID = "00000"
        saveFitBitInput()
    end

    file:close()



    return fitbitUID
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

-- fitbitButton links to fitbit account
fitbitButton = director:createSprite(director.displayCenterX, director.displayHeight * 0.25, "asset/button_bg.png")
local atlas = fitbitButton:getAtlas()
local atlas_w, atlas_h = atlas:getTextureSize()
fitbitButton.xAnchor = 0.5
fitbitButton.yAnchor = 0.5
fitbitButton.xScale = 0.5
fitbitButton.yScale = 0.5
fitbitButton:addEventListener("touch", showFitBitInput)
-- Create Continue Game button text
local fitbitButtonText = director:createLabel( {
  x = 0, y = 0, 
  w = atlas_w, h = atlas_h, 
  hAlignment="centre", vAlignment="middle", 
  textXScale = 2, textYScale = 2, 
  text="Link Fitbit Account"
})
fitbitButton:addChild(fitbitButtonText)


