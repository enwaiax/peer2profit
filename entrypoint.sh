#!/bin/bash

# if email is not set in env, use default value
if [ -z "$email" ]; then
    email="chasing66@live.com"
fi
# if use_proxy from env is set to true, then set proxy
if [ "${use_proxy}" = true ]; then
    # check whether proxychains4.conf exists
    if [ -f /root/proxychains4.conf ]; then
        proxychains4 -q -f /root/proxychains4.conf p2pclient -l ${email}
    else
        echo "Proxychains4.conf not found, exit"
        exit 1
    fi
else
    p2pclient -l ${email}
fi
