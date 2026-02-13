import sys
from PySide6.QtWidgets import QApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtQuickControls2 import QQuickStyle
import PySide6
from Database import DatabaseManager as db 
from Logic import Backend

app = QApplication(sys.argv)
engine = QQmlApplicationEngine()
QQuickStyle.setStyle("Material") 

# connect db 
db = db("AppDB.db")
backend = Backend(db)

print(PySide6.__version__)

from PySide6.QtCore import qVersion, QLibraryInfo
print("Qt version:", qVersion())
print("QML path:", QLibraryInfo.path(QLibraryInfo.QmlImportsPath))

# expose classes to the ui engine 
engine.rootContext().setContextProperty("backend", backend)

engine.load("code/Main.qml")

if not engine.rootObjects():
    sys.exit(-1)

sys.exit(app.exec()) 
