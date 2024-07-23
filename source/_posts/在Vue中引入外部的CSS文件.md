---
title: 在Vue中引入外部的CSS文件
date: 2024-01-30 10:00:40
categories:
- Vue
tags:
- Vue
- CSS
---

# 在Vue中引入外部的CSS文件

在项目的`src`文件下，新建一个`style`文件夹存放*CSS*文件。

###### 1. 全局引入

将外部的*CSS*文件放到`style`文件下，引入外部文件只需在`main.js`文件中

`import '@/style/reset.css'` 我引入的是清除默认样式的css文件

###### 2. 局部引入相对路径

```vue
<style scoped>
    @import '@/assets/iconfont/iconfont.css';
</style>
```

这个分号一定要写，要不会报错。

###### 注意

使用`@import`引入样式文件，就算加`scoped`，其它没有引入的模块还是可以访问到你的样式，如果某个组件的类名一致，则就会被污染到。

如果不想被污染，修改引入方式 `<style src="@/style/reset.css"  scoped></style>` 要是在写新的样式，要重新写一个新的`style`标签

```vue
<style src="@/style/reset.css" scoped></style>

<style scoped>
// 新的css样式
</style>
```

转载自：https://juejin.cn/post/7066982681484984333
