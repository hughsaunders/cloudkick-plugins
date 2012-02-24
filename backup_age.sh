#!/bin/bash

day_in_seconds=86400
age_file="$1"
warn_days="$2"
error_days="$3"


seconds_behind=$(( $(date '+%s') - $(cat $age_file) ))

days_behind=$(echo "scale=4; $seconds_behind/$day_in_seconds"|bc)
grep '^\.' <<<$days_behind && days_behind="0$days_behind"

status="ok"
[[ "$days_behind" > 2 ]] && status="warn"
[[ "$days_behind" > 4 ]] && status="err"

message="backup age file $age_file on $(hostname) is $seconds_behind seconds ($days_behind days) behind the current time"

echo "status $status $message"
echo "metric secondsbehind int $seconds_behind"

