require "assets"
require "entities"
require "player"

game = {
  ticktime = 0
}

function love.load()
  entities.add_entity(player)
end

function love.update(dt)
  entities.update(dt)
  if game.ticktime > 0.05 then
    entities.tick()
    game.ticktime = 0
  end
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
