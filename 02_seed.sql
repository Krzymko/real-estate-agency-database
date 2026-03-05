-- =========================================================
-- Real Estate Agency Database (Oracle)
-- File: 02_seed.sql
-- Purpose: Insert sample data for demo/testing
-- =========================================================

INSERT INTO Typ_nieruchom (ID, Nazwa, Opis)
VALUES (1, 'Dom', 'Nieruchomosc jednorodzinna');
INSERT INTO Typ_nieruchom (ID, Nazwa, Opis)
VALUES (2, 'Mieszkanie', 'Nieruchomosc w bloku');
INSERT INTO Typ_nieruchom (ID, Nazwa, Opis)
VALUES (3, 'Apartament', 'Luksusowy apartament');
INSERT INTO Typ_nieruchom (ID, Nazwa, Opis)
VALUES (4, 'Kawalerka', 'Male mieszkanie jednopokojowe');

--Tabela Adres
INSERT INTO Adres (ID, Ulica, Numer_ulicy, Numer_mieszkania, Kod_pocztowy)
VALUES (1, 'Lipowa', 15, 2, 54321);
INSERT INTO Adres (ID, Ulica, Numer_ulicy, Numer_mieszkania, Kod_pocztowy)
VALUES (2, 'Dluga', 27, 12, 98765);
INSERT INTO Adres (ID, Ulica, Numer_ulicy, Numer_mieszkania, Kod_pocztowy)
VALUES (3, 'Krotka', 9, 3, 12345);
INSERT INTO Adres (ID, Ulica, Numer_ulicy, Numer_mieszkania, Kod_pocztowy)
VALUES (4, 'Szeroka', 1, 1, 11111);

--Tabela Agent
INSERT INTO Agent (ID, Imie, Nazwisko, telefon, mail)
VALUES (1, 'Jan', 'Kowalski', 123456789, 'jan.kowalski@example.com');
INSERT INTO Agent (ID, Imie, Nazwisko, telefon, mail)
VALUES (2, 'Anna', 'Nowak', 987654321, 'anna.nowak@example.com');
INSERT INTO Agent (ID, Imie, Nazwisko, telefon, mail)
VALUES (3, 'Piotr', 'Wozniak', 555444333, 'piotr.wozniak@example.com');
INSERT INTO Agent (ID, Imie, Nazwisko, telefon, mail)
VALUES (4, 'Ewa', 'Lewandowska', 222333444, 'ewa.lewandowska@example.com');

--Tabela Klient
INSERT INTO Klient (ID, Imie, Nazwisko, telefon, mail)
VALUES (1, 'Katarzyna', 'Zielinska', 111222333, 'k.zielinska@example.com');
INSERT INTO Klient (ID, Imie, Nazwisko, telefon, mail)
VALUES (2, 'Tomasz', 'Malinowski', 444555666, 't.malinowski@example.com');
INSERT INTO Klient (ID, Imie, Nazwisko, telefon, mail)
VALUES (3, 'Robert', 'Wisniewski', 777888999, 'r.wisniewski@example.com');
INSERT INTO Klient (ID, Imie, Nazwisko, telefon, mail)
VALUES (4, 'Magdalena', 'Sikorska', 101010101, 'm.sikorska@example.com');

--Tabela Nieruchomosc
INSERT INTO Nieruchomosc (ID, Nazwa, Cena, Powierzchnia, Adres_ID, Agent_ID)
VALUES (1, 'Dom w Lipowej', 500000, 120, 1, 1);
INSERT INTO Nieruchomosc (ID, Nazwa, Cena, Powierzchnia, Adres_ID, Agent_ID)
VALUES (2, 'Mieszkanie na Dluga', 300000, 80, 2, 2);
INSERT INTO Nieruchomosc (ID, Nazwa, Cena, Powierzchnia, Adres_ID, Agent_ID)
VALUES (3, 'Apartament w Krotkiej', 750000, 150, 3, 3);
INSERT INTO Nieruchomosc (ID, Nazwa, Cena, Powierzchnia, Adres_ID, Agent_ID)
VALUES (4, 'Kawalerka na Szerokiej', 200000, 40, 4, 4);

--Tabela Jaki_typ
INSERT INTO Jaki_typ (Typ_nieruchom_ID, Nieruchomosc_ID)
VALUES (1, 1);
INSERT INTO Jaki_typ (Typ_nieruchom_ID, Nieruchomosc_ID)
VALUES (2, 2);
INSERT INTO Jaki_typ (Typ_nieruchom_ID, Nieruchomosc_ID)
VALUES (3, 3);
INSERT INTO Jaki_typ (Typ_nieruchom_ID, Nieruchomosc_ID)
VALUES (4, 4);

--Tabela Ogladanie
INSERT INTO Ogladanie (ID, Termin, Nieruchomosc_ID, Klient_ID)
VALUES (1, TO_TIMESTAMP('2023-05-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 1);
INSERT INTO Ogladanie (ID, Termin, Nieruchomosc_ID, Klient_ID)
VALUES (2, TO_TIMESTAMP('2023-05-02 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2, 2);
INSERT INTO Ogladanie (ID, Termin, Nieruchomosc_ID, Klient_ID)
VALUES (3, TO_TIMESTAMP('2023-05-03 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 3, 3);
INSERT INTO Ogladanie (ID, Termin, Nieruchomosc_ID, Klient_ID)
VALUES (4, TO_TIMESTAMP('2023-05-04 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 4, 4);
INSERT INTO Ogladanie (ID, Termin, Nieruchomosc_ID, Klient_ID)
VALUES (5, TO_TIMESTAMP('2023-05-04 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 4, 2);

--Tabela Transakcja
INSERT INTO Transakcja (ID, Data, Cena, Nieruchomosc_ID, Klient_ID)
VALUES (1, TO_DATE('2023-06-01', 'YYYY-MM-DD'), 500000, 1, 1);
INSERT INTO Transakcja (ID, Data, Cena, Nieruchomosc_ID, Klient_ID)
VALUES (2, TO_DATE('2023-06-02', 'YYYY-MM-DD'), 300000, 2, 2);
INSERT INTO Transakcja (ID, Data, Cena, Nieruchomosc_ID, Klient_ID)
VALUES (3, TO_DATE('2023-06-03', 'YYYY-MM-DD'), 750000, 3, 3);
INSERT INTO Transakcja (ID, Data, Cena, Nieruchomosc_ID, Klient_ID)
VALUES (4, TO_DATE('2023-06-04', 'YYYY-MM-DD'), 200000, 4, 4);

--Tabela Umowa
INSERT INTO Umowa (ID, Numer_umowy, Data_zawarcia, Data_wygasniecia, Transakcja_ID)
VALUES (1, 123456, TO_DATE('2023-06-01', 'YYYY-MM-DD'), TO_DATE('2023-09-11', 'YYYY-MM-DD'), 1);
INSERT INTO Umowa (ID, Numer_umowy, Data_zawarcia, Data_wygasniecia, Transakcja_ID)
VALUES (2, 654321, TO_DATE('2023-06-02', 'YYYY-MM-DD'), NULL, 2);
INSERT INTO Umowa (ID, Numer_umowy, Data_zawarcia, Data_wygasniecia, Transakcja_ID)
VALUES (3, 789123, TO_DATE('2023-06-03', 'YYYY-MM-DD'), TO_DATE('2023-10-14', 'YYYY-MM-DD'), 3);
INSERT INTO Umowa (ID, Numer_umowy, Data_zawarcia, Data_wygasniecia, Transakcja_ID)
VALUES (4, 321987, TO_DATE('2023-06-04', 'YYYY-MM-DD'), NULL, 4);

