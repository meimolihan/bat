@echo off
setlocal enabledelayedexpansion

rem ������Ҫ�滻������ old_url= ���滻������� new_url=
set "old_url=https://blog.mobufan.eu.org:666"
set "new_url=https://file.meimolihan.eu.org"

echo ���ڴ�������.md�ļ�...
echo ��ȷ���ѹر�����.md�ļ������ñ��ݣ�

for /r %%a in (*.md) do (
    echo ���ڴ����ļ���%%a
    powershell -Command "$raw = [System.IO.File]::ReadAllText(\"%%a\", [System.Text.Encoding]::UTF8); [System.IO.File]::WriteAllText(\"%%a\", ($raw -replace '%old_url%', '%new_url%'), [System.Text.Encoding]::UTF8)"
)

echo ������ɣ�
endlocal