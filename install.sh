#!/bin/bash

# ****************************************************************
#
#		SCRIPT SETTINGS
#
# ----------------------------------------------------------------
#

	# Installation directory
	INSTALLATION_PATH=setsail

	# Modules to be downloaded
	MODULE[0]=sailingrobot
	MODULE[1]=waypointlist
	MODULE[2]=ruddercommand
	MODULE[3]=sailcommand
	MODULE[4]=dbhandler
	MODULE[5]=windsensor
	MODULE[6]=servocontroller
	MODULE[7]=gps
	MODULE[8]=coursecalculation

	# Last module index.. used in download loop
	MODULES=8

#
# ****************************************************************


printf "\n**********************************\n"
printf "*                                *\n"
printf "*   \033[32mSailing robot installation\033[39m   *\n"
printf "*                                *\n"
printf "**********************************\n"

RESULT=${PWD##*/}
if [ "$RESULT" == "installation" ]; then
	cd ..
fi

printf "\nCreating directory \033[33m../$INSTALLATION_PATH\033[39m\n"
mkdir $INSTALLATION_PATH
cd $INSTALLATION_PATH

for i in `seq 0 $MODULES`
do
	printf "\nDownloading ${MODULE[$i]} module into \033[33m../$INSTALLATION_PATH/${MODULE[$i]}\033[39m\n"
	git clone https://github.com/pophaax/${MODULE[$i]}
done

printf "\n\033[33mFinished!\033[39m\n\n"