@echo off
chcp 65001
md 150x150 2>nul

for %%a in (.\*.jpg .\*.png .\*.bmp .\*.tga .\*.jpeg .\*.webp .\*.avif) do (
    ffmpeg -i "%%a" -vf "scale=150:150:force_original_aspect_ratio=decrease,pad=150:150:(ow-iw)/2:(oh-ih)/2:color=black@0" -pix_fmt rgba -y "150x150\%%~na.png"
)



rem �����pauseΪ��ͣ���ȥ��rem��Ϊ����(�д����ʱ��ɿ���-�鿴����)��
rem ֻ�ܱ���Ϊpng��ʽ��������ʽ��ʧȥ��ͼ���`͸��`�Ӿ�Ч��