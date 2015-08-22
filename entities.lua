entities = {}

entities._entlist = {}
entities._lastid = 0

--Create new entry in entities and return the new entity
function entities.create_entity()
  entities._lastid = entities._lastid + 1
  newent = {}
  newent.id = entities._lastid
  newent.load = function() end
  newent.update = function(dt) end
  newent.draw = function() end
  newent.mousepressed = function(x,y,b) end
  newent.mousereleased = function(x,y,b) end
  newent.keypressed = function(k) end
  newent.keyreleased = function(k) end
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
  ent.load = ent.load or function() end
  ent.update = ent.update or function(dt) end
  ent.draw = ent.draw or function() end
  ent.mousepressed = ent.mousepressed or function(x,y,b) end
  ent.mousereleased = ent.mousereleased or function(x,y,b) end
  ent.keypressed = ent.keypressed or function(k) end
  ent.keyreleased = ent.keyreleased or function(k) end
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
    v:draw()
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
