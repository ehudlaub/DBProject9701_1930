--TRIGGER 1
-- פונקציית טריגר
CREATE OR REPLACE FUNCTION my_trigger_func()
RETURNS TRIGGER AS $$
BEGIN
    -- פעולה שמתבצעת על כל שורה חדשה
    RAISE NOTICE 'נוספה שורה!';
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- טריגר שמפעיל את הפונקציה הזו
CREATE TRIGGER trg_notify_insert
AFTER INSERT ON resident
FOR EACH ROW
EXECUTE FUNCTION my_trigger_func();
INSERT INTO resident(residentid,name, birthdate,admissiondate,gender)
VALUES (1,'Cami Blyden', '1901-03-11','2001-05-01','M');




--TRIGGER 2
CREATE OR REPLACE FUNCTION prevent_birthdate_update()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.birthdate IS DISTINCT FROM OLD.birthdate THEN
        RAISE EXCEPTION 'Cannot update birthdate of a resident (ID: %)', 
		OLD.residentid;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_block_update_birthdate
BEFORE UPDATE ON resident
FOR EACH ROW
EXECUTE FUNCTION prevent_birthdate_update();

UPDATE resident
SET birthdate = '1955-01-01'
WHERE residentid = 1;
