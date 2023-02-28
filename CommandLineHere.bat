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

@echo off

cd /D %1
call cmd

@rem	cd back to where we started
popd


endlocal
