@echo off
setlocal enabledelayedexpansion

REM 设置颜色为绿色背景，默认亮白色文字
COLOR 0A
CLS
PROMPT $P$G

:init
	rem 定义基础工作目录，设置为用户桌面下的GitHub文件夹
	set "baseDir=%USERPROFILE%\Desktop\GitHub"
	echo 基础工作目录: %baseDir%

:menu
	rem 清屏，显示主菜单
	cls

powershell -Command ^
"Clear-Host; ^
    Write-Host '*********************************************' -ForegroundColor Yellow; ^
    Write-Host '*************  Git 命令菜单  ****************' -ForegroundColor Green; ^
    Write-Host '*********************************************' -ForegroundColor Yellow; ^
    Write-Host '* 1. Git_命令菜单                           *' -ForegroundColor Cyan; ^
    Write-Host '* 2. Hugo_命令菜单                          *' -ForegroundColor Magenta; ^
    Write-Host '* 3. 项目_提交更新                          *' -ForegroundColor Red; ^
    Write-Host '* 4. 项目_拉取更新                          *' -ForegroundColor Blue; ^
    Write-Host '* 5. 项目_更新标签                          *' -ForegroundColor DarkYellow; ^
    Write-Host '* 6. 打开_图床目录                          *' -ForegroundColor DarkGreen; ^
    Write-Host '* 0. 退出                                   *' -ForegroundColor White; ^
    Write-Host '*********************************************' -ForegroundColor Yellow"

	rem 提示用户输入编号
	set /p choice="请输入操作编号 (0 - 9): "

:handle_choice
	if "%choice%"=="1" goto git_menu
	if "%choice%"=="2" goto hugo_commands
	if "%choice%"=="3" goto submenu
	if "%choice%"=="4" goto Pull_updates
	if "%choice%"=="5" goto update_tags
	if "%choice%"=="6" goto dakai_tucuang
	if "%choice%"=="0"  (
		echo 正在退出...
		goto exit_script
	)

	echo 无效的编号，请输入（0 - 9）之间的数字。
	timeout /t 2 >nul
	goto menu

rem ==========================  一 、命令菜单  ===========================
:git_menu
	rem 清屏，显示 Git 命令子菜单
	cls

powershell -Command ^
"Clear-Host; ^
    Write-Host '*********************************************' -ForegroundColor Yellow; ^
    Write-Host '*****************  命令菜单  ****************' -ForegroundColor Green; ^
    Write-Host '*********************************************' -ForegroundColor Yellow; ^
	Write-Host '* 1. 安装 scoop                             *' -ForegroundColor Cyan; ^
    Write-Host '* 2. 安装 Git                               *' -ForegroundColor DarkYellow; ^
	Write-Host '* 3. 更新 Git 版本                          *' -ForegroundColor Magenta; ^
    Write-Host '* 4. 查看 Git 版本                          *' -ForegroundColor DarkCyan; ^
    Write-Host '* 5. 克隆 Git 仓库                          *' -ForegroundColor DarkGreen; ^
    Write-Host '* 6. 设置 Git 用户名和邮箱                  *' -ForegroundColor Cyan; ^
    Write-Host '* 7. 设置 Git 代理                          *' -ForegroundColor DarkYellow; ^
	Write-Host '* 8. 取消 Git 代理                          *' -ForegroundColor DarkYellow; ^
    Write-Host '* 9. 返回主菜单                             *' -ForegroundColor White; ^
    Write-Host '* 0. 退出                                   *' -ForegroundColor White; ^
    Write-Host '*********************************************' -ForegroundColor Yellow"

	set /p choice="请输入操作编号 (0 - 9): "
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
		echo 正在退出...
		goto exit_script
	)

	echo 无效的编号，请输入（0 - 9）之间的数字。
	timeout /t 2 >nul
	goto git_menu

rem ========================= （1）安装 scoop 以管理员权限 ============================
:install_scoop

	REM 定义 scoop 的 main 存储桶目录
	set "scoop_main_dir=%USERPROFILE%\scoop\buckets\main"

	REM 输出当前系统环境变量中的 USERPROFILE 和计算得到的 scoop_main_dir
	echo 当前系统环境变量中的 USERPROFILE: %USERPROFILE%
	echo 计算得到的 scoop_main_dir: %scoop_main_dir%

	REM 检查 Git 是否可用
	where git >nul 2>&1
	if !errorlevel! neq 0 (
		call :handle_error "Git 未安装或者未添加到系统环境变量，请先安装 Git 并配置环境变量。"
		exit /b
	)
	echo Git 已安装并配置到系统环境变量。

	REM 检查目录是否存在
	if not exist "%scoop_main_dir%" (
		call :handle_error "指定的目录 %scoop_main_dir% 不存在。"
		exit /b
	)
	echo 目录 %scoop_main_dir% 存在。

	REM 检查目录是否为 Git 仓库
	if not exist "%scoop_main_dir%\.git" (
		call :handle_error "指定的目录 %scoop_main_dir% 不是一个有效的 Git 仓库。"
		exit /b
	)
	echo 目录 %scoop_main_dir% 是一个有效的 Git 仓库。

	REM 添加安全目录配置
	echo 正在添加安全目录配置...
	git config --global --add safe.directory "%scoop_main_dir%"
	if !errorlevel! neq 0 (
		call :handle_error "添加安全目录配置失败，请检查 Git 配置权限。"
		exit /b
	)
	echo 安全目录配置添加成功。

	REM 切换到 scoop 的 main 存储桶目录
	echo 正在切换到目录: %scoop_main_dir%
	cd /d "%scoop_main_dir%"
	if !errorlevel! neq 0 (
		call :handle_error "切换目录失败，请检查路径是否正确。"
		exit /b
	)
	echo 成功切换到目录: %scoop_main_dir%

	REM 执行 git pull 命令拉取最新代码
	echo 正在拉取最新代码...
	git pull origin master
	if !errorlevel! neq 0 (
		call :handle_error "拉取最新代码失败，请检查网络或 Git 仓库状态。"
		exit /b
	)
	echo 最新代码拉取成功。

    echo 即将在 3 秒后返回 ...
	powershell -Command "Start-Sleep -Seconds 3"
	goto git_menu  rem 定义要返回的菜单
	exit /b

