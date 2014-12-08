--[[
MainMenu scene.
--]]

local scene = director:createScene()
scene.name = "Scene: Menu"

local dw = director.displayWidth
local dh = director.displayHeight
function scene:setUp(event)
  dbg.print("scene1:setUp")

  self.obj0 = director:createLabel( {
    x=4, y=dh - 24, text="MAIN MENU",
    zOrder = 1, color=color.white,
    } )


end
function scene:tearDown(event)
  dbg.print("scene1:tearDown")
    self.obj0:removeFromParent()
    self.obj1:removeFromParent()
  self.obj0 = nil
  self.obj1 = nil
end
function scene:enterPreTransition(event)
  dbg.print("scene1:enterPreTransition")
end
function scene:enterPostTransition(event)
  dbg.print("scene1:enterPostTransition")
end
function scene:exitPreTransition(event)
  dbg.print("scene1:exitPreTransition")
end
function scene:exitPostTransition(event)
  dbg.print("scene1:exitPostTransition")
end

-- Add multiple event listeners to the same object
scene:addEventListener( { "setUp", "tearDown", "enterPreTransition",
  "enterPostTransition", "exitPreTransition", "exitPostTransition" }, scene)

return scene
