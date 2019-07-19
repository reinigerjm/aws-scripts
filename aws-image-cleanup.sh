#!/bin/bash
#Find and deregister any www-server or eventsprout AMIs older than 3 days

#Get some date variables today's date minus 3 days
DATE=`date +%Y-%m-%d`
DATEMINUS3=$(date -d "$DATE - 3 days" +%Y-%m-%d) 

#Get the ImageIds for all www-server production images more than 3 days old
declare -a TBD=(`aws ec2 describe-images --filters "Name=tag:Application,Values=www-server" "Name=tag:Environment,Values=production" --query "Images[*].[ImageId,CreationDate]" --output=json | jq -r '.[] | select (.[1]< "'$DATEMINUS3' | gmtime | todate") | .[0]'`)

echo "Found "${#TBD[@]}" www-server images older than 3 days"
echo

#And then delete them along with their snapshots
for i in "${TBD[@]}"
do 
	echo "Deleting image" $i
	aws ec2 deregister-image --image-id $i
	SNAPSHOT=`aws ec2 describe-snapshots --filters "Name=description,Values=*"$i"*" --query 'Snapshots[*].SnapshotId' --output text`
	echo "Deleting snapshot" $SNAPSHOT
	aws ec2 delete-snapshot --snapshot-id $SNAPSHOT
done

echo
echo "www-server images cleaned up"
echo

#Now repeat for eventsprout-server


#Get the ImageIds for all eventsprout-server production images more than 3 days old
declare -a TBD=(`aws ec2 describe-images --filters "Name=tag:Application,Values=eventsprout" "Name=tag:Environment,Values=production" --query "Images[*].[ImageId,CreationDate]" --output=json | jq -r '.[] | select (.[1]< "'$DATEMINUS3' | gmtime | todate") | .[0]'`)

echo "Found "${#TBD[@]}" eventsprout images older than 3 days"
echo

#And then delete them along with their snapshots
for i in "${TBD[@]}"
do 
	echo "Deleting image" $i
	aws ec2 deregister-image --image-id $i
	SNAPSHOT=`aws ec2 describe-snapshots --filters "Name=description,Values=*"$i"*" --query 'Snapshots[*].SnapshotId' --output text`
	echo "Deleting snapshot" $SNAPSHOT
	aws ec2 delete-snapshot --snapshot-id $SNAPSHOT
done

echo
echo "eventsprout images cleaned up"
echo
