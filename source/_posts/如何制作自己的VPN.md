---
title: 如何制作自己的VPN
date: 2023-12-15 18:08:50
description: 使用Shadowsocks(ss)或OpenVPN来配置VPN，并有根据不同用户来进行分类配置。
tags:
- VPN
- 翻墙
- 国际联网
---

# 如何制作自己的VPN

注意！即便建立了私有VPN，频繁使用IP仍然可能被封，所以此方法仅限查资料用途，不要去Youtube看视频或下载。

创建私有VPN使用方便，稳定，被封的几率小。

建议先去买一个云服务器/虚拟机，例如AWS、GCP或DigitalOcean等，来安装并运行您的VPN服务器。您可以根据需要选择服务器的规格和地理位置，以及操作系统类型，如Ubuntu、CentOS或Debian等。

<strong style="color: #9370db;">如果你有网站，不建议你用你现有的服务器创建VPN，万一被封了连你的网站也用不了了。</strong>

VPN服务器可以使用多种协议，例如OpenVPN、L2TP/IPSec和PPTP等。根据您的需求和设备支持，选择一种协议。

## Shadowsocks(虚拟机)

创建虚拟机时选择CentOS，其余都选最低的（默认配置）即可。接下来就是安装Shadowsocks服务端了。

### 安装 Shadowsocks 服务端

点击Access console进入服务器终端，输入以下命令行：

```bash
yum install python-setuptools && easy_install pip
pip install shadowsocks
```

如果是Linux系统，可输入如下命令

```bash
apt-get install python-pip
pip install shadowsocks
```

之后通过vi新建VPN的配置文件

```bash
vi /etc/shadowsocks.json
```

进入vi编辑器界面后，按INSERT键（Mac上按i键）进入编辑模式。输入如下内容，更改带注释的项目。

```json
{  
    "server":"0.0.0.0", //此处替换成你的服务器IP  
    "server_port":8388, //此处替换成你需要的端口，最好不要使用默认的8388 
    "local_address": "127.0.0.1",  
    "local_port":1080,  
    "password":"你的VPN密码",  
    "timeout":500,  
    "method":"aes-256-cfb",  
    "fast_open": false  
}
```

输入好后，点击ESC键退出编辑模式，然后输入`:x`即可保存文件。

之后输入如下命令启动VPN服务

```bash
  ssserver -c /etc/shadowsocks.json -d start
```

如下命令可以停止服务

```bash
  ssserver -c /etc/shadowsocks.json -d stop
```

如下命令可以在前台启动服务

```bash
  ssserver -c /etc/shadowsocks.json
```

如果需要开机自动启动VPN服务，按如下进行操作

```bash
  vi /etc/rc.local
```

文件内容编辑为：

```bash
  ssserver -c /etc/shadowsocks.json -d start
```

Shadowsocks 日志保存在 <a style="color: #ff66cc;"> /var/log/shadowsocks.log</a>

服务端配置好后，下面就是用 Shadowsocks 客户端来使用VPN服务了。

### 安装 Shadowsocks 客户端

#### Windows

https://github.com/shadowsocks/shadowsocks-windows/releases

#### Mac OS

https://github.com/shadowsocks/ShadowsocksX-NG/releases

#### Linux

https://github.com/shadowsocks/shadowsocks-qt5/wiki/Installation
https://github.com/shadowsocks/shadowsocks-qt5/releases

#### Android

https://play.google.com/store/apps/details?id=com.github.shadowsocks   
https://github.com/shadowsocks/shadowsocks-android/releases

#### IOS

由于多个地区商店均没有收录该应用，请在App Store搜索***FirstWingy***

## OpenVPN

### 安装VPN服务器软件

安装并配置您选择的VPN服务器软件。一般来说，您可以在服务器上运行以下命令来安装：

```bash
sudo apt-get update
sudo apt-get install openvpn easy-rsa
```

对于其他协议，可以在云服务提供商的文档中找到相应的安装指南。

### 配置VPN服务器

一旦安装了VPN服务器软件，需要进行配置。

你需要生成VPN服务器和客户端证书、设置用户认证、定义VPN路由和网络地址转换（NAT）规则等。

#### 生成证书和密钥

在服务器上，使用Easy-RSA工具集来生成证书和密钥

- 首先，你需要设置Easy-RSA并初始化证书颁发机构（CA）。

  ```bash
  cd /usr/share/easy-rsa
  cp -r /usr/share/doc/openvpn/examples/easy-rsa/3.0/* .
  vim vars
  ./easyrsa init-pki
  ```

