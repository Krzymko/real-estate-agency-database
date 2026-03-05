-- =========================================================
-- Real Estate Agency Database (Oracle / PL/SQL)
-- File: 04_triggers.sql
-- Purpose: Triggers used in the project
--
-- Notes:
--   - Some triggers use DBMS_OUTPUT; enable it in your SQL client if you want to see messages.
--   - Tests/demos were moved to: examples/trigger_demo.sql
-- =========================================================

CREATE OR REPLACE TRIGGER sprawdz_daty_umowy
    BEFORE INSERT
    ON Umowa
    FOR EACH ROW
DECLARE
    dlugosc_umowy_dni INTEGER;
BEGIN

    -- Sprawdzenie daty wygaśnięcia umowy
    IF :NEW.Data_wygasniecia IS NOT NULL AND :NEW.Data_wygasniecia <= :NEW.Data_zawarcia THEN
        RAISE_APPLICATION_ERROR(-20001, 'Data wygaśnięcia umowy nie może być wcześniejsza lub równa dacie zawarcia.');
    END IF;

    -- Sprawdzenie unikalności numeru umowy
    DECLARE
        ilosc_umow INTEGER;
    BEGIN
        SELECT COUNT(*)
        INTO ilosc_umow
        FROM Umowa
        WHERE Numer_umowy = :NEW.Numer_umowy;

        IF ilosc_umow > 0 THEN
            :NEW.Numer_umowy := :NEW.Numer_umowy + 1;
        END IF;
    END;

    -- Obliczenie długości trwania umowy w dniach
    dlugosc_umowy_dni := NVL(:NEW.Data_wygasniecia, SYSDATE) - :NEW.Data_zawarcia;


END;
/

CREATE OR REPLACE TRIGGER sprawdz_transakcje
AFTER DELETE OR UPDATE OR INSERT
ON Transakcja
FOR EACH ROW
DECLARE
    ilosc_umow INTEGER;
    nowe_id_umowy INTEGER;
BEGIN
    -- Sprawdzenie, czy istnieje powiązana umowa z tą transakcją w przypadku DELETE lub UPDATE
    IF DELETING OR UPDATING THEN
        SELECT COUNT(*)
        INTO ilosc_umow
        FROM Umowa
        WHERE Transakcja_ID = :OLD.ID;

        IF ilosc_umow > 0 THEN
            IF DELETING THEN
                RAISE_APPLICATION_ERROR(-20004, 'Nie można usunąć tej transakcji, ponieważ istnieje powiązana umowa.');
            ELSIF UPDATING THEN
                RAISE_APPLICATION_ERROR(-20005, 'Nie można zaktualizować tej transakcji, ponieważ istnieje powiązana umowa.');
            END IF;
        END IF;
    END IF;

    -- Automatyczne tworzenie umowy po dodaniu nowej transakcji
    IF INSERTING THEN
        -- Pobranie najwyższego ID umowy i dodanie 1
        SELECT NVL(MAX(ID), 0) + 1
        INTO nowe_id_umowy
        FROM Umowa;

        -- Tworzenie nowej umowy
        INSERT INTO Umowa (ID, Numer_umowy, Data_zawarcia, Data_wygasniecia, Transakcja_ID)
        VALUES (nowe_id_umowy, nowe_id_umowy, :NEW.Data, NULL, :NEW.ID);

        -- Wyświetlenie komunikatu o stworzeniu szkicu umowy
        dbms_output.put_line('Stworzono szkic umowy o ID: ' || nowe_id_umowy || ' i Transakcja_ID: ' || :NEW.ID);
    END IF;
END;
/

CREATE OR REPLACE TRIGGER przypisz_nieruchomosci
    AFTER INSERT
    ON Agent
    FOR EACH ROW
DECLARE
    v_updated_count NUMBER := 0;
    v_comment       VARCHAR2(200);
BEGIN
    -- Update nieruchomosci gdzie agent_id = 1 and cena < 700000
    UPDATE Nieruchomosc
    SET Agent_ID = :NEW.ID
    WHERE Agent_ID = 1
      AND Cena < 700000;

    -- Sprawdzenie ile nieruchomości zostało zaktualizowanych
    SELECT COUNT(*)
    INTO v_updated_count
    FROM Nieruchomosc
    WHERE Agent_ID = :NEW.ID
      AND Cena < 700000;

    -- Informacja o zmianie przypisania nieruchomości
    IF v_updated_count > 0 THEN
        v_comment := 'Nieruchomości przypisane do nowego agenta (ID=' || :NEW.ID ||
                     ') z powodu niskiej wartości (poniżej 700000).';
        dbms_output.put_line(v_comment);
    END IF;
END;
/

CREATE OR REPLACE TRIGGER archiwizacja_umow
    AFTER DELETE OR UPDATE OF Data_wygasniecia
    ON Umowa
    FOR EACH ROW
DECLARE
    v_current_date DATE := SYSDATE;
BEGIN
    -- Przeniesienie umowy do archiwum po wykonaniu operacji DELETE
    IF DELETING THEN
        INSERT INTO ARCHIWUM_UMOW (ID, Numer_umowy, Data_zawarcia, Data_wygasniecia, Transakcja_ID)
        VALUES (:OLD.ID, :OLD.Numer_umowy, :OLD.Data_zawarcia, :OLD.Data_wygasniecia, :OLD.Transakcja_ID);

        -- Komunikat o przeniesieniu umowy do archiwum
        dbms_output.put_line('Umowa o numerze ' || :OLD.Numer_umowy || ' została przeniesiona do archiwum.');
    END IF;

    -- Przeniesienie umowy do archiwum po wykonaniu operacji UPDATE
    IF UPDATING THEN
        IF :OLD.Data_wygasniecia < v_current_date THEN
            INSERT INTO ARCHIWUM_UMOW (ID, Numer_umowy, Data_zawarcia, Data_wygasniecia, Transakcja_ID)
            VALUES (:OLD.ID, :OLD.Numer_umowy, :OLD.Data_zawarcia, :OLD.Data_wygasniecia, :OLD.Transakcja_ID);

            -- Komunikat o przeniesieniu umowy do archiwum
            dbms_output.put_line('Umowa o numerze ' || :OLD.Numer_umowy || ' została przeniesiona do archiwum.');
        END IF;
    END IF;
END;
/
