require "entities"

function love.load()
end

function love.update(dt)
  entities.update(dt)
end

function love.draw()
  entities.draw()
end

function love.mousepressed(x, y, button)
  entities.mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
  entities.mousereleased(x, y, button)
end

function love.keypressed(key)
  entities.keypressed(key)
end

function love.keyreleased(key)
  entities.keyreleased(key)
end
