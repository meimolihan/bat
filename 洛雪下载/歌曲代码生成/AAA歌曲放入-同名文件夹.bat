@echo off
setlocal EnableDelayedExpansion

rem ��ȡ��ǰĿ¼·��
set "current_dir=%cd%"

rem ������ǰĿ¼�µ��ļ�
for %%a in ("%current_dir%\*.*") do (
  rem �ж��Ƿ�Ϊ.bat�ļ�������������ƶ�����
  if not "%%~xa"==".bat" (
    rem ��ȡ�ļ�������������չ����
    set "filename=%%~na"
    rem �������ļ���
    md "!filename!" 2>nul
    rem �ƶ��ļ������ļ�����
    move "%%a" "!filename!" >nul
  )
)

rem ����������
exit
