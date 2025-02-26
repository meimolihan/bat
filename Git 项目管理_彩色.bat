@echo off
rem 启用延迟环境变量扩展，用于在代码块中正确处理变量的动态变化
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
rem 生成临时的 PowerShell 脚本文件
(
    echo Write-Host '*********************************************' -ForegroundColor Yellow
    echo Write-Host '*              Git 项目管理                 *' -ForegroundColor Green
    echo Write-Host '*********************************************' -ForegroundColor Yellow
    echo Write-Host '* 1. Git_命令菜单                           *' -ForegroundColor Cyan
    echo Write-Host '* 2. Hugo_命令菜单                          *' -ForegroundColor Magenta
    echo Write-Host '* 3. 项目_提交更新                          *' -ForegroundColor Red
    echo Write-Host '* 4. 项目_拉取更新                          *' -ForegroundColor Blue
    echo Write-Host '* 5. 项目_更新标签                          *' -ForegroundColor DarkYellow
    echo Write-Host '* 0. 退出                                   *' -ForegroundColor White
    echo Write-Host '*********************************************' -ForegroundColor Yellow
) > temp.ps1
rem 执行临时的 PowerShell 脚本文件
powershell -ExecutionPolicy Bypass -File temp.ps1

rem 删除临时的 PowerShell 脚本文件
del temp.ps1

rem 提示用户输入选择
set /p choice=请输入您的选择（0 - 9）：

rem 根据用户输入跳转到相应的功能模块
call :handle_choice %choice%
goto menu

::--------------------------
:: 功能模块
::--------------------------

:handle_choice
if "%~1"=="1" goto git_menu
if "%~1"=="2" goto hugo_commands
if "%~1"=="3" goto submenu
if "%~1"=="4" goto Pull_updates
if "%~1"=="5" goto update_tags
if "%~1"=="0"  (
    echo 正在退出...
    goto exit_script
)

echo 无效的选择，请输入（0 - 9）之间的数字。
timeout /t 2 >nul
goto menu

rem =====================================================
:git_menu
rem 清屏，显示 Git 命令子菜单
cls
(
    echo Write-Host '*********************************************' -ForegroundColor Yellow
    echo Write-Host '*               Git 命令菜单                *' -ForegroundColor Green
    echo Write-Host '*********************************************' -ForegroundColor Yellow
    echo Write-Host '1. 安装 Git 以管理员权限                    *' -ForegroundColor Cyan
    echo Write-Host '2. 查看 Git 版本                            *' -ForegroundColor Magenta
    echo Write-Host '3. 克隆 Git 仓库                            *' -ForegroundColor DarkCyan
    echo Write-Host '4. 设置 Git 用户名                          *' -ForegroundColor DarkGreen
    echo Write-Host '5. 设置 Git 用户邮箱                        *' -ForegroundColor DarkRed
    echo Write-Host '6. 设置 Git 代理                            *' -ForegroundColor DarkYellow
    echo Write-Host '9. 返回主菜单                               *' -ForegroundColor DarkBlue
    echo Write-Host '0. 退出                                     *' -ForegroundColor White
    echo Write-Host '*********************************************' -ForegroundColor Yellow
) > temp.ps1
powershell -ExecutionPolicy Bypass -File temp.ps1
del temp.ps1

set /p choice="请输入你的选择 (0 - 9): "

if "%choice%"=="1" call :install_git && goto git_menu
if "%choice%"=="2" call :check_git_version && goto git_menu
if "%choice%"=="3" call :clone_git_repo && goto git_menu
if "%choice%"=="4" call :set_user_name && goto git_menu
if "%choice%"=="5" call :set_user_email && goto git_menu
if "%choice%"=="6" call :set_git_proxy && goto git_menu
if "%choice%"=="9" goto menu
if "%choice%"=="0"  (
    echo 正在退出...
    goto exit_script
)

echo 无效的选择，请输入（0 - 9）之间的数字。
timeout /t 2 >nul
goto git_menu

