@echo off
setlocal enabledelayedexpansion

:: 设置要操作的目录（当前脚本所在目录为默认）
set "target_dir=%~dp0"

:: 定义排除的文件名和文件夹名（用空格分隔）
set "exclude_files=*.bat *.exe"
set "exclude_folders=透明图片处理 1920x1080 歌曲代码生成 typecho歌曲 图片处理"

:: 遍历目录下的所有文件
for %%f in ("%target_dir%\*") do (
    :: 检查是否是文件
    if exist "%%f" (
        set "is_excluded="
        for %%e in (%exclude_files%) do (
            if /i "%%~nxf"=="%%~e" (
                set "is_excluded=true"
            )
        )
        if not defined is_excluded (
            echo 删除文件: %%f
            del "%%f" >nul 2>&1
        )
    )
)

:: 遍历目录下的所有文件夹
for /d %%d in ("%target_dir%\*") do (
    set "is_excluded="
    for %%e in (%exclude_folders%) do (
        if /i "%%~nxd"=="%%~e" (
            set "is_excluded=true"
        )
    )
    if not defined is_excluded (
        echo 删除文件夹: %%d
        rd /s /q "%%d" >nul 2>&1
    )
)

echo 操作完成。
:: pause

exit