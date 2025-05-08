---
title: 右键菜单添加使用VSCode打开功能
date: 2025-05-08 15:28:16
tags:
- VS Code
- Windows
categories:
- VS Code
---

# 右键菜单添加“使用 VSCode 打开”功能

如果在装 VS Code 时没有或忘记勾选Windows文件资源管理器相关选项，那么就会导致这个选项较难重新添加回来。

此处我们用注册表来手动添加。

## 右键打开文件

1. 在注册表找到`HKEY_CLASSES_ROOT\*\shell`分支，如果没有shell分支，则在*下新建。

2. 在shell下新建“VisualCode”项，在右侧窗口的“默认”双击，在数据里输入“用VSCode打开”。这是右键上显示的文字。

3. 在“VisualCode”下再新建`Command`项，在右侧窗口的“默认”键值栏内输入程序所在的安装路径，如：`"C:\Users\19534\AppData\Local\Programs\Microsoft VS Code\Code.exe" "%1"`。其中的%1表示要打开的文件参数。

4. 配置缩略图。在VisualCode项上新建可扩充字符串值，命名为Icon，修改值为`"C:\Users\19534\AppData\Local\Programs\Microsoft VS Code\Code.exe"`。

## 右键打开文件夹

1. 在注册表找到`HKEY_CLASSES_ROOT\Directory\shell`分支

2. 同上面的2一样，数据内的值为“用VSCode打开文件夹”

后续步骤相同，不做过多重复叙述。

## 右键文件夹空白处打开文件夹

在注册表，找到`HKEY_CLASSES_ROOT\Directory\Background\shell\`

其余步骤相同，只不过需要注意的是Command项内填写的值需要略作修改，将`%1`改为`%V`，如`"C:\Users\19534\AppData\Local\Programs\Microsoft VS Code\Code.exe" "%V"`。
