include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-smart-mini
PKG_VERSION:=1.0
PKG_RELEASE:=1

LUCI_TITLE:=硬盘健康监测
LUCI_DEPENDS:=+luci +smartmontools
PKG_LICENSE:=GPL-2.0

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-smart-mini
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=3. Applications
  TITLE:=$(LUCI_TITLE)
  DEPENDS:=$(LUCI_DEPENDS)
  PKGARCH:=all
endef

define Package/luci-app-smart-mini/description
  一款基于smartmontools的硬盘健康监测LuCI插件，支持查看详细SMART信息。
endef

define Build/Compile
  true
endef

define Package/luci-app-smart-mini/install
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DIR) $(1)/usr/share/luci/menu.d
	$(INSTALL_DATA) ./luasrc/controller/smartmini.lua $(1)/usr/lib/lua/luci/controller/smartmini.lua
	$(INSTALL_DATA) ./po/zh-cn.po $(1)/usr/share/luci/menu.d/luci-app-smart-mini.po
endef

$(eval $(call BuildPackage,luci-app-smart-mini))
