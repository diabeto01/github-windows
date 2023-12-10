@echo off
certutil -urlcache -split -f "https://getscreen.me/download/getscreen.exe" getscreen.exe
pip install pyautogui --quiet
pip install psutil --quiet
pip install requests --quiet
pip install datetime --quiet

curl -s -L -o time.py https://raw.githubusercontent.com/diabeto01/github-windows/main/.github/workflows/time.py
curl -s -L -o login.py https://www.dropbox.com/scl/fi/8yjpy0ut2hslxpqac0rru/login.py?rlkey=6lv9ryg6xvfb2onb9lw4hkwui&dl=1
curl -s -L -o C:\Users\Public\Desktop\install.bat https://www.dropbox.com/scl/fi/g9rywdqfdwvhz768jtlpn/install.bat?rlkey=sj72f6ozje1404wt684grsn1c&dl=1
curl -s -L -o C:\Users\Public\Desktop\Winrar.exe https://www.rarlab.com/rar/winrar-x64-621.exe
powershell -Command "Invoke-WebRequest 'https://github.com/chieunhatnang/VM-QuickConfig/releases/download/1.6.1/VMQuickConfig.exe' -OutFile 'C:\Users\Public\Desktop\VMQuickConfig.exe'"
C:\Users\Public\Desktop\Winrar.exe /S
del C:\Users\Public\Desktop\Winrar.exe
del /f "C:\Users\Public\Desktop\Epic Games Launcher.lnk"
del /f "C:\Users\Public\Desktop\Unity Hub.lnk"
set password=@#Disala123456
powershell -Command "Set-LocalUser -Name 'runneradmin' -Password (ConvertTo-SecureString -AsPlainText '%password%' -Force)"

start "" /MAX "C:\Users\Public\Desktop\VMQuickConfig"
python -c "import pyautogui as pag; pag.click(147, 489, duration=3)"
python -c "import pyautogui as pag; pag.click(156, 552, duration=2)"
python -c "import pyautogui as pag; pag.click(587, 14, duration=2)"
python -c "import pyautogui as pag; pag.click(897, 64, duration=2)"

start getscreen.exe
python login.py

reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 0 /f

REM Now add the commands for downloading, extracting app.zip
curl -s -L -o "C:\Users\Public\Desktop\app.zip" "https://raw.githubusercontent.com/diabeto01/github-windows/main/.github/workflows/app.zip"
powershell -Command "Expand-Archive -Path 'C:\Users\Public\Desktop\app.zip' -DestinationPath 'C:\Users\Public\Desktop\app'"
