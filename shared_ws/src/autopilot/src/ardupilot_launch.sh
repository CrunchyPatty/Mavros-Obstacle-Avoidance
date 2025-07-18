#!/bin/bash

ARDUPILOT_DIR=$(dirname $(rospack find autopilot))/modules/ardupilot
echo "ArduPilot directory: $ARDUPILOT_DIR"

# Check if the ArduPilot directory exists
if [ -d "$ARDUPILOT_DIR" ]; then
    echo "ArduPilot found at $ARDUPILOT_DIR"
else
    echo "ArduPilot not found at $(dirname $(rospack find autopilot))" >&2
    exit 1
fi

VEHICLE_TYPE=$1
MODEL_TYPE=$2

cd "$ARDUPILOT_DIR"/Tools/autotest
echo "Starting ArduPilot simulation for vehicle type: $VEHICLE_TYPE, model type: $MODEL_TYPE"
./sim_vehicle.py -v $VEHICLE_TYPE -f $MODEL_TYPE --console --map --add-param-file=$3/custom_params.parm