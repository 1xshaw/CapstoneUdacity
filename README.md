# Udacity Cloud DevOps Final Project -- Capstone


## Introduction

The goal of this project is to build a CI/CD pipeline for a microservices application for blue/green deployment strategy. In general, a static web application will be created by using flask. The application files can be found in the directory **app**. Directory **install_scripts** stores the .sh file to set up the environemts. CloudFormation is used, which can be found in the directory **infrastructure**.

All the screenshots can be found in the directory **screenshots**

Some technical features are:
+ The application will be deployed on AWS cloud
+ Using Jenkins to implement Continuous Integration and Continuous Deployment
+ Working with CloudFormation to deploy clusters
+ Using docker to containerize all necessary packages and dependencies
+ Using kubernetes to manage the contanerized application


## Environment Setup

1. Create a EC2 instance manually as Jenkins master

2. Setup all tools & environments in instance
    + clone source code from github repo into instance
    + install python and some of libraries
        ```sh
        source install_scripts/install_awscli.sh
        ```
    + install jenkins in the instance trhough:
        ```sh
        source install_scripts/install_jenkins.sh
        ```
    + install neccessary jenkins plugins:
        + Blue Ocean
        + Docker
        + AWS Pipeline
    + setup credential between jenkins and docker hub, also between jenkins and aws
    + install docker
        ```sh
        source install_scripts/install_docker.sh
        ```
    + install kubectl
        ```sh
        source install_scripts/install_kubectl.sh
        ```
    + install dockerlint
        ```sh
        source install_scripts/install_dockerlint.sh
        ```
        > It seems that **hadolint** is not friendly to Ubuntu system(not easy to find how to install), here **dockerlint** is used for Dockerfile linting

3. Create a stack including a aws cluster and its necessary resources.
    + setup aws cli credential
        ```sh
        aws configure
        ```
    + create aws cluster
        ```sh
        aws cloudformation create-stack \
        --stack-name udacityclouddevopscapstone \
        --region us-west-2 \
        --template-body file://infrastructure/aws-eks.yml \
        --parameters file://infrastructure/eks-params.json \
        --capabilities CAPABILITY_IAM
        ```
    Of course if something goes wrong, you can update the yaml file then update stack with script **stack_update.sh**.

4. Copy **Cluster IAM Role ARN** and change the file in aws-auth.yml correspondingly

5. Add jenkins master instance into work node
    ```sh
    kubectl apply -f infrastructure/aws-auth.yml
    ```

6. setup a pipeline with repo in github in blue ocean interface


## Screenshots
![Lint failed](/screenshots/Lint error.png)

![Lint successed](/screenshots/Lint successful.png)

![Pipeline](/screenshots/Jenkins pipeline deployment success.png)

![CloudFormation](/screenshots/cloudformation.png)

![EKS](/screenshots/eks.png)

![Instances](/screenshots/instances.png)
