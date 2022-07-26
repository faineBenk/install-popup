import PyQt5
import sys,os
from PyQt5.QtCore import Qt, QSize
from PyQt5.QtWidgets import QApplication, QLabel, QScrollArea, QMainWindow

app = QApplication(sys.argv)

already_exists = os.environ['IS_ALREADY_EXISTS']
result = os.environ['RES']
process_pckg = os.environ['PROCESS_PCKGS']
pckg_arr = os.environ['PCKG_ARR']
pckg_arr_result = pckg_arr.split(";")


class Processer:

	 def process_package(*arguments):
	 	s =""
	 	for i in range(len(pckg_arr_result)-1):
	 		pckg_list = pckg_arr_result[i].split(" ")
	 		if (pckg_list[1]=='0'):
	 			s+= pckg_list[0] + ": is already exists in system.\n"
	 		elif (pckg_list[1]=='1' and pckg_list[2]!='1'):
	 			s+= pckg_list[0] + ": was succesfully installed!\n"
	 		else:
	 			s+= pckg_list[0] + ": was not installed. This doesn`t exist in AUR.\n"
	 	return s 


class Window(QMainWindow):

	text_in_Label = Processer.process_package(result, already_exists,  pckg_arr_result)
	def __init__(self):
		super().__init__()
	window = QLabel(text_in_Label)
	scroll_area = QScrollArea()
	scroll_area.setWidget(window)
	scroll_area.setWindowTitle('i_popup Notification')
	scroll_area.show()
	window.show()
  
App = QApplication(sys.argv)
  
window = Window()
  
sys.exit(App.exec())
