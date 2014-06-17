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
		waypointlist 
		ruddercommand 
		sailcommand 
		dbhandler 
		windsensor 
		servocontroller 
		gps 
		coursecalculation
		httpsync
	)

#
# ****************************************************************


printf "\n**********************************\n*                                *\n"
printf "*   \033[32mSailing robot installation\033[39m   *\n"
printf "*                                *\n**********************************\n"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $INSTALLATION_PATH
printf "\nDownloading $REPO_MAIN into \033[33m$INSTALLATION_PATH$REPO_MAIN/\033[39m\n"
git clone https://github.com/pophaax/$REPO_MAIN
cd $REPO_MAIN

for MODULE in ${REPO_MODULES[@]}
do
	printf "\nDownloading $MODULE module into \033[33m$INSTALLATION_PATH$REPO_MAIN/$MODULE/\033[39m\n"
	git clone https://github.com/pophaax/$MODULE
done

printf "\nCreating database in \033[33m$INSTALLATION_PATH$REPO_MAIN/\033[39m\n"
sqlite3 asr.db < $DIR/createtables.sql

printf "\n\033[33mFinished!\033[39m\n\n"
