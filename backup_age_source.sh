#!/bin/bash

day_in_seconds=86400
warn_days=0.5
error_days=1
age_file=/home/hugh3869/.backup_age

seconds_behind=$(( $(date '+%s') - $(cat $age_file) ))

days_behind=$(echo "scale=4; $seconds_behind/$day_in_seconds"|bc)

status="ok"
[[ $days_behind > 2 ]] && status = "warn"
[[ $days_behind > 4 ]] && status = "err"

message="backup age file $age_file on $(hostname) is $seconds_behind seconds ($days_behind days) behind the current time"

echo "status $status $message"
echo "metric sourcetime int $seconds_behind"


