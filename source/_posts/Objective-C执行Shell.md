---
title: Objective-C执行Shell
date: 2023-09-10 22:46:48
categories:
- 各语言执行Shell
tags:
- 编程
---

# Objective-C执行Shell

## 使用NSTask类

```objective-c
NSTask *task = [[NSTask alloc] init];
[task setLaunchPath:@"/bin/sh"];
[task setArguments:@[@"-c", @"ls -al"]];

NSPipe *pipe = [NSPipe pipe];
[task setStandardOutput:pipe];

[task launch];

NSData *data = [[pipe fileHandleForReading] readDataToEndOfFile];
NSString *output = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

NSLog(@"Shell command output:\n%@", output);
```

代码创建了一个NSTask实例，设置它的启动路径为/bin/sh，并将要执行的命令作为参数传递给它。然后，我们创建了一个NSPipe实例，并将其设置为任务的标准输出。接着，我们调用lauch方法启动任务并等待它完成。最后，我们从管道的读取端读取所有数据，并使用UTF8编码将其转换为字符串，打印出执行结果。

## 使用system函数

```objc
#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *command = @"ls -al";
        const char *cmd = [command UTF8String];
        
        int status = system(cmd);
        if (status == -1) {
            NSLog(@"Failed to execute shell command");
        } else {
            NSLog(@"Shell command exited with status: %d", status);
        }
    }
    return 0;
}
```

在这个示例中，我们通过NSString对象创建要执行的Shell命令，并将其转换为C字符串。然后，我们使用system函数来执行命令，并存储返回的状态码。最后，根据状态码打印相应的信息。

## NSTask任务+NSPipe实例

```objc
#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSTask *task = [[NSTask alloc] init];
        [task setLaunchPath:@"/bin/sh"];
        [task setArguments:@[@"-c", @"ls -al"]];

        NSPipe *pipe = [NSPipe pipe];
        [task setStandardOutput:pipe];

        NSFileHandle *file = [pipe fileHandleForReading];
        [task launch];
        
        NSData *data = [file readDataToEndOfFile];
        NSString *output = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSLog(@"Shell command output:\n%@", output);
    }
    return 0;
}
```

这个例子中，我们使用NSTask创建一个任务，并设置其启动路径为`/bin/sh`，并将要执行的命令作为参数传递给它。然后，我们创建了一个NSPipe实例，并将其设置为任务的标准输出。接下来，我们获取管道的文件句柄，并启动任务。然后，我们从文件句柄中读取所有数据，并将其转换为字符串，最后打印出执行结果。

这种方式相对于之前的示例更灵活，可以更方便地处理任务的输入和输出。

## 通过管道进行输入和输出的交互(NSTask)

```objc
#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSTask *task = [[NSTask alloc] init];
        [task setLaunchPath:@"/bin/sh"];
        
        NSPipe *inputPipe = [NSPipe pipe];
        NSPipe *outputPipe = [NSPipe pipe];
        
        [task setStandardInput:inputPipe];
        [task setStandardOutput:outputPipe];
        
        NSFileHandle *inputHandle = [inputPipe fileHandleForWriting];
        NSFileHandle *outputHandle = [outputPipe fileHandleForReading];
        
        [task launch];
        
        NSString *command = @"ls -al";
        NSData *commandData = [command dataUsingEncoding:NSUTF8StringEncoding];
        [inputHandle writeData:commandData];
        [inputHandle closeFile];
        
        NSData *outputData = [outputHandle readDataToEndOfFile];
        NSString *output = [[NSString alloc] initWithData:outputData encoding:NSUTF8StringEncoding];
        
        NSLog(@"Shell command output:\n%@", output);
    }
    return 0;
}
```

在这个示例中，创建了一个`NSTask`对象，并设置其启动路径为`/bin/sh`。然后，我们创建了两个管道，一个用于将命令输入给Shell，另一个用于获取Shell的输出。我们将这两个管道分别设置为任务的标准输入和标准输出。

接下来获取输入管道和输出管道的文件句柄，并启动任务。然后创建一个要执行的Shell命令，并将其转换为NSData对象。使用输入句柄，我们将命令数据写入输入管道，并关闭输入句柄。

最后，从输出句柄中读取所有数据，并将其转换为字符串。打印出Shell命令的输出结果。
