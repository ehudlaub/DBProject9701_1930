begin;
DELETE FROM Instructor
WHERE instructorId IN (
  SELECT i.instructorId
  FROM Instructor i
  JOIN Activity a ON i.instructorId = a.instructorId
  JOIN Feedback f ON a.activityId = f.activityId
  GROUP BY i.instructorId
  HAVING AVG(f.rating) < 3
);
