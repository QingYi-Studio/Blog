---
title: F#执行Shell
date: 2023-09-10 21:33:59
categories:
- 各语言执行Shell
tags:
- 编程
---

# F#执行Shell

在F#中，可以使用`System.Diagnostics.Process`命名空间来执行Shell命令。以下是几种执行Shell命令的方式。

## 使用`System.Diagnostics.Process.Start`方法

```fsharp
open System.Diagnostics

let executeCommand (command: string) =
    let processStartInfo = new ProcessStartInfo("cmd.exe", sprintf "/C %s" command)
    processStartInfo.RedirectStandardOutput <- true
    processStartInfo.UseShellExecute <- false
    processStartInfo.CreateNoWindow <- true

    let process = Process.Start(processStartInfo)
    let output = process.StandardOutput.ReadToEnd()

    process.WaitForExit()
    output

let result = executeCommand "dir"
printfn "%s" result
```

## 使用`System.Diagnostics.Process.Start`方法

获取标准输出和错误输出。

```fsharp
open System.Diagnostics

let executeCommand (command: string) =
    let processStartInfo = new ProcessStartInfo("cmd.exe", sprintf "/C %s" command)
    processStartInfo.RedirectStandardOutput <- true
    processStartInfo.RedirectStandardError <- true
    processStartInfo.UseShellExecute <- false
    processStartInfo.CreateNoWindow <- true

    let process = Process.Start(processStartInfo)
    let output = process.StandardOutput.ReadToEnd()
    let error = process.StandardError.ReadToEnd()

    process.WaitForExit()
    (output, error)

let (output, error) = executeCommand "dir"
printfn "Output:\n%s" output
printfn "Error:\n%s" error
```

## 使用`System.Diagnostics.Process`类

直接执行命令并获取输出。

```fsharp
open System.Diagnostics

let executeCommand (command: string) =
    let process = new Process()
    process.StartInfo.FileName <- "cmd.exe"
    process.StartInfo.Arguments <- sprintf "/C %s" command
    process.StartInfo.UseShellExecute <- false
    process.StartInfo.RedirectStandardOutput <- true

    process.Start()
    let output = process.StandardOutput.ReadToEnd()
    process.WaitForExit()
    output

let result = executeCommand "dir"
printfn "%s" result
```

## 使用`FSharp.SystemCommand`库

```fsharp
open FSharp.SystemCommand

let executeCommand (command: string) =
    Command.create command
    |> Command.run
    |> Command.output

let result = executeCommand "dir"
printfn "%s" result
```
请确保已将`FSharp.SystemCommand`库添加到项目引用中。

## 使用`Suave.Process`库

```fsharp
open Suave.Process

let executeCommand (command: string) =
    command
    |> Shell.exec
    |> Shell.stdout

let result = executeCommand "dir"
printfn "%s" result
```
请确保已将`Suave.Process`库添加到项目引用中。

## 使用外部命令包装器

### Fake

```fsharp
open Fake

Target "ExecuteCommand" (fun _ ->
    let result = Shell.ExecRead "dir" |> String.concat "\n"
    printfn "%s" result
)

RunTargetOrDefault "ExecuteCommand"
```
### Paket.CommandRunners

在F#脚本中引入`Paket.CommandRunners`命名空间，并使用相关函数来执行Shell命令。

```fsharp
open System
open System.IO
open Paket.CommandRunners

let executeCommand (command: string) =
    let runner = CommandRunners.createProcessRunner()
    let output, exitCode = runner.RunCommand(command, "")
  
    match exitCode with
    | 0 -> output
    | _ -> sprintf "Command failed with exit code %d:\n%s" exitCode output

let result = executeCommand "dir"
printfn "%s" result
```

在上述示例中，我们创建了一个`CommandRunners.createProcessRunner()`来创建一个进程托管器。然后使用`RunCommand`方法执行Shell命令，并获取输出和退出码。

请注意，`Paket.CommandRunners`会自动下载所需的依赖项，并将其复制到正确的位置。

这是使用`Paket.CommandRunners`在F#中执行Shell命令的方式。你可以根据实际需求进行调整，并使用适当的参数和选项来定制命令执行过程。
