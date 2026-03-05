-- =========================================================
-- Real Estate Agency Database (Oracle)
-- File: 01_schema.sql
-- Purpose: Create tables + foreign keys (DDL)
-- =========================================================

CREATE TABLE Adres (
    ID integer  NOT NULL,
    Ulica varchar2(30)  NOT NULL,
    Numer_ulicy integer  NOT NULL,
    Numer_mieszkania integer  NOT NULL,
    Kod_pocztowy integer  NOT NULL,
    CONSTRAINT Adres_pk PRIMARY KEY (ID)
) ;

CREATE TABLE Agent (
    ID integer  NOT NULL,
    Imie varchar2(20)  NOT NULL,
    Nazwisko varchar2(30)  NOT NULL,
    telefon integer  NOT NULL,
    mail varchar2(30)  NOT NULL,
    CONSTRAINT Agent_pk PRIMARY KEY (ID)
) ;

CREATE TABLE Jaki_typ (
    Typ_nieruchom_ID integer  NOT NULL,
    Nieruchomosc_ID integer  NOT NULL,
    CONSTRAINT Jaki_typ_pk PRIMARY KEY (Typ_nieruchom_ID,Nieruchomosc_ID)
) ;

CREATE TABLE Klient (
    ID integer  NOT NULL,
    Imie varchar2(20)  NOT NULL,
    Nazwisko varchar2(30)  NOT NULL,
    telefon integer  NOT NULL,
    mail varchar2(30)  NOT NULL,
    CONSTRAINT Klient_pk PRIMARY KEY (ID)
) ;

CREATE TABLE Nieruchomosc (
    ID integer  NOT NULL,
    Nazwa varchar2(30)  NOT NULL,
    Cena integer  NOT NULL,
    Powierzchnia integer  NOT NULL,
    Adres_ID integer  NOT NULL,
    Agent_ID integer  NOT NULL,
    CONSTRAINT Nieruchomosc_pk PRIMARY KEY (ID)
) ;

CREATE TABLE Ogladanie (
    ID integer  NOT NULL,
    Termin timestamp  NOT NULL,
    Nieruchomosc_ID integer  NOT NULL,
    Klient_ID integer  NOT NULL,
    CONSTRAINT Ogladanie_pk PRIMARY KEY (ID)
) ;

CREATE TABLE Transakcja (
    ID integer  NOT NULL,
    Data date  NOT NULL,
    Cena integer  NOT NULL,
    Nieruchomosc_ID integer  NOT NULL,
    Klient_ID integer  NOT NULL,
    CONSTRAINT Transakcja_pk PRIMARY KEY (ID)
) ;

CREATE TABLE Typ_nieruchom (
    ID integer  NOT NULL,
    Nazwa varchar2(20)  NOT NULL,
    Opis varchar2(50)  NOT NULL,
    CONSTRAINT Typ_nieruchom_pk PRIMARY KEY (ID)
) ;

CREATE TABLE Umowa (
    ID integer  NOT NULL,
    Numer_umowy integer  NOT NULL,
    Data_zawarcia date  NOT NULL,
    Data_wygasniecia date  NULL,
    Transakcja_ID integer  NOT NULL,
    CONSTRAINT Umowa_pk PRIMARY KEY (ID)
) ;

ALTER TABLE Jaki_typ ADD CONSTRAINT Jaki_typ_Nieruchomosc
    FOREIGN KEY (Nieruchomosc_ID)
    REFERENCES Nieruchomosc (ID);

ALTER TABLE Jaki_typ ADD CONSTRAINT Jaki_typ_Typ_nieruchom
    FOREIGN KEY (Typ_nieruchom_ID)
    REFERENCES Typ_nieruchom (ID);

ALTER TABLE Nieruchomosc ADD CONSTRAINT Nieruchomosc_Adres
    FOREIGN KEY (Adres_ID)
    REFERENCES Adres (ID);

ALTER TABLE Nieruchomosc ADD CONSTRAINT Nieruchomosc_Agent
    FOREIGN KEY (Agent_ID)
    REFERENCES Agent (ID);

ALTER TABLE Ogladanie ADD CONSTRAINT Ogladanie_Klient
    FOREIGN KEY (Klient_ID)
    REFERENCES Klient (ID);

ALTER TABLE Ogladanie ADD CONSTRAINT Ogladanie_Nieruchomosc
    FOREIGN KEY (Nieruchomosc_ID)
    REFERENCES Nieruchomosc (ID);

ALTER TABLE Transakcja ADD CONSTRAINT Transakcja_Klient
    FOREIGN KEY (Klient_ID)
    REFERENCES Klient (ID);

ALTER TABLE Transakcja ADD CONSTRAINT Transakcja_Nieruchomosc
    FOREIGN KEY (Nieruchomosc_ID)
    REFERENCES Nieruchomosc (ID);

ALTER TABLE Umowa ADD CONSTRAINT Umowa_Transakcja
    FOREIGN KEY (Transakcja_ID)
    REFERENCES Transakcja (ID);

--Tabela Typ_nieruchom

-- Archive table used by the audit trigger
CREATE TABLE ARCHIWUM_UMOW
(
    ID               INTEGER,
    Numer_umowy      INTEGER,
    Data_zawarcia    DATE,
    Data_wygasniecia DATE,
    Transakcja_ID    INTEGER,
    CONSTRAINT ARCHIWUM_UMOW_pk PRIMARY KEY (ID)
);


