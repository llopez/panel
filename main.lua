i2c.setup(0, 2, 1, i2c.SLOW)
menu = require "menu"
keypad = require "keypad"

data = {
  {
    name = 'Light #1', menu = {
      { name = 'on', field = 'state', value = 'on', path = '/devices/1' },
      { name = 'off', field = 'state', value = 'off', path = '/devices/1' }
    }
  },
  {
    name = 'Light #2', menu = {
      { name = 'on', field = 'state', value = 'on', path = '/devices/2' },
      { name = 'off', field = 'state', value = 'off', path = '/devices/2' }
    }
  },
  {
    name = 'Light #3', menu = {
      { name = 'on', field = 'state', value = 'on', path = '/devices/3' },
      { name = 'off', field = 'state', value = 'off', path = '/devices/3' }
    }
  },
  {
    name = 'Light #4', menu = {
      { name = 'on', field = 'state', value = 'on', path = '/devices/4' },
      { name = 'off', field = 'state', value = 'off', path = '/devices/4' }
    }
  },
  {
    name = 'AirCon #1', menu = {
      { name = 'on', field = 'state', value = 'on', path = '/devices/5' },
      { name = 'off', field = 'state', value = 'off', path = '/devices/5' },
    }
  }
}

menu.init(data)

keypad.start(function(k)
  if k == 61 then
    menu.moveUp()
  end
  if k == 117 then
    menu.moveDown()
  end
  if k == 118 then
    currentItem = menu.currentItem()
    if currentItem.menu then
      submenu = currentItem.menu
      menu.fill(submenu)
    else
      print("action", currentItem.name)
      menu.fill(data)
    end
  end
end)
