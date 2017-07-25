local m = {}

local counter = require "counter"

-- private
local lcd = dofile("lcd1602.lua")(63)
local itemPos = 1
local cursorPos = 1
local lastPos = 1
local data = {}

local function log(t)
  for i=1,#t do
    print(t[i].name)
  end
end

local function subrange(t, first, last)
  local sub = {}
  for i=first,last do
    sub[#sub + 1] = t[i]
  end
  return sub
end

local function draw(d)
  log(d)

  if #d < 4 then
    limit = #d
  else
    limit = 4
  end

  for i=1, limit do
    lcd:put(lcd:locate(i-1, 0), d[i].name)
  end
end

local function moveCursor(r)
  lcd:light(1)
  counter.reset()
  lcd:put(lcd:locate(lastPos - 1, 19), " ")
  lcd:put(lcd:locate(r - 1, 19), "<")
  lastPos = r
end

local function scroll()
  s = itemPos - cursorPos + 1
  window = subrange(data, s, s + 3)
  draw(window)
end

-- public

function m.init(d)
  counter.init(function()
    lcd:light()
  end)

  itemPos = 1
  cursorPos = 1
  lastPos = 1
  data = d
  lcd:clear()
  draw(data)
  lcd:put(lcd:locate(0, 19), "<")
end

function m.fill(d)
  lcd:light(1)
  counter.reset()
  itemPos = 1
  cursorPos = 1
  lastPos = 1
  data = d
  lcd:clear()
  draw(data)
  lcd:put(lcd:locate(0, 19), "<")
end

function m.moveDown()
  if itemPos < #data then
    itemPos = itemPos + 1
    if cursorPos < 4 then
      cursorPos = cursorPos + 1
      moveCursor(cursorPos)
    else
      scroll()
    end
  end
end

function m.moveUp()
  if itemPos > 1 then
    itemPos = itemPos - 1
    if cursorPos > 1 then
      cursorPos = cursorPos - 1
      moveCursor(cursorPos)
    else
      scroll()
    end
  end
end

function m.currentItem()
  return data[itemPos]
end

return m
