local m = {}
local x = 0

local function loop(callback)
  if x < 10 then
    x = x + 1
  else
    callback()
    x = 0
  end
  tmr.create():alarm(1000, tmr.ALARM_SINGLE, function()
    loop(callback)
  end)
end

function m.init(callback)
  x = 0
  loop(callback)
end

function m.reset()
  x = 0
end

return m

