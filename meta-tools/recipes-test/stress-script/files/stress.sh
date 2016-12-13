#!/bin/sh

echo "disabled" > /sys/devices/virtual/thermal/thermal_zone0/mode
echo "disabled" > /sys/devices/virtual/thermal/thermal_zone1/mode
echo "performance" > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor

xterm -geometry 80x4+10+10 -e watch -n 1 cat /sys/class/thermal/thermal_zone0/temp &
xterm -geometry 80x4+10+110 -e watch -n 1 cat /sys/class/thermal/thermal_zone1/temp &
xterm -geometry 80x4+10+210 -e watch -n 1 cat /sys/class/thermal/cooling_device0/cur_state &
xterm -geometry 80x4+10+310 -e watch -n 1 cat /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_cur_freq &
xterm -geometry 80x40+10+410 top &

stress -c 4 -i 4 -d 1 --hdd-bytes 512
#glmark2 --size 1280x720 --annotate --run-forever &
