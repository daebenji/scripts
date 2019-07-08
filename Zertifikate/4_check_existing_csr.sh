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

if ([[ ! -d $SERVERNAME ]] && [[ ! -f $SERVERNAME.$(date +%Y).key ]] && [[ $SERVERNAME.conf ]])
then
  echo "ERROR: Folder $SERVERNAME, Key $SERVERNAME.$(date +%Y).key or Config $SERVERNAME.conf does not exist."
else
  cd $SERVERNAME
  ### CHECK CERTIFICATE
  openssl req -text -noout -verify -in $SERVERNAME.$(date +%Y).csr
fi
