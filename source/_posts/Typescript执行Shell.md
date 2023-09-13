---
title: Typescript执行Shell
date: 2023-09-10 21:50:12
author: "Grey-Wind"
categories:
- 各语言执行Shell
tags:
- 编程
---

# Typescript执行Shell

## `exec()`

异步执行 Shell 命令，且不会保留子进程的输出结果。

```typescript
import { exec } from 'child_process';

exec('ls', (error, stdout, stderr) => {
  if (error) {
    console.error(`执行命令出错: ${error.message}`);
    return;
  }
  console.log(`输出内容: ${stdout}`);
});
```

## `execSync()`

同步执行 Shell 命令，并返回输出结果。

```typescript
import { execSync } from 'child_process';

try {
  const output = execSync('ls');
  console.log(`输出内容: ${output.toString()}`);
} catch (error) {
  console.error(`执行命令出错: ${error.message}`);
}
```

## `spawn()`

异步执行 Shell 命令，并可以保留进程的输出结果。

```typescript
import { spawn } from 'child_process';

const ls = spawn('ls');

ls.stdout.on('data', (data) => {
  console.log(`输出内容: ${data}`);
});

ls.stderr.on('data', (data) => {
  console.error(`错误输出: ${data}`);
});

ls.on('close', (code) => {
  console.log(`进程退出码: ${code}`);
});
```

## `spawnSync()`

同步执行 Shell 命令，并返回输出结果。

```typescript
import { spawnSync } from 'child_process';

const ls = spawnSync('ls');
if (ls.error) {
  console.error(`执行命令出错: ${ls.error.message}`);
} else {
  console.log(`输出内容: ${ls.output.toString()}`);
}
```

## `execFile()`

异步执行可执行文件，可以传入命令行参数。

```typescript
import { execFile } from 'child_process';

const command = 'cd';
const args = ['/d', 'desktop'];

execFile(command, args, (error, stdout, stderr) => {
  if (error) {
    console.error(`执行命令出错: ${error.message}`);
    return;
  }
  console.log(`输出内容: ${stdout}`);
});
```

## `execFileSync()`

同步执行可执行文件，可以传入命令行参数。

```typescript
import { execFileSync } from 'child_process';

const command = 'cd';
const args = ['/d', 'desktop'];

try {
  const output = execFileSync(command, args);
  console.log(`输出内容: ${output.toString()}`);
} catch (error) {
  console.error(`执行命令出错: ${error.message}`);
}
```

## `execShellCommand()`

自定义一个异步执行 Shell 命令的封装函数。

```typescript
import { exec } from 'child_process';

function execShellCommand(command: string): Promise<string> {
  return new Promise((resolve, reject) => {
    exec(command, (error, stdout, stderr) => {
      if (error) {
        reject(error);
        return;
      }
      resolve(stdout.trim());
    });
  });
}

// 使用示例
async function main() {
  try {
    const output = await execShellCommand('ls');
    console.log(`输出内容: ${output}`);
  } catch (error) {
    console.error(`执行命令出错: ${error.message}`);
  }
}

main();
```

这个方法将 `exec` 包装在一个 Promise 中，使其可以轻松地使用 `await` 进行异步操作。

## `spawnShellCommand()`

自定义一个异步执行 Shell 命令的封装函数，支持参数和流式数据处理。

```typescript
import { spawn } from 'child_process';

function spawnShellCommand(command: string, args: string[]): Promise<string> {
  return new Promise((resolve, reject) => {
    const child = spawn(command, args);

    let output = '';

    child.stdout.on('data', (data) => {
      output += data.toString();
    });

    child.stderr.on('data', (data) => {
      console.error(data.toString());
    });

    child.on('error', (error) => {
      reject(error);
    });

    child.on('close', (code) => {
      if (code !== 0) {
        reject(new Error(`命令执行失败，退出码: ${code}`));
        return;
      }
      resolve(output.trim());
    });
  });
}

// 使用示例
async function main() {
  try {
    const output = await spawnShellCommand('ls', ['-lh']);
    console.log(`输出内容: ${output}`);
  } catch (error) {
    console.error(`执行命令出错: ${error.message}`);
  }
}

main();
```

这个方法使用 `spawn` 创建子进程，并处理标准输出和标准错误流，最后返回整个输出结果。
