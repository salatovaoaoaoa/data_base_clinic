-- noinspection SqlNoDataSourceInspectionForFile

create table if not exists Doctors
(
    DoctorId                    int                not null,
    DoctorName                  varchar(50)        not null,
    DoctorSpecialization        varchar(100)       not null,
    DoctorExperience            interval           not null,
    constraint Doctors_PK primary key (DoctorId)
);

create table if not exists Hospitals
(
    HospitalId          int              not null,
    HospitalAddress     varchar(256)     not null,
    HospitalPhoneNumber varchar(12)      not null,
    HospitalRating      real             not null,
    constraint Hospitals_PK primary key (HospitalId),
    constraint Hospitals_K1 unique (HospitalAddress),
    constraint Hospitals_K2 unique (HospitalPhoneNumber)
);

create table if not exists Patients
(
    PatientId               int             not null,
    PatientFullName         varchar(50)     not null,
    PatientBirthday         timestamp       not null,
    PatientPhoneNumber      varchar(12)     not null,
    MainHospitalId          int             not null,
    constraint Patients_PK primary key (PatientId),
    constraint Patients_MainHospitalId_FK1 foreign key (MainHospitalId) references Hospitals (HospitalId)
);

create table if not exists Visits
(
    VisitId             int             not null,
    HospitalId          int             not null,
    PatientId           int             not null,
    DoctorId            int             not null,
    VisitTimestamp      timestamp       not null,
    VisitDuration       interval        not null,
    VisitComment        text            not null,
    constraint Visits_PK primary key (VisitId),
    constraint Visits_K1 unique (VisitTimestamp, PatientId),
    constraint Visits_K2 unique (VisitTimestamp, DoctorId),
    constraint Visits_HospitalId_FK1 foreign key (HospitalId) references Hospitals (HospitalId),
    constraint Visits_PatientId_FK2 foreign key (PatientId) references Patients (PatientId),
    constraint Visits_DoctorId_FK3 foreign key (DoctorId) references Doctors (DoctorId)

);

create table if not exists Drugs
(
    DrugName    varchar(50)     not null,
    DrugPrice   real            not null,
    constraint Drugs_PK primary key (DrugName)
);

create table if not exists Prescription
(
    ValidityPeriod          interval         not null,
    StartTimestamp          timestamp        not null,
    DrugName                varchar(50)      not null,
    VisitId                 int              not null,
    constraint Prescription_PK primary key (DrugName, VisitId),
    constraint Prescription_VisitId_FK1 foreign key (VisitId) references Visits (VisitId),
    constraint Prescription_DrugName_FK2 foreign key (DrugName) references Drugs (DrugName)
);
