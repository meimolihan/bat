@echo off
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

powershell -Command ^
"Clear-Host; ^
    Write-Host '*********************************************' -ForegroundColor Yellow; ^
    Write-Host '*************  Git ����˵�  ****************' -ForegroundColor Green; ^
    Write-Host '*********************************************' -ForegroundColor Yellow; ^
    Write-Host '* 1. Git_����˵�                           *' -ForegroundColor Cyan; ^
    Write-Host '* 2. Hugo_����˵�                          *' -ForegroundColor Magenta; ^
    Write-Host '* 3. ��Ŀ_�ύ����                          *' -ForegroundColor Red; ^
    Write-Host '* 4. ��Ŀ_��ȡ����                          *' -ForegroundColor Blue; ^
    Write-Host '* 5. ��Ŀ_���±�ǩ                          *' -ForegroundColor DarkYellow; ^
    Write-Host '* 6. ��_ͼ��Ŀ¼                          *' -ForegroundColor DarkGreen; ^
    Write-Host '* 0. �˳�                                   *' -ForegroundColor White; ^
    Write-Host '*********************************************' -ForegroundColor Yellow"

	rem ��ʾ�û�������
	set /p choice="������������ (0 - 9): "

:handle_choice
	if "%choice%"=="1" goto git_menu
	if "%choice%"=="2" goto hugo_commands
	if "%choice%"=="3" goto submenu
	if "%choice%"=="4" goto Pull_updates
	if "%choice%"=="5" goto update_tags
	if "%choice%"=="6" goto dakai_tucuang
	if "%choice%"=="0"  (
		echo �����˳�...
		goto exit_script
	)

	echo ��Ч�ı�ţ������루0 - 9��֮������֡�
	timeout /t 2 >nul
	goto menu

rem ==========================  һ ������˵�  ===========================
:git_menu
	rem ��������ʾ Git �����Ӳ˵�
	cls

powershell -Command ^
"Clear-Host; ^
    Write-Host '*********************************************' -ForegroundColor Yellow; ^
    Write-Host '*****************  ����˵�  ****************' -ForegroundColor Green; ^
    Write-Host '*********************************************' -ForegroundColor Yellow; ^
	Write-Host '* 1. ��װ scoop                             *' -ForegroundColor Cyan; ^
    Write-Host '* 2. ��װ Git                               *' -ForegroundColor DarkYellow; ^
	Write-Host '* 3. ���� Git �汾                          *' -ForegroundColor Magenta; ^
    Write-Host '* 4. �鿴 Git �汾                          *' -ForegroundColor DarkCyan; ^
    Write-Host '* 5. ��¡ Git �ֿ�                          *' -ForegroundColor DarkGreen; ^
    Write-Host '* 6. ���� Git �û���������                  *' -ForegroundColor Cyan; ^
    Write-Host '* 7. ���� Git ����                          *' -ForegroundColor DarkYellow; ^
	Write-Host '* 8. ȡ�� Git ����                          *' -ForegroundColor DarkYellow; ^
    Write-Host '* 9. �������˵�                             *' -ForegroundColor White; ^
    Write-Host '* 0. �˳�                                   *' -ForegroundColor White; ^
    Write-Host '*********************************************' -ForegroundColor Yellow"

	set /p choice="������������ (0 - 9): "
	if "%choice%"=="1" call :install_scoop && goto git_menu
	if "%choice%"=="2" call :install_git && goto git_menu
	if "%choice%"=="3" call :update_git && goto git_menu
	if "%choice%"=="4" call :check_git_version && goto git_menu
	if "%choice%"=="5" call :clone_git_repo && goto git_menu
	if "%choice%"=="6" call :set_user_name && goto git_menu
	if "%choice%"=="7" call :set_git_proxy && goto git_menu
	if "%choice%"=="8" call :unset_git_proxy && goto git_menu
	if "%choice%"=="9" goto menu
	if "%choice%"=="0"  (
		echo �����˳�...
		goto exit_script
	)

	echo ��Ч�ı�ţ������루0 - 9��֮������֡�
	timeout /t 2 >nul
	goto git_menu

