@echo off
setlocal enabledelayedexpansion

rem �����������
set "base_url=https://cdn.jsdelivr.net/gh/meimolihan/music@v1.0.0/"

rem ��������ļ�
set "output_file=typecho.txt"

rem �������ļ���������ڣ�
if exist %output_file% del %output_file%

rem ������ǰĿ¼�µ��������ļ���
for /d %%a in (*) do (
    rem ��ȡ�ļ�������
    set "folder_name=%%a"
    rem ��ȡ�������͸�����
    for /f "delims=- tokens=1,2" %%b in ("!folder_name!") do (
        set "song_name=%%b"
        set "artist_name=%%c"
    )
    rem ��������
    set "audio_url=%base_url%!folder_name!/song.mp3"
    set "cover_url=%base_url%!folder_name!/cover.jpg"
    set "lrc_url=%base_url%!folder_name!/lyric.lrc"

    rem д�����ݵ��ļ�
    echo     {>> %output_file%
    echo         "name": "!song_name!",>> %output_file%
    echo         "artist": "!artist_name!",>> %output_file%
    echo         "audio": "!audio_url!",>> %output_file%
    echo         "cover": "!cover_url!",>> %output_file%
    echo         "lrc": "!lrc_url!">> %output_file%
    echo     },>> %output_file%
)

endlocal