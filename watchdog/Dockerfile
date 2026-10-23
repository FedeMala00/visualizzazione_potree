FROM python:3.9-slim

RUN apt-get update && apt-get install -y docker.io && rm -rf /var/lib/apt/lists/*
RUN pip install watchdog

WORKDIR /app
COPY watchdog_data.py .

CMD ["python", "-u", "watchdog_data.py"]