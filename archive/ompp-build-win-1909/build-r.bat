@echo off
REM build openMpp R package

setlocal enabledelayedexpansion

REM push into ompp root and make log directory if not exist

if not exist ompp (
  @echo ERROR: missing source code directory: ompp
  EXIT 1
)

pushd ompp

if not exist log mkdir log

REM log build environment 

@echo %DATE% %TIME% Build openMpp R package
@echo Log file: log\build-r.log
@echo %DATE% %TIME% Build openMpp R package > log\build-r.log

REM get source code from git, if directory not already exist

if not exist ompp-r (
  
  call :do_cmd_line_log log\build-r.log "git clone https://github.com/openmpp/R ompp-r"
  
) else (
  @echo Skip: git clone
  @echo Skip: git clone >> log\build-r.log
)

REM build openMpp R package

pushd ompp-r
call :do_cmd_line "R CMD build openMpp"
popd

@echo %DATE% %TIME% Done.
@echo %DATE% %TIME% Done. >> log\build-r.log

popd
goto :eof

REM end of main body

REM helper subroutine to execute command, log it and check errorlevel
REM arguments:
REM  1 = command line

:do_cmd_line
  call :do_cmd_line_log ..\log\build-r.log %1
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

