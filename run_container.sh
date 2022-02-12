#!/bin/bash

docker run --rm -itd \
    -v /etc/group:/etc/group:ro \
    -v /etc/passwd:/etc/passwd:ro \
    -v /etc/shadow:/etc/shadow:ro \
    -u $(id -u $USER):$(id -g $USER) \
    mu777/ros2:foxy_desktop bash
