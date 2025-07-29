ALTER TABLE resident RENAME TO resident1;

ALTER TABLE resident1 ADD COLUMN room_id INT;

ALTER TABLE resident1
ADD CONSTRAINT fk_room FOREIGN KEY (room_id)
REFERENCES room(room_id);


UPDATE resident1 r1
SET room_id = r2.room_id
FROM resident r2
WHERE r1.residentId = r2.resident_id;

DROP TABLE resident;

ALTER TABLE resident1 RENAME TO resident;


ALTER TABLE Activity ADD COLUMN activity_location VARCHAR(100);

INSERT INTO Activity (
  activityId, startDate, endDate, title,
  maxParticipants, currentParticipants, instructorId, activity_location
)
SELECT 
  event_id,
  event_date,
  event_date,
  event_name,
  100,
  0,
  1,
  event_location
FROM event
WHERE event_id NOT IN (SELECT activityId FROM Activity);

DROP TABLE event;

INSERT INTO Participates (residentId, activityId, registrationDate)
SELECT 
  ve.resident_id,
  ve.event_id,
  a.startDate
FROM visiting_event ve
JOIN Activity a ON ve.event_id = a.activityId
WHERE (ve.resident_id, ve.event_id) NOT IN (
  SELECT p.residentId, p.activityId
  FROM Participates p
);

DROP TABLE visiting_event;
