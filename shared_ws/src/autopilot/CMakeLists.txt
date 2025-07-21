cmake_minimum_required(VERSION 3.0.2)
project(autopilot)

find_package(catkin REQUIRED COMPONENTS
  roscpp
  rospy
  tf2_ros
  mavros
  mavros_msgs
  std_msgs
  geometry_msgs
)

catkin_package(
)


include_directories(
  ${catkin_INCLUDE_DIRS}
)


catkin_install_python(PROGRAMS
  src/takeoff_node
  src/teleop_comm
  src/state_publisher
  DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)

