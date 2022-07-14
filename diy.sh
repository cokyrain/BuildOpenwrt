#!/bin/bash

# 修改默认IP为192.168.2.1
[ -e package/base-files/files/bin/config_generate ] && sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate 


# 替换默认theme
rm -rf package/lean/luci-theme-argon
[ -d package/lean ] && git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git  package/lean/luci-theme-argon
[ -e feeds/luci/collections/luci/Makefile ] && sed -ri 's/luci-theme-bootstrap/luci-theme-argon/' feeds/luci/collections/luci/Makefile

# 删掉重复theme
rm -rf feeds/kenzo/luci-theme-argon feeds/kenzo/luci-theme-argonne
[ -e package/feeds/kenzo/luci-app-mosdns/Makefile ] && sed -ri  's#mosdns[-_]neo#mosdns#g' package/feeds/kenzo/luci-app-mosdns/Makefile

# 去掉重复的ssl库
sed -i 's/CONFIG_PACKAGE_libustream-mbedtls=y/# CONFIG_PACKAGE_libustream-mbedtls=n/g' .config
sed -i 's/CONFIG_PACKAGE_libmbedtls=m/# CONFIG_PACKAGE_libmbedtls=n/g' .config
sed -i 's/CONFIG_LIBMBEDTLS_HAVE_SSE2=y/# CONFIG_LIBMBEDTLS_HAVE_SSE2=n/g' .config
