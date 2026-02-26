import os
from ament_index_python.packages import get_package_share_directory
from launch import LaunchDescription
from launch.actions import IncludeLaunchDescription
from launch.launch_description_sources import PythonLaunchDescriptionSource
from launch_ros.actions import Node

def generate_launch_description():
    ur_sim_dir = get_package_share_directory('ur_simulation_gazebo')
    custom_pkg_dir = get_package_share_directory('use_case_sim')

    # Resolve the absolute path to your saved RViz config inside the install space
    rviz_config = os.path.join(custom_pkg_dir, 'rviz', 'default.rviz')

    ur_launch = IncludeLaunchDescription(
        PythonLaunchDescriptionSource(
            os.path.join(ur_sim_dir, 'launch', 'ur_sim_control.launch.py')
        ),
        launch_arguments={
            'ur_type': 'ur10',
            'description_package': 'use_case_sim',
            'description_file': 'task_env.urdf.xacro',
            # 1. Disable the default RViz window spawned by the UR package
            'launch_rviz': 'false'
        }.items()
    )

    # 2. Launch RViz explicitly with our custom configuration file
    rviz_node = Node(
        package='rviz2',
        executable='rviz2',
        name='rviz2',
        output='screen',
        arguments=['-d', rviz_config]
    )

    return LaunchDescription([
        ur_launch,
        rviz_node
    ])
