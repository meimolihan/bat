@echo off
chcp 65001
md 1920x1080 2>nul

for %%a in (.\*.jpg .\*.png .\*.bmp .\*.tga .\*.jpeg .\*.webp .\*.jfif) do (
    ffmpeg -i "%%a" -vf "scale=1920:1080:force_original_aspect_ratio=decrease,pad=1920:1080:(ow-iw)/2:(oh-ih)/2:color=black@0" -pix_fmt rgba -compression_level 9 -y "1920x1080\%%~na.jpg"
)


