i2c.setup(0, 2, 1, i2c.SLOW)
menu = require "menu"
keypad = require "keypad"

data = { 
  "device #1", 
  "device #2", 
  "device #3", 
  "device #4", 
  "device #5",
  "device #6",
  "device #7",
  "device #8",
  "device #9"
}

menu.init(data)

keypad.start(function(k)
  if k == 61 then
    menu.moveUp()
  end
  if k == 117 then
    menu.moveDown()
  end
end)
