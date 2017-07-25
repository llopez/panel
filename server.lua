local m = {}
local data = {}

local url = "http://" .. config.srv.ip .. ":" .. config.srv.port
local header = "Content-Type: application/json\r\nAuthorization: Token token=" .. config.srv.token .. "\r\n"

function m.getMenu(callback)
  http.get(url .. "/api/v1/devices/menu", header, function(code, d)
    if (code < 0) then
      print("HTTP request failed")
    else
      data = sjson.decode(d)
      callback(data)
    end
  end)
end

function m.put(t, callback)
  body = '{"state":"'..t.value..'"}'
  http.put(url .. t.path, header, body, function(code, d)
    if (code < 0) then
      print("HTTP request failed")
    else
      callback()
    end
  end)
end

function m.data()
  return data
end

return m
