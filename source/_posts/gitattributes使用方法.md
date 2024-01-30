---
title: .gitattributes使用方法
date: 2024-01-30 10:21:00
description: 一篇文章简述.gitattributes使用方法，快速教会新手开发者
categories:
- Git
tags:
- Git
---

# .gitattributes使用方法

## 介绍

`.gitattributes`是一个文本文件，文件中的一行定义一个路径的若干个属性，主要用于定义每种文件的属性，以方便 `git` 帮我们统一管理。

`.gitattributes` 文件是一个用来配置 Git 版本控制系统的文件，它的作用主要包括以下几个方面：

1. 定义文件属性：`.gitattributes` 文件可以用来指定特定文件或文件类型的属性，例如文本文件、二进制文件、合并策略等。这可以帮助 Git 更好地处理不同类型的文件。
2. 控制行尾格式：你可以使用 `.gitattributes` 文件来指定文本文件的行尾格式，例如 UNIX 风格的 LF（换行符）或 Windows 风格的 CRLF（回车符+换行符）。这对于跨平台协作和一致的行尾格式非常重要。
3. 合并策略：`.gitattributes` 文件可以指定合并冲突时使用的合并策略。例如，你可以指定某个文件使用 "union" 策略，以在合并冲突时保留所有版本的更改。
4. 指定差异算法：你可以为特定文件指定使用不同的文本差异算法，以控制 Git 如何计算和显示差异。
5. 特定文件处理：`.gitattributes` 文件可以定义一些特定文件的自定义行为，例如执行清理操作、忽略文件等。
6. 执行 Git 钩子：你可以使用 `.gitattributes` 文件来触发 Git 钩子，以在特定操作发生时执行自定义脚本或操作。

## 可定义属性

### text

用于控制行尾的规范性。如果一个文本文件是规范的，则*Git*库汇总该文件（*git*服务器上的文件）的行尾总是`LF`。对于工作目录，除了`text`属性之外，还可以设置`eol`属性或*core.eol*配置变量。

### eol

设置行末字符。

- eol=lf ，[回车] ：入库时将行尾规范为LF，检出时行尾不强制转换为 CRLF
- eol=crlf，[换行、回车] ：入库时将行尾规范为LF，检出时将行尾转换为CRLF

<details>
<summary>补充内容</summary>
<p>GRLF 和 LF都是用来表示文本换行的方式。CR代表回车，对应字符 \r。LF 表示换行，对应字符 \n。不同操作系统文本使用的换行符各不相同。Windows系统使用的是 CRLF，Unix系统（包括Linux，MacOS近些年的版本）使用的是 LF。</p>
<p>事实上，可能并不是所有的开发者用的环境都完全一样，比如有的开发者使用 Windows 环境开发，他们的文本文件的换行符是 ‘\r\n’（CRLF）；而有的开发者使用 MacOS 环境开发，这些开发者文本文件的换行符是 ‘\n’（LF）。为了使得不同系统环境的开发者能开发同一个git项目，便出现了这个。</p>
</details>
### diff

我们知道*git*主要是用来跟踪文件版本的，跟踪文件版本自然离不开比较差异，而`diff`就是用来告诉*git*声明文件需要比较版本差异的。
`diff`属性影响*Git*对特殊文件生成差异的方式。它可以告诉*Git*是否为路径生成文本补丁还是将路径视为二进制文件。它也可以影响在`hunk`头部显示的@@ -k,l +n,m @@，告诉*Git*使用外部命令来生成差异，或者是在生成差异之前让*Git*将二进制文件转换为文本文件。

diff：强制视为文本文件，即使它包含一些通常从不会出现在文本文件的字节值，例如`NUL`。

!diff：表示为非文本文件，没有设置`diff`属性的路径会生成`differ`二进制文件（如果启用了二进制补丁，会生成二进制补丁）。

未定义：未指明`diff`属性的路径首先会检查其内容，如果它看起来像文本文件并且小于大文件阈值（*core.bigFileThreshold*），则将其视为文本文件，否则将生成`differ`二进制文件。

### differ 规则

`diff` 是使用指定的 `diff` 驱动程序显示的。每个驱动程序可以指定一个或多个选项。

这玩意在*gitconfig*里搞，不是*gitattributes*。

### binary

[^如果你不希望产生文本差异，以及行尾转换应用到任何二进制文件。可以使用系统内置的 binary，它会取消 text 和 diff 属性。]:Git官方原文

例如：

```properties
*.png binary
```

上面会把所有的文件都 LF 化，不同的是单独为需要的资源添加了 binary。

## 生效顺序

在一个Git库中可以有多个.gitattributes 文件，不同.gitattributes 文件中，属性设置的优先级(从高到低)如下：

- /myproj/info/attributes
- /myproj/my_path/.gitattributes
- /myproj/.gitattributes

同一个.gitattributes 文件中，遵循覆盖原则，即后面的行会覆盖前面的设置，如果一个文件的某个属性被多次设置，则后设置的优先，类似`int a = 1; a = 2;`最终结果`a == 2`。

## 示例

```properties
* text=auto

# text
*.vue              text eol=lf
*.js               text eol=lf
*.cjs              text eol=lf
*.ts               text eol=lf
*.tsx              text eol=lf
*.json             text eol=lf
*.css              text eol=lf
*.less             text eol=lf
*.scss             text eol=lf
*.html             text eol=lf
*.md               text eol=lf

# -text
*.png              -text
*.jpg              -text
*.jpeg             -text
*.pdf              -text
*.svg              -text

# Linguist
*.js linguist-language=JavaScript
*.jsm linguist-language=JavaScript
*.inc linguist-language=XML
```

上面是一个 `.gitattributes` 文件的示例，它定义了一些文件扩展名的属性，以指定它们在 Git 中的处理方式。让我解释一下这个示例：

1. `* text=auto`：这一行是一个通用规则，指示 Git 自动检测文件类型，并根据文件内容将其视为文本文件或二进制文件。
2. 接下来的部分包含了一系列规则，它们指定了特定文件扩展名的处理方式。这些规则基本上告诉 Git 哪些文件应该被视为文本文件，以及如何处理它们。这些规则包括以下内容：
	- `*.vue text eol=lf`, `*.js`, `*.cjs`, `*.ts`, `*.tsx`, `*.json`, `*.css`, `*.less`, `*.scss`, `*.html`, `*.md`：将这些文件扩展名的文件都视为文本文件，并将它们的行尾格式设置为 LF（换行符）。
3. 之后的部分包含了一系列规则，它们指定了特定文件扩展名的处理方式，即将这些文件视为二进制文件，不进行文本处理。这些规则包括以下内容：
	- `*.png`, `*.jpg`, `*.jpeg`, `*.pdf`, `*.svg`：将这些文件扩展名的文件都视为二进制文件，不进行文本处理。
4. 最后是 [Linguist](https://github.com/github/linguist) 库的属性，它用于生成我们常见的*GitHub*语言分布。

总的来说，这个 `.gitattributes` 文件的目的是为了确保一些常见文件类型（如代码文件和文本文件）在 Git 中的处理方式保持一致，以及将它们的行尾格式标准化为 LF。对于二进制文件，不进行额外的处理。这有助于在多平台协作中保持一致性，并减少不必要的差异。
