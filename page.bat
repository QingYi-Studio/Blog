@echo off
chcp 65001
set /p name=请输入页面名称：
hexo new page "%name%" --silent