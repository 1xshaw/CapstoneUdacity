# Udacity Capstone Cloud DevOps
+   **Author**: Devin Yang
+   **Date**: 22.02.2020

## Description
In this project we assume that we gonna use python flask to develop a "Great Application", all the application files are stored under directory **app**. Here are some technical methods we gonna take to make the development efficient in future:
+ This application will deployed on AWS cloud
+ Use docker to containerize all necessary packages and dependencies
+ Use kubernetes to manage the contanerized application
+ Use jenkins for CI/CD

## How to make it work?
1. Create a GitHub repository, push all the development file into it
    + Makefile
    + Dockerfile
    + Jenkinsfile
    + application source codes
    + ...
The github repo: you can find it [HERE](https://github.com/EVYang1992/udacityclouddevopsfinalproject).

2. Create a IAM role policy for EC2 whole properties access, With this role we can at least manipulate EKS, EC2, S3 Bucket.  

3. Create a Keypairs on aws console manually, and change the ParameterValue of "_KeyName_" in the file "_eks-params.json_"

4. Create a EC2 instance manually as Jenkins master
    + create a ec2 instance manually, assume the installed ec2 system owns a ubuntu 18.0.4 os
    + through ssh connect to this instance

5. Setup all tools & environments in instance
    + clone source code from github repo into instance
    + install awscli
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

6. Create a stack including a aws cluster and its necessary resources.
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

7. Copy **Cluster IAM Role ARN** and change the file in aws-auth.yml correspondingly

8. Add jenkins master instance into work node
    ```sh
    kubectl apply -f infrastructure/aws-auth.yml
    ```

8. setup a pipeline with repo in github in blue ocean interface


## Experiences & Remarks
+ For a instance to initialize a kubenetes cluster, the minimal CPU counts will be 2, t2.micro can not meet the requirements. 

+ To push image to private docker hub repository, it is necessary to create a credential in jenkins credential by using "Username/Password", meanwhile **ID** must be set for jenkins pipeline invoking it to log into docker hub repository

+ In jenkins pipeline when try to log into docker, it came out an error:
    > "Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Post http://%2Fvar%2Frun%2Fdocker.sock/v1.40/auth: dial unix /var/run/docker.sock: connect: permission denied"
    Solution: 
    ```sh
    sudo chmod 777 /var/run/docker.sock
    ```
