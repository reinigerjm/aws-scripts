# README #

### What is this repository for? ###

* Building scripts and tools to manage Red Frog's AWS environment
* These scripts will, in theory, be deployed to the aws-controller EC2 instance and run either by cron locally or hooked in as part of a deployment

### How do I get set up? ###

* The scripts use the Linux date() function. If you're trying to test in macOS, the date function behaves differently, so use a VM or container for sandboxing
* Install the AWS CLI (https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)
* Install jq


### To Do List ###

* Separate the www-server and eventsprout-server AMI creation into different scripts
* Later configure these scripts to fire whenever a deployment succeeds