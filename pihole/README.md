# pihole

TODO does not work yet, can not get tailscale and pihole to start automatically

A pihole image with tailscale installed.
This way you do not need a tailscale sidecar container which would leed to pihole only showing one querying device, the sidecar.
Now with the pihole container beeing its own tailscale device, it will correctly show which device in your tailnet does DNS queries.


docker run --env-file .env --cap-add NET_ADMIN --cap-add SYS_MODULE --device /dev/net/tun:/dev/net/tun -v /var/lib:/var/lib -d --name tpihole tpihole
docker exec -it tpihole bash
pihole setpassword
docker rm -f tpihole
