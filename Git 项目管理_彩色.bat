@echo off
setlocal enabledelayedexpansion

REM 设置颜色为绿色背景，默认亮白色文字
COLOR 0A
CLS
PROMPT $P$G

rem ========================== PowerShell 代码示例 ===========================
rem Write-Host "这是青色文本" -ForegroundColor Cyan         选项（1）
rem Write-Host "这是洋红色文本" -ForegroundColor Magenta    选项（2）
rem Write-Host "这是蓝色文本" -ForegroundColor Blue         选项（3）
rem Write-Host "这是红色文本" -ForegroundColor Red          选项（4）
rem Write-Host "这是深黄色文本" -ForegroundColor DarkYellow 选项（5）
rem Write-Host "这是深绿色文本" -ForegroundColor DarkGreen  选项（6）
rem Write-Host "这是深蓝色文本" -ForegroundColor DarkBlue   选项（7）
rem Write-Host "这是深青色文本" -ForegroundColor DarkCyan   选项（8）
rem Write-Host "这是白色文本" -ForegroundColor White （0退出）（9返回主菜单）
rem Write-Host "这是黄色文本" -ForegroundColor Yellow (分割线)
rem Write-Host "这是黑色文本" -ForegroundColor Black
rem Write-Host "这是深蓝色文本" -ForegroundColor DarkBlue
rem Write-Host "这是深红色文本" -ForegroundColor DarkRed
rem Write-Host "这是深洋红色文本" -ForegroundColor DarkMagenta
rem Write-Host "这是灰色文本" -ForegroundColor Gray
rem Write-Host "这是深灰色文本" -ForegroundColor DarkGray
rem Write-Host "这是绿色文本" -ForegroundColor Green
rem ========================== PowerShell 代码示例 ===========================

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
    Write-Host '* 3. 项目_推送更新                          *' -ForegroundColor Blue; ^
    Write-Host '* 4. 项目_拉取更新                          *' -ForegroundColor Red; ^
    Write-Host '* 5. 项目_更新标签                          *' -ForegroundColor DarkYellow; ^
    Write-Host '* 6. 打开_图床目录                          *' -ForegroundColor DarkGreen; ^
    Write-Host '* 7. 打开_常用目录                          *' -ForegroundColor DarkBlue; ^
    Write-Host '* 8. 打开_杂项菜单                          *' -ForegroundColor DarkCyan; ^
    Write-Host '* 9. 已是主菜单                             *' -ForegroundColor White; ^
    Write-Host '* 0. 退出                                   *' -ForegroundColor White; ^
    Write-Host '*********************************************' -ForegroundColor Yellow"

    set "choice="
    set /p choice="请输入操作编号 (0 - 9): "
    if not defined choice (
        echo 输入不能为空，请输入（0 - 9）之间的数字。
        timeout /t 2 >nul
		rem 定义要返回的菜单
        goto menu
    )
	
	if "%choice%"=="1" goto git_menu
	if "%choice%"=="2" goto hugo_commands
	if "%choice%"=="3" goto push_menu
	if "%choice%"=="4" goto Pull_updates
	if "%choice%"=="5" goto update_tags
	if "%choice%"=="6" goto dakai_tucuang
	if "%choice%"=="7" goto samba_menu
	if "%choice%"=="8" goto zhaxiang_menu
	if "%choice%"=="0" goto exit_script

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
    Write-Host '* 2. 安装 Git                               *' -ForegroundColor Magenta; ^
	Write-Host '* 3. 更新 Git 版本                          *' -ForegroundColor Blue; ^
    Write-Host '* 4. 查看 Git 版本                          *' -ForegroundColor Red; ^
    Write-Host '* 5. 克隆 Git 仓库                          *' -ForegroundColor DarkYellow; ^
    Write-Host '* 6. 设置 Git 用户名和邮箱                  *' -ForegroundColor DarkGreen; ^
    Write-Host '* 7. 设置 Git 代理                          *' -ForegroundColor DarkBlue; ^
	Write-Host '* 8. 取消 Git 代理                          *' -ForegroundColor DarkCyan; ^
    Write-Host '* 9. 返回主菜单                             *' -ForegroundColor White; ^
    Write-Host '* 0. 退出                                   *' -ForegroundColor White; ^
    Write-Host '*********************************************' -ForegroundColor Yellow"

	rem 提示用户输入编号
    set "choice="
    set /p choice="请输入操作编号 (0 - 9): "
    if not defined choice (
        echo 输入不能为空，请输入（0 - 9）之间的数字。
        timeout /t 2 >nul
		rem 定义要返回的菜单
        goto git_menu
    )
	
	if "%choice%"=="1" call :install_scoop && goto git_menu
	if "%choice%"=="2" call :install_git && goto git_menu
	if "%choice%"=="3" call :update_git && goto git_menu
	if "%choice%"=="4" call :check_git_version && goto git_menu
	if "%choice%"=="5" call :clone_git_repo && goto git_menu
	if "%choice%"=="6" call :set_user_name && goto git_menu
	if "%choice%"=="7" call :set_git_proxy && goto git_menu
	if "%choice%"=="8" call :unset_git_proxy && goto git_menu
	if "%choice%"=="9" goto menu
	if "%choice%"=="0" goto exit_script

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

	echo 按任意键返回菜单...
    pause >nul
	rem 定义要返回的菜单
	goto git_menu
	
    rem echo 即将在 2 秒后返回 ...
	rem powershell -Command "Start-Sleep -Seconds 2"
	rem 定义要返回的菜单
	rem goto git_menu

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
	
	echo 按任意键返回菜单...
    pause >nul
	rem 定义要返回的菜单
	goto git_menu
	
    rem echo 即将在 2 秒后返回 ...
	rem powershell -Command "Start-Sleep -Seconds 2"
	rem 定义要返回的菜单
	rem goto git_menu

    endlocal