rem ========================= （2）安装 Git 以管理员权限 ============================
:install_git
    REM 检查 winget 是否可用
    winget --version >nul 2>&1
    if %errorlevel% neq 0 (
        echo winget 不可用，请确保你的系统支持并已正确安装 winget。
        pause
        exit /b
    )

    echo 正在尝试以管理员权限安装 Git，请稍候...
    powershell -Command "Start-Process powershell -Verb runAs -ArgumentList 'winget install --id Git.Git -e --source winget -h'"
    if %errorlevel% neq 0 (
        echo Git 安装失败！
    ) else (
        echo Git 安装成功！
    )

    REM 检查 Git 是否安装成功并打印版本号
    git --version >nul 2>&1
    if %errorlevel% equ 0 (
        for /f "tokens=3 delims= " %%a in ('git --version') do (
            set "git_version=%%a"
        )
        if defined git_version (
            echo 当前安装的 Git 版本号为：!git_version!
        ) else (
            echo 无法获取 Git 版本号，请检查 Git 是否安装成功。
        )
    ) else (
        echo 无法获取 Git 版本号，请检查 Git 是否安装成功。
    )

    echo 即将在 3 秒后返回 ...
	powershell -Command "Start-Sleep -Seconds 3"
	goto git_menu  rem 定义要返回的菜单
	exit /b

endlocal

rem ========================= （3）更新 Git 版本 ============================
:update_git
    echo 正在更新 Git 版本...
    git update-git-for-windows
    echo 即将在 3 秒后返回 ...
	powershell -Command "Start-Sleep -Seconds 3"
	goto git_menu  rem 定义要返回的菜单
	exit /b

rem ========================= （4）查看 Git 版本 ============================
:check_git_version
    echo 正在查看 Git 版本...
    git --version
    if %errorlevel% neq 0 (
        echo 无法获取 Git 版本信息，可能 Git 未安装。
    )
    echo 即将在 3 秒后返回 ...
	powershell -Command "Start-Sleep -Seconds 3"
	goto git_menu  rem 定义要返回的菜单
	exit /b

rem ========================= （5）克隆 Git 仓库 ============================
:clone_git_repo
	REM 切换到目标目录
	CD /D %baseDir%

    REM 提示用户输入 Git 仓库的 URL
    set /p repoUrl="请输入 Git 仓库的 URL: "
    REM 检查是否输入了 URL
    if "%repoUrl%"=="" (
        echo 未输入有效的 URL，请重新运行脚本并输入正确的 URL。
        pause
        exit /b
    )
    REM 使用 git clone 克隆仓库
    echo 正在克隆仓库，请稍候...
    git clone %repoUrl%
    REM 检查克隆是否成功
    if %errorlevel% neq 0 (
        echo 克隆失败，请检查 URL 是否正确或网络连接。
    ) else (
        echo 克隆成功！
    )
    echo 即将在 3 秒后返回 ...
	powershell -Command "Start-Sleep -Seconds 3"
	goto git_menu  rem 定义要返回的菜单
	exit /b

rem ========================= （6）设置 Git 用户名和邮箱 ============================
:set_user_name
    set /p userName="请输入用户名: "
    if "%userName%"=="" (
        echo 未输入有效的用户名，请重新运行脚本并输入正确的用户名。
        pause
        exit /b
    )
    git config --global user.name "%userName%"
    echo 用户名已设置为 %userName%
	
	set /p userEmail="请输入用户邮箱: "
	if "%userEmail%"=="" (
	    echo 未输入有效的用户邮箱，请重新运行脚本并输入正确的用户邮箱。
	    pause
	    exit /b
	)
	git config --global user.email "%userEmail%"
	echo 用户邮箱已设置为 %userEmail%
	
    echo 即将在 3 秒后返回 ...
	powershell -Command "Start-Sleep -Seconds 3"
	goto git_menu  rem 定义要返回的菜单
	exit /b

