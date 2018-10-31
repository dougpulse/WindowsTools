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

tidy.exe -q -xml -wrap 0 -indent -o %1 %1
::tidy.exe -q -indent -o %1 %1

::pause

@rem	cd back to where we started
popd


endlocal
