@echo off
cd /d "%~dp0"
for %%F in (%*) do call :main %%F
rem pause
exit

:main
ffmpeg -i "%~1" "%~n1".jpg -y

rem 上面的pause为暂停命令，去掉rem者为启用(有错误的时候可开启-查看错误)。