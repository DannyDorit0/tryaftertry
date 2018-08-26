/* Probeabschlussprüfung 2017 Lösung */
/* Aufgabe 1 */
DROP TABLE ordner CASCADE CONSTRAINTS;
DROP TABLE getagt_als CASCADE CONSTRAINTS;
DROP TABLE benutzer CASCADE CONSTRAINTS;
DROP TABLE datei CASCADE CONSTRAINTS;
DROP TABLE dateitag CASCADE CONSTRAINTS;

/* Aufgabe 1.a) Tabellen erstellen */
CREATE TABLE benutzer (
  bid NUMBER(10) PRIMARY KEY,
  name VARCHAR2(100 CHAR),
  passwort VARCHAR2(100 CHAR)
);

CREATE TABLE ordner (
  oid NUMBER(10) PRIMARY KEY,
  name VARCHAR2(100 CHAR),
  unterordnerVon NUMBER(10) 
); 

CREATE TABLE datei (
  did NUMBER(10) PRIMARY KEY,
  name VARCHAR2(100 CHAR),
  type VARCHAR2(100 CHAR),
  erstelldatum DATE,
  bid NUMBER(10) REFERENCES benutzer(bid),
  oid NUMBER(10) REFERENCES ordner(oid)
);

CREATE TABLE dateiTag (
  dtid NUMBER(10) PRIMARY KEY,
  name VARCHAR2(100 CHAR)
);

CREATE TABLE getagt_als (
  did NUMBER(10) REFERENCES datei (did),
  dtid NUMBER(10) REFERENCES dateiTag (dtid),
  PRIMARY KEY (did, dtid)
);

/* Aufgabe 1.b) Constraints anlegen */
ALTER TABLE ordner ADD CONSTRAINT unterOrdnerVonConstraint FOREIGN KEY (unterOrdnerVon) REFERENCES ordner(oid);
ALTER TABLE dateiTag ADD CONSTRAINT dateiTagNameUniqueConstraint UNIQUE (name);
ALTER TABLE dateiTag ADD istProjectTag Number(1) CHECK (istProjectTag IN (0,1)); 
ALTER TABLE datei ADD CONSTRAINT dateiDatumNotNullConstraint CHECK (erstelldatum IS NOT NULL);

/* Aufgabe 2.a) Sequenz erstellen */
DROP SEQUENCE seq_dtid;
CREATE SEQUENCE seq_dtid START WITH 5000 INCREMENT BY 7 NOMAXVALUE;

/* Aufgabe 2.b) Tabellen befüllen */
/* Befuelle Tabelle benutzer */
INSERT INTO benutzer (bid, name, passwort) VALUES(0, 'DonJolle', 'amicu2');
INSERT INTO benutzer (bid, name, passwort) VALUES(1, 'StefanFEAR', 'jUKi7V487');
INSERT INTO benutzer (bid, name, passwort) VALUES(2, 'Andy', '1q2w§E$R');
INSERT INTO benutzer (bid, name, passwort) VALUES(3, 'BigShape', '1234');

/* Befuelle Tabelle ordner */
INSERT INTO ordner (oid, name, unterOrdnerVon) VALUES(0, 'assets',NULL);
INSERT INTO ordner (oid, name, unterOrdnerVon) VALUES(1, 'meshes', 0);
INSERT INTO ordner (oid, name, unterOrdnerVon) VALUES(2, 'audio', 0);
INSERT INTO ordner (oid, name, unterOrdnerVon) VALUES(3, 'sfx', 2);
INSERT INTO ordner (oid, name, unterOrdnerVon) VALUES(4, 'voice', 2);
INSERT INTO ordner (oid, name, unterOrdnerVon) VALUES(5, 'images', 0);
INSERT INTO ordner (oid, name, unterOrdnerVon) VALUES(6, 'GUI', 5);
INSERT INTO ordner (oid, name, unterOrdnerVon) VALUES(7, 'texture', 5);

