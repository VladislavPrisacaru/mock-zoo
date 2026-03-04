# Database.py

import sqlite3
import bcrypt

class DatabaseManager:
    def __init__(self, dbName):
        self.dbName = dbName
        self.connection = sqlite3.connect(self.dbName)
        self.cursor = self.connection.cursor()
        self.createTables()
    
    def createTables(self):
        self.cursor.execute("""
            CREATE TABLE IF NOT EXISTS users (
                userID INTEGER PRIMARY KEY AUTOINCREMENT,
                username TEXT NOT NULL UNIQUE,
                email TEXT NOT NULL UNIQUE,
                passwordHash BLOB NOT NULL
            );
        """)

        self.cursor.execute("""
            CREATE TABLE IF NOT EXISTS bookings (
                bookingID INTEGER PRIMARY KEY AUTOINCREMENT,
                userID INTEGER NOT NULL,
                tourDatetime TEXT NOT NULL,
                adults INTEGER NOT NULL,
                children INTEGER NOT NULL,
                hotel INTEGER NOT NULL,
                rooms INTEGER,
                nights INTEGER,
                FOREIGN KEY (userID) REFERENCES users(userID) ON DELETE CASCADE
            );
        """)

        self.connection.commit()
    
    def createUser(self, username, email, password): 
        try:
            hashedPassword = self.hashPassword(password) 
            self.cursor.execute( "INSERT INTO users (username, email, passwordHash) VALUES (?, ?, ?);", (username, email, hashedPassword,) ) 
            self.connection.commit() 
            return True
        except sqlite3.IntegrityError:
            return False

    def logInUser(self, email, password): 
        self.cursor.execute( "SELECT passwordHash FROM users WHERE email = ?", (email,) ) 
        row = self.cursor.fetchone()

        if row is None: 
            return False 
        
        storedHash = row[0] 

        if self.verifyPassword(password, storedHash): 
            return True 
        
        return False
    
    def getUserDetails(self, email):
        self.cursor.execute( "SELECT userID, username, email FROM users WHERE email = ?", (email,))
        row = self.cursor.fetchone()

        if row is None: 
            return False 
        
        return { "userID": row[0], "username": row[1], "email": row[2]}
    
    def addNewBooking(self, userID, tourDatetime, adults, children, hotel, rooms, nights):
        if not hotel:
            rooms = None
            nights = None

        try:   
            self.cursor.execute("""INSERT INTO bookings (userID, tourDatetime, adults, children, hotel, rooms, nights) 
                                VALUES (?, ?, ?, ?, ?, ?, ?)""", 
                                (userID, tourDatetime, adults, children, hotel, rooms, nights))
            self.connection.commit()
            print("booking saved to the db")
        except Exception as e:
            print(e)

    def getBookingInfo(self, userID):
        self.cursor.execute("""SELECT * FROM bookings WHERE userID = ?""", (userID,))

        rows = self.cursor.fetchall()

        bookings = []
        for row in rows:
            bookings.append({
                "bookingID": row[0],
                "userID": row[1],
                "tourDatetime": row[2],
                "adults": row[3],
                "children": row[4],
                "hotel": row[5],
                "rooms": row[6],
                "nights": row[7]
            })

        print("returning bookings to the UI")
        return bookings
    
    def hashPassword(self, password): 
        return bcrypt.hashpw(password.encode("utf-8"), bcrypt.gensalt()) 
    
    def verifyPassword(self, password, storedHash): 
        return bcrypt.checkpw(password.encode("utf-8"), storedHash)