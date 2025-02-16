@echo off
chcp 65001
md 150x150 2>nul

for %%a in (.\*.jpg .\*.png .\*.bmp .\*.tga .\*.jpeg .\*.webp) do (
    ffmpeg -i "%%a" -vf "scale=150:150:force_original_aspect_ratio=decrease,pad=150:150:(ow-iw)/2:(oh-ih)/2:color=black@0" -pix_fmt rgba -compression_level 9 -y "150x150\%%~na.jpg"
)


