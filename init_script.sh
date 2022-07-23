#!/bin/bash

export PROCESS_PCKGS="$@"


for i in $PROCESS_PCKGS; do
	echo  -----$i is checkouted now-----

	pacman -Qi $i
	export IS_ALREADY_EXISTS=$?

	if [ $IS_ALREADY_EXISTS -eq 0 ]; then 
		echo "-----$i is already installed. skipping-----"
		# export RES=0
		# exit 0
	elif [ $IS_ALREADY_EXISTS -eq 1 ]; then
		yes | pacman -Sy $i
		export RES=$? 
		if [ $RES -eq 0 ]; then
			echo "-----$i was succesfully installed-----"
		else
			echo "target not found in repositories"
		fi
	else
		echo "-----error. Can't install.-----"
	fi
done


python3 window.py

