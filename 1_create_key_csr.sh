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

### CREATE REQUEST CONF FILE
echo "[req]" > $DIR/req.conf
echo "distinguished_name = req_distinguished_name"  >> $DIR/req.conf
echo "req_extensions = v3_req"  >> $DIR/req.conf
echo "prompt = no"  >> $DIR/req.conf
echo "[req_distinguished_name]"  >> $DIR/req.conf
echo "C = DE"  >> $DIR/req.conf
echo "ST = Thueringen"  >> $DIR/req.conf
echo "L = Jena"  >> $DIR/req.conf
echo "O = Friedrich-Schiller-Universitaet Jena"  >> $DIR/req.conf
echo "OU = Institut fuer Geographie"  >> $DIR/req.conf
echo "CN = $SERVERNAME"  >> $DIR/req.conf
echo "[v3_req]"  >> $DIR/req.conf
echo "keyUsage = keyEncipherment, dataEncipherment"  >> $DIR/req.conf
echo "extendedKeyUsage = serverAuth"  >> $DIR/req.conf
echo "subjectAltName = @alt_names"  >> $DIR/req.conf
echo "[alt_names]"  >> $DIR/req.conf
echo "DNS.1 = $SERVERNAME" >> $DIR/req.conf

### CREATE CSR PEM-FORMAT BASED ON KEY
openssl req -new -out $DIR/$SERVERNAME.csr.$(date +%Y) -key $DIR/$SERVERNAME.key.$(date +%Y) -config $DIR/req.conf
