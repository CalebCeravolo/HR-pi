#!/usr/bin/bash
# cd /home/robot/HR-pi/Executables/
source /home/robot/HR-pi/Executables/variables.sh
/home/robot/HR-pi/Executables/all_low
/home/robot/HR-pi/Executables/toggle $FAN1
/home/robot/HR-pi/Executables/toggle $FAN2
/home/robot/HR-pi/Executables/fpwm 2 1500 # Dirt sample motor
/home/robot/HR-pi/Executables/fpwm 1 1500 # Auger
/home/robot/HR-pi/Executables/fpwm 0 0 # Centrifuge servo
