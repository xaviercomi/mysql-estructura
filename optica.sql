-- Codi per a crear la base de dades

CREATE DATABASE optica;
USE optica;

CREATE TABLE PROVEIDOR (
	proveidor_NIF VARCHAR(15) NOT NULL UNIQUE,
    nom VARCHAR(30) NOT NULL,
    adreca VARCHAR (30),
    ciutat VARCHAR (20),
    CP VARCHAR(5),
    pais VARCHAR(20),
    telefon VARCHAR(15) NOT NULL,
    fax VARCHAR(15),
    PRIMARY KEY (proveidor_NIF)
);

CREATE TABLE ULLERA (
	ullera_codi VARCHAR(10) NOT NULL UNIQUE,
    marca VARCHAR(20) NOT NULL,
    grad_esq DECIMAL(2,2) NOT NULL,
    grad_dta DECIMAL(2,2) NOT NULL,
    muntura VARCHAR(20)NOT NULL,
    color VARCHAR(15) NOT NULL,
    color_esq VARCHAR(15) NOT NULL,
    color_dta VARCHAR(15) NOT NULL,
    ullera_preu DOUBLE NOT NULL,
    PRIMARY KEY (ullera_codi)
);

CREATE TABLE CLIENTE (
	cliente_DNI VARCHAR(10) NOT NULL UNIQUE,
    nom VARCHAR(20),
    cognom VARCHAR(20),
    adreca VARCHAR(30),
    CP VARCHAR(5),
    telefon VARCHAR(15) NOT NULL,
    email VARCHAR(30),
    recomanat VARCHAR(30),
    registre DATE,
    PRIMARY KEY (cliente_DNI)
);

CREATE TABLE EMPLEAT (
	empleat_ID VARCHAR(10) NOT NULL UNIQUE,
	nom VARCHAR(20),
    cognom VARCHAR(20),
    adreca VARCHAR(30),
    CP VARCHAR(5),
    telefon VARCHAR(15),
    email VARCHAR(30),
    PRIMARY KEY (empleat_ID)
);

