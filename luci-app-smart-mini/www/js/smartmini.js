"use strict";

L.define("view.smartmini", function() {
  return L.view.extend({
    load: function() {
      return L.resolveDefault(L.http.get("/admin/status/smartmini/api"), {});
    },
    render: function(data) {
      if (!data.devices || data.devices.length === 0) {
        return E("div", _("未检测到硬盘设备"));
      }

      var sel = E("select", {id: "disk_select"});
      data.devices.forEach(function(dev) {
        sel.appendChild(E("option", {value: dev}, dev));
      });

      var container = E("div", {class: "cbi-section"}, 
        E("h2", {}, _("硬盘健康监测")),
        E("div", {}, _("选择硬盘设备："), sel),
        E("button", {id: "refresh_btn"}, _("刷新")),
        E("pre", {id: "smart_output"})
      );

      sel.value = data.disk || data.devices[0];
      sel.onchange = this.refresh.bind(this);
      container.querySelector("#refresh_btn").onclick = this.refresh.bind(this);

      this._output = container.querySelector("#smart_output");
      this._select = sel;

      this.updateOutput(data.output);

      return container;
    },
    refresh: function() {
      var disk = this._select.value;
      L.http.get("/admin/status/smartmini/api?disk=" + encodeURIComponent(disk)).then(data => {
        this._output.textContent = data.output.join("\n");
      });
    },
    updateOutput: function(lines) {
      this._output.textContent = lines.join("\n");
    }
  });
});

