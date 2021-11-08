#!/bin/bash

# This script is used to start the p2p-service.
# Will only support Debian and Ubuntu based systems.

export email="$1"
if [ -z "$email" ]; then
    read -rp "Input your email: " email
    export email
fi

function install_dependencies() {
    echo "Installing dependencies..."
    apt update &>/dev/null && apt install curl wget -y
}

function install_p2p_service() {
    echo "Installing p2p-service..."
    wget https://updates.peer2profit.com/p2pclient_0.56_amd64.deb
    dpkg -i ./p2pclient_0.54_amd64.deb
    rm -f ./p2pclient_0.54_amd64.deb
}

function start_p2p_service() {
    echo "Starting p2p-service..."
    ip=$(curl -4fsSLk ip.sb)
    cat > /etc/systemd/system/peer2profit.service  << EOF
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
