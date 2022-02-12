#!/bin/bash
export UID=$(id -u $USER)
export GID=$(id -g $USER)
docker-compose run foxy_desktop