#!/bin/bash

# maintainer: https://github.com/Chasing66/peer2profit
# version: 1.1
# p2pclient_version: 0.60

red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
plain='\033[0m'

function set_vps_swap() {
    # Skip if the virtualization is openVZ
    if [[ -d /proc/vz ]]; then
        echo -e "${green}OpenVZ virtualization detected, skipping add swap${plain}"
        return
    fi
    # Set swap size as two times of RAM size automatically
    if [ $(free -m | grep Mem | awk '{print $2}') -gt 512 ]; then
        echo -e "${green}Enough memory, swap is not needed${plain}"
        free -m
        return 0
    elif [ $(free -m | grep Swap | awk '{print $2}') -gt 0 ]; then
        echo -e "${green}Swap already enabled${plain}"
        cat /proc/swaps
        free -h
        return 0
    else
        echo -e "${green}Swapfile not created. creating it${plain}"
        mem_num=$(awk '($1 == "MemTotal:"){print $2/1024}' /proc/meminfo | sed "s/\..*//g" | awk '{print $1*2}')
        fallocate -l ${mem_num}M /swapfile
        chmod 600 /swapfile
        mkswap /swapfile
        swapon /swapfile
        echo '/swapfile none swap defaults 0 0' >>/etc/fstab
        echo -e "${green}swapfile created.${plain}"
        cat /proc/swaps
        free -h
    fi
}

function parse_args() {
    while [[ $# -gt 0 ]]; do
        case "$1" in
        --email)
            email="$2"
            shift
            shift
            ;;
        --number)
            replicas="$2"
            shift
            shift
            ;;
        --version)
            version="$2"
            shift
            shift
            ;;
        --proxy)
            use_proxy="$2"
            shift
            shift
            ;;
        --debug-output)
            set -x
            shift
            ;;
        *)
            error "Unknown argument: $1"
            display_help
            exit 1
            ;;
        esac
    done
}

function display_help() {
    echo "Usage: $0 [--email <email>] [--number <number>]"
    echo "  --email <email>    Email address to login"
    echo "  --number <number>  Number of replicas to create"
    echo "  --debug-output     Enable debug output"
    echo "Example: $0 --email test@example.com --number 3"
}

function check_root_user() {
    if [ "$(id -u)" != "0" ]; then
        echo -e "${red}Error: root user is needed${plain}"
        exit 1
    fi
}

function check_os() {
    # os distro release
    if [[ -f /etc/redhat-release ]]; then
        release="centos"
    elif cat /etc/issue | grep -Eqi "debian"; then
        release="debian"
    elif cat /etc/issue | grep -Eqi "ubuntu"; then
        release="ubuntu"
    elif cat /etc/issue | grep -Eqi "centos|red hat|redhat"; then
        release="centos"
    elif cat /proc/version | grep -Eqi "debian"; then
        release="debian"
    elif cat /proc/version | grep -Eqi "ubuntu"; then
        release="ubuntu"
    elif cat /proc/version | grep -Eqi "centos|red hat|redhat"; then
        release="centos"
    else
        echo -e "${red}ERROR: Only support Centos8, Debian 10+ or Ubuntu16+${plain}\n" && exit 1
    fi

    # os version
    os_version=""
    if [[ -f /etc/os-release ]]; then
        os_version=$(awk -F'[= ."]' '/VERSION_ID/{print $3}' /etc/os-release)
    fi
    if [[ -z "$os_version" && -f /etc/lsb-release ]]; then
        os_version=$(awk -F'[= ."]+' '/DISTRIB_RELEASE/{print $2}' /etc/lsb-release)
    fi

    if [[ x"${release}" == x"centos" ]]; then
        if [[ ${os_version} -le 7 ]]; then
            echo -e "${red}Please use CentOS 8 or higher version.${plain}\n" && exit 1
        fi
    elif [[ x"${release}" == x"ubuntu" ]]; then
        if [[ ${os_version} -lt 16 ]]; then
            echo -e "${red}Please use Ubuntu 16 or higher version.${plain}\n" && exit 1
        fi
    elif [[ x"${release}" == x"debian" ]]; then
        if [[ ${os_version} -lt 10 ]]; then
            echo -e "${red}Please Debian 10 or higher version.${plain}\n" && exit 1
        fi
    fi
}

