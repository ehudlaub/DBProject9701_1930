ALTER TABLE resident
ADD COLUMN status TEXT;
CREATE OR REPLACE PROCEDURE proc_flag_long_admissions()
LANGUAGE plpgsql
AS $$
DECLARE
    rec RECORD;
    cur CURSOR FOR
        SELECT residentid, admissiondate
        FROM resident
        WHERE admissiondate < CURRENT_DATE - INTERVAL '10 years';
BEGIN
    OPEN cur;
    LOOP
        FETCH cur INTO rec;
        EXIT WHEN NOT FOUND;

        BEGIN
            UPDATE resident
            SET status = 'Veteran'
            WHERE residentid = rec.residentid;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE NOTICE 'Could not update resident ID %: %', rec.residentid, SQLERRM;
        END;
    END LOOP;
    CLOSE cur;
END;
$$;

--  ללא תפקיד
CREATE OR REPLACE PROCEDURE proc_delete_empty_staff_roles()
LANGUAGE plpgsql
AS $$
DECLARE
    rec RECORD;
    cur CURSOR FOR
        SELECT staff_member_id, staff_member_name
        FROM staff_member
        WHERE job_title IS NULL OR TRIM(job_title) = '';
BEGIN
    OPEN cur;
    LOOP
        FETCH cur INTO rec;
        EXIT WHEN NOT FOUND;

        BEGIN
            DELETE FROM staff_member
            WHERE staff_member_id = rec.staff_member_id;
            RAISE NOTICE 'Deleted staff member: %', rec.staff_member_name;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE WARNING 'Failed to delete staff member ID %: %',
                              rec.staff_member_id, SQLERRM;
        END;
    END LOOP;
    CLOSE cur;
END;
$$;

-- main
DO $$
DECLARE
    res RECORD;
BEGIN
    RAISE NOTICE 'Running: proc_flag_long_admissions';
    CALL proc_flag_long_admissions();

    RAISE NOTICE '--- Residents marked as Veteran ---';
    FOR res IN
        SELECT residentid, name, admissiondate
        FROM resident
        WHERE status = 'Veteran'
    LOOP
        RAISE NOTICE 'ID: %, Name: %, Admission Date: %', res.residentid, res.name, res.admissiondate;
    END LOOP;

    RAISE NOTICE 'Running: proc_delete_empty_staff_roles';
    CALL proc_delete_empty_staff_roles();

    RAISE NOTICE '--- Remaining Staff Members ---';
    FOR res IN
        SELECT staff_member_id, staff_member_name, job_title
        FROM staff_member
    LOOP
        RAISE NOTICE 'ID: %, Name: %, Role: %', res.staff_member_id, res.staff_member_name, res.job_title;
    END LOOP;
END;
$$;
