#!/bin/bash

# maintainer: https://github.com/Chasing66/peer2profit

function set_vps_swap() {
    # check whether swap is exist
    if [ -f /swapfile ]; then
        echo "Swap file is exist. Begin to install"
        return 0
    else
        echo "Swap file is not exist"
        echo "Create swap file"
        wget -Nnv https://raw.githubusercontent.com/Chasing66/peer2profit/main/swap.sh &>/dev/null
        chmod +x swap.sh
        source swap.sh
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
                exit 1
        esac
    done
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
        yum install wget sudo curl bc -y &>/dev/null
        if [ `echo ${linux_version} | awk -v tem="8" '{print($1<tem)? "1":"0"}'` -eq "0" ]; then
            echo "This script is designed for Centos8+"
            exit 1
        fi
    elif [ $(echo $linux_distribution | grep "Debian" &>/dev/null; echo $?) -eq 0  ] || [ $(echo $linux_distribution | grep "Ubuntu" &>/dev/null; echo $?) -eq 0 ]; then
        apt update &>/dev/null && apt install wget sudo curl bc -y &>/dev/null
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
        systemctl enable docker
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
    wget -Nnv https://raw.githubusercontent.com/Chasing66/peer2profit/main/docker-compose.yml &>/dev/null
}

function set_peer2profit_email()
{
    if [ -z "$email" ]; then
        read -rp "Input your email: " email
    fi
    if [ -n "$email" ]; then
        echo "You email is: $email"
        export email
        echo "email=$email" > .env
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
        echo "You container numbers is: $replicas"
        export replicas
        sed -i "s/replicas:.*/replicas: $replicas/g" docker-compose.yml
    else
        echo "Please input the container numbers you want to run."
        exit 1
    fi
}

function start_containers()
{
    export COMPOSE_HTTP_TIMEOUT=300
    docker-compose kill
    docker-compose up -d --no-recreate
    docker-compose ps -a
}

function peer2fly()
{   
    set_vps_swap
    parse_args "$@"
    check_whether_root_user
    install_mandantory_packages
    install_docker_dockercompose
    download_compose_file
    set_peer2profit_email
    set_contaienr_replicas_numbers
    start_containers
}

peer2fly "$@"