function install_base() {
    if [[ x"${release}" == x"centos" ]]; then
        yum install wget sudo curl -y &>/dev/null
    else
        apt update &>/dev/null && apt install wget sudo curl -y &>/dev/null
    fi
}

function install_docker_docker-compose() {
    if command -v docker >/dev/null 2>&1; then
        echo -e "${green}docker already installed, skip${plain}"
    else
        echo -e "${green}Installing docker${plain}"
        curl -fsSL https://get.docker.com | sudo bash
        systemctl enable docker || service docker start
    fi

    if ! command -v docker >/dev/null 2>&1; then
        echo -e "${red}docker installation failed, please check your environment${plain}"
        exit 1
    fi

    if command -v docker-compose >/dev/null 2>&1; then
        echo -e "${green}docker-compose already installed, skip${plain}"
    else
        echo -e "${green}Installing docker-compose${plain}"
        curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        chmod +x /usr/local/bin/docker-compose
    fi

    if ! command -v docker-compose >/dev/null 2>&1; then
        echo -e "${red}docker-compose installation failed, please check your environment${plain}"
        exit 1
    fi
}

function download_compose_file() {
    if [[ -f docker-compose.yml ]]; then
        rm -rf docker-compose.yml
    fi
    echo -e "${green}Downloading docker-compose.yml${plain}"
    wget -q https://raw.githubusercontent.com/Chasing66/peer2profit/main/docker-compose.yml -O docker-compose.yml
}

function set_peer2profit_email() {
    if [ -z "$email" ]; then
        read -rp "Input your email: " email
    fi
    if [ -n "$email" ]; then
        echo -e "${green}Your email is: $email ${plain}"
        export email
        sed -i "s/email=.*/email=$email/g" docker-compose.yml
    else
        echo -e "${red}Please input your email${plain}"
        exit 1
    fi
}

function set_contaienr_replicas_numbers() {
    if [ -z "$replicas" ]; then
        read -rp "Input the container numbers you want to run: " replicas
    fi
    if [ -n "$replicas" ]; then
        echo -e "${green}Your container numbers is: $replicas ${plain}"
        export replicas
        sed -i "s/replicas:.*/replicas: $replicas/g" docker-compose.yml
    else
        echo -e "${red}Please input the container numbers you want to run${plain}"
        exit 1
    fi
}

function set_image_version() {
    if [ -n "$version" ]; then
        export version
        echo -e "${green}Will use version: enwaiax/peer2profit:$version ${plain}"
        sed -i "s/image:.*/image: enwaiax/peer2profit:$version/g" docker-compose.yml
    else
        echo -e "${green}Will use defalut version: enwaiax/peer2profit:latest ${plain}"
    fi
}

function set_proxy() {
    # if proxychains4.conf is not exist, then download it.
    if [ ! -f ./proxychains4.conf ]; then
        echo -e "${green}no proxychains4.conf found, downloading... ${plain}"
        wget -q https://raw.githubusercontent.com/Chasing66/peer2profit/main/proxychains4.conf -O proxychains4.conf
    else
        echo -e "${green}proxychains4.conf found, skipped ${plain}"
    fi
    # it use_proxy is true, then set proxychains4.conf
    if [ "$use_proxy" = true ]; then
        echo -e "${green}Proxychains4 is enabled. ${plain}"
        export use_proxy
        # set use_proxy to true in docker-compose.yml
        sed -i "s/use_proxy=.*/use_proxy=true/g" docker-compose.yml
    fi
}

function start_containers() {
    export COMPOSE_HTTP_TIMEOUT=500
    docker-compose pull
    docker-compose up -d
    echo "Clean cache"
    docker system prune -f &>/dev/null
    docker-compose ps -a
    docker stats --no-stream
}

function peer2fly() {
    parse_args "$@"
    check_root_user
    set_vps_swap
    check_os
    install_base
    install_docker_docker-compose
    download_compose_file
    set_peer2profit_email
    set_contaienr_replicas_numbers
    set_image_version
    set_proxy
    start_containers
}

peer2fly "$@"
