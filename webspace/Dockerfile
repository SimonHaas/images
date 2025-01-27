FROM lscr.io/linuxserver/webtop:ubuntu-xfce

RUN curl -fsSL https://tailscale.com/install.sh | sh && \
    apt-get update && apt-get install -y \
    git \
    inetutils-ping \
    && rm -rf /var/lib/apt/lists/*
