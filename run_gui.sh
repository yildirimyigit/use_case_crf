#!/bin/bash
xhost +SI:localuser:root

# Added space after --name, added missing \ after DISPLAY, and used $(pwd) for absolute host path
docker run --rm -it --gpus all --net=host --name "ur_simulation_env" \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
  -v $(pwd)/ros2_ws/src:/ros2_ws/src:rw \
  ur_simulation_env
