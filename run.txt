wget https://github.com/git-for-windows/git/releases/download/v2.34.1.windows.1/Git-2.34.1-64-bit.exe --no-check-certificate -O Git.exe
Git.exe /SILENT
wget https://github.com/Kitware/CMake/releases/download/v3.22.1/cmake-3.22.1-windows-x86_64.msi --no-check-certificate -O CMake.msi
CMake.msi /passive
set PATH=%PATH%;C:\Program Files\Git;C:\Program Files\CMake\bin
wget https://aka.ms/vs/15/release/vs_professional.exe
vs_professional.exe --addProductLang en-us
"C:\Program Files\Git\bin\sh.exe" --login -i -c "mkdir /c/lib"
COPY installOCV.sh C:\lib
cd c:\lib
"C:\Program Files\Git\bin\sh.exe" --login -i -c "./installOCV.sh"
git clone https://github.com/AlexeyAB/darknet
cd darknet
Powershell.exe -executionpolicy Bypass -File build.ps1 -UseVCPKG -EnableOPENCV -DisableInteractive
pause
