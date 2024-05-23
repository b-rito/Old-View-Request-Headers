#!/bin/bash

TEMP_DIR=`mktemp -d DELETEME.XXX`

move_files () {
  ARR=('index.html' 'index.php' 'styles.css' 'tools.png')
  for file in ${ARR[@]}
  do
    cp $TEMP_DIR/webpages/$file /var/www/html/$file
  done
  
  cp $TEMP_DIR/rocky/nginx-default /etc/nginx/conf.d/default.conf
}

dnf update -y && dnf upgrade -y

command -v git || dnf install git -y

dnf install nginx php-fpm -y

git clone https://github.com/b-rito/View-Request-Headers.git $TEMP_DIR

move_files

systemctl enable nginx
systemctl start nginx

rm -R $TEMP_DIR