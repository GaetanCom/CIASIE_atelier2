INSERT INTO Status (id, label) VALUES
(1, 'Administrator'),
(2, 'Member');

INSERT INTO Members (id, pseudo, password, firstname, lastname, mail, last_connexion, id_status) VALUES
(1, 'Admin', 'sha1$ae6555dc$1$d9c6c47d7fcb5f2a96976b36176b0984e52cf24c', 'Admin', 'Admin', 'Admin@gmail.com', '24/03/2021/18:00', 1),
(2, 'Keduma',  'sha1$850e756f$1$0da70dd5b17e9d32f66ad572d35d22adaffce99e', 'Kevin', 'Dupont-Marin', 'Keduma@gmail.com', '24/03/2021/18:00', 2),
(3, 'Guitar',  'sha1$7c7b4a58$1$902f92aaaccb2c9998bb953fa9f58b9c181f82ee', 'Gaetan', 'Comacle', 'Guitar@gmail.com', '24/03/2021/18:00',2),
(4, 'Zacpot',  'sha1$168fc9e0$1$3edfa92c58028ba50ca2b9c99916adf9ffb2d571', 'Arthur', 'Loeuillet',  'Zacpot@gmail.com', '24/03/2021/18:00', 2),
(5, 'Trema',  'sha1$0dfc8f05$1$7eb79fe78d23a26c7159369ef0cb84b2ce4d381d', 'Loic', 'Oberle', 'Trema@gmail.com', '24/03/2021/18:00', 2),
(6, 'Shiryu',  'sha1$153be041$1$781ac7645d3f8d831e5b1897b80995b0d9962926', 'Scott', 'Halgue', 'Shiryu@gmail.com', '24/03/2021/18:00', 2),
(7, 'Jbb',  'sha1$2e4c830f$1$097baa5603c231d1f09d691506b9657f56ca4316', 'Jean-Baptiste', 'Bernard', 'Jbbernard@gmail.com', '24/03/2021/18:00', 2);

INSERT INTO Address (id, number, street, zipcode, country) VALUES
(1, '27', 'Grande Rue', 54000, 'France'),
(2, '16',  'Rue Saint-Georges', 54000, 'France'),
(3, '10',  'Rue de Villers', 54000, 'France'),
(4, '14',  'Rue de la Primatiale', 54000, 'France'),
(5, '29',  'Rue des Maréchaux', 54000, 'France'),
(6, '14',  'Rue de Mon Désert', 54000, 'France'),
(7, '26',  'Rue Emile Bertin', 54000, 'France');

INSERT INTO Events (id, title, description, date, url, id_address, id_creator) VALUES
(1, 'Mon anniversaire', 'Venez fêter mon anniv au Tacos', '05/05/2021/18:00', "https://www.google.com/", 2, 2),
(2, 'Ma bar-mitzvah', 'Venez fêter ma bar-mitzvah', '11/06/2021/14:00', "https://www.google.com/", 6, 3),
(3, 'Mon permis de conduire', 'Venez fêter mon permis de conduire', '20/03/2021/18:00', "https://www.google.com/", 7, 4),
(4, 'Mon Diplome', 'Venez fêter mon Diplome', '07/07/2021/10:00', "https://www.google.com/", 5, 5);

INSERT INTO Guests (id, accept, id_member, id_event) VALUES
(1, 1, 3, 1),
(2, 3, 4, 1),
(3, 1, 5, 1),
(4, 3, 6, 1),
(5, 2, 7, 1),
(6, 1, 2, 2),
(7, 3, 4, 2),
(8, 3, 5, 2),
(9, 2, 6, 2),
(10, 2, 7, 2),
(11, 3, 2, 3),
(12, 3, 3, 3),
(13, 1, 5, 3),
(14, 3, 6, 3),
(15, 2, 7, 3),
(16, 1, 2, 4),
(17, 2, 3, 4),
(18, 3, 4, 4),
(19, 3, 6, 4),
(20, 2, 7, 4);

INSERT INTO Messages (id, text, date, id_member, id_event) VALUES
(1, 'Venez nombreux', '22/03/2021/18:00', 2, 1),
(2, 'Je serais là', '22/03/2021/18:00', 3, 1),
(3, 'Impossible pour moi', '22/03/2021/18:00', 4, 1),
(4, 'J arrive dans 5 minutes!', '22/03/2021/18:00', 5, 1),
(5, 'ABS dzl', '22/03/2021/18:00', 6, 1),
(6, 'pas la non plus', '22/03/2021/18:00', 7, 2),
(7, 'ok', '22/03/2021/18:00', 2, 2),
(8, 'dite moi si vous etes dispo', '22/03/2021/18:00', 3, 2),
(9, 'Je pourrais pas venir dzl', '22/03/2021/18:00', 4, 2),
(10, 'Je suis de la partie! :)', '22/03/2021/18:00', 5, 3),
(11, 'Je sais pas encore', '22/03/2021/18:00', 6, 3),
(12, 'Faut que je vois', '22/03/2021/18:00', 7, 3),
(13, 'Lets go dude!', '22/03/2021/18:00', 2, 4),
(14, 'aye j ai deja un truc de prévu mec', '22/03/2021/18:00', 3, 4);