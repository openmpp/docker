@echo off
REM build openM++ UI
REM environmemnt variables:
REM  set OMPP_BUILD_TAG                 (default: build from latest git)

setlocal enabledelayedexpansion

REM push into ompp root and make log directory if not exist

REM get source code from git

if not exist ompp mkdir ompp

if not exist ompp (
  @echo ERROR: missing source code directory: ompp
  EXIT 1
)

pushd ompp
set   OM_ROOT=%CD%

if not exist log mkdir log

REM log build environment 

@echo %DATE% %TIME% Build openM++ UI
@echo OM_ROOT = %OM_ROOT%

@echo Log file: log\build-ui.log
@echo %DATE% %TIME% Build openM++ UI > log\build-ui.log
@echo OM_ROOT = %OM_ROOT% >> log\build-ui.log

REM get source code from git, if directory not already exist

if not exist ompp-ui (
  
  call :do_cmd_line_log log\build-ui.log "git clone https://github.com/openmpp/UI ompp-ui"
  
) else (
  @echo Skip: git clone
  @echo Skip: git clone >> log\build-ui.log
)

pushd ompp-ui

REM fix git clone issue:
REM ....fatal: detected dubious ownership in repository at 'C:/build/ompp'

@echo git config --global --add safe.directory *

git config --global --add safe.directory * >> ..\log\build-ui.log 2>&1
if ERRORLEVEL 1 (
  @echo FAILED.
  EXIT
) 

REM if OMPP_BUILD_TAG is set then build from that git tag

if defined OMPP_BUILD_TAG (

  @echo  OMPP_BUILD_TAG     = %OMPP_BUILD_TAG%
  @echo  OMPP_BUILD_TAG     = %OMPP_BUILD_TAG% >> ..\log\build-ui.log
  @echo git checkout %OMPP_BUILD_TAG%
  @echo git checkout %OMPP_BUILD_TAG% >> ..\log\build-ui.log

  git checkout %OMPP_BUILD_TAG% >>  ..\log\build-ui.log 2>&1
  if ERRORLEVEL 1 (
    @echo FAILED: git checkout %OMPP_BUILD_TAG% >> ..\log\build-ui.log
    @echo FAILED.
    EXIT
  )
)

REM set npm_config_cache=%OM_ROOT%\build\npm-cache

call :do_npm_call "install"

call :do_npm_call "run build"

popd

@echo %DATE% %TIME% Done.
@echo %DATE% %TIME% Done. >> log\build-ui.log

popd
goto :eof

REM end of main body

REM helper subroutine to call npm command, log it and check errorlevel
REM arguments:
REM  1 = npm command line arguments

:do_npm_call

set c_line=%~1

@echo npm %c_line%
@echo npm %c_line% >> ..\log\build-ui.log

call npm %c_line% >> ..\log\build-ui.log 2>&1
if ERRORLEVEL 1 (
  @echo FAILED.
  @echo FAILED. >> ..\log\build-ui.log
  EXIT
) 
exit /b

REM helper subroutine to execute command, log it and check errorlevel
REM arguments:
REM  1 = log file path
REM  2 = command line

:do_cmd_line_log

set c_log=%1
set c_line=%~2

@echo %c_line%
@echo %c_line% >> %c_log%

%c_line% >> %c_log% 2>&1
if ERRORLEVEL 1 (
  @echo FAILED.
  @echo FAILED. >> %c_log%
  EXIT
) 
exit /b