/* Befuelle Tabelle datei */
INSERT INTO datei (did, name, type, erstelldatum, bid, oid) 
            VALUES(0, 'kleinerJunge', 'fbx', '01.07.2017', 3, 1); 
INSERT INTO datei (did, name, type, erstelldatum, bid, oid) 
            VALUES(1, 'kleinerBengel', 'png', '02.07.2017', 3, 7);  
INSERT INTO datei (did, name, type, erstelldatum, bid, oid) 
            VALUES(2, 'ball', 'png', '03.07.2017', 3, 7); 
INSERT INTO datei (did, name, type, erstelldatum, bid, oid) 
            VALUES(3, 'overlay', 'png', '20.06.2017', 0, 6);
INSERT INTO datei (did, name, type, erstelldatum, bid, oid) 
            VALUES(4, 'button9slice', 'png', '25.06.2017', 0, 6);
INSERT INTO datei (did, name, type, erstelldatum, bid, oid) 
            VALUES(5, 'background', 'jpg', '03.07.2017', 3, 6);  
INSERT INTO datei (did, name, type, erstelldatum, bid, oid) 
            VALUES(6, 'music', 'midi', '04.07.2017', 2, 3); 
INSERT INTO datei (did, name, type, erstelldatum, bid, oid) 
            VALUES(7, 'yes', 'mp3', '02.07.2017', 2, 4); 
INSERT INTO datei (did, name, type, erstelldatum, bid, oid) 
            VALUES(8, 'no', 'mp3', '01.07.2017', 2, 4); 
INSERT INTO datei (did, name, type, erstelldatum, bid, oid) 
            VALUES(9, 'explosion', 'mp3', '30.06.2017', 1, 4); 
INSERT INTO datei (did, name, type, erstelldatum, bid, oid) 
            VALUES(10, 'wow', 'mp3', '06.07.2017', 1, 4); 



/* Befuelle Tabelle dateiTag 
INSERT INTO dateitag (dtid, name, istProjectTag) VALUES(0, 'musik', 0);
INSERT INTO dateitag (dtid, name, istProjectTag) VALUES(1, 'ballspiel', 1);
INSERT INTO dateitag (dtid, name, istProjectTag) VALUES(2, '2D', 0);
INSERT INTO dateitag (dtid, name, istProjectTag) VALUES(4, '3D', 0);
INSERT INTO dateitag (dtid, name, istProjectTag) VALUES(5, 'EndlessJump', 1);
INSERT INTO dateitag (dtid, name, istProjectTag) VALUES(6, 'BadGame', 1);

 Befuelle Tabelle getagt_als
INSERT INTO getagt_als (did, dtid) VALUES(0, 4);
INSERT INTO getagt_als (did, dtid) VALUES(1, 2);
INSERT INTO getagt_als (did, dtid) VALUES(2, 4);
INSERT INTO getagt_als (did, dtid) VALUES(3, 2);
INSERT INTO getagt_als (did, dtid) VALUES(4, 2);
INSERT INTO getagt_als (did, dtid) VALUES(5, 2);
INSERT INTO getagt_als (did, dtid) VALUES(6, 0);
INSERT INTO getagt_als (did, dtid) VALUES(7, 0);
INSERT INTO getagt_als (did, dtid) VALUES(8, 0);
INSERT INTO getagt_als (did, dtid) VALUES(9, 0);
INSERT INTO getagt_als (did, dtid) VALUES(10, 0);
INSERT INTO getagt_als (did, dtid) VALUES(0, 1);
INSERT INTO getagt_als (did, dtid) VALUES(1, 1);
INSERT INTO getagt_als (did, dtid) VALUES(2, 1);
INSERT INTO getagt_als (did, dtid) VALUES(3, 5);
INSERT INTO getagt_als (did, dtid) VALUES(4, 5);
INSERT INTO getagt_als (did, dtid) VALUES(5, 1);
INSERT INTO getagt_als (did, dtid) VALUES(6, 5);
INSERT INTO getagt_als (did, dtid) VALUES(7, 1);
INSERT INTO getagt_als (did, dtid) VALUES(8, 1);
INSERT INTO getagt_als (did, dtid) VALUES(9, 1);
INSERT INTO getagt_als (did, dtid) VALUES(9, 5);
INSERT INTO getagt_als (did, dtid) VALUES(9, 6);
INSERT INTO getagt_als (did, dtid) VALUES(10, 1);
*/

