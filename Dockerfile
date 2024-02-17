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

# Set PATH env
ENV PATH="${PATH}:/app"

# Volumes
VOLUME ["/data"]
VOLUME ["/usr/share/fonts/custom"]

# Init
WORKDIR /data

# Start
ENTRYPOINT ["tail", "-f", "/dev/null"]
