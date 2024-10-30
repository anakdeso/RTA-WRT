#!/bin/bash

echo "Start Downloading Misc files and setup configuration!"
echo "Current Path: $PWD"

#setup custom setting for openwrt and immortalwrt
sed -i "s/Ouc3kNF6/$DATE/g" files/etc/uci-defaults/99-init-settings.sh
echo "$BASE"
sed -i '/# setup misc settings/ a\mv \/www\/luci-static\/resources\/view\/status\/include\/29_temp.js \/www\/luci-static\/resources\/view\/status\/include\/17_temp.js' files/etc/uci-defaults/99-init-settings.sh

if [ "$TARGET" == "Raspberry Pi 4B" ]; then
    echo "$TARGET"
elif [ "$TARGET" == "x86-64" ]; then
    rm packages/luci-app-oled_1.0_all.ipk
else
    rm packages/luci-app-oled_1.0_all.ipk
fi

if [ "$TYPE" == "AMLOGIC" ]; then
    sed -i -E "s|nullwrt|amlogic|g" files/etc/uci-defaults/99-init-settings.sh
    sed -i '/# setup misc settings/ a\chmod +x /lib/netifd/dhcp-get-server.sh' files/etc/uci-defaults/99-init-settings.sh
    sed -i '/# setup misc settings/ a\chmod +x /lib/netifd/dhcp.script' files/etc/uci-defaults/99-init-settings.sh
    sed -i '/# setup misc settings/ a\chmod +x /lib/netifd/dhcpv6.script' files/etc/uci-defaults/99-init-settings.sh
    sed -i '/# setup misc settings/ a\chmod +x /lib/netifd/ppp6-up' files/etc/uci-defaults/99-init-settings.sh
    sed -i '/# setup misc settings/ a\chmod +x /lib/netifd/ppp-down' files/etc/uci-defaults/99-init-settings.sh
    sed -i '/# setup misc settings/ a\chmod +x /lib/netifd/ppp6-down' files/etc/uci-defaults/99-init-settings.sh
    sed -i '/# setup misc settings/ a\chmod +x /lib/netifd/ppp-up' files/etc/uci-defaults/99-init-settings.sh
    sed -i '/# setup misc settings/ a\chmod +x /lib/netifd/wireless/mac80211.sh' files/etc/uci-defaults/99-init-settings.sh
    sed -i '/# setup misc settings/ a\chmod +x /lib/netifd/proto/dhcp.sh' files/etc/uci-defaults/99-init-settings.sh
    sed -i '/# setup misc settings/ a\chmod +x /lib/nefitd/proto/dhcpv6.sh' files/etc/uci-defaults/99-init-settings.sh
    sed -i '/# setup misc settings/ a\chmod +x /lib/netifd/proto/ppp.sh' files/etc/uci-defaults/99-init-settings.sh
fi

# custom script files urls
echo "Downloading custom script" 
sync_time="https://raw.githubusercontent.com/frizkyiman/auto-sync-time/main/sbin/sync_time.sh"
clock="https://raw.githubusercontent.com/frizkyiman/auto-sync-time/main/usr/bin/clock"
repair_ro="https://raw.githubusercontent.com/frizkyiman/fix-read-only/main/install2.sh"

wget --no-check-certificate -nv -P files/sbin "$sync_time"
wget --no-check-certificate -nv -P files/usr/bin "$clock"
wget --no-check-certificate -nv -P files/root "$repair_ro"


# echo "src/gz custom_arch https://dl.openwrt.ai/latest/packages/$ARCH_3/kiddin9" >> repositories.conf

echo "All custom configuration setup completed!"
