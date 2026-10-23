@echo off
echo Accensione dei server MinIO e Nginx e del watchdog worker
docker-compose up -d

echo Avvio del monitor browser
start /B powershell.exe -ExecutionPolicy Bypass -File .\scripts\browser_opener.ps1

echo.
docker logs -f watchdog_worker

pause