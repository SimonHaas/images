FROM pihole/pihole:latest

RUN apk add openrc tailscale
COPY tstart.sh /usr/bin/tstart.sh
RUN chmod +x /usr/bin/tstart.sh

ENTRYPOINT ["tstart.sh"]
