local m = {}

i2c.setup(0, 2, 1, i2c.SLOW)
local menu = require "menu"
local keypad = require "keypad"
local server = require "server"

function m.start()
  server.getMenu(function(data)
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
          server.put(currentItem, function()
            menu.fill(data)
          end)
        end
      end
    end)
  end)
end

return m
