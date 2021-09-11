-- Dades per crear la base de dades

CREATE SCHEMA IF NOT EXISTS pizzeria;
USE pizzeria;

CREATE TABLE PROVINCIA (
	provincia_id SMALLINT PRIMARY KEY AUTO_INCREMENT,
	provincia_nom VARCHAR(30)
);

CREATE TABLE LOCALITAT (
	localitat_id SMALLINT PRIMARY KEY AUTO_INCREMENT,
	localitat_nom VARCHAR(30),
    provincia_id SMALLINT,
    FOREIGN KEY (provincia_id) REFERENCES PROVINCIA(provincia_id)
		ON UPDATE CASCADE ON DELETE CASCADE
); 

CREATE TABLE CLIENT (
	client_id INTEGER AUTO_INCREMENT,
    client_nom VARCHAR(25),
    client_cognoms VARCHAR(50),
    client_adreca VARCHAR(50),
    client_cp SMALLINT,
    client_localitat SMALLINT,
    client_provincia SMALLINT,
    client_telefon VARCHAR(15),
    PRIMARY KEY (client_id),
    FOREIGN KEY (client_localitat) REFERENCES LOCALITAT(localitat_id)
		ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (client_provincia) REFERENCES PROVINCIA(provincia_id)
		ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE CATEGORIA (
	categoria_id VARCHAR(20) PRIMARY KEY,
    categoria_nom VARCHAR(30)
);

CREATE TABLE PRODUCTE (
	producte_id VARCHAR(10),
    producte_nom VARCHAR(20) NOT NULL,
    producte_desc VARCHAR(40) NOT NULL,
    producte_imatge BLOB,
    producte_preu DOUBLE,
    producte_categoria VARCHAR(20),
    PRIMARY KEY (producte_id),
    FOREIGN KEY (producte_categoria) REFERENCES CATEGORIA (categoria_id)
		ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE BOTIGA (
	botiga_id VARCHAR(10),
    botiga_adreca VARCHAR(30),
    botiga_cp SMALLINT,
    botiga_localitat SMALLINT,
    botiga_provincia SMALLINT,
    PRIMARY KEY (botiga_id),
    FOREIGN KEY (botiga_localitat) REFERENCES LOCALITAT(localitat_id)
		ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (botiga_provincia) REFERENCES PROVINCIA(provincia_id)
		ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE EMPLEAT (
	empleat_id VARCHAR(10),
    empleat_nom VARCHAR(25),
    empleat_cognoms VARCHAR(50),
    empleat_nif VARCHAR(10) UNIQUE,
    empleat_telefon VARCHAR(10),
    empleat_botiga VARCHAR(10),
    PRIMARY KEY (empleat_id),
    FOREIGN KEY (empleat_botiga) REFERENCES BOTIGA(botiga_id)
		ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE COMANDA (
	comanda_id SMALLINT AUTO_INCREMENT,
    comanda_client INTEGER,
    comanda_data TIMESTAMP,
    comanda_lliurament VARCHAR(10) NOT NULL,
    comanda_preuTotal DOUBLE,
    comanda_horaEntrega TIMESTAMP,
    comanda_repartidor VARCHAR(10),
    comanda_botiga_id VARCHAR(10),
    PRIMARY KEY (comanda_id),
    FOREIGN KEY (comanda_client) REFERENCES CLIENT (client_id)
		ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (comanda_repartidor) REFERENCES EMPLEAT(empleat_id)
		ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (comanda_botiga_id) REFERENCES BOTIGA(botiga_id)
		ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE DETALL (
	detall_id SMALLINT AUTO_INCREMENT,
    detall_idComanda SMALLINT,
    detall_idProducte VARCHAR(10),
	detall_quantitat SMALLINT,
    detall_preu DOUBLE,
    PRIMARY KEY (detall_id),
    FOREIGN KEY (detall_idComanda) REFERENCES COMANDA(comanda_id)
		ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (detall_idProducte) REFERENCES PRODUCTE(producte_id)
		ON UPDATE CASCADE ON DELETE CASCADE
);

-- Dades per a omplir la base de dades

INSERT INTO PROVINCIA VALUES (01,'Barcelona'),
							 (02,'Tarragona'),
                             (03,'Girona'),
                             (04,'Lleida');
                             
INSERT INTO LOCALITAT VALUES (001,'Barcelona',01),
							 (002,'Tarragona',02),
                             (003,'Girona',03),
                             (004,'Lleida',04);
                             
INSERT INTO CLIENT VALUES (NULL,'Lucas','Gomis','c/ Carrer, 1',08017,001,01,'654983254'),
						  (NULL,'María','Gall','c/ Carrer, 2',08023,002,02,'623541256'),
                          (NULL,'Miguel','Raton','c/ Carrer, 3',08045,003,03,'689093478'),
                          (NULL,'Sara','Bola','c/ Carrer, 3',08034,004,04,'698235412'),
                          (NULL,'Ramon','Dente','c/ Carrer, 4',08023,002,02,'671346523');

INSERT INTO BOTIGA VALUES ('B01','c/ Carrer, 123',08025,001,01),
						  ('B02','c/ Carrer, 245',08026,002,02),
                          ('B03','c/ Carrer, 334',08034,003,03),
                          ('B04','c/ Carrer, 445',08017,004,04);
                          
INSERT INTO EMPLEAT VALUES ('E2101','George','Harrison','34561234H','623344512','B01'),
						   ('E2102','Paul','McCartney','343267890F','654324512','B02'),
                           ('E2103','Ringo','Starr','45671234J','634562312','B03'),
                           ('E2104','John','Lennon','23456789K','632344567','B04');
                           
INSERT INTO CATEGORIA VALUES ('G','Gran'),
							 ('M','Mitjana'),
                             ('P','Petita');
                           
INSERT INTO PRODUCTE VALUES ('H01','Hamburgesa','150 grams','ham1.jpg',9.80,NULL),
							('H02','Hamburgesa formatge','250 grams','ham2.jpg',12.80,NULL),
                            ('H03','Hamburgesa bacon','250 grams','ham3.jpg',12.80,NULL),
                            ('B01','CocaCola','Refresc de cola','B1.jpg',3.80,NULL),
                            ('B02','Fanta','Refresc taronja','B2.jpg',2.80,NULL),
                            ('B03','Estrella','Birra','B3.jpg',3.80,NULL),
                            ('P01','Pizza Margarita','amb tomaquet','Piz1.jpg',12.00,'G'),
                            ('P02','Pizza fortmage','amb tomaquet i formatge','Piz2.jpg',15.00,'P'),
                            ('P03','Pizza Diavola','amb tomaquet i picant','Piz3.jpg',18.00,'M');
                            
INSERT INTO COMANDA VALUES (NULL,1,CURRENT_TIMESTAMP,'a domicili',45.50,CURRENT_TIMESTAMP,'E2101','B01'),
						   (NULL,2,CURRENT_TIMESTAMP,'a domicili',23.50,CURRENT_TIMESTAMP,'E2102','B02'),
                           (NULL,3,CURRENT_TIMESTAMP,'a domicili',78.50,CURRENT_TIMESTAMP,'E2103','B03'),
                           (NULL,4,CURRENT_TIMESTAMP,'a domicili',56.50,CURRENT_TIMESTAMP,'E2104','B04'),
                           (NULL,1,CURRENT_TIMESTAMP,'al local',47.50,CURRENT_TIMESTAMP,NULL,'B02'),
						   (NULL,2,CURRENT_TIMESTAMP,'al local',34.50,CURRENT_TIMESTAMP,NULL,'B01'),
						   (NULL,3,CURRENT_TIMESTAMP,'al local',14.50,CURRENT_TIMESTAMP,NULL,'B03');
                           
INSERT INTO DETALL VALUES (NULL,1,'H01',1,9.80),
						  (NULL,1,'H02',1,12.80),
                          (NULL,1,'B01',1,3.80),
                          (NULL,1,'B02',1,2.80),
                          (NULL,2,'H01',1,9.80),
						  (NULL,2,'H02',1,12.80),
                          (NULL,2,'B01',1,3.80),
                          (NULL,2,'B02',1,2.80),
                          (NULL,3,'H01',1,9.80),
						  (NULL,3,'H02',1,12.80),
                          (NULL,3,'B01',1,3.80),
                          (NULL,3,'B02',1,2.80),
                          (NULL,4,'H01',1,9.80),
						  (NULL,4,'H02',1,12.80),
                          (NULL,4,'B01',1,3.80),
                          (NULL,4,'B02',1,2.80);
                          
-- Cerques a la base de dades

SELECT comanda_repartidor AS 'Empleat', sum(comanda_id) AS 'Num comandes' FROM COMANDA WHERE comanda_repartidor = 'E2102';

SELECT COUNT(detall_idProducte) AS 'Begudes consumides a Barcelona' FROM DETALL d INNER JOIN COMANDA c ON d.detall_idComanda = c.comanda_id WHERE detall_idProducte LIKE 'B%%' AND comanda_botiga_id = (SELECT botiga_id FROM BOTIGA WHERE botiga_localitat = 001);
