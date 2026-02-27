FROM osrf/ros:humble-desktop
ENV DEBIAN_FRONTEND=noninteractive
ENV ROS_DISTRO=humble

RUN apt-get update && apt-get install -y \
    git \
    nano \
    python3-colcon-common-extensions \
    python3-vcstool \
    python3-rosdep \
    ros-humble-gazebo-ros-pkgs \
    ros-humble-gazebo-ros2-control \
    ros-humble-ur \
    ros-humble-ur-robot-driver \
    ros-humble-ros2-control \
    ros-humble-ros2-control-test-assets \
    ros-humble-ros2-controllers \
    && rm -rf /var/lib/apt/lists/*

RUN rosdep update || true

WORKDIR /ros2_ws

# 1. Temporarily copy your host's src folder into the Docker image
COPY ros2_ws/src /ros2_ws/src
# 2. Let rosdep scan the copied code and install system dependencies permanently into the image
RUN apt-get update && rosdep install --from-paths src --ignore-src -y \
    && rm -rf /var/lib/apt/lists/*


# Add ROS and workspace sourcing to .bashrc for any newly attached shells
# Change DOMAIN_ID, if needed.
RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc && \
    echo "if [ -f /ros2_ws/install/setup.bash ]; then source /ros2_ws/install/setup.bash; fi" >> ~/.bashrc && \
    echo "export ROS_DOMAIN_ID=19" >> ~/.bashrc

RUN echo '#!/bin/bash\n\
set -e\n\
source "/opt/ros/humble/setup.bash"\n\
if [ -f "/ros2_ws/install/setup.bash" ]; then\n\
    source "/ros2_ws/install/setup.bash"\n\
fi\n\
exec "$@"' > /ros_entrypoint.sh && chmod +x /ros_entrypoint.sh

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
