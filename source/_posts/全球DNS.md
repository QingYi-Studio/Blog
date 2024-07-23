---
title: 全球DNS
date: 2024-07-23 16:25:36
sticky: 90
tags:
- DNS
---

# 全球DNS

## 国内

### 腾讯 DNS (DNSPod)

IPv4：

```TEXT
119.29.29.29
182.254.116.116(使用情况未知)
```

IPv6：

```TEXT
2402:4e00::
```

DoH：

```TEXT
https://doh.pub/dns-query
```

DoH(IP)：

```TEXT
https://1.12.12.12/dns-query
https://120.53.53.53/dns-query
```

DoH (国密 SM2)基于腾讯云政企国密解决方案：

```TEXT
https://sm2.doh.pub/dns-query
```

DoT：

```TEXT
dot.pub
```

DoT(IP版)：

```TEXT
1.12.12.12
120.53.53.53
```

### 阿里 DNS (Alidns)

IPv4：

```TEXT
223.5.5.5
223.6.6.6
```

IPv6：

```TEXT
2400:3200::1
2400:3200:baba::1
```

DoH：

```TEXT
https://dns.alidns.com/dns-query
```

DoT：

```TEXT
dns.alidns.com
```

### 百度 DNS



IPv4：

```TEXT
180.76.76.76
```

IPv6 **[无法解析]**：

```TEXT
2400:da00::6666
```

### 字节跳动 TrafficRoute DNS

IPv4：

```TEXT
180.184.1.1
180.184.2.2
```

### 360 安全 DNS

IPv4：

- 中国电信/中国铁通/中国移动

	```TEXT
	101.226.4.6
	218.30.118.6
	```
- 中国联通

	```TEXT
	123.125.81.6
	140.207.198.6
	```

DoH：

```TEXT
https://doh.360.cn
```

DoT：

```TEXT
dot.360.cn
```

### 114DNS

IPv4 纯净版：

```TEXT
114.114.114.114
114.114.115.115
```

IPv4 安全版(拦截钓鱼病毒木马网站等)：

```TEXT
114.114.114.119
114.114.115.119
```

IPv4 家庭版(拦截色情网站，保护少年儿童)：

```TEXT
114.114.114.110
114.114.115.110
```

### CNNIC DNS

IPv4：

```TEXT
1.2.4.8
210.2.4.8
```

IPv6 **[无法解析]**：

```TEXT
2001:dc7:1000::1
```

### Yeti DNS

IPv6：

```TEXT
240C::6666
240C::6644
```

DoH：

```TEXT
https://dns.ipv6dns.com/dns-query
```

DoT：

```TEXT
dns.ipv6dns.com
```



### OneDNS

#### 纯净版

不对访问网站进行任何过滤拦截，直接返回其真实的响应结果。

IPv4：

```TEXT
117.50.10.10
52.80.52.52
```

IPv6：

```TEXT
2400:7fc0:849e:200::8
2404:c2c0:85d8:901::8
```

DoH：

```TEXT
doh-pure.onedns.net/dns-query
```

DoT：

```TEXT
dot-pure.onedns.net
```

#### 拦截版

防护各类恶意软件，过滤广告骚扰。

IPv4：

```TEXT
52.80.66.66
117.50.22.22
```

IPv6：

```TEXT
2400:7fc0:849e:200::4
2404:c2c0:85d8:901::4
```

DoH：

```TEXT
doh.onedns.net/dns-query
```

DoT：

```TEXT
dot.onedns.net
```

#### 家庭版

在拦截版的基础上，增加了色情暴力站点过滤、赌博站点过滤功能，更好的净化家庭网络环境。

IPv4：

```TEXT
117.50.60.30
52.80.60.30
```

### **Hi!XNS DNS**

**[已无法使用]**

IPv4：

```TEXT
40.73.101.101
```

### TWNIC DNS Quad 101

IPv4：

```TEXT
101.101.101.101
101.102.103.104
```

IPv6：

```TEXT
2001:de4::101
2001:de4::102
```

DoH：

```TEXT
https://dns.twnic.tw/dns-query
```

### HiNet 中华电信 DNS

IPv4：

```TEXT
168.95.1.1
168.95.192.1
```

IPv6：

```TEXT
2001:b000:168::1
2001:b000:168::2
```



## 国内教育网

### 北京邮电大学

IPv6：

```TEXT
2001:da8:202:10::36
2001:da8:202:10::37
```

