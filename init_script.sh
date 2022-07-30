#!/bin/bash

PCKG_ARR=""

# function adds to pckg arr result of processing package
compose_pckg_arr() {
	PCKG_ARR+=$i" "
	PCKG_ARR+=$IS_ALREADY_EXISTS" " 
	PCKG_ARR+=$RES";"
}


check_pyqt() {
	res_check_pyqt=$(pip list | grep PyQt | head -n 1 | awk {'print$1'})
	if [ $res_check_pyqt == "PyQt5" ]; then 
		echo "-----PyQt is already installed-----"
	else
		pip install PyQt5
	fi
}

check_pyqt

process_pckg() {
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
}


process_input() {
	# if file - PROCESS_PCKGS should be read as file, 
	# if array - as $@
	if [ $# -ge 2 ]; then
    	echo "-----Packages are processing from list.-----"
    	export PROCESS_PCKGS="$@"
    	echo $PROCESS_PCKGS
		process_pckg PROCESS_PCKGS
	else 
		echo "-----There is file with packages processing-----"
		file="$1"
		value=$(cat $file)
		echo $value
		export PROCESS_PCKGS=$value
		process_pckg PROCESS_PCKGS
		# export 
	fi
}

process_input "$@"


python3 window.py
