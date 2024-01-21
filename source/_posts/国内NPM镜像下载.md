---
title: 国内NPM镜像下载
date: 2024-01-21 19:28:06
description: 使用国内NPM镜像加速下载
categories:
- Node.js
tags:
- 编程
- Node.js
---

# 国内 NPM 镜像源

| 站点名称 | 站点地址                                 |
| ------------ | ------------------------------------------------------------ |
| 官方      | https://registry.npmjs.org/                                  |
| 淘宝 | https://registry.npm.taobao.org |
|阿里云 | https://npm.aliyun.com|
|腾讯云 | https://mirrors.cloud.tencent.com/npm/|
|华为云 | https://mirrors.huaweicloud.com/repository/npm/|
|网易 | https://mirrors.163.com/npm/|
|中科院大学 | http://mirrors.ustc.edu.cn/|
|清华大学 | https://mirrors.tuna.tsinghua.edu.cn/|

腾讯、华为、阿里的镜像站基本上比较全，个人使用的是腾讯的

## 使用方法

### 设置镜像源

```sh
npm config set registry {url}
```

*{url}*为上问中的站点地址

### 查看当前的镜像源

```sh
npm config get registry
```

