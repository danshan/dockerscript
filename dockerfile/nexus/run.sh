#!/bin/bash

docker run -it --name nexus -h nexus -u nexus -p 8081:8081 -v /Users/danshan/data/nexus:/data/nexus nexus
