---
title: 如何查看Clash的真实延迟
date: 2025-04-07 16:34:22
category_bar: true
tags:
- Clash
- VPN
- 翻墙
- 国际联网
---

# 如何查看Clash的真实延迟

Clash for Windows的这个测试是不准确的。它有一个设置，路径是 Settings 设置 → Proxies 代理 → Latency Test URL 延迟测试链接。当你测速时，它就是访问这个链接并给出你访问该URL的速度，并且默认是超过3000ms就会显示超时。

有些机场可以在入口做劫持，那你看到的延迟其实是你到国内中转服务器的延迟，那可能就会是很低的，反映不出实际的网速。

你可以更换用于测速的网址，如果你的机场没有劫持这个网址，那么它反映出来的延迟就是真实的。以下是一些网址，可以更换了看看。

| 服务提供者 | 链接                                                       |
| ---------- | ---------------------------------------------------------- |
| Google     | http://www.gstatic.com/generate_204                        |
| Google     | http://www.google-analytics.com/generate_204               |
| Google     | http://www.google.com/generate_204                         |
| Google     | http://connectivitycheck.gstatic.com/generate_204          |
| Apple      | http://captive.apple.com                                   |
| Apple      | http://www.apple.com/library/test/success.html             |
| MicroSoft  | http://www.msftconnecttest.com/connecttest.txt             |
| Cloudflare | http://cp.cloudflare.com/                                  |
| Firefox    | http://detectportal.firefox.com/success.txt                |
| V2ex       | http://www.v2ex.com/generate_204                           |
| 小米       | http://connect.rom.miui.com/generate_204                   |
| 华为       | http://connectivitycheck.platform.hicloud.com/generate_204 |
| Vivo       | http://wifi.vivo.com.cn/generate_204                       |

当然，建议使用国外的

> **为什么这些网址大多有204？
> **这个是“204 No Content”响应测试。HTTP状态码204表示服务器成功处理了请求，但不需要返回任何内容。因此，当客户端发出请求时，服务器可以快速地响应204状态码，而无需返回任何实际的内容。这种方式可以更快地检测网络连接是否正常，而不会增加额外的网络流量和服务器负载。

## 如何测试网速

但其实说回来，测试延迟也不能代表什么，还得看连接之后稳不稳定。要想知道网速好不好，直接使用一些测速的网站或者是软件，列入 Speedtest 或者是 Google Fiber。

| 文件大小 | 地址                                                         |
| -------- | ------------------------------------------------------------ |
| 100MB    | https://speed.cloudflare.com/__down?during=download&bytes=104857600 |
| 1GB      | https://speed.cloudflare.com/__down?during=download&bytes=1073741824 |
| 10GB     | https://speed.cloudflare.com/__down?during=download&bytes=10737418240 |
