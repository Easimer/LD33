require "class"
require "assets"
require "entities"
require "player"
require "background"
require "cell"
require "sound"

game = {
  ticktime = 0,
  player = nil,
  camera = {
    x = 0,
    y = 0
  },
  background = nil,
}

function game.load()
  love.window.setTitle("Vector Decay") --working title
  love.window.setMode(1024, 768)
  game.player = entities.add_entity(class(player))
  p2 = entities.add_entity(class(player))
  p2._controlled = false
  p2.pos = {x = 0, y = 0}
  game.background = entities.add_entity(background)
  entities.add_entity(class(cell)).pos = {x = 25, y = 300}
end

function game.update(dt)
  entities.update(dt)
  game.ticktime = game.ticktime + dt
  if game.ticktime >= 0.05 then
    entities.tick()
    game.ticktime = 0
  end
end

function game.draw()
  game.background:draw()
  entities.draw()
end

function game.mousepressed(x, y, button)
  entities.mousepressed(x, y, button)
end

function game.mousereleased(x, y, button)
  entities.mousereleased(x, y, button)
end

function game.keypressed(key)
  entities.keypressed(key)
end

function game.keyreleased(key)
  entities.keyreleased(key)
end

local function error_printer(msg, layer)
	print((debug.traceback("Error: " .. tostring(msg), 1+(layer or 1)):gsub("\n[^\n]+$", "")))
end

function game.errhand(msg)
	msg = tostring(msg)
  print("FATAL ERROR")
	error_printer(msg, 2)

	if not love.window or not love.graphics or not love.event then
		return
	end

	if not love.graphics.isCreated() or not love.window.isCreated() then
		local success, status = pcall(love.window.setMode, 800, 600)
		if not success or not status then
			return
		end
	end
	if love.mouse then
		love.mouse.setVisible(true)
		love.mouse.setGrabbed(false)
	end
	if love.joystick then
		for i,v in ipairs(love.joystick.getJoysticks()) do
			v:setVibration()
		end
	end
	if love.audio then love.audio.stop() end
	love.graphics.reset()
	local font = love.graphics.setNewFont(math.floor(love.window.toPixels(14)))
	local sRGB = select(3, love.window.getMode()).srgb
	if sRGB and love.math then
		love.graphics.setBackgroundColor(love.math.gammaToLinear(0, 0, 0))
	else
		love.graphics.setBackgroundColor(0, 0, 0)
	end
	love.graphics.setColor(255, 255, 255, 255)
	local trace = debug.traceback()
	love.graphics.clear()
	love.graphics.origin()
	local err = {}
	table.insert(err, "Error\n")
	table.insert(err, msg.."\n\n")
	for l in string.gmatch(trace, "(.-)\n") do
		if not string.match(l, "boot.lua") then
			l = string.gsub(l, "stack traceback:", "Traceback\n")
			table.insert(err, l)
		end
	end
  table.insert(err, "\n\nSend report to: easimer@gmail.com")
	local p = table.concat(err, "\n")
	p = string.gsub(p, "\t", "")
	p = string.gsub(p, "%[string \"(.-)\"%]", "%1")
  local logofont = love.graphics.newFont(math.floor(love.window.toPixels(24)))
	local function draw()
		local pos = love.window.toPixels(100)
		love.graphics.clear()
    love.graphics.setFont(logofont)
    love.graphics.print("Vector Decay", love.window.toPixels(95), love.window.toPixels(38))
    love.graphics.setFont(font)
		love.graphics.printf(p, pos, pos, love.graphics.getWidth() - pos)
		love.graphics.present()
	end
	while true do
		love.event.pump()
		for e, a, b, c in love.event.poll() do
			if e == "quit" then
				return
			end
			if e == "keypressed" and a == "escape" then
				return
			end
		end
		draw()
		if love.timer then
			love.timer.sleep(0.1)
		end
	end
end
