# escape=`

# Docker image to run openM++ models on Windows
#
# Example of build:
#   docker build --isolation process -t openmpp/openmpp-run:windows-1909 .
#
# Example of run:
#   docker run --isolation process -v C:\my\ompp:C:\ompp     openmpp/openmpp-run:windows-1909 MyModel.exe
#   docker run --isolation process -v C:\my\ompp:C:\ompp     openmpp/openmpp-run:windows-1909 mpiexec -n 2 MyModel_mpi -OpenM.SubValues 16
#   docker run --isolation process -v C:\my\ompp:C:\ompp -it openmpp/openmpp-run:windows-1909
# 

FROM mcr.microsoft.com/windows/servercore:1909

# download and install 7zip, curl expected to be included in servercore
ADD https://www.7-zip.org/a/7z1900-x64.exe C:\Temp\7z_setup.exe

RUN C:\Temp\7z_setup.exe /S /D=C:\7zip\ && `
    del C:\Temp\7z_setup.exe

# download and install VC2015, VC2017, VC2019 re-distributable runtimes
# according to Microsoft: VC2015, VC2017, VC2019 all share the same re-distributable runtime
RUN curl -L -o C:\Temp\vc_redist.x86.exe https://aka.ms/vs/16/release/vc_redist.x86.exe && `
    C:\Temp\vc_redist.x86.exe /install /quiet /norestart /log C:\Temp\log.x86.txt

RUN curl -L -o C:\Temp\vc_redist.x64.exe https://aka.ms/vs/16/release/vc_redist.x64.exe && `
    C:\Temp\vc_redist.x64.exe /install /quiet /norestart /log C:\Temp\log.x64.txt

# download and install MS MPI runtime
RUN curl -L -o C:\Temp\msmpisetup.exe https://github.com/microsoft/Microsoft-MPI/releases/download/v10.1.1/msmpisetup.exe && `
    C:\Temp\msmpisetup.exe && `
    del C:\Temp\msmpisetup.exe

# set openM++ root directory
USER ContainerAdministrator

RUN setx /M OM_ROOT C:\ompp

USER ContainerUser

# describe image
#
LABEL name=openmpp/openmpp-run:windows-1909
LABEL os=Windows
LABEL license=MIT
LABEL description="OpenM++ runtime environemnt: VC++ 2015, VC++ 2017, VC++ 2019 runtime (Release only), MS MPI"

# Done with installation
# 
WORKDIR /ompp

# CMD echo OpenM++ runtime environemnt: only Release, VC++ Debug runtime not installed
