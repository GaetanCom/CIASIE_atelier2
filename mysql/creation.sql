CREATE TABLE Status
(
    idStatus INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    label VARCHAR(255)
)ENGINE=InnoDB;

CREATE TABLE Address
(
    idAddress INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    number INT,
    street VARCHAR(255),
    zipcode INT,
    country VARCHAR(255),
    longitude DOUBLE,
    latitude DOUBLE
)ENGINE=InnoDB;

CREATE TABLE Members
(
    idMembers INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    firstname VARCHAR(255),
    lastname VARCHAR(255),
    mail VARCHAR(255),
    pseudo VARCHAR(255),
    password VARCHAR(255),
    CONSTRAINT AK_pseudo UNIQUE(pseudo),
    last_connexion VARCHAR(255),
    id_status INT
)ENGINE=InnoDB;

CREATE TABLE Events
(
    idEvents INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    title VARCHAR(255),
    description VARCHAR(255),
    date VARCHAR(255),
    url VARCHAR(255),
    id_address INT,
    id_creator INT
)ENGINE=InnoDB;

CREATE TABLE Guests
(
    idGuests INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    accept INT,
    id_event INT,
    id_member INT
)ENGINE=InnoDB;

CREATE TABLE Messages
(
    idMessages INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    text VARCHAR(255),
    date VARCHAR(255),
    id_member INT,
    id_event INT
)ENGINE=InnoDB;

ALTER TABLE Members
ADD CONSTRAINT fk_member_status FOREIGN KEY (id_status) REFERENCES Status(idStatus);

ALTER TABLE Events
ADD CONSTRAINT fk_event_creator FOREIGN KEY (id_creator) REFERENCES Members(idMembers);
ALTER TABLE Events
ADD CONSTRAINT fk_event_address FOREIGN KEY (id_address) REFERENCES Address(idAddress);

ALTER TABLE Guests
ADD CONSTRAINT fk_guest_event FOREIGN KEY (id_event) REFERENCES Events(idEvents);
ALTER TABLE Guests
ADD CONSTRAINT fk_guest_member FOREIGN KEY (id_member) REFERENCES Members(idMembers);

ALTER TABLE Messages
ADD CONSTRAINT fk_message_member FOREIGN KEY (id_member) REFERENCES Members(idMembers);
ALTER TABLE Messages
ADD CONSTRAINT fk_message_event FOREIGN KEY (id_event) REFERENCES Events(idEvents);