rem ========================= （3）更新 Git 版本 ============================
:update_git
    echo 正在更新 Git 版本...
    git update-git-for-windows
	
    echo 即将在 1 秒后返回 ...
	powershell -Command "Start-Sleep -Seconds 1"
	rem 定义要返回的菜单
	goto git_menu  rem 定义要返回的菜单

rem ========================= （4）查看 Git 版本 ============================
:check_git_version
    echo 正在查看 Git 版本...
    git --version
    if %errorlevel% neq 0 (
        echo 无法获取 Git 版本信息，可能 Git 未安装。
    )
	
	echo 按任意键返回菜单...
    pause >nul
	goto git_menu  rem 定义要返回的菜单

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
	
    echo 即将在 1 秒后返回 ...
	powershell -Command "Start-Sleep -Seconds 1"
	rem 定义要返回的菜单
	goto git_menu

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
	
    echo 即将在 1 秒后返回 ...
	powershell -Command "Start-Sleep -Seconds 1"
	rem 定义要返回的菜单
	goto git_menu

rem ========================= （7）设置 Git 代理 ============================
:set_git_proxy
    git config --global --unset http.proxy
    git config --global --unset https.proxy
	echo Git 取消历史配置成功
	
    git config --global http.proxy 127.0.0.1:7890
    git config --global https.proxy 127.0.0.1:7890
    echo Git 代理已设置为 http://127.0.0.1:7890 和 https://127.0.0.1:7890
	
    echo 即将在 1 秒后返回 ...
	powershell -Command "Start-Sleep -Seconds 1"
	rem 定义要返回的菜单
	goto git_menu
	
rem ========================= （8）取消 Git 代理 ============================
:unset_git_proxy
    git config --global --unset http.proxy
    git config --global --unset https.proxy
	echo Git 取消历史配置成功
	
    echo 即将在 1 秒后返回 ...
	powershell -Command "Start-Sleep -Seconds 1"
	rem 定义要返回的菜单
	goto git_menu

rem ======================== 二 、Hugo_命令菜单 =============================
:hugo_commands
	rem 清屏，显示hugo命令子菜单
	cls

powershell -Command ^
"Clear-Host; ^
    Write-Host '*********************************************' -ForegroundColor Yellow; ^
    Write-Host '*************  Hugo_命令菜单  ***************' -ForegroundColor Green; ^
    Write-Host '*********************************************' -ForegroundColor Yellow; ^
	Write-Host '* 1. 安装 scoop                             *' -ForegroundColor Cyan; ^
    Write-Host '* 2. 安装 hugo                              *' -ForegroundColor Magenta; ^
    Write-Host '* 3. 查看 hugo 版本                         *' -ForegroundColor Blue; ^
    Write-Host '* 4. 新建文章                               *' -ForegroundColor Red; ^
    Write-Host '* 5. 打开文章目录                           *' -ForegroundColor DarkYellow; ^
    Write-Host '* 6. 运行 hugo                              *' -ForegroundColor DarkGreen; ^
    Write-Host '* 7. 浏览器打开 :1313                       *' -ForegroundColor DarkBlue; ^
    Write-Host '* 8. 运行 hugo 并打开                       *' -ForegroundColor DarkCyan; ^
    Write-Host '* 9. 返回主菜单                             *' -ForegroundColor White; ^
    Write-Host '* 0. 退出                                   *' -ForegroundColor White; ^
    Write-Host '*********************************************' -ForegroundColor Yellow"

	rem 提示用户输入编号
    set "choice="
    set /p choice="请输入操作编号 (0 - 9): "
    if not defined choice (
        echo 输入不能为空，请输入（0 - 9）之间的数字。
        timeout /t 2 >nul
		rem 定义要返回的菜单
        goto hugo_commands
    )

	if "%choice%"=="1" call :install_scoop && goto hugo_commands
	if "%choice%"=="2" call :install_hugo && goto hugo_commands
	if "%choice%"=="3" call :hugo_v && goto hugo_commands
	if "%choice%"=="4" call :create_article && goto hugo_commands
	if "%choice%"=="5" call :post_hugo && goto hugo_commands
	if "%choice%"=="6" call :run_hugo && goto hugo_commands
	if "%choice%"=="7" call :open_browser && goto hugo_commands
	if "%choice%"=="8" call :run_hugo_link && goto hugo_commands
	if "%choice%"=="9" goto menu
	if "%choice%"=="0" goto exit_script

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

    echo 即将在 1 秒后返回 ...
	powershell -Command "Start-Sleep -Seconds 1"
	rem 定义要返回的菜单
	goto git_menu  rem 定义要返回的菜单

