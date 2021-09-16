-- Codi per a crear base de dades
DROP DATABASE IF EXISTS Spoty;
CREATE DATABASE Spoty CHARACTER SET utf8mb4;
USE Spoty;

CREATE TABLE IF NOT EXISTS User (
  UserID VARCHAR(45) NOT NULL,
  UserType ENUM('premium','free'),
  email VARCHAR(45) NULL,
  password BINARY(15) NOT NULL,
  UserName VARCHAR(45) NULL,
  Birth DATE NOT NULL,
  Gender VARCHAR(45) NULL,
  Country VARCHAR(45) NULL,
  PostalCode INT NULL,
  PRIMARY KEY (UserID));

CREATE TABLE IF NOT EXISTS CreditCard (
  Number INT NOT NULL,
  Month INT NOT NULL,
  Year INT NOT NULL,
  SecurityCode INT NOT NULL,
  PRIMARY KEY (Number));

CREATE TABLE IF NOT EXISTS SubscriptionPayment (
  OrderNum INT NOT NULL AUTO_INCREMENT,
  UserID VARCHAR(45) NOT NULL,
  Date DATE NULL,
  Renewal DATETIME NOT NULL,
  CreditCard_Number INT NULL,
  PayPal_UserName VARCHAR(45) NULL,
  Total DOUBLE NULL,
  PRIMARY KEY (OrderNum),
	FOREIGN KEY (UserID) 
    REFERENCES User (UserID),
    FOREIGN KEY (CreditCard_Number)
    REFERENCES CreditCard (Number)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE IF NOT EXISTS Playlist (
  Playlist_Code INT NOT NULL,
  Playlist_status ENUM('active','delete'),
  Title VARCHAR(45) NOT NULL,
  SongsNum INT NOT NULL,
  Created DATE NOT NULL,
  Playlist_UserID VARCHAR(45) NOT NULL,
  PRIMARY KEY (Playlist_Code),
    FOREIGN KEY (PlayList_UserID)
    REFERENCES User(UserID)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
    
CREATE TABLE IF NOT EXISTS User_Share_PlayList (
  Share_UserID VARCHAR(45) NOT NULL,
  Playlist_Code INT NOT NULL,
  Date DATE NULL,
  PRIMARY KEY (Share_UserID, Playlist_Code),
    FOREIGN KEY (Share_UserID)
    REFERENCES User(UserID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (Playlist_Code)
    REFERENCES Playlist (Playlist_Code)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE IF NOT EXISTS Artist (
  idArtist INT NOT NULL,
  Name VARCHAR(45) NULL,
  Photo BLOB NULL,
  Related_idArtist INT NOT NULL,
  PRIMARY KEY (idArtist),
    FOREIGN KEY (Related_idArtist)
    REFERENCES Artist(idArtist)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE IF NOT EXISTS Album (
  idAlbum INT NOT NULL,
  Title VARCHAR(45) NULL,
  Year INT NULL,
  Cover BLOB NULL,
  Artist_idArtist INT NOT NULL,
  PRIMARY KEY (idAlbum),
    FOREIGN KEY (Artist_idArtist)
    REFERENCES Artist (idArtist)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE IF NOT EXISTS Song (
  idSong INT NOT NULL,
  Title VARCHAR(45) NOT NULL,
  Duration DECIMAL(2) NULL,
  TimesPlayed INT NULL,
  Album_idAlbum INT NOT NULL,
  PRIMARY KEY (idSong),
    FOREIGN KEY (Album_idAlbum)
    REFERENCES Album (idAlbum)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE IF NOT EXISTS User_follows_Artist (
  Artist_UserID VARCHAR(45) NOT NULL,
  Artist_idArtist INT NOT NULL,
  PRIMARY KEY (Artist_UserID, Artist_idArtist),
    FOREIGN KEY (Artist_UserID)
    REFERENCES User(UserID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (Artist_idArtist)
    REFERENCES Artist(idArtist)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE IF NOT EXISTS User_Favorite_Album (
  Fav_Album_idAlbum INT NOT NULL,
  Fav_Album_UserID VARCHAR(45) NOT NULL,
  PRIMARY KEY (Fav_Album_idAlbum, Fav_Album_UserID),
    FOREIGN KEY (Fav_Album_idAlbum)
    REFERENCES Album(idAlbum)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (Fav_Album_UserID)
    REFERENCES User(UserID)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE IF NOT EXISTS User_Favorite_Song (
  Fav_Song_idSong INT NOT NULL,
  Fav_Song_UserID VARCHAR(45) NOT NULL,
  PRIMARY KEY (Fav_Song_idSong, Fav_Song_UserID),
    FOREIGN KEY (Fav_Song_idSong)
    REFERENCES Song(idSong)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (Fav_Song_UserID)
    REFERENCES User(UserID)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


















