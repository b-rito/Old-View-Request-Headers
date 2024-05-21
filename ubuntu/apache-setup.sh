#!/bin/bash

TEMP_DIR=`mktemp -d DELETEME.XXX`

move_files () {
  ARR=('index.html' 'index.php' 'styles.css' 'tools.png')
  for file in ${ARR[@]}
  do
    cp $TEMP_DIR/webpages/$file /var/www/html/$file
  done

  cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf.backup
  cp $TEMP_DIR/ubuntu/apache-default /etc/apache2/sites-available/000-default.conf
}

apt update -y && apt upgrade -y

command -v git || apt install git

apt install apache2 libapache2-mod-php

git clone https://github.com/b-rito/View-Request-Headers.git $TEMP_DIR

move_files

systemctl enable apache2
systemctl start apache2

rm -R $TEMP_DIR