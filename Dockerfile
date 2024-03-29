FROM ubuntu:22.04

# Meta
LABEL \
  "name"="media-toolkit" \
  "maintainer"="Mahesh Bandara Wijerathna <m4heshd@gmail.com> (m4heshd)"

# Install dependencies
RUN apt-get -y update
RUN apt-get install -y ffmpeg
RUN apt-get install -y openssh-server

# Set up yt-dlp
ADD https://github.com/yt-dlp/yt-dlp/releases/download/2023.12.30/yt-dlp /app/yt-dlp
RUN chmod a+rx /app/yt-dlp

# Set up ttyd
ADD https://github.com/tsl0922/ttyd/releases/download/1.7.4/ttyd.i686 /app/ttyd
RUN chmod +x /app/ttyd

# Set up media-toolkit
COPY src /app
RUN chmod +x /app/burn_subs.sh

# Set PATH env
ENV PATH="${PATH}:/app"
RUN echo "export PATH=${PATH}" >> /root/.bashrc
RUN echo "cd /data" >> /root/.bashrc

# Ports
EXPOSE 22
EXPOSE 2525

# Volumes
VOLUME ["/config/ssh/key.pub"]
VOLUME ["/data"]
VOLUME ["/usr/share/fonts/custom"]

# Init
WORKDIR /data

# Set up entrypoint
COPY src/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Start
ENTRYPOINT ["/entrypoint.sh"]
