--new entity אם activity
ALTER TABLE activity
ADD COLUMN location VARCHAR(100);

--Deleting a table
DROP TABLE event CASCADE;


--Name change 
ALTER TABLE visiting_event
RENAME COLUMN event_id TO activityId;
