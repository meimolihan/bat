@echo off
setlocal enabledelayedexpansion

:: ����Ҫ������Ŀ¼����ǰ�ű�����Ŀ¼ΪĬ�ϣ�
set "target_dir=%~dp0"

:: �����ų����ļ������ļ��������ÿո�ָ���
set "exclude_files=*.bat *.exe"
set "exclude_folders=͸��ͼƬ���� 1920x1080 ������������ typecho���� ͼƬ����"

:: ����Ŀ¼�µ������ļ�
for %%f in ("%target_dir%\*") do (
    :: ����Ƿ����ļ�
    if exist "%%f" (
        set "is_excluded="
        for %%e in (%exclude_files%) do (
            if /i "%%~nxf"=="%%~e" (
                set "is_excluded=true"
            )
        )
        if not defined is_excluded (
            echo ɾ���ļ�: %%f
            del "%%f" >nul 2>&1
        )
    )
)

:: ����Ŀ¼�µ������ļ���
for /d %%d in ("%target_dir%\*") do (
    set "is_excluded="
    for %%e in (%exclude_folders%) do (
        if /i "%%~nxd"=="%%~e" (
            set "is_excluded=true"
        )
    )
    if not defined is_excluded (
        echo ɾ���ļ���: %%d
        rd /s /q "%%d" >nul 2>&1
    )
)

echo ������ɡ�
:: pause

exit