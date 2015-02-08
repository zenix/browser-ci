#!/bin/sh
docker run -d -p 8081:8080 -v /data/jenkins:/var/jenkins_home zenix/browser-ci
