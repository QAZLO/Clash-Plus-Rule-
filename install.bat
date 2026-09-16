@echo off
chcp 65001 >nul
title Clash Plus 中国直连规则 - 安装器

echo.
echo ====================================
echo   Clash Plus 中国直连规则安装器
echo ====================================
echo.
echo 正在启动 PowerShell 脚本...
echo.

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0install.ps1"

if errorlevel 1 (
    echo.
    echo [错误] 安装失败，请查看上方错误信息。
    pause
    exit /b 1
)
