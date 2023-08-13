#!/usr/bin/env bash

PREV_TOTAL=0
PREV_IDLE=0
cpuFile="/tmp/dashboard-cpu_usage.eww.tmp"

get_cpu_usage() {
	if [[ -f "${cpuFile}" ]]; then
		fileCont=$(cat "${cpuFile}")
		PREV_TOTAL=$(echo "${fileCont}" | head -n 1)
		PREV_IDLE=$(echo "${fileCont}" | tail -n 1)
	fi

    CPU=($(cat /proc/stat | grep '^cpu ')) # Get the total CPU statistics.
    unset "CPU[0]"                          # Discard the "cpu" prefix.
    IDLE=${CPU[4]}                        # Get the idle CPU time.

    # Calculate the total CPU time.
    TOTAL=0

    for VALUE in "${CPU[@]:0:4}"; do (( TOTAL = TOTAL + VALUE )); done

    # Calculate the CPU usage since we last checked.
    (( DIFF_IDLE = IDLE - PREV_IDLE ))
    (( DIFF_TOTAL = TOTAL - PREV_TOTAL ))
    (( DIFF_USAGE = (1000 * (DIFF_TOTAL - DIFF_IDLE) / DIFF_TOTAL + 5) / 10 ))

    echo "${DIFF_USAGE}%"

    # Remember the total and idle CPU times for the next check.``
	echo "${TOTAL}" > "${cpuFile}"
	echo "${IDLE}" >> "${cpuFile}"
}

get_used_memory() {
	printf "%.0f%%\n" "$(free -m | grep Mem | awk '{print ($3/$2)*100}')"
}

get_battery_capacity() {
    printf "%s%%\n" "$(cat /sys/class/power_supply/BAT?/capacity)"
}

get_brightness() {
    printf "%s%%\n" "$(brightnessctl -m | awk -F, '{print substr($4, 0, length($4)-1)}')"
}

get_volume() {
    printf "%s%%\n" "$(pactl list sinks | \
        grep '^[[:space:]]Volume:' | \
        head -n $(( SINK + 1 )) | \
        tail -n 1 | \
        sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')"
}

## Execute accordingly
if [[ "$1" == "--cpu" ]]; then get_cpu_usage
elif [[ "$1" == "--mem" ]]; then get_used_memory
elif [[ "$1" == "--bat" ]]; then get_battery_capacity
elif [[ "$1" == "--bri" ]]; then get_brightness
elif [[ "$1" == "--vol" ]]; then get_volume
else
    echo "Usage: $0 [--cpu|--mem|--bat|--bri|--vol]"
    exit 1
fi