rem ========================= ��1����װ scoop �Թ���ԱȨ�� ============================
:install_scoop

	REM ���� scoop �� main �洢ͰĿ¼
	set "scoop_main_dir=%USERPROFILE%\scoop\buckets\main"

	REM �����ǰϵͳ���������е� USERPROFILE �ͼ���õ��� scoop_main_dir
	echo ��ǰϵͳ���������е� USERPROFILE: %USERPROFILE%
	echo ����õ��� scoop_main_dir: %scoop_main_dir%

	REM ��� Git �Ƿ����
	where git >nul 2>&1
	if !errorlevel! neq 0 (
		call :handle_error "Git δ��װ����δ��ӵ�ϵͳ�������������Ȱ�װ Git �����û���������"
		exit /b
	)
	echo Git �Ѱ�װ�����õ�ϵͳ����������

	REM ���Ŀ¼�Ƿ����
	if not exist "%scoop_main_dir%" (
		call :handle_error "ָ����Ŀ¼ %scoop_main_dir% �����ڡ�"
		exit /b
	)
	echo Ŀ¼ %scoop_main_dir% ���ڡ�

	REM ���Ŀ¼�Ƿ�Ϊ Git �ֿ�
	if not exist "%scoop_main_dir%\.git" (
		call :handle_error "ָ����Ŀ¼ %scoop_main_dir% ����һ����Ч�� Git �ֿ⡣"
		exit /b
	)
	echo Ŀ¼ %scoop_main_dir% ��һ����Ч�� Git �ֿ⡣

	REM ��Ӱ�ȫĿ¼����
	echo ������Ӱ�ȫĿ¼����...
	git config --global --add safe.directory "%scoop_main_dir%"
	if !errorlevel! neq 0 (
		call :handle_error "��Ӱ�ȫĿ¼����ʧ�ܣ����� Git ����Ȩ�ޡ�"
		exit /b
	)
	echo ��ȫĿ¼������ӳɹ���

	REM �л��� scoop �� main �洢ͰĿ¼
	echo �����л���Ŀ¼: %scoop_main_dir%
	cd /d "%scoop_main_dir%"
	if !errorlevel! neq 0 (
		call :handle_error "�л�Ŀ¼ʧ�ܣ�����·���Ƿ���ȷ��"
		exit /b
	)
	echo �ɹ��л���Ŀ¼: %scoop_main_dir%

	REM ִ�� git pull ������ȡ���´���
	echo ������ȡ���´���...
	git pull origin master
	if !errorlevel! neq 0 (
		call :handle_error "��ȡ���´���ʧ�ܣ���������� Git �ֿ�״̬��"
		exit /b
	)
	echo ���´�����ȡ�ɹ���

    echo ������ 3 ��󷵻� ...
	powershell -Command "Start-Sleep -Seconds 3"
	goto git_menu  rem ����Ҫ���صĲ˵�
	exit /b

rem ========================= ��2����װ Git �Թ���ԱȨ�� ============================
:install_git
    REM ��� winget �Ƿ����
    winget --version >nul 2>&1
    if %errorlevel% neq 0 (
        echo winget �����ã���ȷ�����ϵͳ֧�ֲ�����ȷ��װ winget��
        pause
        exit /b
    )

    echo ���ڳ����Թ���ԱȨ�ް�װ Git�����Ժ�...
    powershell -Command "Start-Process powershell -Verb runAs -ArgumentList 'winget install --id Git.Git -e --source winget -h'"
    if %errorlevel% neq 0 (
        echo Git ��װʧ�ܣ�
    ) else (
        echo Git ��װ�ɹ���
    )

    REM ��� Git �Ƿ�װ�ɹ�����ӡ�汾��
    git --version >nul 2>&1
    if %errorlevel% equ 0 (
        for /f "tokens=3 delims= " %%a in ('git --version') do (
            set "git_version=%%a"
        )
        if defined git_version (
            echo ��ǰ��װ�� Git �汾��Ϊ��!git_version!
        ) else (
            echo �޷���ȡ Git �汾�ţ����� Git �Ƿ�װ�ɹ���
        )
    ) else (
        echo �޷���ȡ Git �汾�ţ����� Git �Ƿ�װ�ɹ���
    )

    echo ������ 3 ��󷵻� ...
	powershell -Command "Start-Sleep -Seconds 3"
	goto git_menu  rem ����Ҫ���صĲ˵�
	exit /b

endlocal

rem ========================= ��3������ Git �汾 ============================
:update_git
    echo ���ڸ��� Git �汾...
    git update-git-for-windows
    echo ������ 3 ��󷵻� ...
	powershell -Command "Start-Sleep -Seconds 3"
	goto git_menu  rem ����Ҫ���صĲ˵�
	exit /b

rem ========================= ��4���鿴 Git �汾 ============================
:check_git_version
    echo ���ڲ鿴 Git �汾...
    git --version
    if %errorlevel% neq 0 (
        echo �޷���ȡ Git �汾��Ϣ������ Git δ��װ��
    )
    echo ������ 3 ��󷵻� ...
	powershell -Command "Start-Sleep -Seconds 3"
	goto git_menu  rem ����Ҫ���صĲ˵�
	exit /b

