@echo off
chcp 65001 > nul

:input
echo 请输入文章名称（不要带引号）：
set /p "name="

:: 检查是否输入了名称
if "%name%"=="" (
    echo 错误：未输入文章名称！
    goto input
)

:: 使用 Hexo 创建新文章
echo 正在创建文章 "%name%"...
hexo new "%name%"

:: 检查是否成功
if errorlevel 1 (
    echo 错误：创建文章失败！
    pause
    exit /b
) else (
    echo 文章 "%name%" 创建成功！
    pause
    exit /b 0
)