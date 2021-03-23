CREATE TABLE Address
(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    number INT,
    street VARCHAR(255),
    zipcode INT,
    country VARCHAR(255),
    longitude DOUBLE,
    latitude DOUBLE
)ENGINE=InnoDB;

CREATE TABLE Members
(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    firstname VARCHAR(255),
    lastname VARCHAR(255),
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
    url VARCHAR(255),
    id_address INT,
    id_creator INT
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
    id_member INT,
    id_event INT
)ENGINE=InnoDB;

ALTER TABLE Events
ADD CONSTRAINT fk_event_creator FOREIGN KEY (id_creator) REFERENCES Members(id);
ALTER TABLE Events
ADD CONSTRAINT fk_event_address FOREIGN KEY (id_address) REFERENCES Address(id);

ALTER TABLE Guests
ADD CONSTRAINT fk_guest_event FOREIGN KEY (id_event) REFERENCES Events(id);
ALTER TABLE Guests
ADD CONSTRAINT fk_guest_member FOREIGN KEY (id_member) REFERENCES Members(id);

ALTER TABLE Messages
ADD CONSTRAINT fk_message_member FOREIGN KEY (id_member) REFERENCES Members(id);
ALTER TABLE Messages
ADD CONSTRAINT fk_message_event FOREIGN KEY (id_event) REFERENCES Events(id);