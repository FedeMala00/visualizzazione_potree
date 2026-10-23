import time
import subprocess
import os
from watchdog.observers.polling import PollingObserver as Observer
from watchdog.events import PatternMatchingEventHandler

class GestoreNuoveMappe(PatternMatchingEventHandler):
    patterns = ["*.pcd"]

    def on_created(self, event):
        print(f"Rilevata nuova mappa dal robot: {event.src_path}")
        
        # Pausa di sicurezza per far finire a ROS la scrittura del file
        time.sleep(5) 
        
        nome_file = os.path.basename(event.src_path)
        nome_cartella_output = nome_file.replace('.pcd', '_risultato')
        
        #  Percorso host da docker-compose
        host_data_path = os.environ.get("HOST_DATA_PATH", "./data")
        
        comando = [
            "docker", "run", "--rm", 
            "--network", "potree_pipeline_default",
            "-v", f"{host_data_path}:/data", 
            "potree-worker", "bash", "running.sh", 
            nome_file, nome_cartella_output
        ]
        
        print(f"Avvio la conversione per {nome_file}")
        subprocess.run(comando)
        print("Mappa pronta e caricata su MinIO!")

if __name__ == "__main__":
    # Percorso interno al container mappato nel docker-compose
    percorso_data = "/data"
    
    observer = Observer()
    observer.schedule(GestoreNuoveMappe(), percorso_data, recursive=False)
    observer.start()
    
    print(f"Watchdog attivo su: {percorso_data}")
    
    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        observer.stop()
    observer.join()