@echo off
setlocal EnableDelayedExpansion

rem 获取当前目录路径
set "current_dir=%cd%"

rem 遍历当前目录下的文件
for %%a in ("%current_dir%\*.*") do (
  rem 判断是否为.bat文件，不是则进行移动操作
  if not "%%~xa"==".bat" (
    rem 获取文件名（不包括扩展名）
    set "filename=%%~na"
    rem 创建新文件夹
    md "!filename!" 2>nul
    rem 移动文件到新文件夹中
    move "%%a" "!filename!" >nul
  )
)

rem 结束批处理
exit