- 生成服务器证书和密钥

  ```bash
  ./easyrsa build-ca
  ./easyrsa gen-req servername
  ./easyrsa sign-req server servername
  ```

- 生成客户端证书和密钥

  ```bash
  ./easyrsa gen-req clientname
  ./easyrsa sign-req client clientname
  ```

#### 配置服务器

- 创建一个服务器配置文件（例如，server.ovpn）并进行相应的配置。以下是一个示例配置文件：

  ```properties
  port 1194
  proto udp
  dev tun
  ca /etc/openvpn/server/ca.crt
  cert /etc/openvpn/server/server.crt
  key /etc/openvpn/server/server.key
  dh /etc/openvpn/server/dh.pem
  server 10.8.0.0 255.255.255.0
  ifconfig-pool-persist ipp.txt
  push "redirect-gateway def1 bypass-dhcp"
  push "dhcp-option DNS 8.8.8.8"
  duplicate-cn
  keepalive 10 120
  cipher AES-128-CBC
  comp-lzo
  user nobody
  group nogroup
  persist-key
  persist-tun
  status openvpn-status.log
  verb 3
  ```

- 将生成的服务器证书和密钥（ca.crt、server.crt、server.key）复制到服务器上的相应目录中，如/etc/openvpn/server/

#### 配置客户端

 - 创建一个客户端配置文件（例如，client.ovpn）并进行相应的配置。以下是一个示例配置文件：

     ```properties
     client
     dev tun
     proto udp
     remote your_server_ip 1194
     resolv-retry infinite
     nobind
     ca ca.crt
     cert client.crt
     key client.key
     comp-lzo
     verb 3
     ```

   - 将生成的客户端证书和密钥（ca.crt、client.crt、client.key）复制到客户端上，并将配置文件中的"your_server_ip"替换为你的服务器IP地址。 

#### 配置用户认证

- 对于用户名/密码认证，可以在服务器上创建一个用户名和密码文件（如auth.txt），并在服务器配置文件中指定。

  ```bash
  auth-user-pass auth.txt
  ```

- 对于证书认证，OpenVPN会自动验证客户端证书。

#### 定义VPN路由

- 在服务器上配置VPN路由。你可以使用route命令或在配置文件中添加"push route"来定义VPN路由。

  ```bash
  push "route 192.168.0.0 255.255.255.0"
  ```

#### 设置网络地址转换（NAT）规则

- 如果你希望通过VPN访问互联网，你需要设置网络地址转换（NAT）规则。以下是一个iptables的示例规则：

  ```bash
  iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE
  ```

- 这个规则将允许从VPN子网（10.8.0.0/24）中的客户端访问通过eth0接口连接的互联网。

#### 通过配置用户认证来给不同的用户设置不同的流量限制或速度限制

通过配置用户认证来给不同的用户设置不同的流量限制或速度限制，你可以使用OpenVPN的用户配置文件和配额限制功能。下面是一些示例步骤供参考：

1. 创建用户配置文件：
   - 在服务器上为每个用户创建一个独立的用户配置文件。
   - 在OpenVPN服务器配置文件中添加以下行，以告诉服务器加载用户配置文件：
     ```properties
     client-config-dir /etc/openvpn/ccd
     ```
   - 创建一个目录用于存放用户配置文件，例如`/etc/openvpn/ccd`。

2. 配置用户限制：
   - 对于流量限制，可以在用户配置文件中添加以下行，以限制每个用户的流量。例如，限制用户A的流量为100MB：
     ```properties
     ifconfig-push 10.8.0.2 255.255.255.0
     ifconfig-pool-persist ipp.txt
     ifconfig-noexec
     client-connect "/etc/openvpn/scripts/set_user_limit.sh A 100"
     ```
   - 对于速度限制，可以使用Linux的`tc`命令来设置用户的带宽限制。创建一个脚本（例如`set_user_speed.sh`）并在用户配置文件中调用该脚本。以下是一个示例脚本，将用户A的上传速度限制为100kbps：
     ```bash
     #!/bin/bash
     USERNAME=$1
     
     # Clear existing traffic control rules for the user
     tc qdisc del dev $dev root
     
     # Set new traffic control rules
     tc qdisc add dev $dev root handle 1: htb default 30
     tc class add dev $dev parent 1: classid 1:1 htb rate 100kbps
     tc filter add dev $dev protocol ip parent 1: prio 1 u32 match ip src $ifconfig_local flowid 1:1
     ```

