---
title: Git推送一个不包含历史记录的新分支
date: 2024-07-23 16:08:34
categories:
- Git
tags:
- Git
---

# Git推送一个不包含历史记录的新分支

## 1. 基本概念

在开始之前，让我们先弄清楚一些基本概念：

- 分支：在Git中，分支即是一系列提交的集合，它们形成了一个完整的开发历史。我们可以通过创建新的分支，在其中进行开发工作，而不影响主分支。
- 远程仓库：远程仓库是一个存放在网络上的Git仓库，它用于多人协作开发或备份代码。
- 本地仓库：本地仓库是存放于本地机器上的Git仓库，我们可以在本地进行开发和提交代码。

## 2. 创建新分支

要创建一个新分支，请打开终端（命令行界面），进入项目的根目录，并执行以下命令：

```bash
git checkout --orphan <branch_name>
```

在上述命令中，`-orphan`这个参数的主要作用有两个，一个是拷贝当前所在分支的所有文件，另一个是没有父结点，可以理解为没有历史记录，是一个完全独立背景干净的分支。

例如，我们要创建一个名为`new-feature`的新分支，可以运行以下命令：

```bash
git checkout --orphan new-feature
```

## 3. 拉取代码

使用`git pull`拉取源仓库的代码（与本地代码相同）。

例如当v1.0.0的代码完成后希望开始制作v1.1.0，这时候使用`orphan`参数创建v1.1.0分支，创建好拉取v1.0.0代码，完成提交再进行v1.1.0的制作。

如果不拉取代码会由于没有历史记录显示：

```TEXT
There isn’t anything to compare.
*** and ** are entirely different commit histories.
```

如果你不需要使用PR进行代码合并则不需要拉取代码。

如果遇到部分问题可选择性使用以下代码来复制解决。

```bash
git pull origin master --allow-unrelated-histories
```

`--allow-unrelated-histories` 命令参数代表统一无关的历史记录进行合并操作。

- 如果是 git pull 命令时出现该问题，可以使用 `git pull origin master --allow-unrelated-histories` 命令执行拉取，然后再使用 git push 提交更新
- 如果是合并分支，可以使用 `git merge master --allow-unrelated-histories` 命令将两个无关的分支进行合并，并继续其他操作
