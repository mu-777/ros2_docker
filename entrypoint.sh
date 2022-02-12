#!/bin/bash
set -e

USER_ID=${LOCAL_UID:-9001}
GROUP_ID=${LOCAL_GID:-9001}

echo "Starting with UID : $USER_ID, GID: $GROUP_ID"
USER_NAME=user
useradd -u $USER_ID -o -m $USER_NAME
groupmod -g $GROUP_ID $USER_NAME
export HOME=/home/$USER_NAME

# setup ros2 environment
source "/opt/ros/$ROS_DISTRO/setup.bash"

exec /usr/sbin/gosu $USER_NAME "$@"