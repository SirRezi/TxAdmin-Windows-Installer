@echo off
setlocal EnableDelayedExpansion

REM Begrüßung und Systemmeldung
echo.
echo System von SirRezi
echo.

REM Konfiguration
set "SERVER_DIR=%USERPROFILE%\Desktop\FiveMServer"
set "SERVER_7Z_URL=https://runtime.fivem.net/artifacts/fivem/build_server_windows/master/6537-f2c6ed5f64cc5a71ca0d9505f9b72bb015d370d6/server.7z"

REM Farben
set "GREEN=2"
set "YELLOW=6"

REM Farbwechsel
color %YELLOW%

REM Ordner erstellen
echo.
echo Erstelle FiveM-Server-Ordner...
mkdir "%SERVER_DIR%"

REM Server-Dateien herunterladen
echo.
echo Lade FiveM-Server-Dateien herunter...
powershell -command "(New-Object System.Net.WebClient).DownloadFile('%SERVER_7Z_URL%', '%SERVER_DIR%\server.7z')"

REM Server-Dateien entpacken
echo.
echo Entpacke FiveM-Server-Dateien...
"%ProgramFiles%\7-Zip\7z.exe" x "%SERVER_DIR%\server.7z" -o"%SERVER_DIR%"

REM Farbwechsel
color %GREEN%

REM Server starten
echo.
echo Starte FiveM-Server...
echo.
cd "%SERVER_DIR%"
start "" "FXServer.exe" +exec server.cfg

echo.
echo FiveM-Server-Installation abgeschlossen.
echo.
pause