rem ========================= 安装 Git 以管理员权限 ============================
:install_git
    REM 检查 winget 是否可用
    winget --version >nul 2>&1
    if %errorlevel% neq 0 (
        echo winget 不可用，请确保你的系统支持并已正确安装 winget。
        pause
        exit /b
    )

    echo 正在尝试以管理员权限安装 Git，请稍候...
    powershell -Command "Start-Process powershell -Verb runAs -ArgumentList 'winget install --id Git.Git -e --source winget -h'" > install_log.txt 2>&1
    if %errorlevel% neq 0 (
        echo Git 安装失败！
    ) else (
        echo Git 安装成功！
    )
    pause
    exit /b

rem ========================= 查看 Git 版本 ============================
:check_git_version
    echo 正在查看 Git 版本...
    git --version
    if %errorlevel% neq 0 (
        echo 无法获取 Git 版本信息，可能 Git 未安装。
    )
    pause
    exit /b

rem ========================= 克隆 Git 仓库 ============================
:clone_git_repo
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
    pause
    exit /b

rem ========================= 设置 Git 用户名 ============================
:set_user_name
    set /p userName="请输入用户名: "
    if "%userName%"=="" (
        echo 未输入有效的用户名，请重新运行脚本并输入正确的用户名。
        pause
        exit /b
    )
    git config --global user.name "%userName%"
    echo 用户名已设置为 %userName%
    pause
    exit /b

rem ========================= 设置 Git 用户邮箱 ============================
:set_user_email
    set /p userEmail="请输入用户邮箱: "
    if "%userEmail%"=="" (
        echo 未输入有效的用户邮箱，请重新运行脚本并输入正确的用户邮箱。
        pause
        exit /b
    )
    git config --global user.email "%userEmail%"
    echo 用户邮箱已设置为 %userEmail%
    pause
    exit /b

rem ========================= 设置 Git 代理 ============================
:set_git_proxy
    git config --global --unset http.proxy
    git config --global --unset https.proxy
	echo Git 取消历史配置成功
	
    git config --global http.proxy 127.0.0.1:7890
    git config --global https.proxy 127.0.0.1:7890
    echo Git 代理已设置为 http://127.0.0.1:7890 和 https://127.0.0.1:7890
    pause
    exit /b

rem ======================== Hugo_命令菜单 =============================
:hugo_commands
rem 清屏，显示hugo命令子菜单
cls
(
    echo Write-Host '*********************************************' -ForegroundColor Yellow
    echo Write-Host '*             Hugo_命令菜单                 *' -ForegroundColor Green
    echo Write-Host '*********************************************' -ForegroundColor Yellow
    echo Write-Host '* 1. 安装 hugo                              *' -ForegroundColor Cyan
    echo Write-Host '* 2. 查看 hugo 版本                         *' -ForegroundColor Magenta
    echo Write-Host '* 3. 新建文章                               *' -ForegroundColor DarkCyan
    echo Write-Host '* 4. 打开文章目录                           *' -ForegroundColor DarkGreen
    echo Write-Host '* 5. 运行 hugo                              *' -ForegroundColor DarkRed
    echo Write-Host '* 6. 浏览器打开 :1313                       *' -ForegroundColor DarkYellow
    echo Write-Host '* 7. 运行 hugo 并打开                       *' -ForegroundColor DarkBlue
    echo Write-Host '* 9. 返回主菜单                             *' -ForegroundColor White
    echo Write-Host '* 0. 退出                                   *' -ForegroundColor Gray
    echo Write-Host '*********************************************' -ForegroundColor Yellow
) > temp.ps1
powershell -ExecutionPolicy Bypass -File temp.ps1
del temp.ps1

rem 提示用户输入操作编号
set /p subchoice=请输入操作编号（0 - 9）：

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
    echo 正在退出...
    goto exit_script
)

echo 无效的选择，请输入（0 - 9）之间的数字。
timeout /t 2 >nul
goto hugo_commands

