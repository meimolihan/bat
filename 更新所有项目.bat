@echo off
setlocal enabledelayedexpansion

REM 设置颜色为绿色背景，默认亮白色文字
COLOR 0A
CLS
PROMPT $P$G

rem 设置根目录为用户桌面下的 GitHub 文件夹
set "ROOT_DIR=%USERPROFILE%\Desktop\GitHub\"

rem 检查目录是否存在
if not exist "%ROOT_DIR%" (
    echo 指定的目录 "%ROOT_DIR%" 不存在。
    pause
    exit /b 1
)

rem 遍历目录下的所有文件夹
echo 正在检查 GitHub 文件夹中的项目...
echo.
for /d %%F in ("%ROOT_DIR%\*") do (
    rem 检查文件夹是否是 Git 项目（通过检查 .git 文件夹是否存在）
    if exist "%%F\.git" (
        rem 切换到目录并执行 git pull
        pushd "%%F"
        echo.
        echo ========================================
        echo 正在更新项目: %%~nxF
        echo 项目路径: %%F
        echo ========================================
        git pull origin main
        popd
        echo.
        echo.
    )
)

echo 所有项目更新完成！
pause
exit /b 0