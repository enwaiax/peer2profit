# peer2profit

<!-- PROJECT SHIELDS -->

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![Docker Pulls][docker-pulls-shield]][docker-pulls-url]

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
    <a href="https://github.com/Chasing66/peer2profit" target="_blank">Github</a>
    |
    <a href="https://hub.docker.com/r/enwaiax/peer2profit" target="_blank">Docker Hub</a>
  </p>
</p>

## Language

[English](README.md) | [中文文档](README_zh.md)

## **Introduction**

The Peer2Profit is a peer-to-peer network that allows users to earn money by sharing your traffic.

This project is the **first docker image** for Peer2Profit in the whole Internet, even earlier than the Peer2Profit official image.

It has below features:

1. Supporting two tags of image based on Alpine and Debian11. The tag `alpine` is absolutely the smallest image, and the tag `latest` is the most common image.

2. The script `peer2fly.sh` will help will help with below steps
   - Install the necessary packages
   - Set Swap Memory(two times of the physical memory)
   - Install docker and docker-compose
   - Setting email and container numbers
   - Start the containers as you required with docker-compose

## Notes

- Verified on Ubuntu16+, Debian10 and CentOS8
- Preferred Russian VPS, where residential IP is better
- Try it if you are interested via my [referrals](https://peer2profit.com/r/16297247056123a02153377/en)

## Usage

### 1. Interactive

```shell
bash <(curl -fsSL bit.ly/peer2fly)
```

Or giving the parameters:
```shell
curl -fsSL bit.ly/peer2fly |bash -s -- --email chasing66@live.com --number 5
```

### 2. Download and run with parameters

```shell
wget -q https://bit.ly/peer2fly -O peer2fly.sh
```

Given the parameters, for example

```shell
bash peer2fly.sh --email chasing66@live.com --number 10
```

### 3. Install as a service on Ubuntu/Debian system

```shell
bash <(curl -fsSL git.io/JzDdQ) chasing66@live.com
```

## Disclaimer

This program is for learning purposes only, not for profit, please delete it within 24 hours after downloading, not for any commercial use. The text, data and images are copyrighted, if reproduced, please indicate the source.

Use of this program is subject to the deployment disclaimer. Use of this program is subject to the laws and regulations of the country where the server is deployed, the country where it is located, and the country where the user is located, and the author of the program is not responsible for any misconduct of the user.

## Stargazers over time

[![Stargazers over time](https://starchart.cc/Chasing66/peer2profit.svg)](https://starchart.cc/Chasing66/peer2profit)

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->

[contributors-shield]: https://img.shields.io/github/contributors/Chasing66/peer2profit.svg?style=flat-square
[contributors-url]: https://github.com/Chasing66/peer2profit/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/Chasing66/peer2profit.svg?style=flat-square
[forks-url]: https://github.com/Chasing66/peer2profit/network/members
[stars-shield]: https://img.shields.io/github/stars/Chasing66/peer2profit.svg?style=flat-square
[stars-url]: https://github.com/Chasing66/peer2profit/stargazers
[issues-shield]: https://img.shields.io/github/issues/Chasing66/peer2profit.svg?style=flat-square
[issues-url]: https://github.com/Chasing66/peer2profit/issues
[license-shield]: https://img.shields.io/github/license/Chasing66/peer2profit.svg?style=flat-square
[license-url]: https://github.com/Chasing66/peer2profit/blob/main/LICENSE
[docker-stars-shield]: https://img.shields.io/docker/stars/enwaiax/peer2profit.svg?style=flat-square
[docker-stars-url]: https://hub.docker.com/r/enwaiax/peer2profit
[docker-pulls-shield]: https://img.shields.io/docker/pulls/enwaiax/peer2profit.svg?style=flat-square
[docker-pulls-url]: https://hub.docker.com/r/enwaiax/peer2profit
