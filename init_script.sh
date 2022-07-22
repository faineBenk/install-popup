#!/bin/bash

PACKAGE=$1
export PACKAGE=$1
echo  -----${PACKAGE} is checkouted now-----

pacman -Qi ${PACKAGE}
export IS_ALREADY_EXISTS=$?

if [ $IS_ALREADY_EXISTS -eq 0 ]; then 
	echo "-----${PACKAGE} is already installed. skipping-----"
	export RES=0
	# exit 0
elif [ $IS_ALREADY_EXISTS -eq 1 ]; then
	yes | pacman -Sy ${PACKAGE}
	export RES=$? 
	if [ $RES -eq 0 ]; then
		echo "-----${PACKAGE} was succesfully installed-----"
	else
		echo "target not found in repositories"
	fi
else
	echo "-----error. Can't install.-----"
fi

python3 window.py