rem ========================= ��5����¡ Git �ֿ� ============================
:clone_git_repo
	REM �л���Ŀ��Ŀ¼
	CD /D %baseDir%

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
    echo ������ 3 ��󷵻� ...
	powershell -Command "Start-Sleep -Seconds 3"
	goto git_menu  rem ����Ҫ���صĲ˵�
	exit /b

rem ========================= ��6������ Git �û��������� ============================
:set_user_name
    set /p userName="�������û���: "
    if "%userName%"=="" (
        echo δ������Ч���û��������������нű���������ȷ���û�����
        pause
        exit /b
    )
    git config --global user.name "%userName%"
    echo �û���������Ϊ %userName%
	
	set /p userEmail="�������û�����: "
	if "%userEmail%"=="" (
	    echo δ������Ч���û����䣬���������нű���������ȷ���û����䡣
	    pause
	    exit /b
	)
	git config --global user.email "%userEmail%"
	echo �û�����������Ϊ %userEmail%
	
    echo ������ 3 ��󷵻� ...
	powershell -Command "Start-Sleep -Seconds 3"
	goto git_menu  rem ����Ҫ���صĲ˵�
	exit /b

rem ========================= ��7������ Git ���� ============================
:set_git_proxy
    git config --global --unset http.proxy
    git config --global --unset https.proxy
	echo Git ȡ����ʷ���óɹ�
	
    git config --global http.proxy 127.0.0.1:7890
    git config --global https.proxy 127.0.0.1:7890
    echo Git ����������Ϊ http://127.0.0.1:7890 �� https://127.0.0.1:7890
    echo ������ 3 ��󷵻� ...
	powershell -Command "Start-Sleep -Seconds 3"
	goto git_menu  rem ����Ҫ���صĲ˵�
	exit /b
	
rem ========================= ��8��ȡ�� Git ���� ============================
:unset_git_proxy
    git config --global --unset http.proxy
    git config --global --unset https.proxy
	echo Git ȡ����ʷ���óɹ�
	
    echo ������ 3 ��󷵻� ...
	powershell -Command "Start-Sleep -Seconds 3"
	goto git_menu  rem ����Ҫ���صĲ˵�
	exit /b

rem ======================== �� ��Hugo_����˵� =============================
:hugo_commands
	rem ��������ʾhugo�����Ӳ˵�
	cls

powershell -Command ^
"Clear-Host; ^
    Write-Host '*********************************************' -ForegroundColor Yellow; ^
    Write-Host '*************  Hugo_����˵�  ***************' -ForegroundColor Green; ^
    Write-Host '*********************************************' -ForegroundColor Yellow; ^
	Write-Host '* 1. ��װ scoop                             *' -ForegroundColor DarkBlue; ^
    Write-Host '* 2. ��װ hugo                              *' -ForegroundColor Cyan; ^
    Write-Host '* 3. �鿴 hugo �汾                         *' -ForegroundColor Magenta; ^
    Write-Host '* 4. �½�����                               *' -ForegroundColor DarkCyan; ^
    Write-Host '* 5. ������Ŀ¼                           *' -ForegroundColor DarkGreen; ^
    Write-Host '* 6. ���� hugo                              *' -ForegroundColor DarkRed; ^
    Write-Host '* 7. ������� :1313                       *' -ForegroundColor DarkYellow; ^
    Write-Host '* 8. ���� hugo ����                       *' -ForegroundColor DarkBlue; ^
    Write-Host '* 9. �������˵�                             *' -ForegroundColor White; ^
    Write-Host '* 0. �˳�                                   *' -ForegroundColor White; ^
    Write-Host '*********************************************' -ForegroundColor Yellow"

	rem ��ʾ�û�����������
	set /p choice=�����������ţ�0 - 9����

:handle_hugo_choice
	if "%choice%"=="1" call :install_scoop && goto hugo_commands
	if "%choice%"=="2" call :install_hugo && goto hugo_commands
	if "%choice%"=="3" call :hugo_v && goto hugo_commands
	if "%choice%"=="4" call :create_article && goto hugo_commands
	if "%choice%"=="5" call :post_hugo && goto hugo_commands
	if "%choice%"=="6" call :run_hugo && goto hugo_commands
	if "%choice%"=="7" call :open_browser && goto hugo_commands
	if "%choice%"=="8" call :run_hugo_link && goto hugo_commands
	if "%choice%"=="9" goto menu
	if "%choice%"=="0"  (
		echo �����˳�...
		goto exit_script
	)

	echo ��Ч�ı�ţ������루0 - 9��֮������֡�
	timeout /t 2 >nul
	goto hugo_commands

