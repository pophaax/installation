#!/bin/bash

# ****************************************************************
#
#		SCRIPT SETTINGS
#
# ----------------------------------------------------------------
#

	# Installation directory
	INSTALLATION_DIR=setsail

	# Modules to be downloaded
	MODULES=(
	 	sailingrobot
		waypointlist 
		ruddercommand 
		sailcommand 
		dbhandler 
		windsensor 
		servocontroller 
		gps 
		coursecalculation
	)

#
# ****************************************************************


printf "\n**********************************\n*                                *\n"
printf "*   \033[32mSailing robot installation\033[39m   *\n"
printf "*                                *\n**********************************\n"

RESULT=${PWD##*/}

if [ "$RESULT" == "installation" ]; then
	cd ..
	ROOT_PATH=..
else
	ROOT_PATH=.
fi

printf "\nCreating directory \033[33m$ROOT_PATH/$INSTALLATION_DIR/\033[39m\n"
mkdir $INSTALLATION_DIR
cd $INSTALLATION_DIR

for MODULE in ${MODULES[@]}
do
	printf "\nDownloading $MODULE module into \033[33m$ROOT_PATH/$INSTALLATION_DIR/$MODULE/\033[39m\n"
	git clone https://github.com/pophaax/$MODULE
done

printf "\n\033[33mFinished!\033[39m\n\n"
