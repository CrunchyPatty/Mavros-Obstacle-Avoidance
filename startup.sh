#!/bin/bash

# Setup ardupilot environment
cd /home/Queen/shared_ws/src/modules/ardupilot
./waf configure --board sitl
./waf copter
./Tools/environment_install/install-prereqs-ubuntu.sh -y

# Setup gazebo plugin
cd /home/Queen/shared_ws/src/modules/ardupilot_gazebo
mkdir build
cd build
cmake ..
make -j2
sudo make install

echo "export GAZEBO_MODEL_PATH=~/shared_ws/src/ardupilot_gazebo/models:$GAZEBO_MODEL_PATH" >> ~/.bashrc
echo "export GAZEBO_MODEL_PATH=~/shared_ws/src/ardupilot_gazebo/models_gazebo:$GAZEBO_MODEL_PATH" >> ~/.bashrc
echo "export GAZEBO_RESOURCE_PATH=~/shared_ws/src/ardupilot_gazebo/worlds:$GAZEBO_RESOURCE_PATH" >> ~/.bashrc
echo "export GAZEBO_PLUGIN_PATH=~/shared_ws/src/ardupilot_gazebo/build:$GAZEBO_PLUGIN_PATH" >> ~/.bashrc
echo "export PATH=$PATH:$HOME/.local/bin" >> ~/.bashrc
echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
echo "source /usr/share/gazebo/setup.bash" >> ~/.bashrc

source /usr/share/gazebo/setup.bash
source /opt/ros/noetic/setup.bash

clear
cd ~/shared_ws
exec $@
