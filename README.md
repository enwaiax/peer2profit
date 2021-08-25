# peer2profit

GitHub [Chasing66/peer2profit](https://github.com/Chasing66/peer2profit)  
Docker [enwaiax/peer2profit](https://hub.docker.com/r/enwaiax/peer2profit)
> *docker image support for AMD64

## Introduction
This project builds peer2profit containers based on Alpine to achieve running multiple processes concurrently on a single VPS at the same time, which can get multiple times more traffic. The script includes increasing virtual memory, installing docker, installing docke-compose, setting account email, setting the number of running containers, etc.
#### Some introduction vedio: [Peer2Profit Payout Proof - Earn Money With Bandwidth Sharing](https://www.youtube.com/watch?v=K2MozWH0Q5Y)

## Note
- Preferred Russian VPS, where residential IP is better
- It is not easy to develop, if you want to try it, please register via my aff. [referral link](https://peer2profit.com/r/1629477772611fdb8cab06c)
- Validated systems Ubuntu16+, Debian10, Centos8. Debian9 and below are not supported at the moment.

### Usage
- Interactive
```shell
wget https://raw.githubusercontent.com/Chasing66/peer2profit/main/peer2fly.sh
chmod +x peer2fly.sh
./peer2fly.sh
```
- One Click Script
```shell
wget https://raw.githubusercontent.com/Chasing66/beautiful_docker/main/peer2profit/peer2fly.sh
chmod +x peer2fly.sh
./peer2fly.sh --email "Your email" --number "Container numbers"
```
