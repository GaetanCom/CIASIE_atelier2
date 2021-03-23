INSERT INTO Members (id, pseudo, password, firstname, lastname, mail) VALUES
(1, 'Admin', 'Admin123', 'Admin', 'Admin', 'Admin@gmail.com'),
(2, 'Keduma',  'Keduma123', 'Kevin', 'Dupont-Marin', 'Keduma@gmail.com'),
(3, 'Guitar',  'Guitar123', 'Gaetan', 'Comacle', 'Guitar@gmail.com'),
(4, 'Zacpot',  'Zacpot123', 'Arthur', 'Loeuillet',  'Zacpot@gmail.com'),
(5, 'Trema',  'Trema123', 'Loic', 'Oberle', 'Trema@gmail.com'),
(6, 'Shiryu',  'Shiryu123', 'Scott', 'Halgue', 'Shiryu@gmail.com'),
(7, 'Harry',  'Harry123', 'Harry', 'Potter', 'Harry@gmail.com');

INSERT INTO Address (id, number, street, zipcode, country) VALUES
(1, '27', 'Grande Rue', 54000, 'France'),
(2, '16',  'Rue Saint-Georges', 54000, 'France'),
(3, '10',  'Rue de Villers', 54000, 'France'),
(4, '14',  'Rue de la Primatiale', 54000, 'France'),
(5, '29',  'Rue des Maréchaux', 54000, 'France'),
(6, '14',  'Rue de Mon Désert', 54000, 'France'),
(7, '26',  'Rue Emile Bertin', 54000, 'France');

INSERT INTO Events (id, title, description, date, url, id_address, id_creator) VALUES
(1, 'Mon anniversaire', 'Venez fêter mon anniv a la Tacos', '05/05/2021/18:00', 2 ,2),
(2, 'Ma bar mitsva', 'Venez fêter ma bar mitsva', '11/06/2021/14:00', 6 ,3),
(3, 'Mon permis de conduire', 'Venez fêter mon permis de conduire', '20/03/2021/18:00', 7 ,4),
(4, 'Mon Diplome', 'Venez fêter mon Diplome', '07/07/2021/10:00', 5 ,5);