rem ========================= （7）设置 Git 代理 ============================
:set_git_proxy
    git config --global --unset http.proxy
    git config --global --unset https.proxy
	echo Git 取消历史配置成功
	
    git config --global http.proxy 127.0.0.1:7890
    git config --global https.proxy 127.0.0.1:7890
    echo Git 代理已设置为 http://127.0.0.1:7890 和 https://127.0.0.1:7890
    echo 即将在 3 秒后返回 ...
	powershell -Command "Start-Sleep -Seconds 3"
	goto git_menu  rem 定义要返回的菜单
	exit /b
	
rem ========================= （8）取消 Git 代理 ============================
:unset_git_proxy
    git config --global --unset http.proxy
    git config --global --unset https.proxy
	echo Git 取消历史配置成功
	
    echo 即将在 3 秒后返回 ...
	powershell -Command "Start-Sleep -Seconds 3"
	goto git_menu  rem 定义要返回的菜单
	exit /b

rem ======================== 二 、Hugo_命令菜单 =============================
:hugo_commands
	rem 清屏，显示hugo命令子菜单
	cls

powershell -Command ^
"Clear-Host; ^
    Write-Host '*********************************************' -ForegroundColor Yellow; ^
    Write-Host '*************  Hugo_命令菜单  ***************' -ForegroundColor Green; ^
    Write-Host '*********************************************' -ForegroundColor Yellow; ^
	Write-Host '* 1. 安装 scoop                             *' -ForegroundColor DarkBlue; ^
    Write-Host '* 2. 安装 hugo                              *' -ForegroundColor Cyan; ^
    Write-Host '* 3. 查看 hugo 版本                         *' -ForegroundColor Magenta; ^
    Write-Host '* 4. 新建文章                               *' -ForegroundColor DarkCyan; ^
    Write-Host '* 5. 打开文章目录                           *' -ForegroundColor DarkGreen; ^
    Write-Host '* 6. 运行 hugo                              *' -ForegroundColor DarkRed; ^
    Write-Host '* 7. 浏览器打开 :1313                       *' -ForegroundColor DarkYellow; ^
    Write-Host '* 8. 运行 hugo 并打开                       *' -ForegroundColor DarkBlue; ^
    Write-Host '* 9. 返回主菜单                             *' -ForegroundColor White; ^
    Write-Host '* 0. 退出                                   *' -ForegroundColor White; ^
    Write-Host '*********************************************' -ForegroundColor Yellow"

	rem 提示用户输入操作编号
	set /p choice=请输入操作编号（0 - 9）：

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
		echo 正在退出...
		goto exit_script
	)

	echo 无效的编号，请输入（0 - 9）之间的数字。
	timeout /t 2 >nul
	goto hugo_commands

rem ========================= （1）安装 scoop 以管理员权限 ============================
:install_scoop
	REM 定义 scoop 的 main 存储桶目录
	set "scoop_main_dir=%USERPROFILE%\scoop\buckets\main"

	REM 输出当前系统环境变量中的 USERPROFILE 和计算得到的 scoop_main_dir
	echo 当前系统环境变量中的 USERPROFILE: %USERPROFILE%
	echo 计算得到的 scoop_main_dir: %scoop_main_dir%

	REM 检查 Git 是否可用
	where git >nul 2>&1
	if !errorlevel! neq 0 (
		call :handle_error "Git 未安装或者未添加到系统环境变量，请先安装 Git 并配置环境变量。"
		exit /b
	)
	echo Git 已安装并配置到系统环境变量。

	REM 检查目录是否存在
	if not exist "%scoop_main_dir%" (
		call :handle_error "指定的目录 %scoop_main_dir% 不存在。"
		exit /b
	)
	echo 目录 %scoop_main_dir% 存在。

	REM 检查目录是否为 Git 仓库
	if not exist "%scoop_main_dir%\.git" (
		call :handle_error "指定的目录 %scoop_main_dir% 不是一个有效的 Git 仓库。"
		exit /b
	)
	echo 目录 %scoop_main_dir% 是一个有效的 Git 仓库。

	REM 添加安全目录配置
	echo 正在添加安全目录配置...
	git config --global --add safe.directory "%scoop_main_dir%"
	if !errorlevel! neq 0 (
		call :handle_error "添加安全目录配置失败，请检查 Git 配置权限。"
		exit /b
	)
	echo 安全目录配置添加成功。

	REM 切换到 scoop 的 main 存储桶目录
	echo 正在切换到目录: %scoop_main_dir%
	cd /d "%scoop_main_dir%"
	if !errorlevel! neq 0 (
		call :handle_error "切换目录失败，请检查路径是否正确。"
		exit /b
	)
	echo 成功切换到目录: %scoop_main_dir%

	REM 执行 git pull 命令拉取最新代码
	echo 正在拉取最新代码...
	git pull origin master
	if !errorlevel! neq 0 (
		call :handle_error "拉取最新代码失败，请检查网络或 Git 仓库状态。"
		exit /b
	)
	echo 最新代码拉取成功。

    echo 即将在 3 秒后返回 ...
	powershell -Command "Start-Sleep -Seconds 3"
	goto git_menu  rem 定义要返回的菜单
	exit /b

