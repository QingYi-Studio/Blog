---
title: MongoDB 默认数据库
date: 2025-05-08 23:16:22
tags:
  - 数据库
  - MongoDB
categories:
  - 数据库
  - MongoDB
  - 基础用法
---
# MongoDB 默认数据库

MongoDB 中默认的数据库为 test，如果你没有创建新的数据库，集合将存放在 test 数据库中。

当您通过 shell 连接到 MongoDB 实例时，如果未使用 use 命令切换到其他数据库，则会默认使用 test 数据库。例如，在启动 MongoDB 实例并连接到 MongoDB shell 后，如果您开始插入文档而未显式指定数据库，MongoDB 将默认使用 test 数据库。

> **注意:** 在 MongoDB 中，集合只有在内容插入后才会创建，就是说，创建集合(数据表)后要再插入一个文档(记录)，集合才会真正创建。
