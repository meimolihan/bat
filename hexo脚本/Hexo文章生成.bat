@echo off
setlocal enabledelayedexpansion

rem 提示用户输入文章标题
set /p "folderName=请输入文章标题(将作为文件夹名): "

rem 获取桌面路径
for %%i in ("%USERPROFILE%\Desktop") do set "desktopPath=%%~fi"

rem 拼接完整路径
set "fullPath=%desktopPath%\%folderName%"

rem 创建文件夹
md "%fullPath%" 2>nul
if errorlevel 1 (
    echo 错误：无法创建文件夹 "%folderName%"
    exit /b 1
)

rem 获取ISO 8601时间（含时区）
for /f "tokens=2 delims==." %%a in ('wmic os get localdatetime /value ^| findstr "LocalDateTime"') do (
    set "datetime=%%a"
)

rem 格式基本时间部分
set "isoTime=!datetime:~0,4!-!datetime:~4,2!-!datetime:~6,2!T!datetime:~8,2!:!datetime:~10,2!:!datetime:~12,2!"

rem 动态获取时区偏移（支持夏令时）
for /f "tokens=*" %%t in ('powershell -Command "(Get-Date).ToString('zzz')"') do (
    set "timezone=%%t"
)

rem 生成完整时间戳
set "fullDateTime=!isoTime!!timezone!"

rem 生成文章模板
(
    echo ---
    echo title: "!folderName!"
    echo date: !fullDateTime!
	echo # 文章置顶，数值越大越靠前
    echo sticky: 
    echo # 文章封面
	echo # cover: 
	echo # 文章分类
	echo categories: 
	echo   - 默认分类
	echo # 文章标签
	echo tags:
    echo   - hexo
    echo ---
) > "%fullPath%\index.md"

if exist "%fullPath%\index.md" (
    echo 成功创建文章模板：
    echo 路径：%fullPath%
    echo 时间：!fullDateTime!
) else (
    echo 错误：模板文件生成失败
)

endlocal