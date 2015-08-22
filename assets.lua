assets = {}

assets._assets = {}

--Load graphics asset
function assets.load_image(fn)
  img = love.graphics.newImage(fn)
  assets._assets[fn] = img
  return assets._assets[fn]
end

--Load font asset
function assets.load_font(fn)
  fnt = love.graphics.newFont(fn)
  assets._assets[fn] = fnt
  return assets._assets[fn]
end

--Load static sound asset
function assets.load_staticsound(fn)
  snd = love.audio.newSource(fn, "static")
  assets._assets[fn] = snd
  return assets._assets[fn]
end

--Load streaming sound asset
function assets.load_streamsound(fn)
  snd = love.audio.newSource(fn, "stream")
  assets._assets[fn] = snd
  return assets._assets[fn]
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
