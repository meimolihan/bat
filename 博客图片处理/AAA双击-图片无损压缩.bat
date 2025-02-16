@echo off
chcp 65001
md 压缩完成 2>nul

for %%a in (.\*.jpg .\*.png .\*.bmp .\*.tga .\*.jpeg .\*.webp .\*.avif) do (
    ffmpeg -i "%%a" -compression_level 0 -y "压缩完成\%%~na.jpg"
)

#compress_level：压缩等级为正整数，数值越大压缩等级越高
