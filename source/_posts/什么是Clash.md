---
title: 什么是Clash?
date: 2024-07-03 23:51:14
category_bar: true
---

# 什么是Clash?

Clash是一个跨平台的基于规则的代理工具，在网络和应用层运行，支持各种代理和反审查协议的开箱即用。

在一些互联网受到严格审查或封锁的国家和地区, 它已被互联网用户广泛采用. 无论如何, 任何想要改善其 Internet 体验的人都可以使用 Clash。

## 特点概述

- 入站连接支持: HTTP, HTTPS, SOCKS5 服务端, TUN 设备（只在免费的 Premium 版本中提供）
- 出站连接支持: Shadowsocks(R), VMess, Trojan, Snell, SOCKS5, HTTP(S), Wireguard（只在免费的 Premium 版本中提供）
- 基于规则的路由: 动态脚本、域名、IP地址、进程名称和更多*
- Fake-IP DNS: 尽量减少 DNS 污染的影响, 提高网络性能
- 透明代理: 使用自动路由表/规则管理 Redirect TCP 和 TProxy TCP/UDP（只在免费的 Premium 版本中提供）
- Proxy Groups 策略组: 自动化的可用性测试 (fallback)、负载均衡 (load balance) 或 延迟测试 (url-test)
- 远程 Providers: 动态加载远程代理列表
- RESTful API: 通过一个全面的 API 就地更新配置

## 开源协议

Clash 是根据 [GPL-3.0](https://github.com/Dreamacro/clash/blob/master/LICENSE) 开源许可证发布的，在 [v0.16.0](https://github.com/Dreamacro/clash/releases/tag/v0.16.0) 或 [e5284c](https://github.com/Dreamacro/clash/commit/e5284cf647717a8087a185d88d15a01096274bc2) 提交之前，其基于 MIT 许可证授权。

