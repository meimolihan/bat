@echo off
setlocal enabledelayedexpansion

rem 定义需要替换的链接 old_url= 和替换后的链接 new_url=
set "old_url=https://blog.mobufan.eu.org:666"
set "new_url=https://file.meimolihan.eu.org"

echo 正在处理所有.md文件...
echo 请确保已关闭所有.md文件并做好备份！

for /r %%a in (*.md) do (
    echo 正在处理文件：%%a
    powershell -Command "$raw = [System.IO.File]::ReadAllText(\"%%a\", [System.Text.Encoding]::UTF8); [System.IO.File]::WriteAllText(\"%%a\", ($raw -replace '%old_url%', '%new_url%'), [System.Text.Encoding]::UTF8)"
)

echo 处理完成！
endlocal