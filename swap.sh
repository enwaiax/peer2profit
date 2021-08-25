#!/usr/bin/env bash

Green="\033[32m"
Font="\033[0m"
Red="\033[31m" 

# Check root permission
root_need(){
    if [[ $EUID -ne 0 ]]; then
        echo -e "${Red}Error:This script must be run as root!${Font}"
        exit 1
    fi
}

# Check whether ovz
ovz_no(){
    if [[ -d "/proc/vz" ]]; then
        echo -e "${Red}Your VPS is based on OpenVZ，not supported!${Font}"
        exit 1
    fi
}

add_swap(){
echo -e "${Green}Input the swap(unit:M) you want add，suggest memory*2 ${Font}"
read -p "Please input swap number(unit:M):" swapsize

# Check whether swapfile exists
grep -q "swapfile" /etc/fstab

# Create swap if not exists
if [ $? -ne 0 ]; then
	echo -e "${Green}swapfile is not existed，create it${Font}"
	fallocate -l ${swapsize}M /swapfile
	chmod 600 /swapfile
	mkswap /swapfile
	swapon /swapfile
	echo '/swapfile none swap defaults 0 0' >> /etc/fstab
         echo -e "${Green}swap created${Font}"
         cat /proc/swaps
         cat /proc/meminfo | grep Swap
else
	echo -e "${Red}swapfile existed，Please delete it and then set ${Font}"
fi
}

del_swap(){
# Check whether swapfile exists
grep -q "swapfile" /etc/fstab

# Delete swap if exists
if [ $? -eq 0 ]; then
	echo -e "${Green}swapfile existed，will be deleted...${Font}"
	sed -i '/swapfile/d' /etc/fstab
	echo "3" > /proc/sys/vm/drop_caches
	swapoff -a
	rm -f /swapfile
    echo -e "${Green}swap has been deleted${Font}"
else
	echo -e "${Red}no swapfile，delete swap failed${Font}"
fi
}

# Main menu
main(){
root_need
ovz_no
clear
echo -e "———————————————————————————————————————"
echo -e "${Green}Linux VPS swap${Font}"
echo -e "${Green}1、Add swap${Font}"
echo -e "${Green}2、Delete swap${Font}"
echo -e "———————————————————————————————————————"
read -p "Input number [1-2]:" num
case "$num" in
    1)
    add_swap
    ;;
    2)
    del_swap
    ;;
    *)
    clear
    echo -e "${Green}Please input the correct number [1-2]${Font}"
    sleep 2s
    main
    ;;
    esac
}

main()