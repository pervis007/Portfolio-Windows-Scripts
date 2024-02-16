@echo off

REM Moving to the root directory
cd /

REM Initiating patch download; It may take a few minutes depending on your internet speed
echo "Downloading Patches; This will take several minutes depending on your Internet speed"

REM Downloading the first patch
powershell -Command "(New-Object Net.WebClient).DownloadFile('http://download.windowsupdate.com/c/msdownload/update/software/uprl/2020/03/windows-kb000000-x64-v5.81_74132082f1421c2217b1b07673b671ceddba20fb.exe', ' kb000000_Scan.exe')"
echo "1 out of 4 downloaded"
echo "****"

REM Downloading the second patch
powershell -Command "(New-Object Net.WebClient).DownloadFile('http://download.windowsupdate.com/c/msdownload/update/software/secu/2020/03/windows10.0- kb000000-x64_5db6cfc57a8bda4d13107ad24b3fe8fd790219cf.msu', ' kb000000.msu')"
echo "2 out of 4 downloaded"
echo "****"

REM Downloading the third patch
powershell -Command "(New-Object Net.WebClient).DownloadFile('http://download.windowsupdate.com/c/msdownload/update/software/secu/2020/04/windows10.0- kb000000-x64_705fda69935538eab5054d9d616e1761742816ec.msu', ' kb000000.msu')"
echo "3 out of 4 downloaded"
echo "****"

REM Downloading the fourth patch
powershell -Command "(New-Object Net.WebClient).DownloadFile('http://download.windowsupdate.com/d/msdownload/update/software/secu/2020/04/windows10.0- kb000000-x64_5411f88ea08bfc0ac98f388f5a3bdc8bcfea3261.msu', ' kb000000.msu')"
echo "4 out of 4 are downloaded, Now installing patches!"
echo "****"

REM Installing the patches
@echo off
cd /
wusa.exe C:\ kb000000.msu /quiet /norestart
echo " kb000000 is installed, processing the next one"
echo "****"
wusa.exe C:\ kb000000.msu /quiet /norestart
echo " kb000000 is installed, processing the next one"
echo "****"
echo "This will take 5-10 mins for installing"
echo "****"
wusa.exe C:\ kb000000.msu /quiet /norestart
echo "All the patches are installed & Your system is about to restart now"

REM Restarting the system
shutdown -r