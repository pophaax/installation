#!/bin/bash

# ****************************************************************
#
#		SCRIPT SETTINGS
#
# ----------------------------------------------------------------
#

	# Installation directory
	INSTALLATION_PATH=~/
	
	# Main repository
	REPO_MAIN=sailingrobot
	
	# Module repositories to be downloaded
	REPO_MODULES=(
		ruddercommand 
		sailcommand 
		dbhandler 
		CV7 
		servocontroller 
		gps 
		coursecalculation
		httpsync
	)

	# Terminal colors
	CLR_HEAD='\033[34m'
	CLR_INFO='\033[35m'
	CLR_ASK='\033[36m'
	CLR_OPT='\033[37m'
	CLR_DIR='\033[37m'
	CLR_OK='\033[32m'
	CLR_ERR='\033[31m'
	CLR_END='\033[39m'

#
# ****************************************************************

printf "\n$CLR_HEAD"
printf "\n     *****************************************************"
printf "\n     *                                                   *"
printf "\n     *           .:          .:: ::    .:::::::          *"
printf "\n     *          .: ::      .::    .::   ::    .::        *"
printf "\n     *         .:  .::      .::         ::    .::        *"
printf "\n     *        .::   .::       .::       : .::            *"
printf "\n     *       .:::::: .::         .::    ::  .::          *"
printf "\n     *      .::       .::  .::    .::   ::    .::        *"
printf "\n     *     .::         .::   .:: ::    .::      .::      *"
printf "\n     *                                                   *"
printf "\n     *             Sailing robot installation            *"
printf "\n     *                                                   *"
printf "\n     *****************************************************"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

print_result()
{
	if $1
	then 
		printf "$CLR_OK"
		printf "Success\n"
	else 
		printf "$CLR_ERR"
		printf "Failed\n"
	fi
}

opt_install ()
{
	cd $INSTALLATION_PATH
	printf "$CLR_INFO\nDownloading $REPO_MAIN into $CLR_DIR$INSTALLATION_PATH$REPO_MAIN/$CLR_INFO\n"
	print_result "git clone https://github.com/pophaax/$REPO_MAIN"
	cd $REPO_MAIN
	for MODULE in ${REPO_MODULES[@]}
	do
		printf "$CLR_INFO\nDownloading $MODULE module into $CLR_DIR$INSTALLATION_PATH$REPO_MAIN/$MODULE/$CLR_INFO\n"
		print_result "git clone https://github.com/pophaax/$MODULE"
	done

	printf "$CLR_ASK\nDo you wish to create a database?\n$CLR_OPT"
	select option in "Yes" "No"
	do
		case $option in
		    Yes ) printf "$CLR_INFO\nCreating database in $CLR_DIR$INSTALLATION_PATH$REPO_MAIN/$CLR_INFO\n"
					if sqlite3 asr.db < $DIR/createtables.sql;
					then print_result true; else print_result false; break; fi
					printf "$CLR_ASK\nServer settings:\n$CLR_OPT"
					read -p "Boat name: " BOATID
					read -p "Boat password: " BOATPWD
					read -p "Server address: " SRVADDR
					printf "$CLR_INFO"
					if sqlite3 asr.db "INSERT INTO server(id, boat_id, boat_pwd, srv_addr) VALUES('1', '$BOATID', '$BOATPWD', '$SRVADDR')";
					then print_result true; else print_result false; fi
					break;;
			No ) printf "$CLR_INFO\nSkipping database\n"
					break;;
		esac
	done
}

opt_update ()
{
	cd $INSTALLATION_PATH$REPO_MAIN
	printf "$CLR_INFO\nUpdating $REPO_MAIN into $CLR_DIR$INSTALLATION_PATH$REPO_MAIN/$CLR_INFO\n"
	print_result "git pull"
	
	for MODULE in ${REPO_MODULES[@]}
	do
		cd $MODULE
		printf "$CLR_INFO\nUpdating $MODULE module into $CLR_DIR$INSTALLATION_PATH$REPO_MAIN/$MODULE/$CLR_INFO\n"
		print_result "git pull"
		cd ..
	done
}

opt_remove ()
{
	cd $INSTALLATION_PATH
	rm -rf $REPO_MAIN
	printf "$CLR_INFO\nFiles removed\n"
}

opt_daemon_create ()
{
	cd $DIR
	echo "[Unit]" >> asr.service
	echo "Description=sailingrobot" >> asr.service
	echo "Requires=gpsd.service" >> asr.service
	echo "After=gpsd.service" >> asr.service
	echo "" >> asr.service
	echo "[Service]" >> asr.service
	echo "Type=simple" >> asr.service
	echo "ExecStart=$INSTALLATION_PATH$REPO_MAIN/sr" >> asr.service
	echo "RestartSec=5" >> asr.service
	echo "Restart=on-failure" >> asr.service
	echo "" >> asr.service
	echo "[Install]" >> asr.service
	echo "WantedBy=multi-user.target" >> asr.service
	printf "$CLR_INFO\nDaemon created\n"
	sudo mv asr.service /etc/systemd/system/asr.service
	sudo systemctl enable asr.service
	rm -rf asr.service
	printf "$CLR_INFO\nDaemon enabled\n"
}

opt_daemon_remove ()
{
	sudo systemctl disable asr.service
	printf "$CLR_INFO\nDaemon disabled\n"
	sudo rm /etc/systemd/system/asr.service
	printf "$CLR_INFO"
	printf "Daemon removed\n"
}

printf "\n$CLR_ASK\nWhat do you want to do?\n$CLR_OPT"
select option in "Install" "Update" "Remove" "Create Daemon" "Remove Daemon" "Quit"
do
	case $option in
		"Install" ) opt_install; break;;
		"Update" ) opt_update; break;;
		"Remove" ) opt_remove; break;;
		"Create Daemon" ) opt_daemon_create; break;;
		"Remove Daemon" ) opt_daemon_remove; break;;
		"Quit" ) break;;
	esac
done

printf "$CLR_END\n"


