#!/bin/bash

# This script is used to start the p2pclient.
# Will only support Debian and Ubuntu based systems.

p2pclient_deb_url="https://updates.peer2profit.app/peer2profit_0.48_amd64.deb"

export email="$1"
if [ -z "$email" ]; then
    read -rp "Input your email: " email
    export email
fi

function install_dependencies() {
    echo "Installing dependencies..."
    apt update -qq &>/dev/null && apt get install -y -qq  curl &>/dev/null
}

function install_p2p_service() {
    echo "Installing p2pclient..."
    wget $p2pclient_deb_url -O p2pclient.deb
    dpkg -i p2pclient.deb
    rm -f p2pclient.deb
}

function start_p2p_service() {
    echo "Starting peer2profit..."
    ip=$(curl -4fsSLk ip.sb)
    if [ -f /etc/systemd/system/peer2profit.service ]; then
        systemctl disable peer2profit
        systemctl stop peer2profit
        rm -f /etc/systemd/system/peer2profit.service
    fi

    cat >/etc/systemd/system/peer2profit.service <<EOF
[Unit]
Description=peer2profit

[Service]
Type=simple
ExecStart=/usr/bin/p2pclient -l $email -n "$ip;8.8.8.8,1.1.1.1"
TimeoutSec=15
Restart=always

[Install]
WantedBy=multi-user.target
EOF

    systemctl daemon-reload
    systemctl enable peer2profit
    systemctl start peer2profit
    systemctl status peer2profit
}

function main() {
    install_dependencies
    install_p2p_service
    start_p2p_service
}

main "$@"
