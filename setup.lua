local module = {}

local function wifi_wait_ip()  
  if wifi.sta.getip()== nil then
    print("IP unavailable, Waiting...")
  else
    tmr.stop(1)
    print("\n====================================")
    print("ESP8266 mode is: " .. wifi.getmode())
    print("MAC address is: " .. wifi.ap.getmac())
    print("IP is "..wifi.sta.getip())
    print("====================================")
    app.start()
  end
end

local function wifi_start()
  wifi.sta.config("Luigi","lacasadeluigi2016")
  wifi.sta.connect()
  print("Connecting to " .. "Luigi" .. " ...")
  tmr.alarm(1, 2500, 1, wifi_wait_ip)
end

function module.start()  
  print("Configuring Wifi ...")
  wifi.setmode(wifi.STATION)
  wifi_start()
end

return module
