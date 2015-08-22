assets = {}

assets._assets = {}

--Load graphics asset
function assets.load_image(fn)
  if not assets._assets[fn] then
    assets._assets[fn] = love.graphics.newImage(fn)
    print("assets.lua: Loaded new asset " .. fn)
  end
  return assets._assets[fn]
end

--Load font asset
function assets.load_font(fn)
  if not assets._assets[fn] then
    assets._assets[fn] = love.graphics.newFont(fn)
    print("assets.lua: Loaded new asset " .. fn)
  end
  return assets._assets[fn]
end

--Load static sound asset
function assets.load_staticsound(fn)
  if not assets._assets[fn] then
    assets._assets[fn] = love.graphics.newSource(fn, "static")
    print("assets.lua: Loaded new asset " .. fn)
  end
  return assets._assets[fn]
end

--Load streaming sound asset
function assets.load_streamsound(fn)
  if not assets._assets[fn] then
    assets._assets[fn] = love.graphics.newSource(fn, "stream")
    print("assets.lua: Loaded new asset " .. fn)
  end
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