rem =================== （2）安装 hugo =====================
:install_hugo
    REM 检查 winget 是否可用
    winget --version >nul 2>&1
    if %errorlevel% neq 0 (
        echo winget 不可用，请确保你的系统支持并已正确安装 winget。

	echo 即将在 2 秒后返回 Hugo 命令菜单...
	powershell -Command "Start-Sleep -Seconds 2"
	rem 定义要返回的菜单
	goto hugo_commands
    )

    echo 正在尝试以管理员权限安装 Hugo，请稍候...
    powershell -Command "Start-Process powershell -Verb runAs -ArgumentList 'winget install --id Hugo.Hugo.Extended -e --source winget'"
    if %errorlevel% neq 0 (
        echo Hugo 安装失败！
    ) else (
        echo Hugo 安装成功！
    )
	
    echo 即将在 1 秒后返回 ...
	powershell -Command "Start-Sleep -Seconds 1"
	rem 定义要返回的菜单
	goto hugo_commands

rem ================ （3）查看 hugo 版本 ========================
:hugo_v
	rem 启动一个新的命令行窗口并运行hugo服务器
	start cmd /k "hugo version"
	
    echo 即将在 1 秒后返回 ...
	powershell -Command "Start-Sleep -Seconds 1"
	rem 定义要返回的菜单
	goto hugo_commands

rem ================= （4）新建文章 =======================
:create_article
	rem 提示用户输入文章名字
	set /p name=请输入文章名字：

	rem 切换到hugo项目的根目录
	call :change_dir "%baseDir%\hugo-main" || (
		echo 无法切换到hugo项目根目录，请检查路径。
		pause >nul
		goto hugo_commands
	)

	rem 使用hugo命令创建新文章
	call hugo new "post\%name%\index.md"
	if %errorlevel% neq 0 (
		echo 文章创建失败，请检查Hugo配置或路径。
		pause >nul
		goto hugo_commands
	)

	echo 文章创建成功，正在打开typora.exe编辑器...

	rem 打开记事本编辑器编辑新创建的文章
	set articlePath=%baseDir%\hugo-main\content\post\%name%\index.md
	if not exist "%articlePath%" (
		echo 文章文件未正确生成，请检查Hugo配置。
		pause >nul
		goto hugo_commands
	)

	rem start "" "notepad.exe" "%articlePath%"
	start "" "typora.exe" "%articlePath%"
	if %errorlevel% neq 0 (
		echo 无法打开typora.exe编辑器，请检查typora.exe是否安装。
		pause >nul
	)
	echo 请在typora.exe中编辑文章，编辑完成后按任意键返回菜单。
	
    echo 即将在 1 秒后返回 ...
	powershell -Command "Start-Sleep -Seconds 1"
	rem 定义要返回的菜单
	goto hugo_commands  rem 定义要返回的菜单

rem ================== （5）打开文章目录 ======================
:post_hugo
	rem 定义目标目录（使用 %USERPROFILE% 使路径通用）
	start "" "%baseDir%\hugo-main\content\post"
	
    echo 即将在 1 秒后返回 ...
	powershell -Command "Start-Sleep -Seconds 1"
	rem 定义要返回的菜单
	goto hugo_commands

rem ================== （6）运行 hugo ======================
:run_hugo
	call :change_dir "%baseDir%\hugo-main" || (
		echo 无法切换到hugo项目根目录，请检查路径。
		pause >nul
		goto hugo_commands
	)
	rem 启动一个新的命令行窗口并运行hugo服务器
	start cmd /k "hugo server -D"
	
    echo 即将在 1 秒后返回 ...
	powershell -Command "Start-Sleep -Seconds 1"
	rem 定义要返回的菜单
	goto hugo_commands

rem ================== （7）浏览器打开 :1313 ======================
:open_browser
	echo 本地服务器已启动，请访问 http://localhost:1313/，浏览器打开。
	timeout /t 2 >nul
	echo 浏览器已自动打开本地Hugo页面。
	rem 打开浏览器访问本地hugo服务器
	start "" "http://localhost:1313"
	
    echo 即将在 1 秒后返回 ...
	powershell -Command "Start-Sleep -Seconds 1"
	rem 定义要返回的菜单
	goto hugo_commands

rem ================== （8）运行 hugo 并打开   ======================
:run_hugo_link
	call :change_dir "%baseDir%\hugo-main" || (
		echo 无法切换到hugo项目根目录，请检查路径。
		pause >nul
		goto hugo_commands
	)
	rem 启动一个新的命令行窗口并运行hugo服务器
	start cmd /k "hugo server -D"
	echo 本地服务器已启动，请访问 http://localhost:1313/，浏览器将在服务器启动后5秒内自动打开。
	timeout /t 3 >nul
	echo 浏览器已自动打开本地Hugo页面。
	rem 打开浏览器访问本地hugo服务器
	start "" "http://localhost:1313"
	
    echo 即将在 1 秒后返回 ...
	powershell -Command "Start-Sleep -Seconds 1"
	rem 定义要返回的菜单
	goto hugo_commands


