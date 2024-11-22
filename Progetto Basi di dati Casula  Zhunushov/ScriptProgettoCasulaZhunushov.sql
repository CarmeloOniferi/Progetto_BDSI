############################################################################
################      Script per progetto BDSI 2022/23     #################
############################################################################
#
# GRUPPO FORMATO DA:
#
# Matricola: 7085019      Cognome:  Casula        Nome:     Carmelo
# Matricola: 7073339      Cognome:  Zhunushov     Nome:     Sultan






####################################
#     creazione database           #
####################################

drop database  if exists progetto;
create database progetto;
use progetto;

####################################
#      creazione tabelle           #
####################################

CREATE TABLE Studente(
CF CHAR(20) NOT NULL UNIQUE,
Nome CHAR (30),
Cognome CHAR (30),
Telefono CHAR(30),
Email CHAR(30),
PRIMARY KEY(CF)
)ENGINE=INNODB;

CREATE TABLE sede(
IDSede INT NOT NULL,
nome CHAR(30),
Idirizzo CHAR(30),
Numero CHAR(30),
PRIMARY KEY(IDSede)
)ENGINE=INNODB;

CREATE TABLE docente(
IDDocente INT NOT NULL,
Nome CHAR(30),
Cognome CHAR(30),
PRIMARY KEY(IDDocente)

)ENGINE=INNODB;

CREATE TABLE corso(
IDCorso INT NOT NULL,
NomeC CHAR(30),
IDDocente INT NOT NULL,
DataI DATE,
PRIMARY KEY (IDCorso),
FOREIGN KEY(IDDocente) REFERENCES docente(IDDocente)
)ENGINE=INNODB;

CREATE TABLE esame(
IDEsame INT NOT NULL,
IDCorso INT NOT NULL,
IDDocente INT NOT NULL,
CFStudente CHAR(20) NOT NULL,
Voto INT,
Sede INT NOT NULL,
PRIMARY KEY(IDEsame),
FOREIGN KEY(IDCorso) REFERENCES corso(IDCorso),
FOREIGN KEY(IDDocente) REFERENCES docente(IDDocente),
FOREIGN KEY(CFStudente) REFERENCES studente(CF),
FOREIGN KEY(Sede) REFERENCES sede(IDSede)
)ENGINE=INNODB;

CREATE TABLE segue(
IDSegue INT NOT NULL,
CFStudente CHAR(20) NOT NULL,
IDCorso INT NOT NULL,
PRIMARY KEY(IDSegue),
FOREIGN KEY(CFStudente) REFERENCES Studente(CF),
FOREIGN KEY(IDCorso) REFERENCES corso(IDCorso)

)ENGINE=INNODB;

CREATE TABLE rfid(
ID INT NOT NULL AUTO_INCREMENT,
CFStudente CHAR(20) NOT NULL,
PRIMARY KEY(ID),
FOREIGN KEY(CFStudente) REFERENCES studente(CF)
)ENGINE=INNODB;

####################################
#          popolamento             #
####################################

insert into Studente values 
('ABCD','Carmelo','Casula','1234','carmelo@gmail.com'),
('ABCE','Sultan','Zhunushov','5678','sultan@gmail.com'),
('ZJHD','Paolo','Bitta','8920','bitta@gmail.com'),
('KAFT','Luca','Nervi','7296','luca@gmail.com'),
('KAFV','Jesse','Pinkman','2671','pinkman@hotmail.com'),
('YEJS','Gigi','Buffon','4829','buffon@juve.com'),
('PDNN','George','Martin','5432','martin@tiscali.it'),
('KANF','Giulio','Cesare','3221','giulio@virgilio.it'),
('EGDB','Goku','Sayan','5682','goku@gmail.com'),
('GOAT','Cristiano','Ronaldo','3213','ronaldo@gmail.com'),
('JUVE','Alex','Del Piero','3459','alex@nazionale.it'),
('FUEN','Lionel','Messi','3223','messi@hotmail.com'),
('RPDM','Jon','Snow','3421','jon@trono.net'),
('FDNS','Hank','Shrader','3214','hank@dea.com'),
('DCJA','Cliff','Burton','3134','cliff@metal.com');

