@echo off
cd /d "%~dp0"
for %%F in (%*) do call :main %%F
rem pause
exit

:main
ffmpeg -i "%~1" "%~n1".jpg -y

rem �����pauseΪ��ͣ���ȥ��rem��Ϊ����(�д����ʱ��ɿ���-�鿴����)��