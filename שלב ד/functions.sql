CREATE OR REPLACE FUNCTION func_get_elderly_residents()
RETURNS refcursor AS $$
DECLARE
    cur refcursor := 'elderly_cur';  -- שם לקורזור
BEGIN
    OPEN cur FOR
        SELECT residentid, name, birthdate
        FROM resident
        WHERE EXTRACT(YEAR FROM AGE(CURRENT_DATE, birthdate)) >= 80;

    RETURN cur;
END;
$$ LANGUAGE plpgsql;

BEGIN;
SELECT func_get_elderly_residents();   -- פותח את הקורזור בשם elderly_cur
FETCH ALL FROM elderly_cur;            -- קורא את הנתונים
COMMIT;
DO $$
DECLARE
    cur refcursor;
    rec RECORD;
BEGIN
    cur := func_get_elderly_residents();

    LOOP
        FETCH cur INTO rec;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE 'Resident ID: %, Name: %, Birthdate: %',
                     rec.residentid, rec.name, rec.birthdate;
    END LOOP;

    CLOSE cur;
END;
$$;


rollback
------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION func_resident_visit_summary()
RETURNS refcursor AS $$
DECLARE
    cur refcursor := 'visit_summary_cur';
    temp RECORD;
    exists_check INT;
BEGIN
    SELECT COUNT(*) INTO exists_check FROM resident;
    IF exists_check = 0 THEN
        RAISE EXCEPTION 'No residents in database';
    END IF;

    CREATE TEMP TABLE temp_visit_summary (
        residentid INT,
        name TEXT,
        total_visits INT
    ) ON COMMIT DROP;

    FOR temp IN
        SELECT r.residentid, r.name, COUNT(v.activityid) AS total_visits
        FROM resident r
        LEFT JOIN visiting_event v ON r.residentid = v.resident_id 
        GROUP BY r.residentid, r.name
    LOOP
        INSERT INTO temp_visit_summary(residentid, name, total_visits)
        VALUES (temp.residentid, temp.name, temp.total_visits);
    END LOOP;

    OPEN cur FOR SELECT * FROM temp_visit_summary;
    RETURN cur;
END;
$$ LANGUAGE plpgsql;


BEGIN;
SELECT func_resident_visit_summary();
FETCH ALL FROM visit_summary_cur;
COMMIT;


rollback
---------------------------main

DO $$
DECLARE
    elderly_cur refcursor;
    summary_cur refcursor;
    rec RECORD;
BEGIN
    elderly_cur := func_get_elderly_residents();
    RAISE NOTICE '--- Elderly Residents (80+) ---';
    LOOP
        FETCH elderly_cur INTO rec;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE 'ID: %, Name: %, Birthdate: %', rec.residentid, rec.name, rec.birthdate;
    END LOOP;
    CLOSE elderly_cur;
    summary_cur := func_resident_visit_summary();
    RAISE NOTICE '--- Visit Summary ---';
    LOOP
        FETCH summary_cur INTO rec;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE 'ID: %, Name: %, Visits: %', rec.residentid, rec.name, rec.total_visits;
    END LOOP;
    CLOSE summary_cur;

END;
$$;
