#!/bin/bash
#To be run by cron on aws-controller instance at 0100 Central each day

DATE=`date +%Y%m%d-%k%M`

#Get variables
INSTANCEID=`aws ec2 describe-instances --filters "Name=tag:Name,Values=eventsprout-server" "Name=instance-state-name,Values=running" --query Reservations[*].Instances[*].[InstanceId] --output text`
IMAGENAME="eventsprout-server-"$DATE

echo "Creating AMI "$IMAGENAME" from instance "$INSTANCEID

#Create the image
aws ec2 create-image --instance-id $INSTANCEID --name $IMAGENAME --no-reboot --description "Nightly eventsprout-server image generated by aws-controller"

#Update the Launch Template
#Get the new image ID
IMAGEID=`aws ec2 describe-images --filters "Name=name,Values="$IMAGENAME --query Images[*].[ImageId] --output text`

echo "Updating eventsprout-server-autoscaling Launch Template to use the new image "$IMAGEID

#Create a new Launch Template version
aws ec2 create-launch-template-version --launch-template-name eventsprout-server-autoscaling --source-version '$Latest' --launch-template-data '{"ImageId":"'$IMAGEID'"}'

#Tag the new image
aws ec2 create-tags --resources $IMAGEID --tags Key=Application,Value=eventsprout Key=Environment,Value=production