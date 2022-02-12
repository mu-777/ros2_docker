#!/bin/bash
docker-compose run -e LOCAL_UID=$(id -u $USER) -e LOCAL_GID=$(id -g $USER) foxy_desktop