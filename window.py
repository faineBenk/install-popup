import PyQt5
import sys, os
from PyQt5.QtWidgets import QApplication, QLabel

app = QApplication(sys.argv)

already_exists = os.environ['IS_ALREADY_EXISTS']
result = os.environ['RES']
process_pckg = os.environ['PROCESS_PCKGS']

# test_var_exists = os.environ['IS_EXISTS']
# pckg_dict = os.environ['PCKG_DICT']

# process_pckg = [
# {name: 'pckg_name', 
# res: 'res', 
# already_exists: '1'},
# {name: 'pckg_name', 
# res: 'res', 
# already_exists: '1'}
# ]

def create_window(result, already_exists, process_pckg):
	# process_pckg = process_pckg.split()
	print(type(process_pckg))
	for i in process_pckg:
		s = ""
		if (already_exists=='0'):
			print("package already exists")
			window = QLabel(process_pckg + "\nis already exists in system.")
			# s+= name + " is already exists in system.\n"

		elif (already_exists=='1'):
			print("package was successfully installed!")
			window = QLabel(process_pckg + "\nwas succesfully installed!")
			# s+= name + " was succesfully installed!\n"
		else:
			print("Oops.")
			window = QLabel(process_pckg + "\nwas not installed.\nTry again.")
			# s+= name + " was not installed. Try again.\n"

	# window = QLabel(s)
	window.setGeometry(50,50,150,50)
	window.show()
	app.exec()



create_window(result, already_exists, process_pckg)
