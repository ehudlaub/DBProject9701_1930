CREATE TABLE Instructor
(
  specialty VARCHAR(50) NOT NULL,
  gender INT NOT NULL,
  startDate DATE NOT NULL,
  instructorId INT NOT NULL,
  name VARCHAR(50) NOT NULL,
  PRIMARY KEY (instructorId)
);

CREATE TABLE Supplier
(
  name VARCHAR(50) NOT NULL,
  serviceType VARCHAR(50) NOT NULL,
  contractStart DATE NOT NULL,
  contractEnd	 DATE NOT NULL,
  supplierId INT NOT NULL,
  PRIMARY KEY (supplierId)
);

CREATE TABLE Activity
(
  activityId INT NOT NULL,
  endDate DATE NOT NULL,
  title VARCHAR(50) NOT NULL,
  startDate DATE NOT NULL,
  maxParticipants INT NOT NULL,
  currentParticipants INT NOT NULL,
  instructorId INT NOT NULL,
  PRIMARY KEY (activityId),
  FOREIGN KEY (instructorId) REFERENCES Instructor(instructorId)
);

CREATE TABLE Resident
(
  residentId INT NOT NULL,
  name VARCHAR(50) NOT NULL,
  birthDate DATE NOT NULL,
  admissionDate DATE NOT NULL,
  gender INT NOT NULL,
  PRIMARY KEY (residentId)
);

CREATE TABLE supplies
(
  cost INT NOT NULL,
  supplyDate DATE NOT NULL,
  supplierId INT NOT NULL,
  activityId INT NOT NULL,
  PRIMARY KEY (supplyDate, supplierId, activityId),
  FOREIGN KEY (supplierId) REFERENCES Supplier(supplierId),
  FOREIGN KEY (activityId) REFERENCES Activity(activityId)
);

CREATE TABLE Participates
(
  registrationDate DATE NOT NULL,
  activityId INT NOT NULL,
  residentId INT NOT NULL,
  PRIMARY KEY (activityId, residentId),
  FOREIGN KEY (activityId) REFERENCES Activity(activityId),
  FOREIGN KEY (residentId) REFERENCES Resident(residentId)
);

CREATE TABLE Feedback
(
  feedbackDate DATE NOT NULL,
  comment	 VARCHAR(100) NOT NULL,
  feedbackId INT NOT NULL,
  rating INT NOT NULL,
  activityId INT NOT NULL,
  residentId INT NOT NULL,
  PRIMARY KEY (feedbackId),
  FOREIGN KEY (activityId, residentId) REFERENCES Participates(activityId, residentId)
);