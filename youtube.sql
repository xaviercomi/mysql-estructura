-- Codi per a crear base de dades

CREATE SCHEMA IF NOT EXISTS youtube;
USE youtube ;

CREATE TABLE IF NOT EXISTS CANAL (
  canal_id VARCHAR(10) NOT NULL,
  canal_nom VARCHAR(20) NOT NULL,
  canal_descripcio VARCHAR(100) NOT NULL,
  canal_creat DATE NOT NULL,
  PRIMARY KEY (canal_id));
  
CREATE TABLE IF NOT EXISTS ESTAT (
  estat_id TINYINT NOT NULL,
  estat_nom VARCHAR(10) NOT NULL,
  PRIMARY KEY (estat_id));
  
CREATE TABLE IF NOT EXISTS USUARI (
  usuari_nif VARCHAR(10) NOT NULL,
  usuari_contrasenya CHAR(250) NOT NULL,
  usuari_nom VARCHAR(30) NOT NULL,
  usuari_neix DATE NOT NULL,
  usuari_sexe VARCHAR(10) NOT NULL,
  usuari_email VARCHAR(30) NOT NULL,
  usuari_cp SMALLINT NOT NULL,
  usuari_pais VARCHAR(30) NOT NULL,
  PRIMARY KEY (usuari_nif));
  
