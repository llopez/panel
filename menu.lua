local m = {}

-- private
local lcd = dofile("lcd1602.lua")(63)
local itemPos = 1
local cursorPos = 1
local lastPos = 1
local data = {}
local x = 0

local function resetCounter()
  lcd:light(1)
  x = 0
end

local function incCounter()
  x = x + 1
  if x == 30 then
    lcd:light()
    x = 0
  end
  tmr.create():alarm(1000, tmr.ALARM_SINGLE, function()
    incCounter()
  end)
end

local function log(t)
  for i=1,#t do
    print(t[i])
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
  for i=1, 4 do
    lcd:put(lcd:locate(i-1, 0), d[i])
  end
end

local function moveCursor(r)
  resetCounter()
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
  data = d
  lcd:clear()
  draw(data)
  lcd:put(lcd:locate(0, 19), "<")
  incCounter()
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
