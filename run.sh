#!/bin/bash

# Needs to be root
/usr/local/bin/xvfb.sh
# Needs to be jenkins
su jenkins -c "xvfb-run /usr/local/bin/selenium.sh"
su jenkins -c "xvfb-run /usr/local/bin/jenkins.sh"
exec "$@"
