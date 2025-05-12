---
title: MongoDB 文档
date: 2025-05-12 21:40:12
tags:
  - 数据库
  - MongoDB
categories:
  - 数据库
  - MongoDB
  - 基础用法
---
# MongoDB 文档

文档的数据结构和 JSON 基本一样。

所有存储在集合中的数据都是 BSON 格式。

BSON 是一种类似 JSON 的二进制形式的存储格式，是 Binary JSON 的简称。

## 插入文档

常用的插入文档方法包括：


| 方法           | 用途               | 是否弃用 |
| ---------------- | -------------------- | ---------- |
| `insertOne()`  | 插入单个文档       | 否       |
| `insertMany()` | 插入多个文档       | 否       |
| `insert()`     | 插入单个或多个文档 | 是       |
| `save()`       | 插入或更新文档     | 是       |

两种已弃用的方法此处就不进行叙述了，也不推荐大家使用。

### insertOne()

insertOne() 方法用于在集合中插入单个文档。

```javascript
db.collection.insertOne(document, options)
```

* document：要插入的单个文档。
* options（可选）：一个可选参数对象，可以包含 writeConcern 和 bypassDocumentValidation 等。

```javascript
db.myCollection.insertOne({
name: "Alice",
age: 25,
city: "New York"
});
```

返回结果：

```json
{
    "acknowledged": true,
    "insertedId": ObjectId("60c72b2f9b1d8b5a5f8e2b2d")
}
```

### insertMany()

insertMany() 方法用于在集合中插入多个文档。

```javascript
db.collection.insertMany(documents, options)
```

* documents：要插入的文档数组。
* options（可选）：一个可选参数对象，可以包含 ordered、writeConcern 和 bypassDocumentValidation 等参数。

```javascript
db.myCollection.insertMany([
    { name: "Bob", age: 30, city: "Los Angeles" },
    { name: "Charlie", age: 35, city: "Chicago" }
]);
```

返回结果：

```json
{
    "acknowledged": true,
    "insertedIds": [
        ObjectId("60c72b2f9b1d8b5a5f8e2b2e"),
        ObjectId("60c72b2f9b1d8b5a5f8e2b2f")
    ]
}
```

此处返回值有两个ObjectId是因为插入了两个文档，如果插入三个文档则此处有三个ObjectId，每个Id和添加的文档一一对应。

## 更新文档

### updateOne()

updateOne() 方法用于更新匹配过滤器的单个文档。

语法：

```javascript
db.collection.updateOne(filter, update, options)
```

* **filter** ：用于查找文档的查询条件。
* **update** ：指定更新操作的文档或更新操作符。
* **options** ：可选参数对象，如 `upsert`、`arrayFilters` 等。

```javascript
db.myCollection.updateOne(
{ name: "Alice" },                // 过滤条件
{ $set: { age: 26 } },            // 更新操作
{ upsert: false }                 // 可选参数
);
```

### updateMany()

updateMany() 方法用于更新所有匹配过滤器的文档。

语法：

```javascript
db.collection.updateMany(filter, update, options)
```

* **filter** ：用于查找文档的查询条件。
* **update** ：指定更新操作的文档或更新操作符。
* **options** ：可选参数对象，如 `upsert`、`arrayFilters` 等。

```javascript
db.myCollection.updateMany(
    { age: { $lt: 30 } },             // 过滤条件
    { $set: { status: "active" } },   // 更新操作
    { upsert: false }                  // 可选参数
);
```

### replaceOne()

replaceOne() 方法用于替换匹配过滤器的单个文档，新的文档将完全替换旧的文档。

语法：

```javascript
db.collection.replaceOne(filter, replacement, options)
```

* **filter** ：用于查找文档的查询条件。
* **replacement** ：新的文档，将替换旧的文档。
* **options** ：可选参数对象，如 `upsert` 等。

```javascript
db.myCollection.replaceOne(
    { name: "Bob" },                  // 过滤条件
    { name: "Bob", age: 31 }          // 新文档
);
```

### findOneAndUpdate()

findOneAndUpdate() 方法用于查找并更新单个文档，可以选择返回更新前或更新后的文档。

语法：

```javascript
db.collection.findOneAndUpdate(filter, update, options)
```

* **filter** ：用于查找文档的查询条件。
* **update** ：指定更新操作的文档或更新操作符。
* **options** ：可选参数对象，如 `projection`、`sort`、`upsert`、`returnDocument` 等。