rem ========================= ��1����װ scoop �Թ���ԱȨ�� ============================
:install_scoop
	REM ���� scoop �� main �洢ͰĿ¼
	set "scoop_main_dir=%USERPROFILE%\scoop\buckets\main"

	REM �����ǰϵͳ���������е� USERPROFILE �ͼ���õ��� scoop_main_dir
	echo ��ǰϵͳ���������е� USERPROFILE: %USERPROFILE%
	echo ����õ��� scoop_main_dir: %scoop_main_dir%

	REM ��� Git �Ƿ����
	where git >nul 2>&1
	if !errorlevel! neq 0 (
		call :handle_error "Git δ��װ����δ��ӵ�ϵͳ�������������Ȱ�װ Git �����û���������"
		exit /b
	)
	echo Git �Ѱ�װ�����õ�ϵͳ����������

	REM ���Ŀ¼�Ƿ����
	if not exist "%scoop_main_dir%" (
		call :handle_error "ָ����Ŀ¼ %scoop_main_dir% �����ڡ�"
		exit /b
	)
	echo Ŀ¼ %scoop_main_dir% ���ڡ�

	REM ���Ŀ¼�Ƿ�Ϊ Git �ֿ�
	if not exist "%scoop_main_dir%\.git" (
		call :handle_error "ָ����Ŀ¼ %scoop_main_dir% ����һ����Ч�� Git �ֿ⡣"
		exit /b
	)
	echo Ŀ¼ %scoop_main_dir% ��һ����Ч�� Git �ֿ⡣

	REM ��Ӱ�ȫĿ¼����
	echo ������Ӱ�ȫĿ¼����...
	git config --global --add safe.directory "%scoop_main_dir%"
	if !errorlevel! neq 0 (
		call :handle_error "��Ӱ�ȫĿ¼����ʧ�ܣ����� Git ����Ȩ�ޡ�"
		exit /b
	)
	echo ��ȫĿ¼������ӳɹ���

	REM �л��� scoop �� main �洢ͰĿ¼
	echo �����л���Ŀ¼: %scoop_main_dir%
	cd /d "%scoop_main_dir%"
	if !errorlevel! neq 0 (
		call :handle_error "�л�Ŀ¼ʧ�ܣ�����·���Ƿ���ȷ��"
		exit /b
	)
	echo �ɹ��л���Ŀ¼: %scoop_main_dir%

	REM ִ�� git pull ������ȡ���´���
	echo ������ȡ���´���...
	git pull origin master
	if !errorlevel! neq 0 (
		call :handle_error "��ȡ���´���ʧ�ܣ���������� Git �ֿ�״̬��"
		exit /b
	)
	echo ���´�����ȡ�ɹ���

    echo ������ 3 ��󷵻� ...
	powershell -Command "Start-Sleep -Seconds 3"
	goto git_menu  rem ����Ҫ���صĲ˵�
	exit /b

rem =================== ��2����װ hugo =====================
:install_hugo
    REM ��� winget �Ƿ����
    winget --version >nul 2>&1
    if %errorlevel% neq 0 (
        echo winget �����ã���ȷ�����ϵͳ֧�ֲ�����ȷ��װ winget��
        rem �ȴ����뷵�ز˵�
	echo ������ 2 ��󷵻� Hugo ����˵�...
	powershell -Command "Start-Sleep -Seconds 2"
	goto hugo_commands  rem ����Ҫ���صĲ˵�
	exit /b
    )

    echo ���ڳ����Թ���ԱȨ�ް�װ Hugo�����Ժ�...
    powershell -Command "Start-Process powershell -Verb runAs -ArgumentList 'winget install --id Hugo.Hugo.Extended -e --source winget'"
    if %errorlevel% neq 0 (
        echo Hugo ��װʧ�ܣ�
    ) else (
        echo Hugo ��װ�ɹ���
    )
    echo ������ 3 ��󷵻� ...
	powershell -Command "Start-Sleep -Seconds 3"
	goto hugo_commands  rem ����Ҫ���صĲ˵�
	exit /b

rem ================ ��3���鿴 hugo �汾 ========================
:hugo_v
	rem ����һ���µ������д��ڲ�����hugo������
	start cmd /k "hugo version"
	echo ������ 3 ��󷵻� ...
	powershell -Command "Start-Sleep -Seconds 2"
	goto hugo_commands  rem ����Ҫ���صĲ˵�
	exit /b

