# mailflow

https://mailflow.sh
https://github.com/maathimself/mailflow

Mailflow-frontend binds to port 80 AND 443.
This is not best practice.
The service should only expose unencrypted http on an ideally configurable port and a external reverse proxy should handle https.

This also conflicted with a tailscale serve sidecar container which inturn exposes port 443 to handle https and forwards request to the http port of an application.
