module("luci.controller.smartmini", package.seeall)

function index()
    entry({"admin", "status", "smartmini"}, call("action_index"), _("硬盘健康监测"), 30).dependent = false
end

local http = require "luci.http"

function action_index()
    local f = io.popen("smartctl --scan")
    local devices = {}
    if f then
        for line in f:lines() do
            local dev = line:match("(/dev/%S+)")
            if dev then table.insert(devices, dev) end
        end
        f:close()
    end

    local out = ""
    if #devices > 0 then
        local dev = devices[1] -- 先显示第一个硬盘详细信息
        local cmd = "smartctl -a " .. dev .. " 2>/dev/null"
        local f2 = io.popen(cmd)
        if f2 then
            out = f2:read("*a")
            f2:close()
        end
    else
        out = "未检测到支持SMART的硬盘设备"
    end

    http.prepare_content("text/plain; charset=utf-8")
    http.write(out)
end

