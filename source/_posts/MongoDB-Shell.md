---
title: MongoDB Shell
date: 2025-04-08 21:37:21
tags:
- 数据库
- MongoDB
categories:
- 数据库
- MongoDB
- 介绍
---

# MongoDB Shell

**启动 MongoDB Shell：**

在命令行中输入 mongosh 命令，启动 MongoDB Shell，如果 MongoDB 服务器运行在本地默认端口（27017），则可以直接连接。

```bash
mongosh
```

查看版本：

```bash
mongosh --version
```

**连接到 MongoDB 服务器：**

如果 MongoDB 服务器运行在非默认端口或者远程服务器上，可以使用以下命令连接：

```bash
mongosh --host <hostname>:<port>
```

其中 `<hostname>` 是 MongoDB 服务器的主机名或 IP 地址，`<port>` 是 MongoDB 服务器的端口号。
