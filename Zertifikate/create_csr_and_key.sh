#!/bin/bash

# Verify the type of input and number of values
# Display an error message if the username (input) is not correct
# Exit the shell script with a status of 1 using exit 1 command.
[ $# -eq 0 ] && { echo "Usage: $0 servername i.e. server.geogr.uni-jena.de"; exit 1; }


SERVERNAME=$1
DIR=/etc/ssl/private
TESTFILE=$DIR/can_be_deleted.txt
touch $TESTFILE
[ ! -f "$TESTFILE" ] && { echo "Usage: superuser-privileges needed"; exit 1; }

### CREATE KEY
openssl genrsa -out $DIR/$SERVERNAME.$(date +%Y).key 2048

### CREATE REQUEST CONF FILE
echo "[req]" > $DIR/$SERVERNAME.conf
echo "distinguished_name = req_distinguished_name"  >> $DIR/$SERVERNAME.conf
echo "req_extensions = v3_req"  >> $DIR/$SERVERNAME.conf
echo "prompt = no"  >> $DIR/$SERVERNAME.conf
echo "[req_distinguished_name]"  >> $DIR/$SERVERNAME.conf
echo "C = DE"  >> $DIR/$SERVERNAME.conf
echo "ST = Thueringen"  >> $DIR/$SERVERNAME.conf
echo "L = Gera"  >> $DIR/$SERVERNAME.conf
echo "O = Foo GmbH"  >> $DIR/$SERVERNAME.conf
echo "OU = IT"  >> $DIR/$SERVERNAME.conf
echo "CN = $SERVERNAME"  >> $DIR/$SERVERNAME.conf
echo "[v3_req]"  >> $DIR/$SERVERNAME.conf
echo "keyUsage = keyEncipherment, dataEncipherment"  >> $DIR/$SERVERNAME.conf
echo "extendedKeyUsage = serverAuth"  >> $DIR/$SERVERNAME.conf
echo "subjectAltName = @alt_names"  >> $DIR/$SERVERNAME.conf
echo "[alt_names]"  >> $DIR/$SERVERNAME.conf
echo "DNS.1 = $SERVERNAME" >> $DIR/$SERVERNAME.conf

### CREATE CSR PEM-FORMAT BASED ON KEY
openssl req -new -out $DIR/$SERVERNAME.$(date +%Y).csr -key $DIR/$SERVERNAME.$(date +%Y).key -config $DIR/$SERVERNAME.conf
openssl req -new -x509 -key $DIR/$SERVERNAME.$(date +%Y).key -config $DIR/$SERVERNAME.conf -out /etc/ssl/$SERVERNAME.$(date +%Y).crt -days 365
