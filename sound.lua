require "assets"

soundsys = {}

--Background music which is looped
soundsys.ambient = {}

--Background music which is controllable
soundsys.bgmusic = {}

--Add asset called `name` to the sound system, with name `ssysname`
function soundsys.add_ambient(name, ssysname)
  local asset = assets.get(name)
  if not asset then return end
  soundsys.ambient[ssysname] = asset
  soundsys.ambient[ssysname]:setLooping(true)
  love.audio.play(soundsys.ambient[ssysname])
end

function soundsys.add_bgmusic(name, ssysname)
  local asset = assets.get(name)
  if not asset then return end
  soundsys.bgmusic[ssysname] = asset
end

function soundsys.rem_ambient(ssysname)
  amb = soundsys.ambient[ssysname]
  if amb then
    love.audio.stop(amb)
    soundsys.ambient[ssysname] = nil
  end
end

function soundsys.rem_bgmusic(ssysname)
  bgm = soundsys.bgmusic[ssysname]
  if bgm then
    love.audio.stop(bgm)
    soundsys.bgmusic[ssysname] = nil
  end
end

function soundsys.play_sfx(name)
  love.audio.play(assets.get(name))
end

function soundsys.reset()
  for k,_ in pairs(soundsys.ambient) do
    love.audio.stop(soundsys.ambient[k])
    soundsys.ambient[k] = nil
  end
  for k,_ in pairs(soundsys.bgmusic) do
    love.audio.stop(soundsys.bgmusic[k])
    soundsys.bgmusic[k] = nil
  end
end
