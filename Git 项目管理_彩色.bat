@echo off
rem �����ӳٻ���������չ�������ڴ��������ȷ��������Ķ�̬�仯
setlocal enabledelayedexpansion

REM ������ɫΪ��ɫ������Ĭ������ɫ����
COLOR 0A
CLS
PROMPT $P$G

:init
rem �����������Ŀ¼������Ϊ�û������µ�GitHub�ļ���
set "baseDir=%USERPROFILE%\Desktop\GitHub"
echo ��������Ŀ¼: %baseDir%

:menu
rem ��������ʾ���˵�
cls
rem ������ʱ�� PowerShell �ű��ļ�
(
    echo Write-Host '*********************************************' -ForegroundColor Yellow
    echo Write-Host '*              Git ��Ŀ����                 *' -ForegroundColor Green
    echo Write-Host '*********************************************' -ForegroundColor Yellow
    echo Write-Host '* 1. Git_����˵�                           *' -ForegroundColor Cyan
    echo Write-Host '* 2. Hugo_����˵�                          *' -ForegroundColor Magenta
    echo Write-Host '* 3. ��Ŀ_�ύ����                          *' -ForegroundColor Red
    echo Write-Host '* 4. ��Ŀ_��ȡ����                          *' -ForegroundColor Blue
    echo Write-Host '* 5. ��Ŀ_���±�ǩ                          *' -ForegroundColor DarkYellow
    echo Write-Host '* 0. �˳�                                   *' -ForegroundColor White
    echo Write-Host '*********************************************' -ForegroundColor Yellow
) > temp.ps1
rem ִ����ʱ�� PowerShell �ű��ļ�
powershell -ExecutionPolicy Bypass -File temp.ps1

rem ɾ����ʱ�� PowerShell �ű��ļ�
del temp.ps1

rem ��ʾ�û�����ѡ��
set /p choice=����������ѡ��0 - 9����

rem �����û�������ת����Ӧ�Ĺ���ģ��
call :handle_choice %choice%
goto menu

::--------------------------
:: ����ģ��
::--------------------------

:handle_choice
if "%~1"=="1" goto git_menu
if "%~1"=="2" goto hugo_commands
if "%~1"=="3" goto submenu
if "%~1"=="4" goto Pull_updates
if "%~1"=="5" goto update_tags
if "%~1"=="0"  (
    echo �����˳�...
    goto exit_script
)

echo ��Ч��ѡ�������루0 - 9��֮������֡�
timeout /t 2 >nul
goto menu

rem =====================================================
:git_menu
rem ��������ʾ Git �����Ӳ˵�
cls
(
    echo Write-Host '*********************************************' -ForegroundColor Yellow
    echo Write-Host '*               Git ����˵�                *' -ForegroundColor Green
    echo Write-Host '*********************************************' -ForegroundColor Yellow
    echo Write-Host '1. ��װ Git �Թ���ԱȨ��                    *' -ForegroundColor Cyan
    echo Write-Host '2. �鿴 Git �汾                            *' -ForegroundColor Magenta
    echo Write-Host '3. ��¡ Git �ֿ�                            *' -ForegroundColor DarkCyan
    echo Write-Host '4. ���� Git �û���                          *' -ForegroundColor DarkGreen
    echo Write-Host '5. ���� Git �û�����                        *' -ForegroundColor DarkRed
    echo Write-Host '6. ���� Git ����                            *' -ForegroundColor DarkYellow
    echo Write-Host '9. �������˵�                               *' -ForegroundColor DarkBlue
    echo Write-Host '0. �˳�                                     *' -ForegroundColor White
    echo Write-Host '*********************************************' -ForegroundColor Yellow
) > temp.ps1
powershell -ExecutionPolicy Bypass -File temp.ps1
del temp.ps1

set /p choice="���������ѡ�� (0 - 9): "

if "%choice%"=="1" call :install_git && goto git_menu
if "%choice%"=="2" call :check_git_version && goto git_menu
if "%choice%"=="3" call :clone_git_repo && goto git_menu
if "%choice%"=="4" call :set_user_name && goto git_menu
if "%choice%"=="5" call :set_user_email && goto git_menu
if "%choice%"=="6" call :set_git_proxy && goto git_menu
if "%choice%"=="9" goto menu
if "%choice%"=="0"  (
    echo �����˳�...
    goto exit_script
)

