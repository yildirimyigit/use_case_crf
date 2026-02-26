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
    && rm -rf /var/lib/apt/lists/*

RUN rosdep update || true

WORKDIR /ros2_ws
RUN mkdir -p src

# Add ROS and workspace sourcing to .bashrc for any newly attached shells
RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc && \
    echo "if [ -f /ros2_ws/install/setup.bash ]; then source /ros2_ws/install/setup.bash; fi" >> ~/.bashrc

RUN echo '#!/bin/bash\n\
set -e\n\
source "/opt/ros/humble/setup.bash"\n\
if [ -f "/ros2_ws/install/setup.bash" ]; then\n\
    source "/ros2_ws/install/setup.bash"\n\
fi\n\
exec "$@"' > /ros_entrypoint.sh && chmod +x /ros_entrypoint.sh

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
