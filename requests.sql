-- 1.
SELECT * from patients WHERE patientid in (
  SELECT patientid from visits WHERE doctorid = 0
);

-- 2.
SELECT doctorid, patientid from visits WHERE visitid In (
  SELECT visitid from prescription WHERE drugname = 'Омепразол'
);

-- 3.
SELECT * from visits
WHERE hospitalId = (SELECT hospitalid from hospitals WHERE hospitaladdress = 'Автобусная ул., 5Б')
    and doctorId = (SELECT doctorid from doctors WHERE doctorname = 'Лебедев Никита Ильич')
	and VisitTimestamp > '2023-05-25'
	and VisitTimestamp < (TO_TIMESTAMP('2023-05-25', 'YYYY-MM-DD HH:MI:SS') + INTERVAL '1 day');

-- 4.
SELECT * from prescription WHERE visitid in
(SELECT visitid from visits WHERE patientid in (
  SELECT patientid from patients WHERE patientfullname = 'Попова Александра Львовна'
));

-- 5.
SELECT COUNT(visitid) from visits
WHERE hospitalId = (SELECT hospitalid from hospitals WHERE hospitaladdress = 'Жени Егоровой ул., 1')
and VisitTimestamp > '2023-05-25'
and VisitTimestamp < (TO_TIMESTAMP('2023-05-25', 'YYYY-MM-DD HH:MI:SS') + INTERVAL '1 day');

-- 6.
INSERT into Visits (VisitId, HospitalId, PatientId, DoctorId, VisitTimestamp, VisitDuration, VisitComment)
VALUES (5, 1, 5, 4, '2023-05-25 10:00:00', '30 minute', '-');

-- 7.
SELECT doctorname from doctors WHERE doctorid in
(SELECT doctorid from visits WHERE visitid in
(SELECT visitid from visits WHERE patientId in
(SELECT patientid from patients WHERE patientfullname = 'Попова Александра Львовна')));

-- 8.

INSERT into Patients (PatientId, PatientFullName, PatientBirthday, PatientPhoneNumber, MainHospitalId)
VALUES (10, 'Саламатова Татьяна Олеговна', '2001-03-17 00:00:00', '+79193115616', 3);

-- 9.

INSERT into Prescription (VisitId, DrugName, ValidityPeriod, StartTimestamp)
VALUES (6, 'Омепразол', '17 day'
, now());

-- 10.

UPDATE doctors
SET DoctorExperience = DoctorExperience + '1 year'
WHERE DoctorId = 4;

-- 11.

UPDATE Drugs
SET DrugPrice = 1567.88
WHERE DrugName = 'Омепразол';

-- 12.

UPDATE Visits
SET VisitComment = 'левый тоже перестал видеть'
WHERE VisitId = 2;

-- 13.

DELETE FROM patients WHERE patientid = 10;