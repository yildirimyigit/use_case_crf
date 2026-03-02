Description
---
This repo contains a Docker container for the CRF use case. The aim is to provide a standard development environment for different partners. 

After running the build script, a container will be compiled with:
- Ubuntu 22.04.5
- ROS2 Humble
- Gazebo Classic

The container blindly mounts the _ros2_ws/src_ folder, ensuring that changes made within the _src_ folder are saved on the host machine. So you can use VS Code (or any tool you like) on your host for development.

By default, Docker contains under _src_:
- Universal_Robots_ROS2_Gazebo_Simulation
- robotiq_gripper
- serial (a dependency for the gripper)
- easy_ur_control (controllers developed by the IDRA Lab)
- cartesian_controllers
as submodules. There is another ROS package _use_case_sim_ for a trivial example scenario.

Installation
---
1- Clone the repository. Don't forget the **--recurse-submodules** flag:
```
git clone --recurse-submodules git@github.com:yildirimyigit/use_case_crf.git
```

2- After cloning, build and run Docker with:
  - ``` ./build_docker.sh ```
  - ``` ./run_gui.sh ```
  - (Optional if you want to attach another shell to a running container) ``` ./attach_docker.sh ``` 

3- On the container, run ```ros2 launch use_case_sim peg_in_hole.launch.py```.
  - In your first run (after ./run_gui.sh), give Gazebo some time to download the models. There is another bug I haven't solved yet that causes Gazebo to fail **only on the first run** (any help is appreciated). It should work successfully in subsequent launches.

<img width="1200" height="676" alt="image" src="https://github.com/user-attachments/assets/51d3b644-d3f3-42f2-b044-f4203ace0fa6" />
<br/>
<br/>
<br/>

4- On the container, run ```ros2 launch use_case_sim assembly_task.launch.py```. This scene also features a ZED2 camera.
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/0fbab2fb-2eee-485c-9456-1246034bf3c3" />