/* Befuelle Tabelle dateiTag / Befuelle Tabelle getagt_als */
INSERT INTO dateitag (dtid, name, istProjectTag) VALUES(seq_dtid.NEXTVAL, 'musik', 0);
INSERT INTO getagt_als (did, dtid) VALUES(6, seq_dtid.CURRVAL);
INSERT INTO getagt_als (did, dtid) VALUES(7, seq_dtid.CURRVAL);
INSERT INTO getagt_als (did, dtid) VALUES(8, seq_dtid.CURRVAL);
INSERT INTO getagt_als (did, dtid) VALUES(9, seq_dtid.CURRVAL);
INSERT INTO getagt_als (did, dtid) VALUES(10, seq_dtid.CURRVAL);
INSERT INTO dateitag (dtid, name, istProjectTag) VALUES(seq_dtid.NEXTVAL, 'ballspiel', 1);
INSERT INTO getagt_als (did, dtid) VALUES(0, seq_dtid.CURRVAL);
INSERT INTO getagt_als (did, dtid) VALUES(1, seq_dtid.CURRVAL);
INSERT INTO getagt_als (did, dtid) VALUES(2, seq_dtid.CURRVAL);
INSERT INTO getagt_als (did, dtid) VALUES(5, seq_dtid.CURRVAL);
INSERT INTO getagt_als (did, dtid) VALUES(7, seq_dtid.CURRVAL);
INSERT INTO getagt_als (did, dtid) VALUES(8, seq_dtid.CURRVAL);
INSERT INTO getagt_als (did, dtid) VALUES(9, seq_dtid.CURRVAL);
INSERT INTO getagt_als (did, dtid) VALUES(10, seq_dtid.CURRVAL);
INSERT INTO dateitag (dtid, name, istProjectTag) VALUES(seq_dtid.NEXTVAL, '2D', 0);
INSERT INTO getagt_als (did, dtid) VALUES(1, seq_dtid.CURRVAL); 
INSERT INTO getagt_als (did, dtid) VALUES(3, seq_dtid.CURRVAL);
INSERT INTO getagt_als (did, dtid) VALUES(4, seq_dtid.CURRVAL);
INSERT INTO getagt_als (did, dtid) VALUES(5, seq_dtid.CURRVAL);
INSERT INTO dateitag (dtid, name, istProjectTag) VALUES(seq_dtid.NEXTVAL, '3D', 0);
INSERT INTO getagt_als (did, dtid) VALUES(0, seq_dtid.CURRVAL); 
INSERT INTO getagt_als (did, dtid) VALUES(2, seq_dtid.CURRVAL);
INSERT INTO dateitag (dtid, name, istProjectTag) VALUES(seq_dtid.NEXTVAL, 'endlessjump', 1);
INSERT INTO getagt_als (did, dtid) VALUES(3, seq_dtid.CURRVAL);
INSERT INTO getagt_als (did, dtid) VALUES(4, seq_dtid.CURRVAL);
INSERT INTO getagt_als (did, dtid) VALUES(6, seq_dtid.CURRVAL);
INSERT INTO getagt_als (did, dtid) VALUES(9, seq_dtid.CURRVAL);
INSERT INTO dateitag (dtid, name, istProjectTag) VALUES(seq_dtid.NEXTVAL, 'badgame', 1);
INSERT INTO getagt_als (did, dtid) VALUES(9, seq_dtid.CURRVAL);


