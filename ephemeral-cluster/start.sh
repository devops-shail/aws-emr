#!/usr/bin/env bash

# For aws cli version 1, please use: aws ecr get-login | sh
aws ecr get-login-password | docker login -u AWS --password-stdin https://075790327284.dkr.ecr.ap-south-1.amazonaws.com

# getting env secrets from secrets manager
aws secretsmanager get-secret-value --secret-id $AZKABAN_ENV_SECRET_NAME > secrets


awsClusterName=$1
flowEnv=$2
Core_InstanceType=$3
Task_InstanceType=$4
Master_InstanceType=$5
Core_Instances=$6
Task_Instances=$7

aws emr create-cluster \
        --name "$awsClusterName" \
        --applications Name=Hadoop Name=Spark Name=Zeppelin \
        --release-label emr-5.35.0 \ #emr version 
        --service-role EMR_DefaultRole \ #emr cluster role
        --instance-groups InstanceGroupType=MASTER,InstanceCount=1,InstanceType=$Master_InstanceType InstanceGroupType=CORE,InstanceCount=$Core_Instances,InstanceType=$Core_InstanceType InstanceGroupType=TASK,InstanceCount=$Task_Instances,InstanceType=$Task_InstanceType \
        --log-uri 's3://aws-logs-xxxxx-ap-south-1/elasticmapreduce/' \
        --ec2-attributes '{"KeyName":"filename.pem","InstanceProfile":"EMR_EC2_DefaultRole","ServiceAccessSecurityGroup":"sg-xxxxxx","SubnetId":"subnet-0xxxxx","EmrManagedSlaveSecurityGroup":"sg-0xxxxxxx","EmrManagedMasterSecurityGroup":"sg-0xxxxxx"}' \
        --region ap-south-1 \
        --auto-scaling-role EMR_AutoScaling_DefaultRole \
        --auto-termination-policy IdleTimeout 7200 # time in minutes
