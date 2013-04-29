#!/bin/bash

## LIST REVERSE FUNCTION REQUIRED TO PARSE URLS
function listreverse()
{
	local OBJECTS=""
	local DELIMITER="$2"
	local SOURCE_STRING="$1"
	
	## ADD TOGETHER IN REVERSE
	for i in $(echo $SOURCE_STRING | tr -s '.' ' '); do 
		OBJECTS=$i.$OBJECTS;
	done
	
	## REMOVE TRAILING . AND RETURN
	echo $(echo $OBJECTS|sed s/.$//)
}

function debug_locations()
{
	echo "PROJECT              = $PROJECT"
	echo "TEMPLATE             = $TEMPLATE"
	echo "REVERSE_DOMAIN       = $REVERSE_DOMAIN"
	echo "PRODUCTION_URL       = $PRODUCTION_URL"
	echo "STAGING_URL          = $STAGING_URL"
	echo "LOCAL_URL            = $LOCAL_URL"
	echo "TEST_STAGING_URL     = $TEST_STAGING_URL"
	echo "TEST_PRODUCTION_URL  = $TEST_PRODUCTION_URL"
	echo "TEST_LOCAL_URL       = $TEST_LOCAL_URL"
	echo "REPONAME             = $REPONAME"
	echo "DATABASE_USER_LOCAL  = $DATABASE_USER_LOCAL"
	echo "DATABASE_USER_PROD   = $DATABASE_USER_PROD"
	echo "DATABASE_USER_STAGE  = $DATABASE_USER_STAGE"
	echo "DATABASE_NAME_LOCAL  = $DATABASE_NAME_LOCAL"
	echo "DATABASE_NAME_PROD   = $DATABASE_NAME_PROD"
	echo "DATABASE_NAME_STAGE  = $DATABASE_NAME_STAGE"
	echo "STAGING_IP           = $STAGING_IP"
	echo "PRODUCTION_IP        = $PRODUCTION_IP"
	echo "REPO_LOCATION        = $REPO_LOCATION"
	echo "STAGING_LOCATION     = $STAGING_LOCATION"
	echo "PRODUCTION_LOCATION  = $PRODUCTION_LOCATION"
	echo "LOCAL_LOCATION       = $LOCAL_LOCATION"
}

function do_check_project_exists()
{
	## CHECK TO SEE THERE ARE NO REPS CURRENTLY BY THAT PROJECT NAME
	
	echo "Checking for project '$REPO_LOCATION' and '$LOCAL_LOCATION' "
	
	if [ -d "$REPO_LOCATION" ] || [ -d "$LOCAL_LOCATION" ]; then
		echo "Project already exists... exiting"
		exit
	fi
	
	if ! [ -d "$TEMPLATE_LOCATION" ] ; then
		echo "Template $TEMPLATE not found in $TEMPLATE_LOCATION! ...exiting"
		exit
	fi
	
	
}

function do_create_project_repo(){
	local script_loc=$REPO_LOCATION/scripts
	local conf_loc=$REPO_LOCATION/conf
	local locations_dest=$script_loc/$LOCATIONS_FILENAME
	local functions_dest=$script_loc/$FUNCTIONS_FILENAME

	mkdir -p $REPO_LOCATION
	cd $REPO_LOCATION
	
	cp -Rav $TEMPLATE_LOCATION/. $REPO_LOCATION
	git init

	cp $LOCATIONS_CONFIG $locations_dest
	cp $FUNCTIONS_CONFIG $functions_dest

	sed -i.bak 's/$IN_PROJECT/@@PROJECT@@/g' "$locations_dest"
	sed -i.bak 's/$IN_REVERSE_DOMAIN/@@REVERSE_DOMAIN@@/g' "$locations_dest"
	sed -i.bak 's/$IN_TEMPLATE/@@TEMPLATE@@/g' "$locations_dest"
	sed -i.bak 's/$DTOOLS_LOC/@@DTOOLS_LOC@@/g' "$locations_dest"
	sed -i.bak "s/@@PROJECT@@/$IN_PROJECT/g"  "$locations_dest"
	sed -i.bak "s/@@REVERSE_DOMAIN@@/$IN_REVERSE_DOMAIN/g" "$locations_dest"
	sed -i.bak "s/@@TEMPLATE@@/$IN_TEMPLATE/g" "$locations_dest" 
	sed -i.bak "s%@@DTOOLS_LOC@@%${script_loc}%g" "$locations_dest"
	rm -f $locations_dest.tmp
	find $script_loc -type f \( ! -iname ".*" \) | xargs sed -i.bak "s%/var/rep/interactivecv%$REPO_LOCATION%g"
	find $conf_loc -type f \( ! -iname ".*" \) | xargs sed -i.bak "s%@@PRODUCTION_URL@@%$PRODUCTION_URL%g"
	find $conf_loc -type f \( ! -iname ".*" \) | xargs sed -i.bak "s%/var/wwp/com.rudiyardley.cv%$PRODUCTION_LOCATION%g"
	find $conf_loc -type f \( ! -iname ".*" \) | xargs sed -i.bak "s%@@WEBROOT_EXTENSION@@%$WEBROOT_EXTENSION%g"
	find $conf_loc -type f \( ! -iname ".*" \) | xargs sed -i.bak "s%@@STAGING_URL@@%$STAGING_URL%g"
	find $conf_loc -type f \( ! -iname ".*" \) | xargs sed -i.bak "s%/var/wws/com.rudiyardley.cv%$STAGING_LOCATION%g"
	find $conf_loc -type f \( ! -iname ".*" \) | xargs sed -i.bak "s%@@LOCAL_URL@@%$LOCAL_URL%g"
	find $conf_loc -type f \( ! -iname ".*" \) | xargs sed -i.bak "s%@@LOCAL_LOCATION@@%$LOCAL_LOCATION%g"
	find $script_loc -type f \( ! -iname ".*" \) | xargs sed -i.bak "s%/var/wwp/com.rudiyardley.cv%$PRODUCTION_LOCATION%g"
	find $script_loc -type f \( ! -iname ".*" \) | xargs sed -i.bak "s%interactivecv%$REPONAME%g"
	find $script_loc -type f \( ! -iname ".*" \) | xargs sed -i.bak "s%/var/wws/com.rudiyardley.cv%$STAGING_LOCATION%g"
		
	find $REPO_LOCATION -type f -name "*.bak" -exec rm -f {} \;
	
	$REPO_LOCATION/scripts/local/install.sh
	
	git add *
	git commit -m "Initializing Repo $PROJECT"
}


function do_setup_local_staging_branch(){
	
	cd $REPO_LOCATION
	git checkout -b staging
	git commit -a -m 'This is staging'
	
}

function do_setup_remote_repo(){
	cd ${REPO_LOCATION}
	echo "Setting up remote repository"	

echo "Setting up remote folders..."
	# Setup folders and permissions as root and enable site
	ssh root@${PRODUCTION_IP} <<SHHEND1
	
	mkdir -p ${PRODUCTION_LOCATION}
	mkdir -p ${STAGING_LOCATION}
	mkdir -p ${REPO_LOCATION}.git

	chown -R deploy:deploy ${PRODUCTION_LOCATION}
	chown -R deploy:deploy ${STAGING_LOCATION}
	chown -R deploy:deploy ${REPO_LOCATION}.git
	
	ln -s ${PRODUCTION_LOCATION}/conf/apache2.conf /etc/apache2/sites-enabled/${REPONAME}
	
SHHEND1

echo "Setting up hooks..."
	# Create repository as deploy user	
	ssh deploy@${PRODUCTION_IP} <<SHHEND2
cd ${REPO_LOCATION}.git
git --bare init
SHHEND2

scp ${REPO_LOCATION}/scripts/hooks/post-receive deploy@${PRODUCTION_IP}:${REPO_LOCATION}.git/hooks/

	ssh deploy@${PRODUCTION_IP} <<SHHEND4
chmod +x ${REPO_LOCATION}.git/hooks/post-receive
SHHEND4
echo "CHANGING LOCAL HOSTS FILE"
sudo -- sh -c "echo ' # ${PRODUCTION_URL} machines' >> /etc/hosts"
sudo -- sh -c "echo ${PRODUCTION_IP} ${PRODUCTION_URL} >> /etc/hosts"
sudo -- sh -c "echo ${STAGING_IP} ${STAGING_URL} >> /etc/hosts"
sudo -- sh -c "echo 127.0.0.1 ${LOCAL_URL} >> /etc/hosts"
sudo -- sh -c "echo ' ' >> /etc/hosts"
echo "Adding remote repo..."
	git checkout -b staging
	git remote add web deploy@${PRODUCTION_IP}:${REPO_LOCATION}.git

	git push web master
	git push web staging
	
	ssh root@${PRODUCTION_IP} <<SHHEND3
apachectl restart
SHHEND3
}



function do_delete_project(){
	
	echo "********** WARNING!!!!!! ***********"
	read -p "Are you sure you want to delete the $IN_PROJECT project?  (y/n)" YN
	if [[ "$YN" == "y" ]]; then
		echo $REPO_LOCATION/scripts/production/uninstall.sh
		echo $REPO_LOCATION/scripts/local/uninstall.sh
		read -p "ready to gio ahead?" RD
		$REPO_LOCATION/scripts/production/uninstall.sh
		read -p "ready to gio ahead?" RD
		$REPO_LOCATION/scripts/local/uninstall.sh
	else
		echo "Cancelling install"
	fi
	
}

function do_remove_production_repo(){
	ssh root@${PRODUCTION_IP} <<EOF
		echo REMOVING ${REPO_LOCATION}
		rm -Rf ${PRODUCTION_LOCATION}
		rm -Rf ${STAGING_LOCATION}
		rm -Rf ${REPO_LOCATION}.git
		rm -Rf /etc/apache2/sites-enabled/${REPONAME}
EOF
}

function do_remove_local_site(){
	rm -Rf $REPO_LOCATION
	rm -f /Applications/MAMP/conf/apache/vhosts/${REPONAME}.conf
}
