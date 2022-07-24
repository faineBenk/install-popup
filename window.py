import PyQt5
import sys, os, subprocess
from PyQt5.QtWidgets import QApplication, QLabel

app = QApplication(sys.argv)

already_exists = os.environ['IS_ALREADY_EXISTS']
result = os.environ['RES']
process_pckg = os.environ['PROCESS_PCKGS']
print(type(os.environ.get('PCKG_ARR')))
pckg_arr = os.environ['PCKG_ARR']
print(pckg_arr)

pckg_arr_result = pckg_arr.split(";")

print(pckg_arr_result)

def create_window(result, already_exists,  pckg_arr_result):
	s =""
	for i in range(len(pckg_arr_result)-1):
		pckg_list = pckg_arr_result[i].split(" ")
		if (pckg_list[1]=='0'):
			s+= pckg_list[0] + ": is already exists in system.\n"
		elif (pckg_list[1]=='1' and pckg_list[2]!='1'):
			s+= pckg_list[0] + ": was succesfully installed!\n"
		else:
			s+= pckg_list[0] + ": was not installed. This doesn`t exist in AUR.\n"

	window = QLabel(s)
	window.setGeometry(50,50,150,50)
	window.show()
	app.exec()



create_window(result, already_exists, pckg_arr_result)
