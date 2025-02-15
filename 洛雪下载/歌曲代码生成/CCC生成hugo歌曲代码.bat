@echo off
setlocal enabledelayedexpansion

rem 检查输出文件是否存在，如果存在则删除
if exist hugo.txt del hugo.txt

rem 遍历当前目录下的所有子文件夹
for /d %%D in (*) do (
    echo         '%%D', >> hugo.txt
)

echo 完成。文件夹名称已写入 hugo.txt。
rem pause