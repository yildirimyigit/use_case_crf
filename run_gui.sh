#!/bin/bash
xhost +SI:localuser:root

docker run --rm -it --gpus all --net=host --name "ur_simulation_env" \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
  -v $(pwd)/ros2_ws:/ros2_ws:rw \
  ur_simulation_env \
  bash -c "colcon build --symlink-install --packages-skip cartesian_controller_simulation cartesian_controller_tests --cmake-args -DCMAKE_BUILD_TYPE=Release && source install/setup.bash && exec bash"
