---
title: C++执行Shell
date: 2023-09-09 21:28:17
author: "Grey-Wind"
excerpt: "使用iostream库的system函数来执行Shell"
categories:
- 各语言执行Shell
tags:
- 编程
- Cpp
---

# C++执行Shell

代码如下

```c++
#include <iostream>

int main() {
    std::string command = "dir"; // 将要执行的 cmd 命令(例如ipconfig，ping等)
    int result = system(command.c_str()); // 执行命令，并获得返回值
    std::cout << "Command result: " << result << std::endl; // 输出返回值

    return 0;

}
```

示例代码将执行 dir 命令，并输出命令的返回值。
