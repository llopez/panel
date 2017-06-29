i2c.setup(0, 2, 1, i2c.SLOW)
lcd = dofile("lcd1602.lua")(63)
lcd:clear()

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

for i=1, 4 do
  lcd:put(lcd:locate(i-1, 0), data[i])
end

itemPos = 1
cursorPos = 1
lastPos = 1

lcd:put(lcd:locate(0, 19), "<")

function subrange(t, first, last)
  local sub = {}
  for i=first,last do
    sub[#sub + 1] = t[i]
  end
  return sub
end

function moveCursor(r)
  lcd:put(lcd:locate(lastPos - 1, 19), " ")
  lcd:put(lcd:locate(r - 1, 19), "<")
  lastPos = r
end


function shiftUp()
  print("shift up")
  s = itemPos - cursorPos + 1
  window = subrange(data, s, s + 4)

  for i=1, 4 do
    lcd:put(lcd:locate(i-1, 0), window[i])
  end
end

function shiftDown()
  print("shift down")
  s = itemPos - cursorPos + 1
  window = subrange(data, s, s + 4)

  for i=1, 4 do
    lcd:put(lcd:locate(i-1, 0), window[i])
  end
end

function moveDown()
  if itemPos < #data then
    itemPos = itemPos + 1
    if cursorPos < 4 then
      cursorPos = cursorPos + 1
      moveCursor(cursorPos)
    else
      shiftUp()
    end
  end
  print("itemPos", itemPos)
  print("cursorPos", cursorPos)
end

function moveUp()
  if itemPos > 1 then
    itemPos = itemPos - 1
    if cursorPos > 1 then
      cursorPos = cursorPos - 1
      moveCursor(cursorPos)
    else
      shiftDown()
    end
  end
  print("itemPos", itemPos)
  print("cursorPos", cursorPos)
end

