@echo off
setlocal enabledelayedexpansion

rem 遍历当前目录及其子目录下的所有文件
for /r %%a in (*) do (
    set "filepath=%%~dpa"
    set "file=%%~nxa"
    set "ext=%%~xa"
    if "!ext!"==".mp3" (
        if not "!file!"=="song.mp3" (
            if not exist "!filepath!song.mp3" (
                move "%%a" "!filepath!song.mp3" >nul 2>&1
            ) else (
                echo 子目录!filepath! 中存在同名的 song.mp3 文件，无法将 %%a 重命名为 song.mp3
            )
        )
    ) else if "!ext!"==".jpg" (
        if not "!file!"=="cover.jpg" (
            if not exist "!filepath!cover.jpg" (
                move "%%a" "!filepath!cover.jpg" >nul 2>&1
            ) else (
                echo 子目录!filepath! 中存在同名的 cover.jpg 文件，无法将 %%a 重命名为 cover.jpg
            )
        )
    ) else if "!ext!"==".lrc" (
        if not "!file!"=="lyric.lrc" (
            if not exist "!filepath!lyric.lrc" (
                move "%%a" "!filepath!lyric.lrc" >nul 2>&1
            ) else (
                echo 子目录!filepath! 中存在同名的 lyric.lrc 文件，无法将 %%a 重命名为 lyric.lrc
            )
        )
    )
)
echo 文件重命名操作已完成，如有同名文件导致部分重命名未成功，请查看提示信息。
rem pause