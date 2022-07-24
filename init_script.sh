#!/bin/bash

export PROCESS_PCKGS="$@"
PCKG_ARR=""


# function adds to pckg arr result of processing package
compose_pckg_arr() {
	PCKG_ARR+=$i" "
	PCKG_ARR+=$IS_ALREADY_EXISTS" " 
	PCKG_ARR+=$RES";"
}


for i in $PROCESS_PCKGS; do
	echo  -----$i is checkouted now-----

	pacman -Qi $i
	export IS_ALREADY_EXISTS=$?

	if [ $IS_ALREADY_EXISTS -eq 0 ]; then 
		echo "-----$i is already installed. skipping-----"
		export RES=0
		compose_pckg_arr $i $IS_ALREADY_EXISTS $RES 
		# exit 0
	elif [ $IS_ALREADY_EXISTS -eq 1 ]; then
		yes | pacman -Sy $i
		export RES=$? 
		if [ $RES -eq 0 ]; then
			echo "-----$i was succesfully installed-----"
			compose_pckg_arr $i $IS_ALREADY_EXISTS $RES
		else
			echo "target not found in repositories"
			compose_pckg_arr $i $IS_ALREADY_EXISTS $RES
		fi
	else
		echo "-----error. Can't install.-----"
	fi
done

export PCKG_ARR

python3 window.py