rem =================== （2）安装 hugo =====================
:install_hugo
    REM 检查 winget 是否可用
    winget --version >nul 2>&1
    if %errorlevel% neq 0 (
        echo winget 不可用，请确保你的系统支持并已正确安装 winget。
        rem 等待两秒返回菜单
	echo 即将在 2 秒后返回 Hugo 命令菜单...
	powershell -Command "Start-Sleep -Seconds 2"
	goto hugo_commands  rem 定义要返回的菜单
	exit /b
    )

    echo 正在尝试以管理员权限安装 Hugo，请稍候...
    powershell -Command "Start-Process powershell -Verb runAs -ArgumentList 'winget install --id Hugo.Hugo.Extended -e --source winget'"
    if %errorlevel% neq 0 (
        echo Hugo 安装失败！
    ) else (
        echo Hugo 安装成功！
    )
    echo 即将在 3 秒后返回 ...
	powershell -Command "Start-Sleep -Seconds 3"
	goto hugo_commands  rem 定义要返回的菜单
	exit /b

rem ================ （3）查看 hugo 版本 ========================
:hugo_v
	rem 启动一个新的命令行窗口并运行hugo服务器
	start cmd /k "hugo version"
	echo 即将在 3 秒后返回 ...
	powershell -Command "Start-Sleep -Seconds 2"
	goto hugo_commands  rem 定义要返回的菜单
	exit /b

rem ================= （4）新建文章 =======================
:create_article
	rem 提示用户输入文章名字
	set /p name=请输入文章名字：

	rem 切换到hugo项目的根目录
	call :change_dir "%baseDir%\hugo-main" || (
		echo 无法切换到hugo项目根目录，请检查路径。
		pause >nul
		goto menu
	)

	rem 使用hugo命令创建新文章
	call hugo new "post\%name%\index.md"
	if %errorlevel% neq 0 (
		echo 文章创建失败，请检查Hugo配置或路径。
		pause >nul
		goto menu
	)

	echo 文章创建成功，正在打开typora.exe编辑器...

	rem 打开记事本编辑器编辑新创建的文章
	set articlePath=%baseDir%\hugo-main\content\post\%name%\index.md
	if not exist "%articlePath%" (
		echo 文章文件未正确生成，请检查Hugo配置。
		pause >nul
		goto menu
	)

	REM start "" "notepad.exe" "%articlePath%"
	start "" "typora.exe" "%articlePath%"
	if %errorlevel% neq 0 (
		echo 无法打开typora.exe编辑器，请检查typora.exe是否安装。
		pause >nul
	)

	echo 请在typora.exe中编辑文章，编辑完成后按任意键返回菜单。
    echo 即将在 3 秒后返回 ...
	powershell -Command "Start-Sleep -Seconds 2"
	goto hugo_commands  rem 定义要返回的菜单
	exit /b

rem ================== （5）打开文章目录 ======================
:post_hugo
	:: 定义目标目录（使用 %USERPROFILE% 使路径通用）
	start "" "%baseDir%\hugo-main\content\post"
	rem 等待两秒返回菜单
    echo 即将在 3 秒后返回 ...
	powershell -Command "Start-Sleep -Seconds 2"
	goto hugo_commands  rem 定义要返回的菜单
	exit /b

rem ================== （6）运行 hugo ======================
:run_hugo
	call :change_dir "%baseDir%\hugo-main" || (
		echo 无法切换到hugo项目根目录，请检查路径。
		pause >nul
		goto menu
	)
	rem 启动一个新的命令行窗口并运行hugo服务器
	start cmd /k "hugo server -D"
    echo 即将在 3 秒后返回 ...
	powershell -Command "Start-Sleep -Seconds 2"
	goto hugo_commands  rem 定义要返回的菜单
	exit /b

rem ================== （7）浏览器打开 :1313 ======================
:open_browser
	echo 本地服务器已启动，请访问 http://localhost:1313/，浏览器打开。
	timeout /t 2 >nul
	echo 浏览器已自动打开本地Hugo页面。
	rem 打开浏览器访问本地hugo服务器
	start "" "http://localhost:1313"
    echo 即将在 3 秒后返回 ...
	timeout /t 3 >nul  REM 等待 3 秒
	goto hugo_commands  REM 返回到 Hugo 命令菜单
	exit /b

rem ================== （8）运行 hugo 并打开   ======================
:run_hugo_link
	call :change_dir "%baseDir%\hugo-main" || (
		echo 无法切换到hugo项目根目录，请检查路径。
		pause >nul
		goto menu
	)
	rem 启动一个新的命令行窗口并运行hugo服务器
	start cmd /k "hugo server -D"
	echo 本地服务器已启动，请访问 http://localhost:1313/，浏览器将在服务器启动后5秒内自动打开。
	timeout /t 5 >nul
	echo 浏览器已自动打开本地Hugo页面。
	rem 打开浏览器访问本地hugo服务器
	start "" "http://localhost:1313"
    echo 即将在 3 秒后返回 ...
	timeout /t 3 >nul
	goto hugo_commands  REM 返回到 Hugo 命令菜单
	exit /b


rem =======================  三 、GitHub 项目提交  ==============================
:submenu
	rem 清屏，显示项目提交子菜单
	cls
