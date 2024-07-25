---
title: C#同时出现MSB3644、MSB3270、NU1202错误及警告时的解决方案
date: 2024-07-25 20:08:35
categories:
- C#
tags:
- C-Sharp
---

# C#同时出现MSB3644、MSB3270、NU1202错误及警告时的解决方案

在进行基于.NET Standard的开发中，可能会遇到以下报错同时出现的情况。

| 错误代码 | 报错信息                                                     |
| -------- | ------------------------------------------------------------ |
| MSB3644  | 找不到 netstandard2.0,Version=v0.0 的引用程序集。要解决此问题，请为此框架版本安装开发人员工具包(SDK/目标包)或者重新定向应用程序。可在 https://aka.ms/msbuild/developerpacks 处下载 .NET Framework 开发人员工具包 |
| NU1202   | 包 NETStandard.Library 2.0.3 与 netstandard20 (netstandard2.0,Version=v0.0) 不兼容。 包 NETStandard.Library 2.0.3 支持: netstandard1.0 (.NETStandard,Version=v1.0) |
| MSB3270  | 所生成项目的处理器架构“MSIL”与引用“C:\WINDOWS\Microsoft.NET\Framework\v4.0.30319\mscorlib.dll”的处理器架构“x86”不匹配。这种不匹配可能会导致运行时失败。请考虑通过配置管理器更改您的项目的目标处理器架构，以使您的项目与引用间的处理器架构保持一致，或者为引用关联一个与您的项目的目标处理器架构相符的处理器架构。 |

先用官方说法解释以下这三个错误：

- **MSB3644**
	- 此警告提示 MSBuild 无法找到 netstandard2.0 程序集引用。
	- 为了解决这个问题，你需要为你的目标框架版本安装 [.NET Framework Developer Pack](https://aka.ms/msbuild/developerpacks) (SDK/Targeting Pack)。
- **NU1202**
	- 这个错误说明包 NETStandard.Library 版本 2.0.3 与 netstandard2.0, version =v0.0 不兼容。
	- 确保您的所有包和依赖项都与项目中指定的 .NET 标准版本(在您的情况下为 netstandard2.0 )兼容。您可能需要更新或修改软件包版本来解决此问题。
- **MSB3270**
	- 此警告提示生成的项目(MSIL)的处理器体系结构与引用(mscorlib.dll)的体系结构不匹配。
	- 要解决这个问题，您应该确保项目的目标处理器体系结构(如x86、x64或AnyCPU)与引用程序集的体系结构匹配。您可以在Build选项卡下的项目属性中更改此设置，或者直接编辑项目文件。



在询问了ChatGPT后，它给了我这些解决方案：

- **安装 .NET Framework 开发人员工具包**：下载并安装适用于你正在使用的 .NET Framework 版本的开发人员工具包（SDK/目标包）。这将确保你的项目可以找到必要的程序集。
- **更新包版本**：检查项目中所有引用的包的兼容性，确保它们支持你所选用的 .NET Standard 版本。如果需要，更新包的版本以解决兼容性问题。
- **调整处理器架构**：确保你的项目的目标处理器架构与引用的程序集的架构匹配。根据需要调整项目设置，避免因架构不匹配导致的运行时失败。

------

但是，我看了好多遍我的代码，没问题啊？我都没有改，为什么会这样？

我尝试手动下载 `NETStandard.Library` ，显然，失败了，出现了 *NU1202* 的报错。

这个报错只需删除该包即可解决，但是核心问题没有解决。

我将目光转向了 MSB3644 ，这个报错指出一个大方向，和版本有关。

自查了有没有打错 `netstandard2.0` 和 `netstandard2.1` ，发现也没有，看了半天 .csproj 文件都没发现什么问题，Visual Studio也更新了，应该都没有问题了啊？

打开 IntelliSense 模式的属性界面发现了核心问题，我错误的将 `netstandard2.0;netstandard2.1` 写成了 `netstandard2.0,netstandard2.1` 。

一个小小的符号问题，查了半天代码，属实不应该。

但也长了记性，以后查文件需要更加认真仔细，不能扫一眼拼写对不对，有时符号错误可能编辑器不会提示，需要自己长记性认真看。
