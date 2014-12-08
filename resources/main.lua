-- Your app starts here!
local neighbors
local chosenMonsterIndex = 0 
local chosenNeighbor
pathS = system:getFilePath("storage")
SERVER = 'http://54.148.44.95:5000'


local testscene = require("test")

require("settingsMenu") -- put in your fitbit or moves account
require("barnMenu") -- equip beast, see status, and upgrade
local arenaScene = require("arena") -- fight others in the neighborhood
local battlegroundScene = require("battleground") -- where battle takes place
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
    elseif (scene_name == "battle") then
        director:moveToScene(battlegroundScene, {transitionType="slideInL", transitionTime=0.5})
    elseif (scene_name == "test") then
        director:moveToScene(testscene, {transitionType="slideInL", transitionTime=0.5})
    end
end




dbg.print("This is my app alan!")


director:setCurrentScene(nil)
director:moveToScene(mainMenuScene)

