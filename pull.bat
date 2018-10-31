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
goto run

:askfolder
set /p fldr="Folder (C:\%HOMEPATH%\Documents\Folder):  "
set fldr=%HOMEPATH%\Documents\%fldr%

::goto end

:run
echo %fldr%
c:
cd %fldr%
git pull

pause
goto end


:help

echo.
echo Usage:
echo pull.bat Folder
echo.

pause

:end



@rem	cd back to where we started
popd


endlocal