rem =======================  三 、GitHub 项目推送  ==============================
:push_menu
	rem 清屏，显示项目提交子菜单
	cls
powershell -Command ^
"Clear-Host; ^
    Write-Host '*********************************************' -ForegroundColor Yellow; ^
    Write-Host '**************  GitHub 项目推送  ************' -ForegroundColor Green; ^
    Write-Host '*********************************************' -ForegroundColor Yellow; ^
    Write-Host '* 1. 项目推送：hugo-main                    *' -ForegroundColor Cyan; ^
    Write-Host '* 2. 项目推送：music                        *' -ForegroundColor Magenta; ^
    Write-Host '* 3. 项目推送：file                         *' -ForegroundColor Blue; ^
    Write-Host '* 4. 项目推送：bat                          *' -ForegroundColor Red; ^
    Write-Host '* 5. 项目推送：random-pic-api               *' -ForegroundColor DarkYellow; ^
    Write-Host '* 6. 项目推送：compose                      *' -ForegroundColor DarkGreen; ^
    Write-Host '* 7. 项目推送：sh                           *' -ForegroundColor DarkBlue; ^
	Write-Host '* 8. 项目推送：所有项目                     *' -ForegroundColor DarkCyan; ^
    Write-Host '* 9. 返回主菜单                             *' -ForegroundColor White; ^
    Write-Host '* 0. 退出                                   *' -ForegroundColor White; ^
    Write-Host '*********************************************' -ForegroundColor Yellow"

	rem 提示用户输入编号
    set "choice="
    set /p choice="请输入操作编号 (0 - 9): "
    if not defined choice (
        echo 输入不能为空，请输入（0 - 9）之间的数字。
        timeout /t 2 >nul
		rem 定义要返回的菜单
        goto submenu
    )

	if "%choice%"=="1" set "REPO_PATH=%baseDir%\hugo-main" && call :ValidateRepoAndCommit && goto after_commit
	if "%choice%"=="2" set "REPO_PATH=%baseDir%\music" && call :ValidateRepoAndCommit && goto after_commit
	if "%choice%"=="3" set "REPO_PATH=%baseDir%\file" && call :ValidateRepoAndCommit && goto after_commit
	if "%choice%"=="4" set "REPO_PATH=%baseDir%\bat" && call :ValidateRepoAndCommit && goto after_commit
	if "%choice%"=="5" set "REPO_PATH=%baseDir%\random-pic-api" && call :ValidateRepoAndCommit && goto after_commit
	if "%choice%"=="6" set "REPO_PATH=%baseDir%\compose" && call :ValidateRepoAndCommit && goto after_commit
	if "%choice%"=="7" set "REPO_PATH=%baseDir%\sh" && call :ValidateRepoAndCommit && goto after_commit
	if "%choice%"=="8" set "REPO_PATH=%baseDir%\" && call :git_push_add && goto after_commit
	if "%choice%"=="9" goto menu
	if "%choice%"=="0" goto exit_script