/* Aufgabe 2.c) Ändern */
UPDATE datei SET name = 'kleinerJunge' WHERE ERSTELLDATUM = '02.07.2017' AND TYPE = 'png';


/* Aufgabe 2.d) Löschen */
DELETE FROM getagt_als WHERE dtid IN (SELECT dtid FROM dateitag WHERE name LIKE 'badgame');
DELETE FROM dateitag WHERE name LIKE 'badgame';


/* Aufgabe 3 Transaction Control Language */
SET TRANSACTION READ WRITE;
SAVEPOINT tabellen_erzeugt;
SAVEPOINT tabellen_geaendert;
SAVEPOINT constraints_erzeugt;
COMMIT;
ROLLBACK TO tabellen_erzeugt;

/* Aufgabe 4 Abfragen */
/* Aufgabe 4.a) Abfrage */
SELECT type, count(*) as AnzahlDateien
FROM datei
JOIN getagt_als USING (did)
JOIN dateitag USING (dtid)
WHERE dateitag.ISTPROJECTTAG = 1
GROUP BY TYPE
ORDER BY 2 DESC;
/
/* Aufgabe 4.b) Prozedur */
/*Wie viele Dateien der Mitarbeiter pro Monat angelegt hat. 
Je Datei soll ein Stern ausgegeben werden */
SET SERVEROUTPUT ON
CREATE OR REPLACE PROCEDURE dateienProMonat (benutzerid NUMBER)
IS 
  benutzername benutzer.name%TYPE;
  
  FUNCTION wiederhole (buchstabe VARCHAR2, anzahl NUMBER)
  RETURN VARCHAR2
  IS
    ausgabe VARCHAR2(100);
  BEGIN
    FOR i IN 1..anzahl
    LOOP
      ausgabe := ausgabe || buchstabe;
    END LOOP;
    return ausgabe;
  END;
BEGIN
  SELECT benutzer.name
  INTO benutzername
  FROM benutzer
  WHERE bid = benutzerid;

  FOR datensatz IN (
    SELECT type, count(*) as anzahl
    FROM benutzer
    JOIN datei USING(bid)
    WHERE bid = benutzerid
    GROUP BY type
  )
  LOOP
    DBMS_OUTPUT.PUT_LINE(benutzername || ' ' || wiederhole (SUBSTR(datensatz.type, 0,1),datensatz.anzahl)); 
  END LOOP;
END;
/

EXECUTE dateienProMonat(0);
EXECUTE dateienProMonat(3);

/* Aufgabe 4.c) Trigger */
drop trigger pruefeOrdnerzuordnung;
SET SERVEROUTPUT ON
CREATE OR REPLACE TRIGGER pruefeOrdnerzuordnung
AFTER INSERT OR UPDATE ON ordner 
DECLARE
-- keine Variablen benoetigt
BEGIN
  FOR datensatz IN (
    SELECT * 
    FROM ordner
  )
  LOOP
    DBMS_OUTPUT.PUT_LINE(datensatz.oid || ' ' || datensatz.name || ' ' || datensatz.unterOrdnerVon);
    IF datensatz.oid = datensatz.unterOrdnerVon THEN
      RAISE_APPLICATION_ERROR (-20001,'Ordner mit oid ' || datensatz.unterOrdnerVon ||' darf nicht Unterordner von sich selbst sein.');
    END IF;
  END LOOP;
END;


-- Test
BEGIN
  UPDATE ordner SET unterOrdnerVon = 0 WHERE unterOrdnerVon = 0;
  UPDATE ordner SET unterOrdnerVon = oid WHERE unterOrdnerVon = 0;
END;
/


SELECT * FROM ordner;
SELECT * FROM getagt_als;
SELECT * FROM benutzer;
SELECT * FROM dateitag;
SELECT * FROM datei;