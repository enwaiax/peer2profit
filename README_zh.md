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
  <p align="center">分享闲置带宽获得利润</p>
  <p align="center">
    <a href="https://github.com/Chasing66/peer2profit">Github</a>
    |
    <a href="https://hub.docker.com/r/enwaiax/peer2profit">Docker Hub</a>
  </p>
</p>

## 语言
[English](README.md) | [中文文档](README_zh.md)

## 充电支持

<a href="https://afdian.net/@LuckyHunter"><img src="https://img.shields.io/badge/%E7%88%B1%E5%8F%91%E7%94%B5-LuckyHunter-%238e8cd8?style=for-the-badge" alt="前往爱发电赞助" width=auto height=auto border="0" /></a>

## 介绍
本项目基于Alpine docker 镜像搭建peer2profit容器，实现在单个VPS上同时并发运行多个进程，可以获得多倍的流量。脚本包括自动增加虚拟内存（物理内存的两倍）、安装docker、安装docke-compose、设置账户邮箱、设置运行容器数量等。

## 信息
- 本项目已经在 Ubuntu16+ 和 Debian10上验证
- 首选俄罗斯 VPS，住宅IP更好
- 开发不易，如果你想尝试，请通过我的推荐链接注册。 [推荐链接](https://peer2profit.com/r/1629477772611fdb8cab06c)


### 使用方法
- 交互式
```shell
wget https://raw.githubusercontent.com/Chasing66/peer2profit/main/peer2fly.sh
chmod +x peer2fly.sh
./peer2fly.sh
```
- 一键脚本
```shell
wget https://raw.githubusercontent.com/Chasing66/peer2profit/main/peer2fly.sh
chmod +x peer2fly.sh
./peer2fly.sh --email "你的邮箱地址" --number "容器个数"
```

### 免责声明

本程序仅供学习了解, 非盈利目的，请于下载后 24 小时内删除, 不得用作任何商业用途, 文字、数据及图片均有所属版权, 如转载须注明来源。

使用本程序必循遵守部署免责声明。使用本程序必循遵守部署服务器所在地、所在国家和用户所在国家的法律法规, 程序作者不对使用者任何不当行为负责.

### 鸣谢
特别一下MJJ的充电支持, 排名不分先后
- Pony
- 断魂枪
- [A苏义](https://github.com/aisuyi065)
- 一阵小风
- 🍎🍎
