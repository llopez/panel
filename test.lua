i2c.setup(0, 2, 1, i2c.SLOW)
lcd = dofile("lcd1602.lua")(63)
lcd:clear()
lcd:put(lcd:locate(1, 7), "Hello!")
lcd:put(lcd:locate(2, 2), "Welcome to Panel")

