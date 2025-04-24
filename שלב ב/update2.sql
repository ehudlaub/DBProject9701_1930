BEGIN;

UPDATE Feedback
SET comment = LOWER(comment);

SELECT feedbackId, comment
FROM Feedback;
