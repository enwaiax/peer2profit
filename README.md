# peer2profit

<!-- PROJECT SHIELDS -->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]

<!-- PROJECT LOGO -->
<br />
<p align="center">
  <br>
    <img src="https://peer2profit.com/landing/img/logo.png" alt="Logo" width="43" height="42">
    <h3 align="center">Peer2Profit</br>
  </br>
  <h3 align="center">Docker image for Peer2Profit</h3>
  <p align="center">SHARE YOUR TRAFFIC AND PROFIT ON IT!</p>
  <p align="center">
    <a href="https://github.com/Chasing66/peer2profit">Github</a>
    |
    <a href="https://hub.docker.com/r/enwaiax/peer2profit">Docker Hub</a>
  </p>
</p>

## Language
[English](README.md) | [中文文档](README_zh.md)

## Introduction
This project builds peer2profit containers based on Alpine docker image to achieve running multiple processes concurrently on a single VPS at the same time, which can get multiple times more traffic. The script includes auto increasing virtual memory(two times of the physical memory), installing docker, installing docke-compose, setting account email, setting the number of running containers, etc.

#### Some introduction vedio: [Peer2Profit Payout Proof - Earn Money With Bandwidth Sharing](https://www.youtube.com/watch?v=K2MozWH0Q5Y)

## Note
- Verified on Ubuntu16+ and Debian10
- Preferred Russian VPS, where residential IP is better
- It is not easy to develop, if you want to try it, please register via my referral link. [Referral link](https://peer2profit.com/r/1629477772611fdb8cab06c)


### Usage
- Interactive
```shell
wget -Nnv https://raw.githubusercontent.com/Chasing66/peer2profit/main/peer2fly.sh &>/dev/null
chmod +x peer2fly.sh
./peer2fly.sh
```
- One Click Script
```shell
wget -Nnv https://raw.githubusercontent.com/Chasing66/peer2profit/main/peer2fly.sh &>/dev/null
chmod +x peer2fly.sh
./peer2fly.sh --email "Your email" --number "Container numbers"
```

### Disclaimer

This program is for learning purposes only, not for profit, please delete it within 24 hours after downloading, not for any commercial use. The text, data and images are copyrighted, if reproduced, please indicate the source.

Use of this program is subject to the deployment disclaimer. Use of this program is subject to the laws and regulations of the country where the server is deployed, the country where it is located, and the country where the user is located, and the author of the program is not responsible for any misconduct of the user.

## Stargazers over time

[![Stargazers over time](https://starchart.cc/Chasing66/peer2profit.svg)](https://starchart.cc/Chasing66/peer2profit)

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/Chasing66/peer2profit.svg?style=for-the-badge
[contributors-url]: https://github.com/Chasing66/peer2profit/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/Chasing66/peer2profit.svg?style=for-the-badge
[forks-url]: https://github.com/Chasing66/peer2profit/network/members
[stars-shield]: https://img.shields.io/github/stars/Chasing66/peer2profit.svg?style=for-the-badge
[stars-url]: https://github.com/Chasing66/peer2profit/stargazers
[issues-shield]: https://img.shields.io/github/issues/Chasing66/peer2profit.svg?style=for-the-badge
[issues-url]: https://github.com/Chasing66/peer2profit/issues
[license-shield]: https://img.shields.io/github/license/Chasing66/peer2profit.svg?style=for-the-badge
[license-url]: https://github.com/Chasing66/peer2profit/blob/main/LICENSE
