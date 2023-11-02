#!/bin/bash

P2P_CONFIG="/root/.config/org.peer2profit.peer2profit.ini"

if [ -z "$email" ]; then
    echo "Please specify account email address via email=<email>"
    exit 1
fi
if [ ! -f $P2P_CONFIG ]; then
    echo "Creating config..."
    tee $P2P_CONFIG <<END
[General]
StartOnStartup=true
hideToTrayMsg=true
locale=en_US
Username=$email
installid2=$(cat /proc/sys/kernel/random/uuid)
END
    echo -n
fi

echo "Staring Peer2Profit..."
if [ "${use_proxy}" = true ] && [ -f /root/proxychains4.conf ]; then
    proxychains4 -q -f /root/proxychains4.conf xvfb-run peer2profit
else
    xvfb-run peer2profit
fi