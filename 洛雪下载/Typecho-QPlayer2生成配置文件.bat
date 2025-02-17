@echo off
setlocal enabledelayedexpansion

REM 设置输出文件
set "outputFile=music.txt"

REM 清空或创建输出文件
echo [ > "%outputFile%"

REM 打印开始信息
echo 正在处理文件，结果将保存到 %outputFile%...

REM 遍历当前目录下的所有.mp3、.jpg和.lrc文件
for %%f in (*.mp3 *.jpg *.lrc) do (
    REM 获取文件名和扩展名
    set "filename=%%~nf"
    set "extension=%%~xf"

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

    REM 根据文件类型设置URL前缀
    if "!extension!"==".mp3" set "url=https://file.mobufan.eu.org:666/music/%%f"
    if "!extension!"==".jpg" set "url=https://file.mobufan.eu.org:666/music/%%f"
    if "!extension!"==".lrc" set "url=https://cdn.jsdelivr.net/gh/meimolihan/music@v1.0.0/%%f"

    REM 写入JSON格式到输出文件
    echo { >> "%outputFile%"
    echo     "name": "!name!", >> "%outputFile%"
    echo     "artist": "!artist!", >> "%outputFile%"
    echo     "audio": "https://file.mobufan.eu.org:666/music/!name!-!artist!.mp3", >> "%outputFile%"
    echo     "cover": "https://file.mobufan.eu.org:666/music/!name!-!artist!.jpg", >> "%outputFile%"
    echo     "lrc": "https://cdn.jsdelivr.net/gh/meimolihan/music@v1.0.0/!name!-!artist!.lrc" >> "%outputFile%"
    echo }, >> "%outputFile%"

    REM 打印处理完成信息
    echo  - 处理完成: %%f
    echo.
)

REM 删除最后一个逗号并闭合JSON数组
powershell -Command "(Get-Content '%outputFile%') -replace ',*$', '' | Set-Content '%outputFile%'"
echo ] >> "%outputFile%"

REM 打印完成信息
echo 所有文件处理完成，结果已保存到 %outputFile%。

REM 完成后自动退出
exit