### 上海交通大学

校外无法使用，仅限上海市交通大学校内使用。

IPv4：

```TEXT
202.120.2.100
202.120.2.101
```

IPv6：

```TEXT
2001:da8:8000:1:202:120:2:100
2001:da8:8000:1:202:120:2:101
```

### Yeti DNS Project

#### 中科院网络信息中心

IPv6：

```TEXT
2001:cc0:2fff:1::6666
```

#### 北京交通大学

IPv6：

```TEXT
2001:da8:205:2060::188
```

#### 清华大学

IPv6：

```TEXT
2001:da8:ff:305:20c:29ff:fe1f:a92a
```

### 清华大学 TUNA 协会

IPv4停止对校外解析，IPv6仍可使用。

IPv4：

```TEXT
101.6.6.6
```

IPv6：

```TEXT
2001:da8::666
```

DoH：

```TEXT
https://101.6.6.6:8443/dns-query
```

### 北京科技大学

IPv6：

```TEXT
2001:da8:208:10::6
```

### 中国科技网

IPv6：

```TEXT
2001:cc0:2fff:2::6 
```

## 海外

### Google Public DNS

IPv4：

```TEXT
8.8.8.8
8.8.4.4
```

IPv6：

```TEXT
2001:4860:4860::8888
2001:4860:4860::8844
```

DoH：

```TEXT
https://dns.google/dns-query
```

DoH(IPv6)：

```TEXT
https://dns64.dns.google/dns-query
```

DoT：

```TEXT
dns.google
```

### Cloudflare DNS

#### 普通版

IPv4：

```TEXT
1.1.1.1
1.0.0.1
```

IPv6：

```TEXT
2606:4700:4700::1111
2606:4700:4700::1001
```

DoH：

```TEXT
https://cloudflare-dns.com/dns-query
https://1.1.1.1/dns-query
https://1.0.0.1/dns-query
```

DoT：

```TEXT
1dot1dot1dot1.cloudflare-dns.com
one.one.one.one
```

#### 安全版(拦截恶意代码)

IPv4：

```TEXT
1.1.1.2
1.0.0.2
```

IPv6：

```TEXT
2606:4700:4700::1112
2606:4700:4700::1002
```

DoH：

```TEXT
https://security.cloudflare-dns.com/dns-query
```

DoT：

```TEXT
security.cloudflare-dns.com
```

#### 家庭版(拦截恶意代码和成人内容)

IPv4：

```TEXT
1.1.1.3
1.0.0.3
```

IPv6：

```TEXT
2606:4700:4700::1113
2606:4700:4700::1003
```

DoH：

```TEXT
https://family.cloudflare-dns.com/dns-query
```

DoT：

```TEXT
family.cloudflare-dns.com
```

### Quad9 DNS

IPv4：

```TEXT
9.9.9.9
149.112.112.112
```

IPv6：

```TEXT
2620:fe::fe
2620:fe::9
```

DoH：

```TEXT
https://dns.quad9.net/dns-query
```

DoT：

```TEXT
dns.quad9.net
```

### DNS.SB

IPv4：

```TEXT
185.222.222.222
45.11.45.11
```

IPv6：

```TEXT
2a09::
2a11::
```

DoH：

```TEXT
https://doh.dns.sb/dns-query
https://doh.sb/dns-query
```

DoT：

```TEXT
dot.sb
```

### Cisco OpenDNS/Cisco Umbrella

IPv4：

```TEXT
208.67.222.222
208.67.220.220
208.67.222.220
208.67.220.222
```

IPv6：

```TEXT
2620:119:35::35
2620:119:53::53
```

DoH：

```TEXT
https://doh.opendns.com/dns-query
https://dns.opendns.com/dns-query
https://dns.umbrella.com/dns-query
```

### OpenDNS FamilyShield

阻止成人内容。

IPv4：

```TEXT
208.67.222.123
208.67.220.123
```

IPv6：

```TEXT
2620:119:35::123
2620:119:53::123
```

DoH：

```TEXT
https://familyshield.opendns.com/dns-query
https://doh.familyshield.opendns.com/dns-query
```

### Yandex DNS

#### 基础版

快速可靠。

IPv4：

```TEXT
77.88.8.8
77.88.8.1
```

IPv6：

```TEXT
2a02:6b8::feed:0ff
2a02:6b8:0:1::feed:0ff
```

DoH：

