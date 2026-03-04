# Logic.py 

from PySide6.QtCore import QObject, Slot, Property, Signal

class Backend(QObject): 
    userChanged = Signal()
    bookingsChanged = Signal()

    def __init__(self, db): 
        super().__init__() 
        self.db = db 
        self.currentUser = None
        self.currentUserID = self.currentUser["userID"] if self.currentUser else None
    
    @Slot(str, str, str, result=bool) 
    def register(self, username, email, password): 
        return self.db.createUser(username, email, password) 
    
    @Slot(str, str, result=bool) 
    def logIn(self, email, password): 
        if self.db.logInUser(email, password):
            self.currentUser = self.db.getUserDetails(email)
            self.currentUserID = self.currentUser["userID"]
            self.userChanged.emit()
            self.bookingsChanged.emit()
            return True
        return False
    
    @Slot(str, int, int, int, int, int)
    def addBooking(self, tourDatetime, adults, children, hotel, rooms, nights):
        try:
            print("ADDING BOOKING:", self.currentUserID, tourDatetime, adults, children, hotel, rooms, nights)
            self.db.addNewBooking(self.currentUserID, tourDatetime, adults, children, hotel, rooms, nights)
            self.bookingsChanged.emit()
        except Exception as e:
            print(e)

    @Property('QVariant', notify=bookingsChanged)
    def bookings(self):
        if not self.currentUser:
            return []
        print()
        print(self.db.getBookingInfo(self.currentUserID))
        return self.db.getBookingInfo(self.currentUserID)

    @Slot()
    def logOut(self):
        self.currentUser = None
        self.userChanged.emit()
        self.bookingsChanged.emit()
    
    @Property(str, notify=userChanged)
    def username(self):
        return self.currentUser["username"] if self.currentUser else ""
    
    @Property(str, notify=userChanged)
    def email(self):
        return self.currentUser["email"] if self.currentUser else ""
    
    @Property(bool, notify=userChanged)
    def loggedIn(self):
        return bool(self.currentUser)
    
