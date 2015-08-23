require "collision"

entities = {}

entities._entlist = {}
entities._lastid = 0

--Create new entry in entities and return the new entity
function entities.create_entity()
  entities._lastid = entities._lastid + 1
  newent = {}
  newent.id = entities._lastid
  newent.load = function(s) end
  newent.update = function(s,dt) end
  newent.draw = function(s) end
  newent.mousepressed = function(s,x,y,b) end
  newent.mousereleased = function(s,x,y,b) end
  newent.keypressed = function(s,k) end
  newent.keyreleased = function(s,k) end
  newent.tick = function(s) end
  newent.collision = function(s,o) end
  entities._entlist[entities._lastid] = newent
  --table.insert(entities._entlist, entities._lastid, newent)
  print("New entitity " .. tostring(newent) .. " created with ID " .. newent.id)
  return newent
end

--Add entity to the system
--Missing members like update, id, draw, etc., will be declared.
function entities.add_entity(ent)
  ent = ent
  entities._lastid = entities._lastid + 1
  ent.id = entities._lastid
  ent.load = ent.load or function(s) end
  ent.update = ent.update or function(s,dt) end
  ent.draw = ent.draw or function(s) end
  ent.mousepressed = ent.mousepressed or function(s,x,y,b) end
  ent.mousereleased = ent.mousereleased or function(s,x,y,b) end
  ent.keypressed = ent.keypressed or function(s,k) end
  ent.keyreleased = ent.keyreleased or function(s,k) end
  ent.tick = ent.tick or function(s) end
  ent.collision = ent.collision or function(s,o) end
  entities._entlist[entities._lastid] = ent
  print("Entity " .. tostring(ent) .. " added with ID " .. ent.id)
  ent:load()
  return ent
end

--Call update on every entity
function entities.update(dt)
  for k,v in pairs(entities._entlist) do
    v:update(dt)
  end
end

--Call draw on every entity
function entities.draw()
  for k,v in pairs(entities._entlist) do
    if not v.__mdraw then
      v:draw()
    end
  end
end

--Return entity with ID `id`
function entities.get_entity(id)
  if entities._entlist[id] == nil then
    return nil
  end
  return entities._entlist[id]
end

function entities.destroy_entity(id)
  if not entities._entlist[id] == nil then
    entities._entlist[id] = nil
  end
end

--Call mousepressed on every entity
function entities.mousepressed(x, y, b)
  for k,v in pairs(entities._entlist) do
    v:mousepressed(x,y,b)
  end
end

--Call mousereleased on every entity
function entities.mousereleased(x, y, b)
  for k,v in pairs(entities._entlist) do
    v:mousereleased(x,y,b)
  end
end

--Call keypressed on every entity
function entities.keypressed(key)
  for k,v in pairs(entities._entlist) do
    v:keypressed(key)
  end
end

--Call keyreleased on every entity
function entities.keyreleased(key)
  for k,v in pairs(entities._entlist) do
    v:keyreleased(key)
  end
end

function entities.tick()
  for k,v in pairs(entities._entlist) do
    v:tick()
  end
  entities.collision()
end

function table.contains(t, e)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

--Collision check
function entities.collision()
  --start = os.clock()
  already = {}
  for k,v in pairs(entities._entlist) do
    for k2,v2 in pairs(entities._entlist) do
      if (not table.contains(already, {k, k2})) or (not table.contains(already, {k2, k})) then
        if not (k == k2) then
          if (not v._nophysics) and (not v2._nophysics) then
            if collision.rect2(v:getX(), v:getY(), v:getW(), v:getH(), v2:getX(), v2:getY(), v2:getW(), v2:getH()) then
              v:collision(v2)
              v2:collision(v)
              --print("CollCheck(" .. k .. "," .. k2 .. "): COLLISION!!!!!")
            else
              --print("CollCheck(" .. k .. "," .. k2 .. "): check ok, no collision")
            end
          else
            --print("CollCheck(" .. k .. "," .. k2 .. "): no check: physics disabled")
          end
        else
          --print("CollCheck(" .. k .. "," .. k2 .. "): no check: ents are the same")
        end
        table.insert(already, {k, k2})
      end
    end
  end
  --print("CollCheck: finished under " .. tostring(os.clock() - start) .. " seconds!")
end

function entities.get_nearest(id)
  local nearest = 0
  local nearest_dist = 5.6e300
  local center = entities.get_entity(id)
  if not center then return nil end
  if (not center.getX) or (not center.getY) then return nil end
  for k,v in pairs(entities._entlist) do
    if v.getX and v.getY then
      local distance = math.sqrt(math.pow(center:getX() + v:getX(), 2) + math.pow(center:getY() + v:getY(), 2))
      if distance <= nearest_dist then
        nearest_dist = distance
        nearest = v.id
      end
    end
  end
  return nearest
end
