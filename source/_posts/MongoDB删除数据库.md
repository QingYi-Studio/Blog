---
title: MongoDB 删除数据库
date: 2025-05-08 23:41:40
tags:
  - 数据库
  - MongoDB
categories:
  - 数据库
  - MongoDB
  - 基础用法
---
# MongoDB 删除数据库

MongoDB 删除数据库的语法格式如下：

```sql
db.dropDatabase()
```

删除当前数据库，默认为`test`，你可以使用`db`命令查看当前数据库名。

我们需要先切换到想要删除的数据库，然后再执行删除语句，最后可使用`show dbs`检查是否成功删除。
