#!/bin/bash

INPUT_PCD=$1
OUTPUT_FOLDER=$2
if [ -z "$INPUT_PCD" ] || [ -z "$OUTPUT_FOLDER" ]; then
    echo "Errore: Parametri mancanti."
    echo "Uso corretto: bash process.sh <file_input.pcd> <cartella_output>"
    exit 1
fi

echo "Elaborazione PDAL"
pdal translate "$INPUT_PCD" temp_scaled.laz -f randomize \
    --writers.las.scale_x=0.001 \
    --writers.las.scale_y=0.001 \
    --writers.las.scale_z=0.001 \
    

echo "Conversione con PotreeConverter"
/usr/local/bin/PotreeConverter temp_scaled.laz -o "$OUTPUT_FOLDER" --output-format LAZ -s 0.005

echo "Pulizia"
rm temp_scaled.laz

echo "Caricamento su MinIO"
mc alias set domain http://minio-storage:9000 admin password123
mc cp -r "$OUTPUT_FOLDER" domain/pointclouds/

echo "{\"ultima_mappa\": \"$OUTPUT_FOLDER\"}" > latest.json
mc cp latest.json domain/pointclouds/

echo "Completato, mappa salvata nella cartella: $OUTPUT_FOLDER"