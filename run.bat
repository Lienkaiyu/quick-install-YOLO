if not exist %USERPROFILE%\Documents\WindowsPowerShell\ (mkdir %USERPROFILE%\Documents\WindowsPowerShell\)
echo $ProgressPreference = 'SilentlyContinue' > %USERPROFILE%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
Powershell.exe Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
echo downloading Git
if not exist Git.exe (
  Powershell.exe Invoke-WebRequest https://github.com/git-for-windows/git/releases/download/v2.34.1.windows.1/Git-2.34.1-64-bit.exe -O Git.exe
)
Git.exe /SILENT

echo downloading CMake
if not exist CMake.msi (
  Powershell.exe Invoke-WebRequest https://github.com/Kitware/CMake/releases/download/v3.22.1/cmake-3.22.1-windows-x86_64.msi -O CMake.msi
)
CMake.msi /passive

echo downloading Visual Studio 2017 Installer
if not exist vs_Professional.exe (
  Powershell.exe Invoke-WebRequest https://aka.ms/vs/15/release/vs_professional.exe -O vs_Professional.exe
)
vs_professional.exe --addProductLang en-us

set PATH=%PATH%;C:\Program Files\Git;C:\Program Files\CMake\bin

mkdir c:\lib
cd c:\lib
if not exist installOCV.sh (
  Powershell.exe Invoke-WebRequest https://github.com/Lienkaiyu/quick-install-darknet/blob/main/installOCV.sh -O installOCV.sh
)
"C:\Program Files\Git\bin\sh.exe" --login -i -c "./installOCV.sh"

if not exist darknet(
  git clone https://github.com/AlexeyAB/darknet
)
cd darknet

Powershell.exe -executionpolicy Bypass -File build.ps1 -UseVCPKG -EnableOPENCV -DisableInteractive
pause
