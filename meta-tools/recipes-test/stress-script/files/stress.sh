#!/bin/sh

THERMAL_ZONE0_TEMP="/sys/devices/virtual/thermal/thermal_zone0/temp"
THERMAL_ZONE1_TEMP="/sys/devices/virtual/thermal/thermal_zone1/temp"
COOLING_DEVICE0_STATE="/sys/class/thermal/cooling_device0/cur_state"
COOLING_DEVICE1_STATE="/sys/class/thermal/cooling_device1/cur_state"
CPU_FREQENCY="/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq"

echo 0 > /sys/devices/virtual/thermal/thermal_zone0/trip_point_0_temp
echo 0 > /sys/devices/virtual/thermal/thermal_zone1/trip_point_0_temp
echo "disabled" > /sys/devices/virtual/thermal/thermal_zone0/mode
echo "disabled" > /sys/devices/virtual/thermal/thermal_zone1/mode
echo "performance" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor

[ -e ${THERMAL_ZONE0_TEMP} ] && \
xterm -title thermal_zone0 -geometry 80x4+10+10 -e watch -n 1 cat ${THERMAL_ZONE0_TEMP} &

[ -e ${THERMAL_ZONE1_TEMP} ] && \
xterm -title thermal_zone1 -geometry 80x4+10+110 -e watch -n 1 cat ${THERMAL_ZONE1_TEMP} &

[ -e ${COOLING_DEVICE0_STATE} ] && \
xterm -title cooling_device0 -geometry 80x4+10+210 -e watch -n 1 cat ${COOLING_DEVICE0_STATE} &

[ -e ${COOLING_DEVICE1_STATE} ] && \
xterm -title cooling_device1 -geometry 80x4+10+310 -e watch -n 1 cat ${COOLING_DEVICE1_STATE} &

[ -e ${CPU_FREQENCY} ] && \
xterm -title cpu_freq -geometry 80x4+10+410 -e watch -n 1 cat ${CPU_FREQENCY} &

xterm -title top -geometry 80x40+10+510 top &

stress -c 4
#glmark2 --size 1280x720 --annotate --run-forever &
