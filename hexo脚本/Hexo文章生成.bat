@echo off
setlocal enabledelayedexpansion

rem ��ʾ�û��������±���
set /p "folderName=���������±���(����Ϊ�ļ�����): "

rem ��ȡ����·��
for %%i in ("%USERPROFILE%\Desktop") do set "desktopPath=%%~fi"

rem ƴ������·��
set "fullPath=%desktopPath%\%folderName%"

rem �����ļ���
md "%fullPath%" 2>nul
if errorlevel 1 (
    echo �����޷������ļ��� "%folderName%"
    exit /b 1
)

rem ��ȡISO 8601ʱ�䣨��ʱ����
for /f "tokens=2 delims==." %%a in ('wmic os get localdatetime /value ^| findstr "LocalDateTime"') do (
    set "datetime=%%a"
)

rem ��ʽ����ʱ�䲿��
set "isoTime=!datetime:~0,4!-!datetime:~4,2!-!datetime:~6,2!T!datetime:~8,2!:!datetime:~10,2!:!datetime:~12,2!"

rem ��̬��ȡʱ��ƫ�ƣ�֧������ʱ��
for /f "tokens=*" %%t in ('powershell -Command "(Get-Date).ToString('zzz')"') do (
    set "timezone=%%t"
)

rem ��������ʱ���
set "fullDateTime=!isoTime!!timezone!"

rem ��������ģ��
(
    echo ---
    echo title: "!folderName!"
    echo date: !fullDateTime!
	echo # �����ö�����ֵԽ��Խ��ǰ
    echo sticky: 
    echo # ���·���
	echo # cover: 
	echo # ���·���
	echo categories: 
	echo   - Ĭ�Ϸ���
	echo # ���±�ǩ
	echo tags:
    echo   - hexo
    echo ---
	echo.
) > "%fullPath%\index.md"

if exist "%fullPath%\index.md" (
    echo �ɹ���������ģ�壺
    echo ·����%fullPath%
    echo ʱ�䣺!fullDateTime!
) else (
    echo ����ģ���ļ�����ʧ��
)

	echo ���´����ɹ������ڴ�typora.exe�༭��...

	rem �򿪼��±��༭���༭�´���������
	set articlePath=%fullPath%\index.md
	if not exist "%articlePath%" (
		echo �����ļ�δ��ȷ���ɣ����� Hexo ���á�
		pause >nul
		goto hugo_commands
	)

	rem start "" "notepad.exe" "%articlePath%"
	start "" "typora.exe" "%articlePath%"
	if %errorlevel% neq 0 (
		echo �޷���typora.exe�༭��������typora.exe�Ƿ�װ��
		pause >nul
	)
	echo ����typora.exe�б༭���£��༭��ɺ���������ز˵���

endlocal


