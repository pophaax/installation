#!/bin/bash

printf "\n**********************************\n"
printf "*                                *\n"
printf "*   \033[32mSailing robot installation\033[39m   *\n"
printf "*                                *\n"
printf "**********************************\n"

RESULT=${PWD##*/}
if [ "$RESULT" == "installation" ]; then
	cd ..
fi

printf "\nCreating directory \033[33m../setsail\033[39m\n"
mkdir setsail
cd setsail
#printf "                                                          "
#printf " [\033[32mDONE\033[39m]\n\n"

printf "\nDownloading sailingrobot module into \033[33m../setsail/sailingrobot\033[39m\n"
git clone https://github.com/pophaax/sailingrobot

printf "\nDownloading waypointlist module into \033[33m../setsail/waypointlist\033[39m\n"
git clone https://github.com/pophaax/waypointlist

printf "\nDownloading ruddercommand module into \033[33m../setsail/ruddercommand\033[39m\n"
git clone https://github.com/pophaax/ruddercommand

printf "\nDownloading sailcommand module into \033[33m../setsail/sailcommand\033[39m\n"
git clone https://github.com/pophaax/sailcommand

printf "\nDownloading dbhandler module into \033[33m../setsail/dbhandler\033[39m\n"
git clone https://github.com/pophaax/dbhandler

printf "\nDownloading windsensor module into \033[33m../setsail/windsensor\033[39m\n"
git clone https://github.com/pophaax/windsensor

printf "\nDownloading servocontroller module into \033[33m../setsail/servocontroller\033[39m\n"
git clone https://github.com/pophaax/servocontroller

printf "\nDownloading gps module into \033[33m../setsail/gps\033[39m\n"
git clone https://github.com/pophaax/gps

printf "\nDownloading coursecalculation module into \033[33m../setsail/coursecalculation\033[39m\n"
git clone https://github.com/pophaax/coursecalculation

printf "\n\033[33mFinished!\033[39m\n\n"