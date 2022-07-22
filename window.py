import PyQt5
import sys, os
from PyQt5.QtWidgets import QApplication, QLabel

app = QApplication(sys.argv)

already_exists = os.environ['IS_ALREADY_EXISTS']
result = os.environ['RES']
package = os.environ['PACKAGE']


def create_window(result, already_exists, package):
	if (already_exists=='0'):
		print("package already exists")
		window = QLabel(package + "\nis already exists in system.")
	elif (already_exists=='1' and result!="1"):
		window = QLabel(package + "\nwas succesfully installed!")
	else:
		window = QLabel(package + "\nwas not installed.\nTry again.")
	window.setGeometry(50,50,150,50)
	window.show()
	app.exec()

create_window(result, already_exists, package)