echo ��Ч��ѡ�������루0 - 9��֮������֡�
timeout /t 2 >nul
goto git_menu

rem ========================= ��װ Git �Թ���ԱȨ�� ============================
:install_git
    REM ��� winget �Ƿ����
    winget --version >nul 2>&1
    if %errorlevel% neq 0 (
        echo winget �����ã���ȷ�����ϵͳ֧�ֲ�����ȷ��װ winget��
        pause
        exit /b
    )

    echo ���ڳ����Թ���ԱȨ�ް�װ Git�����Ժ�...
    powershell -Command "Start-Process powershell -Verb runAs -ArgumentList 'winget install --id Git.Git -e --source winget -h'" > install_log.txt 2>&1
    if %errorlevel% neq 0 (
        echo Git ��װʧ�ܣ�
    ) else (
        echo Git ��װ�ɹ���
    )
    pause
    exit /b

rem ========================= �鿴 Git �汾 ============================
:check_git_version
    echo ���ڲ鿴 Git �汾...
    git --version
    if %errorlevel% neq 0 (
        echo �޷���ȡ Git �汾��Ϣ������ Git δ��װ��
    )
    pause
    exit /b

rem ========================= ��¡ Git �ֿ� ============================
:clone_git_repo
    REM ��ʾ�û����� Git �ֿ�� URL
    set /p repoUrl="������ Git �ֿ�� URL: "
    REM ����Ƿ������� URL
    if "%repoUrl%"=="" (
        echo δ������Ч�� URL�����������нű���������ȷ�� URL��
        pause
        exit /b
    )
    REM ʹ�� git clone ��¡�ֿ�
    echo ���ڿ�¡�ֿ⣬���Ժ�...
    git clone %repoUrl%
    REM ����¡�Ƿ�ɹ�
    if %errorlevel% neq 0 (
        echo ��¡ʧ�ܣ����� URL �Ƿ���ȷ���������ӡ�
    ) else (
        echo ��¡�ɹ���
    )
    pause
    exit /b

rem ========================= ���� Git �û��� ============================
:set_user_name
    set /p userName="�������û���: "
    if "%userName%"=="" (
        echo δ������Ч���û��������������нű���������ȷ���û�����
        pause
        exit /b
    )
    git config --global user.name "%userName%"
    echo �û���������Ϊ %userName%
    pause
    exit /b

rem ========================= ���� Git �û����� ============================
:set_user_email
    set /p userEmail="�������û�����: "
    if "%userEmail%"=="" (
        echo δ������Ч���û����䣬���������нű���������ȷ���û����䡣
        pause
        exit /b
    )
    git config --global user.email "%userEmail%"
    echo �û�����������Ϊ %userEmail%
    pause
    exit /b

rem ========================= ���� Git ���� ============================
:set_git_proxy
    git config --global --unset http.proxy
    git config --global --unset https.proxy
	echo Git ȡ����ʷ���óɹ�
	
    git config --global http.proxy 127.0.0.1:7890
    git config --global https.proxy 127.0.0.1:7890
    echo Git ����������Ϊ http://127.0.0.1:7890 �� https://127.0.0.1:7890
    pause
    exit /b

rem ======================== Hugo_����˵� =============================
:hugo_commands
rem ��������ʾhugo�����Ӳ˵�
cls
(
    echo Write-Host '*********************************************' -ForegroundColor Yellow
    echo Write-Host '*             Hugo_����˵�                 *' -ForegroundColor Green
    echo Write-Host '*********************************************' -ForegroundColor Yellow
    echo Write-Host '* 1. ��װ hugo                              *' -ForegroundColor Cyan
    echo Write-Host '* 2. �鿴 hugo �汾                         *' -ForegroundColor Magenta
    echo Write-Host '* 3. �½�����                               *' -ForegroundColor DarkCyan
    echo Write-Host '* 4. ������Ŀ¼                           *' -ForegroundColor DarkGreen
    echo Write-Host '* 5. ���� hugo                              *' -ForegroundColor DarkRed
    echo Write-Host '* 6. ������� :1313                       *' -ForegroundColor DarkYellow
    echo Write-Host '* 7. ���� hugo ����                       *' -ForegroundColor DarkBlue
    echo Write-Host '* 9. �������˵�                             *' -ForegroundColor White
    echo Write-Host '* 0. �˳�                                   *' -ForegroundColor Gray
    echo Write-Host '*********************************************' -ForegroundColor Yellow
) > temp.ps1
powershell -ExecutionPolicy Bypass -File temp.ps1
del temp.ps1

