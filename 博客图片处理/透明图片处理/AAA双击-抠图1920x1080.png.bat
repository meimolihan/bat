@echo off
chcp 65001
md 1920x1080 2>nul

for %%a in (.\*.jpg .\*.png .\*.bmp .\*.tga .\*.jpeg .\*.webp .\*.avif) do (
    ffmpeg -i "%%a" -vf "scale=1920:1080:force_original_aspect_ratio=decrease,pad=1920:1080:(ow-iw)/2:(oh-ih)/2:color=black@0" -pix_fmt rgba -y "1920x1080\%%~na.png"
)



rem �����pauseΪ��ͣ���ȥ��rem��Ϊ����(�д����ʱ��ɿ���-�鿴����)��
rem ֻ�ܱ���Ϊpng��ʽ��������ʽ��ʧȥ��ͼ���`͸��`�Ӿ�Ч��