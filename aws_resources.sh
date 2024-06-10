#!/bin/bash


##########################
#Author: Kaivalya
#Version: 3
#Report: Aws resources usage
############################

echo " Print list of s3 buckets"
# List S3 buckets
buckets=$(aws s3 ls)

# Check if there are any buckets
if [ -z "$buckets" ]; then
    echo "0 buckets"
else
    echo "$buckets"
fi



echo " Print list of ec2 instances"
# Get the list of EC2 instances and their names
instances=$(aws ec2 describe-instances --query "Reservations[*].Instances[*].[InstanceId, Tags[?Key=='Name'].Value | [0]]" --output text)

# Count the number of instances
instance_count=$(echo "$instances" | wc -l)

# Check if there are any instances
if [ "$instance_count" -eq 0 ]; then
    echo "0 instances"
else
    echo "Number of instances: $instance_count"
    echo "Instance IDs and Names:"
    echo "$instances"
fi
