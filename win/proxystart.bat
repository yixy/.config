@echo off

echo 打开代理...
echo=
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f >nul 2>nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /d "127.0.0.1:8001" /f >nul 2>nul
echo 打开代理完成

C:\0x37\v2XXX-windows-64\v2XXX.exe