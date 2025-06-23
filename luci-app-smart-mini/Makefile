include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-smart-mini
PKG_VERSION:=1.0
PKG_RELEASE:=1

LUCI_TITLE:=硬盘健康监测
LUCI_DESCRIPTION:=Show SMART info for disks with charts in LuCI
LUCI_DEPENDS:=+smartmontools +luci-compat +luci-base +luci-mod-admin-full
PKG_MAINTAINER:=YourName <youremail@example.com>
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
  $(LUCI_DESCRIPTION)
endef

define Build/Compile
  true
endef

define Package/luci-app-smart-mini/install
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DATA) ./luasrc/controller/smartmini.lua $(1)/usr/lib/lua/luci/controller/smartmini.lua

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/ucode
	$(INSTALL_DATA) ./ucode/smartmini.uc $(1)/usr/lib/lua/luci/ucode/smartmini.uc

	$(INSTALL_DIR) $(1)/usr/share/luci-static/resources/view/smartmini
	$(INSTALL_DATA) ./www/js/smartmini.js $(1)/usr/share/luci-static/resources/view/smartmini/smartmini.js

	$(INSTALL_DIR) $(1)/usr/share/luci-i18n
	$(INSTALL_DATA) ./i18n/zh-cn.po $(1)/usr/share/luci-i18n/luci-app-smart-mini-zh-cn.po
endef

$(eval $(call BuildPackage,luci-app-smart-mini))

