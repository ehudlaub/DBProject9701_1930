ALTER TABLE Feedback
ADD CONSTRAINT rating_range CHECK (rating BETWEEN 1 AND 5);
