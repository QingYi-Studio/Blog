---
title: Visual Basic调用Shell
date: 2023-09-09 19:39:11
author: "Grey-Wind"
excerpt: "这是文章的摘要内容。"
categories:
- 各语言执行Shell
tags:
- 编程
---

# Visual Basic调用Shell

使用Visual Studio创建一个Visual Basic项目，本文以控制台项目演示。

输入以下代码

```visual basic
Module Module1

    Sub Main()
        Shell("cmd.exe /c echo 1&&pause")
    End Sub

End Module
```

Visual Studio可能自动生成了除shell以外的代码。

调整执行命令只需修改本代码段“echo 1”与“pause”即可。

------

当然，以下是一个自定义度更高的方法。

代码如下：

```visual basic
Dim command As String
command = "dir"

Dim shell As Object
Set shell = CreateObject("WScript.Shell")

Dim exec As Object
Set exec = shell.Exec("cmd /c " & command)

Do While exec.Status = 0
    WScript.Sleep 100
Loop

Dim output As String
output = exec.StdOut.ReadAll

WScript.Echo output
```

这段示例代码将执行 dir 命令，并在控制台输出命令的结果。你可以将需要执行的命令赋值给 command 变量。

本代码使用了 Windows Script Host 对象模型，通过 CreateObject() 函数创建了一个 WScript.Shell 对象，并调用其 Exec() 方法来执行 cmd 命令。Exec() 方法返回一个 WshScriptExec 对象，该对象的 Status 属性表示当前命令执行状态，StdOut 属性是一个 TextStream 对象，可以读取命令的输出结果。
