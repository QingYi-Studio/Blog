---
title: CefSharp禁用debug.log
date: 2024-07-03 23:31:47
categories:
- C#
- CefSharp
tags:
- C-Sharp
- HTML
---

# CefSharp禁用debug.log

由于 CefSharp 默认会记录日志到`debug.log`文件中，如果不做清理或限制这个文件甚至会高达上百兆。

以下是解决方案：

```c#
public static void Init()
{
    var settings = new CefSettings();
 
    // settings.LogSeverity = LogSeverity.Verbose; // 增加日志严重性，以便CEF输出详细信息，这对调试很有用
    settings.LogSeverity = LogSeverity.Disable; // 关闭日志显示
    settings.CachePath = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData), "CefSharp\\Cache"); // 注意:执行用户必须有足够的权限来写这个文件夹。
    
    // 启用 WebRTC                            
    settings.CefCommandLineArgs.Add("enable-media-stream");
    
    // 禁用 GPU 加速
    settings.CefCommandLineArgs.Add("disable-gpu");
 
    // 不要使用代理服务器，总是使用直接连接。覆盖传递的任何其他代理服务器标志。
    // 稍微改进了Cef初始化时间，因为它不会尝试解析代理
    settings.CefCommandLineArgs.Add("no-proxy-server"); 

 
    Cef.Initialize(settings);
}
```

大部分代码与题无关，关键是`settings.LogSeverity = LogSeverity.Disable;`。
