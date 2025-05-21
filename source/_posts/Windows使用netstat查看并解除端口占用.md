---
title: Windows使用netstat查看并解除端口占用
date: 2025-05-21 12:40:50
tags:
- Windows
---

# Windows 使用 netstat 查看并解除端口占用

以我们网页开发常用的80端口为示例，可根据实际情况修改。

```bash
netstat -ano | findstr "80"
```

这行代码会把`netstat`返回信息中所有包含80的行筛选出来，然后记住最后一列的PID。

```bash
tasklist | findstr "[PID]"
```

之后利用`tasklist`来将返回信息中带有指定PID的行筛选出来。

有些应用，如nginx使用pid关闭后会自动重启，所以此处使用另一种方法来关闭。

```bash
taskkill /f /im [name].exe
```
