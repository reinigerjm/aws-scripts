# README #

### What is this repository for? ###

* Building scripts and tools to manage Red Frog's AWS environment
* These scripts will, in theory, be deployed to the aws-controller EC2 instance and run either by cron locally or hooked in as part of a deployment

### How do I get set up? ###

* You'll want the AWS CLI installed on your environment (https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)
* jq will probably come in handy for parsing aws cli JSON output

### To Do List ###

* Seperate AMI pruning from the AMI creation script
* Separate the www-server and eventsprout-server AMI creation into different scripts
* Start with nightly cron image creation for both applications
* Later configure these scripts to fire whenever a deployment succeeds