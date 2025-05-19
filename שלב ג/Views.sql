--view 1
CREATE VIEW activity_participants_view AS
SELECT 
    a.activityId,
    a.title,
    a.location,
    a.startDate,
    r.residentId,
    r.name AS resident_name
FROM 
    Activity a
JOIN 
    Participates p ON a.activityId = p.activityId
JOIN 
    Resident r ON p.residentId = r.residentId;

--view 2
CREATE OR REPLACE VIEW inventory_staff_view AS
SELECT 
    i.item_id,
    i.item_name,
    i.quantity,
    s.staff_member_id,
    s.staff_member_name,
    s.job_title
FROM 
    Inventory i
JOIN 
    staff_member s ON i.item_id = s.staff_member_id;