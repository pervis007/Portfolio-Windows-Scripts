@echo off

REM Presenting Options
echo Please select the action you'd like to perform:
echo [A] Set a Static IP address to XX.XX.XX.XX
echo [B] Set to DHCP (Automatic IP)

echo ================================

REM Choice Handling
:choice
SET /P C=Enter your choice [A or B]:
if /I [%C%]==[A] goto A
if /I [%C%]==[B] goto B
goto choice

:A
@echo off
REM Setting Static IP
echo Setting static IP address to XX.XX.XX.XX
netsh interface ip set address "Local Area Connection" static XX.XX.XX.XX 255.255.255.0 XX.XX.XX.YY

REM Setting DNS Servers
echo Setting DNS servers to Google's DNS
netsh interface ip add dns "Local Area Connection" addr="8.8.4.4"
netsh interface ip add dns "Local Area Connection" addr="8.8.8.8"

REM Displaying Configuration
echo Updated network configuration:
netsh interface ip show config "Local Area Connection"
pause
goto end

:B
@echo off
REM Setting to DHCP
echo Enabling DHCP for automatic IP configuration
netsh interface ip set address "Local Area Connection" source=dhcp
netsh interface ip set dnsservers "Local Area Connection" source=dhcp

REM Displaying Configuration
echo Updated network configuration:
netsh interface ip show config "Local Area Connection"
pause
goto end

:end