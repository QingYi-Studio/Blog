---
title: Clash快速入手
date: 2024-07-29 17:20:26
description: 建议您在继续阅读本节之前，先阅读介绍。在您对Clash的工作原理有了简单的了解后，您可以开始编写您自己的配置。
category_bar: true
hide: true
---

# Clash快速入手

建议您在继续阅读本节之前，先阅读[介绍](http://blog.qingyi-studio.top/2024/07/04/Clash%E4%BB%8B%E7%BB%8D/)。在您对Clash的工作原理有了简单的了解后，您可以开始编写您自己的配置。

## 配置文件

主配置文件名为 `config.yaml`。默认情况下，Clash会在 `$HOME/.config/clash` 目录读取配置文件。如果该目录不存在，Clash会在该位置生成一个最小的配置文件。

如果您想将配置文件放在其他地方 (例如 `/etc/clash`) ，您可以使用命令行选项 `-d` 来指定配置目录：

```shell
clash -d . # current directory
clash -d /etc/clash
```

或者, 您可以使用选项 `-f` 来指定配置文件：

```shell
clash -f ./config.yaml
clash -f /etc/clash/config.yaml
```

