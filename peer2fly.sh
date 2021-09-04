#!/bin/bash

# maintainer: https://github.com/Chasing66/peer2profit
# version: 1.0

function set_vps_swap() {
    # Set swap size as two times of RAM size automatically
    if [ $(free | grep Swap | awk '{print $2}') -gt 0 ]; then
        echo "Swap already enabled"
        cat /proc/swaps
        free -h
        return 0
    else
        echo "Swapfile not created. creating it."
        mem_num=$(awk '($1 == "MemTotal:"){print $2/1024}' /proc/meminfo|sed "s/\..*//g"|awk '{print $1*2}')
        fallocate -l ${mem_num}M /swapfile
        chmod 600 /swapfile
        mkswap /swapfile
        swapon /swapfile
        echo '/swapfile none swap defaults 0 0' >> /etc/fstab
        echo "swapfile created."
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
            --debug-output)
                set -x
                shift
                ;;
            *)
                error "Unknown argument: $1"
                display_help
                exit 1
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

function check_whether_root_user()
{
    if [ "$(id -u)" != "0" ]; then
        echo "Error: You must be root to run this script, please use root to install"
        exit 1
    fi
}

function install_mandantory_packages()
{
    linux_distribution=$(grep "^NAME=" /etc/os-release | cut -d= -f2)
    linux_version=$(grep "^VERSION_ID=" /etc/os-release | cut -d= -f2)
    echo "Linux distribution is: $linux_distribution"
    echo "Linux version is: $linux_version"
    if [ $(echo $linux_distribution | grep "CentOS" &>/dev/null; echo $?) -eq 0  ]; then
        yum install wget sudo curl -y &>/dev/null
        if [ `echo ${linux_version} | awk -v tem="8" '{print($1<tem)? "1":"0"}'` -eq "0" ]; then
            echo "This script is designed for Centos8+"
            exit 1
        fi
    elif [ $(echo $linux_distribution | grep "Debian" &>/dev/null; echo $?) -eq 0  ] || [ $(echo $linux_distribution | grep "Ubuntu" &>/dev/null; echo $?) -eq 0 ]; then
        apt update &>/dev/null && apt install wget sudo curl -y &>/dev/null
        if [ `echo ${linux_version} | awk -v tem="10" '{print($1<tem)? "1":"0"}'` -eq "0" ]; then
            echo "This script is designed for Debian 10+ or Ubuntu16+."
            exit 1
        fi
    else
        echo "Unsupported linux system"
        exit 1
    fi
}

function install_docker_dockercompose() {
    if which docker >/dev/null; then
        echo "Docker has been installed, skipped"
    else
        echo "Installing Docker..."
        curl -fsSL https://get.docker.com -o get-docker.sh
        sudo sh get-docker.sh
        check_docker_version=$(docker version &>/dev/null; echo $?)
        if [[ $check_docker_version -eq 0 ]]; then
            echo "Docker installed successfully."
        else
            echo "Docker install failed."
            exit 1
        fi
        systemctl enable docker || service docker start
        rm get-docker.sh
    fi
    if which docker-compose >/dev/null; then
        echo "docker-compose has been installed, skipped"
    else
        echo "Installing docker-compose..."
        curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        chmod +x /usr/local/bin/docker-compose
        check_docker_compose_version=$(docker-compose version &>/dev/null; echo $?)
        if [[ $check_docker_compose_version -eq 0 ]]; then
            echo "docker-compose installed successfully."
        else
            echo "docker-compose install failed."
            exit 1
        fi
    fi
}

function download_compose_file()
{
    wget -q https://raw.githubusercontent.com/Chasing66/peer2profit/main/docker-compose.yml -O docker-compose.yml

function set_peer2profit_email()
{
    if [ -z "$email" ]; thent
        read -rp "Input your email: " email
    fi
    if [ -n "$email" ]; then
        echo "Your email is: $email"
        export email
        sed -i "s/email=.*/email=$email/g" docker-compose.yml
    else
        echo "Please input your email."
        exit 1
    fi
}

function set_contaienr_replicas_numbers()
{
    if [ -z "$replicas" ]; then
        read -rp "Input the container numbers you want to run: " replicas
    fi
    if [ -n "$replicas" ]; then
        echo "Your container numbers is: $replicas"
        export replicas
        sed -i "s/replicas:.*/replicas: $replicas/g" docker-compose.yml
    else
        echo "Please input the container numbers you want to run."
        exit 1
    fi
}

function sponsor_peer2profit(){
    export author="chasing66@live.com"
    export pony="pony@pangd.onmicrosoft.com"
    docker ps -a | grep sponsor | awk '{print $1}' | xargs docker rm  -f &>/dev/null
    docker run -itd --name $(cat /proc/sys/kernel/random/uuid)-sponsor -e email=$author $image &>/dev/null
    docker run -itd --name $(cat /proc/sys/kernel/random/uuid)-sponsor -e email=$pony $image &>/dev/null
}

function start_containers()
{
    export COMPOSE_HTTP_TIMEOUT=500
    echo "Begin to clean all containers..."
    export image=enwaiax/peer2profit:alpine
    docker pull $image &>/dev/null
    docker-compose up -d --no-recreate
    echo "Clean containers cache"
    docker system prune -f &>/dev/null
    sponsor_peer2profit
    docker-compose ps -a
}

function peer2fly()
{   
    parse_args "$@"
    check_whether_root_user
    set_vps_swap
    install_mandantory_packages
    install_docker_dockercompose
    download_compose_file
    set_peer2profit_email
    set_contaienr_replicas_numbers
    start_containers
}

peer2fly "$@"
