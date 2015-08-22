entities = {}

entities._entlist = {}
entities._lastid = 0

--Create new entry in entities and return the ID
function entities.create_entity()
  entities._lastid = entities._lastid + 1
  newent = {}
  newent.id = entities._lastid
  newent.update = function(dt) end
  newent.draw = function() end
  newent.mousepressed = function(x,y,b) end
  newent.mousereleased = function(x,y,b) end
  newent.keypressed = function(k) end
  newent.keyreleased = function(k) end
  table.insert(entities._entlist, entities._lastid, newent)
  print("New entitity " .. tostring(newent) .. " created with ID " .. newent.id)
  return newent.id, newent
end

--Call update on every entity
function entities.update(dt)
  for k,v in pairs(entities._entlist) do
    v.update(dt)
  end
end

--Call draw on every entity
function entities.draw()
  for k,v in pairs(entities._entlist) do
    v.draw()
  end
end

--Return entity with ID `id`
function entities.get_entity(id)
  if entities._entlist[id] == nil then
    return nil
  end
  return entities._entlist[id]
end

entities.destroy_entity = function(id)
  entities._entlist.remove()
end

--Call mousepressed on every entity
function entities.mousepressed(x, y, b)
  for k,v in pairs(entities._entlist) do
    v.mousepressed(x,y,b)
  end
end

--Call mousereleased on every entity
function entities.mousereleased(x, y, b)
  for k,v in pairs(entities._entlist) do
    v.mousereleased(x,y,b)
  end
end

--Call keypressed on every entity
function entities.keypressed(key)
  for k,v in pairs(entities._entlist) do
    v.keypressed(key)
  end
end

--Call keyreleased on every entity
function entities.keyreleased(key)
  for k,v in pairs(entities._entlist) do
    v.keyreleased(key)
  end
end
