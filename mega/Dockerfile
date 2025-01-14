FROM ubuntu

RUN apt-get update && apt-get install -y \
  wget \
  ca-certificates \
  && wget https://mega.nz/linux/repo/xUbuntu_24.10/amd64/megacmd-xUbuntu_24.10_amd64.deb && apt-get install "$PWD/megacmd-xUbuntu_24.10_amd64.deb" -y \
  && rm -rf /var/lib/apt/lists/*