rem ================= ��4���½����� =======================
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
	call hugo new "post\%name%\index.md"
	if %errorlevel% neq 0 (
		echo ���´���ʧ�ܣ�����Hugo���û�·����
		pause >nul
		goto menu
	)

	echo ���´����ɹ������ڴ�typora.exe�༭��...

	rem �򿪼��±��༭���༭�´���������
	set articlePath=%baseDir%\hugo-main\content\post\%name%\index.md
	if not exist "%articlePath%" (
		echo �����ļ�δ��ȷ���ɣ�����Hugo���á�
		pause >nul
		goto menu
	)

	REM start "" "notepad.exe" "%articlePath%"
	start "" "typora.exe" "%articlePath%"
	if %errorlevel% neq 0 (
		echo �޷���typora.exe�༭��������typora.exe�Ƿ�װ��
		pause >nul
	)

	echo ����typora.exe�б༭���£��༭��ɺ���������ز˵���
    echo ������ 3 ��󷵻� ...
	powershell -Command "Start-Sleep -Seconds 2"
	goto hugo_commands  rem ����Ҫ���صĲ˵�
	exit /b

rem ================== ��5��������Ŀ¼ ======================
:post_hugo
	:: ����Ŀ��Ŀ¼��ʹ�� %USERPROFILE% ʹ·��ͨ�ã�
	start "" "%baseDir%\hugo-main\content\post"
	rem �ȴ����뷵�ز˵�
    echo ������ 3 ��󷵻� ...
	powershell -Command "Start-Sleep -Seconds 2"
	goto hugo_commands  rem ����Ҫ���صĲ˵�
	exit /b

rem ================== ��6������ hugo ======================
:run_hugo
	call :change_dir "%baseDir%\hugo-main" || (
		echo �޷��л���hugo��Ŀ��Ŀ¼������·����
		pause >nul
		goto menu
	)
	rem ����һ���µ������д��ڲ�����hugo������
	start cmd /k "hugo server -D"
    echo ������ 3 ��󷵻� ...
	powershell -Command "Start-Sleep -Seconds 2"
	goto hugo_commands  rem ����Ҫ���صĲ˵�
	exit /b

rem ================== ��7��������� :1313 ======================
:open_browser
	echo ���ط������������������ http://localhost:1313/��������򿪡�
	timeout /t 2 >nul
	echo ��������Զ��򿪱���Hugoҳ�档
	rem ����������ʱ���hugo������
	start "" "http://localhost:1313"
    echo ������ 3 ��󷵻� ...
	timeout /t 3 >nul  REM �ȴ� 3 ��
	goto hugo_commands  REM ���ص� Hugo ����˵�
	exit /b

rem ================== ��8������ hugo ����   ======================
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
    echo ������ 3 ��󷵻� ...
	timeout /t 3 >nul
	goto hugo_commands  REM ���ص� Hugo ����˵�
	exit /b


rem =======================  �� ��GitHub ��Ŀ�ύ  ==============================
:submenu
	rem ��������ʾ��Ŀ�ύ�Ӳ˵�
	cls
powershell -Command ^
"Clear-Host; ^
    Write-Host '*********************************************' -ForegroundColor Yellow; ^
    Write-Host '**************  GitHub ��Ŀ�ύ  ************' -ForegroundColor Green; ^
    Write-Host '*********************************************' -ForegroundColor Yellow; ^
    Write-Host '* 1. ��Ŀ�ύ��hugo-main                    *' -ForegroundColor Cyan; ^
    Write-Host '* 2. ��Ŀ�ύ��music                        *' -ForegroundColor Magenta; ^
    Write-Host '* 3. ��Ŀ�ύ��file                         *' -ForegroundColor DarkCyan; ^
    Write-Host '* 4. ��Ŀ�ύ��bat                          *' -ForegroundColor DarkGreen; ^
    Write-Host '* 5. ��Ŀ�ύ��random-pic-api               *' -ForegroundColor DarkRed; ^
    Write-Host '* 6. ��Ŀ�ύ��compose                      *' -ForegroundColor DarkYellow; ^
    Write-Host '* 7. ��Ŀ�ύ��sh                           *' -ForegroundColor DarkBlue; ^
	Write-Host '* 8. ��Ŀ�ύ��������Ŀ                     *' -ForegroundColor Cyan; ^
    Write-Host '* 9. �������˵�                             *' -ForegroundColor White; ^
    Write-Host '* 0. �˳�                                   *' -ForegroundColor White; ^
    Write-Host '*********************************************' -ForegroundColor Yellow"

	rem ��ʾ�û�������Ŀ���
	set /p choice=��������Ŀ��ţ�0 - 9����

