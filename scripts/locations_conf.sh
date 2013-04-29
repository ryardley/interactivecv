#!/bin/bash

## INCASE NOT DEFINED
SCRIPT_LOC="/var/rep/interactivecv/scripts"

## GIVEN BY USER
PROJECT="InteractiveCv"
TEMPLATE="rails"
REVERSE_DOMAIN="com.rudiyardley.cv"

## GLOBAL
REPO_BASE=/var/rep
WWW_LOCAL=/var/wwl
WWW_PRODUCTION=/var/wwp
WWW_STAGING=/var/wws
SRC_FOLDER=src
HTTPDOCS_FOLDER=public	

## DERIVED LOCATIONS
PROJECT="$(echo $PROJECT | sed 's/ //g')"
SLUG="$(echo $PROJECT | tr '[A-Z]' '[a-z]')"
FORWARD_DOMAIN=$(listreverse $REVERSE_DOMAIN)

LOCATIONS_FILENAME=locations_conf.sh
LOCATIONS_CONFIG=${DTOOLS_LOC}/${LOCATIONS_FILENAME}
FUNCTIONS_FILENAME=functions.sh
FUNCTIONS_CONFIG=${DTOOLS_LOC}/${FUNCTIONS_FILENAME}
WEBROOT_EXTENSION=/${SLUG}/public
TEMPLATE_LOCATION=${DTOOLS_LOC}/templates/$TEMPLATE
REPO_LOCATION=${REPO_BASE}/${SLUG}
STAGING_LOCATION=${WWW_STAGING}/${REVERSE_DOMAIN}
PRODUCTION_LOCATION=${WWW_PRODUCTION}/${REVERSE_DOMAIN}
LOCAL_LOCATION=${WWW_LOCAL}/${REVERSE_DOMAIN}


## WORK OUT ALL METADATA 
REPONAME=$SLUG
DATABASE_USER_LOCAL=$SLUG
DATABASE_USER_PROD=$SLUG
DATABASE_USER_STAGE=${SLUG}_sta
DATABASE_NAME_LOCAL=$SLUG
DATABASE_NAME_PROD=$SLUG
DATABASE_NAME_STAGE=${SLUG}_sta
PRODUCTION_URL=$FORWARD_DOMAIN
STAGING_URL=staging.$FORWARD_DOMAIN
LOCAL_URL=local.$FORWARD_DOMAIN
TEST_STAGING_URL=test.$STAGING_URL
TEST_PRODUCTION_URL=test.$PRODUCTION_URL
TEST_LOCAL_URL=test.$LOCAL_URL
STAGING_IP='166.78.249.119'
PRODUCTION_IP='166.78.249.119'







