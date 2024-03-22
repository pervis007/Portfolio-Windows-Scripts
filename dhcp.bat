@echo off
REM Network Configuration Utility

REM Presenting Options
echo Welcome to Network Configuration Utility
echo Please select the network interface:
echo [1] Local Area Connection
echo [2] Wireless Network Connection

REM Choice Handling for Interface Selection
:interface_choice
SET /P I=Enter your choice [1 or 2]:
if /I [%I%]==[1] set interface="Local Area Connection"
if /I [%I%]==[2] set interface="Wireless Network Connection"
if not defined interface goto interface_choice

REM Presenting Options for Configuration
echo ================================
echo Please select the configuration type for %interface%:
echo [1] Set to DHCP (Automatic IP)
echo [2] Set to Static IP

REM Choice Handling for Configuration Type
:configuration_choice
SET /P C=Enter your choice [1 or 2]:
if /I [%C%]==[1] goto dhcp
if /I [%C%]==[2] goto static
goto configuration_choice

:dhcp
@echo off
REM Setting to DHCP
echo Enabling DHCP for automatic IP configuration
netsh interface ip set address %interface% source=dhcp
netsh interface ip set dnsservers %interface% source=dhcp

REM Displaying Configuration
echo Updated network configuration:
netsh interface ip show config %interface%
pause
exit

:static
@echo off
REM Setting Static IP

REM Requesting IP Address
set /p ip=Enter the desired IP address: 
echo Setting static IP address to %ip%

REM Requesting Subnet Mask
set /p subnet=Enter the subnet mask: 

REM Requesting Default Gateway
set /p gateway=Enter the gateway address: 

REM Requesting DNS Servers
set /p dns=Enter the primary DNS address: 
set /p dns2=Enter the secondary DNS address (optional): 

REM Applying Configuration
netsh interface ip set address %interface% static %ip% %subnet% %gateway%
netsh interface ip add dns %interface% addr=%dns%
if not "%dns2%"=="" netsh interface ip add dns %interface% addr=%dns2% index=2

REM Displaying Configuration
echo Updated network configuration:
netsh interface ip show config %interface%
pause
exit
