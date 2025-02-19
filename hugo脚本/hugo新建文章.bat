@echo off
:: ���ù���Ŀ¼��ȷ��·����ȷ��
set "hugoDir=%USERPROFILE%\Desktop\GitHub\hugo-main"

:: ���Ŀ¼�Ƿ����
if not exist "%hugoDir%" (
    echo Ŀ��Ŀ¼ %hugoDir% �����ڣ�����·���Ƿ���ȷ��
    pause
    exit
)

:: ��ʾ�û������ļ���
set /p fileName=��������������

:: ����Ƿ��������ļ���
if "%fileName%"=="" (
    echo �ļ�������Ϊ�գ����������нű���������Ч���ļ�����
    pause
    exit
)

:: �л��� Hugo ��ĿĿ¼
cd /d "%hugoDir%"

:: ʹ�� hugo new ��������ļ�
echo ���ڴ������ļ�...
hugo new "post/%fileName%/index.md"

:: ����ļ��Ƿ񴴽��ɹ�
set "contentPath=%hugoDir%\content\post\%fileName%\index.md"
if not exist "%contentPath%" (
    echo �ļ� %fileName% �Ĵ���ʧ�ܣ����� Hugo �Ƿ���ȷ��װ�����á�
    pause
    exit
)

:: ��ʾ�û��ļ��Ѵ���
echo �ļ� %fileName% �ѳɹ������� %contentPath%��

:: �򿪼��±��������ļ����˳�CMD
echo ���ڴ򿪼��±�...
start notepad.exe "%contentPath%"
exit