FROM n8nio/n8n

USER root

# Install dependencies
RUN apt-get update && \
    apt-get install -y python3 python3-pip ffmpeg supervisor && \
    pip3 install gTTS flask && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy workflow file (optional)
COPY n8n-workflow.json /home/node/.n8n/

# Copy gTTS Flask app
COPY tts_app.py /home/node/

# Copy Supervisor config
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

USER node

EXPOSE 8080 5000

CMD ["/usr/bin/supervisord"]
