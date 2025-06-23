local http = require "luci.http"

function main()
  local disk = http.formvalue("disk") or ""
  local res = {}
  local handle = io.popen("smartctl --scan")
  res.devices = {}
  if handle then
    for line in handle:lines() do
      local dev = line:match("(/dev/%S+)")
      if dev then table.insert(res.devices, dev) end
    end
    handle:close()
  end

  if disk == "" then
    disk = res.devices[1] or ""
  end

  res.disk = disk
  res.output = {}
  if disk ~= "" then
    local f = io.popen("smartctl -a " .. disk .. " 2>/dev/null")
    if f then
      for line in f:lines() do
        table.insert(res.output, line)
      end
      f:close()
    end
  end

  http.prepare_content("application/json")
  http.write_json(res)
end

