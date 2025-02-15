@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

REM ������ɫΪ��ɫ������Ĭ������ɫ����
COLOR 0A
CLS
PROMPT $P$G

REM ����Ŀ��Ŀ¼
SET "REPO_PATH=%USERPROFILE%\Desktop\GitHub\file"

:ValidateRepoPath
REM ���Ŀ��Ŀ¼�Ƿ����
IF NOT EXIST "%REPO_PATH%" (
    CALL :ShowError "����Ŀ¼ %REPO_PATH% �����ڣ�����·����"
    EXIT /B 1
)

REM �л���Ŀ��Ŀ¼
CD /D "%REPO_PATH%" 2>NUL
IF ERRORLEVEL 1 (
    CALL :ShowError "�����޷��л���Ŀ¼ %REPO_PATH%������ Git �ֿ⡣"
    EXIT /B 1
)

REM ����Ƿ�Ϊ��Ч�� Git �ֿ�
IF NOT EXIST .git (
    CALL :ShowError "����Ŀ¼ %REPO_PATH% ����һ����Ч�� Git �ֿ⡣"
    EXIT /B 1
)

:CheckForChanges
REM ����Ƿ����޸���Ҫ�ύ
CALL :ShowMessage "���ڼ���Ƿ����ļ���Ҫ�ύ..."

git status >nul 2>&1
IF ERRORLEVEL 1 (
    CALL :ShowError "�����޷���ȡ Git �ֿ�״̬�����黷����"
    EXIT /B 1
)

SET "CHANGES="
FOR /F "delims=" %%D IN ('git status --porcelain') DO (
    IF "%%D" NEQ "" (
        SET "CHANGES=YES"
    )
)

IF DEFINED CHANGES (
    CALL :ShowMessage "��⵽�ļ��޸ģ���ʼ�ύ..."
    CALL :AddChanges
    CALL :CommitChanges
    CALL :PushChanges
    CALL :ShowMessage "�ύ�����ͳɹ���"
) ELSE (
    CALL :ShowMessage "û���ļ���Ҫ�ύ��"
)

REM ��ʾ���
CALL :ShowMessage "�ű�ִ����ɡ�"
pause
ENDLOCAL
EXIT /B 0

:ShowMessage
ECHO ============================================
ECHO %~1
ECHO ============================================
ECHO.
EXIT /B 0

:ShowError
ECHO ============================================
ECHO %~1
ECHO ============================================
pause
EXIT /B 0

:AddChanges
CALL :ShowMessage "����������и���..."
git add .
IF ERRORLEVEL 1 (
    CALL :ShowError "�����޷�����ļ������� Git �ֿ⡣"
    EXIT /B 1
)
EXIT /B 0

:CommitChanges
CALL :ShowMessage "�����ύ����..."
git commit -m "update"
IF ERRORLEVEL 1 (
    CALL :ShowError "�����ύʧ�ܣ����� Git �ֿ⡣"
    EXIT /B 1
)
EXIT /B 0

:PushChanges
CALL :ShowMessage "�������͸��ĵ�Զ�ֿ̲�..."
git push
IF ERRORLEVEL 1 (
    CALL :ShowError "��������ʧ�ܣ������������ӻ�Զ�����á�"
    EXIT /B 1
)
EXIT /B 0


