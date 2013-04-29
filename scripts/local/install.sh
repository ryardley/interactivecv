#!/bin/bash

## This script will install the actual software ie rails new x

source /var/rep/interactivecv/scripts/functions.sh
source /var/rep/interactivecv/scripts/locations_conf.sh

# cd to the REPOBASE
cd $REPO_LOCATION
# run rails new xxxxx
rails new $REPONAME
cd $REPO_LOCATION/$REPONAME
bundle install
# create a symlink to /var/wwl/domainname
echo "To run your rails application in WEBrick open a new terminal and type the following:"
echo
echo "cd $REPO_LOCATION/$REPONAME"
echo "rails s"
echo 
echo "Then go to http://localhost:3000 in the browser"

