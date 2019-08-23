@echo OFF
@rem --------------------------------------------------------------
@rem 
@rem --------------------------------------------------------------
setlocal

@rem	store the drive and path of this file in a variable
set dirname=%~dp0
@rem	cd to the directory containing this file
pushd %dirname%
@rem	do stuff


if "%1%" == "/?" goto help
if "%%1%%" == "" goto help
if ""%2%"" == "" goto help

dir ""%1"" > folder1.txt
dir ""%2"" > folder2.txt


fc folder1.txt folder2.txt

del folder1.txt
del folder2.txt

pause
goto end


:help

echo.
echo Usage:
echo.
echo CompareFolders.bat ?
echo     Displays this message
echo.
echo CompareFolders.bat C:\Folder1Name C:\Folder2Name
echo     Compares directory the listings of the two folders.
echo.


:end

@rem	cd back to where we started
popd


endlocal
