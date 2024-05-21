#!/bin/bash

TEMP_DIR=`mktemp -d DELETEME.XXX`

move_files () {
  ARR=('index.html' 'index.php' 'styles.css' 'tools.png')
  for file in ${ARR[@]}
  do
    cp $TEMP_DIR/webpages/$file /var/www/html/$file
  done

  cp /etc/nginx/sites-available/default /etc/nginx/sites-available/default.backup
  cp $TEMP_DIR/ubuntu/nginx-default /etc/nginx/sites-available/default
}

apt update -y && apt upgrade -y

command -v git || apt install git

apt install nginx php-fpm

git clone https://github.com/b-rito/view-request-header.git $TEMP_DIR

move_files

systemctl enable nginx
systemctl start nginx

rm -R $TEMP_DIR