rem =================== 安装 hugo =====================
:install_hugo
    REM 检查 winget 是否可用
    winget --version >nul 2>&1
    if %errorlevel% neq 0 (
        echo winget 不可用，请确保你的系统支持并已正确安装 winget。
        pause
        exit /b
    )

    echo 正在尝试以管理员权限安装 Hugo，请稍候...
    powershell -Command "Start-Process powershell -Verb runAs -ArgumentList 'winget install --id Hugo.Hugo.Extended -e --source winget'" > install_log.txt 2>&1
    if %errorlevel% neq 0 (
        echo Hugo 安装失败！
    ) else (
        echo Hugo 安装成功！
    )
    pause
    exit /b

rem ================ 查看 hugo 版本 ========================
:hugo_v
rem 启动一个新的命令行窗口并运行hugo服务器
start cmd /k "hugo version"
pause >nul
exit /b

rem ================= 新建文章 =======================
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
call hugo new "post/%name%.md"
if %errorlevel% neq 0 (
    echo 文章创建失败，请检查Hugo配置或路径。
    pause >nul
    goto menu
)
echo 文章创建成功，正在打开notepad.exe编辑器...
rem 打开记事本编辑器编辑新创建的文章
start "" "notepad.exe" "%baseDir%\hugo-main\content\post\%name%.md"
if %errorlevel% neq 0 (
    echo 无法打开notepad.exe编辑器，请检查notepad.exe是否安装。
    pause >nul
)
echo 请在notepad.exe中编辑文章，编辑完成后按任意键返回菜单。
pause >nul
exit /b

rem ================== 打开文章目录 ======================
:post_hugo
:: 定义目标目录（使用 %USERPROFILE% 使路径通用）
start "" "%baseDir%\hugo-main\content\post"
pause >nul
exit /b

rem ================== 运行 hugo ======================
:run_hugo
call :change_dir "%baseDir%\hugo-main" || (
    echo 无法切换到hugo项目根目录，请检查路径。
    pause >nul
    goto menu
)
rem 启动一个新的命令行窗口并运行hugo服务器
start cmd /k "hugo server -D"
pause >nul
exit /b

rem ================== 浏览器打开 :1313 ======================
:open_browser
echo 本地服务器已启动，请访问 http://localhost:1313/，浏览器打开。
timeout /t 2 >nul
echo 浏览器已自动打开本地Hugo页面。
rem 打开浏览器访问本地hugo服务器
start "" "http://localhost:1313"
pause >nul
exit /b

rem ================== 运行 hugo 并打开   ======================
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
pause >nul
exit /b


rem ======================= GitHub 项目提交 ==============================
:submenu
rem 清屏，显示项目提交子菜单
cls
(
    echo Write-Host '*********************************************' -ForegroundColor Yellow
    echo Write-Host '*            GitHub 项目提交                *' -ForegroundColor Green
    echo Write-Host '*********************************************' -ForegroundColor Yellow
    echo Write-Host '* 1. 项目提交：hugo-main                    *' -ForegroundColor Cyan
    echo Write-Host '* 2. 项目提交：music                        *' -ForegroundColor Magenta
    echo Write-Host '* 3. 项目提交：file                         *' -ForegroundColor DarkCyan
    echo Write-Host '* 4. 项目提交：bat                          *' -ForegroundColor DarkGreen
    echo Write-Host '* 5. 项目提交：random-pic-api               *' -ForegroundColor DarkRed
    echo Write-Host '* 6. 项目提交：compose                      *' -ForegroundColor DarkYellow
    echo Write-Host '* 7. 项目提交：sh                           *' -ForegroundColor DarkBlue
    echo Write-Host '* 9. 返回主菜单                             *' -ForegroundColor White
    echo Write-Host '* 0. 退出                                   *' -ForegroundColor Gray
    echo Write-Host '*********************************************' -ForegroundColor Yellow
) > temp.ps1
powershell -ExecutionPolicy Bypass -File temp.ps1
del temp.ps1

rem 提示用户输入项目编号
set /p subchoice=请输入项目编号（0-9）：

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
    echo 正在退出...
    goto exit_script
)

