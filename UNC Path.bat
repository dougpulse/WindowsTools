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

pwsh ".\UNC Path.ps1" %*

:: 
:: @echo off
:: setlocal enabledelayedexpansion
:: 
:: set args=
:: for %%x in (%*) do (
::    set "args=!args! %%~x"
:: )
:: 
:: pwsh "UNC Path.ps1" %args%
:: 


@rem	cd back to where we started
popd

endlocal
