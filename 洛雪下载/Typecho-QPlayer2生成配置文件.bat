@echo off
setlocal enabledelayedexpansion

REM ��������ļ�
set "outputFile=music.txt"

REM ��ջ򴴽�����ļ�
echo [ > "%outputFile%"

REM ��ӡ��ʼ��Ϣ
echo ���ڴ����ļ�����������浽 %outputFile%...

REM ������ǰĿ¼�µ�����.mp3��.jpg��.lrc�ļ�
for %%f in (*.mp3 *.jpg *.lrc) do (
    REM ��ȡ�ļ�������չ��
    set "filename=%%~nf"
    set "extension=%%~xf"

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

    REM �����ļ���������URLǰ׺
    if "!extension!"==".mp3" set "url=https://file.mobufan.eu.org:666/music/%%f"
    if "!extension!"==".jpg" set "url=https://file.mobufan.eu.org:666/music/%%f"
    if "!extension!"==".lrc" set "url=https://cdn.jsdelivr.net/gh/meimolihan/music@v1.0.0/%%f"

    REM д��JSON��ʽ������ļ�
    echo { >> "%outputFile%"
    echo     "name": "!name!", >> "%outputFile%"
    echo     "artist": "!artist!", >> "%outputFile%"
    echo     "audio": "https://file.mobufan.eu.org:666/music/!name!-!artist!.mp3", >> "%outputFile%"
    echo     "cover": "https://file.mobufan.eu.org:666/music/!name!-!artist!.jpg", >> "%outputFile%"
    echo     "lrc": "https://cdn.jsdelivr.net/gh/meimolihan/music@v1.0.0/!name!-!artist!.lrc" >> "%outputFile%"
    echo }, >> "%outputFile%"

    REM ��ӡ���������Ϣ
    echo  - �������: %%f
    echo.
)

REM ɾ�����һ�����Ų��պ�JSON����
powershell -Command "(Get-Content '%outputFile%') -replace ',*$', '' | Set-Content '%outputFile%'"
echo ] >> "%outputFile%"

REM ��ӡ�����Ϣ
echo �����ļ�������ɣ�����ѱ��浽 %outputFile%��

REM ��ɺ��Զ��˳�
exit