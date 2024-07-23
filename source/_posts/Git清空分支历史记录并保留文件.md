---
title: Git清空分支历史记录并保留文件
date: 2024-07-23 22:59:01
categories:
- Git
tags:
- Git
---

# Git清空分支历史记录并保留文件

1. 新建一个空白分支

  切换到需要清空的分支，然后执行以下命令。

  ```bash
  git checkout --orphan null_branch
  ```

2. 初始化提交

  刚刚分支下所有文件成为了待添加状态，可以先添加再提交。

  ```bash
  git add -A
  git commit -am "Init commit."
  ```

  

3. 删除旧本地分支并重命名新的分支

  ```bash
  git branch -D test
  git branch -m test
  ```

  此处假定你当时选定需要清空的分支名称为test。

4. 强制提交到远程仓库

	```bash
	git push -f origin test
	```

5. 可能遇到的问题

	如果你使用过 GitHub 或者 SourceTree 可能会遇到：

	```TEXT
	This repository is configured for Git LfS but 'git-lfs' was not found on your path.If you no longer wish to use Git LfS, remove this hook by deleting .git/hooks/pre-push.
	```

	可以执行以下命令删除该 hook 来解决。

	```bash
	rm -rf .git/hooks/pre-push
	```

	

