---
title: 国内DNS
date: 2024-01-19 23:36:48
tags:
- DNS
---

# 国内DNS

## 腾讯

### IPv4

```
119.29.29.29
```

### IPv6

```
2402:4e00::
```

### DoH

```
https://doh.pub/dns-query
```

### DoH (IP)

```
https://1.12.12.12/dns-query
https://120.53.53.53/dns-query
```

### DoH (国密)

```
https://sm2.doh.pub/dns-query
```

### DoT

```
dot.pub
```

### DoT (IP)

```
1.12.12.12
120.53.53.53
```

## 百度

### IPv4

```
180.76.76.76 
```

### ipv6

```
2400:da00::6666
```

## 360

[原地址](https://sdns.360.net/dnsPublic.html)

### IPv4

电信、移动、铁通：

```
101.226.4.6
218.30.118.6
```

联通：

```
123.125.81.6
140.207.198.6
```

### IPv6

无

### DoH

```
https://doh.360.cn
```

### DoT

```
dot.360.cn
```

### 特殊方法

#### Windows

下载并安装360安全DNS

链接：[`https://beijing.xstore.qihu.com/dns-360/360sdns_client_2.5.1_setup[d2luZG93cy5kb2guMzYwLmNu].exe`](https://beijing.xstore.qihu.com/dns-360/360sdns_client_2.5.1_setup[d2luZG93cy5kb2guMzYwLmNu].exe)

#### IOS / MacOS

下载安装配置文件，即描述文件。

链接：[`https://sdns.360.net/360-public-https.mobileconfig`](https://sdns.360.net/360-public-https.mobileconfig)

#### Linux / MacOS

在终端运行以下命令

```bash
sh -c "$(curl -sL https://sdns.360.net/install)"
```

#### Linux

1. 登入linux主机系统

2. 编辑文件`/etc/systemd/resolved.conf`，将其内容修改为：

   ```properties
   [Resolve]
   DNS=101.198.198.198
   DNS=101.198.199.200
   DNSOverTLS=yes
   ```

3. 执行命令`systemctl restart systemd-resolved`重启服务

#### 浏览器

##### 360

1. 从360安全浏览器菜单栏中点击【设置】
2. 在搜索框中输入“DNS”，在下方的检索结果中勾选【开启DNS安全解析】

##### Google Chrome

1. 打开Chrome浏览器，从 菜单栏中点击 【设置】选项
2. 在搜索框中输入“DNS”，在下方的检索结果中，点击【安全】右侧的展开箭头
3. 页面下拉到最下方，在【高级】选项中，开通“使用安全DNS”功能，并在【使用】-【自定义】框中输入`https://doh.360.cn`即可完成配置

##### Firefox

1. 从 Firefox 菜单栏中点击 【设置】
2. 搜索框中输入“DNS”，点击【网络设置】中的【设置】按钮
3. 在设置页面的底部，找到并勾选“启用基于HTTPS的DNS”，选择“自定义”的提供商，并输入接口地址`https://doh.360.cn`，点击【确定】

#### 路由器

1. 在浏览器中，访问路由器的管理控制台，并登录
2. 找到设置DNS服务器的页面。如果在主要和次要DNS服务器的字段中指定了IP地址，请将其记下以备将来参考
3. 据您所在的运营商（测试所在运营商），选择并替换成对应的360公共DNS服务地址（此处DNS服务地址参考前文IPv4地址）

#### 开发者

DoH的调用方式支持RFC8484和JSON两种调用方式：

RFC8484：`https://doh.360.cn/dns-query`

JSON：`https://doh.360.cn/resolve?`

如果需要别的服务，去找360客服。

[接入文档](https://sdns.360.net/360DNS-%E5%AF%B9%E6%8E%A5%E6%96%87%E6%A1%A3-2021-03-17.pdf)

#### DNS服务器

##### dnsmasq

1. 登入linux主机系统

2. 编辑文件/etc/dnsmasq.conf，在其中添加如下内容

   ```properties
   strict-order
   server=101.198.198.198
   server=123.125.81.6
   ```

3. 执行命令`systemctl restart dnsmasq`重启服务

##### dnsmasq DoH

1. 登入linux主机系统

2. 安装DoH代理360SDNS

   执行以下命令安装360SDNS
   ```bash
   LISTEN_IP=127.0.0.1 LISTEN_PORT=3053 sh -c "$(curl -sL https://sdns.360.net/install)"
   ```

3. 检查360SDNS服务

   运行如下命令
   ```bash
   dig @127.0.0.1 -p 3053 www.360.cn
   ```

   执行结果为NOERROR继续下一步

4. 编辑文件/etc/dnsmasq.conf，在其中添加如下内容

   ```properties
   strict-order
   server=127.0.0.1#3053
   ```

5. 执行命令重启服务

   ```bash
   systemctl restart dnsmasq
   ```

   

##### Unbound

1. 登入linux主机系统

2. 编辑文件`/etc/unbound/unbound.conf`，在其中添加内容：

   ```properties
   forward-zone:
      name: "."
      forward-addr: 101.226.4.6
      forward-addr: 123.125.81.6
   ```

3. 执行命令重启服务

   ```bash
   systemctl restart unbound
   ```

   注意：请删除其他forward-zone及其子配置项。

##### Unbound DoT

1. 登入linux主机系统

2. 编辑文件/etc/unbound/unbound.conf，在其中添加如下内容

   1. 添加forward-zone配置项

      ```properties
      forward-zone:
           name: "."
           forward-tls-upstream: yes
           forward-addr: 101.198.192.33#dot.360.cn
           forward-addr: 112.65.69.15#dot.360.cn
      ```
      
      注意：如果只通过tls方式接入上游服务器，请删除其他forward-zone及其子配置项

   2. 添加tls-cert-bundle配置项
      
      查找内容 # tls-cert-bundle，在其下方添加如下内容：
      
      ```properties
      tls-cert-bundle: "/etc/pki/tls/certs/ca-bundle.crt"
      ```
      
   
3. 执行命令重启服务

   ```bash
   systemctl restart unbound
   ```

##### BIND9

1. 登入linux主机系统

2. 编辑文件`/etc/bind/named.conf.options`，用以下内容替换或适配到该文件中

   ```properties
   options {
      directory "/var/cache/bind";
      recursion yes;
      allow-query { any; };
      forwarders {
        101.198.198.198;
        101.226.4.6;
      };
      dnssec-validation no;
      auth-nxdomain no;
      listen-on-v6 { any; };
   };
   ```

   注意：*forwarders*配置项中的内容用于将*named*接入到360SDNS。如果*named.conf.options*已经有相关配置，只需要将*forwarders*中的IP修改为360SDNS地址即可

3. 执行命令重启服务

   ```bash
   systemctl restart bind9
   ```

##### BIND9 DoH

1. 登入linux主机系统

2. 安装DoH代理360SDNS

   安装360SDNS
   
   ```bash
   LISTEN_IP=127.0.0.1 LISTEN_PORT=3053 sh -c "$(curl -sL https://sdns.360.net/install)"
   ```

3. 检查360SDNS服务

   ```bash
   dig @127.0.0.1 -p 3053 www.360.cn
   ```

   执行结果为NOERROR继续下一步

4. 编辑文件`/etc/bind/named.conf.options`，用以下内容替换或适配到该文件中

   ```properties
   options {
      directory "/var/cache/bind";
      recursion yes;
      allow-query { any; };
      forwarders {
        127.0.0.1 port 3053;
      };
      dnssec-validation no;
      auth-nxdomain no;
      listen-on-v6 { any; };
   };
   ```

   注意：*forwarders*配置项中的内容用于将*named*接入到DoH代理360SDNS。如果*named.conf.options*已经有相关配置，只需要将*forwarders*中的IP修改为`127.0.0.1 port 3053;`即可。

5. 执行命令重启服务

   ```bash
   systemctl restart bind9
   ```

##### Windows DNS Server

1. 打开DNS管理器，右键点击需要配置的DNS服务器名，选择“属性”![](https://p1.ssl.qhimg.com/t012221405d37f80a31.jpg)
2. 选择“转发器”选项卡，点击“编辑”![](https://p3.ssl.qhimg.com/t0167f7cd7bcb505de2.jpg)
3. 输入上游DNS服务地址，点击确定![](https://p3.ssl.qhimg.com/t01e3300dafc891cb6c.jpg)
4. 添加结果如下![](https://p1.ssl.qhimg.com/t0149e96e0b5c547a24.jpg)

##### Windows DNS Server DoH

1. 在[此处](https://beijing.xstore.qihu.com/dns-360/360sdns_server_2.5.0_setup[d2luZG93cy5kb2guMzYwLmNu].exe)下载安装程序
2. 根据如图安装后，即可使用
   1. ![](https://p3.ssl.qhimg.com/t01f524152adf83fc81.jpg)
   2. ![](https://p1.ssl.qhimg.com/t01e38f58ff3357001f.jpg)
   3. ![](https://p3.ssl.qhimg.com/t016348752b51c00dda.jpg)
   4. ![](https://p2.ssl.qhimg.com/t0121073174b7c847ca.jpg)
3. 打开DNS管理器，右键点击需要配置的DNS服务器名，选择“属性”![](https://p1.ssl.qhimg.com/t012221405d37f80a31.jpg)
4. 选择“转发器”选项卡，点击“编辑”![](https://p2.ssl.qhimg.com/t014173ef8496c7e24e.jpg)
5. 输入上游DNS服务地址(如果安装在本机，使用127.0.0.2，若是其他机器，则是对应IP，并添加备用地址101.198.198.198)，点击确定![](https://p0.ssl.qhimg.com/t01968f524ec19a61c7.jpg)
6. 添加结果如下(注:127.0.0.2 是本机IP，服务器FQDN显示无法解析为正常现象，不影响功能使用)![](https://p4.ssl.qhimg.com/t012cebb4159b7346a0.jpg)
7. 安装完成后，在浏览器中测试打开*http://www.360.cn*是否正常，然后使用`nslookup www.360.cn 127.0.0.2`验证![](https://p4.ssl.qhimg.com/t016144f5a79090852d.jpg)
