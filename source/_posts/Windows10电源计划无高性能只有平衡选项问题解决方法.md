---
title: Windows10 电源计划无高性能只有平衡选项问题解决方法
date: 2025-04-07 16:08:01
categories:
- Windows
tags:
- Windows
---

# Windows10 电源计划无高性能只有平衡选项问题解决方法

![出现错误的图片](https://blog-assets.qingyi-cdn.top/Windows10%E7%94%B5%E6%BA%90%E8%AE%A1%E5%88%92%E6%97%A0%E9%AB%98%E6%80%A7%E8%83%BD%E5%8F%AA%E6%9C%89%E5%B9%B3%E8%A1%A1%E9%80%89%E9%A1%B9%E9%97%AE%E9%A2%98%E8%A7%A3%E5%86%B3%E6%96%B9%E6%B3%95/1.png)

1. 按下“Windows键”+“R键”，然后输入regedit，依次点击注册表左侧的：HKEY_LOCAL_MACHINE、SYSTEM、CurrentControlSet、Control、Power
	右侧可以看到CsEnabled选项，双击，将数值“1”改为“0”，然后点击确定，最后重启电脑

2. 若找不到CsEnabled选项，以管理员模式运行命令提示符，输入如下代码并回车执行

	```shell
	reg add HKLM\System\CurrentControlSet\Control\Power /v PlatformAoAcOverride /t REG_DWORD /d 0
	```

	
