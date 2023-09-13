---
title: C执行Shell
date: 2023-09-09 21:22:18
author: "Grey-Wind"
categories:
- 各语言执行Shell
tags:
- 编程
---

# C执行Shell

```c
#include <stdio.h>
#include <stdlib.h>

int main() {
    char command[1000] = "dir"; // 将要执行的 cmd 命令
    FILE *fp = NULL;
    char res[1024];

    fp = popen(command, "r"); // 执行命令，并打开读取管道
     
    if (fp == NULL) { // 判断是否成功打开管道
        printf("运行命令失败\n");
        exit(1);
    }
     
    while (fgets(res, sizeof(res), fp) != NULL) { // 从管道中读取输出结果
        printf("%s", res);
    }
    
    pclose(fp); // 关闭管道
    return 0;

}
```

这个示例代码将执行 dir 命令，并输出命令的输出结果。可以替换 command 变量的值为需要执行的命令。

这个实现使用了标准 C 库函数中的 popen() 和 pclose() 函数来执行命令和关闭读取管道。popen() 函数打开一个管道用于读取命令的输出，返回的文件指针 fp 可以用于读取管道中的内容。pclose() 函数关闭读取管道。
