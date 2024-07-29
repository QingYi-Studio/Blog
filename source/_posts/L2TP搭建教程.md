---
title: L2TP搭建教程
date: 2024-02-15 21:15:40
description: 在VPS服务器上搭建并使用L2TP来制作简易VPN。
tags:
- VPN
- 翻墙
- 国际联网
---

# L2TP搭建教程

[Finalshell下载地址](https://blog-assets.qingyi-cdn.top/L2TP搭建教程/finalshell_install.exe)

买一个VPS服务器，厂商随意，系统使用CentOS 3.6。

[^开通好的的机器，在机器界面，点击防火墙创建防火墙规则]:你用到什么规则就填写什么规则，比如你用到的端口是5555 你就开放5555，如果对于端口不是很清楚的，那么就直接ALL

接下来修改密码，必须要修改重置一下，这个密码自己要记住，因为等会Finashell远程的时候是需要填写账号密码的，重置账号密码后等待一分钟他在重启服务器，重启完服务器后，密码就会生效。

打开我们刚下载安装好的Finalshell工具。

![](https://blog-assets.qingyi-cdn.top/L2TP搭建教程/finalshell-connect.png)

运行命令：

```shell
wget https://blog-assets.qingyi-cdn.top/L2TP搭建教程/vpnsetup.sh -O vpn.sh && sudo sh vpn.sh
```

PS:傻瓜式一键搭建脚本

之后测试搭建是否成功。

![](https://blog-assets.qingyi-cdn.top/L2TP搭建教程/test-l2tp-1.png)
![](https://blog-assets.qingyi-cdn.top/L2TP搭建教程/test-l2tp-2.png)

这些没问题的话，就测试连接测试IP是否成功

![](https://blog-assets.qingyi-cdn.top/L2TP搭建教程/test-l2tp-3.png)

Windows 10会遇到一些问题，比如连接不上，或者出现809，这里是一些解决的办法。

1. 解决办法： Win + R呼出运行窗口，输入`regedit`
    ![](https://blog-assets.qingyi-cdn.top/L2TP搭建教程/l2tp-bugfix-1.png)
2. 在左侧依次找`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\PolicyAgent`
3. 右键，新建Dword值，名为`AssumeUDPEncapsulationContextOnSendRule`
    ![](https://blog-assets.qingyi-cdn.top/L2TP搭建教程/l2tp-bugfix-2.png)
4. 双击刚刚创建好的值，将值改为2
    ![](https://blog-assets.qingyi-cdn.top/L2TP搭建教程/l2tp-bugfix-3.png)
5. 重启电脑，即可完成连接

------

使用方法：

`sudo delvpnuser.sh`  添加用户

`sudo delvpnuser.sh`  删除用户

`/etc/ppp/chap-secrets` 用户保存路径