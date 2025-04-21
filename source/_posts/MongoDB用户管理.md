---
title: MongoDB 用户管理
date: 2025-04-21 21:59:10
tags:
  - 数据库
  - MongoDB
categories:
  - 数据库
  - MongoDB
  - 基础用法
---
# MongoDB 用户管理

## 使用 MongoDB Shell (mongo) 管理用户

以下是使用 MongoDB Shell (mongosh) 进行用户管理的详细说明，包括创建用户、分配角色、认证和登录的具体步骤。

**1. 连接到 MongoDB**

首先，打开你的终端并使用 mongosh 命令连接到 MongoDB 服务器：

mongosh --host `<hostname>` --port `<port>`

说明：

- `mongosh`：启动 MongoDB Shell 命令行工具。
- `--host <hostname>`：指定 MongoDB 服务器的主机名或 IP 地址。
  - `<hostname>`：MongoDB 服务器的主机名（如 `localhost`）或 IP 地址（如 `127.0.0.1`）。
- `--port <port>`：指定 MongoDB 服务器的端口号。
  - `<port>`：MongoDB 服务器监听的端口号，默认端口是 `27017`。

**2. 切换到目标数据库**

在 MongoDB 中，用户是针对特定数据库创建的，使用 **use** 命令切换到你要创建用户的数据库：

```sql
use <database_name>
```

* **database_name** - 为要切换的数据库。

**3. 创建用户**

使用 db.createUser 命令创建用户并分配角色。

例如，创建一个名为 testuser 的用户，密码为 password123，并赋予 readWrite 和 dbAdmin 角色：

```sql
db.createUser({
  user:"testuser",
  pwd:"password123",
  roles:[
    { role:"readWrite", db:"<database_name>"},
    { role:"dbAdmin", db:"<database_name>"}
  ]
})
```

**4. 验证用户**

创建用户后，你可以使用 db.auth 命令验证用户身份：

```sql
db.auth("testuser","password123")
```

**5. 启用身份验证**

为了确保只有经过身份验证的用户才能访问 MongoDB，需要启用身份验证。

编辑 MongoDB 配置文件 mongod.conf，并在其中添加以下内容：

```config
security:
  authorization:"enabled"
```

然后重启 MongoDB 服务以应用更改。

**6. 使用用户身份登录**

启用身份验证后，你需要使用创建的用户身份连接到 MongoDB：

```shell
mongosh --host <hostname>--port <port>-u "testuser"-p "password123"--authenticationDatabase "<database_name>"
```

**7. 删除用户**

使用 **db.dropUser** 命令删除指定用户。

例如，删除名为 testuser 的用户：

```sql
db.dropUser("testuser")
```

### 实例操作示例

启动 MongoDB Shell 并连接到服务器：

```shell
mongosh --host localhost --port 27017
```

切换到 testdb 数据库：

```sql
use testdb
```

创建 testuser 用户：

```sql
db.createUser({
  user:"testuser",
  pwd:"password123",
  roles:[{ role:"readWrite", db:"testdb"}]
})
```

**启用身份验证并重启 MongoDB 实例**

编辑 mongod.conf 文件，添加以下内容：

```config
security:
  authorization:"enabled"
```

重启 MongoDB 服务：

```shell
sudo systemctl restart mongod
```

使用 testuser 用户进行身份验证连接：

```shell
mongosh --host localhost --port 27017-u "testuser"-p "password123"--authenticationDatabase "testdb"
```

删除 testuser 用户：

```sql
db.dropUser("testuser")
```
