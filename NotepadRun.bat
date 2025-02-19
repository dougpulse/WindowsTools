@echo off

GOTO %~sx1

::  Run a script directly from Notepad++
::  Usage:
::    Run | Run (or just F5)
::    %USERPROFILE%\repos\WindowsTools\NotepadRun.bat "$(FULL_CURRENT_PATH)"

:.ps1
::  cd "%~d1%~p1"
::  powershell.exe .\%~n1%~sx1 
::  GOTO end
:: Updated 2021-02-26 for Windows 7 and PowerShell 2
::  cd "%~d1%~p1"
::  powershell -ExecutionPolicy Unrestricted -File "%~n1%~sx1"
::  GOTO end
:: What about Windows 11 and PowerShell 7?
 cd "%~d1%~p1"
 pwsh -ExecutionPolicy Unrestricted -File "%~n1%~sx1"
 GOTO end

:.bat
 call "%~f1"
 GOTO end

:.js
 cscript "%~f1"
 GOTO end

:.vbs
 cscript "%~f1"
 GOTO end

:.rb
 ruby "%~f1"
 GOTO end

:.php
 php "%~f1"
 GOTO end

:end

pause