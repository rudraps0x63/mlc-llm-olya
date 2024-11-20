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

REM Step 4: Add LLVM to PATH (only add the new path, don't append to existing)
echo Adding LLVM to PATH...
for /f "tokens=2*" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v Path') do set "CURRENT_PATH=%%b"
setx PATH "%CURRENT_PATH%;%~dp0..\llvm\bin"

REM Add to current session
set "PATH=%PATH%;%~dp0..\llvm\bin"

REM Step 5: Verify llvm-config installation using full path
echo Verifying llvm-config installation...
"%~dp0..\llvm\bin\llvm-config" --version

REM Step 6: Cleanup
echo Cleaning up...
del /F /Q "%LLVM_INSTALLER_PATH%"