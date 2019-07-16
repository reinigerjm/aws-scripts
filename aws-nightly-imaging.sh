#!/bin/bash
#To be run by cron on aws-controller instance at 0100 Central (0600 GMT) each day

#First, the webserver

/home/ec2-user/aws-www-server-imaging.sh

#Then, same thing for EventSprout

/home/ec2-user/aws-eventsprout-imaging.sh