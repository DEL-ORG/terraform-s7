# terraform-s7
```
s3-backend
aws-auth-config
aws-ebs-csi-driver
aws-load-balancer-controller
bastion-host
cluster-auto-scaler
ec2-private
eks-control-plane
eks-namespaces
eks-node-group
external-dns
vpc
acm
```

```
1- s3-backend
2 - vpc
3 - acm
4 - bastion-host
5 - ec2-private
6 - eks-control-plane
7 - eks-node-group
8 - aws-auth-config
9 - eks-namespaces
10 - cluster-auto-scaler
11 - aws-load-balancer-controller
12 - external-dns
13 - aws-ebs-csi-driver
```

```
#!/bin/bash

# How to create an images of running instance in AWS
INSTANCE_ID="i-042adac675c841771"  # Replace with your EC2 instance ID
AMI_NAME="s7-jenkins-master-ami"          # Replace with a name for your AMI
DESCRIPTION="s7-jenkins-master-ami" # Replace with a description for your AMI

# Create the AMI
aws ec2 create-image --instance-id "$INSTANCE_ID" --name "$AMI_NAME" --description "$DESCRIPTION" --no-reboot

# ===========================================================================================================

INSTANCE_ID="i-042adac675c841771"  # Replace with your EC2 instance ID
AMI_NAME="s7-jenkins-master-ami"          # Replace with a name for your AMI
DESCRIPTION="s7-jenkins-master-ami" # Replace with a description for your AMI

# Capture current date and time
CURRENT_DATE_TIME=$(date +"%Y%m%d%H%M%S")

# Create the AMI with tags and date/time in the name
aws ec2 create-image --instance-id "$INSTANCE_ID" \
  --name "$AMI_NAME-$CURRENT_DATE_TIME" \
  --description "$DESCRIPTION" \
  --no-reboot
```