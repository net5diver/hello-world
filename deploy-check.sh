#/bin/bash
# Author: Gary Yu
# Date: 05/01/2020

control_file=deploy-control.txt
start_time=$(awk -F= '/start_time=/ {print $2}' $control_file)
end_time=$(awk -F= '/end_time=/ {print $2}' $control_file)
now=$(date +"%Y/%m/%d_%T")

# Check time window
echo "Start,              Now,                   End"
echo "$start_time,   $now,   $end_time"

if [[ "$start_time" < "$now" ]] && [[ "$now" < "$end_time" ]]; then
    echo "Task is now IN the time window."
else
    echo "Task is now OUT of the time window."
    exit 1
fi

# Check version
version=$(awk -F= '/version=/ {print $2}' $control_file)
echo $version, $S3LambaName
echo $S3LambdaName | grep "^CompanyAPI/SalesX.Company.API_${version}_"
if [[ $? == 0 ]]; then
    echo "Version matched"
else
    echo "Version NOT matched"
    exit 1
fi

