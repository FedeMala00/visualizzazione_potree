#!/bin/bash

echo "Accensione dei server MinIO e Nginx e del watchdog"
docker-compose up -d

echo "Avvio del monitor browser in background"
./scripts/browser_opener.sh &

docker logs -f watchdog_worker