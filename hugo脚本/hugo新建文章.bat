@echo off
:: 设置工作目录（确保路径正确）
set "hugoDir=%USERPROFILE%\Desktop\GitHub\hugo-main"

:: 检查目录是否存在
if not exist "%hugoDir%" (
    echo 目标目录 %hugoDir% 不存在，请检查路径是否正确。
    pause
    exit
)

:: 提示用户输入文件名
set /p fileName=请输入文章名：

:: 检查是否输入了文件名
if "%fileName%"=="" (
    echo 文件名不能为空，请重新运行脚本并输入有效的文件名。
    pause
    exit
)

:: 切换到 Hugo 项目目录
cd /d "%hugoDir%"

:: 使用 hugo new 命令创建新文件
echo 正在创建新文件...
hugo new "post/%fileName%/index.md"

:: 检查文件是否创建成功
set "contentPath=%hugoDir%\content\post\%fileName%\index.md"
if not exist "%contentPath%" (
    echo 文件 %fileName% 的创建失败，请检查 Hugo 是否正确安装并配置。
    pause
    exit
)

:: 提示用户文件已创建
echo 文件 %fileName% 已成功创建在 %contentPath%！

:: 打开记事本并加载文件后退出CMD
echo 正在打开记事本...
start notepad.exe "%contentPath%"
exit