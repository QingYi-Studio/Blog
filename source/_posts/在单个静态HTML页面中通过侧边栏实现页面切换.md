---
title: 在单个静态HTML页面中通过侧边栏实现页面切换
date: 2025-05-14 21:26:53
tags:
  - HTML
categories:
  - HTML
---
# 在单个静态HTML页面中通过侧边栏实现页面切换

在我们平时的开发中，在单个页面中实现侧边栏点击切换主页面部分内容一般会使用Vue来实现，但在部分特殊情况下，我们会需要使用静态页面，此时大部分项目的操作都是创建多个页面来跳转，不过我在此处实现了一种基于原生静态HTML页面实现的一种方案。

HTML页面代码（index.html）：

```html
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8" />
    <link rel="stylesheet" href="container.css" />
    <link rel="stylesheet" href="sidebar.css" />
    <link rel="stylesheet" href="content.css" />
    <title>Cipherlink Nexus</title>
    <style>
        /* 确保基础样式优先级 */
        .page {
            display: none !important;
        }

        .page.active {
            display: block !important;
        }
    </style>
    <script>
        // 增强版路由逻辑
        function initializeRouter() {
            // 统一路由命名规范（小写）
            const routes = ['home', 'server', 'client', 'about'];

            function updateActiveState(hash) {
                const validHash = routes.includes(hash) ? hash : 'home';

                // 更新页面内容
                document.querySelectorAll('.page').forEach(page => {
                    page.classList.remove('active');
                });
                const activePage = document.getElementById(validHash.charAt(0).toUpperCase() + validHash.slice(1));
                if (activePage) activePage.classList.add('active');

                // 更新导航高亮
                document.querySelectorAll('.sidebar a').forEach(link => {
                    link.classList.remove('active');
                    if (link.getAttribute('href') === `#${validHash}`) {
                        link.classList.add('active');
                    }
                });
            }

            // 监听路由变化
            window.addEventListener('hashchange', () => {
                const hash = window.location.hash.substring(1).toLowerCase();
                updateActiveState(hash);
            });

            // 初始化路由
            const initialHash = window.location.hash.substring(1).toLowerCase();
            updateActiveState(initialHash || 'home');
        }

        // 页面加载时初始化
        window.addEventListener('DOMContentLoaded', initializeRouter);
    </script>
</head>

<body>
    <div id="container" class="container">
        <!-- 侧边栏 -->
        <div class="sidebar">
            <a href="#home">Home</a>
            <a href="#server">Server</a>
            <a href="#client">Client</a>
            <a href="#about">About</a>
        </div>

        <!-- 主内容 -->
        <div id="content" class="content">
            <!-- 注意：ID 保持首字母大写 -->
            <div id="Home" class="page">
                <div id="content" class="content">
                    <h2>Welcome to home page</h2>
                    <p>description</p>
                </div>
            </div>

            <!-- 添加缺失的页面区块 -->
            <div id="Server" class="page">
                <h2>Server Configuration</h2>
                <p>Server management interface</p>
            </div>

            <div id="Client" class="page">
                <h2>Client Setup</h2>
                <p>Client configuration details</p>
            </div>

            <div id="About" class="page">
                <h2>About Our Project</h2>
                <p>2025</p>
            </div>
        </div>
    </div>
</body>

</html>
```

容器样式（container.css）：

```css
body {
    background-color: aliceblue;
}

#container {
    display: flex; /* 启用flex布局 */
    min-height: 100vh;
}
```

侧边栏样式（sidebar.css）:

```css
/* 侧边导航菜单 */
.sidebar {
    margin: 0;
    padding: 0;
    width: 200px;
    background-color: #f1f1f1;
    position: fixed;
    height: 100%;
    overflow: auto;
}

/* 侧边栏链接 */
.sidebar a {
    display: block;
    color: black;
    padding: 16px;
    text-decoration: none;
}

/* 活动/当前链接 */
.sidebar a.active {
    background-color: #4CAF50;
    color: white;
}

/* 鼠标悬停链接 */
.sidebar a:hover:not(.active) {
    background-color: #555;
    color: white;
}

/* 页面内容 */
div.content {
    margin-left: 200px;
    padding: 20px;
    min-height: 100vh;
}
```

将以上代码复制或替换到项目中需要的位置即可，可根据需要调整CSS样式与JavaScript代码。