rem ��ʾ�û�����������
set /p subchoice=�����������ţ�0 - 9����

call :handle_hugo_choice %subchoice%
goto hugo_commands

:handle_hugo_choice
if "%~1"=="1" call :install_hugo && goto hugo_commands
if "%~1"=="2" call :hugo_v && goto hugo_commands
if "%~1"=="3" call :create_article && goto hugo_commands
if "%~1"=="4" call :post_hugo && goto hugo_commands
if "%~1"=="5" call :run_hugo && goto hugo_commands
if "%~1"=="6" call :open_browser && goto hugo_commands
if "%~1"=="7" call :run_hugo_link && goto hugo_commands
if "%~1"=="9" goto menu
if "%~1"=="0"  (
    echo �����˳�...
    goto exit_script
)

echo ��Ч��ѡ�������루0 - 9��֮������֡�
timeout /t 2 >nul
goto hugo_commands

rem =================== ��װ hugo =====================
:install_hugo
    REM ��� winget �Ƿ����
    winget --version >nul 2>&1
    if %errorlevel% neq 0 (
        echo winget �����ã���ȷ�����ϵͳ֧�ֲ�����ȷ��װ winget��
        pause
        exit /b
    )

    echo ���ڳ����Թ���ԱȨ�ް�װ Hugo�����Ժ�...
    powershell -Command "Start-Process powershell -Verb runAs -ArgumentList 'winget install --id Hugo.Hugo.Extended -e --source winget'" > install_log.txt 2>&1
    if %errorlevel% neq 0 (
        echo Hugo ��װʧ�ܣ�
    ) else (
        echo Hugo ��װ�ɹ���
    )
    pause
    exit /b

rem ================ �鿴 hugo �汾 ========================
:hugo_v
rem ����һ���µ������д��ڲ�����hugo������
start cmd /k "hugo version"
pause >nul
exit /b

rem ================= �½����� =======================
:create_article
rem ��ʾ�û�������������
set /p name=�������������֣�
rem �л���hugo��Ŀ�ĸ�Ŀ¼
call :change_dir "%baseDir%\hugo-main" || (
    echo �޷��л���hugo��Ŀ��Ŀ¼������·����
    pause >nul
    goto menu
)
rem ʹ��hugo�����������
call hugo new "post/%name%.md"
if %errorlevel% neq 0 (
    echo ���´���ʧ�ܣ�����Hugo���û�·����
    pause >nul
    goto menu
)
echo ���´����ɹ������ڴ�notepad.exe�༭��...
rem �򿪼��±��༭���༭�´���������
start "" "notepad.exe" "%baseDir%\hugo-main\content\post\%name%.md"
if %errorlevel% neq 0 (
    echo �޷���notepad.exe�༭��������notepad.exe�Ƿ�װ��
    pause >nul
)
echo ����notepad.exe�б༭���£��༭��ɺ���������ز˵���
pause >nul
exit /b

rem ================== ������Ŀ¼ ======================
:post_hugo
:: ����Ŀ��Ŀ¼��ʹ�� %USERPROFILE% ʹ·��ͨ�ã�
start "" "%baseDir%\hugo-main\content\post"
pause >nul
exit /b

rem ================== ���� hugo ======================
:run_hugo
call :change_dir "%baseDir%\hugo-main" || (
    echo �޷��л���hugo��Ŀ��Ŀ¼������·����
    pause >nul
    goto menu
)
rem ����һ���µ������д��ڲ�����hugo������
start cmd /k "hugo server -D"
pause >nul
exit /b

rem ================== ������� :1313 ======================
:open_browser
echo ���ط������������������ http://localhost:1313/��������򿪡�
timeout /t 2 >nul
echo ��������Զ��򿪱���Hugoҳ�档
rem ����������ʱ���hugo������
start "" "http://localhost:1313"
pause >nul
exit /b

rem ================== ���� hugo ����   ======================
:run_hugo_link
call :change_dir "%baseDir%\hugo-main" || (
    echo �޷��л���hugo��Ŀ��Ŀ¼������·����
    pause >nul
    goto menu
)
rem ����һ���µ������д��ڲ�����hugo������
start cmd /k "hugo server -D"
echo ���ط������������������ http://localhost:1313/����������ڷ�����������5�����Զ��򿪡�
timeout /t 5 >nul
echo ��������Զ��򿪱���Hugoҳ�档
rem ����������ʱ���hugo������
start "" "http://localhost:1313"
pause >nul
exit /b


