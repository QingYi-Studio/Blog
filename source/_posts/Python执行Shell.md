---
title: Python执行Shell
date: 2023-09-10 21:14:47
author: "Grey-Wind"
categories:
- 各语言执行Shell
- Python
tags:
- 编程
---

# Python执行Shell

在Python中，有多种方法可以执行Shell命令。以下是一些常用的方法。

## 使用`os.system`函数

```python
import os
os.system("shell 命令")
```
该方法简单直接，执行命令后会将结果输出到标准输出。但不方便获取命令执行的返回值。

## 使用`subprocess.run`函数

```python
import subprocess
subprocess.run("shell 命令", shell=True)
```
该方法执行命令，并可以通过`subprocess.CompletedProcess`对象获取命令的返回值、输出和错误信息。

## 使用`subprocess.Popen`类

```python
import subprocess
process = subprocess.Popen("shell 命令", shell=True, stdout=subprocess.PIPE)
output, _ = process.communicate()
print(output.decode())
```
该方法也可执行命令，并通过`Popen`对象控制进程和获取输出。这里使用`communicate()`方法获取命令的输出。

## 使用`os.popen`函数（已过时）

```python
import os
output = os.popen("shell 命令").read()
print(output)
```
该方法执行命令，并返回命令的输出。但由于安全性和可维护性等问题，不推荐使用。

## 使用`os.system`函数

```python
import os
os.system("shell 命令")
```
该方法简单直接，执行命令后会将结果输出到标准输出。但不方便获取命令执行的返回值。

## 使用`subprocess.check_output`函数

```python
import subprocess
output = subprocess.check_output("shell 命令", shell=True)
print(output.decode())
```
该方法执行命令，并返回命令的输出。但如果命令返回非零状态码，则会引发`subprocess.CalledProcessError`异常。

## 使用`subprocess.Popen`类

```python
import subprocess
process = subprocess.Popen("shell 命令", shell=True, stdout=subprocess.PIPE)
output, _ = process.communicate()
print(output.decode())
```
该方法也可执行命令，并通过`Popen`对象控制进程和获取输出。这里使用`communicate()`方法获取命令的输出。

当然，还有一些其他的方法可以执行Shell命令。以下是其中几种常见的方法：

## 使用`os.exec*`系列函数

```python
import os
os.exec*(命令)
```
这里的`*`代表不同的函数，例如`os.execlp`、`os.execvp`等。这些函数会替换当前进程，并直接执行指定的命令。

## 使用第三方库

### sh库

```python
import sh

# 执行命令并获取输出
output = sh.shell命令()
print(output)

# 指定命令路径执行
output = sh.Command('命令路径')()
print(output)

# 处理命令的输入和输出
command = sh.Command('命令路径')
output = command('输入内容')
print(output)
```
在示例中，我们通过导入`sh`模块或者使用`Command`类来执行Shell命令。可以直接调用Shell命令作为函数，并使用`()`传递输入内容。还可以使用`Command`类指定命令的路径。

`sh`库提供了简洁和易用的方式来执行Shell命令，并自动处理了输入和输出。你可以根据具体的需求使用`sh`库来执行Shell命令。

### `plumbum`库

```python
from plumbum import local

# 执行命令并获取输出
output = local["shell 命令"]()
print(output)

# 指定工作目录执行命令
with local.cwd("/path/to/directory"):
    output = local["shell 命令"]()

# 处理命令的输入和输出
cmd = local["shell 命令"]
output = cmd("输入内容")
print(output)

# 获取命令执行的返回码
cmd = local["shell 命令"]
cmd.run()  # 执行命令
return_code = cmd.returncode  # 获取返回码
```

在示例中，我们通过导入`local`对象来执行Shell命令。使用`local`对象，我们可以像调用函数一样来执行Shell命令，并通过`()`传递输入内容。还可以使用`cwd`方法指定执行命令时的工作目录。可以通过`run()`方法执行命令，并使用`returncode`属性获取返回码。

`plumbum`库提供了更加简洁和高级的方式来执行Shell命令。它支持输入输出、文件操作以及远程命令执行等功能，具有更好的可读性和易用性。你可以根据自己的需求使用`plumbum`库来执行Shell命令。
