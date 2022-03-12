FROM ubuntu:20.04

# https://docs.ros.org/en/foxy/Installation/Ubuntu-Install-Debians.html
# https://github.com/osrf/docker_images/blob/master/ros/foxy/ubuntu/focal/ros-core/Dockerfile

SHELL ["/bin/bash", "-c"]

RUN echo 'Etc/UTC' > /etc/timezone && \
    ln -s /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    apt-get update && \
    apt-get install -q -y --no-install-recommends tzdata && \
    rm -rf /var/lib/apt/lists/*

RUN apt update && apt install -y --no-install-recommends \
    curl \
    gnupg2 \
    lsb-release \
    locales \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(source /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

ENV ROS_DISTRO foxy

RUN apt update && apt install -y --no-install-recommends \
    ros-foxy-desktop \
    && rm -rf /var/lib/apt/lists/*

RUN rosdep init && rosdep update

COPY ./ros_entrypoint.sh /

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]