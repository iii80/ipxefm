@echo off
cd /d %~dp0
mode con cols=50 lines=2
title=����MINI.WIM��......
copy "X:\Program Files\GhostCGI\ghost64.exe" X:\ipxefm\mini\Windows\System32\. /y
ver |find "2200"
if errorlevel 0 set pelist=mini_ntfs_21h2.txt&&echo win11
if errorlevel 1 set pelist=mini_ntfs.txt&&echo win10
echo ��������ͼ��
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3" /v "Settings" /t REG_BINARY /d "30000000feffffff22020000030000003e0000002800000000000000d802000056050000000300006000000001000000" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v HideSCANetwork /t REG_DWORD /d 1 /f
if exist "%~dp0mini\Program Files\PENetwork\penetwork.reg" reg import "%~dp0mini\Program Files\PENetwork\penetwork.reg"

if exist excel.txt del /q excel.txt
set wimlib="X:\Program Files\GhostCGI\wimlib64\wimlib-imagex.exe"
start "" "%programfiles%\WinXShell.exe" -ui -jcfg wxsUI\UI_LED.zip -top -text "��������MiNi.Wim,���Ժ�"
echo ��ȡWINPE�ļ�������Ȩ
takeown /f "%~dp0" /r /d y 1>nul
cacls "%~dp0data" /T /E /G Everyone:F 1>nul
takeown /f "%~dp04" /r /d y 1>nul
cacls "%~dp0" /T /E /G Everyone:F 1>nul
%wimlib% capture "%~dp0mini " "%~dp0mini.wim" "WindowsPE" --boot --compress=lzx --rebuild
echo �����б��С���

for /f "delims=" %%i in (%~dp0mini\%pelist%) do (
if exist %%i @echo add "%%i" "%%i">>excel.txt
)
echo ���ڰ��ļ����ӵ�wim����
%wimlib% update %~dp0mini.wim<excel.txt
echo �ٴθ��������ļ�

%wimlib% update %~dp0mini.wim --command="add mini \ "
%wimlib% optimize %~dp0mini.wim
start "" "X:\Program Files\WinXShell.exe" -code "QuitWindow(nil,'UI_LED')"
start "" "%programfiles%\WinXShell.exe" -ui -jcfg wxsUI\UI_LED.zip -top -wait 5 -text "�������,����Դӿͻ�����������PE��!"
if exist excel.txt del /q excel.txt