powershell -Command ^
"Clear-Host; ^
    Write-Host '*********************************************' -ForegroundColor Yellow; ^
    Write-Host '**************  GitHub 项目提交  ************' -ForegroundColor Green; ^
    Write-Host '*********************************************' -ForegroundColor Yellow; ^
    Write-Host '* 1. 项目提交：hugo-main                    *' -ForegroundColor Cyan; ^
    Write-Host '* 2. 项目提交：music                        *' -ForegroundColor Magenta; ^
    Write-Host '* 3. 项目提交：file                         *' -ForegroundColor DarkCyan; ^
    Write-Host '* 4. 项目提交：bat                          *' -ForegroundColor DarkGreen; ^
    Write-Host '* 5. 项目提交：random-pic-api               *' -ForegroundColor DarkRed; ^
    Write-Host '* 6. 项目提交：compose                      *' -ForegroundColor DarkYellow; ^
    Write-Host '* 7. 项目提交：sh                           *' -ForegroundColor DarkBlue; ^
	Write-Host '* 8. 项目提交：所有项目                     *' -ForegroundColor Cyan; ^
    Write-Host '* 9. 返回主菜单                             *' -ForegroundColor White; ^
    Write-Host '* 0. 退出                                   *' -ForegroundColor White; ^
    Write-Host '*********************************************' -ForegroundColor Yellow"

	rem 提示用户输入项目编号
	set /p choice=请输入项目编号（0 - 9）：

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
		echo 正在退出...
		goto exit_script
	)

	echo 无效的编号，请输入（0 - 9）之间的数字。
	timeout /t 3 >nul
	goto submenu

:ValidateRepoAndCommit
	REM 检查目标目录是否存在
	IF NOT EXIST "%REPO_PATH%" (
		CALL :ShowError "错误：目录 %REPO_PATH% 不存在，请检查路径！"
		EXIT /B 1
	)

	REM 切换到目标目录
	CD /D "%REPO_PATH%" 2>NUL
	IF ERRORLEVEL 1 (
		CALL :ShowError "错误：无法切换到目录 %REPO_PATH%，请检查 Git 仓库。"
		EXIT /B 1
	)

	REM 检查是否为有效的 Git 仓库
	IF NOT EXIST .git (
		CALL :ShowError "错误：目录 %REPO_PATH% 不是一个有效的 Git 仓库。"
		EXIT /B 1
	)

	:CheckForChanges
	REM 检查是否有修改需要提交
	CALL :ShowMessage "正在检查是否有文件需要提交..."

	git status >nul 2>&1
	IF ERRORLEVEL 1 (
		CALL :ShowError "错误：无法获取 Git 仓库状态，请检查环境。"
		exit /b 1
	)

	SET "CHANGES="
	FOR /F "delims=" %%D IN ('git status --porcelain') DO (
		IF "%%D" NEQ "" (
			SET "CHANGES=YES"
		)
	)

	IF DEFINED CHANGES (
		CALL :ShowMessage "检测到文件修改，开始提交..."
		CALL :AddChanges
		CALL :CommitChanges
		CALL :PushChanges
		CALL :ShowMessage "提交和推送成功！"
	) ELSE (
		CALL :ShowMessage "没有文件需要提交，尝试推送到远程仓库..."
		CALL :PushChanges
	)

	REM 提示完成
	CALL :ShowMessage "脚本执行完成。"
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
	CALL :ShowMessage "正在添加所有更改..."
	git add .
	IF ERRORLEVEL 1 (
		CALL :ShowError "错误：无法添加文件，请检查 Git 仓库。"
		exit /b 1
	)
	exit /b 0

:CommitChanges
	CALL :ShowMessage "正在提交更改..."
	git commit -m "update"
	IF ERRORLEVEL 1 (
		CALL :ShowError "错误：提交失败，请检查 Git 仓库。"
		exit /b 1
	)
	exit /b 0

:PushChanges
	CALL :ShowMessage "正在推送更改到远程仓库..."
	git push
	IF ERRORLEVEL 1 (
		CALL :ShowError "错误：推送失败，请检查网络连接或远程配置。"
		exit /b 1
	)
	exit /b 0

:after_commit
	echo 操作完成，等待 3 秒后返回子菜单...
	timeout /t 3 >nul
	goto submenu

rem ================== 提交所有项目 ======================
:git_push_add
	set "separator=------------------------------"
	rem 检查基础目录是否存在
	if not exist "%baseDir%" (
		echo 目录 %baseDir% 不存在。
		pause
		exit /b 1
	)

	echo %separator%
	echo 开始处理所有项目
	echo %separator%

	rem 遍历基础目录下的所有子目录
	for /d %%i in ("%baseDir%\*") do (
		echo %separator%
		echo 正在处理项目: %%~nxi
		cd /d "%%i"
		
		rem 检查当前目录是否为 Git 仓库
		git rev-parse --is-inside-work-tree >nul 2>&1
		if !errorlevel! equ 0 (
			echo 此目录是 Git 仓库，开始检查是否有变更...
			git diff --quiet --exit-code
			if !errorlevel! equ 0 (
				echo 项目 %%~nxi 没有文件变更，跳过提交。
			) else (
				echo 项目 %%~nxi 有文件变更，开始提交...
				echo 执行 git add .
				git add .
				
				echo 执行 git commit -m "update"
				git commit -m "update"
				if !errorlevel! equ 0 (
					echo 项目 %%~nxi 提交成功，开始推送...
					echo 执行 git push
					git push
					if !errorlevel! equ 0 (
						echo 项目 %%~nxi 推送成功。
					) else (
						echo 项目 %%~nxi 推送失败，请检查网络或仓库权限。
					)
				) else (
					echo 项目 %%~nxi 提交失败，请检查文件状态或提交信息。
				)
			)
		) else (
			echo 项目 %%~nxi 不是一个 Git 仓库，跳过。
		)
		echo %separator%
	)

	echo %separator%
	echo 所有项目处理完成。
	echo %separator%

	echo 操作完成，等待 6 秒后返回 ...
	timeout /t 6 >nul
	goto submenu

