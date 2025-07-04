# escape=`

# Docker image to run openM++ models on Windows
#
# Example of build:
#   docker build -t openmpp/openmpp-run:windows-ltsc2025 .
#
# Example of run:
#   docker run -v C:\my\ompp:C:\ompp     openmpp/openmpp-run:windows-ltsc2025 MyModel.exe
#   docker run -v C:\my\ompp:C:\ompp     openmpp/openmpp-run:windows-ltsc2025 mpiexec -n 2 MyModel_mpi -OpenM.SubValues 16
#   docker run -v C:\my\ompp:C:\ompp -it openmpp/openmpp-run:windows-ltsc2025
# 

FROM mcr.microsoft.com/windows/servercore:ltsc2025

# download and install 7zip, curl expected to be included in servercore
ADD https://www.7-zip.org/a/7z2301-x64.exe C:\Temp\7z_setup.exe

RUN C:\Temp\7z_setup.exe /S /D=C:\7zip\ && `
    del C:\Temp\7z_setup.exe

# download and install VC2015, VC2017, VC2019, VC2022 re-distributable runtimes
# according to Microsoft: VC2015, VC2017, VC2019, VS2022 all share the same re-distributable runtime
RUN curl -L -o C:\Temp\vc_redist.x86.exe https://aka.ms/vs/17/release/vc_redist.x86.exe && `
    C:\Temp\vc_redist.x86.exe /install /quiet /norestart /log C:\Temp\log.x86.txt

RUN curl -L -o C:\Temp\vc_redist.x64.exe https://aka.ms/vs/17/release/vc_redist.x64.exe && `
    C:\Temp\vc_redist.x64.exe /install /quiet /norestart /log C:\Temp\log.x64.txt

# download and install MS MPI runtime
RUN curl -L -o C:\Temp\msmpisetup.exe https://download.microsoft.com/download/7/2/7/72731ebb-b63c-4170-ade7-836966263a8f/msmpisetup.exe && `
    C:\Temp\msmpisetup.exe && `
    del C:\Temp\msmpisetup.exe

# set openM++ root directory
USER ContainerAdministrator

RUN setx /M OM_ROOT C:\ompp

USER ContainerUser

# describe image
#
LABEL name=openmpp/openmpp-run:windows-ltsc2025
LABEL os=Windows
LABEL license=MIT
LABEL description="OpenM++ runtime environemnt: VC++ 2015, VC++ 2017, VC++ 2019, VC++ 2022 runtime (Release only), MS MPI"

# Done with installation
# 
WORKDIR /ompp

# CMD echo OpenM++ runtime environemnt: only Release, VC++ Debug runtime not installed
