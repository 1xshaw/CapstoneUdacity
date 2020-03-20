#!/usr/bin/env bash

sudo apt-get install openjdk-8-jdk
wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
sudo apt-get update
sudo apt-get install jenkins
sudo systemctl start jenkins