insert into Sede values
(1,'Morgagni','Viale Morgagni',10),
(2,'Novoli','Via Di Novoli',7),
(3,'Dimai','Viale Morgagni','27'),
(4,'Dipartimento di statistica','Viale Morgagni',15),
(5,'Sesto Fiorentino','Via Firenze',23);


insert into docente values 
(1,'James','Hetfield'),
(2,'Barney','Stinson'),
(3,'Walter','White'),
(4,'Aldo','Baglio'),
(5,'Mario','Marras'),
(6,'Ignazio','La Russa');

insert into corso values(1,'Analisi III', 2,'2023-07-04'),
(2,'Fisica aereospaziale',2,'2023-07-02'),
(3,'Algoritmi',1,'2023-05-04'),
(4,'Chimica',3,'2023-06-02'),
(5,'Criminologia',3,'2022-03-08'),
(6,'Scienze Politiche',6,'2023-04-02'),
(7,'Recitazione',4,'2023-06-01'),
(8,'Statistica',2,'2021-03-03'),
(9,'Poesia',5,'2022-06-09');

insert into esame values(1,2,2,'ABCD',21,5),
(2,2,2,'ABCE',18,5),
(3,4,3,'DCJA',27,3),
(4,4,3,'FDNS',30,3),
(5,6,6,'FUEN',19,2),
(6,3,1,'ZJHD',19,3),
(7,1,4,'ABCD',29,3),
(8,7,4,'JUVE',24,2);

insert into segue values(1,'ABCD',2),
(2,'ABCE',2),
(3,'ABCD',9),
(4,'JUVE',7),
(5,'JUVE',5),
(6,'ZJHD',4),
(7,'FUEN',6),
(8,'KAFT',4),
(9,'DCJA',3),
(10,'FDNS',3),
(11,'ABCD',3),
(12,'EGDB',2),
(13,'KAFV',3),
(14,'KANF',4),
(15,'PDNN',6),
(16,'RPDM',6),
(17,'YEJS',8);

insert into rfid(CFStudente) values
('ABCD'),
('ABCE'),
('ZJHD'),
('KAFT'),
('KAFV'),
('YEJS'),
('PDNN'),
('KANF'),
('EGDB'),
('GOAT'),
('JUVE'),
('FUEN'),
('RPDM'),
('DCJA');

####################################
#        Interrogazioni            #
####################################

-- 1)Dati degli studenti che hanno fatto l'esame di Algoritmi
select studente.* from studente  join esame on studente.CF=esame.CFStudente where 
esame.IDCorso = (select idcorso from corso where nomeC='Algoritmi');

-- 2)Studenti che hanno preso un voto maggiore della media ad analisi III
select esame.CFStudente from esame where
 voto>(select avg(voto) from esame)and IDCorso=(select idcorso from corso where nomeC='Analisi III');

-- 3)Corsi tenuti dal professor White
select corso.* from corso where IDdocente=(select IDDocente from docente where cognome= 'White');

-- 4)Esami che si sono tenuti a sesto fiorentino
select esame.* from esame where esame.Sede=(select IDSede from sede where nome='Sesto Fiorentino');

-- 5)Dati degli studenti che hanno il nome che inizia per c
select * from studente where nome like 'C%';

-- 6)Dati degli studenti che utilizzano gmail
select * from studente where email like'%gmail.com';
 
-- 7)I corsi che sono iniziati nel 2022
select * from corso where DataI between '2022-01-01' AND '2022-12-31';

-- 8)I dati degli studenti e il voto preso a  un'esame con il professor Stinson
select studente.*, esame.voto from studente inner join esame where 
studente.CF=esame.CFStudente and esame.IDDocente=(select IDDocente from docente where cognome='Stinson');

-- 9)La media dei voti per ogni esame 
 select esame.IDcorso, corso.nomeC, avg(esame.voto)AS media from esame join corso on 
 esame.IDcorso=corso.IDCorso group  by esame.IDCorso;

-- 10)Le sedi dove si è tenuto almeno un'esame
select sede.* from sede where sede.IDsede in(select esame.sede from esame);

-- 11)I professori che hanno fatto almeno un'esame a Novoli
select docente.* from docente where 
docente.IDDocente in(select esame.IDDocente from esame join sede on esame.sede=sede.IDsede where sede.nome='Novoli');