```javascript
db.myCollection.findOneAndUpdate(
    { name: "Charlie" },              // 过滤条件
    { $set: { age: 36 } },            // 更新操作
    { returnDocument: "after" }       // 可选参数，返回更新后的文档
);
```

### options 参数

这些更新方法的 options 参数通常可以包含以下选项：

* **upsert** ：如果没有匹配的文档，是否插入一个新文档。
* **arrayFilters** ：当更新嵌套数组时，指定应更新的数组元素的条件。
* **collation** ：指定比较字符串时使用的排序规则。
* **returnDocument** ：在 findOneAndUpdate 中使用，指定返回更新前 ("before") 或更新后 ("after") 的文档。

### 更多示例

更新单个文档：

```javascript
db.myCollection.updateOne(
    { name: "Alice" },
    { $set: { age: 26 } }
);
```

更新多个文档：

```javascript
db.myCollection.updateMany(
    { age: { $lt: 30 } },
    { $set: { status: "active" } }
);
```

替换单个文档：

```javascript
db.myCollection.replaceOne(
    { name: "Bob" },
    { name: "Bob", age: 31 }
);
```

查找并更新单个文档：

```javascript
db.myCollection.findOneAndUpdate(
    { name: "Charlie" },
    { $set: { age: 36 } },
    { returnDocument: "after" }
);
```

以下实例中我们替换了 _id 为 56064f89ade2f21f36b03136 的文档数据：

```javascript
db.col.save({
    "_id" : ObjectId("56064f89ade2f21f36b03136"),
    "title" : "MongoDB",
    "description" : "MongoDB 是一个 Nojavascript 数据库",
    "by" : "Runoob",
    "url" : "http://www.example.com",
    "tags" : [
            "mongodb",
            "Nojavascript"
    ],
    "likes" : 110
})
```

替换成功后，我们可以通过 find() 命令来查看替换后的数据

```javascript
db.col.find().pretty()
{
        "_id" : ObjectId("56064f89ade2f21f36b03136"),
        "title" : "MongoDB",
        "description" : "MongoDB 是一个 Nojavascript 数据库",
        "by" : "Runoob",
        "url" : "http://www.example.com",
        "tags" : [
                "mongodb",
                "Nojavascript"
        ],
        "likes" : 110
}
```

```javascript
db.col.update( { "count" : { $gt : 1 } } , { $set : { "test2" : "OK"} } );
```

全部更新：

```javascript
db.col.update( { "count" : { $gt : 3 } } , { $set : { "test2" : "OK"} },false,true );
```

只添加第一条：

```javascript
db.col.update( { "count" : { $gt : 4 } } , { $set : { "test5" : "OK"} },true,false );
```

全部添加进去:

```javascript
db.col.update( { "count" : { $gt : 5 } } , { $set : { "test5" : "OK"} },true,true );
```

全部更新：

```javascript
db.col.update( { "count" : { $gt : 15 } } , { $inc : { "count" : 1} },false,true );
```

只更新第一条记录：

```javascript
db.col.update( { "count" : { $gt : 10 } } , { $inc : { "count" : 1} },false,false );
```

## 删除文档

### deleteOne()

deleteOne() 方法用于删除匹配过滤器的单个文档。

语法：

```javascript
db.collection.deleteOne(filter, options)
```

* **filter** ：用于查找要删除的文档的查询条件。
* **options** （可选）：一个可选参数对象。

```javascript
db.myCollection.deleteOne({ name: "Alice" });
```

返回结果：

```json
{
    "acknowledged": true,
    "deletedCount": 1
}
```

### deleteMany()

deleteMany() 方法用于删除所有匹配过滤器的文档。

语法：

```javascript
db.collection.deleteMany(filter, options)
```

* **filter** ：用于查找要删除的文档的查询条件。
* **options** （可选）：一个可选参数对象。

```javascript
db.myCollection.deleteMany({ status: "inactive" });
```

返回结果：

```json
{
    "acknowledged": true,
    "deletedCount": 1
}
```

### findOneAndDelete()

findOneAndDelete() 方法用于查找并删除单个文档，并可以选择返回删除的文档。

语法：

```javascript
db.collection.findOneAndDelete(filter, options)
```

* **filter** ：用于查找要删除的文档的查询条件。
* **options** ：可选参数对象，如 `projection`、`sort` 等。