rem ==============================  四 、拉取更新的项目  ==================================
:Pull_updates
	rem 清屏，显示项目拉取更新子菜单
	cls

powershell -Command ^
"Clear-Host; ^
    Write-Host '*********************************************' -ForegroundColor Yellow; ^
    Write-Host '**************  拉取更新的项目  *************' -ForegroundColor Green; ^
    Write-Host '*********************************************' -ForegroundColor Yellow; ^
    Write-Host '* 1. 拉取更新：hugo-main                    *' -ForegroundColor Cyan; ^
    Write-Host '* 2. 拉取更新：music                        *' -ForegroundColor Magenta; ^
    Write-Host '* 3. 拉取更新：file                         *' -ForegroundColor DarkCyan; ^
    Write-Host '* 4. 拉取更新：bat                          *' -ForegroundColor DarkGreen; ^
    Write-Host '* 5. 拉取更新：random-pic-api               *' -ForegroundColor DarkRed; ^
    Write-Host '* 6. 拉取更新：compose                      *' -ForegroundColor DarkYellow; ^
    Write-Host '* 7. 拉取更新：sh                           *' -ForegroundColor DarkBlue; ^
    Write-Host '* 8. 拉取更新：所有项目                     *' -ForegroundColor Cyan; ^
    Write-Host '* 9. 返回主菜单                             *' -ForegroundColor White; ^
    Write-Host '* 0. 退出                                   *' -ForegroundColor White; ^
    Write-Host '*********************************************' -ForegroundColor Yellow"

	rem 提示用户输入操作编号
	set /p choice=请输入操作编号（0 - 9）：

	rem 根据用户输入跳转到相应的功能模块
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
		echo 正在退出...
		goto exit_script
	)

	echo 无效的编号，请输入（0 - 9）之间的数字。
	timeout /t 3 >nul
	goto Pull_updates

:update_single_project
	SET "REPO_PATH=%~1"
	REM 检查目标目录是否存在
	IF NOT EXIST "%REPO_PATH%" (
		echo ===========================================
		echo 错误：目录 %REPO_PATH% 不存在，请检查路径！
		echo ===========================================
		pause
		EXIT /B 1
	)
	REM 切换到目标目录
	CD /D "%REPO_PATH%"
	REM 检查是否为有效的 Git 仓库
	IF NOT EXIST .git (
		echo ===========================================
		echo 错误：目录 %REPO_PATH% 不是一个有效的 Git 仓库。
		echo ===========================================
		pause
		EXIT /B 1
	)
	REM 确保当前分支是 main 分支
	git rev-parse --abbrev-ref HEAD >nul 2>&1
	IF ERRORLEVEL 1 (
		echo ===========================================
		echo 错误：无法检测当前分支，请确保这是一个有效的 Git 仓库。
		echo ===========================================
		pause
		EXIT /B 1
	)
	SET CURRENT_BRANCH=main
	git checkout %CURRENT_BRANCH% >nul 2>&1
	IF ERRORLEVEL 1 (
		echo ===========================================
		echo 错误：无法切换到分支 %CURRENT_BRANCH%，请检查分支名称。
		echo ===========================================
		pause
		EXIT /B 1
	)
	REM 检查远程仓库是否有更新
	SET "RETRY_COUNT=0"
	
:CHECK_UPDATES_LOOP
	echo ===========================================
	echo 正在检查远程仓库是否有更新...
	git fetch origin %CURRENT_BRANCH%
	IF NOT "!ERRORLEVEL!"=="0" (
		SET /A "RETRY_COUNT+=1"
		IF !RETRY_COUNT! LEQ 3 (
			echo 尝试获取更新失败，等待 5 秒后进行第 !RETRY_COUNT! 次重试...
			timeout /t 5 >nul
			goto CHECK_UPDATES_LOOP
		)
		echo 错误：无法从远程仓库获取更新，请检查网络连接或远程配置。
		pause
		EXIT /B 1
	)
	REM 比较本地分支与远程分支
	SET REMOTE_BRANCH=origin/%CURRENT_BRANCH%
	git rev-list --left-right --count %REMOTE_BRANCH%...%CURRENT_BRANCH% >nul 2>&1
	FOR /F "tokens=1,2 delims=	" %%A IN ('git rev-list --left-right --count %REMOTE_BRANCH%...%CURRENT_BRANCH%') DO (
		SET BEHIND_COUNT=%%A
		SET AHEAD_COUNT=%%B
	)
	echo ===========================================
	echo 本地分支与远程分支的差异：
	echo 当前分支落后远程分支 !BEHIND_COUNT! 次提交。
	echo 当前分支领先远程分支 !AHEAD_COUNT! 次提交。
	echo ===========================================
	REM 如果有更新，则拉取更改
	IF !BEHIND_COUNT! GTR 0 (
		echo 正在从远程仓库拉取更新...
		git pull origin %CURRENT_BRANCH%
		IF "!ERRORLEVEL!"=="0" (
			echo 更新成功！
		) ELSE (
			echo 错误：拉取更新失败，请手动检查。
		)
	) ELSE (
		echo 本地分支已经是最新状态，无需更新。
	)
	echo ===========================================
	echo 单个项目更新脚本执行完成。
	EXIT /B 0


