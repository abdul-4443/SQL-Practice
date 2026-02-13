USE master;
GO
DROP DATABASE abdulrehmanbutt_24L_0725;

CREATE DATABASE abdulrehmanbutt_24L_0725;
GO

USE abdulrehmanbutt_24L_0725;
GO

--Q1. Create a table Patient with following fields
--• PatientID varchar (15) (PatientID is primary key) (should be assigned automatically)
--• Name varchar (15) (should not be null)
--• Age int
--• Gender varchar(5)
--• Address varchar(20)
--• Disease varchar(10)
--• DoctorID varchar(15)
----Also add a CHECK constraint to only allow patients above 5 years old.
CREATE TABLE PATIENT(
	PatientID INT IDENTITY(1,1) PRIMARY KEY,
	pname VARCHAR(15) NOT NULL,
	Age INT CHECK (Age > 5),
	Gender VARCHAR(5),
	Address VARCHAR(20),
	Disease VARCHAR(10),
	DoctorID INT
);
GO

--Q2. Change the datatype of Gender from varchar(5) to char in the Patient table using the
--ALTER command.
ALTER TABLE PATIENT
ALTER COLUMN Gender CHAR;
GO

-- Q3. Create a table Doctor with following fields
--• DoctorID varchar (15) (DoctorID is primary key) (should be assigned automatically)
--• Name varchar (15) (should not be null)
--• Age int
--• Gender char
--• Address varchar(20)
--The doctor&#39;s age should be above 18. Add this constraint using CHECK.
CREATE TABLE DOCTOR(
	DoctorID INT IDENTITY(1,1) PRIMARY KEY,
	dname VARCHAR(15) NOT NULL,
	Age INT CHECK (Age > 18),
	Gender CHAR,
	Address VARCHAR(20)
);
GO

-- Q4. Now add column DrSpecialization varchar(20) in the Doctor table.
ALTER TABLE DOCTOR ADD DrSpecialization VARCHAR(20);
GO

-- Q5. There is no relationship between the Patient and Doctor table, so make a relation
--between these two tables using the ALTER command. Note DoctorID in Patient, should be
--foreign key from Doctor table. 
ALTER TABLE PATIENT
ADD CONSTRAINT FK_Patient_Doctor
FOREIGN KEY (DoctorID) REFERENCES DOCTOR(DoctorID);
GO

-- Q6. Create a table LabTest with following fields
--• LabID varchar (15) (LabID is primary key)
--• LabNo varchar (10) (should be unique)
--• TestDate date DEFAULT: today’s date
--• TestAmount double
--• PatientID varchar(15) (foreign key)
--• DoctorID varchar(15) (foreign key)
CREATE TABLE LabTest (
    LabID VARCHAR(15) PRIMARY KEY,
    LabNo VARCHAR(10) UNIQUE,
    TestDate DATE DEFAULT GETDATE(), 
    TestAmount DECIMAL(10, 2),
    PatientID INT,
    DoctorID INT,

    CONSTRAINT FK_LabTest_Patient FOREIGN KEY (PatientID) 
        REFERENCES Patient(PatientID),
    CONSTRAINT FK_LabTest_Doctor FOREIGN KEY (DoctorID) 
        REFERENCES Doctor(DoctorID)
);
GO

-- Q7. Create a table PatientBill with following fields
-- • BillID varchar (15) (BillID is Primary key)
-- • BillDate date
-- • Amount varchar(20)
-- • PatientID varchar(15) (foreign key)
-- • DoctorID varchar(15) (foreign key)
CREATE TABLE PatientBill (
	BillID VARCHAR(15) PRIMARY KEY,
	BillDate DATE,
	Amount VARCHAR(20),
	PatientID INT,
	DoctorID INT,

	CONSTRAINT FK_PatientBill_Patient FOREIGN KEY (PatientID) 
        REFERENCES PATIENT(PatientID)
		ON DELETE CASCADE,
    CONSTRAINT FK_PatientBill_Doctor FOREIGN KEY (DoctorID) 
        REFERENCES DOCTOR(DoctorID)
		ON DELETE CASCADE
);
GO

-- Q8. Hospital cancels lab tests so remove table LabTest from database using DROP command.
DROP TABLE LabTest;
GO

-- Q9. Now add information of 4 doctors
INSERT INTO DOCTOR (dname, Age, Gender, Address, DrSpecialization) VALUES 
('Dr. Ali', 25, 'M', 'Lahore', 'MBBS'),
('Dr. Fatima', 31, 'F', 'Lahore', 'MBBS'),
('Dr. Subhan', 70, 'M', 'Multan', 'MBBS'),
('Dr. Ayesha', 19, 'F', 'Hafizabad', 'MBBS');
GO

-- Q10. Add 4 patients record
INSERT INTO PATIENT (pname, Age, Gender, Address, Disease, DoctorID)
VALUES 
('Ali', 30, 'F', 'Hafizabad', 'severe flu', 1),
('Fatima', 45, 'M', 'Lahore', 'cold', 2),
('Subhan', 25, 'M', 'Multan', 'cancer', 1),
('Ayesha', 35, 'F', 'Lahore', 'Headache', 3);
GO

-- Q11. Add 2 patient bills.
INSERT INTO PatientBill (BillID, BillDate, Amount, PatientID, DoctorID)
VALUES 
    ('B001', '2025-01-15', '25.0', 1, 1),
    ('B002', '2025-01-20', '120.50', 2, 2);
GO

-- Q12. Now show your record using a select query. Also show a patient bill exceeding Rs 100.
SELECT *
FROM PATIENT;
SELECT *
FROM DOCTOR;
SELECT *
FROM PatientBill;


-- Q13. Delete all data of PatientBill table with one query (table and its attributes should not be deleted)
SELECT *
FROM PatientBill
WHERE CAST(Amount AS DECIMAL) > 100;

-- Q14. Delete record of 1 patient by the help of his/her name
DELETE FROM Patient WHERE pname = 'Subhan'

-- Q15. Update all patients with the severe flu disease to COVID.
UPDATE Patient SET pname = 'covid' WHERE pname = 'severe flu'