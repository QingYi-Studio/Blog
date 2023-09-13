---
title: C# WPF(.NET Framework)窗口使用HTML页面
date: 2023-09-13 21:42:58
tags:
- 编程
- C-Sharp
- HTML
---

# C# WPF(.NET Framework)窗口使用HTML页面

由于`Awesomium`和`DotNetBrowser`目前都已经停止更新并不再推荐使用，所以我并没有写相关教程。

然后呢，我个人不喜欢`.Net Core`，所以`WebView`也没写，单纯个人喜好问题，以后想要用了再写吧。

## WebBrowser

首先，在XAML文件中添加一个`WebBrowser`控件：

```xaml
<Window x:Class="MyApp.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="HTML嵌入示例" Height="450" Width="800">
    <Grid>
        <WebBrowser x:Name="webBrowser" />
    </Grid>
</Window>
```

### 代码嵌入式

在后台代码中加载HTML内容：

```csharp
using System;
using System.Windows;

namespace MyApp
{
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();

            // 在窗口加载时加载HTML
            Loaded += MainWindow_Loaded;
        }

        private void MainWindow_Loaded(object sender, RoutedEventArgs e)
        {
            // 加载HTML内容
            webBrowser.NavigateToString("<html><body><h1>Hello, World!</h1></body></html>");
        }
    }
}
```

此示例在窗口加载时将显示一个包含标题 "Hello, World!" 的HTML页面。

### 外部文件绝对路径式

```csharp
using System;
using System.IO;
using System.Windows;
using System.Windows.Controls;

namespace WebBrowserExample
{
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            string filePath = @"C:\path\to\your\html\file.html";

            if (File.Exists(filePath))
            {
                webBrowser.Navigate(new Uri(filePath));
            }
            else
            {
                MessageBox.Show("指定的文件不存在！");
            }
        }
    }
}
```

在上面的示例中，我们假设你有一个 `MainWindow`（主窗口）并添加了一个名为 `webBrowser` 的 `WebBrowser` 控件。在窗口的 `Loaded` 事件中，我们指定了要加载的 HTML 文件的绝对路径。

### 外部文件相对路径式

```csharp
using System;
using System.IO;
using System.Windows;
using System.Windows.Controls;

namespace WebBrowserExample
{
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            string currentDirectory = Directory.GetCurrentDirectory();
            string relativePath = "your/html/file.html";
            string absolutePath = Path.Combine(currentDirectory, relativePath);

            if (File.Exists(absolutePath))
            {
                webBrowser.Navigate(new Uri(absolutePath));
            }
            else
            {
                MessageBox.Show("指定的文件不存在！");
            }
        }
    }
}
```

在上述示例中，我们假设你有一个 `MainWindow`（主窗口）并添加了一个名为 `webBrowser` 的 `WebBrowser` 控件。在窗口的 `Loaded` 事件中，我们首先获取当前目录的路径 `currentDirectory`，然后将其与相对路径 `relativePath` 合并为绝对路径 `absolutePath`。

最后，我们检查文件是否存在，如果文件存在，就使用 `WebBrowser` 控件的 `Navigate` 方法加载该文件；如果文件不存在，则弹出一个消息框提示文件不存在。

### 直接加载(无C#代码)

填写窗口XAML文件`WebBrowser`中的`Address`。

例如：

```xml
<WebBrowser x:Name="webBrowser" Address="https://sunrise-studio.gitee.io/" />
```

简单吧，但是不方便修改，这个只适合最简单基础的。

## CefSharp

在MainWindow.xaml文件中添加一个WebBrowser控件：

```xml
<Window x:Class="CefSharpDemo.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:cefSharp="clr-namespace:CefSharp.Wpf;assembly=CefSharp.Wpf"
        Title="CefSharp Demo" Height="350" Width="525">
    <Grid>
        <cefSharp:ChromiumWebBrowser x:Name="webBrowser" Address="about:blank" />
    </Grid>
</Window>
```

### 代码嵌入式

```csharp
using System.Windows;
using CefSharp;
using CefSharp.Wpf;

namespace CefSharpDemo
{
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
            InitializeCefSharp();
            webBrowser.Loaded += WebBrowser_Loaded;
        }

        private void InitializeCefSharp()
        {
            var settings = new CefSettings();
            Cef.Initialize(settings);
        }

        private void WebBrowser_Loaded(object sender, RoutedEventArgs e)
        {
            string html = @"<html><body><h1>Hello, World!</h1></body></html>";
            webBrowser.LoadHtml(html, "https://localhost");
        }
        
        protected override void OnClosed(System.EventArgs e)
        {
            base.OnClosed(e);
            Cef.Shutdown();
        }
    }
}
```

在构造函数中，我们初始化了CefSharp引擎，并将`webBrowser.Loaded`事件处理器指向了`WebBrowser_Loaded`方法。这样，当`webBrowser`控件加载完成时，会触发该事件，然后在`WebBrowser_Loaded`方法中加载HTML内容。

