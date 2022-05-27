# """ database dependencies to support Users db examples """
# from random import randrange
#
# from __init__ import db
# from sqlalchemy.exc import IntegrityError
# from werkzeug.security import generate_password_hash, check_password_hash
# from flask_login import UserMixin
#
# ''' Tutorial: https://www.sqlalchemy.org/library.html#tutorials, try to get into Python shell and follow along '''
#
#
# # Define the 'Users Notes' table  with a relationship to Users within the model
# # Relationships are expressed with the relationship() function. However the foreign key has to be separately
# # declared with the ForeignKey class.
# # A Foreign key is a column that creates a relationship between two tables. The purpose of the Foreign key is
# # to maintain data integrity and allow navigation between two different instances of an entity. It acts as a
# # cross-reference between two tables as it references the primary key of another table(Users in our case).
# # Every relationship in the database should be supported by a foreign key.
#
# class Notes(db.Model):
#     __tablename__ = 'notes'
#
#     # Define the Notes schema
#     id = db.Column(db.Integer, primary_key=True)
#     note = db.Column(db.Text, unique=False, nullable=False)
#     # Define a relationship in Notes Schema to userID who originates the note, many-to-one (many notes to one user)
#     userID = db.Column(db.Integer, db.ForeignKey('users.userID'))
#
#     # Constructor of a Notes object, initializes of instance variables within object
#     def __init__(self, note, userID):
#         self.note = note
#         self.userID = userID
#
#     # Returns a string representation of the Notes object, similar to java toString()
#     # returns string
#     def __repr__(self):
#         return "Notes(" + str(self.id) + "," + self.note + "," + str(self.userID) + ")"
#
#     # CRUD create, adds a new record to the Notes table
#     # returns the object added or None in case of an error
#     def create(self):
#         try:
#             # creates a Notes object from Notes(db.Model) class, passes initializers
#             db.session.add(self)  # add prepares to persist person object to Notes table
#             db.session.commit()  # SqlAlchemy "unit of work pattern" requires a manual commit
#             return self
#         except IntegrityError:
#             db.session.remove()
#             return None
#
#     # CRUD read, returns dictionary representation of Notes object
#     # returns dictionary
#     def read(self):
#         return {
#             "id": self.id,
#             "note": self.note,
#             "userID": self.userID
#         }
#
#
# # Define the Users table within the model
# # -- Object Relational Mapping (ORM) is the key concept of SQLAlchemy
# # -- a.) db.Model is like an inner layer of the onion in ORM
# # -- b.) Users represents data we want to store, something that is built on db.Model
# # -- c.) SQLAlchemy ORM is layer on top of SQLAlchemy Core, then SQLAlchemy engine, SQL
# class Users(UserMixin, db.Model):
#     __tablename__ = 'users'
#
#     # Define the Users schema
#     userID = db.Column(db.Integer, primary_key=True)
#     name = db.Column(db.String(255), unique=False, nullable=False)
#     email = db.Column(db.String(255), unique=True, nullable=False)
#     password = db.Column(db.String(255), unique=False, nullable=False)
#     phone = db.Column(db.String(255), unique=False, nullable=False)
#     # Defines a relationship between User record and Notes table, one-to-many (one user to many notes)
#     notes = db.relationship("Notes", cascade='all, delete', backref='users', lazy=True)
#     # lazy defines when SQLAlchemy will
#     # load the data  from the database: True (which is the default) means that
#     # SQLAlchemy will load the data as
#     # necessary in one go using a standard 'select' statement.