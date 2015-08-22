require "assets"

background = {}
background._image = nil
background.offset = {x = 0, y = 0}
background.__mdraw = true --manual draw

function background.load(self)
  self._image = assets.load_image("data/background.png")
end

function background.draw(self)
  love.graphics.draw(self._image, self.offset.x, self.offset.y)
end

function background.update(self, dt)
  
end
