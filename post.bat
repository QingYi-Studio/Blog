@echo off
chcp 65001

rem 获取用户输入的文章名称
set /p name=请输入文章名称：

rem 使用 Hexo 创建新文章
hexo new "%name%" --silent
