@echo off

:: 定义目标目录（使用 %USERPROFILE% 使路径通用）
set "targetDir=%USERPROFILE%\Desktop\GitHub\hugo-main"

:: 判断目标目录是否存在
if not exist "%targetDir%" (
    echo 目标目录不存在，请检查路径！
    pause
    exit /b
)

:: 在目标目录打开CMD
start cmd.exe /k cd /d "%targetDir%"