```javascript
db.myCollection.findOneAndDelete(
{ name: "Charlie" },
{ projection: { name: 1, age: 1 } }
);
```

findOneAndDelete 返回被删除的文档，如果找不到匹配的文档，则返回 null。

### options 参数

这些删除方法的 options 参数通常可以包含以下选项：

* **writeConcern** ：指定写操作的确认级别。
* **collation** ：指定比较字符串时使用的排序规则。
* **projection** （仅适用于 `findOneAndDelete`）：指定返回的字段。
* **sort** （仅适用于 `findOneAndDelete`）：指定排序顺序以确定要删除的文档。

### 示例

删除单个文档：

```javascript
db.myCollection.deleteOne({ name: "Alice" });
```

删除多个文档：

```javascript
db.myCollection.deleteMany({ status: "inactive" });
```

查找并删除单个文档：

```javascript
db.myCollection.findOneAndDelete(
    { name: "Charlie" },
    { projection: { name: 1, age: 1 } }
);
```

## 查询文档

MongoDB 是一种非关系型数据库，其查询语法与传统的 SQL 有所不同。以下是使用 `find()` 和 `findOne()` 查询文档的详细操作介绍，以及对应的类似 SQL 的示例代码。

### find()

`find()` 方法用于查询集合中的多个文档，类似于 SQL 中的 `SELECT` 语句。

#### 基本语法

```javascript
db.collection.find(query, projection)
```

- `query`：查询条件，类似于 SQL 中的 `WHERE` 子句。
- `projection`：可选参数，用于指定返回的字段，类似于 SQL 中的 `SELECT` 列表。

#### 示例

假设有一个名为 `students` 的集合，包含以下文档：

```json
{ "_id": 1, "name": "Alice", "age": 20, "class": "A" }
{ "_id": 2, "name": "Bob", "age": 22, "class": "B" }
{ "_id": 3, "name": "Charlie", "age": 21, "class": "A" }
```

##### 查询所有文档

```javascript
db.students.find()
```

类似 SQL：

```sql
SELECT * FROM students;
```

##### 查询特定条件的文档

查询年龄大于 20 的学生：

```javascript
db.students.find({ "age": { "$gt": 20 } })
```

类似 SQL：

```sql
SELECT * FROM students WHERE age > 20;
```

##### 查询特定字段

查询所有学生的姓名和班级：

```javascript
db.students.find({}, { "name": 1, "class": 1, "_id": 0 })
```

类似 SQL：

```sql
SELECT name, class FROM students;
```

##### 查询特定条件的特定字段

查询年龄大于 20 的学生的姓名和班级：

```javascript
db.students.find({ "age": { "$gt": 20 } }, { "name": 1, "class": 1, "_id": 0 })
```

类似 SQL：

```sql
SELECT name, class FROM students WHERE age > 20;
```

### findOne()

`findOne()` 方法用于查询集合中的单个文档，类似于 SQL 中的 `SELECT` 语句加上 `LIMIT 1`。

#### 基本语法

```javascript
db.collection.findOne(query, projection)
```

- `query`：查询条件，类似于 SQL 中的 `WHERE` 子句。
- `projection`：可选参数，用于指定返回的字段。

#### 示例

##### 查询第一个文档

```javascript
db.students.findOne()
```

类似 SQL：

```sql
SELECT * FROM students LIMIT 1;
```

##### 查询特定条件的文档

查询班级为 A 的第一个学生：

```javascript
db.students.findOne({ "class": "A" })
```

类似 SQL：

```sql
SELECT * FROM students WHERE class = 'A' LIMIT 1;
```

##### 查询特定条件的特定字段

查询班级为 A 的第一个学生的姓名和年龄：

```javascript
db.students.findOne({ "class": "A" }, { "name": 1, "age": 1, "_id": 0 })
```

类似 SQL：

```sql
SELECT name, age FROM students WHERE class = 'A' LIMIT 1;
```

### 注意事项

- `find()` 返回的是一个游标（Cursor），可以通过遍历游标获取所有匹配的文档。
- `findOne()` 返回的是单个文档对象，如果没有找到匹配的文档，则返回 `null`。
- 在 MongoDB 中，`_id` 字段是默认的主键，类似于 SQL 中的 `PRIMARY KEY`。
- 查询条件中可以使用多种操作符，如 `$gt`（大于）、`$lt`（小于）、`$eq`（等于）等。