:update_all_projects
	cd /d "%baseDir%"
	rem 检查目录是否存在
	if not exist "%baseDir%" (
		echo 指定的目录 "%baseDir%" 不存在。
		pause
		exit /b 1
	)
	rem ========================= 拉取更新：所有项目 ==================================
	rem 遍历目录下的所有文件夹
	echo 正在检查 GitHub 文件夹中的项目...
	echo.
	for /d %%F in ("%baseDir%\*") do (
		rem 检查文件夹是否是 Git 项目（通过检查 .git 文件夹是否存在）
		if exist "%%F\.git" (
			rem 切换到目录并执行 git pull
			pushd "%%F"
			echo.
			echo ========================================
			echo 正在更新项目: %%~nxF
			echo 项目路径: %%F
			echo ========================================
			SET "RETRY_COUNT=0"
			:ALL_PROJECT_CHECK_UPDATES_LOOP
			git pull origin main
			IF NOT "!ERRORLEVEL!"=="0" (
				SET /A "RETRY_COUNT+=1"
				IF !RETRY_COUNT! LEQ 3 (
					echo 尝试更新项目失败，等待 5 秒后进行第 !RETRY_COUNT! 次重试...
					timeout /t 5 >nul
					goto ALL_PROJECT_CHECK_UPDATES_LOOP
				)
				echo 错误：项目 %%~nxF 更新失败，请手动检查。
			)
			popd
			echo.
			echo.
		)
	)
	echo 所有项目更新完成。
	EXIT /B 0

:after_update
	echo 操作完成，等待 3 秒后返回 ...
	timeout /t 3 >nul
	goto Pull_updates rem 定义要返回的菜单


rem =========================  五 、项目更新标签  ============================
:update_tags
	rem 清屏，显示项目更新标签子菜单
	cls

powershell -Command ^
"Clear-Host; ^
    Write-Host '*********************************************' -ForegroundColor Yellow; ^
    Write-Host '*****************  项目更新标签  ************' -ForegroundColor Green; ^
    Write-Host '*********************************************' -ForegroundColor Yellow; ^
    Write-Host '* 1. 更新标签：hugo-main                    *' -ForegroundColor Cyan; ^
    Write-Host '* 2. 更新标签：music                        *' -ForegroundColor Magenta; ^
    Write-Host '* 3. 更新标签：file                         *' -ForegroundColor DarkCyan; ^
    Write-Host '* 4. 更新标签：random-pic-api               *' -ForegroundColor DarkGreen; ^
    Write-Host '* 5. 更新标签：bat                          *' -ForegroundColor DarkRed; ^
    Write-Host '* 6. 更新标签：sh                           *' -ForegroundColor DarkYellow; ^
    Write-Host '* 9. 返回主菜单                             *' -ForegroundColor White; ^
    Write-Host '* 0. 退出                                   *' -ForegroundColor White; ^
    Write-Host '*********************************************' -ForegroundColor Yellow"

	rem 提示用户输入操作编号
	set /p choice=请输入操作编号（0 - 9）：

:handle_update_tags_choice
	if "%choice%"=="1" set "projectDir=%baseDir%\hugo-main" && call :update_project_tags && goto after_update
	if "%choice%"=="2" set "projectDir=%baseDir%\music" && call :update_project_tags && goto after_update
	if "%choice%"=="3" set "projectDir=%baseDir%\file" && call :update_project_tags && goto after_update
	if "%choice%"=="4" set "projectDir=%baseDir%\random-pic-api" && call :update_project_tags && goto after_update
	if "%choice%"=="5" set "projectDir=%baseDir%\bat" && call :update_project_tags && goto after_update
	if "%choice%"=="6" set "projectDir=%baseDir%\sh" && call :update_project_tags && goto after_update
	if "%choice%"=="9" goto menu
	if "%choice%"=="0"  (
		echo 正在退出...
		goto exit_script
	)

	echo 无效的编号，请输入（0 - 9）之间的数字。
	timeout /t 2 >nul
	goto update_tags

:update_project_tags
	call :change_dir "%projectDir%" || (
		echo 无法切换到项目目录，请检查路径。
		pause >nul
		exit /b
	)

	rem 定义执行的命令
	call :git_add_and_commit
	call :git_push
	call :delete_tag v1.0.0
	call :create_and_push_tag v1.0.0 "Recreate tags for the latest submission"
	exit /b

