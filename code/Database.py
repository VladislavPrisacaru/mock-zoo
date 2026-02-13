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
                userId INTEGER PRIMARY KEY AUTOINCREMENT,
                username TEXT NOT NULL UNIQUE,
                email TEXT NOT NULL UNIQUE,
                passwordHash BLOB NOT NULL
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
        self.cursor.execute( "SELECT userId, username, email FROM users WHERE email = ?", (email,))
        row = self.cursor.fetchone()

        if row is None: 
            return False 
        
        return { "userId": row[0], "username": row[1], "email": row[2]}
    
    def hashPassword(self, password): 
        return bcrypt.hashpw(password.encode("utf-8"), bcrypt.gensalt()) 
    
    def verifyPassword(self, password, storedHash): 
        return bcrypt.checkpw(password.encode("utf-8"), storedHash)