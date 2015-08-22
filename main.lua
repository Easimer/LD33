require "game"

--Load game
love.load = game.load or function() end
love.update = game.update or function(dt) end
love.draw = game.draw or function() end
love.mousepressed = game.mousepressed or function(x,y,b) end
love.mousereleased = game.mousereleased or function(x,y,b) end
love.keypressed = game.keypressed or function(k) end
love.keyreleased = game.keyreleased or function(k) end
love.focus = game.focus or function(f) end
love.mousefocus = game.mousefocus or function(f) end
love.mousemoved = game.mousemoved or function(x,y,dx,dy) end
love.resize = game.resize or function(x,y) end
love.quit = game.quit or function() end
love.textinput = game.textinput or function() end
love.visible = game.visible or function(v) end
love.threaderror = game.threaderror or function(t,errstr) end
love.errhand = game.errhand or love.errhand
print("init ok")