注意，在`WebBrowser_Loaded`方法中，我们将HTML代码赋值给`html`变量，然后通过`webBrowser.LoadHtml`方法加载到`webBrowser`控件中。

现在，当启动此WPF应用程序时，它将在窗口加载完成后加载并显示`Hello, World!`的HTML内容。

### 外部文件绝对路径式

```csharp
using System;
using System.IO;
using System.Windows;
using CefSharp;
using CefSharp.Wpf;

namespace CefSharpDemo
{
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
            InitializeCefSharp();

            Loaded += MainWindow_Loaded;
            Closed += MainWindow_Closed;
        }

        private void InitializeCefSharp()
        {
            var settings = new CefSettings();
            Cef.Initialize(settings);
        }

        private void MainWindow_Loaded(object sender, RoutedEventArgs e)
        {
            string htmlFilePath = @"C:\path\to\your\html\file.html";
            LoadHtmlFromFile(htmlFilePath);
        }

        private void LoadHtmlFromFile(string filePath)
        {
            try
            {
                string htmlContent = File.ReadAllText(filePath);
                webBrowser.LoadHtml(htmlContent, "https://localhost");
            }
            catch (Exception ex)
            {
                // 处理加载错误
                MessageBox.Show($"Failed to load HTML file: {ex.Message}");
            }
        }

        private void MainWindow_Closed(object sender, EventArgs e)
        {
            Cef.Shutdown();
        }
    }
}
```

在这个简化的示例中，我们假设要加载的HTML文件位于本地磁盘上的绝对路径`C:\path\to\your\html\file.html`。在`MainWindow_Loaded`方法中，我们调用`LoadHtmlFromFile`方法，并将HTML文件的路径作为参数传递给它。

`LoadHtmlFromFile`方法读取指定路径的HTML文件内容，并使用`webBrowser.LoadHtml`方法将内容加载到`webBrowser`控件中。如果加载过程中出现错误，我们通过一个简单的消息框显示错误信息。

在窗口关闭时，我们调用`Cef.Shutdown`方法来关闭CefSharp引擎。

### 外部文件相对路径式



```csharp
using System;
using System.IO;
using System.Reflection;
using System.Windows;
using CefSharp;
using CefSharp.Wpf;

namespace CefSharpDemo
{
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
            InitializeCefSharp();

            Loaded += MainWindow_Loaded;
            Closed += MainWindow_Closed;
        }

        private void InitializeCefSharp()
        {
            var settings = new CefSettings();
            Cef.Initialize(settings);
        }

        private void MainWindow_Loaded(object sender, RoutedEventArgs e)
        {
            string htmlFilePath = GetHtmlFilePath("file.html");
            LoadHtmlFromFile(htmlFilePath);
        }

        private string GetHtmlFilePath(string fileName)
        {
            //获取当前应用程序目录的路径
            string currentPath = Path.GetDirectoryName(Assembly.GetExecutingAssembly().GetName().CodeBase).Replace(@"file:\", "");
            //获取HTML文件的绝对路径
            string htmlFilePath = Path.Combine(currentPath, fileName);
            return htmlFilePath;
        }

        private void LoadHtmlFromFile(string filePath)
        {
            try
            {
                string htmlContent = File.ReadAllText(filePath);
                webBrowser.LoadHtml(htmlContent, "https://localhost");
            }
            catch (Exception ex)
            {
                // 处理加载错误
                MessageBox.Show($"Failed to load HTML file: {ex.Message}");
            }
        }

        private void MainWindow_Closed(object sender, EventArgs e)
        {
            Cef.Shutdown();
        }
    }
}
```

这个简化的示例中，我们将要加载HTML文件放在程序的根目录下，并命名为`file.html`。在`MainWindow_Loaded`方法中，我们调用了`GetHtmlFilePath`方法，并将HTML文件名作为参数传递给它。

`GetHtmlFilePath`方法首先获取当前应用程序目录的路径，然后使用`Path.Combine`方法将HTML文件名与应用程序目录组合成完整路径，并返回该路径。

随后，我们调用`LoadHtmlFromFile`方法，并将HTML文件的完整路径作为参数传递给它。该方法读取指定路径的HTML文件内容，并使用`webBrowser.LoadHtml`方法将内容加载到`webBrowser`控件中。

如果加载过程中出现错误，我们通过一个简单的消息框显示错误信息。

在窗口关闭时，我们调用`Cef.Shutdown`方法来关闭CefSharp引擎。

请注意，我们使用了`Path.GetDirectoryName(Assembly.GetExecutingAssembly().GetName().CodeBase)`方法来获取当前目录的路径，而不是`Environment.CurrentDirectory`。这是因为当应用程序启动时，`Environment.CurrentDirectory`可能不是期望的路径。当然，如果你不在意的话，用`Environment.CurrentDirectory`也是可以的

### 直接加载(无C#代码)

填写窗口XAML文件`cefSharp`中的`Address`。

例如：

```xml
<cefSharp:ChromiumWebBrowser x:Name="webBrowser" Address="https://sunrise-studio.gitee.io/" />
```

简单吧，但是不方便修改，这个只适合最简单基础的。
