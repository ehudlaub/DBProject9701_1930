BEGIN;
ALTER TABLE Resident
ADD COLUMN isActive BOOLEAN;
UPDATE Resident
SET isActive = TRUE
WHERE residentId IN (
  SELECT p.residentId
  FROM Participates p
  JOIN Activity a ON p.activityId = a.activityId
  WHERE a.startDate >= CURRENT_DATE - INTERVAL '2 years'
  GROUP BY p.residentId
  HAVING COUNT(*) >= 2
);

UPDATE Resident
SET isActive = FALSE
WHERE isActive IS NULL;