rem ======================= GitHub ��Ŀ�ύ ==============================
:submenu
rem ��������ʾ��Ŀ�ύ�Ӳ˵�
cls
(
    echo Write-Host '*********************************************' -ForegroundColor Yellow
    echo Write-Host '*            GitHub ��Ŀ�ύ                *' -ForegroundColor Green
    echo Write-Host '*********************************************' -ForegroundColor Yellow
    echo Write-Host '* 1. ��Ŀ�ύ��hugo-main                    *' -ForegroundColor Cyan
    echo Write-Host '* 2. ��Ŀ�ύ��music                        *' -ForegroundColor Magenta
    echo Write-Host '* 3. ��Ŀ�ύ��file                         *' -ForegroundColor DarkCyan
    echo Write-Host '* 4. ��Ŀ�ύ��bat                          *' -ForegroundColor DarkGreen
    echo Write-Host '* 5. ��Ŀ�ύ��random-pic-api               *' -ForegroundColor DarkRed
    echo Write-Host '* 6. ��Ŀ�ύ��compose                      *' -ForegroundColor DarkYellow
    echo Write-Host '* 7. ��Ŀ�ύ��sh                           *' -ForegroundColor DarkBlue
    echo Write-Host '* 9. �������˵�                             *' -ForegroundColor White
    echo Write-Host '* 0. �˳�                                   *' -ForegroundColor Gray
    echo Write-Host '*********************************************' -ForegroundColor Yellow
) > temp.ps1
powershell -ExecutionPolicy Bypass -File temp.ps1
del temp.ps1

rem ��ʾ�û�������Ŀ���
set /p subchoice=��������Ŀ��ţ�0-9����

call :handle_submenu_choice %subchoice%
goto submenu

:handle_submenu_choice
if "%~1"=="1" set "REPO_PATH=%baseDir%\hugo-main" && call :ValidateRepoAndCommit && goto submenu
if "%~1"=="2" set "REPO_PATH=%baseDir%\music" && call :ValidateRepoAndCommit && goto submenu
if "%~1"=="3" set "REPO_PATH=%baseDir%\file" && call :ValidateRepoAndCommit && goto submenu
if "%~1"=="4" set "REPO_PATH=%baseDir%\bat" && call :ValidateRepoAndCommit && goto submenu
if "%~1"=="5" set "REPO_PATH=%baseDir%\random-pic-api" && call :ValidateRepoAndCommit && goto submenu
if "%~1"=="6" set "REPO_PATH=%baseDir%\compose" && call :ValidateRepoAndCommit && goto submenu
if "%~1"=="7" set "REPO_PATH=%baseDir%\sh" && call :ValidateRepoAndCommit && goto submenu
if "%~1"=="9" goto menu
if "%~1"=="0" (
    echo �����˳�...
    goto exit_script
)

echo ��Ч��ѡ�������루0 - 9��֮������֡�
timeout /t 2 >nul
goto submenu

:ValidateRepoAndCommit
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
    exit /b 1
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
exit /b 0

:ShowMessage
ECHO ============================================
ECHO %~1
ECHO ============================================
ECHO.
exit /b 0

:ShowError
ECHO ============================================
ECHO %~1
ECHO ============================================
pause
exit /b 0

:AddChanges
CALL :ShowMessage "����������и���..."
git add .
IF ERRORLEVEL 1 (
    CALL :ShowError "�����޷�����ļ������� Git �ֿ⡣"
    exit /b 1
)
exit /b 0

:CommitChanges
CALL :ShowMessage "�����ύ����..."
git commit -m "update"
IF ERRORLEVEL 1 (
    CALL :ShowError "�����ύʧ�ܣ����� Git �ֿ⡣"
    exit /b 1
)
exit /b 0

:PushChanges
CALL :ShowMessage "�������͸��ĵ�Զ�ֿ̲�..."
git push
IF ERRORLEVEL 1 (
    CALL :ShowError "��������ʧ�ܣ������������ӻ�Զ�����á�"
    exit /b 1
)
exit /b 0

