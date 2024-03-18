# escape=`

# Docker image to build openM++ latest version on Windows
#
# Example of build:
#   docker build -t openmpp/openmpp-build:windows-20H2 .
#
# Example of run:
#   docker run -v C:\my\build:C:\build     openmpp/openmpp-build:windows-20H2 build-all
#   docker run -v C:\my\build:C:\build     openmpp/openmpp-build:windows-20H2 build-openmpp
#   docker run -v C:\my\build:C:\build     openmpp/openmpp-build:windows-20H2 build-models
#   docker run -v C:\my\build:C:\build     openmpp/openmpp-build:windows-20H2 build-go
#   docker run -v C:\my\build:C:\build     openmpp/openmpp-build:windows-20H2 build-r
#   docker run -v C:\my\build:C:\build     openmpp/openmpp-build:windows-20H2 build-perl
#   docker run -v C:\my\build:C:\build     openmpp/openmpp-build:windows-20H2 build-ui
#   docker run -v C:\my\build:C:\build     openmpp/openmpp-build:windows-20H2 build-zip
#   docker run -v C:\my\build:C:\build -it openmpp/openmpp-build:windows-20H2 cmd
#   docker run -v C:\my\build:C:\build -it openmpp/openmpp-build:windows-20H2 C:\perl32\portableshell
# 

FROM mcr.microsoft.com/windows/servercore:20H2

# download and install 7zip, curl expected to be included in servercore
ADD https://www.7-zip.org/a/7z2301-x64.exe C:\Temp\7z_setup.exe

RUN C:\Temp\7z_setup.exe /S /D=C:\7zip\ && `
    del C:\Temp\7z_setup.exe

# download and install v17 (VS-2022) Microsoft MSBuild Tools and VC++
RUN curl -L -o C:\Temp\vs_buildtools.exe https://aka.ms/vs/17/release/vs_BuildTools.exe && `
    ( C:\Temp\vs_buildtools.exe --quiet --wait --norestart --nocache --includeRecommended `
    --installPath C:\BuildTools `
    --add Microsoft.VisualStudio.Workload.MSBuildTools `
    --add Microsoft.VisualStudio.Workload.VCTools `
  || IF "%ERRORLEVEL%"=="3010" EXIT 0 ) && `
    del C:\Temp\vs_buildtools.exe

# download and install MS MPI runtime and SDK
RUN curl -L -o C:\Temp\msmpisetup.exe https://download.microsoft.com/download/7/2/7/72731ebb-b63c-4170-ade7-836966263a8f/msmpisetup.exe && `
    C:\Temp\msmpisetup.exe && `
    del C:\Temp\msmpisetup.exe

RUN curl -L -o C:\Temp\msmpisdk.msi https://download.microsoft.com/download/7/2/7/72731ebb-b63c-4170-ade7-836966263a8f/msmpisdk.msi && `
    msiexec /i C:\Temp\msmpisdk.msi /q /norestart /L* C:\Temp\msmpisdk.log &&`
    del C:\Temp\msmpisdk.msi && `
    del C:\Temp\msmpisdk.log

# download and install git
RUN curl -L -o C:\Temp\git_setup.exe https://github.com/git-for-windows/git/releases/download/v2.41.0.windows.3/Git-2.41.0.3-64-bit.exe && `
    C:\Temp\git_setup.exe /SILENT /SUPPRESSMSGBOXES /DIR=C:\Git /LOG && `
    del C:\Temp\git_setup.exe

# download and install flex and bison for Windows
# win_flex_bison-2.5.24 provides bison 3.7.4, flex 2.6.4
# set environment for openM++ build
ENV BISON_FLEX_DIR=C:\bison_flex

RUN curl -L -o C:\Temp\winflexbison.zip https://github.com/lexxmark/winflexbison/releases/download/v2.5.24/win_flex_bison-2.5.24.zip && `
    C:\7zip\7z.exe x -o%BISON_FLEX_DIR% C:\Temp\winflexbison.zip && `
    del C:\Temp\winflexbison.zip
    
# download and install sqlite command line tools for Windows
# set environment for openM++ build
ENV SQLITE_EXE_DIR=C:\sqlite

RUN curl -L -o C:\Temp\sqlite_bin.zip https://www.sqlite.org/2024/sqlite-tools-win-x64-3450000.zip && `
    C:\7zip\7z.exe e -o%SQLITE_EXE_DIR% C:\Temp\sqlite_bin.zip && `
    del C:\Temp\sqlite_bin.zip

# download and install Go and MinGW
RUN curl -L -o C:\Temp\go_setup.zip https://dl.google.com/go/go1.22.1.windows-amd64.zip && `
    C:\7zip\7z.exe x -oC:\ C:\Temp\go_setup.zip && `
    del C:\Temp\go_setup.zip

RUN curl -L -o C:\Temp\mingw_setup.exe https://nuwen.net/files/mingw/mingw-19.0.exe && `
    C:\7zip\7z.exe x -oC:\ C:\Temp\mingw_setup.exe && `
    del C:\Temp\mingw_setup.exe

# download and install R
# RUN curl -L -o C:\Temp\r_setup.exe https://cloud.r-project.org/bin/windows/base/old/3.6.3/R-3.6.3-win.exe && `
#    C:\Temp\r_setup.exe /SILENT /SUPPRESSMSGBOXES /DIR=C:\R /LOG && `
#    del C:\Temp\r_setup.exe