:git_add_and_commit
	echo ===========================================
	echo 正在添加所有更改...
	rem 添加所有文件到暂存区
	git add .
	if %errorlevel% neq 0 (
		echo "git add ." 执行失败，请检查您的Git配置或文件权限。
		pause >nul
		exit /b
	)
	echo ===========================================

	rem 检查是否有文件被添加到暂存区
	git diff --cached --quiet
	if %errorlevel% equ 0 (
		echo 没有可提交的更改，跳过提交步骤。
		echo ===========================================
		exit /b
	)

	echo 正在提交更改，提交信息为 "update"...
	rem 提交暂存区的文件到本地仓库
	git commit -m "update"
	if %errorlevel% neq 0 (
		echo "git commit -m 'update'" 执行失败，请检查您的Git配置或网络连接。
		pause >nul
		exit /b
	)
	echo ===========================================
	exit /b

:git_push
	echo 正在将提交推送到远程仓库...
	rem 推送本地仓库的提交到远程仓库
	git push
	if %errorlevel% neq 0 (
		echo "git push" 执行失败，请检查您的Git配置或网络连接。
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
	echo 正在删除本地标签 %1...
	rem 删除本地标签
	git tag -d %1
	if %errorlevel% neq 0 (
		echo 本地标签 %1 删除失败，请手动检查。
		pause >nul
		exit /b
	)
	echo ===========================================
	exit /b

:delete_remote_tag
	echo 正在删除远程标签 %1...
	rem 删除远程标签
	git push origin :refs/tags/%1
	if %errorlevel% neq 0 (
		echo 远程标签 %1 删除失败，请手动检查。
		pause >nul
		exit /b
	)
	echo ===========================================
	exit /b

:check_tag_deletion
	rem 检查标签是否删除成功
	git tag -l | findstr /I "%1" >nul
	IF %ERRORLEVEL% EQU 0 (
		echo 远程标签 %1 删除失败，请手动检查。
	) ELSE (
		echo 远程标签 %1 删除成功。
	)
	echo ===========================================
	exit /b

:create_and_push_tag
	call :create_new_tag %1 "%2"
	call :push_new_tag %1
	call :check_tag_push %1
	exit /b

:create_new_tag
	echo 正在创建新标签 %1，标签信息为 "%2"...
	rem 创建新标签
	git tag -a %1 -m "%2"
	if %errorlevel% neq 0 (
		echo 新标签 %1 创建失败，请手动检查。
		pause >nul
		exit /b
	)
	echo ===========================================
	exit /b

:push_new_tag
	echo 正在将新的标签 %1 推送到远程仓库...
	rem 推送新标签到远程仓库
	git push origin %1
	if %errorlevel% neq 0 (
		echo 标签 %1 推送失败，请手动检查。
		pause >nul
		exit /b
	)
	echo ===========================================
	exit /b

:check_tag_push
	rem 检查标签是否推送成功
	git tag -l | findstr /I "%1" >nul
	IF %ERRORLEVEL% EQU 0 (
		echo 标签 %1 推送成功。
	) ELSE (
		echo 标签 %1 推送失败，请手动检查。
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
	echo 推送完成，等待 3 秒返回 ...
	timeout /t 3 >nul
	goto update_tags rem 定义要返回的菜单

rem ======================== 六 、打开图床目录 =============================
:dakai_tucuang
	rem 清屏，显示hugo命令子菜单
	cls
powershell -Command ^
"Clear-Host; ^
    Write-Host '*********************************************' -ForegroundColor Yellow; ^
    Write-Host '*************  打开图床目录  ****************' -ForegroundColor Green; ^
    Write-Host '*********************************************' -ForegroundColor Yellow; ^
    Write-Host '* 1. vercel图床 封面图片                    *' -ForegroundColor DarkBlue; ^
    Write-Host '* 2. vercel图床 截屏图片                    *' -ForegroundColor Cyan; ^
    Write-Host '* 3. vercel图床 GIF图片                     *' -ForegroundColor Magenta; ^
    Write-Host '* 4. nginx图床 封面图片                     *' -ForegroundColor DarkCyan; ^
    Write-Host '* 5. nginx图床 截屏图片                     *' -ForegroundColor DarkGreen; ^
    Write-Host '* 6. nginx图床 GIF图片                      *' -ForegroundColor DarkRed; ^
    Write-Host '* 7. vercel+nginx 封面图片                  *' -ForegroundColor DarkYellow; ^
    Write-Host '* 8. vercel+nginx 截屏图片                  *' -ForegroundColor DarkBlue; ^
    Write-Host '* 9. 返回主菜单                             *' -ForegroundColor White; ^
    Write-Host '* 0. 退出                                   *' -ForegroundColor White; ^
    Write-Host '*********************************************' -ForegroundColor Yellow"

	rem 提示用户输入操作编号（0 - 9）
	set /p choice=请输入操作编号（0 - 9）：

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

	echo 无效的编号，请输入（0 - 9）之间的数字。
	timeout /t 3 >nul
	goto dakai_tucuang
	
rem ======================== 七 、XXXXXXXXXXXXXXXX =============================


rem ===========================================================================
:exit_script
	echo 感谢使用，再见！
	timeout /t 3 >nul
	exit
rem ===========================================================================