rem =====================================================
:update_tags
rem ��������ʾ��Ŀ���±�ǩ�Ӳ˵�
cls
(
    echo Write-Host '*********************************************' -ForegroundColor Yellow
    echo Write-Host '*               ��Ŀ���±�ǩ                *' -ForegroundColor Green
    echo Write-Host '*********************************************' -ForegroundColor Yellow
    echo Write-Host '* 1. ���±�ǩ��hugo-main                    *' -ForegroundColor Cyan
    echo Write-Host '* 2. ���±�ǩ��music                        *' -ForegroundColor Magenta
    echo Write-Host '* 3. ���±�ǩ��file                         *' -ForegroundColor DarkCyan
    echo Write-Host '* 4. ���±�ǩ��random-pic-api               *' -ForegroundColor DarkGreen
    echo Write-Host '* 5. ���±�ǩ��bat                          *' -ForegroundColor DarkRed
    echo Write-Host '* 6. ���±�ǩ��sh                           *' -ForegroundColor DarkYellow
    echo Write-Host '* 9. �������˵�                             *' -ForegroundColor DarkBlue
    echo Write-Host '* 0. �˳�                                   *' -ForegroundColor White
    echo Write-Host '*********************************************' -ForegroundColor Yellow
) > temp.ps1
powershell -ExecutionPolicy Bypass -File temp.ps1
del temp.ps1

rem ��ʾ�û�����������
set /p subchoice=�����������ţ�0 - 9����

call :handle_update_tags_choice %subchoice%
goto update_tags

:handle_update_tags_choice
if "%~1"=="1" set "projectDir=%baseDir%\hugo-main" && call :update_project_tags && goto update_tags
if "%~1"=="2" set "projectDir=%baseDir%\music" && call :update_project_tags && goto update_tags
if "%~1"=="3" set "projectDir=%baseDir%\file" && call :update_project_tags && goto update_tags
if "%~1"=="4" set "projectDir=%baseDir%\random-pic-api" && call :update_project_tags && goto update_tags
if "%~1"=="5" set "projectDir=%baseDir%\bat" && call :update_project_tags && goto update_tags
if "%~1"=="6" set "projectDir=%baseDir%\sh" && call :update_project_tags && goto update_tags
if "%~1"=="9" goto menu
if "%~1"=="0"  (
    echo �����˳�...
    goto exit_script
)

echo ��Ч��ѡ�������루0 - 9��֮������֡�
timeout /t 2 >nul
goto update_tags

:update_project_tags
call :change_dir "%projectDir%" || (
    echo �޷��л�����ĿĿ¼������·����
    pause >nul
    exit /b
)

rem ����ִ�е�����
call :git_add_and_commit
call :git_push
call :delete_tag v1.0.0
call :create_and_push_tag v1.0.0 "Recreate tags for the latest submission"
pause >nul
exit /b

:git_add_and_commit
echo ===========================================
echo ����������и���...
rem ��������ļ����ݴ���
git add .
if %errorlevel% neq 0 (
    echo "git add ." ִ��ʧ�ܣ���������Git���û��ļ�Ȩ�ޡ�
    pause >nul
    exit /b
)
echo ===========================================
echo �����ύ���ģ��ύ��ϢΪ "update"...
rem �ύ�ݴ������ļ������زֿ�
git commit -m "update"
if %errorlevel% neq 0 (
    echo "git commit -m 'update'" ִ��ʧ�ܣ���������Git���û��������ӡ�
    pause >nul
    exit /b
)
echo ===========================================
exit /b

:git_push
echo ���ڽ��ύ���͵�Զ�ֿ̲�...
rem ���ͱ��زֿ���ύ��Զ�ֿ̲�
git push
if %errorlevel% neq 0 (
    echo "git push" ִ��ʧ�ܣ���������Git���û��������ӡ�
    pause >nul
    exit /b
)
echo ===========================================
exit /b

:delete_tag
call :delete_local_tag %1
call :delete_remote_tag %1
call :check_tag_deletion %1
exit /b

:delete_local_tag
echo ����ɾ�����ر�ǩ %1...
rem ɾ�����ر�ǩ
git tag -d %1
if %errorlevel% neq 0 (
    echo ���ر�ǩ %1 ɾ��ʧ�ܣ����ֶ���顣
    pause >nul
    exit /b
)
echo ===========================================
exit /b

:delete_remote_tag
echo ����ɾ��Զ�̱�ǩ %1...
rem ɾ��Զ�̱�ǩ
git push origin :refs/tags/%1
if %errorlevel% neq 0 (
    echo Զ�̱�ǩ %1 ɾ��ʧ�ܣ����ֶ���顣
    pause >nul
    exit /b
)
echo ===========================================
exit /b

