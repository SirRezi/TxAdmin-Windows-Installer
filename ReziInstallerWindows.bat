@echo off
setlocal EnableDelayedExpansion

REM Begrüßung und Systemmeldung
echo.
echo System von SirRezi
echo.

REM Konfiguration
set "SERVER_DIR=%USERPROFILE%\Desktop\FiveMServer"
set "SERVER_ARCHIVE=%SERVER_DIR%\server.7z"
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
powershell -command "(New-Object System.Net.WebClient).DownloadFile('%SERVER_7Z_URL%', '%SERVER_ARCHIVE%')"

REM Server-Dateien entpacken
echo.
echo Entpacke FiveM-Server-Dateien...

REM Überprüfe, ob WinRAR installiert ist
if exist "%ProgramFiles%\WinRAR\winrar.exe" (
    echo WinRAR erkannt. Entpacke mit WinRAR...
    "%ProgramFiles%\WinRAR\winrar.exe" x -o+ "%SERVER_ARCHIVE%" "%SERVER_DIR%\"
) else (
    REM Überprüfe, ob 7-Zip installiert ist
    if exist "%ProgramFiles%\7-Zip\7z.exe" (
        echo 7-Zip erkannt. Entpacke mit 7-Zip...
        "%ProgramFiles%\7-Zip\7z.exe" x "%SERVER_ARCHIVE%" -o"%SERVER_DIR%\"
    ) else (
        echo Weder WinRAR noch 7-Zip wurden gefunden. Bitte installieren Sie eines der Programme, um fortzufahren.
        exit /b
    )
)

REM Lösche das Archiv
del "%SERVER_ARCHIVE%"

REM Farbwechsel
color %GREEN%

REM Server starten
echo.
echo Starte FiveM-Server...
echo.
cd /d "%SERVER_DIR%"
start "" "FXServer.exe" +exec server.cfg

echo.
echo FiveM-Server-Installation abgeschlossen.
echo.
pause
