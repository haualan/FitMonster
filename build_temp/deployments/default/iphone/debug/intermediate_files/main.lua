-- Your app starts here!

require("settingsMenu") -- put in your fitbit or moves account
require("barnMenu") -- equip beast, see status, and upgrade
require("arena") -- fight others
require("mainMenu") -- splash screen upon opening


function switchToScene(scene_name)
    if (scene_name == "settings") then
        director:moveToScene(settingsMenuScene, {transitionType="slideInL", transitionTime=0.5})
    elseif (scene_name == "barn") then
        director:moveToScene(barnMenuScene, {transitionType="slideInL", transitionTime=0.5})
    elseif (scene_name == "arena") then
        director:moveToScene(arenaScene, {transitionType="slideInL", transitionTime=0.5})
    elseif (scene_name == "main") then
        director:moveToScene(mainMenuScene, {transitionType="slideInL", transitionTime=0.5})
    end
end




-- local gemTween
-- local currentScore = 0


-- print("This is my app alan!")
-- director:createLabel(0, 0, 'Hello, World hi alan! this is a ong paragrapgdhdd o ao =cu d u!')
-- local label = director:createLabel(0, 0, 'Hello, World!' .. director.displayWidth .. ',' ..  system:getTime())
-- label.color = color.cyan

-- local button = director:createSprite(
--   {x = director.displayCenterX, 
--   y= director.displayCenterY, 
--   source ="asset/matcha.png",
--   xAnchor=0.5,
--   yAnchor=0.5
--   })


-- -- Create a label to display the score
-- local scoreLabel = director:createLabel( {
--     x=0, y=director.displayHeight - 30,
--     w=director.displayWidth, h = 30,
--     hAlignment="left", vAlignment="top",
--     text="0",
--     color=color.yellow
--     })

-- function button:touch(event)
--     if (event.phase == 'began') then
--         local r = math.random(0, 255)
--         local g = math.random(0, 255)
--         local b = math.random(0, 255)
--         self:setColor(r, g, b)
--     end

--     if (event.phase == "ended") then
--         dbg.print("Gem was touched")
--         -- make gem tween
--         if (gemTween == nil) then
--           -- Create a tween that scales the gem up and down
--           gemTween = tween:to(button, {
--           xScale=2,
--           yScale=0.5,
--           time=1,
--           mode="mirror"
--           } )

--           -- Update the score
--           currentScore = currentScore + 10
--           scoreLabel.text = currentScore

--         else
--           -- cancel the tween
--           tween:cancel(gemTween)
--           -- Destroy the tween
--           gemTween = nil
--           --Reset the gems xScale to 1.0
--           button.xScale = 1 ; button.yScale = 1
--         end
--     end
-- end
-- button:addEventListener('touch', button)

-- function continueGame( )
--   print("continueGame")
--   -- body
-- end

-- -- Create Continue Game button
-- continueGameButton = director:createSprite(director.displayCenterX, director.displayCenterY + 100, "asset/matcha.png")
-- local atlas = continueGameButton:getAtlas()
-- local atlas_w, atlas_h = atlas:getTextureSize()
-- continueGameButton.xAnchor = 0.5
-- continueGameButton.yAnchor = 0.5
-- continueGameButton.xScale = 3
-- continueGameButton.yScale = 3
-- continueGameButton:addEventListener("touch", continueGame)
-- -- Create Continue Game button text
-- local label = director:createLabel( {
--     x = 0, y = 0,
--     w = atlas_w, h = atlas_h,
--     hAlignment="centre", vAlignment="middle",
--     textXScale = 1, textYScale = 1,
--     text="Continue"
-- })
-- continueGameButton:addChild(label)