:check_tag_deletion
rem ����ǩ�Ƿ�ɾ���ɹ�
git tag -l | findstr /I "%1" >nul
IF %ERRORLEVEL% EQU 0 (
    echo Զ�̱�ǩ %1 ɾ��ʧ�ܣ����ֶ���顣
) ELSE (
    echo Զ�̱�ǩ %1 ɾ���ɹ���
)
echo ===========================================
exit /b

:create_and_push_tag
call :create_new_tag %1 "%2"
call :push_new_tag %1
call :check_tag_push %1
exit /b

:create_new_tag
echo ���ڴ����±�ǩ %1����ǩ��ϢΪ "%2"...
rem �����±�ǩ
git tag -a %1 -m "%2"
if %errorlevel% neq 0 (
    echo �±�ǩ %1 ����ʧ�ܣ����ֶ���顣
    pause >nul
    exit /b
)
echo ===========================================
exit /b

:push_new_tag
echo ���ڽ��µı�ǩ %1 ���͵�Զ�ֿ̲�...
rem �����±�ǩ��Զ�ֿ̲�
git push origin %1
if %errorlevel% neq 0 (
    echo ��ǩ %1 ����ʧ�ܣ����ֶ���顣
    pause >nul
    exit /b
)
echo ===========================================
exit /b

:check_tag_push
rem ����ǩ�Ƿ����ͳɹ�
git tag -l | findstr /I "%1" >nul
IF %ERRORLEVEL% EQU 0 (
    echo ��ǩ %1 ���ͳɹ���
) ELSE (
    echo ��ǩ %1 ����ʧ�ܣ����ֶ���顣
)
echo ===========================================
exit /b

:change_dir
cd /d "%~1"
if %errorlevel% neq 0 (
    exit /b 1
)
exit /b 0

rem ================================================================
:Pull_updates
rem ��������ʾ��Ŀ��ȡ�����Ӳ˵�
cls
(
    echo Write-Host '*********************************************' -ForegroundColor Yellow
    echo Write-Host '*          ��ѡ��Ҫ��ȡ���µ���Ŀ           *' -ForegroundColor Green
    echo Write-Host '*********************************************' -ForegroundColor Yellow
    echo Write-Host '* 1. ��ȡ���£�hugo-main                    *' -ForegroundColor Cyan
    echo Write-Host '* 2. ��ȡ���£�music                        *' -ForegroundColor Magenta
    echo Write-Host '* 3. ��ȡ���£�file                         *' -ForegroundColor DarkCyan
    echo Write-Host '* 4. ��ȡ���£�bat                          *' -ForegroundColor DarkGreen
    echo Write-Host '* 5. ��ȡ���£�random-pic-api               *' -ForegroundColor DarkRed
    echo Write-Host '* 6. ��ȡ���£�compose                      *' -ForegroundColor DarkYellow
    echo Write-Host '* 7. ��ȡ���£�sh                           *' -ForegroundColor DarkBlue
    echo Write-Host '* 8. ��ȡ���£�������Ŀ                     *' -ForegroundColor White
    echo Write-Host '* 9. �������˵�                             *' -ForegroundColor Gray
    echo Write-Host '* 0. �˳�                                   *' -ForegroundColor DarkGray
    echo Write-Host '*********************************************' -ForegroundColor Yellow
) > temp.ps1
powershell -ExecutionPolicy Bypass -File temp.ps1
del temp.ps1

rem ��ʾ�û�������Ŀ���
set /p subchoice=��������Ŀ��ţ�0 - 9����

rem �����û�������ת����Ӧ�Ĺ���ģ��
if "%subchoice%"=="1" call :update_single_project "%baseDir%\hugo-main" && goto Pull_updates
if "%subchoice%"=="2" call :update_single_project "%baseDir%\music" && goto Pull_updates
if "%subchoice%"=="3" call :update_single_project "%baseDir%\file" && goto Pull_updates
if "%subchoice%"=="4" call :update_single_project "%baseDir%\bat" && goto Pull_updates
if "%subchoice%"=="5" call :update_single_project "%baseDir%\random-pic-api" && goto Pull_updates
if "%subchoice%"=="6" call :update_single_project "%baseDir%\compose" && goto Pull_updates
if "%subchoice%"=="7" call :update_single_project "%baseDir%\sh" && goto Pull_updates
if "%subchoice%"=="8" call :update_all_projects && goto Pull_updates
if "%subchoice%"=="9" goto menu
if "%subchoice%"=="0"  (
    echo �����˳�...
    goto exit_script
)

