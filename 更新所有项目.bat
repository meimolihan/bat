@echo off
setlocal enabledelayedexpansion

REM ������ɫΪ��ɫ������Ĭ������ɫ����
COLOR 0A
CLS
PROMPT $P$G

rem ���ø�Ŀ¼Ϊ�û������µ� GitHub �ļ���
set "ROOT_DIR=%USERPROFILE%\Desktop\GitHub\"

rem ���Ŀ¼�Ƿ����
if not exist "%ROOT_DIR%" (
    echo ָ����Ŀ¼ "%ROOT_DIR%" �����ڡ�
    pause
    exit /b 1
)

rem ����Ŀ¼�µ������ļ���
echo ���ڼ�� GitHub �ļ����е���Ŀ...
echo.
for /d %%F in ("%ROOT_DIR%\*") do (
    rem ����ļ����Ƿ��� Git ��Ŀ��ͨ����� .git �ļ����Ƿ���ڣ�
    if exist "%%F\.git" (
        rem �л���Ŀ¼��ִ�� git pull
        pushd "%%F"
        echo.
        echo ========================================
        echo ���ڸ�����Ŀ: %%~nxF
        echo ��Ŀ·��: %%F
        echo ========================================
        git pull origin main
        popd
        echo.
        echo.
    )
)

echo ������Ŀ������ɣ�
pause
exit /b 0