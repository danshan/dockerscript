#!/bin/bash

docker run -it --name jenkins -h jenkins -u jenkins -p 8080:8080 -v /Users/danshan/data/jenkins:/data/jenkins jenkins
