@echo off
setlocal enabledelayedexpansion

rem �������ļ��Ƿ���ڣ����������ɾ��
if exist hugo.txt del hugo.txt

rem ������ǰĿ¼�µ��������ļ���
for /d %%D in (*) do (
    echo         '%%D', >> hugo.txt
)

echo ��ɡ��ļ���������д�� hugo.txt��
rem pause