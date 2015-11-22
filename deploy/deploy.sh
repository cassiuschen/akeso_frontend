#!/bin/bash

APP_PATH='/var/app/akeso_frontend'
APP_USER='web'

echo "Start deployment"
cd $APP_PATH
echo 'pulling source code...'
git reset --hard origin/master
git clean -f
git pull
git checkout master
pm2 restart all
