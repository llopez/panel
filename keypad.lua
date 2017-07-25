local m = {}

local function w(b)
  i2c.start(0)
  i2c.address(0, 56, i2c.TRANSMITTER)
  i2c.write(0, b)
  i2c.stop(0)
end

local function r()
  i2c.start(0)
  i2c.address(0, 56, i2c.RECEIVER)
  reg = i2c.read(0,1)
  i2c.stop(0)
  return string.byte(reg)
end

function m.start(callback)
  local cols = {126, 125, 123}
  for k, v in pairs(cols) do
    w(v)
    reg = r()
    if v ~= reg then
      callback(reg)
    end
  end

  tmr.create():alarm(250, tmr.ALARM_SINGLE, function()
    m.start(callback)
  end)
end

return m
