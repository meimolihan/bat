@echo off
setlocal enabledelayedexpansion

rem ������ǰĿ¼������Ŀ¼�µ������ļ�
for /r %%a in (*) do (
    set "filepath=%%~dpa"
    set "file=%%~nxa"
    set "ext=%%~xa"
    if "!ext!"==".mp3" (
        if not "!file!"=="song.mp3" (
            if not exist "!filepath!song.mp3" (
                move "%%a" "!filepath!song.mp3" >nul 2>&1
            ) else (
                echo ��Ŀ¼!filepath! �д���ͬ���� song.mp3 �ļ����޷��� %%a ������Ϊ song.mp3
            )
        )
    ) else if "!ext!"==".jpg" (
        if not "!file!"=="cover.jpg" (
            if not exist "!filepath!cover.jpg" (
                move "%%a" "!filepath!cover.jpg" >nul 2>&1
            ) else (
                echo ��Ŀ¼!filepath! �д���ͬ���� cover.jpg �ļ����޷��� %%a ������Ϊ cover.jpg
            )
        )
    ) else if "!ext!"==".lrc" (
        if not "!file!"=="lyric.lrc" (
            if not exist "!filepath!lyric.lrc" (
                move "%%a" "!filepath!lyric.lrc" >nul 2>&1
            ) else (
                echo ��Ŀ¼!filepath! �д���ͬ���� lyric.lrc �ļ����޷��� %%a ������Ϊ lyric.lrc
            )
        )
    )
)
echo �ļ���������������ɣ�����ͬ���ļ����²���������δ�ɹ�����鿴��ʾ��Ϣ��
rem pause