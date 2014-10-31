#!/bin/bash

docker run -it --name jenkins -h jenkins -u jenkins -p 8080:8080 -v /data/jenkins:/var/jenkins_home jenkins
