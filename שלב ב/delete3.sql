begin;
DELETE FROM Feedback
WHERE feedbackId IN (
  SELECT f.feedbackId
  FROM Feedback f
  JOIN Activity a ON f.activityId = a.activityId
  WHERE a.title = 'Art'
  AND f.rating < 3
);
