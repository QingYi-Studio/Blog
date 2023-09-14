---
title: C执行Shell
date: 2023-09-09 21:22:18
author: "Grey-Wind"
excerpt: "使用了C语言库中的system()、popen()、exec()等函数来执行Shell"
categories:
- 各语言执行Shell
tags:
- 编程
---

# C执行Shell

在C语言中，可以使用以下几种方法执行Shell命令。

## `system()`函数

`system()`函数是C标准库中提供的一个函数，用于执行Shell命令。例如，你可以通过以下代码执行命令 `ls -l`：

```c
#include <stdio.h>
#include <stdlib.h>

int main() {
    system("ls -l");
    return 0;
}
```
请注意，`system()`函数的返回值是命令的退出状态。

也可以使用以下方式来检测是否成功执行。

在`system()`函数执行命令后，可以通过检查其返回值来确定命令是否成功执行。返回值为`-1`表示执行失败，其他返回值表示命令执行的退出状态。

```c
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

int main() {
    int status;

    status = system("ls -l");
    if (status == -1) {
        printf("Command execution failed.\n");
    } else {
        if (WIFEXITED(status)) {
            printf("Command exited with status: %d\n", WEXITSTATUS(status));
        } else if (WIFSIGNALED(status)) {
            printf("Command terminated due to signal: %d\n", WTERMSIG(status));
        }
    }

    return 0;
}
```
在上面的示例中，`system()`函数返回的状态被检查，并打印了命令的退出状态或终止信号。

## `popen()`函数

`popen()`函数也是一个常用的方法，它可以打开一个管道，允许你执行Shell命令并从命令的输出中读取数据。

```c
#include <stdio.h>
#include <stdlib.h>

int main() {
    FILE *fp;
    char buffer[256];

    fp = popen("ls -l", "r");
    if (fp == NULL) {
        printf("Error executing command.\n");
        return 1;
    }

    while (fgets(buffer, sizeof(buffer), fp) != NULL) {
        printf("%s", buffer);
    }

    pclose(fp);
    return 0;
}
```
在上面的示例中，命令 `ls -l` 的输出被逐行读取，并打印到控制台上。

## `fork()`和`exec()`函数组合

使用`fork()`和`exec()`函数组合也可以执行Shell命令。`fork()`函数用于创建一个新的进程，而`exec()`函数用于在新的进程中执行Shell命令。

```c
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main() {
    pid_t pid;

    pid = fork();
    if (pid == -1) {
        printf("Error creating child process.\n");
        return 1;
    }

    if (pid == 0) {
        // Child process
        execl("/bin/ls", "ls", "-l", NULL);
        exit(0);
    } else {
        // Parent process
        wait(NULL);
        printf("Child process completed.\n");
    }

    return 0;
}
```
在上面的示例中，父进程使用`fork()`创建一个子进程，并在子进程中使用`execl()`函数调用 `ls -l` 命令。父进程使用`wait()`函数等待子进程执行完毕。

## `execve()`函数

`execve()`函数是一个更底层的系统调用，它可以在当前进程中执行一个新的程序。可以使用`execve()`函数来执行Shell命令。

```c
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main() {
    char *args[] = {"ls", "-l", NULL};
    execve("/bin/ls", args, NULL);
    return 0;
}
```
在上面的示例中，`execve()`函数被用来执行命令 `ls -l`。

## `system()`函数的替代方案

如果你对安全性有更高的要求，可以使用以下代码片段作为`system()`函数的替代方案，以避免潜在的安全风险。

```c
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main() {
    pid_t pid;

    pid = fork();
    if (pid == -1) {
        printf("Error creating child process.\n");
        return 1;
    }

    if (pid == 0) {
        // Child process
        execl("/bin/sh", "sh", "-c", "ls -l", NULL);
        exit(0);
    } else {
        // Parent process
        wait(NULL);
        printf("Child process completed.\n");
    }

    return 0;
}
```
在这个例子中，父进程使用`fork()`创建子进程，并在子进程中使用`execl()`函数调用Shell解释器 `/bin/sh`，并传递 `-c` 参数来执行命令 `ls -l`。

## `execvp()`函数

`execvp()`函数是`exec()`函数族中的一个变体，它可以在当前进程中执行一个新的程序。该函数接受一个程序名称和参数列表，并根据系统的搜索路径查找可执行文件。以下是一个例子：

```c
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main() {
    char *args[] = {"ls", "-l", NULL};
    execvp("ls", args);
    return 0;
}
```
在上面的示例中，`execvp()`函数被用来执行命令 `ls -l`。
