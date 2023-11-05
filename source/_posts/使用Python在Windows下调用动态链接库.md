---
title: 使用Python在Windows下调用动态链接库
date: 2023-11-05 15:52:01
author: "Grey-Wind"
categories:
- Python
tags:
- 编程
---

# 使用Python在Windows下调用动态链接库

使用`ctypes`来调用动态链接库。

## 调用C# .NET Framework的动态链接库

```csharp
using System;

namespace MyLibrary
{
    public class MyFunctions
    {
        public static int Add(int a, int b)
        {
            return a + b;
        }
    }
}
```

```python
import ctypes

# 加载C# .NET Framework的动态链接库
mylib = ctypes.cdll.LoadLibrary('mylibrary.dll')

# 调用C# .NET Framework的函数
result = mylib.MyFunctions_Add(2, 3)
print(result)  # 输出：5
```

## 调用C# .NET 6.0/7.0的动态链接库

C# .NET 6.0/7.0使用了跨平台的.NET Core/Runtime，而不是传统的.NET Framework。

```csharp
using System;

namespace MyLibrary
{
    public class MyClass
    {
        public int Add(int a, int b)
        {
            return a + b;
        }
    }
}
```

```python
import ctypes

# 加载C# .NET 6.0/7.0的动态链接库
mylib = ctypes.CDLL('Path/To/Your/Library.dll')

# 定义函数签名
mylib.Add.argtypes = [ctypes.c_int, ctypes.c_int]
mylib.Add.restype = ctypes.c_int

# 调用C# .NET 6.0/7.0的函数
result = mylib.Add(2, 3)
print(result)  # 输出：5
```

需要注意的是，上述示例中的路径和文件名应根据实际情况进行调整。另外，函数签名的定义是必要的，以便正确传递参数并获取返回值。

[函数签名的详解](../函数签名的详解/)

## 调用VB.NET的动态链接库

```vb
Public Class MyFunctions
    Public Shared Function Add(ByVal a As Integer, ByVal b As Integer) As Integer
        Return a + b
    End Function
End Class
```

```python
import ctypes

# 加载VB.NET的动态链接库
mylib = ctypes.cdll.LoadLibrary('mylibrary.dll')

# 调用VB.NET的函数
result = mylib.MyFunctions_Add(2, 3)
print(result)  # 输出：5
```

## 调用C的动态链接库

```c
#include <stdio.h>

int add(int a, int b)
{
    return a + b;
}
```

```python
import ctypes

# 加载C的动态链接库
mylib = ctypes.cdll.LoadLibrary('mylibrary.dll')

# 调用C的函数
result = mylib.add(2, 3)
print(result)  # 输出：5
```

## 调用C++的动态链接库

```cpp
extern "C" {
    int add(int a, int b)
    {
        return a + b;
    }
}
```

```python
import ctypes

# 加载C++的动态链接库
mylib = ctypes.cdll.LoadLibrary('mylibrary.dll')

# 调用C++的函数
result = mylib.add(2, 3)
print(result)  # 输出：5
```

需要注意的是，以上示例中的动态链接库的命名和函数名可能会因实际情况而异，请根据具体的库文件和函数名进行调整。
