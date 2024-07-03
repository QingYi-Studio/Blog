---
title: Hexo博客增加文章置顶功能
date: 2024-01-30 10:44:21
description: 给Hexo博客添加一个文章指定功能。（即本站的置顶方式）
categories:
- Hexo
- Fluid
tags:
- Hexo
- Fluid
---

# Hexo博客增加文章置顶功能

留意过公众号「历史消息」页面的朋友，想必会在不少公众号看到下图的「**作者精选**」模块，它有点像是**置顶**🔝功能，可以让作者或运营者把最想让用户看到的内容排在所有文章的最前面。

给 Hexo 博客添加「文章置顶」功能也非常简单，当然需要说明的是，不同的 Hexo 主题添加或配置这个功能的方法，存在着细微的差异。

以本博客在用的 Hexo Fluid 主题为例，官方提供的「[配置指南](https://hexo.fluid-dev.com/docs/guide/#%E6%96%87%E7%AB%A0%E6%8E%92%E5%BA%8F)」也提供了详细的说明。

安装版本号 >= 2.0.0 的 `hexo-generator-index` 插件，并在文章开头的 `Front-matter` 中额外增加一个 sticky 属性，就能将文章置顶啦。

数字大的文章会排在数字小的文章上方，例如100在99的上方。

如果你使用的是别的 Hexo 主题，可能要安装另外的插件 `hexo-generator-index-pin-top`，并配置 top 属性来实现文章的置顶。（[使用参考文章](https://blog.51cto.com/u_15477117/4919708)）

借鉴自：https://penghh.fun/2022/10/20/2022-10-20-article_pin/
