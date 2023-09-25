---
title: 将安卓XML图标转换成SVG图片
date: 2023-09-25 18:54:54
tags:
---

# 将安卓XML图标转换成SVG图片

首先要明确的是，安卓`XML`格式的图标其实是`XML`矢量图片，与SVG图片及其类似，同根同源。

## 介绍SVG
缩放矢量图形（英语：Scalable Vector Graphics，即SVG）是一种基于可扩展标记语言`XML`，用于描述二维矢量图形的图形格式。

.svg格式相对于.jpg、.png甚至.webp具有较多优势：

- 图像与分辨率无关，不会变形，适配安卓的各种分辨率；

- 省空间。体积小，一般复杂图像也能在100KB内搞定，图标更不在话下。

## 转换方法
### 手动转换
1. 将头部的：

```xml
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
```

替换成

```xml
<svg xmlns="http://www.w3.org/2000/svg"
```

闭标签也做相应修改。

2. 将`android:width`替换成`width`

3. 将`android:height`替换成`height`

4. 将`android:pathData`替换成`d`

5. 将`android:fillColor`替换成`fill`

如果没有`android:fillcolor`的话，要加上`fill="#ffffff"`

6. 将`android:viewportHeight="24" android:viewportWidth="24"`替换成`viewBox="0 0 24 24"`的形式。

### 自动转换

显而易见，手动转换及其的费时费力，且易出差错。

我将带来我个人开发的全自动图标转换器：[Image Convert](https://qingyi-studio.gitee.io/imageconvert)

目前项目稳定运行，服务器开销不小，大家多多支持。
