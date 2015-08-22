require "entities"

function love.load()
end

function love.update(dt)
  entities.update(dt)
end

function love.draw()
  entities.draw()
end
