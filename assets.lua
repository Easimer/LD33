assets = {}

assets._assets = {}

--Load graphics asset
function assets.load_image(fn, name)
  img = love.graphics.newImage(fn)
  assets._assets[name] = img
  return assets._assets[name]
end

--Load font asset
function assets.load_font(fn, name)
  fnt = love.graphics.newFont(fn)
  assets._assets[name] = fnt
  return assets._assets[name]
end

--Load static sound asset
function assets.load_staticsound(fn, name)
  snd = love.audio.newSource(fn, "static")
  assets._assets[name] = snd
  return assets._assets[name]
end

--Load streaming sound asset
function assets.load_streamsound(fn, name)
  snd = love.audio.newSource(fn, "stream")
  assets._assets[name] = snd
  return assets._assets[name]
end

--Get asset by name
function assets.get(name)
  return assets._assets[name]
end

--Unload asset called `name`
function assets.unload(name)
  assets._assets[name] = nil
end

function assets.get_current_frame(animation)
  return animation.frames[animation.frame];
end
