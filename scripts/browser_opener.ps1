# Percorso del file da monitorare
$percorso_file = ".\data\latest.json"

Write-Host "Browser opener attivo"

# Data ultima modifica del file (se esiste già)
$ultima_modifica = $null
if (Test-Path $percorso_file) {
    $ultima_modifica = (Get-Item $percorso_file).LastWriteTime
}

while ($true) {
    Start-Sleep -Seconds 2
    
    if (Test-Path $percorso_file) {
        $modifica_attuale = (Get-Item $percorso_file).LastWriteTime
        
        # Data cambiata -> conversione terminata
        if ($ultima_modifica -ne $null -and $modifica_attuale -ne $ultima_modifica) {
            Write-Host "Mappa pronta, apertura tab"
            Start-Process "http://localhost"
            $ultima_modifica = $modifica_attuale
            
            # Sleep per evitare aperture multiple
            Start-Sleep -Seconds 10 
        } 
        elseif ($ultima_modifica -eq $null) {
            # Caso prima apertura
            Write-Host "Apertura tab con prima mappa"
            Start-Process "http://localhost"
            $ultima_modifica = $modifica_attuale
            Start-Sleep -Seconds 10
        }
    }
}