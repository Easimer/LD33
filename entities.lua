entities = {}

entities._entlist = {}
entities._lastid = 0

--Create new entry in entities and return the ID
entities.create_entity = function()
  entities._lastid = entities._lastid + 1
  newent = {}
  newent.id = entities._lastid
  newent.update = function(dt) end
  newent.draw = function() end
  table.insert(entities._entlist, entities._lastid, newent)
  print("New entitity " .. tostring(newent) .. " created with ID " .. newent.id)
  return newent.id, newent
end

--Call update on every entity
entities.update = function(dt)
  for k,v in pairs(entities._entlist) do
    v.update(dt)
  end
end

--Call draw on every entity
entities.draw = function()
  for k,v in pairs(entities._entlist) do
    v.draw()
  end
end

--Return entity with ID `id`
entities.get_entity = function(id)
  if entities._entlist[id] == nil then
    return nil
  end
  return entities._entlist[id]
end

entities.destroy_entity = function(id)
  entities._entlist.remove()
end
