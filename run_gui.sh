#!/bin/bash
xhost +SI:localuser:root

# Mount the entire ros2_ws and append the build-and-run command
docker run --rm -it --gpus all --net=host --name "ur_simulation_env" \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
  -v $(pwd)/ros2_ws:/ros2_ws:rw \
  ur_simulation_env \
  bash -c "colcon build --symlink-install && source install/setup.bash && exec bash"
