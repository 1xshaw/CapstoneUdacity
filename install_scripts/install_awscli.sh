#!/usr/bin/env bash

sudo apt-get -y install python3-pip
pip3 install -r requirements.txt


# Update aws credentials - IAM user programmetic acces - Amazon-admin access) 
# aws configure


# ---------------------------------Update kube-config file------------------------------------------------------------------
# Update kubernetes cluster configuration
# aws eks update-kubeconfig --name zetacluster


# ---------------------------------Update Worker Nodes Configuration---------------------------
# Before running this command, update aws-auth-cm.yml file. File is in cfn folder of the project. 
# After you copy role from AWS cloudformation stack output, update rolearn in line 8. 
# Update ConfigMap credentials(role) for kubernetes worker nodes by running this command:
# kubectl apply -f cfn/aws-auth-cm.yml 


# ----------------------------------------Commands to Remember (Optional)---------------------------------------------------
#  # Pull image from docker hub
#  kubectl run capstone-clouddevops --image=prhomhyse/devops-capstone:latest --port=80
#  kubectl expose deployment capstone-clouddevops --type=LoadBalancer --port=80
#  sudo kubectl get services