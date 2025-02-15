@echo off
setlocal enabledelayedexpansion

rem 定义基础链接
set "base_url=https://cdn.jsdelivr.net/gh/meimolihan/music@v1.0.0/"

rem 定义输出文件
set "output_file=typecho.txt"

rem 清空输出文件（如果存在）
if exist %output_file% del %output_file%

rem 遍历当前目录下的所有子文件夹
for /d %%a in (*) do (
    rem 获取文件夹名称
    set "folder_name=%%a"
    rem 提取歌曲名和歌手名
    for /f "delims=- tokens=1,2" %%b in ("!folder_name!") do (
        set "song_name=%%b"
        set "artist_name=%%c"
    )
    rem 构建链接
    set "audio_url=%base_url%!folder_name!/song.mp3"
    set "cover_url=%base_url%!folder_name!/cover.jpg"
    set "lrc_url=%base_url%!folder_name!/lyric.lrc"

    rem 写入内容到文件
    echo     {>> %output_file%
    echo         "name": "!song_name!",>> %output_file%
    echo         "artist": "!artist_name!",>> %output_file%
    echo         "audio": "!audio_url!",>> %output_file%
    echo         "cover": "!cover_url!",>> %output_file%
    echo         "lrc": "!lrc_url!">> %output_file%
    echo     },>> %output_file%
)

endlocal