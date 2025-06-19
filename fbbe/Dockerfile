FROM ubuntu as builder
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    build-essential git ca-certificates \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*
RUN git clone --recurse-submodules https://github.com/luke-jr/bfgminer.git /bfgminer

FROM rust
