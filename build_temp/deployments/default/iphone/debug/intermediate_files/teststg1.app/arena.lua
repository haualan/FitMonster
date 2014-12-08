
-- in the arena, you will see your neighbors kind of like in a dating site.

arenaScene = director:createScene()
director:createLabel(0, 0, 'this is the arena, fight your neighbors here: ' .. location:getLocationType())


-- 0. post my location (lon ,lat) to the server and the server will return the 50 closest users & their monsterstate object by distance
function postMyLonLat(lon, lat )
  local result = {}
  -- http post
  result = "postMyLonLat"

  return result
end

function getDst(lon1, lat1, lon2, lat2 )
  -- finds the euclidean distance between 2 pairs of lon lat coordinates
  local result = math.abs(lon1 - lat1) + math.abs(lon2 - lat2)


  return result
end






