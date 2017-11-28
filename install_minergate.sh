#!/bin/bash
apt-get update
mkdir /downloads
cd /downloads
wget https://minergate.com/download/deb-cli -O minergate-cli.deb
dpkg -i minergate-cli.deb
