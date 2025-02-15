 @echo off
setlocal enabledelayedexpansion

for %%F in (*) do (
set "file=%%F"
set "newFile=!file: =!"
ren "!file!" "!newFile!"
)

endlocal
echo 删除空格后的文件名已更新完毕！
 
rem pause    ::去掉rem执行暂停命令 
exit     ::去掉rem执行退出命令 
