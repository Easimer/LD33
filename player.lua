require "assets"

player = {}

player._sprites = {}
player._keystate = {}
player.pos = {x = 100, y = 100}
player.state = "idle"
player.vel = {x = 0, y = 0}
player.rot = 0

function player.load(self)
  self._sprites["idle"] = {
    frame = 1,
    maxframes = 2,
    frametime = 500,
    frames = {
      [1] = assets.load_image("data/player_idle1.png"),
      [2] = assets.load_image("data/player_idle2.png")
    }
  }
  self._sprites["moving"] = {
    frame = 1,
    maxframes = 2,
    frametime = 100,
    frames = {
      [1] = assets.load_image("data/player_idle1.png"),
      [2] = assets.load_image("data/player_idle2.png")
    }
  }
  print("Player loaded!")
end

function player.update(self, dt)
  --animation
  if not self._sprites[self.state].__ftime then
    self._sprites[self.state].__ftime = 0 --frame time counter
  end
  self._sprites[self.state].__ftime = self._sprites[self.state].__ftime + dt * 1000
  --if frame time counter is over frametime
  if self._sprites[self.state].__ftime >= self._sprites[self.state].frametime then
    if self._sprites[self.state].frame >= self._sprites[self.state].maxframes then
      self._sprites[self.state].frame = 1
    else
      self._sprites[self.state].frame = self._sprites[self.state].frame + 1
    end
    self._sprites[self.state].__ftime = 0
  end
  --physics stuff
  if self._keystate["w"] or self._keystate["up"] then
    --a padló koszos, a fal színes
    self.vel.x = self.vel.x + 100 * math.cos(self.rot) * dt
    if self.vel.x > 30 then
      self.vel.x = 30
    end
    self.vel.y = self.vel.y + 100 * math.sin(self.rot) * dt
    if self.vel.y > 30 then
      self.vel.y = 30
    end
  end
  if self._keystate["a"] or self._keystate["left"] then
    self.rot = self.rot - (5 * dt)
  end
  if self._keystate["s"] or self._keystate["down"] then
    self.vel.x = self.vel.x - self.vel.x / 2 * dt
    self.vel.y = self.vel.y - self.vel.y / 2 * dt
  end
  if self._keystate["d"] or self._keystate["right"] then
    self.rot = self.rot + (5 * dt)
  end
  --add velocity to position
  self.pos.x = self.pos.x + self.vel.x * 10 * dt
  self.pos.y = self.pos.y + self.vel.y * 10 * dt
  --slow down
  self.vel.x = self.vel.x - self.vel.x / 2 * dt
  self.vel.y = self.vel.y - self.vel.y / 2 * dt
end

function player.draw(self)
  love.graphics.print("Player state: " .. self.state)
  love.graphics.print("Player speed: " .. tostring(math.sqrt(math.pow(self.vel.x, 2) + math.pow(self.vel.x, 2))) .. " px/s", 0, 24)
  if not self._sprites[self.state] then
    return
  end
  love.graphics.draw(self._sprites[self.state].frames[self._sprites[self.state].frame],
    self.pos.x, self.pos.y, self.rot + (math.pi / 2), 2, 2,
    assets.get_current_frame(self._sprites[self.state]):getWidth() / 2,
    assets.get_current_frame(self._sprites[self.state]):getHeight() / 2)
end

function player.keypressed(self, key)
  self._keystate[key] = true
  if key == "w" or key == "up" or key == "s" or key == "down" then
    self.state = "moving"
  end
end

function player.keyreleased(self, key)
  self._keystate[key] = false
  if key == "w" or key == "up" or key == "s" or key == "down" then
    self.state = "idle"
  end
end