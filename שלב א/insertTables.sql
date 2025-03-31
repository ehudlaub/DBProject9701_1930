
-- Instructor
INSERT INTO Instructor (instructorId, name, gender, startDate, specialty) VALUES
(1, 'Susan Clark', 0, '2020-05-01', 'Physiotherapy'),
(2, 'Michael Johnson', 1, '2018-09-15', 'Art'),
(3, 'Emily Davis', 0, '2021-01-10', 'Music');

-- Supplier
INSERT INTO Supplier (supplierId, name, serviceType, contractStart, contractEnd) VALUES
(1, 'Healthy Bites', 'Food', '2024-01-01', '2024-12-31'),
(2, 'CarePoint', 'Medical', '2023-06-01', '2025-05-31'),
(3, 'EventEase', 'Logistics', '2024-03-01', '2024-11-30');

-- Resident
INSERT INTO Resident (residentId, name, birthDate, admissionDate, gender) VALUES
(1, 'John Miller', '1942-04-12', '2022-01-10', 1),
(2, 'Helen Brooks', '1940-06-25', '2021-05-15', 0),
(3, 'George Adams', '1938-11-03', '2023-03-20', 1);

-- Activity
INSERT INTO Activity (activityId, title, startDate, endDate, maxParticipants, currentParticipants, instructorId) VALUES
(1, 'Yoga Session', '2025-04-01', '2025-04-30', 20, 3, 1),
(2, 'Painting Class', '2025-05-01', '2025-05-31', 15, 2, 2),
(3, 'Choir Practice', '2025-04-15', '2025-06-15', 25, 3, 3);

-- supplies
INSERT INTO supplies (supplyDate, supplierId, activityId, cost) VALUES
('2025-03-10', 1, 1, 300),
('2025-03-15', 2, 2, 200),
('2025-03-20', 3, 3, 150);

-- Participates
INSERT INTO Participates (registrationDate, activityId, residentId) VALUES
('2025-03-01', 1, 1),
('2025-03-02', 2, 2),
('2025-03-03', 3, 3);

-- Feedback
INSERT INTO Feedback (feedbackId, feedbackDate, comment, rating, activityId, residentId) VALUES
(1, '2025-03-05', 'Great activity!', 5, 1, 1),
(2, '2025-03-06', 'Very enjoyable', 4, 2, 2),
(3, '2025-03-07', 'Nice instructor', 5, 3, 3);
