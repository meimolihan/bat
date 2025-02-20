@echo off
setlocal enabledelayedexpansion

REM ��������ļ�
set "outputFile=music.txt"

REM ��ջ򴴽�����ļ�
> "%outputFile%" echo [

REM ��ӡ��ʼ��Ϣ
echo ���ڴ����ļ�����������浽 %outputFile%...

REM ������ǰĿ¼�µ�����.mp3�ļ�
for %%f in (*.mp3) do (
    REM ��ȡ�ļ�������������չ����
    set "filename=%%~nf"

    REM ��ӡ��ǰ������ļ�
    echo ���ڴ����ļ�: %%f

    REM ����name��artist
    for /f "tokens=1,2 delims=-" %%a in ("!filename!") do (
        set "name=%%a"
        set "artist=%%b"
    )

    REM ��ӡ������name��artist
    echo  - Name: !name!
    echo  - Artist: !artist!

    REM ����Ӧ��.jpg��.lrc�ļ��Ƿ����
    set "coverExists="
    set "lrcExists="
    if exist "!filename!.jpg" set "coverExists=1"
    if exist "!filename!.lrc" set "lrcExists=1"

    REM �����ļ������������URL
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

    REM д��JSON��ʽ������ļ�
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

    REM ��ӡ���������Ϣ
    echo  - �������: %%f
    echo.
)

REM ɾ�����һ�����Ų��պ�JSON����
powershell -Command "$lines = Get-Content -Path '%outputFile%'; if ($lines.Length -gt 0) { $lastLine = $lines[$lines.Length - 1]; if ($lastLine -match '^(\s*}),\s*$') { $lines[$lines.Length - 1] = $Matches[1] }; }; $lines += ']'; Set-Content -Path '%outputFile%' -Value $lines"

REM ��ӡ�����Ϣ
echo �����ļ�������ɣ�����ѱ��浽 %outputFile%��

REM �Զ��򿪽���ļ�
start notepad "%outputFile%"

REM ��ɺ��Զ��˳�
exit