echo ��Ч��ѡ�������루0 - 9��֮������֡�
timeout /t 2 >nul
goto Pull_updates

:update_single_project
SET "REPO_PATH=%~1"
REM ���Ŀ��Ŀ¼�Ƿ����
IF NOT EXIST "%REPO_PATH%" (
    echo ===========================================
    echo ����Ŀ¼ %REPO_PATH% �����ڣ�����·����
    echo ===========================================
    pause
    EXIT /B 1
)
REM �л���Ŀ��Ŀ¼
CD /D "%REPO_PATH%"
REM ����Ƿ�Ϊ��Ч�� Git �ֿ�
IF NOT EXIST .git (
    echo ===========================================
    echo ����Ŀ¼ %REPO_PATH% ����һ����Ч�� Git �ֿ⡣
    echo ===========================================
    pause
    EXIT /B 1
)
REM ȷ����ǰ��֧�� main ��֧
git rev-parse --abbrev-ref HEAD >nul 2>&1
IF ERRORLEVEL 1 (
    echo ===========================================
    echo �����޷���⵱ǰ��֧����ȷ������һ����Ч�� Git �ֿ⡣
    echo ===========================================
    pause
    EXIT /B 1
)
SET CURRENT_BRANCH=main
git checkout %CURRENT_BRANCH% >nul 2>&1
IF ERRORLEVEL 1 (
    echo ===========================================
    echo �����޷��л�����֧ %CURRENT_BRANCH%�������֧���ơ�
    echo ===========================================
    pause
    EXIT /B 1
)
REM ���Զ�ֿ̲��Ƿ��и���
echo ===========================================
echo ���ڼ��Զ�ֿ̲��Ƿ��и���...
git fetch origin %CURRENT_BRANCH%
IF NOT "!ERRORLEVEL!"=="0" (
    echo �����޷���Զ�ֿ̲��ȡ���£������������ӻ�Զ�����á�
    pause
    EXIT /B 1
)
REM �Ƚϱ��ط�֧��Զ�̷�֧
SET REMOTE_BRANCH=origin/%CURRENT_BRANCH%
git rev-list --left-right --count %REMOTE_BRANCH%...%CURRENT_BRANCH% >nul 2>&1
FOR /F "tokens=1,2 delims=	" %%A IN ('git rev-list --left-right --count %REMOTE_BRANCH%...%CURRENT_BRANCH%') DO (
    SET BEHIND_COUNT=%%A
    SET AHEAD_COUNT=%%B
)
echo ===========================================
echo ���ط�֧��Զ�̷�֧�Ĳ��죺
echo ��ǰ��֧���Զ�̷�֧ !BEHIND_COUNT! ���ύ��
echo ��ǰ��֧����Զ�̷�֧ !AHEAD_COUNT! ���ύ��
echo ===========================================
REM ����и��£�����ȡ����
IF !BEHIND_COUNT! GTR 0 (
    echo ���ڴ�Զ�ֿ̲���ȡ����...
    git pull origin %CURRENT_BRANCH%
    IF "!ERRORLEVEL!"=="0" (
        echo ���³ɹ���
    ) ELSE (
        echo ������ȡ����ʧ�ܣ����ֶ���顣
    )
) ELSE (
    echo ���ط�֧�Ѿ�������״̬��������¡�
)
echo ===========================================
echo ������Ŀ���½ű�ִ����ɡ�
pause
EXIT /B 0

:update_all_projects
cd /d "%baseDir%"
rem ���Ŀ¼�Ƿ����
if not exist "%baseDir%" (
    echo ָ����Ŀ¼ "%baseDir%" �����ڡ�
    pause
    exit /b 1
)
rem ========================= ��ȡ���£�������Ŀ ==================================
rem ����Ŀ¼�µ������ļ���
echo ���ڼ�� GitHub �ļ����е���Ŀ...
echo.
for /d %%F in ("%baseDir%\*") do (
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
echo ������Ŀ������ɡ�


rem ===========================================================================
:exit_script
echo ��лʹ�ã��ټ���
timeout /t 2 >nul
exit
rem ===========================================================================