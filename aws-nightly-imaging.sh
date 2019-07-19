#!/bin/bash
#To be run by cron on aws-controller instance at 0100 Central (0600 GMT) each day

#First, the webserver

sh /home/ec2-user/aws-scripts/aws-www-server-imaging.sh </dev/null

#Then, same thing for EventSprout

sh /home/ec2-user/aws-scripts/aws-eventsprout-imaging.sh </dev/null