####################################
#             visite               #
####################################

-- 1) studenti che hanno passato l'esame di algoritmi
drop view if exists algoritmi;
create view  algoritmi as
select studente.* from studente inner join esame 
where studente.cf=esame.CFStudente and voto>=18 and esame.IDCorso=(select idcorso from corso where nomeC='Algoritmi');

select * from algoritmi;

-- 2) studenti che hanno preoso almeno a un'esame 30 e il corso dove l'hanno preso
DROP VIEW IF EXISTS trenta;
CREATE VIEW trenta as select studente.*, corso.NomeC from studente  inner join esame inner join corso  
where studente.CF=esame.CFStudente and esame.IDCorso=corso.IDCorso and esame.voto>=30;

select * from trenta;

####################################
#           Procedure              #
####################################
-- 1)  Procedura per cercare i corsi tenuti da un determinato professore 
drop procedure if exists cercaDocente;

DELIMITER $$
CREATE PROCEDURE cercaDocente(cognomeDocente CHAR(30))
BEGIN select corso.* from corso where corso.IDDocente=(select IDDocente from docente where cognome=cognomeDocente);
END $$
DELIMITER ;

call cercaDocente('White');
call cercaDocente('Marras');

-- 2) procedura per trovare studenti che hanno preso un determinato voto in un determinato esame
drop procedure if exists cercaStudenti;
DELIMITER $$
CREATE PROCEDURE cercaStudenti(votoC int, materia CHAR(30))
BEGIN select studente.* from studente inner join esame 
where studente.cf=esame.cfstudente and voto=votoC and
idcorso=(select idcorso from corso where nomeC=materia);
END $$
DELIMITER ;

call cercaStudenti(30,'Chimica');

--  il numero di studenti che hanno preso un voto maggiore di un voto selezionato

drop procedure if exists contaVoto;
DELIMITER $$
CREATE PROCEDURE  contaVoto (v int)
BEGIN select  count(*)as numeroStudenti from esame where Voto>v;
END $$
DELIMITER ;

call contaVoto(20);

-- funzione che restituisce la media di tutti gli esami di un dato studente

DROP function IF EXISTS mediaDtudente;
DELIMITER $$
create function mediaStudente(codice CHAR(20))
RETURNS int
DETERMINISTIC
BEGIN
DECLARE m INT DEFAULT 0; 
select avg(voto) into m from esame join studente on esame.CFStudente=studente.CF where studente.CF=codice;
return m;
END $$
DELIMITER ;

SELECT mediaStudente('ABCD');
SELECT mediaStudente('JUVE');
####################################
#           Trigger                #
####################################

-- questo trigger appena un nuovo studente si iscrive eroga subito la tessera RFID

DROP trigger IF EXISTS nuovaIscrizione;
DELIMITER $$
CREATE TRIGGER nuovaIscrizione
AFTER INSERT ON Studente
FOR EACH ROW
BEGIN
insert INTO rfid (CFStudente) values (new.CF);
END$$
DELIMITER ;

-- Test del trigger

select * from studente;
select * from rfid;
-- insert into studente values ('DCZZ','Luigi','Cadorna ','3133','luigi@esercito.it');
select * from studente;
select * from rfid;

/* Il seguente trigger fa in modo che quando uno studente si cancella dall'ente di studi vengono cancellate anche 
le iscrizioni ai corsi, i risultati degli esami e la tessera RFID
*/

DROP trigger IF EXISTS smettiDiSeguire;
DELIMITER $$
CREATE TRIGGER smettiDiSeguire
BEFORE DELETE ON studente
FOR EACH ROW
BEGIN
DELETE FROM RFID where CFStudente=OLD.CF;
DELETE FROM segue where CFStudente=OLD.CF;
DELETE FROM esame where CFStudente=OLD.CF;


END $$
DELIMITER ;

-- Test sul trigger, l'operazione di delete è commentata per evitare che eseguendo tutto il codice all'inizio si  
-- cancelli senza prima verificarne l'esistenza 

SELECT * FROM studente;
SELECT * FROM esame;
SELECT * FROM segue;
--  delete  from studente where CF='FUEN';
 SELECT * FROM studente;
SELECT * FROM esame;
SELECT * FROM segue;