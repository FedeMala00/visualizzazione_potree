ULTIMA_MODIFICA=""

# Controlla se il file esiste già e memorizza la data di modifica iniziale
if [ -f "$PERCORSO_FILE" ]; then
    ULTIMA_MODIFICA=$(stat -c %Y "$PERCORSO_FILE")
fi

while true; do
    sleep 2

    # Se il file esiste già
    if [ -f "$PERCORSO_FILE" ]; then
        MODIFICA_ATTUALE=$(stat -c %Y "$PERCORSO_FILE")

        # Se ULTIMA_MODIFICA non è vuota e è diversa dalla modifica attuale
        if [ -n "$ULTIMA_MODIFICA" ] && [ "$MODIFICA_ATTUALE" != "$ULTIMA_MODIFICA" ]; then
            echo "Mappa pronta! Apertura del browser..."
            xdg-open "http://localhost"
            ULTIMA_MODIFICA="$MODIFICA_ATTUALE"
            sleep 10

        # Se è la prima volta che il file viene creato
        elif [ -z "$ULTIMA_MODIFICA" ]; then
            echo "Prima mappa pronta! Apertura del browser..."
            xdg-open "http://localhost"
            ULTIMA_MODIFICA="$MODIFICA_ATTUALE"
            sleep 10
        fi
    fi
done