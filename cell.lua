require "assets"

cell = {}

function cell:load()
  self._sprites = {}
  self.pos = {x = 0, y = 0}
  self.state = "idle"
  self.vel = {x = 0, y = 0}
  self.rot = 0
  self._sprites["idle"] = {
    frame = 1,
    maxframes = 1,
    frametime = 1000,
    frames = {
      [1] = assets.load_image("data/cell_idle.png"),
    }
  }
  self._sprites["infected"] = {
    frame = 1,
    maxframes = 1,
    frametime = 1000,
    frames = {
      [1] = assets.load_image("data/cell_infected.png"),
    }
  }
end

function cell:update(dt)
  self.rot = self.rot + 1 * dt
end

function cell:draw()
  love.graphics.draw(self._sprites[self.state].frames[1], self.pos.x - game.camera.x, self.pos.y - game.camera.y, self.rot, 1, 1, self._sprites[self.state].frames[1]:getWidth() / 2, self._sprites[self.state].frames[1]:getHeight() / 2)
end
