#!/usr/bin/env fish

if test (count $argv) -eq 0
  echo "Provide either -r / --region or -a / --all for all regions"
  exit
end

getopts $argv | while read -l key value
  switch $key
    case a all
      set -g region "all"
      echo "all!"
      break
    case r region
      set -g region $value
  end
end

if test $region = "all"
  echo "Retrieving instances from all regions ..."
  for reg in (aws ec2 describe-regions --output text | cut -f3) 
    echo "Region: $reg"
    aws ec2 describe-instances --region $reg \
      --query 'Reservations[*].Instances[*].{ID:InstanceId,State:State.Name,InstanceType:InstanceType,LaunchTime:LaunchTime,Tags:Tags[?Key==`Name`].Value[]}'
    echo " "
  end
else
  echo "Retrieving instances from region $region ..."
  aws ec2 describe-instances --region $region \
      --query 'Reservations[*].Instances[*].{ID:InstanceId,State:State.Name,InstanceType:InstanceType,LaunchTime:LaunchTime,Tags:Tags[?Key==`Name`].Value[]}'
end

echo "... done."
