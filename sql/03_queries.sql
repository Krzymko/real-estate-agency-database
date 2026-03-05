-- =========================================================
-- Real Estate Agency Database (Oracle)
-- File: 03_queries.sql
-- Purpose: Example/reporting queries (SELECTs)
-- =========================================================

-- Lista nieruchomości z ich typem i agentem:
SELECT Nieruchomosc.Nazwa AS Nieruchomosc, Typ_nieruchom.Nazwa AS Typ, Agent.Imie || ' ' || Agent.Nazwisko AS Agent
FROM Nieruchomosc
         JOIN Jaki_typ ON Nieruchomosc.ID = Jaki_typ.Nieruchomosc_ID
         JOIN Typ_nieruchom ON Jaki_typ.Typ_nieruchom_ID = Typ_nieruchom.ID
         JOIN Agent ON Nieruchomosc.Agent_ID = Agent.ID;



-- Lista oglądań z informacjami o nieruchomości i kliencie:
SELECT Ogladanie.Termin,
       Nieruchomosc.Nazwa                    AS Nieruchomosc,
       Klient.Imie || ' ' || Klient.Nazwisko AS Klient,
       Klient.TELEFON
FROM Ogladanie
         JOIN Nieruchomosc ON Ogladanie.Nieruchomosc_ID = Nieruchomosc.ID
         JOIN Klient ON Ogladanie.Klient_ID = Klient.ID;



--Średnia cena nieruchomości dla każdego typu:
SELECT Typ_nieruchom.Nazwa AS Typ, AVG(Nieruchomosc.Cena) AS Srednia_Cena
FROM Nieruchomosc
         JOIN Jaki_typ ON Nieruchomosc.ID = Jaki_typ.Nieruchomosc_ID
         JOIN Typ_nieruchom ON Jaki_typ.Typ_nieruchom_ID = Typ_nieruchom.ID
GROUP BY Typ_nieruchom.Nazwa;



--Liczba oglądań dla każdej nieruchomości mającej więcej niż jedno oglądanie:
SELECT Nieruchomosc.Nazwa AS Nieruchomosc, COUNT(Ogladanie.ID) AS Liczba_Ogladan
FROM Ogladanie
         JOIN Nieruchomosc ON Ogladanie.Nieruchomosc_ID = Nieruchomosc.ID
GROUP BY Nieruchomosc.Nazwa
HAVING COUNT(Ogladanie.ID) > 1;



--Lista nieruchomości o cenie wyższej niż średnia cena wszystkich nieruchomości:
SELECT Nazwa, Cena
FROM Nieruchomosc
WHERE Cena > (SELECT AVG(Cena) FROM Nieruchomosc);



--Lista agentów, którzy mają co najmniej jedną nieruchomość w bazie:
SELECT Imie, Nazwisko
FROM Agent
WHERE ID IN (SELECT Agent_ID FROM Nieruchomosc);



--Lista nieruchomości wraz z liczbą oglądań dla każdej nieruchomości:
SELECT N1.Nazwa,
       (SELECT COUNT(*)
        FROM Ogladanie O
        WHERE O.Nieruchomosc_ID = N1.ID) AS Liczba_Ogladan
FROM Nieruchomosc N1;
