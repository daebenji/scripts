#!/bin/bash

# On the hub
cf-agent -K -f failsafe.cf
cf-promises

# On the client

rm -f /var/cfengine/inputs/cf_promises_validated
# Download new promises
cf-agent -K -f failsafe.cf
#execute new promises in verbose mode
cf-agent -vK