CREATE TABLE IF NOT EXISTS VIDEO (
  video_id VARCHAR(10) NOT NULL,
  video_titol VARCHAR(40) NOT NULL,
  video_descripcio VARCHAR(100) NOT NULL,
  video_nomArxiu VARCHAR(20) NOT NULL COMMENT 'Nom de l’arxiu del vídeo.',
  video_duracio DOUBLE NOT NULL COMMENT 'Minuts i segons necessaris per mostrar el contingut en la seva totalitat. ',
  video_mida DOUBLE NOT NULL COMMENT 'Quantitat de bits que utilitza.',
  video_visionat INT NOT NULL COMMENT 'visionat fa referència a la quantitat de vegades que s’ha vist el vídeo. ',
  video_thumbnail BLOB NOT NULL,
  video_publicat VARCHAR(10) NOT NULL COMMENT 'video_publicat correspon a la identificació (nif) de l’usuari que ha publicat el vídeo.',
  video_estat_id TINYINT NOT NULL,
  video_dataPublicacio DATETIME NOT NULL,
  PRIMARY KEY (video_id, video_publicat),
    FOREIGN KEY (video_estat_id)
    REFERENCES ESTAT (estat_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (video_publicat)
    REFERENCES USUARI(usuari_nif)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE IF NOT EXISTS COMENTARI (
  comentari_id VARCHAR(10) NOT NULL,
  comentari_text VARCHAR(150) NOT NULL,
  comentari_data DATE NOT NULL,
  comentari_video_id VARCHAR(10) NOT NULL,
  PRIMARY KEY (comentari_id),
	FOREIGN KEY (comentari_video_id)
    REFERENCES VIDEO(video_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE IF NOT EXISTS COMENTARI_USUARI (
  comentari_usuari_id VARCHAR(10) NOT NULL,
  comentari_usuari_agrada INT NOT NULL DEFAULT '0',
  comentari_usuari_noAgrada INT NOT NULL DEFAULT '0',
  comentari_usuari_data DATE NOT NULL,
  comentari_usuari_usuari_nif VARCHAR(10) NOT NULL,
  comentari_usuari_comentari_id VARCHAR(10) NOT NULL,
  PRIMARY KEY (comentari_usuari_id),
    FOREIGN KEY (comentari_usuari_comentari_id)
    REFERENCES COMENTARI (comentari_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (comentari_usuari_usuari_nif)
    REFERENCES USUARI (usuari_nif)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE IF NOT EXISTS ETIQUETA (
  etiqueta_id VARCHAR(10) NOT NULL,
  etiqueta_nom VARCHAR(10) NOT NULL,
  PRIMARY KEY (etiqueta_id));

CREATE TABLE IF NOT EXISTS ETIQUETADO (
  etiquetado_etiqueta_id VARCHAR(10) NOT NULL,
  etiquetado_video_id VARCHAR(10) NOT NULL,
    FOREIGN KEY (etiquetado_etiqueta_id)
    REFERENCES ETIQUETA(etiqueta_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (etiquetado_video_id)
    REFERENCES VIDEO(video_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE IF NOT EXISTS LIKES (
  likes_like INT NOT NULL DEFAULT '0',
  likes_dislike INT NOT NULL DEFAULT '0',
  likes_data DATETIME NOT NULL,
  likes_usuari_nif VARCHAR(10) NOT NULL,
  likes_video_id VARCHAR(10) NOT NULL,
    FOREIGN KEY (likes_usuari_nif)
    REFERENCES USUARI (usuari_nif)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (likes_video_id)
    REFERENCES VIDEO (video_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE IF NOT EXISTS PLAYLIST (
  playlist_id VARCHAR(10) NOT NULL,
  playlist_nom VARCHAR(20) NOT NULL,
  playlist_creada DATE NOT NULL,
  playlist_estat TINYINT NOT NULL,
  PRIMARY KEY (playlist_id),
    FOREIGN KEY (playlist_estat)
    REFERENCES ESTAT (estat_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE IF NOT EXISTS SUBSCRIPCIO (
  subscripcio_id VARCHAR(10) NOT NULL,
  subscripcio_canal_id VARCHAR(10) NOT NULL,
  subscripcio_usuari_nif VARCHAR(10) NOT NULL,
  PRIMARY KEY (subscripcio_id),
    FOREIGN KEY (subscripcio_canal_id)
    REFERENCES CANAL(canal_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (subscripcio_usuari_nif)
    REFERENCES USUARI(usuari_nif)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE IF NOT EXISTS VIDEO_PLAYLIST (
  playlist_usuari_nif VARCHAR(10) NOT NULL,
  playlist_playlist_id VARCHAR(10) NOT NULL,
    FOREIGN KEY (playlist_playlist_id)
    REFERENCES PLAYLIST(playlist_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (playlist_usuari_nif)
    REFERENCES USUARI(usuari_nif)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

    
-- Dades a insertar a la base de dades

INSERT INTO USUARI VALUES ('45671234H','1234','Ross','1961-03-22','male','rossboss@gmail.com',08012,'United States of America'),
						  ('45346778K','5678','Joey','1960-03-22','male','joeytribbiani@hotmail.com',08013,'Italy'),
						  ('78893467T','9999','Phobe','1973-03-22','female','phobebuffay@gmail.com',08015,'Spain');
                          
INSERT INTO CANAL VALUES ('C001','Supervideos','very long videos','2019-01-01'),
						 ('C002','Coolvideos','very cool videos','2020-02-02'),
                         ('C003','Shortvideos','very short videos','2021-03-03');
                         
INSERT INTO SUBSCRIPCIO VALUES ('S001','C001','45671234H'),
							   ('S002','C002','45346778K'),
                               ('S003','C003','78893467T');
                               
INSERT INTO ESTAT VALUES ('1','public'),
						 ('2','privat'),
                         ('3','ocult');
                         
INSERT INTO PLAYLIST VALUES ('PL01','in the moon','2020-02-03','1'),
							('PL02','in the moon','2019-11-02','1'),
                            ('PL03','in the moon','2020-12-03','3');
                            
INSERT INTO VIDEO_PLAYLIST VALUES ('45671234H','PL01'),
								  ('45346778K','PL02'),
								  ('78893467T','PL03');
                                  
INSERT INTO VIDEO VALUES ('V001','Dog','Dog talking','dogTalk.mov',2.45,120,2000,'/picdog.png','45671234H','1','2018-4-6'),
						 ('V002','Cat','Cat talking','catTalk.mov',1.00,60,1000,'/piccat.png','45346778K','3','2017-5-12'),
						 ('V003','Fish','Fish talking','fishTalk.mov',1.56,80,6000,'/picfish.png','78893467T','2','2020-6-15');
                         
INSERT INTO LIKES VALUES (1,0,'2020-9-12','45671234H','V001'),
						 (0,1,'2018-5-15','45346778K','V002'),
                         (1,0,'2020-1-30','78893467T','V003');
                         
INSERT INTO ETIQUETA VALUES ('E20','Animals'),
							('E30','Cats'),
                            ('E40','Ocean');
                         
INSERT INTO ETIQUETADO VALUES ('E20','V001'),
							  ('E30','V002'),
                              ('E40','V003');
                              
INSERT INTO COMENTARI VALUES ('COM1','i like it','2021-1-11','V001'),
							 ('COM2','i like it','2019-3-1','V002'),
                             ('COM3','i like it','2016-8-12','V003');
                             
INSERT INTO COMENTARI_USUARI VALUES ('COU1',0,1,'2019-12-7','45671234H','COM1'),
									('COU2',1,0,'2020-12-6','45346778K','COM2'),
									('COU3',0,1,'2021-8-9','78893467T','COM3');
									





