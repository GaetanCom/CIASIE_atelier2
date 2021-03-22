CREATE TABLE Members
(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    firstname VARCHAR(255),
    name VARCHAR(255),
    mail VARCHAR(255),
    pseudo VARCHAR(255),
    password VARCHAR(255)
)ENGINE=InnoDB;

CREATE TABLE Events
(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    title VARCHAR(255),
    description VARCHAR(255),
    date VARCHAR(255),
    longitude DOUBLE,
    latitude DOUBLE,
    adress VARCHAR(255),
    url VARCHAR(255),
    id_creator INT,
    id_message INT
)ENGINE=InnoDB;

CREATE TABLE Guests
(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    accept BOOLEAN,
    id_event INT,
    id_member INT
)ENGINE=InnoDB;

CREATE TABLE Messages
(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    date VARCHAR(255),
    id_member INT
)ENGINE=InnoDB;