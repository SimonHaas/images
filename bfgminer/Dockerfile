FROM ubuntu
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    build-essential git ca-certificates autoconf automake libtool pkg-config libcurl4-gnutls-dev libjansson-dev uthash-dev libncursesw5-dev libudev-dev libusb-1.0-0-dev libevent-dev libmicrohttpd-dev libhidapi-dev libusb-1.0-0-dev \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*
RUN git config --global url."https://".insteadOf git://
RUN git clone --recurse-submodules https://github.com/luke-jr/bfgminer.git /bfgminer
WORKDIR /bfgminer
RUN ./autogen.sh
RUN ./configure
RUN make