CREATE TABLE COMANDA (
	comanda_num SMALLINT NOT NULL AUTO_INCREMENT,
    proveidor_NIF VARCHAR(15) NOT NULL,
    ullera_codi VARCHAR(10) NOT NULL,
    date DATE NOT NULL,
    PRIMARY KEY (comanda_num),
    FOREIGN KEY (proveidor_NIF) REFERENCES PROVEIDOR(proveidor_NIF)
		ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (ullera_codi) REFERENCES ULLERA(ullera_codi)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE VENDA (
	venda_num SMALLINT NOT NULL AUTO_INCREMENT,
    cliente_DNI VARCHAR(10) NOT NULL,
    ullera_codi VARCHAR(10) NOT NULL,
    empleat_ID VARCHAR(10) NOT NULL,
    date DATE NOT NULL,
    PRIMARY KEY (venda_num),
    FOREIGN KEY (cliente_DNI) REFERENCES CLIENTE(cliente_DNI)
        ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (ullera_codi) REFERENCES ULLERA(ullera_codi)
        ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (empleat_ID) REFERENCES EMPLEAT(empleat_ID)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE DETALL_VENDA (
	venda_registre SMALLINT AUTO_INCREMENT,
    venda_num SMALLINT,
    ullera_codi VARCHAR(10) NOT NULL,
    preu_unitat DOUBLE NOT NULL, 
    quantitat SMALLINT NOT NULL,
    PRIMARY KEY (venda_registre),
	FOREIGN KEY (venda_num) REFERENCES VENDA(venda_num)
		ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (ullera_codi) REFERENCES ULLERA(ullera_codi)
		ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE DETALL_COMANDA (
	comanda_registre SMALLINT AUTO_INCREMENT,
	comanda_num SMALLINT,
    ullera_codi VARCHAR(10) NOT NULL,
    preu_unitat DOUBLE NOT NULL, 
    quantitat SMALLINT NOT NULL,
    PRIMARY KEY (comanda_registre),
    FOREIGN KEY (comanda_num) REFERENCES COMANDA(comanda_num)
		ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (ullera_codi) REFERENCES ULLERA(ullera_codi)
		ON UPDATE CASCADE ON DELETE CASCADE
);

-- Dades de la base de dades

INSERT INTO CLIENTE VALUES ('98765432J','Manuel','Gomez','c/ Balmes, 78','08087','698454856','manuelgomez@gmail.com','Javier C','2021-12-08'),
						   ('34567890T','María','Martínez','c/ Muntaner, 56','08017','634344869','jorgemartinez@gmail.com','Fernandez','2001-01-10'),
						   ('56782374G','Javier','Hernandez','c/ Aribau, 67','08045','698344529','jhernandez@gmail.com','Jose C','2000-02-2'),
						   ('47654236H','Sandra','Fernandez','c/ Casanova, 6','08034','678344543','pedrofernandez@gmail.com','La Popular','2019-06-4'),
						   ('47863463G','Lourdes','Pérez','c/ Urgell, 135','08025','675344556','jaimepm@gmail.com','IBM','2021-08-5'); 
                           

INSERT INTO EMPLEAT VALUES ('JC6756','Juan','Coma','c/ Calle, 1','08017','679542365','juanc@hotmail.com'),
						   ('GM6345','Sara','Goma','c/ Caller, 2','09345','62354845','saragoma@gmail.es'),
                           ('CC6356','Carol','Coral','c/ Caller, 2','09345','62354845','carol@gmail.es'),
						   ('EG6345','Elena','Gay','c/ Caller, 2','09345','62354845','elenagay@gmail.com'),
                           ('CC6345','Carles','Casa','c/ Caller, 2','09345','62354845','carlesc@hotmail.es');
                           
INSERT INTO PROVEIDOR VALUES ('PRO23','Gafotas S.L.','c/ poligono, 1','Barcelona','08023','Spain','933456789','934568712'),
							 ('PRO56','Las gafas S.A.','c/ poligono, 2','Madrid','08067','Spain','933456789','934568712'),
                             ('PRO76','Gafas guays S.L.','c/ poligono, 3','Vitoria','08063','Spain','933456789','934568712'),
                             ('PRO28','Gafas caras S.A.','c/ poligono, 4','Lleida','08034','Spain','933456789','934568712'),
                             ('PRO78','Gafas olimpia S.L.','c/ poligono, 5','Girona','08089','Spain','933456789','934568712'),
                             ('PRO34','Gaferia S.L.','c/ poligono, 6','Bilbao','08090','Spain','933456789','934568712'),
                             ('PRO89','Gafas online S.L.','c/ poligono, 7','Tarragona','08012','Spain','933456789','934568712');
                             
INSERT INTO ULLERA VALUES ('U765','Boss',.75,.56,'pasta','negro','azul','azul',120.00),
						  ('U456','Ikks',.07,.05,'aluminio','negro','oscuro','oscuro',60.45),
                          ('U789','Carrera',.09,.06,'acero','negro','amarillo','amarillo',110.00),
                          ('U677','Rayban',.23,.96,'pasta','negro','transparente','transparente',89.00),
                          ('U768','Police',.87,.36,'acero','negro','rosa','rosa',90.00),
                          ('U678','Armani',.56,.26,'plastico','negro','transparete','transparente',75.60),
                          ('U747','Okley',.75,.16,'pasta','negro','azul','azul',9.00);
		
INSERT INTO VENDA VALUES (NULL,'34567890T','U789','JC6756','2019-01-01'),
						 (NULL,'56782374G','U789','GM6345','2019-02-14'),
                         (NULL,'34567890T','U677','JC6756','2019-03-18'),
                         (NULL,'56782374G','U789','CC6345','2020-04-16'),
                         (NULL,'34567890T','U765','EG6345','2020-11-05'),
                         (NULL,'47863463G','U789','GM6345','2020-12-03'),
                         (NULL,'34567890T','U678','JC6756','2020-03-04'),
                         (NULL,'47654236H','U789','EG6345','2021-09-06'),
                         (NULL,'34567890T','U747','JC6756','2021-10-21'),
                         (NULL,'98765432J','U789','CC6356','2021-07-13'),
                         (NULL,'47654236H','U789','GM6345','2021-08-07');
                         
INSERT INTO  COMANDA VALUES (NULL,'PRO23','U789','2019-01-15'),
							(NULL,'PRO56','U765','2019-06-14'),
                            (NULL,'PRO76','U456','2020-01-16'),
                            (NULL,'PRO78','U768','2020-06-16'),
                            (NULL,'PRO89','U747','2021-01-15');    
                            
INSERT INTO DETALL_COMANDA VALUES (NULL,1,'U765',78.00,50),	
								  (NULL,2,'U456',70.00,10),
                                  (NULL,3,'U768',67.89,30),
                                  (NULL,4,'U747',65.67,70),
                                  (NULL,5,'U678',78.50,25);
                                  
INSERT INTO DETALL_VENDA VALUES (NULL,1,'U789',125.00,1),
								(NULL,2,'U765',140.00,2),
								(NULL,3,'U747',111.00,1),
                                (NULL,4,'U789',150.00,2),
								(NULL,5,'U678',180.00,1),
                                (NULL,6,'U789',125.00,1),
								(NULL,7,'U765',140.00,2),
								(NULL,8,'U747',111.00,1),
                                (NULL,9,'U789',150.00,2),
								(NULL,10,'U678',180.00,1),
                                (NULL,11,'U677',180.00,2);
                                
-- Cerca a la base de dades

SELECT * FROM VENDA WHERE cliente_DNI = '56782374G' AND date BETWEEN '2019-01-01' AND '2021-01-01';

SELECT DISTINCT v.ullera_codi AS 'Model ullera', empleat_id AS 'Empleat' FROM VENDA v JOIN ULLERA u ON v.ullera_codi = u.ullera_codi WHERE empleat_id = 'JC6756' AND date BETWEEN '2019-01-01' AND '2020-01-01';

SELECT p.proveidor_NIF, nom AS 'nom proveidor' FROM PROVEIDOR p LEFT JOIN COMANDA c ON p.proveidor_NIF = c.proveidor_NIF WHERE c.ullera_codi IN (SELECT ullera_codi FROM VENDA);
