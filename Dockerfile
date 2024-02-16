FROM ubuntu:22.04

# Meta
LABEL \
  "name"="subs-burner" \
  "maintainer"="Mahesh Bandara Wijerathna <m4heshd@gmail.com> (m4heshd)"

# Install dependencies
RUN apt-get -y update
RUN apt-get install -y ffmpeg

# Volumes
VOLUME ["/data"]

# Init
WORKDIR /data

# Start
ENTRYPOINT ["tail", "-f", "/dev/null"]
