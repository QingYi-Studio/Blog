---
title: MongoDB 集合
date: 2025-05-08 23:53:12
tags:
  - 数据库
  - MongoDB
categories:
  - 数据库
  - MongoDB
  - 基础用法
---
# MongoDB 集合

## 创建集合

MongoDB 中使用 **createCollection()** 方法来创建集合。

语法格式：

```javascript
db.createCollection(name, options)
```

参数说明：

* name: 要创建的集合名称。
* options: 可选参数, 指定有关内存大小及索引的选项。

options 可以是如下参数：


| 参数名             | 类型   | 描述                                                                                                                                                                              | 示例值                          |
| -------------------- | -------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------- |
| `capped`           | 布尔值 | 是否创建一个固定大小的集合。                                                                                                                                                      | `true`                          |
| `size`             | 数值   | 集合的最大大小（以字节为单位）。仅在`capped` 为 true 时有效。                                                                                                                     | `10485760` (10MB)               |
| `max`              | 数值   | 集合中允许的最大文档数。仅在`capped` 为 true 时有效。                                                                                                                             | `5000`                          |
| `validator`        | 对象   | 用于文档验证的表达式。                                                                                                                                                            | `{ $jsonSchema: { ... }}`       |
| `validationLevel`  | 字符串 | 指定文档验证的严格程度。<br />`"off"`：不进行验证。<br />`"strict"`：插入和更新操作都必须通过验证（默认）。<br />`"moderate"`：仅现有文档更新时必须通过验证，插入新文档时不需要。 | `"strict"`                      |
| `validationAction` | 字符串 | 指定文档验证失败时的操作。`"error"`：阻止插入或更新（默认）。`"warn"`：允许插入或更新，但会发出警告。                                                                             | `"error"`                       |
| `storageEngine`    | 对象   | 为集合指定存储引擎配置。                                                                                                                                                          | `{ wiredTiger: { ... }}`        |
| `collation`        | 对象   | 指定集合的默认排序规则。                                                                                                                                                          | `{ locale: "en", strength: 2 }` |

在插入文档时，MongoDB 首先检查固定集合的 size 字段，然后检查 max 字段。

示例代码：

```javascript
db.createCollection("myComplexCollection", {
  capped: true,
  size: 10485760,
  max: 5000,
  validator: { $jsonSchema: {
    bsonType: "object",
    required: ["name", "email"],
    properties: {
      name: {
        bsonType: "string",
        description: "必须为字符串且为必填项"
      },
      email: {
        bsonType: "string",
        pattern: "^.+@.+$",
        description: "必须为有效的电子邮件地址"
      }
    }
  }},
  validationLevel: "strict",
  validationAction: "error",
  storageEngine: {
    wiredTiger: { configString: "block_compressor=zstd" }
  },
  collation: { locale: "en", strength: 2 }
});
```

这个示例创建了一个集合，具有以下特性：

* 固定大小，最大 10MB，最多存储 5000 个文档。
* 文档必须包含`name` 和`email` 字段，其中`name` 必须是字符串，`email` 必须是有效的电子邮件格式。
* 验证级别为严格，验证失败将阻止插入或更新。
* 使用 WiredTiger 存储引擎，指定块压缩器为 zstd。
* 默认使用英语排序规则。

如果要查看已有集合，可以使用 **show collections** 或 **show tables** 命令。

## 更新集合名

在 MongoDB 中，不能直接通过命令来重命名集合。

MongoDB 可以使用 renameCollection 方法来来重命名集合。

renameCollection  方法在 MongoDB 的 admin 数据库中运行，可以将一个集合重命名为另一个名称。

renameCollection 命令的语法：

```javascript
db.adminCommand({
  renameCollection: "sourceDb.sourceCollection",
  to: "targetDb.targetCollection",
  dropTarget: <boolean>
})
```

**参数说明：**

* **renameCollection** ：要重命名的集合的完全限定名称（包括数据库名）。
* **to** ：目标集合的完全限定名称（包括数据库名）。
* **dropTarget** （可选）：布尔值。如果目标集合已经存在，是否删除目标集合。默认值为`false`。

### 示例

假设你要将 test 数据库中的 oldCollection 重命名为 newCollection，可以按以下步骤进行：

1. 确保已连接到 test 数据库

```javascript
use test
```

2. 运行 renameCollection 命令

```javascript
db.adminCommand({ 
  renameCollection: "test.oldCollection", 
  to: "test.newCollection" 
});
```

如果你要将集合重命名到另一个数据库，例如将 test 数据库中的 oldCollection 重命名为 production 数据库中的 newCollection，可以这样做：

```javascript
db.adminCommand({ 
  renameCollection: "test.oldCollection", 
  to: "production.newCollection" 
});
```

#### 注意事项

* **权限要求** ：执行`renameCollection` 命令需要具有对源数据库和目标数据库的适当权限。通常需要`dbAdmin` 或`dbOwner` 角色。
* **目标集合不存在** ：目标集合不能已经存在。如果目标集合存在，则会返回错误。
* **索引和数据** ：重命名集合会保留所有文档和索引。

#### 检查重命名结果

重命名后，可以通过以下命令检查新的集合是否存在：

```javascript
use test
show collections
```

如果集合已重命名为 newCollection，你应该会在结果中看到 newCollection。

## 删除集合

MongoDB 中使用 drop() 方法来删除集合。

drop() 方法可以永久地从数据库中删除指定的集合及其所有文档，这是一个不可逆的操作，因此需要谨慎使用。

**语法格式：**

```javascript
db.collection.drop()
```

这个方法无需参数，如果成功删除选定集合，则 drop() 方法返回 true，否则返回 false。
