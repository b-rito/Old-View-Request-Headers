#!/bin/bash

TEMP_DIR=`mktemp -d DELETEME.XXX`

move_files () {
  ARR=('index.html' 'index.php' 'styles.css' 'tools.png')
  for file in ${ARR[@]}
  do
    cp $TEMP_DIR/webpages/$file /var/www/html/$file
  done
}

dnf update -y && dnf upgrade -y

command -v git || dnf install git

dnf install httpd php-fpm

git clone https://github.com/b-rito/View-Request-Headers.git $TEMP_DIR

move_files

systemctl enable apache2
systemctl start apache2

rm -R $TEMP_DIR