```TEXT
https://common.dot.dns.yandex.net
https://77.88.8.8
https://2a02:6b8::feed:0ff
```

DoT：

```TEXT
common.dot.dns.yandex.net
77.88.8.8
2a02:6b8::feed:0ff
```

#### 安全版

病毒和钓鱼防御。

IPv4：

```TEXT
77.88.8.88
77.88.8.2
```

IPv6：

```TEXT
2a02:6b8::feed:bad
2a02:6b8:0:1::feed:bad
```

DoH：

```TEXT
https://safe.dot.dns.yandex.net
```

DoT：

```TEXT
safe.dot.dns.yandex.net
```

#### 家庭版

拦截成人内容。

IPv4：

```TEXT
77.88.8.7
77.88.8.3
```

IPv6：

```TEXT
2a02:6b8::feed:a11
2a02:6b8:0:1::feed:a11
```

DoH：

```TEXT
https://family.dot.dns.yandex.net
```

DoT：

```TEXT
family.dot.dns.yandex.net
```

### COMODO SecureDNS

IPv4：

```TEXT
8.26.56.26
8.20.247.20
```

### Neustar UltraDNS

#### 基础版

快速可靠。

IPv4：

```TEXT
64.6.64.6
64.6.65.6
```

IPv6：

```TEXT
2620:74:1b::1:1
2620:74:1c::2:2
```

#### 安全版

病毒和钓鱼防御。

IPv4：

```TEXT
156.154.70.2
156.154.71.2
```

IPv6：

```TEXT
2610:a1:1018::2
2610:a1:1019::2
```

#### 家庭版

拦截成人内容。

IPv4：

```TEXT
156.154.70.3
156.154.71.3
```

IPv6：

```TEXT
2610:a1:1018::3
2610:a1:1019::3
```

### AdGuard DNS

#### 默认服务器

拦截广告和跟踪器

IPv4：

```TEXT
94.140.14.14
94.140.15.15
```

IPv6：

```TEXT
2a10:50c0::ad1:ff
2a10:50c0::ad2:ff
```

DoH：

```TEXT
https://dns.adguard-dns.com/dns-query
```

DoT：

```TEXT
dns.adguard-dns.com
```

#### 无过滤服务器

不拦截广告和跟踪器

IPv4：

```TEXT
94.140.14.140
94.140.14.141
```

IPv6：

```TEXT
2a10:50c0::1:ff
2a10:50c0::2:ff
```

DoH：

```TEXT
https://unfiltered.adguard-dns.com/dns-query
```

DoT：

```TEXT
unfiltered.adguard-dns.com
```

#### 家庭保护服务器

在可能的情况下拦截广告、跟踪器和成人内容，并启用安全搜索和安全模式。

IPv4：

```TEXT
94.140.14.15
94.140.15.16
```

IPv6：

```TEXT
2a10:50c0::bad1:ff
2a10:50c0::bad2:ff
```

DoH：

```TEXT
https://family.adguard-dns.com/dns-query
```

DoT：

```TEXT
family.adguard-dns.com
```

### Level 3 Parent DNS

如果 Windows 升级出现问题，可以使用这个 DNS 服务器。

IPv4：

```TEXT
4.2.2.1
4.2.2.2
4.2.2.3
4.2.2.4
4.2.2.5
4.2.2.6
```

## DNS相关知识

### 1.DNS 如何选择：

在国内一般使用我提供的几个国内 DNS 服务器都可以，如果身处海外的话建议选择海外的公共 DNS 服务器。另外经过测试，114DNS、百度 DNS、腾讯 DNS 在海外大部分地区都可以使用，而 阿里DNS 在海外很多地区连通性不好。

### 2.什么是 DoT 和 DoH：

DoT 和 DoH 都是加密DNS的一种方式，区别在于它们采用不同的协议和端口，两个都是域名解析安全扩展协议的一种。

概念：

- DoT 全称 DNS over TLS，它使用 TLS 来传输 DNS 协议。
- DoH 全称 DNS over HTTPS，它使用 HTTPS 来传输 DNS 协议。

两个协议原理是相同的，都是通过加密传输用户和 DNS 服务器之间的 DNS 消息，起到防止中间用户窃听和域名查询隐私泄漏的作用。相对来说 DoH 更通用一些。

DOH常用于PC端，DOT常用于手机端。

------

部分资源来自[icoa.cn](https://www.icoa.cn)。
