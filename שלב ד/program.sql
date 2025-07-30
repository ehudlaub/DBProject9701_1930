CREATE OR REPLACE PROCEDURE register_resident_to_activity(
    p_resident_id INT,
    p_activity_id INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_max INT;
    v_current INT;
    v_end DATE;
BEGIN
    SELECT maxparticipants, currentparticipants, enddate
    INTO v_max, v_current, v_end
    FROM Activity
    WHERE activityid = p_activity_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Activity % not found', p_activity_id;
    END IF;

    IF v_end < CURRENT_DATE THEN
        RAISE EXCEPTION 'Activity % has already ended', p_activity_id;
    END IF;

    IF v_current >= v_max THEN
        RAISE EXCEPTION 'Activity % is full', p_activity_id;
    END IF;

    INSERT INTO participates(residentid, activityid, registrationdate)
    VALUES (p_resident_id, p_activity_id, CURRENT_DATE);

    UPDATE Activity
    SET currentparticipants = currentparticipants + 1
    WHERE activityid = p_activity_id;

    RAISE NOTICE 'Resident % successfully registered to activity %', p_resident_id, p_activity_id;
END;
$$;

CREATE OR REPLACE FUNCTION update_current_participants()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        UPDATE Activity
        SET currentparticipants = currentparticipants + 1
        WHERE activityid = NEW.activityid;
    ELSIF TG_OP = 'DELETE' THEN
        UPDATE Activity
        SET currentparticipants = currentparticipants - 1
        WHERE activityid = OLD.activityid;
    END IF;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_inc_current_participants
AFTER INSERT ON participates
FOR EACH ROW
EXECUTE FUNCTION update_current_participants();

CREATE TRIGGER trg_dec_current_participants
AFTER DELETE ON participates
FOR EACH ROW
EXECUTE FUNCTION update_current_participants();

CREATE OR REPLACE FUNCTION print_all_instructors_report()
RETURNS VOID AS $$
DECLARE
    rec RECORD;
BEGIN
    FOR rec IN
        SELECT 
            i.instructorId,
            i.name AS instructor_name,
            COUNT(a.activityId) AS total_activities,
            DATE_PART('year', AGE(CURRENT_DATE, i.startDate)) AS years_of_experience,
            ROUND(AVG(f.rating), 2) AS avg_feedback,
            ROUND(AVG(a.currentParticipants), 2) AS avg_participants
        FROM Instructor i
        LEFT JOIN Activity a ON i.instructorId = a.instructorId
        LEFT JOIN Feedback f ON a.activityId = f.activityId
        GROUP BY i.instructorId, i.name, i.startDate
        ORDER BY COUNT(a.activityId) DESC
    LOOP
        RAISE NOTICE 'Instructor: %, Activities: %, Experience: %, Avg Feedback: %, Avg Participants: %',
            rec.instructor_name, rec.total_activities, rec.years_of_experience, rec.avg_feedback, rec.avg_participants;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

DO $$
DECLARE
    cur refcursor;
    rec RECORD;
BEGIN
    cur := get_all_instructors_report();

    RAISE NOTICE '--- Instructors Report ---';

    LOOP
        FETCH cur INTO rec;
        EXIT WHEN NOT FOUND;

        RAISE NOTICE 'ID: %, Name: %, Activities: %, Experience: %, Avg Feedback: %, Avg Participants: %',
            rec.instructorId, rec.instructor_name, rec.total_activities,
            rec.years_of_experience, rec.avg_feedback, rec.avg_participants;
    END LOOP;

    CLOSE cur;
END;
$$;

ALTER TABLE supplies ADD COLUMN wasPaid BOOLEAN DEFAULT FALSE;

CREATE TABLE payment_log (
    log_id SERIAL PRIMARY KEY,
    supplier_id INT NOT NULL,
    supply_date DATE NOT NULL,
    activity_id INT NOT NULL,
    original_cost NUMERIC NOT NULL,
    final_paid NUMERIC NOT NULL,
    log_date DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (supplier_id, supply_date, activity_id)
        REFERENCES supplies(supplierId, supplyDate, activityId)
);


CREATE OR REPLACE FUNCTION calculate_late_fee(
    p_cost NUMERIC,
    p_supply_date DATE
) RETURNS NUMERIC AS $$
DECLARE
    years_late INT;
BEGIN
    years_late := DATE_PART('year', AGE(CURRENT_DATE, p_supply_date));
    RETURN ROUND(p_cost * POWER(1.03, years_late), 2);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE mark_supply_as_paid_row(
    IN p_supply_row supplies,
    OUT p_amount_paid NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_exists supplies%ROWTYPE;
BEGIN
    SELECT * INTO v_exists
    FROM supplies
    WHERE supplierId = p_supply_row.supplierId
      AND supplyDate = p_supply_row.supplyDate
      AND activityId = p_supply_row.activityId;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Supply not found';
    END IF;

    IF v_exists.waspaid THEN
        RAISE EXCEPTION 'Supply was already marked as paid';
    END IF;

    p_amount_paid := calculate_late_fee(v_exists.cost, v_exists.supplyDate);

    UPDATE supplies
    SET waspaid = TRUE
    WHERE supplierId = p_supply_row.supplierId
      AND supplyDate = p_supply_row.supplyDate
      AND activityId = p_supply_row.activityId;
END;
$$;

CREATE OR REPLACE FUNCTION log_payment_update() RETURNS TRIGGER AS $$
DECLARE
    v_paid NUMERIC;
BEGIN
    v_paid := calculate_late_fee(NEW.cost, NEW.supplyDate);

    INSERT INTO payment_log (
        supplier_id,
        supply_date,
        activity_id,
        original_cost,
        final_paid
    ) VALUES (
        NEW.supplierId,
        NEW.supplyDate,
        NEW.activityId,
        NEW.cost,
        v_paid
    );

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_log_payment
AFTER UPDATE OF waspaid ON supplies
FOR EACH ROW
WHEN (NEW.waspaid = TRUE AND OLD.waspaid = FALSE)
EXECUTE FUNCTION log_payment_update();

DO $$
DECLARE
    v_row supplies;
    v_paid NUMERIC;
BEGIN
    SELECT * INTO v_row
    FROM supplies
    WHERE supplierId = 99
      AND supplyDate = DATE '2020-06-15'
      AND activityId = 999;

    CALL mark_supply_as_paid_row(v_row, v_paid);
    RAISE NOTICE 'its paid % ₪', v_paid;
END;
$$;

