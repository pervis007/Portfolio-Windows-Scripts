@echo off

REM Setting up paths
set UNITERM_BIN_PATH=C:\onePOS\uniterm\bin
set HASH_EXPECTED=37a5b2d72d2148f13f365fa0ab84ae2a
set ONEPOS_PATH=C:\onePOS
set PUBLIC_ONEPOS_PATH=C:\users\public\onePOS Remote Launcher
set OLDER_VERSIONS_PATH=%USERPROFILE%\Desktop\Olderversions
set UPGRADE_FOLDER_PATH=%USERPROFILE%\Desktop\919upgrade

REM Stopping UniTerm process
echo Stopping UniTerm process...
taskkill /f /im uniterm.exe > nul 2>&1
if %errorlevel% equ 0 (
    echo UniTerm process stopped.
) else (
    echo UniTerm process is not running.
)
pause

REM Stopping OnePosServer process
echo Stopping OnePosServer process...
taskkill /f /im oneposserver.exe > nul 2>&1
if %errorlevel% equ 0 (
    echo OnePosServer process stopped.
) else (
    echo OnePosServer process is not running.
)
pause

REM Checking UniTerm binary hash
echo Checking UniTerm binary hash...
certutil -hashfile "%UNITERM_BIN_PATH%\uniterm.exe" MD5 > temp.txt
for /f "skip=1 tokens=1,2 delims= " %%G in (temp.txt) do (
    if "%%G"=="MD5" (
        set HASH_CURRENT=%%H
    )
)
del temp.txt

if "%HASH_CURRENT%" equ "%HASH_EXPECTED%" (
    echo Hash matched. Proceeding.
) else (
    REM Hash did not match, performing necessary actions
    echo Hash did not match. Renaming UniTerm folder to 'olduniterm' in C:\onePOS...
    rename "%ONEPOS_PATH%\UniTerm" "olduniterm" > nul 2>&1
    if exist "%ONEPOS_PATH%\olduniterm" (
        echo UniTerm folder renamed to 'olduniterm' in C:\onePOS.
    ) else (
        echo Failed to rename UniTerm folder in C:\onePOS.
    )
    pause

    echo Renaming UniTerm folder to 'olduniterm' in Public location...
    rename "%PUBLIC_ONEPOS_PATH%\UniTerm" "olduniterm" > nul 2>&1
    if exist "%PUBLIC_ONEPOS_PATH%\olduniterm" (
        echo UniTerm folder renamed to 'olduniterm' in Public location.
    ) else (
        echo Failed to rename UniTerm folder in Public location.
    )
    pause

    echo Moving UniTerm folder from upgrade folder to C:\onePOS...
    move /y "%UPGRADE_FOLDER_PATH%\UniTerm" "%ONEPOS_PATH%" > nul 2>&1
    if exist "%ONEPOS_PATH%\UniTerm" (
        echo UniTerm folder moved to C:\onePOS.
    ) else (
        echo Failed to move UniTerm folder to C:\onePOS.
    )
    pause

    echo Moving UniTerm folder from upgrade folder to Public location...
    move /y "%UPGRADE_FOLDER_PATH%\UniTerm" "%PUBLIC_ONEPOS_PATH%" > nul 2>&1
    if exist "%PUBLIC_ONEPOS_PATH%\UniTerm" (
        echo UniTerm folder moved to Public location.
    ) else (
        echo Failed to move UniTerm folder to Public location.
    )
    pause
)

echo Press Enter to continue...
pause > nul