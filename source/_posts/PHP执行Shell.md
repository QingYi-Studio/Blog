---
title: PHP执行Shell
date: 2023-09-13 21:23:24
author: "Grey-Wind"
categories:
- PHP
tags:
- PHP
---

# PHP执行Shell

PHP有多种执行Shell命令的方法，以下是其中一些常用(或能用)的方法：

## exec函数

```php
$result = exec('shell command');
```
这会在Shell中执行指定的命令，并将结果保存在变量`$result`中。

## shell_exec函数

```php
$result = shell_exec('shell command');
```
这与exec函数类似，但是会返回命令的完整输出结果。

## system函数

```php
system('shell command', $return_value);
```
该函数将命令的输出直接打印到屏幕上，并将返回值存储在`$return_value`中。

## passthru函数

```php
passthru('shell command');
```
该函数直接将命令的输出打印到屏幕上，而不会返回任何结果。

是的，还有其他一些执行Shell命令的方法。以下是其中的一些：

## popen函数

```php
$handle = popen('shell command', 'r');
$result = fread($handle, 8192);
pclose($handle);
```
这个函数可以打开一个管道，并执行Shell命令。您可以使用`fread`函数读取命令的输出，并使用`pclose`函数关闭管道。

## proc_open函数

```php
$descriptorspec = array(
   0 => array("pipe", "r"),  
   1 => array("pipe", "w"),  
   2 => array("pipe", "w")   
);

$process = proc_open('shell command', $descriptorspec, $pipes);
if (is_resource($process)) {
    $output = stream_get_contents($pipes[1]);
    fclose($pipes[1]);

    $error = stream_get_contents($pipes[2]);
    fclose($pipes[2]);

    proc_close($process);
}
```
这个函数可以打开一个进程，并执行Shell命令。您可以使用`stream_get_contents`函数读取标准输出和错误输出。

## backtick操作符（反引号）

```php
$result = `shell command`;
```
在PHP中，您可以使用backtick操作符将Shell命令嵌入到字符串中，然后将其执行。执行结果将作为字符串返回给变量`$result`。可以使用`echo $result;`来输出结果。
