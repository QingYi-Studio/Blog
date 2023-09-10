---
title: Rust执行CMD
date: 2023-09-10 17:39:55
categories:
- 各语言执行Shell
tags:
- 编程
---

# Rust执行Shell

使用Cargo创建一个Rust项目。

```rust
use std::process::Command;  

fn main() {
    let _ = Command::new("cmd.exe").arg("/c").arg("pause").status();
}
```

可以将 .arg("pause") 中的内容替换为其他命令。
