@echo off
chcp 65001

for %%a in (.\*.png .\*.bmp .\*.tga .\*.jpeg .\*.webp .\*.avif) do (
    ffmpeg -i "%%a" -c copy -y "%%~na.ico"
)


rem 上面的pause为暂停命令，去掉rem者为启用(有错误的时候可开启-查看错误)。