echo 无效的选择，请输入（0 - 9）之间的数字。
timeout /t 2 >nul
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
    CALL :ShowMessage "没有文件需要提交。"
)

REM 提示完成
CALL :ShowMessage "脚本执行完成。"
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

rem =====================================================
:update_tags
rem 清屏，显示项目更新标签子菜单
cls
(
    echo Write-Host '*********************************************' -ForegroundColor Yellow
    echo Write-Host '*               项目更新标签                *' -ForegroundColor Green
    echo Write-Host '*********************************************' -ForegroundColor Yellow
    echo Write-Host '* 1. 更新标签：hugo-main                    *' -ForegroundColor Cyan
    echo Write-Host '* 2. 更新标签：music                        *' -ForegroundColor Magenta
    echo Write-Host '* 3. 更新标签：file                         *' -ForegroundColor DarkCyan
    echo Write-Host '* 4. 更新标签：random-pic-api               *' -ForegroundColor DarkGreen
    echo Write-Host '* 5. 更新标签：bat                          *' -ForegroundColor DarkRed
    echo Write-Host '* 6. 更新标签：sh                           *' -ForegroundColor DarkYellow
    echo Write-Host '* 9. 返回主菜单                             *' -ForegroundColor DarkBlue
    echo Write-Host '* 0. 退出                                   *' -ForegroundColor White
    echo Write-Host '*********************************************' -ForegroundColor Yellow
) > temp.ps1
powershell -ExecutionPolicy Bypass -File temp.ps1
del temp.ps1

rem 提示用户输入操作编号
set /p subchoice=请输入操作编号（0 - 9）：

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
    echo 正在退出...
    goto exit_script
)

echo 无效的选择，请输入（0 - 9）之间的数字。
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
pause >nul
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

rem ================================================================
:Pull_updates
rem 清屏，显示项目拉取更新子菜单
cls
(
    echo Write-Host '*********************************************' -ForegroundColor Yellow
    echo Write-Host '*          请选择要拉取更新的项目           *' -ForegroundColor Green
    echo Write-Host '*********************************************' -ForegroundColor Yellow
    echo Write-Host '* 1. 拉取更新：hugo-main                    *' -ForegroundColor Cyan
    echo Write-Host '* 2. 拉取更新：music                        *' -ForegroundColor Magenta
    echo Write-Host '* 3. 拉取更新：file                         *' -ForegroundColor DarkCyan
    echo Write-Host '* 4. 拉取更新：bat                          *' -ForegroundColor DarkGreen
    echo Write-Host '* 5. 拉取更新：random-pic-api               *' -ForegroundColor DarkRed
    echo Write-Host '* 6. 拉取更新：compose                      *' -ForegroundColor DarkYellow
    echo Write-Host '* 7. 拉取更新：sh                           *' -ForegroundColor DarkBlue
    echo Write-Host '* 8. 拉取更新：所有项目                     *' -ForegroundColor White
    echo Write-Host '* 9. 返回主菜单                             *' -ForegroundColor Gray
    echo Write-Host '* 0. 退出                                   *' -ForegroundColor DarkGray
    echo Write-Host '*********************************************' -ForegroundColor Yellow
) > temp.ps1
powershell -ExecutionPolicy Bypass -File temp.ps1
del temp.ps1

rem 提示用户输入项目编号
set /p subchoice=请输入项目编号（0 - 9）：

rem 根据用户输入跳转到相应的功能模块
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
    echo 正在退出...
    goto exit_script
)

echo 无效的选择，请输入（0 - 9）之间的数字。
timeout /t 2 >nul
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
echo ===========================================
echo 正在检查远程仓库是否有更新...
git fetch origin %CURRENT_BRANCH%
IF NOT "!ERRORLEVEL!"=="0" (
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
pause
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
        git pull origin main
        popd
        echo.
        echo.
    )
)
echo 所有项目更新完成。


rem ===========================================================================
:exit_script
echo 感谢使用，再见！
timeout /t 2 >nul
exit
rem ===========================================================================