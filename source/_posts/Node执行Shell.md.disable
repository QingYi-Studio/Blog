---
title: Node.js执行Shell
date: 2023-09-10 18:06:28
author: "Grey-Wind"
categories:
- Node.js
tags:
- Node.js
---

# Node.js执行Shell

在 Node.js 中执行 Shell 命令有多种方法。以下是几种常用的方法：

## `child_process` 模块：

### 使用 exec 方法执行 Shell 命令

```javascript
const { exec } = require('child_process');

exec('ls -a', (error, stdout, stderr) => {
  if (error) {
    console.error(`执行命令出错: ${error}`);
    return;
  }
  console.log(`标准输出: ${stdout}`);
  console.error(`错误输出: ${stderr}`);
});
```

### 使用 spawn 方法执行 Shell 命令

```javascript
const { spawn } = require('child_process');

const ls = spawn('ls', ['-a']);
ls.stdout.on('data', (data) => {
  console.log(`标准输出: ${data}`);
});
ls.stderr.on('data', (data) => {
  console.error(`错误输出: ${data}`);
});
ls.on('close', (code) => {
  console.log(`子进程退出码: ${code}`);
});
```

## `execSync` 方法：

```javascript
const { execSync } = require('child_process');

try {
  const stdout = execSync('ls -a');
  console.log(`标准输出: ${stdout}`);
} catch (error) {
  console.error(`执行命令出错: ${error}`);
}
```

##  `shelljs`模块：

```javascript
const shell = require('shelljs');

// 执行 Shell 命令，并获取输出
const result = shell.exec('ls -a');
if (result.code !== 0) {
  console.error(`执行命令出错: ${result.stderr}`);
  return;
}
console.log(`标准输出: ${result.stdout}`);
```

## `execa` 模块

提供了一个简单且强大的接口来执行外部命令

```javascript
const execa = require('execa');

(async () => {
  try {
    const { stdout } = await execa('ls', ['-a']);
    console.log(`标准输出: ${stdout}`);
  } catch (error) {
    console.error(`执行命令出错: ${error}`);
  }
})();
```

## `node-pty` 模块

这是一个伪终端的库，允许你与 Shell 进行交互式通信

```javascript
const os = require('os');
const pty = require('node-pty');

const shell = os.platform() === 'win32' ? 'cmd.exe' : 'bash';
const ptyProcess = pty.spawn(shell, [], {
  name: 'xterm-color',
  cols: 80,
  rows: 30,
  cwd: process.cwd(),
  env: process.env
});

ptyProcess.on('data', (data) => {
  console.log(`输出: ${data}`);
});

ptyProcess.write('ls -a\r');
```

## `shelljs-exec-proxy` 模块

这是一个对 `shelljs` 的封装，提供了更简洁的方式来执行 Shell 命令并处理输出。

```javascript
const shell = require('shelljs-exec-proxy');

const { code, stdout, stderr } = shell('ls -a');
if (code !== 0) {
  console.error(`执行命令出错: ${stderr}`);
  return;
}
console.log(`标准输出: ${stdout}`);
```

## `simple-git` 模块

这是一个用于管理 Git 仓库的库，它也提供了执行 Shell 命令的功能。

```javascript
const simpleGit = require('simple-git');

const git = simpleGit();
git.raw(['ls-files', '-z'], (error, result) => {
  if (error) {
    console.error(`执行命令出错: ${error}`);
    return;
  }
  console.log(`标准输出: ${result}`);
});
```

## `ssh2` 模块

这是一个用于通过 SSH 执行 Shell 命令的库。

```javascript
const Client = require('ssh2').Client;

const conn = new Client();
conn.on('ready', () => {
  conn.exec('ls -a', (error, stream) => {
    if (error) {
      console.error(`执行命令出错: ${error}`);
      return;
    }
    stream.on('close', (code, signal) => {
      console.log(`子进程退出码: ${code}`);
      conn.end();
    }).on('data', (data) => {
      console.log(`标准输出: ${data}`);
    }).stderr.on('data', (data) => {
      console.error(`错误输出: ${data}`);
    });
  });
}).connect({
  host: 'example.com',
  username: 'username',
  password: 'password'
});
```

## `cross-spawn` 模块

这是一个跨平台的库，可以在 Windows 和 Unix 系统上执行 Shell 命令。

```javascript
const spawn = require('cross-spawn');

const ls = spawn('ls', ['-a']);
ls.stdout.on('data', (data) => {
  console.log(`标准输出: ${data}`);
});
ls.stderr.on('data', (data) => {
  console.error(`错误输出: ${data}`);
});
ls.on('close', (code) => {
  console.log(`子进程退出码: ${code}`);
});
```

## `shell-exec` 模块

这是另一个对 Shell 命令的封装，它提供了一个简单的接口来执行命令并处理输出。

   ```javascript
   const shellExec = require('shell-exec');

   (async () => {
     const result = await shellExec('ls -a');
     if (result.code !== 0) {
       console.error(`执行命令出错: ${result.stderr}`);
       return;
     }
     console.log(`标准输出: ${result.stdout}`);
   })();
   ```

当然，还有一些其他的方法：

## `node-pty` 模块

这是一个能够让你生成一个伪终端并与其中运行 Shell 命令的库。它在计算机和服务器上都可以工作，并使你能够与 Shell 交互。

   ```javascript
   const os = require('os');
   const pty = require('node-pty');

   const term = pty.spawn(os.platform() === 'win32' ? 'cmd.exe' : 'bash', [], {
     name: 'xterm-color',
     cwd: process.env.HOME,
     env: process.env
   });

   term.onData((data) => {
     console.log(`输出: ${data}`);
   });

   term.write('ls\r');
   ```

## `runas` 模块

这个库允许你在 Windows 系统上以管理员身份运行 Shell 命令。

   ```javascript
   const runas = require('runas');

   try {
     runas('%windir%\\system32\\ipconfig.exe /all', {
       admin: true,
       hide: true
     });
   } catch (error) {
     console.error(`执行命令出错: ${error}`);
   }
   ```

## `node-cmd` 模块

这是一个能够在 Node.js 中执行 Shell 命令的简单库，它提供了简洁的接口。

```javascript
const cmd = require('node-cmd');

cmd.get('ls -a', (error, stdout, stderr) => {
  if (error) {
    console.error(`执行命令出错: ${error}`);
    return;
  }
  console.log(`标准输出: ${stdout}`);
  console.error(`错误输出: ${stderr}`);
});
```