3. 创建脚本：
   - 创建一个脚本（例如`set_user_limit.sh`）来设置用户的流量限制。以下是一个示例脚本，该脚本将读取用户名和流量限制作为参数，并使用iptables和tc命令来限制用户的流量：
     ```bash
     #!/bin/bash
     USERNAME=$1
     LIMIT=$2
     
     # Clear existing iptables rules for the user
     iptables -D FORWARD -m state --state NEW -m comment --comment "$USERNAME" -j ACCEPT
     
     # Set new iptables rules
     iptables -I FORWARD -m state --state NEW -m comment --comment "$USERNAME" -j ACCEPT
     
     # Set traffic control rules
     tc qdisc del dev $dev root
     tc qdisc add dev $dev root handle 1: htb default 30
     tc class add dev $dev parent 1: classid 1:1 htb rate $LIMIT
     tc filter add dev $dev protocol ip parent 1: prio 1 u32 match ip src $ifconfig_local flowid 1:1
     ```

4. 将脚本和用户配置文件放入正确的位置：
   - 将`set_user_limit.sh`和`set_user_speed.sh`脚本复制到服务器上的适当位置，并确保设置正确的执行权限。
   - 将每个用户的配置文件放入`/etc/openvpn/ccd`目录中，文件名与用户名相匹配。

### 启动VPN服务器

在完成配置后，启动VPN服务器并确保它可以正常运行。一般来说，可以使用以下命令启动:

```bash
sudo systemctl start openvpn@server
```

对于其他协议，请参阅相关文档以了解如何启动服务器。

### 测试VPN连接

使用您的VPN客户端应用程序测试VPN连接，确保它可以成功连接到VPN服务器并通过VPN通信。

以上是搭建自己的VPN服务器的基本步骤。具体的配置和操作可能因所选的VPN协议而异。在进行任何更改之前，请确保了解你正在执行的操作，并备份数据以防万一。

### 使用 Objective-C 配置 *NETunnelProviderProtocol* 对象的示例代码

#### 配置协议名称和版本

```objective-c
NETunnelProviderProtocol *protocolConfiguration = [[NETunnelProviderProtocol alloc] init];
protocolConfiguration.serverAddress = @"your-vpn-server-address";
protocolConfiguration.providerBundleIdentifier = @"your-vpn-app-bundle-identifier";
protocolConfiguration.providerConfiguration = @{@"key": @"value"};
protocolConfiguration.protocolConfigurationDescription = @"My VPN";
protocolConfiguration.disconnectOnSleep = YES;
```

在这里，需要将 "your-vpn-server-address" 替换为VPN服务器地址，将 "your-vpn-app-bundle-identifier" 替换为VPN应用程序的 Bundle Identifier，将 "key" 和 "value" 替换为希望包含在配置中的其他信息。

#### 配置用户名和密码

```objective-c
protocolConfiguration.username = @"your-vpn-username";
protocolConfiguration.passwordReference = passwordReference;
```

如果VPN服务器需要身份验证，则可以使用上面的代码配置用户名和密码。这里的 "your-vpn-username" 是VPN帐户用户名，而 passwordReference 则是VPN帐户密码的引用。

#### 配置协议设置

```objective-c
NEProxySettings *proxySettings = [[NEProxySettings alloc] init];
proxySettings.HTTPEnabled = YES;
proxySettings.HTTPServer = @"your-http-server-address";
proxySettings.HTTPPort = your-http-server-port;
proxySettings.HTTPSEnabled = YES;
proxySettings.HTTPSServer = @"your-https-server-address";
proxySettings.HTTPSPort = your-https-server-port;
NETunnelProviderProtocol *protocolConfiguration = [[NETunnelProviderProtocol alloc] init];
protocolConfiguration.proxySettings = proxySettings;
```

如果需要使用代理服务器连接到VPN服务器，则可以使用上面的代码配置代理设置。在这里需要将 "your-http-server-address" 替换为HTTP代理服务器地址，将 your-http-server-port 替换为HTTP代理服务器端口，将 "your-https-server-address" 替换为HTTPS代理服务器地址，将 your-https-server-port 替换为HTTPS代理服务器端口。

以上是一些配置 *NETunnelProviderProtocol* 的基本示例，具体的配置需求取决于您的VPN服务器和应用程序需求。
