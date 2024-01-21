---
title: C#执行Shell
date: 2023-09-10 17:44:40
author: "Grey-Wind"
categories:
- 各语言执行Shell
tags:
- 编程
- C Sharp
---

# C#执行Shell

在C#中执行Shell命令有多种方法

## 使用System.Diagnostics.Process类：

```csharp
string command = "ipconfig";
Process process = new Process();
ProcessStartInfo startInfo = new ProcessStartInfo();
startInfo.FileName = "cmd.exe";
startInfo.Arguments = "/c " + command; // 如果是使用 PowerShell 命令，则将 "/c" 改为 "/k"
startInfo.RedirectStandardOutput = true;
startInfo.UseShellExecute = false;
startInfo.CreateNoWindow = true;

process.StartInfo = startInfo;
process.Start();

string output = process.StandardOutput.ReadToEnd();

process.WaitForExit();
```

## 使用System.Diagnostics.Process类和PowerShell：

```csharp
string command = "Get-Process";
Process process = new Process();
ProcessStartInfo startInfo = new ProcessStartInfo();
startInfo.FileName = "powershell.exe";
startInfo.Arguments = command;
startInfo.RedirectStandardOutput = true;
startInfo.UseShellExecute = false;
startInfo.CreateNoWindow = true;

process.StartInfo = startInfo;
process.Start();

string output = process.StandardOutput.ReadToEnd();

process.WaitForExit();
```

## 使用System.Management命名空间的ManagementObject类（需要引用System.Management.dll）：

```csharp
string command = "ipconfig";
ManagementClass processClass = new ManagementClass("Win32_Process");
object[] methodArgs = { command, null, null, 0 };
object result = processClass.InvokeMethod("Create", methodArgs);
int exitCode = Convert.ToInt32(result);
```

当然，还有其他一些执行Shell命令的方法。以下是其中的两种：

## 使用System.Diagnostics.Process类和WMI（Windows Management Instrumentation）：

```csharp
string command = "ipconfig";
Process process = new Process();
ProcessStartInfo startInfo = new ProcessStartInfo();
startInfo.FileName = "cmd.exe";
startInfo.Arguments = "/c " + command; // 如果是使用 PowerShell 命令，则将 "/c" 改为 "/k"
startInfo.RedirectStandardOutput = true;
startInfo.UseShellExecute = false;
startInfo.CreateNoWindow = true;

process.StartInfo = startInfo;
process.Start();

string output = process.StandardOutput.ReadToEnd();

process.WaitForExit();
```

## 使用Microsoft.VisualBasic.Interaction类：

```csharp
string command = "ipconfig";
string output = Microsoft.VisualBasic.Interaction.Shell(command, AppWinStyle.Hide, true, -1);
```

## 使用System.Runtime.InteropServices引用DLL文件：

```csharp
using System.Runtime.InteropServices;

[DllImport("kernel32.dll", SetLastError = true)]
public static extern bool CreateProcess(string lpApplicationName, string lpCommandLine, IntPtr lpProcessAttributes, IntPtr lpThreadAttributes,
                                        bool bInheritHandles, uint dwCreationFlags, IntPtr lpEnvironment, string lpCurrentDirectory,
                                        ref STARTUPINFO lpStartupInfo, out PROCESS_INFORMATION lpProcessInformation);

[DllImport("kernel32.dll", SetLastError = true)]
public static extern void WaitForSingleObject(IntPtr hHandle, uint dwMilliseconds);

struct PROCESS_INFORMATION
{
    public IntPtr hProcess;
    public IntPtr hThread;
    public int dwProcessId;
    public int dwThreadId;
}

struct STARTUPINFO
{
    public int cb;
    public string lpReserved;
    public string lpDesktop;
    public string lpTitle;
    public int dwX;
    public int dwY;
    public int dwXSize;
    public int dwYSize;
    public int dwXCountChars;
    public int dwYCountChars;
    public int dwFillAttribute;
    public int dwFlags;
    public short wShowWindow;
    public short cbReserved2;
    public IntPtr lpReserved2;
    public IntPtr hStdInput;
    public IntPtr hStdOutput;
    public IntPtr hStdError;
}

static void Main(string[] args)
{
    string command = "ipconfig";
    STARTUPINFO startupInfo = new STARTUPINFO();
    PROCESS_INFORMATION processInfo = new PROCESS_INFORMATION();
    
    bool success = CreateProcess(null, command, IntPtr.Zero, IntPtr.Zero, false, 0, IntPtr.Zero, null, ref startupInfo, out processInfo);
    if (success)
    {
        WaitForSingleObject(processInfo.hProcess, 0xFFFFFFFF);
    }
}
```

这种方法使用了Platform Invoke技术，可以直接调用Windows的API函数来执行Shell命令。请注意，使用此方法需要在代码中引用System.Runtime.InteropServices命名空间，并确保正确设置结构体和函数调用。同样地，在执行Shell命令时，需要谨慎处理输入内容和安全问题。

当然，还有一种方法可以执行Shell命令：

## 使用System.Diagnostics.Process类和PowerShell Core：

```csharp
string command = "ipconfig";
Process process = new Process();
ProcessStartInfo startInfo = new ProcessStartInfo();
startInfo.FileName = "pwsh.exe"; // PowerShell Core的可执行文件路径
startInfo.Arguments = "-Command " + command;
startInfo.RedirectStandardOutput = true;
startInfo.UseShellExecute = false;
startInfo.CreateNoWindow = true;

process.StartInfo = startInfo;
process.Start();

string output = process.StandardOutput.ReadToEnd();

process.WaitForExit();
```

这种方法使用了PowerShell Core的可执行文件（`pwsh.exe`）来执行Shell命令。需要注意，你需要先安装并配置好PowerShell Core，并将其可执行文件的路径正确填写到代码中(或者添加到环境变量中)。

以上是使用C#执行Shell命令的几种常见方法，可以根据具体需求选择适合的方法进行操作。请务必确保输入内容的安全性，并谨慎处理可能存在的风险。
