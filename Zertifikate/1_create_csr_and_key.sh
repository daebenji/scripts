#!/bin/bash
source config.txt

if [ -z "$REQ_CN" ]
then
  if [ $# -eq 0 ]
  then
    echo "Usage: $0 servername i.e. server.organisation.tld || or enter REQ_CN in config.txt"
    exit 1
  else
    SERVERNAME=$1
  fi
else
  SERVERNAME=$REQ_CN
fi

if [ ! -d "$SERVERNAME" ]
then
  echo "OK. Folder $SERVERNAME will be created."
  mkdir $SERVERNAME && cd $SERVERNAME
   if [ $? -ne 0 ]
   then
     echo "ERROR: Folder $SERVERNAME could not be created."
     exit 69
   fi
else
  cd $SERVERNAME
  if [ -d archive ]
  then
    mv $SERVERNAME.* archive
  else
    mkdir archive && cd archive
    if [ $? -ne 0 ]
    then
      echo "ERROR: Folder $SERVERNAME/archiv could not be created."
      exit 69
    else
      mv $SERVERNAME.* archive
    fi
  fi
fi

### CREATE KEY
openssl genrsa -out $SERVERNAME.$(date +%Y).key 2048

### CREATE REQUEST CONF FILE
echo "[req]" > $SERVERNAME.conf
echo "distinguished_name = req_distinguished_name"  >> $SERVERNAME.conf
echo "req_extensions = v3_req"  >> $SERVERNAME.conf
echo "prompt = no"  >> $SERVERNAME.conf
echo "[req_distinguished_name]"  >> $SERVERNAME.conf
echo "C = $REQ_C"  >> $SERVERNAME.conf
echo "ST = $REQ_ST"  >> $SERVERNAME.conf
echo "L = $REQ_L"  >> $SERVERNAME.conf
echo "O = $REQ_O"  >> $SERVERNAME.conf
echo "OU = $REQ_OU"  >> $SERVERNAME.conf
echo "CN = $SERVERNAME"  >> $SERVERNAME.conf
echo "[v3_req]"  >> $SERVERNAME.conf
echo "keyUsage = keyEncipherment, dataEncipherment"  >> $SERVERNAME.conf
echo "extendedKeyUsage = serverAuth"  >> $SERVERNAME.conf
echo "subjectAltName = @alt_names"  >> $SERVERNAME.conf
echo "[alt_names]"  >> $SERVERNAME.conf
echo "DNS.1 = $SERVERNAME" >> $SERVERNAME.conf

### CREATE CSR PEM-FORMAT BASED ON KEY
openssl req -new -out $SERVERNAME.$(date +%Y).csr -key $SERVERNAME.$(date +%Y).key -config $SERVERNAME.conf
openssl req -new -x509 -key $SERVERNAME.$(date +%Y).key -config $SERVERNAME.conf -out $SERVERNAME.$(date +%Y).crt -days 365
