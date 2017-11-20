#!/bin/bash

# Verify the type of input and number of values
# Display an error message if the username (input) is not correct
# Exit the shell script with a status of 1 using exit 1 command.

[ $# -eq 0 ] && { echo "Usage: $0 servername i.e. server.geogr.uni-jena.de"; exit 1; }


SERVERNAME=$1
DIR=/etc/ssl
TESTFILE=$DIR/can_be_deleted.txt
touch $TESTFILE
[ ! -f "$TESTFILE" ] && { echo "Usage: superuser-privileges needed"; exit 1; }

### CREATE KEY
openssl genrsa -out $DIR/$SERVERNAME.key.$(date +%Y) 2048

### CREATE CSR PEM-FORMAT BASED ON KEY
openssl req -new -out $DIR/$SERVERNAME.csr.$(date +%Y) -key $DIR/$SERVERNAME.key.$(date +%Y) -config $DIR/req.conf 