:handle_submenu_choice
	if "%choice%"=="1" set "REPO_PATH=%baseDir%\hugo-main" && call :ValidateRepoAndCommit && goto after_commit
	if "%choice%"=="2" set "REPO_PATH=%baseDir%\music" && call :ValidateRepoAndCommit && goto after_commit
	if "%choice%"=="3" set "REPO_PATH=%baseDir%\file" && call :ValidateRepoAndCommit && goto after_commit
	if "%choice%"=="4" set "REPO_PATH=%baseDir%\bat" && call :ValidateRepoAndCommit && goto after_commit
	if "%choice%"=="5" set "REPO_PATH=%baseDir%\random-pic-api" && call :ValidateRepoAndCommit && goto after_commit
	if "%choice%"=="6" set "REPO_PATH=%baseDir%\compose" && call :ValidateRepoAndCommit && goto after_commit
	if "%choice%"=="7" set "REPO_PATH=%baseDir%\sh" && call :ValidateRepoAndCommit && goto after_commit
	if "%choice%"=="8" set "REPO_PATH=%baseDir%\" && call :git_push_add && goto after_commit
	if "%choice%"=="9" goto menu
	if "%choice%"=="0" (
		echo �����˳�...
		goto exit_script
	)

	echo ��Ч�ı�ţ������루0 - 9��֮������֡�
	timeout /t 3 >nul
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
		CALL :ShowMessage "û���ļ���Ҫ�ύ���������͵�Զ�ֿ̲�..."
		CALL :PushChanges
	)

	REM ��ʾ���
	CALL :ShowMessage "�ű�ִ����ɡ�"
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

:after_commit
	echo ������ɣ��ȴ� 3 ��󷵻��Ӳ˵�...
	timeout /t 3 >nul
	goto submenu

rem ================== �ύ������Ŀ ======================
:git_push_add
	set "separator=------------------------------"
	rem ������Ŀ¼�Ƿ����
	if not exist "%baseDir%" (
		echo Ŀ¼ %baseDir% �����ڡ�
		pause
		exit /b 1
	)

	echo %separator%
	echo ��ʼ����������Ŀ
	echo %separator%

	rem ��������Ŀ¼�µ�������Ŀ¼
	for /d %%i in ("%baseDir%\*") do (
		echo %separator%
		echo ���ڴ�����Ŀ: %%~nxi
		cd /d "%%i"
		
		rem ��鵱ǰĿ¼�Ƿ�Ϊ Git �ֿ�
		git rev-parse --is-inside-work-tree >nul 2>&1
		if !errorlevel! equ 0 (
			echo ��Ŀ¼�� Git �ֿ⣬��ʼ����Ƿ��б��...
			git diff --quiet --exit-code
			if !errorlevel! equ 0 (
				echo ��Ŀ %%~nxi û���ļ�����������ύ��
			) else (
				echo ��Ŀ %%~nxi ���ļ��������ʼ�ύ...
				echo ִ�� git add .
				git add .
				
				echo ִ�� git commit -m "update"
				git commit -m "update"
				if !errorlevel! equ 0 (
					echo ��Ŀ %%~nxi �ύ�ɹ�����ʼ����...
					echo ִ�� git push
					git push
					if !errorlevel! equ 0 (
						echo ��Ŀ %%~nxi ���ͳɹ���
					) else (
						echo ��Ŀ %%~nxi ����ʧ�ܣ����������ֿ�Ȩ�ޡ�
					)
				) else (
					echo ��Ŀ %%~nxi �ύʧ�ܣ������ļ�״̬���ύ��Ϣ��
				)
			)
		) else (
			echo ��Ŀ %%~nxi ����һ�� Git �ֿ⣬������
		)
		echo %separator%
	)

	echo %separator%
	echo ������Ŀ������ɡ�
	echo %separator%

	echo ������ɣ��ȴ� 6 ��󷵻� ...
	timeout /t 6 >nul
	goto submenu

rem ==============================  �� ����ȡ���µ���Ŀ  ==================================
:Pull_updates
	rem ��������ʾ��Ŀ��ȡ�����Ӳ˵�
	cls

