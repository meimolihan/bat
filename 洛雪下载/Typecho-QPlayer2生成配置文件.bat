@echo off
setlocal enabledelayedexpansion

REM 设置输出文件
set "outputFile=music.txt"

REM 清空或创建输出文件
> "%outputFile%" echo [

REM 打印开始信息
echo 正在处理文件，结果将保存到 %outputFile%...

REM 遍历当前目录下的所有.mp3文件
for %%f in (*.mp3) do (
    REM 获取文件名（不包含扩展名）
    set "filename=%%~nf"

    REM 打印当前处理的文件
    echo 正在处理文件: %%f

    REM 分离name和artist
    for /f "tokens=1,2 delims=-" %%a in ("!filename!") do (
        set "name=%%a"
        set "artist=%%b"
    )

    REM 打印分离后的name和artist
    echo  - Name: !name!
    echo  - Artist: !artist!

    REM 检查对应的.jpg和.lrc文件是否存在
    set "coverExists="
    set "lrcExists="
    if exist "!filename!.jpg" set "coverExists=1"
    if exist "!filename!.lrc" set "lrcExists=1"

    REM 根据文件存在情况设置URL
    set "audioUrl=https://file.mobufan.eu.org:666/music/%%f"
    if defined coverExists (
        set "coverUrl=https://file.mobufan.eu.org:666/music/!filename!.jpg"
    ) else (
        set "coverUrl="
    )
    if defined lrcExists (
        set "lrcUrl=https://cdn.jsdelivr.net/gh/meimolihan/music@v1.0.0/!filename!/lyric.lrc"
    ) else (
        set "lrcUrl="
    )

    REM 写入JSON格式到输出文件
    echo { >> "%outputFile%"
    echo     "name": "!name!", >> "%outputFile%"
    echo     "artist": "!artist!", >> "%outputFile%"
    echo     "audio": "!audioUrl!", >> "%outputFile%"
    if defined coverExists (
        echo     "cover": "!coverUrl!", >> "%outputFile%"
    ) else (
        echo     "cover": "", >> "%outputFile%"
    )
    if defined lrcExists (
        echo     "lrc": "!lrcUrl!" >> "%outputFile%"
    ) else (
        echo     "lrc": "" >> "%outputFile%"
    )
    echo }, >> "%outputFile%"

    REM 打印处理完成信息
    echo  - 处理完成: %%f
    echo.
)

REM 删除最后一个逗号并闭合JSON数组
powershell -Command "$lines = Get-Content -Path '%outputFile%'; if ($lines.Length -gt 0) { $lastLine = $lines[$lines.Length - 1]; if ($lastLine -match '^(\s*}),\s*$') { $lines[$lines.Length - 1] = $Matches[1] }; }; $lines += ']'; Set-Content -Path '%outputFile%' -Value $lines"

REM 打印完成信息
echo 所有文件处理完成，结果已保存到 %outputFile%。

REM 自动打开结果文件
start notepad "%outputFile%"

REM 完成后自动退出
exit