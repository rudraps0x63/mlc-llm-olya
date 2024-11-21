REM @echo off
setlocal enabledelayedexpansion

REM Set variables
set MSYS2_INSTALLER_URL=https://github.com/msys2/msys2-installer/releases/download/2024-01-13/msys2-x86_64-20240113.exe
set MSYS2_INSTALLER_PATH=%TEMP%\msys2-installer.exe
set MSYS2_PATH=D:\a\msys64

REM Download MSYS2 installer
echo Downloading MSYS2 installer...
curl -L %MSYS2_INSTALLER_URL% -o %MSYS2_INSTALLER_PATH%

REM Install MSYS2 silently
echo Installing MSYS2...
%MSYS2_INSTALLER_PATH% install --confirm-command --accept-messages --root %MSYS2_PATH%

REM Wait a bit for installation to complete
timeout /t 5

REM Update MSYS2 packages
echo Updating MSYS2...
%MSYS2_PATH%\usr\bin\bash.exe -lc "pacman -Syu --noconfirm"

REM Install LLVM
echo Installing LLVM...
%MSYS2_PATH%\usr\bin\bash.exe -lc "pacman -S --noconfirm mingw-w64-x86_64-llvm"

REM Add MSYS2 MinGW64 bin to PATH permanently
echo Adding LLVM to PATH...
for /f "tokens=2*" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v Path') do set "CURRENT_PATH=%%b"
setx PATH "%CURRENT_PATH%;%MSYS2_PATH%\mingw64\bin"

REM Add to current session
set "PATH=%PATH%;%MSYS2_PATH%\mingw64\bin"

REM Verify installation
echo Verifying LLVM installation...
llvm-config --version
where zlib1.dll
REM dir bin
dir "%MSYS2_PATH%\mingw64\bin"
REM dir include
dir "%MSYS2_PATH%\mingw64\include"

REM Cleanup
echo Cleaning up...
del /F /Q "%MSYS2_INSTALLER_PATH%"

echo Installation complete! Please restart your terminal to use LLVM.




