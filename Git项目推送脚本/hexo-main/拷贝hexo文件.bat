@echo off
setlocal enabledelayedexpansion

set "source_dir=%USERPROFILE%\Desktop\GitHub\hexo"
set "dest_dir=%USERPROFILE%\Desktop\GitHub\hexo-main"

:: ����Ŀ��Ŀ¼����������ڣ�
if not exist "%dest_dir%" mkdir "%dest_dir%"

:: ���ƶ����ļ�������������ʾ
for %%f in (_config.yml _config.butterfly.yml package.json .gitignore) do (
    xcopy "%source_dir%\%%f" "%dest_dir%\" /Y >nul
    if not errorlevel 1 (
        echo �ɹ������ļ�: %%f
    ) else (
        echo �����ļ� %%f ʧ��
    )
)

:: �����ͻĿ¼��������ϸ������
for %%i in (themes source scaffolds) do (
    set "target_path=%dest_dir%\%%i"
    
    :: ���Ŀ��·���Ƿ����
    if exist "!target_path!" (
        :: ����Ƿ�Ϊ�ļ�
        if not exist "!target_path!\." (
            echo ���ֳ�ͻ�ļ�: !target_path!
            del /F /Q "!target_path!" >nul 2>&1
            if errorlevel 1 (
                echo ����: �޷�ɾ���ļ������ֶ����������
                exit /b 1
            )
            echo �ļ���ɾ��: !target_path!
        ) else (
            echo Ŀ��Ŀ¼�Ѵ���: !target_path!
        )
    )
    
    :: ����Ŀ¼���������
    xcopy "%source_dir%\%%i" "!target_path!" /E /Y /H /I >nul
    if not errorlevel 1 (
        echo �ɹ�����Ŀ¼: %%i
    ) else (
        echo ����Ŀ¼ %%i ʧ��
    )
)

endlocal
echo ȫ���ļ���Ŀ¼�ѳɹ����ƣ�
pause