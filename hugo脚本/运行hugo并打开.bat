@echo off
pushd "%USERPROFILE%\Desktop\GitHub\hugo-main"
start "" cmd /k "hugo server -D"
timeout /t 5 /nobreak >nul
start http://localhost:1313/
