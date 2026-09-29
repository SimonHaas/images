FROM debian:bookworm-slim
ARG TARGETARCH

RUN apt-get update \
		&& apt-get install -y --no-install-recommends ca-certificates wget \
		&& case "$TARGETARCH" in \
			amd64) asset=yt-dlp_linux ;; \
			arm64) asset=yt-dlp_linux_aarch64 ;; \
			*) echo "Unsupported TARGETARCH: $TARGETARCH" >&2; exit 1 ;; \
		esac \
		&& wget -O /usr/local/bin/yt-dlp "https://github.com/yt-dlp/yt-dlp/releases/latest/download/$asset" \
		&& chmod a+rx /usr/local/bin/yt-dlp \
		&& rm -rf /var/lib/apt/lists/*
ENTRYPOINT ["/usr/local/bin/yt-dlp"]
