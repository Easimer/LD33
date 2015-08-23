require "assets"

background = {}
background._image = nil
background.__mdraw = true --manual draw
background._nophysics = true --no collision
background.parallax = {
  left = false,
  right = false,
  up = false,
  down = false
}

function background.load(self)
  self._image = assets.load_image("data/background.png")
end

function background.draw(self)
  local drawx, drawy
  drawx = -768 + game.player.vel.x
  drawy = -576 + game.player.vel.y
  love.graphics.draw(self._image, drawx, drawy)
end

function background.update(self, dt)

end

function background.keypressed(self, key)
  if key == "w" then
    self.parallax.down = true
  end
  if key == "s" then
    self.parallax.up = true
  end
  if key == "a" then
    self.parallax.right = true
  end
  if key == "d" then
    self.parallax.left = true
  end
end

function background.keyreleased(self, key)
  if key == "w" then
    self.parallax.down = false
  end
  if key == "s" then
    self.parallax.up = false
  end
  if key == "a" then
    self.parallax.right = false
  end
  if key == "d" then
    self.parallax.left = false
  end
end
