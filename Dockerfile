FROM ubuntu:22.04

# Meta
LABEL \
  "name"="subs-burner" \
  "maintainer"="Mahesh Bandara Wijerathna <m4heshd@gmail.com> (m4heshd)"

# Install dependencies
RUN apt-get -y update
RUN apt-get install -y ffmpeg

# Set up subs-burner
COPY src /app
RUN chmod +x /app/burn_subs.sh

# Set up ttyd
ADD https://github.com/tsl0922/ttyd/releases/download/1.7.4/ttyd.i686 /app/ttyd
RUN chmod +x /app/ttyd

# Set PATH env
ENV PATH="${PATH}:/app"

# Ports
EXPOSE 2525

# Volumes
VOLUME ["/data"]
VOLUME ["/usr/share/fonts/custom"]

# Init
WORKDIR /data

# Start
ENTRYPOINT ttyd -u 1000 -g 1000 -p 2525 -W bash
