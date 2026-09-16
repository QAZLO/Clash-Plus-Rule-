@echo off
chcp 65001 >nul
title Clash Plus 中国直连规则 - 卸载器

echo.
echo ====================================
echo   Clash Plus 规则卸载器
echo ====================================
echo.

:: 检测配置目录
set CLASH_DIR=%APPDATA%\Clash Plus\Clash Plus
if not exist "%CLASH_DIR%" (
    echo [错误] 未找到 Clash Plus 配置目录！
    pause
    exit /b 1
)

echo 找到配置目录：%CLASH_DIR%
echo.

:: 显示备份列表
echo 可用的备份：
echo.
dir /b "%CLASH_DIR%\backup_*" 2>nul
if errorlevel 1 (
    echo [提示] 未找到备份文件！
    echo 无法自动恢复，请手动配置 Clash Plus。
    echo.
    pause
    exit /b 1
)

echo.
echo ====================================
echo 选择恢复方式：
echo   1. 恢复最新备份
echo   2. 手动选择备份
echo   3. 取消
echo ====================================
set /p choice=请输入选项 (1-3):

if "%choice%"=="1" (
    for /f "delims=" %%i in ('dir /b /o-d "%CLASH_DIR%\backup_*\config.yaml.bak" 2^>nul ^| findstr /r ".*" ^| more +0') do (
        set LATEST_BACKUP=%%~dpi%%~nxi
        goto :restore
    )
)

if "%choice%"=="2" (
    echo.
    echo 请手动复制备份文件到：
    echo   %CLASH_DIR%\config.yaml
    explorer "%CLASH_DIR%"
    pause
    exit /b 0
)

if "%choice%"=="3" (
    echo 已取消卸载
    pause
    exit /b 0
)

:restore
echo.
echo [恢复中] 正在恢复备份...
copy /Y "%LATEST_BACKUP%" "%CLASH_DIR%\config.yaml" >nul
if errorlevel 1 (
    echo [错误] 恢复失败！
    pause
    exit /b 1
)

echo.
echo ====================================
echo   ✓ 恢复成功！
echo ====================================
echo.
echo 已恢复到备份：%LATEST_BACKUP%
echo.
echo 请重启 Clash Plus 使配置生效。
echo.
pause
