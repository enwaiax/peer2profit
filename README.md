# peer2profit

GitHub [Chasing66/peer2profit](https://github.com/Chasing66/peer2profit)  
Docker [enwaiax/peer2profit](https://hub.docker.com/r/enwaiax/peer2profit)
> *docker image support for AMD64

## Sponsor

<a href="https://afdian.net/@LuckyHunter"><img src="https://img.shields.io/badge/%E7%88%B1%E5%8F%91%E7%94%B5-LuckyHunter-%238e8cd8?style=for-the-badge" alt="前往爱发电赞助" width=auto height=auto border="0" /></a>

## Introduction
This project builds peer2profit containers based on Alpine to achieve running multiple processes concurrently on a single VPS at the same time, which can get multiple times more traffic. The script includes auto increasing virtual memory(two times of the physical memory), installing docker, installing docke-compose, setting account email, setting the number of running containers, etc.
#### Some introduction vedio: [Peer2Profit Payout Proof - Earn Money With Bandwidth Sharing](https://www.youtube.com/watch?v=K2MozWH0Q5Y)

## Note
- Preferred Russian VPS, where residential IP is better
- It is not easy to develop, if you want to try it, please register via my referral link. [Referral link](https://peer2profit.com/r/1629477772611fdb8cab06c)
- Ubuntu16+ and Debian10 is more recommanded

### Usage
- Interactive
```shell
wget https://raw.githubusercontent.com/Chasing66/peer2profit/main/peer2fly.sh
chmod +x peer2fly.sh
./peer2fly.sh
```
- One Click Script
```shell
wget https://raw.githubusercontent.com/Chasing66/peer2profit/main/peer2fly.sh
chmod +x peer2fly.sh
./peer2fly.sh --email "Your email" --number "Container numbers"
```

## Stargazers over time

[![Stargazers over time](https://starchart.cc/Chasing66/peer2profit.svg)](https://starchart.cc/Chasing66/peer2profit)
