@echo off
chcp 65001
md 32x32 2>nul

for %%a in (.\*.jpg .\*.png .\*.bmp .\*.tga .\*.jpeg .\*.webp .\*.avif) do (
    ffmpeg -i "%%a" -vf "scale=32:32:force_original_aspect_ratio=decrease,pad=32:32:(ow-iw)/2:(oh-ih)/2:color=black@0" -pix_fmt rgba -y "32x32\%%~na.png"
)



rem 上面的pause为暂停命令，去掉rem者为启用(有错误的时候可开启-查看错误)。
rem 只能保存为png格式，其它格式将失去抠图后的`透明`视觉效果