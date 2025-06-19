@echo off
REM build openM++ Go oms web-service and dbcopy, dbget utilities
REM
REM environmemnt variables:
REM  set OMPP_BUILD_TAG     (default: build from latest git)
REM  set OMPP_GIT_URL       (default: https://github.com/openmpp)

setlocal enabledelayedexpansion

REM push into ompp root and make log directory if not exist

if not exist ompp mkdir ompp

if not exist ompp (
  @echo ERROR: missing source code directory: ompp
  EXIT 1
)

pushd ompp

if not exist log mkdir log

REM log build environment 

@echo %DATE% %TIME% Build Go oms web-service and dbcopy, dbget utilities
@echo Log file: log\build-go.log
@echo %DATE% %TIME% Build Go oms web-service and dbcopy, dbget utilities > log\build-go.log

REM build go oms web-service and dbcopy, dbget utilities

if not exist ompp-go (
  call :do_cmd_line_log log\build-go.log "git clone %OMPP_GIT_URL%/%OMPP_GO_GIT% ompp-go"
)

pushd ompp-go

REM fix git clone issue:
REM ....fatal: detected dubious ownership in repository at 'C:/build/ompp'
@echo git config --global --add safe.directory *

git config --global --add safe.directory * >> ..\log\build-go.log 2>&1
if ERRORLEVEL 1 (
  @echo FAILED.
  EXIT
) 

REM if OMPP_BUILD_TAG is set then build from that git tag

if defined OMPP_BUILD_TAG (

  @echo  OMPP_BUILD_TAG     = %OMPP_BUILD_TAG%
  @echo  OMPP_BUILD_TAG     = %OMPP_BUILD_TAG% >> ..\log\build-go.log
  @echo git checkout %OMPP_BUILD_TAG%
  @echo git checkout %OMPP_BUILD_TAG% >> ..\log\build-go.log

  git checkout %OMPP_BUILD_TAG% >> ..\log\build-go.log 2>&1
  if ERRORLEVEL 1 (
    @echo FAILED: git checkout %OMPP_BUILD_TAG% >> ..\log\build-go.log
    @echo FAILED.
    EXIT
  )
)

REM do build

call :do_cmd_line "go install -tags odbc,sqlite_math_functions,sqlite_omit_load_extension ./dbcopy"
call :do_cmd_line "go install -tags odbc,sqlite_math_functions,sqlite_omit_load_extension ./dbget"
call :do_cmd_line "go install -tags odbc,sqlite_math_functions,sqlite_omit_load_extension ./oms"

popd

@echo %DATE% %TIME% Done.
@echo %DATE% %TIME% Done. >> log\build-go.log

popd
goto :eof

REM end of main body

REM helper subroutine to execute command, log it and check errorlevel
REM arguments:
REM  1 = command line

:do_cmd_line
  call :do_cmd_line_log ..\log\build-go.log %1
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
