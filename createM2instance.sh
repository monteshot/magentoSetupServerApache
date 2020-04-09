#!/bin/sh
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/$1.key -out /etc/ssl/certs/$1.crt
mkdir -p ~/ApacheSites/$1/log/
mkdir -p ~/ApacheSites/$1/content/
DOMENNAME=$1
sites_available="/etc/apache2/sites-available/"
tempdir="/var/tmp/sites4apache/"
mkdir -p $tempdir
sudo ./genSite.sh $DOMENNAME > $tempdir$1.conf
sudo cp $tempdir$1.conf $sites_available$1.conf
# sudo ./genSite.sh $DOMENNAME > $sites_available$1.conf
sudo a2ensite $1.conf && sudo service apache2 restart
