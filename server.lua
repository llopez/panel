local m = {}
local data = {}

function m.getMenu(callback)
  http.get("http://192.168.0.13:3000/api/v1/devices/menu", nil, function(code, d)
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
  http.put('http://192.168.0.13:3000'..t.path, 'Content-Type: application/json\r\n', body, function(code, d)
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
