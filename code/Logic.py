# Logic.py 

from PySide6.QtCore import QObject, Slot, Property, Signal

class Backend(QObject): 
    userChanged = Signal()

    def __init__(self, db): 
        super().__init__() 
        self.db = db 
        self.currentUser = None
    
    @Slot(str, str, str, result=bool) 
    def register(self, username, email, password): 
        return self.db.createUser(username, email, password) 
    
    @Slot(str, str, result=bool) 
    def logIn(self, email, password): 
        if self.db.logInUser(email, password):
            self.currentUser = self.db.getUserDetails(email)
            self.userChanged.emit()
            return True
        return False
    
    @Slot()
    def logOut(self):
        self.currentUser = None
        self.userChanged.emit()
    
    @Property(str, notify=userChanged)
    def username(self):
        return self.currentUser["username"] if self.currentUser else ""
    
    @Property(str, notify=userChanged)
    def email(self):
        return self.currentUser["email"] if self.currentUser else ""
    
    @Property(bool, notify=userChanged)
    def loggedIn(self):
        return bool(self.currentUser)
    
