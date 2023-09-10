---
title: Scala执行Shell
date: 2023-09-10 19:00:53
categories:
- 各语言执行Shell
tags:
- 编程
---

# Scala执行Shell

在Scala中，可以使用以下几种方式执行shell命令：

## 使用Java的`ProcessBuilder`类

可以通过创建`ProcessBuilder`对象，并设置要执行的shell命令，然后使用`.start()`方法启动进程并执行命令。以下是一个示例代码：

```scala
import java.io._

val command = "ls -l"
val processBuilder = new ProcessBuilder(command.split("\\s+"): _*)
val process = processBuilder.start()

val inputStream = process.getInputStream
val reader = new BufferedReader(new InputStreamReader(inputStream))

var line: String = null
while ({line = reader.readLine(); line != null}) {
  println(line)
}

process.waitFor()
```
这个示例中使用了`ls -l`命令来列出当前目录下的文件和文件夹。

## 使用`sys.process`包

Scala提供了一个方便的`sys.process`包，可以使用其中的`Process`类来执行shell命令。以下是示例代码：

```scala
import sys.process._

val command = "ls -l"
val output = command.!!
println(output)
```
这个示例中，`!!`操作符会执行shell命令并返回输出结果。

## 使用`scala.sys.process.Process`类

和前面的方法类似，也是使用`Process`类执行shell命令。以下是示例代码：

```scala
import scala.sys.process._

val command = Seq("ls", "-l")
val process = Process(command)
val output = process.!!
println(output)
```
这个示例中使用了`Seq`来定义命令和参数，然后使用`!!`操作符执行命令并返回输出结果。

## 使用`java.lang.Runtime`类

Scala可以直接使用Java的`Runtime`类来执行shell命令。以下是示例代码：

```scala
import java.lang.Runtime

val command = "ls -l"
val runtime = Runtime.getRuntime
val process = runtime.exec(command)

val inputStream = process.getInputStream
val reader = new BufferedReader(new InputStreamReader(inputStream))

var line: String = null
while ({line = reader.readLine(); line != null}) {
  println(line)
}

process.waitFor()
```
这个示例中使用了`Runtime.getRuntime`获取当前运行时环境的`Runtime`对象，然后使用`exec`方法执行shell命令，并读取命令的输出结果。

## 使用`scala.sys.process.ProcessBuilder`类

Scala的`sys.process`包还提供了`ProcessBuilder`类，它是对Java中的`ProcessBuilder`类的封装，提供了更加方便的链式调用方式。以下是示例代码：

```scala
import scala.sys.process._

val command = Seq("ls", "-l")
val processBuilder = Process(command)
  .run(ProcessLogger(line => println(line)))

processBuilder.exitValue()
```
这个示例中使用了`Process`类的`run`方法来执行shell命令，同时通过`ProcessLogger`指定了命令输出的处理方式，这里简单地将每一行输出打印出来。最后使用`exitValue`方法获取命令的退出值。

这些方法都可以根据具体的需求选择适合的方式来执行shell命令。请根据实际情况选择合适的方法，并注意处理命令执行可能出现的异常情况。
