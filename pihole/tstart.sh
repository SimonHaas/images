#!/bin/bash

mkdir /run/openrc
touch /run/openrc/softlevel
rc-service tailscale start
tailscale up --auth-key=${TS_AUTHKEY}

bash start.sh