:ValidateRepoAndCommit
	REM 检查目标目录是否存在
	IF NOT EXIST "%REPO_PATH%" (
		CALL :ShowError "错误：目录 %REPO_PATH% 不存在，请检查路径！"
		exit /b 1
	)

	REM 切换到目标目录
	CD /D "%REPO_PATH%" 2>NUL
	IF ERRORLEVEL 1 (
		CALL :ShowError "错误：无法切换到目录 %REPO_PATH%，请检查 Git 仓库。"
		exit /b 1
	)

	REM 检查是否为有效的 Git 仓库
	IF NOT EXIST .git (
		CALL :ShowError "错误：目录 %REPO_PATH% 不是一个有效的 Git 仓库。"
		exit /b 1
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
	echo 按任意键返回菜单...
    pause >nul
	rem 定义要返回的菜单
	goto push_menu
	
    rem echo 即将在 2 秒后返回 ...
	rem powershell -Command "Start-Sleep -Seconds 2"
	rem 定义要返回的菜单
	rem goto push_menu

rem ================== 推送所有项目 ======================
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

	echo 按任意键返回菜单...
    pause >nul
	rem 定义要返回的菜单
	goto push_menu
	
    rem echo 即将在 2 秒后返回 ...
	rem powershell -Command "Start-Sleep -Seconds 2"
	rem 定义要返回的菜单
	rem goto push_menu

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
    Write-Host '* 3. 拉取更新：file                         *' -ForegroundColor Blue; ^
    Write-Host '* 4. 拉取更新：bat                          *' -ForegroundColor Red; ^
    Write-Host '* 5. 拉取更新：random-pic-api               *' -ForegroundColor DarkYellow; ^
    Write-Host '* 6. 拉取更新：compose                      *' -ForegroundColor DarkGreen; ^
    Write-Host '* 7. 拉取更新：sh                           *' -ForegroundColor DarkBlue; ^
    Write-Host '* 8. 拉取更新：所有项目                     *' -ForegroundColor DarkCyan; ^
    Write-Host '* 9. 返回主菜单                             *' -ForegroundColor White; ^
    Write-Host '* 0. 退出                                   *' -ForegroundColor White; ^
    Write-Host '*********************************************' -ForegroundColor Yellow"

	rem 提示用户输入编号
    set "choice="
    set /p choice="请输入操作编号 (0 - 9): "
    if not defined choice (
        echo 输入不能为空，请输入（0 - 9）之间的数字。
        timeout /t 2 >nul
		rem 定义要返回的菜单
        goto Pull_updates
    )
	
	if "%choice%"=="1" call :update_single_project "%baseDir%\hugo-main" && goto after_update
	if "%choice%"=="2" call :update_single_project "%baseDir%\music" && goto after_update
	if "%choice%"=="3" call :update_single_project "%baseDir%\file" && goto after_update
	if "%choice%"=="4" call :update_single_project "%baseDir%\bat" && goto after_update
	if "%choice%"=="5" call :update_single_project "%baseDir%\random-pic-api" && goto after_update
	if "%choice%"=="6" call :update_single_project "%baseDir%\compose" && goto after_update
	if "%choice%"=="7" call :update_single_project "%baseDir%\sh" && goto after_update
	if "%choice%"=="8" call :update_all_projects && goto after_update
	if "%choice%"=="9" goto menu
	if "%choice%"=="0" goto exit_script

:update_single_project
	SET "REPO_PATH=%~1"
	REM 检查目标目录是否存在
	IF NOT EXIST "%REPO_PATH%" (
		echo ===========================================
		echo 错误：目录 %REPO_PATH% 不存在，请检查路径！
		echo ===========================================
		pause
		exit /b 1
	)
	REM 切换到目标目录
	CD /D "%REPO_PATH%"
	REM 检查是否为有效的 Git 仓库
	IF NOT EXIST .git (
		echo ===========================================
		echo 错误：目录 %REPO_PATH% 不是一个有效的 Git 仓库。
		echo ===========================================
		pause
		exit /b 1
	)
	REM 确保当前分支是 main 分支
	git rev-parse --abbrev-ref HEAD >nul 2>&1
	IF ERRORLEVEL 1 (
		echo ===========================================
		echo 错误：无法检测当前分支，请确保这是一个有效的 Git 仓库。
		echo ===========================================
		pause
		exit /b 1
	)
	SET CURRENT_BRANCH=main
	git checkout %CURRENT_BRANCH% >nul 2>&1
	IF ERRORLEVEL 1 (
		echo ===========================================
		echo 错误：无法切换到分支 %CURRENT_BRANCH%，请检查分支名称。
		echo ===========================================
		pause
		exit /b 1
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
		exit /b 1
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
	exit /b 0

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
	exit /b 0

:after_update
	echo 按任意键返回菜单...
    pause >nul
	rem 定义要返回的菜单
	goto Pull_updates
	
    rem echo 即将在 2 秒后返回 ...
	rem powershell -Command "Start-Sleep -Seconds 2"
	rem 定义要返回的菜单
	rem goto submenu rem 定义要返回的菜单

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
    Write-Host '* 3. 更新标签：file                         *' -ForegroundColor Blue; ^
    Write-Host '* 4. 更新标签：random-pic-api               *' -ForegroundColor Red; ^
    Write-Host '* 5. 更新标签：bat                          *' -ForegroundColor DarkYellow; ^
    Write-Host '* 6. 更新标签：sh                           *' -ForegroundColor DarkGreen; ^
    Write-Host '* 9. 返回主菜单                             *' -ForegroundColor White; ^
    Write-Host '* 0. 退出                                   *' -ForegroundColor White; ^
    Write-Host '*********************************************' -ForegroundColor Yellow"

	rem 提示用户输入编号
    set "choice="
    set /p choice="请输入操作编号 (0 - 9): "
    if not defined choice (
        echo 输入不能为空，请输入（0 - 9）之间的数字。
        timeout /t 2 >nul
		rem 定义要返回的菜单
        goto update_tags
    )

	if "%choice%"=="1" set "projectDir=%baseDir%\hugo-main" && call :update_project_tags && goto after_update
	if "%choice%"=="2" set "projectDir=%baseDir%\music" && call :update_project_tags && goto after_update
	if "%choice%"=="3" set "projectDir=%baseDir%\file" && call :update_project_tags && goto after_update
	if "%choice%"=="4" set "projectDir=%baseDir%\random-pic-api" && call :update_project_tags && goto after_update
	if "%choice%"=="5" set "projectDir=%baseDir%\bat" && call :update_project_tags && goto after_update
	if "%choice%"=="6" set "projectDir=%baseDir%\sh" && call :update_project_tags && goto after_update
	if "%choice%"=="9" goto menu
	if "%choice%"=="0" goto exit_script

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
		pause
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
		pause
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
		pause
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
		pause
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
		pause
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
		pause
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
		pause
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
	echo 按任意键返回菜单...
    pause >nul
	rem 定义要返回的菜单
	goto update_tags
	
    rem echo 即将在 2 秒后返回 ...
	rem powershell -Command "Start-Sleep -Seconds 2"
	rem 定义要返回的菜单
	rem goto update_tags

rem ======================== 六 、打开图床目录 =============================
:dakai_tucuang
	rem 清屏，显示hugo命令子菜单
	cls
powershell -Command ^
"Clear-Host; ^
    Write-Host '*********************************************' -ForegroundColor Yellow; ^
    Write-Host '*************  打开图床目录  ****************' -ForegroundColor Green; ^
    Write-Host '*********************************************' -ForegroundColor Yellow; ^
    Write-Host '* 1. vercel图床 封面图片                    *' -ForegroundColor Cyan; ^
    Write-Host '* 2. vercel图床 截屏图片                    *' -ForegroundColor Magenta; ^
    Write-Host '* 3. vercel图床 GIF图片                     *' -ForegroundColor Blue; ^
    Write-Host '* 4. nginx图床 封面图片                     *' -ForegroundColor Red; ^
    Write-Host '* 5. nginx图床 截屏图片                     *' -ForegroundColor DarkYellow; ^
    Write-Host '* 6. nginx图床 GIF图片                      *' -ForegroundColor DarkGreen; ^
    Write-Host '* 7. vercel+nginx 封面图片                  *' -ForegroundColor DarkBlue; ^
    Write-Host '* 8. vercel+nginx 截屏图片                  *' -ForegroundColor DarkCyan; ^
    Write-Host '* 9. 返回主菜单                             *' -ForegroundColor White; ^
    Write-Host '* 0. 退出                                   *' -ForegroundColor White; ^
    Write-Host '*********************************************' -ForegroundColor Yellow"

	rem 提示用户输入编号
    set "choice="
    set /p choice="请输入操作编号 (0 - 9): "
    if not defined choice (
        echo 输入不能为空，请输入（0 - 9）之间的数字。
        timeout /t 2 >nul
		rem 定义要返回的菜单
        goto dakai_tucuang
    )

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
	
rem ==========================  七 、打开常用目录  ===========================
:samba_menu
	rem 清屏，显示 Git 命令子菜单
	cls

powershell -Command ^
"Clear-Host; ^
    Write-Host '*********************************************' -ForegroundColor Yellow; ^
    Write-Host '*****************  打开常用目录  ************' -ForegroundColor Green; ^
    Write-Host '*********************************************' -ForegroundColor Yellow; ^
	Write-Host '* 1. 打开_Debian                            *' -ForegroundColor Cyan; ^
    Write-Host '* 2. 打开_Ubuntu                            *' -ForegroundColor Magenta; ^
	Write-Host '* 3. 打开_CentOS                            *' -ForegroundColor Blue; ^
    Write-Host '* 4. 打开_Alpine                            *' -ForegroundColor Red; ^
    Write-Host '* 5. 打开_Pve                               *' -ForegroundColor DarkYellow; ^
    Write-Host '* 6. 打开_本地阿里云盘                      *' -ForegroundColor DarkGreen; ^
    Write-Host '* 7. 打开_SMB阿里云盘                       *' -ForegroundColor DarkBlue; ^
	Write-Host '* 8. 打开_本地+SMB阿里云盘                  *' -ForegroundColor DarkCyan; ^
    Write-Host '* 9. 返回主菜单                             *' -ForegroundColor White; ^
    Write-Host '* 0. 退出                                   *' -ForegroundColor White; ^
    Write-Host '*********************************************' -ForegroundColor Yellow"

	rem 提示用户输入编号
    set "choice="
    set /p choice="请输入操作编号 (0 - 9): "
    if not defined choice (
        echo 输入不能为空，请输入（0 - 9）之间的数字。
        timeout /t 2 >nul
		rem 定义要返回的菜单
        goto git_menu
    )
	
	if "%choice%"=="1" call :samba_debian && goto samba_menu
	if "%choice%"=="2" call :samba_ubuntu && goto samba_menu
	if "%choice%"=="3" call :samba_centos && goto samba_menu
	if "%choice%"=="4" call :samba_alpine && goto samba_menu
	if "%choice%"=="5" call :samba_pve && goto samba_menu
	if "%choice%"=="6" call :samba_bendi_ali && goto samba_menu
	if "%choice%"=="7" call :samba_smb_ali && goto samba_menu
	if "%choice%"=="8" call :samba_bendi_smb_ali && goto samba_menu
	if "%choice%"=="9" goto menu
	if "%choice%"=="0" goto exit_script

rem ========================= （1）打开_Debian ============================
:samba_debian
	set ip=10.10.10.245\Debian
	set username=admin
	set password=yifan0719

	rem 使用net use命令连接Samba共享
	net use \\%ip% /user:%username% %password%
	REM 打开资源管理器并定位到Samba共享
	explorer \\%ip%
	rem 定义要返回的菜单
	goto samba_menu

rem ========================= （2）打开_Ubuntu ============================
:samba_ubuntu
	set ip=10.10.10.247\Ubuntu
	set username=admin
	set password=yifan0719

	REM 使用net use命令连接Samba共享
	net use \\%ip% /user:%username% %password%
	REM 打开资源管理器并定位到Samba共享
	explorer \\%ip%
	rem 定义要返回的菜单
	goto samba_menu

rem ========================= （3）打开_CentOS ============================
:samba_centos
    :: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    echo 此项未配置，2 秒后返回 ...
	powershell -Command "Start-Sleep -Seconds 1"
	rem 定义要返回的菜单
	goto samba_menu
    :: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx	
	set ip=10.10.10.246\CentOS
	set username=admin
	set password=yifan0719

	REM 使用net use命令连接Samba共享
	net use \\%ip% /user:%username% %password%
	REM 打开资源管理器并定位到Samba共享
	taskkill /f /im explorer.exe >nul 2>&1
	start explorer.exe \\%ip%
	goto samba_menu

rem ========================= （4）打开_Alpine ============================
:samba_alpine
    :: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    echo 此项未配置，2 秒后返回 ...
	powershell -Command "Start-Sleep -Seconds 1"
	rem 定义要返回的菜单
	goto samba_menu
    :: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
	
    set ip=10.10.10.242\Alpine
    set username=admin
    set password=yifan0719

	REM 使用net use命令连接Samba共享
	net use \\%ip% /user:%username% %password%
	REM 打开资源管理器并定位到Samba共享
    explorer "\\%ip%"
    rem 定义要返回的菜单
    goto samba_menu
	
rem ========================= （5）打开_Pve ============================
:samba_pve
	set ip=10.10.10.254
	set username=root
	set password=yifan0719

	REM 使用net use命令连接Samba共享
	net use \\%ip% /user:%username% %password%
	REM 打开资源管理器并定位到Samba共享
	explorer \\%ip%
	rem 定义要返回的菜单
	goto samba_menu
	
rem ========================= （6）打开_本地阿里云盘 ============================
:samba_bendi_ali
	start "" "E:\教程文件"
	rem 定义要返回的菜单
	goto samba_menu
	
rem ========================= （7）打开_SMB阿里云盘 ============================
:samba_smb_ali
	set ip=10.10.10.254\PVE-ntfs\阿里云盘\教程文件
	set username=root
	set password=yifan0719

	REM 使用net use命令连接Samba共享
	net use \\%ip% /user:%username% %password%
	REM 打开资源管理器并定位到Samba共享
	explorer \\%ip%
	rem 定义要返回的菜单
	goto samba_menu
	
rem ========================= （8）打开_本地+SMB阿里云盘 ============================
:samba_bendi_smb_ali
	start "" "E:\教程文件"
	
	set ip=10.10.10.254\PVE-ntfs\阿里云盘\教程文件
	set username=root
	set password=yifan0719

	REM 使用net use命令连接Samba共享
	net use \\%ip% /user:%username% %password%
	REM 打开资源管理器并定位到Samba共享
	explorer \\%ip%
	rem 定义要返回的菜单
	goto samba_menu
	
rem ==========================  八 、杂项菜单  ===========================
:zhaxiang_menu
	rem 清屏，显示 Git 命令子菜单
	cls

powershell -Command ^
"Clear-Host; ^
    Write-Host '*********************************************' -ForegroundColor Yellow; ^
    Write-Host '*****************  杂项菜单  ****************' -ForegroundColor Green; ^
    Write-Host '*********************************************' -ForegroundColor Yellow; ^
	Write-Host '* 1. 批量克隆所有项目                       *' -ForegroundColor Cyan; ^
    Write-Host '* 2. 批量修改为SSH连接                      *' -ForegroundColor Magenta; ^
	Write-Host '* 3. 预整理photos壁纸                       *' -ForegroundColor Blue; ^
    Write-Host '* 4. 整理photos壁纸api                      *' -ForegroundColor Red; ^
    Write-Host '* 5. XXXXXXXXXXXXX                          *' -ForegroundColor DarkYellow; ^
    Write-Host '* 6. XXXXXXXXXXXXX                          *' -ForegroundColor DarkGreen; ^
    Write-Host '* 7. XXXXXXXXXXXXX                          *' -ForegroundColor DarkBlue; ^
	Write-Host '* 8. XXXXXXXXXXXXX                          *' -ForegroundColor DarkCyan; ^
    Write-Host '* 9. 返回主菜单                             *' -ForegroundColor White; ^
    Write-Host '* 0. 退出                                   *' -ForegroundColor White; ^
    Write-Host '*********************************************' -ForegroundColor Yellow"
	
	rem 提示用户输入编号
    set "choice="
    set /p choice="请输入操作编号 (0 - 9): "
    if not defined choice (
        echo 输入不能为空，请输入（0 - 9）之间的数字。
        timeout /t 2 >nul
		rem 定义要返回的菜单
        goto zhaxiang_menu
    )
	
	if "%choice%"=="1" call :git_clone_add && goto zhaxiang_menu
	if "%choice%"=="2" call :git_ssh_add && goto zhaxiang_menu
	if "%choice%"=="3" call :downloads_photos && goto zhaxiang_menu
	if "%choice%"=="4" call :debian_photos && zhaxiang_menu
	if "%choice%"=="5" call :clone_git_repo && zhaxiang_menu
	if "%choice%"=="6" call :set_user_name && zhaxiang_menu
	if "%choice%"=="7" call :set_git_proxy && zhaxiang_menu
	if "%choice%"=="8" call :unset_git_proxy && zhaxiang_menu
	if "%choice%"=="9" goto menu
	if "%choice%"=="0" goto exit_script

rem ========================= （1）批量克隆所有项目 ============================
:git_clone_add
	echo %baseDir%
	echo ==================================================
	:: 检查目标目录是否存在，如果不存在则创建
	if not exist "%baseDir%" (
		mkdir "%baseDir%"
	)

	:: 进入目标目录
	cd /d "%baseDir%"

	:: 定义要克隆的仓库列表
	set "repos=https://github.com/meimolihan/music.git https://github.com/meimolihan/file.git https://github.com/meimolihan/bat.git https://github.com/meimolihan/hugo-main.git https://github.com/meimolihan/sh.git https://github.com/meimolihan/random-pic-api.git https://github.com/meimolihan/compose.git https://github.com/meimolihan/typecho_Pytools.git"

	echo ==================================================
	echo 开始克隆所有仓库
	echo ==================================================

	:: 循环克隆每个仓库
	for %%i in (%repos%) do (
		echo --------------------------------------------------
		echo 正在克隆仓库: %%i
		git clone %%i
		if %errorlevel% equ 0 (
			echo 仓库 %%i 克隆成功。
		) else (
			echo 仓库 %%i 克隆失败。
		)
		echo --------------------------------------------------
	)
	echo ==================================================
	echo 所有仓库克隆操作完成。
	echo ==================================================

	echo 按任意键返回菜单...
    pause >nul
	rem 定义要返回的菜单
	goto zhaxiang_menu

rem ========================= （2）批量修改为SSH连接 ============================
:git_ssh_add
	echo 基础工作目录: %baseDir%

	REM 检查基础工作目录是否存在
	if not exist "%baseDir%" (
		echo 错误：基础工作目录 %baseDir% 不存在。
		pause
		exit /b 1
	)

	REM 定义要操作的目录
	set "dirs=bat hugo-main file music compose sh"
	REM 定义对应的 Git 仓库地址
	set "repos=git@github.com:meimolihan/bat.git git@github.com:meimolihan/hugo-main.git git@github.com:meimolihan/file.git git@github.com:meimolihan/music.git git@github.com:meimolihan/compose.git git@github.com:meimolihan/sh.git"

	REM 将目录和仓库地址拆分成数组
	set i=0
	for %%a in (%dirs%) do (
		set "dir[!i!]=%%a"
		set /a i+=1
	)
	set i=0
	for %%a in (%repos%) do (
		set "repo[!i!]=%%a"
		set /a i+=1
	)

	REM 遍历目录和仓库地址，依次设置 Git 远程仓库 URL
	set count=0
	for %%i in (%dirs%) do (
		set "targetDir=%baseDir%\!dir[%count%]!"
		if not exist "!targetDir!" (
			echo 错误：目标目录 !targetDir! 不存在。
		) else (
			echo ===========================================================
			cd /d "!targetDir!"
			echo 正在尝试为 !targetDir! 设置 Git 远程仓库的 URL...
			git remote set-url origin !repo[%count%]!
			if !errorlevel! neq 0 (
				echo 错误：为 !targetDir! 设置 Git 远程仓库 URL 时出现问题。
			) else (
				echo 已成功为 !targetDir! 设置 Git 远程仓库 URL 为 !repo[%count%]!。
			)
		)
		set /a count+=1
	)
	echo ===========================================================
	
	echo 按任意键返回菜单...
    pause >nul
	rem 定义要返回的菜单
	goto zhaxiang_menu
	
rem ========================= （3）预整理photos壁纸 ============================
:downloads_photos
	:: 检查目录是否存在，不存在则创建
	set "targetDir=Y:\img\photos"
	if not exist "%targetDir%\" (
		mkdir "%targetDir%"
		echo 目录 "%targetDir%" 已创建。
	) else (
		echo 目录 "%targetDir%" 已存在。
	)

	:: 打开目标目录
	start "" "%targetDir%"
	
	echo 执行以下命令整理壁纸：
	echo ============================
	echo cd /mnt/img ^&^& python3 classify.py
	echo ============================
	
	:: 连接到远程服务器
	start cmd /k "ssh root@10.10.10.245"
	:: ssh root@10.10.10.245
	
	echo 按任意键返回菜单...
    pause >nul
	rem 定义要返回的菜单
	goto zhaxiang_menu

rem ========================= （4）整理photos壁纸API ============================
:debian_photos
	:: 检查目录是否存在，不存在则创建
	set "targetDir=Y:\mydisk\home\random-pic-api\photos"
	if not exist "%targetDir%\" (
		mkdir "%targetDir%"
		echo 目录 "%targetDir%" 已创建。
	) else (
		echo 目录 "%targetDir%" 已存在。
	)

	:: 打开目标目录
	start "" "%targetDir%"
	
	echo 执行以下命令整理壁纸：
	echo ============================
	echo cd /mnt/mydisk/home/random-pic-api ^&^& python3 classify.py
	echo ============================
	
	:: 连接到远程服务器
	start cmd /k "ssh root@10.10.10.245"
	:: ssh root@10.10.10.245
	
	echo 按任意键返回菜单...
    pause >nul
	rem 定义要返回的菜单
	goto zhaxiang_menu
	
rem ========================= （5）XXXXXXXXXXXXXXXXXXXXXX ============================


rem ===========================================================================
:exit_script
	echo 感谢使用，再见！
	timeout /t 2 >nul
	exit
rem ===========================================================================