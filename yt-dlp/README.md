# yt-dlp

https://github.com/yt-dlp/yt-dlp

```bash
docker buildx build --platform linux/arm64 --load -t yt-dlp .
docker run --rm --platform linux/arm64 \
  -v "$PWD:/downloads" yt-dlp -P /downloads \
  'https://www.youtube.com/watch?v=dQw4w9WgXcQ'
```