powershell -Command ^
"Clear-Host; ^
    Write-Host '*********************************************' -ForegroundColor Yellow; ^
    Write-Host '**************  ��ȡ���µ���Ŀ  *************' -ForegroundColor Green; ^
    Write-Host '*********************************************' -ForegroundColor Yellow; ^
    Write-Host '* 1. ��ȡ���£�hugo-main                    *' -ForegroundColor Cyan; ^
    Write-Host '* 2. ��ȡ���£�music                        *' -ForegroundColor Magenta; ^
    Write-Host '* 3. ��ȡ���£�file                         *' -ForegroundColor DarkCyan; ^
    Write-Host '* 4. ��ȡ���£�bat                          *' -ForegroundColor DarkGreen; ^
    Write-Host '* 5. ��ȡ���£�random-pic-api               *' -ForegroundColor DarkRed; ^
    Write-Host '* 6. ��ȡ���£�compose                      *' -ForegroundColor DarkYellow; ^
    Write-Host '* 7. ��ȡ���£�sh                           *' -ForegroundColor DarkBlue; ^
    Write-Host '* 8. ��ȡ���£�������Ŀ                     *' -ForegroundColor Cyan; ^
    Write-Host '* 9. �������˵�                             *' -ForegroundColor White; ^
    Write-Host '* 0. �˳�                                   *' -ForegroundColor White; ^
    Write-Host '*********************************************' -ForegroundColor Yellow"

	rem ��ʾ�û�����������
	set /p choice=�����������ţ�0 - 9����

	rem �����û�������ת����Ӧ�Ĺ���ģ��
	if "%choice%"=="1" call :update_single_project "%baseDir%\hugo-main" && goto after_update
	if "%choice%"=="2" call :update_single_project "%baseDir%\music" && goto after_update
	if "%choice%"=="3" call :update_single_project "%baseDir%\file" && goto after_update
	if "%choice%"=="4" call :update_single_project "%baseDir%\bat" && goto after_update
	if "%choice%"=="5" call :update_single_project "%baseDir%\random-pic-api" && goto after_update
	if "%choice%"=="6" call :update_single_project "%baseDir%\compose" && goto after_update
	if "%choice%"=="7" call :update_single_project "%baseDir%\sh" && goto after_update
	if "%choice%"=="8" call :update_all_projects && goto after_update
	if "%choice%"=="9" goto menu
	if "%choice%"=="0"  (
		echo �����˳�...
		goto exit_script
	)

	echo ��Ч�ı�ţ������루0 - 9��֮������֡�
	timeout /t 3 >nul
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
	SET "RETRY_COUNT=0"
	
:CHECK_UPDATES_LOOP
	echo ===========================================
	echo ���ڼ��Զ�ֿ̲��Ƿ��и���...
	git fetch origin %CURRENT_BRANCH%
	IF NOT "!ERRORLEVEL!"=="0" (
		SET /A "RETRY_COUNT+=1"
		IF !RETRY_COUNT! LEQ 3 (
			echo ���Ի�ȡ����ʧ�ܣ��ȴ� 5 �����е� !RETRY_COUNT! ������...
			timeout /t 5 >nul
			goto CHECK_UPDATES_LOOP
		)
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
			SET "RETRY_COUNT=0"
			:ALL_PROJECT_CHECK_UPDATES_LOOP
			git pull origin main
			IF NOT "!ERRORLEVEL!"=="0" (
				SET /A "RETRY_COUNT+=1"
				IF !RETRY_COUNT! LEQ 3 (
					echo ���Ը�����Ŀʧ�ܣ��ȴ� 5 �����е� !RETRY_COUNT! ������...
					timeout /t 5 >nul
					goto ALL_PROJECT_CHECK_UPDATES_LOOP
				)
				echo ������Ŀ %%~nxF ����ʧ�ܣ����ֶ���顣
			)
			popd
			echo.
			echo.
		)
	)
	echo ������Ŀ������ɡ�
	EXIT /B 0

:after_update
	echo ������ɣ��ȴ� 3 ��󷵻� ...
	timeout /t 3 >nul
	goto Pull_updates rem ����Ҫ���صĲ˵�


rem =========================  �� ����Ŀ���±�ǩ  ============================
:update_tags
	rem ��������ʾ��Ŀ���±�ǩ�Ӳ˵�
	cls

powershell -Command ^
"Clear-Host; ^
    Write-Host '*********************************************' -ForegroundColor Yellow; ^
    Write-Host '*****************  ��Ŀ���±�ǩ  ************' -ForegroundColor Green; ^
    Write-Host '*********************************************' -ForegroundColor Yellow; ^
    Write-Host '* 1. ���±�ǩ��hugo-main                    *' -ForegroundColor Cyan; ^
    Write-Host '* 2. ���±�ǩ��music                        *' -ForegroundColor Magenta; ^
    Write-Host '* 3. ���±�ǩ��file                         *' -ForegroundColor DarkCyan; ^
    Write-Host '* 4. ���±�ǩ��random-pic-api               *' -ForegroundColor DarkGreen; ^
    Write-Host '* 5. ���±�ǩ��bat                          *' -ForegroundColor DarkRed; ^
    Write-Host '* 6. ���±�ǩ��sh                           *' -ForegroundColor DarkYellow; ^
    Write-Host '* 9. �������˵�                             *' -ForegroundColor White; ^
    Write-Host '* 0. �˳�                                   *' -ForegroundColor White; ^
    Write-Host '*********************************************' -ForegroundColor Yellow"

	rem ��ʾ�û�����������
	set /p choice=�����������ţ�0 - 9����

