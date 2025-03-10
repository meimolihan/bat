@echo off
setlocal enabledelayedexpansion

set "source_dir=%USERPROFILE%\Desktop\GitHub\hexo"
set "dest_dir=%USERPROFILE%\Desktop\GitHub\hexo-main"

:: 创建目标目录（如果不存在）
if not exist "%dest_dir%" mkdir "%dest_dir%"

:: 复制独立文件并给出独立提示
for %%f in (_config.yml _config.butterfly.yml package.json .gitignore) do (
    xcopy "%source_dir%\%%f" "%dest_dir%\" /Y >nul
    if not errorlevel 1 (
        echo 成功复制文件: %%f
    ) else (
        echo 复制文件 %%f 失败
    )
)

:: 处理冲突目录（包含详细错误处理）
for %%i in (themes source scaffolds) do (
    set "target_path=%dest_dir%\%%i"
    
    :: 检查目标路径是否存在
    if exist "!target_path!" (
        :: 检查是否为文件
        if not exist "!target_path!\." (
            echo 发现冲突文件: !target_path!
            del /F /Q "!target_path!" >nul 2>&1
            if errorlevel 1 (
                echo 错误: 无法删除文件，请手动处理后重试
                exit /b 1
            )
            echo 文件已删除: !target_path!
        ) else (
            echo 目标目录已存在: !target_path!
        )
    )
    
    :: 复制目录并处理错误
    xcopy "%source_dir%\%%i" "!target_path!" /E /Y /H /I >nul
    if not errorlevel 1 (
        echo 成功复制目录: %%i
    ) else (
        echo 复制目录 %%i 失败
    )
)

endlocal
echo 全部文件和目录已成功复制！
pause