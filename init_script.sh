#!/bin/bash

# PACKAGE=$1
# export PACKAGE=$@

export PROCESS_PCKGS="$@"
declare -A PCKG_DICT 


for i in $PROCESS_PCKGS; do
	echo  -----$i is checkouted now-----

	pacman -Qi $i
	export IS_ALREADY_EXISTS=$?

	if [ $IS_ALREADY_EXISTS -eq 0 ]; then 
		echo "-----$i is already installed. skipping-----"
		export RES=0
		# PCKG_DICT[$i]=$IS_ALREADY_EXISTS
		# IS_EXISTS=PCKG_DICT[$i]
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
		# PCKG_DICT[$i]=$IS_ALREADY_EXISTS
	fi
done


python3 window.py

