#/bin/bash
start_time=$(awk -F= '/start_time=/ {print $2}' version-timewindow.txt)
end_time=$(awk -F= '/end_time=/ {print $2}' version-timewindow.txt)
now=$(date +"%Y/%m/%d_%T")

echo "Start,              Now,                   End"
echo "$start_time,   $now,   $end_time"

if [[ "$start_time" < "$now" ]] && [[ "$now" < "$end_time" ]]; then
    echo "Task is now IN the time window."
    exit 0
else
    echo "Task is now OUT of the time window."
    exit 1
fi
