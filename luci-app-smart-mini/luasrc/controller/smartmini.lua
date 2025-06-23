module("luci.controller.smartmini", package.seeall)

function index()
  entry({"admin", "status", "smartmini"}, template("smartmini"), _("硬盘健康监测"), 30).dependent = false
  entry({"admin", "status", "smartmini", "api"}, call("api_smartinfo")).leaf = true
end

local luci_http = require "luci.http"

function api_smartinfo()
  local handle = io.popen("smartctl --scan")
  local devices = {}
  if handle then
    for line in handle:lines() do
      local dev = line:match("(/dev/%S+)")
      if dev then
        table.insert(devices, dev)
      end
    end
    handle:close()
  end

  local disk = luci_http.formvalue("disk") or (devices[1] or "")
  if disk == "" then
    luci_http.write_json({error="未找到硬盘设备"})
    return
  end

  local cmd = "smartctl -a " .. disk .. " 2>/dev/null"
  local output = {}
  local f = io.popen(cmd)
  if f then
    for line in f:lines() do
      table.insert(output, line)
    end
    f:close()
  end

  luci_http.prepare_content("application/json")
  luci_http.write_json({devices=devices, disk=disk, output=output})
end

