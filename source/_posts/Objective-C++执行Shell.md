---
title: Objective-C++执行Shell
date: 2023-09-10 22:58:22
author: "Grey-Wind"
categories:
- Objective C++
tags:
- 编程
- Objective-C++
---

# Objective-C++执行Shell

## 使用 NSTask 类

NSTask 是一个 Objective-C 类，用于在 macOS 或 iOS 应用程序中执行外部命令。它可以创建一个子进程，并允许您设置命令、参数和环境变量。下面是一个示例代码片段：

```objective-c
#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSTask *task = [[NSTask alloc] init];
        [task setLaunchPath:@"/usr/bin/env"];
        [task setArguments:@[@"ls", @"-l"]];
        
        NSPipe *pipe = [NSPipe pipe];
        [task setStandardOutput:pipe];
        
        [task launch];
        [task waitUntilExit];
        
        NSData *data = [[pipe fileHandleForReading] readDataToEndOfFile];
        NSString *output = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@", output);
    }
    return 0;
}
```

上述代码中，NSTask 用于运行 "ls -l" 命令，并将输出保存到一个 NSPipe 中。然后，我们读取管道中的数据并打印到控制台。

## 使用 system() 函数

C++ 中有一个名为 system() 的函数，可以用于执行 Shell 命令。在 Objective-C++ 中，您也可以使用该函数。下面是一个示例代码片段：

```objective-c++
#include <iostream>
#include <cstdlib>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int result = system("ls -l");
        if (result != 0) {
            std::cout << "Command execution failed." << std::endl;
        }
    }
    return 0;
}
```

## 使用 popen() 函数

popen() 函数可以用于执行 Shell 命令并获取输出。

```objective-c++
#include <iostream>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        FILE *pipe = popen("ls -l", "r");
        if (pipe == NULL) {
            std::cout << "Command execution failed." << std::endl;
            return -1;
        }
        
        char buffer[128];
        while (fgets(buffer, sizeof(buffer), pipe) != NULL) {
            std::cout << buffer;
        }
        
        pclose(pipe);
    }
    return 0;
}
```

上述代码中，我们使用 popen() 执行 "ls -l" 命令，并逐行读取输出并打印到控制台。

## 使用 NSTask 的便捷方法

NSTask 类提供了一些便捷方法来执行 Shell 命令，而无需手动设置 launch path 和 arguments。

```objective-c++
#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *output = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://example.com"]
                                                    encoding:NSUTF8StringEncoding
                                                       error:nil];
        NSLog(@"%@", output);
    }
    return 0;
}
```

上述代码中，我们使用 `[NSString stringWithContentsOfURL:encoding:error:]` 方法执行了 `curl http://example.com` 命令，并将输出保存在 NSString 对象中。

5. 使用 system() 或 popen() 的 C++ 封装：您可以将 system() 或 popen() 函数进行封装，以便更方便地在 Objective-C++ 中使用。例如，可以创建一个 C++ 函数来执行 Shell 命令，并返回结果。下面是一个示例代码片段：

```objective-c++
#include <iostream>
#include <cstdio>

std::string executeShellCommand(const std::string &command) {
    char buffer[128];
    std::string result = "";
    
    FILE *pipe = popen(command.c_str(), "r");
    if (!pipe) {
        return "Command execution failed.";
    }
    
    while (fgets(buffer, sizeof(buffer), pipe) != NULL) {
        result += buffer;
    }
    
    pclose(pipe);
    
    return result;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        std::string output = executeShellCommand("ls -l");
        std::cout << output;
    }
    return 0;
}
```

上述代码中，我们定义了一个 `executeShellCommand()` 函数，它接受一个 Shell 命令，并返回执行结果。在 `main()` 函数中，我们调用该函数执行 "ls -l" 命令，并将输出打印到控制台。

## 使用 POSIX 的 fork() 和 exec() 函数

Objective-C++ 可以直接使用 POSIX 的 fork() 和 exec() 函数来创建子进程并执行外部命令。下面是一个示例代码片段：

```objective-c++
#include <iostream>
#include <unistd.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        pid_t pid = fork();
        
        if (pid < 0) {
            std::cout << "Failed to create child process." << std::endl;
            return -1;
        } else if (pid == 0) {
            // Child process
            execl("/bin/ls", "ls", "-l", NULL);
            std::cout << "Failed to execute command." << std::endl;
            return -1;
        } else {
            // Parent process
            wait(NULL);
        }
    }
    return 0;
}
```

上述代码中，我们通过调用 fork() 函数创建了一个子进程，并在子进程中调用 execl() 函数来执行 "ls -l" 命令。父进程通过调用 wait() 函数等待子进程的结束。

## 使用 NSTask 的便捷方法执行 Shell 脚本

如果要执行复杂的 Shell 脚本，可以使用 NSTask 的便捷方法来执行脚本文件。下面是一个示例代码片段：

```objective-c++
#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *scriptPath = [[NSBundle mainBundle] pathForResource:@"script.sh" ofType:nil];
        
        NSTask *task = [[NSTask alloc] init];
        [task setLaunchPath:@"/bin/sh"];
        [task setArguments:@[scriptPath]];
        
        NSPipe *pipe = [NSPipe pipe];
        [task setStandardOutput:pipe];
        
        [task launch];
        [task waitUntilExit];
        
        NSData *data = [[pipe fileHandleForReading] readDataToEndOfFile];
        NSString *output = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@", output);
    }
    return 0;
}
```

上述代码中，我们使用 NSTask 执行一个名为 "script.sh" 的 Shell 脚本文件，并将输出保存到一个 NSPipe 中。
