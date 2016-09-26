#!/bin/sh

X &
#a few sleeps
export DISPLAY=:0
openbox &
glmark2 --size 1280x720 --annotate --run-forever &
xterm -geometry 40x5 -e watch -n 1 cat /sys/class/thermal/thermal_zone0/temp &
xterm -geometry 40x5 -e watch -n 1 cat /sys/class/thermal/thermal_zone1/temp &
xterm -geometry 40x5 -e watch -n 1 cat /sys/class/thermal/cooling_device0/cur_state &
stress --cpu 4 --io 2 --vm 1 --hdd 2 -t 600
#stress-ng
