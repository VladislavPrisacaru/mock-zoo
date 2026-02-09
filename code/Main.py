import sys
from PySide6.QtWidgets import QApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtQuickControls2 import QQuickStyle
from Database import DatabaseManager as db 
from Logic import Backend

app = QApplication(sys.argv)
engine = QQmlApplicationEngine()
QQuickStyle.setStyle("Material") 

# connect db 
db = db("AppDB.db")
backend = Backend(db)

# expose classes to the ui engine 
engine.rootContext().setContextProperty("backend", backend)

engine.load("QMLLogIn/Main.qml")

if not engine.rootObjects():
    sys.exit(-1)

sys.exit(app.exec()) 
