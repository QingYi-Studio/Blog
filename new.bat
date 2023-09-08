@echo off
chcp 65001
set /p name=请输入文章名称：
hexo new "%name%"