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

:folder
if "%1%" == "" goto askfolder
set fldr=%1%
goto message

:askfolder
set /p fldr="Folder (C:\%HOMEPATH%\Documents\Folder):  "
set fldr=%HOMEPATH%\Documents\%fldr%


:message
if "%2%" == "" goto askmessage
set msg=%2%
goto run

:askmessage
set /p msg="Commit message:  "


:run
echo %fldr%
echo %msg%
c:
cd %fldr%
git add -A
git commit -m "%msg%"
git push

pause
goto end


:help

echo.
echo Usage:
echo push.bat UserName "message"
echo.


pause

:end


@rem	cd back to where we started
popd


endlocal