# download and install node.js
RUN curl -L -o C:\Temp\node.zip https://nodejs.org/dist/v20.11.0/node-v20.11.0-win-x64.zip && `
    C:\7zip\7z.exe x -oC:\ C:\Temp\node.zip && `
    rename C:\node-v20.11.0-win-x64 node && `
    del C:\Temp\node.zip

# download and install portable Perl
# 5.32.1.1 is the last 32bit version, after that only 64bit available
RUN curl -L -o C:\Temp\perl32_setup.zip https://strawberryperl.com/download/5.32.1.1/strawberry-perl-5.32.1.1-32bit-portable.zip && `
    C:\7zip\7z.exe x -oC:\perl32 C:\Temp\perl32_setup.zip && `
    del C:\Temp\perl32_setup.zip

RUN curl -L -o C:\Temp\perl64_setup.zip http://strawberryperl.com/download/5.32.1.1/strawberry-perl-5.32.1.1-64bit-portable.zip && `
    C:\7zip\7z.exe x -oC:\perl64 C:\Temp\perl64_setup.zip && `
    del C:\Temp\perl64_setup.zip

# install cpan modules
RUN C:\perl32\portableshell /SETENV && `
    SET TEMP=C:\Temp&&SET TMP=C:\Temp&&cpanm Getopt::Long::Descriptive && cpanm Config::Tiny && cpanm pp

RUN C:\perl64\portableshell /SETENV && `
    SET TEMP=C:\Temp&&SET TMP=C:\Temp&&cpanm Getopt::Long::Descriptive && cpanm Config::Tiny && cpanm pp

# set local openM++ timezone
RUN tzutil /s "Eastern Standard Time"

# copy build scripts
COPY copy_scripts.bat `
    build-all.bat `
    build-openm.bat `
    build-models.bat `
    build-go.bat `
    build-ui.bat `
    build-r.bat `
    build-perl.bat `
    build-zip.bat `
    README.txt C:\build_scripts\

# set Go, MinGW and R environment
USER ContainerAdministrator

RUN setx /M GOROOT C:\go && `
  setx /M GOPATH C:\build\ompp && `
  setx /M OM_SCRIPTS_DIR C:\build_scripts && `
  setx /M PATH "%GOROOT%\bin;%GOPATH%\bin;C:\Git\cmd;C:\R\bin;%PATH%"

USER ContainerUser

# describe image
#
LABEL name=openmpp/openmpp-build:windows-20H2
LABEL os=Windows
LABEL license=MIT
LABEL description="OpenM++ build environemnt: VC++ 2022, MSBuild, MS MPI, git, SQLite, bison, flex, Go, MinGW, node.js, Perl"

# Done with installation
# 
WORKDIR /build

# start VC++ developer command prompt
# and MinGW environment with any other commands specified.
#
# known issue:
#   "Invalid macro definition." 
#   this error messages can be ignored,
#   doskey is broken in MS windows/servercore
#
ENTRYPOINT (C:\BuildTools\Common7\Tools\VsDevCmd.bat && `
    C:\MinGW\set_distro_paths.bat && `
    C:\node\nodevars.bat && `
    %OM_SCRIPTS_DIR%\copy_scripts.bat) &&

CMD type %OM_SCRIPTS_DIR%\README.txt
