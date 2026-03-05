-- =========================================================
-- Trigger demo / manual tests (Oracle)
-- File: trigger_demo.sql
-- =========================================================
SET SERVEROUTPUT ON;

-- Run order suggestion:
--   1) sql/01_schema.sql
--   2) sql/02_seed.sql
--   3) sql/04_triggers.sql
--   4) (optional) this file
--
-- PIERWSZY BEFORE:

-- TESTY DO BEFORA PIERWSZEGO :
-- Próba wstawienia umowy z niepoprawną datą wygaśnięcia

INSERT INTO Umowa (ID, Numer_umowy, Data_zawarcia, Data_wygasniecia, Transakcja_ID)
VALUES (101, 987654, TO_DATE('2023-06-01', 'YYYY-MM-DD'), TO_DATE('2023-05-30', 'YYYY-MM-DD'), 1);


-- Wstawienie umowy z numerem, który już istnieje
INSERT INTO Umowa (ID, Numer_umowy, Data_zawarcia, Data_wygasniecia, Transakcja_ID)
VALUES (5, 123456, TO_DATE('2023-06-01', 'YYYY-MM-DD'), NULL, 2);


-- DRUGI BEFORE
-- DROP TRIGGER SPRAWDZ_TRANSAKCJE;  -- (left here as a reference, but disabled)
-- TESTY DO BEFORA DRUGIEGO:
-- Dodanie nowej transakcji
INSERT INTO Transakcja (ID, Data, Cena, Nieruchomosc_ID, Klient_ID)
VALUES (5, TO_DATE('2023-06-05', 'YYYY-MM-DD'), 400000, 4, 4);

SELECT * FROM TRANSAKCJA;
SELECT * FROM UMOWA;


DELETE FROM TRANSAKCJA WHERE ID=5;

-- Sprawdzenie, czy umowa została utworzona
SELECT *
FROM Umowa
WHERE Transakcja_ID = 5;


-- ======================================================================================================

-- PIERWSZY AFTER:
select *
from AGENT;
Select *
from NIERUCHOMOSC;

INSERT INTO AGENT
VALUES (99, 'KAROL', 'PACIOREK', 999999000, 'K.PACIOREK@EXAMPLE.COM');

DELETE
FROM AGENT
WHERE ID = 99;

UPDATE NIERUCHOMOSC
SET AGENT_ID=1
WHERE ID = 1;

SELECT * FROM NIERUCHOMOSC;

-- Usunięcie umowy (spowoduje przeniesienie do ARCHIWUM_UMOW i wyświetli komunikat)
DELETE
FROM Umowa
WHERE ID = 1;

-- Aktualizacja daty wygaśnięcia na wcześniejszą (spowoduje przeniesienie do ARCHIWUM_UMOW i wyświetli komunikat)
UPDATE Umowa
SET Data_wygasniecia = TO_DATE('2023-06-01', 'YYYY-MM-DD')
WHERE ID = 2;

SELECT *
FROM ARCHIWUM_UMOW;
SELECT *
FROM UMOWA
