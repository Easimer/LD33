entities = {}

entities._entlist = {}
entities._lastid = -1

entities.create_entity = function()
  entities._lastid = entities._lastid + 1
  entities._entlist[entities._lastid] = {}
  newent = entities._entlist[entities._lastid]
  newent.id = entities._lastid
  newent.update = function(dt) end
  newent.draw = function() end
  print("New entitity created with ID " .. newent.id)
end

entities.update = function(dt)

end

entities.draw = function()

end