:handle_update_tags_choice
	if "%choice%"=="1" set "projectDir=%baseDir%\hugo-main" && call :update_project_tags && goto after_update
	if "%choice%"=="2" set "projectDir=%baseDir%\music" && call :update_project_tags && goto after_update
	if "%choice%"=="3" set "projectDir=%baseDir%\file" && call :update_project_tags && goto after_update
	if "%choice%"=="4" set "projectDir=%baseDir%\random-pic-api" && call :update_project_tags && goto after_update
	if "%choice%"=="5" set "projectDir=%baseDir%\bat" && call :update_project_tags && goto after_update
	if "%choice%"=="6" set "projectDir=%baseDir%\sh" && call :update_project_tags && goto after_update
	if "%choice%"=="9" goto menu
	if "%choice%"=="0"  (
		echo �����˳�...
		goto exit_script
	)

	echo ��Ч�ı�ţ������루0 - 9��֮������֡�
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

	rem ����Ƿ����ļ�����ӵ��ݴ���
	git diff --cached --quiet
	if %errorlevel% equ 0 (
		echo û�п��ύ�ĸ��ģ������ύ���衣
		echo ===========================================
		exit /b
	)

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

:after_update
	echo ������ɣ��ȴ� 3 �뷵�� ...
	timeout /t 3 >nul
	goto update_tags rem ����Ҫ���صĲ˵�

rem ======================== �� ����ͼ��Ŀ¼ =============================
:dakai_tucuang
	rem ��������ʾhugo�����Ӳ˵�
	cls
powershell -Command ^
"Clear-Host; ^
    Write-Host '*********************************************' -ForegroundColor Yellow; ^
    Write-Host '*************  ��ͼ��Ŀ¼  ****************' -ForegroundColor Green; ^
    Write-Host '*********************************************' -ForegroundColor Yellow; ^
    Write-Host '* 1. vercelͼ�� ����ͼƬ                    *' -ForegroundColor DarkBlue; ^
    Write-Host '* 2. vercelͼ�� ����ͼƬ                    *' -ForegroundColor Cyan; ^
    Write-Host '* 3. vercelͼ�� GIFͼƬ                     *' -ForegroundColor Magenta; ^
    Write-Host '* 4. nginxͼ�� ����ͼƬ                     *' -ForegroundColor DarkCyan; ^
    Write-Host '* 5. nginxͼ�� ����ͼƬ                     *' -ForegroundColor DarkGreen; ^
    Write-Host '* 6. nginxͼ�� GIFͼƬ                      *' -ForegroundColor DarkRed; ^
    Write-Host '* 7. vercel+nginx ����ͼƬ                  *' -ForegroundColor DarkYellow; ^
    Write-Host '* 8. vercel+nginx ����ͼƬ                  *' -ForegroundColor DarkBlue; ^
    Write-Host '* 9. �������˵�                             *' -ForegroundColor White; ^
    Write-Host '* 0. �˳�                                   *' -ForegroundColor White; ^
    Write-Host '*********************************************' -ForegroundColor Yellow"

	rem ��ʾ�û����������ţ�0 - 9��
	set /p choice=�����������ţ�0 - 9����

	if "%choice%"=="1" (
		start "" "%USERPROFILE%\Desktop\GitHub\file\img"
		goto dakai_tucuang
	)
	if "%choice%"=="2" (
		start "" "%USERPROFILE%\Desktop\GitHub\file\screenshot"
		goto dakai_tucuang
	)
	if "%choice%"=="3" (
		start "" "%USERPROFILE%\Desktop\GitHub\file\gif"
		goto dakai_tucuang
	)
	if "%choice%"=="4" (
		start "" "Y:\file\blog\img"
		goto dakai_tucuang
	)
	if "%choice%"=="5" (
		start "" "Y:\file\blog\screenshot"
		goto dakai_tucuang
	)
	if "%choice%"=="6" (
		start "" "Y:\file\blog\gif"
		goto dakai_tucuang
	)
	if "%choice%"=="7" (
		start "" "%USERPROFILE%\Desktop\GitHub\file\img"
		start "" "Y:\file\blog\img"
		goto dakai_tucuang
	)
	if "%choice%"=="8" (
		start "" "%USERPROFILE%\Desktop\GitHub\file\screenshot"
		start "" "Y:\file\blog\screenshot"
		goto dakai_tucuang
	)
	if "%choice%"=="9" goto menu
	if "%choice%"=="0" goto exit_script

	echo ��Ч�ı�ţ������루0 - 9��֮������֡�
	timeout /t 3 >nul
	goto dakai_tucuang
	
rem ======================== �� ��XXXXXXXXXXXXXXXX =============================


rem ===========================================================================
:exit_script
	echo ��лʹ�ã��ټ���
	timeout /t 3 >nul
	exit
rem ===========================================================================