#!/bin/bash

docker run -d --name jenkins -h jenkins -u root -p 8080:8080 -v /data/jenkins:/var/jenkins_home jenkins
