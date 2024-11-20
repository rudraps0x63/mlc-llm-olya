@echo off

REM Step 1: Set LLVM version and download URL
set LLVM_VERSION=15.0.0
set LLVM_INSTALLER_URL=https://github.com/llvm/llvm-project/releases/download/llvmorg-%LLVM_VERSION%/LLVM-%LLVM_VERSION%-win64.exe
set LLVM_INSTALLER_PATH=%TEMP%\LLVM-%LLVM_VERSION%-win64.exe

REM Step 2: Download LLVM installer
echo Downloading LLVM installer...
curl -L %LLVM_INSTALLER_URL% -o %LLVM_INSTALLER_PATH%

REM Step 3: Install LLVM silently
echo Installing LLVM...
"%LLVM_INSTALLER_PATH%" /S /D=%~dp0..\llvm

REM Step 4: Add LLVM to PATH
echo Adding LLVM to PATH...
setx PATH "%PATH%;%~dp0..\llvm\bin"
set "PATH=%PATH%;%~dp0..\llvm\bin"

REM Step 5: Verify llvm-config installation
echo Verifying llvm-config installation...
llvm-config --version

REM Step 6: Cleanup
echo Cleaning up...
del /F /Q "%LLVM_INSTALLER_PATH%"