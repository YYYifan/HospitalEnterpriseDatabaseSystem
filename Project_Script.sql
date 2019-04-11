Use hospitaldb;

create view `view_ResidentPatient` AS
select patient.PatientID, FirstName, LastName, ssn, address, AdmitDate, residentpatient.DischargedDate, building.BuildingName, residentpatient.RoomID, residentpatient.BedID
from patient inner join residentpatient on patient.PatientID = residentpatient.PatientID
inner join building on building.BID = residentpatient.BID;

select * from view_ResidentPatient;

create view `view_OutPatient` AS
select patient.PatientID, FirstName, LastName, ssn, address, AdmitDate, outpatient.CheckBackDate
from patient inner join outpatient on patient.PatientID = outpatient.PatientID;

select * from view_OutPatient;


create view `view_treatment` AS
select patient.PatientID, patient.FirstName as PatientFirstName, patient.LastName as PatientLastName, patient.AdmitDate, physician.FirstName as PhysicianFirstName, physician.LastName as PhysicianLastName,
treat.Date, treat.Time, treatment.Description, treat.Result
from patient inner join treat on patient.PatientID = treat.PatientID
inner join treatment on treat.TreatID = treatment.TreatID
inner join physician on treat.PhyID = physician.PhyID;

select * from view_treatment;


create view `view_consumedItems` AS
select patient.PatientID, patient.FirstName as PatientFirstName, patient.LastName as PatientLastName, patient.AdmitDate,
consumes.ConsumeDate, consumes.ItemID, consumes.Quantity, items.Description, items.UnitPrice, consumes.TotalPrice
from patient inner join consumes on patient.PatientID = consumes.PatientID
inner join items on consumes.ItemID = items.ItemID;

select * from view_consumedItems;

alter view `view_carecenterinfo` AS
select carecenter.CcID, carecenter.CcName, carecenter.telephoneNumber, building.BuildingName, carecenteremployee.FirstName as employeeFirstName, carecenteremployee.LastName as employeeLastName,
carecenteremployee.PhoneNumber, carecenteremployee.Email
from carecenter inner join building on carecenter.BID = building.BID
inner join employs on carecenter.CcID = employs.CcID
inner join carecenteremployee on employs.EmpID = carecenteremployee.EmpID;

select * from view_carecenterinfo;

-- Trigger1: logging changes in updates
Create Table `hospitaldb`.`patient_log` (
	`UID` int not null auto_increment,
    `username` varchar(45) null,
    `patientID` int null,
    `oldname` varchar(45) null,
    `newname` varchar(45) null,
    primary key (`UID`));
    
Delimiter $$
create trigger `patient_update`
	after update
    on `patient`
	for each row
begin
	insert into patient_log (username, patientID, oldname, newname)
    values (user(), old.PatientID, old.FirstName, new.FirstName);
end $$

Delimiter ;

-- update a record to observe the change
update patient set FirstName = 'Mujin' where patientID = 1;
update patient set FirstName = 'haha' where patientID = 2;

select * from patient;

select * from patient_log;

-- Trigger2: Using trigger to backup for deletion
CREATE TABLE `hospitaldb`.`patient_backup` (
  `patientid` INT NOT NULL,
  `patinetFname` VARCHAR(45) not NULL,
  `patientLname` VARCHAR(45) not NULL,
  `patientSsn` VARCHAR(45) not NULL,
  `patientAddress` VARCHAR(45) not NULL,
  `AdmitDate` Date not null,
  `physicianID` int not null,
  `OutPatient` VARCHAR(45) not NULL,
  `ResidentPatient` VARCHAR(45) not NULL,
  PRIMARY KEY (`patientid`));
  
delimiter $$
create trigger `patient_delete_backup`
before delete on `patient`
	for each row
begin
	insert into patient_backup
    values (old.PatientID, old.FirstName, old.LastName, old.ssn, old.address, old.AdmitDate, old.PhyID, old.OutPatient, old.ResidentPatient);
end;
$$
-- delete a record to observe the change
insert into `patient` values (9, 'Fanny', 'Davis', '666', 'Beijing', '2018-4-27', 3, 'N', 'Y');
select * from patient;
select * from residentpatient;
delete from residentpatient where patientID = 10;
delete from patient where PatientID = 8;
insert into `patient_backup` values (9, 'Fanny', 'Davis', '666', 'Beijing', '2018-4-27', 3, 'N', 'Y');
select * from `patient_backup`;

-- trigger 3: after deletion, deletion logs
Create Table `hospitaldb`.`Resientpatient_deletedRecords` (
	`UID` int not null auto_increment,
    `username` varchar(45) not null,
    `Date` Date not null,
    `patientID` int not null,
    primary key (`UID`));
    
delimiter //
create trigger trigger_deleted_patient after delete on residentpatient for each row
begin
insert into Resientpatient_deletedRecords values(user(), now(), old.patientID);
end;//
insert into `Resientpatient_deletedRecords` values (10, 'Fanny', 'Davis', '666', 'Beijing', '2018-4-27', 3, 'N', 'Y');
delete from residentpatient where patientID = 10;
select * from residentpatient;
insert into Resientpatient_deletedRecords values(1, user(), now(), 10);
select * from Resientpatient_deletedRecords;
select * from patient_deletedrecords;
-- trigger 4: when inserting a patient record, a outpatient record or a residetPatient record 
-- would be inserted on the meantime.
delimiter //
CREATE DEFINER=`root`@`localhost` TRIGGER `hospitaldb`.`patient_AFTER_INSERT` AFTER INSERT ON `patient` FOR EACH ROW
BEGIN
if(new.OutPatient = 'Y')
then 
insert into outpatient(PatientID) values(new.PatientID);
end if;
if(new.ResidentPatient = 'Y')
then
insert into residentpatient(PatientID, BedID, RoomID, CcID, BID) values(new.PatientID, 1, 100, 1, 1);
end if;
END;//



-- Data Sample

-- carecenter
insert into `carecenter` values (1, 'internal medicine', 1, '123-456-789');
insert into `carecenter` values (2, 'surgery', 2, '111-222-333');
select * from carecenter;
-- Building
insert into `building` values (1, 'South Building');
insert into `building` values (2, 'North Building');
select * from building;
-- Room
insert into `room` values (100, 1, 1, 1);
insert into `room` values (101, 2, 1, 1);
insert into `room` values (200, 2, 2, 2);
insert into `room` values (201, 8, 2, 2);
select * from room;
-- Bed
insert into `bed` values (1, 'VIP', 100, 1, 1);
insert into `bed` values (1, 'Nomal', 101, 1, 1);
insert into `bed` values (2, 'Nomal', 101, 1, 1);
insert into `bed` values (1, 'Nomal', 200, 2, 2);
insert into `bed` values (2, 'Nomal', 200, 2, 2);
delete from bed where BedID = 1;
delete from bed where BedID = 2;
select * from bed;
-- carecenteremployee
insert into `carecenteremployee` values (1, 'Bob', 'Johns', '987-654-321', '111@hhh.com');
insert into `carecenteremployee` values (2, 'Kate', 'Smith', '123-131-434', '222@hhh.com');
insert into `carecenteremployee` values (3, 'Isebella', 'Muji', '932-232-123', '333@hhh.com');
select * from carecenteremployee;
-- employs
insert into `employs` values (1, 1);
insert into `employs` values (2, 1);
insert into `employs` values (3, 2);
insert into `employs` values (1, 2);
select * from employs;

-- pysician
insert into `physician` values (1, 'Vanessa', 'Smith');
insert into `physician` values (2, 'Alula', 'Zhang');
insert into `physician` values (3, 'Yif', 'Liu');
insert into `physician` values (4, 'Suibian', 'WUsuowei');
select * from physician;
-- insert patient records
insert into `patient` values (1, 'Yifan', 'Zhang', '123', 'Malden', '2018-4-25', 2, 'Y', 'N');
insert into `patient` values (2, 'Kitty', 'Smith', '456', 'Boston', '2018-4-26', 1, 'N', 'Y');
insert into `patient` values (3, 'Bob', 'Brown', '556', 'Washington', '2018-4-26', 3, 'Y', 'N');
insert into `patient` values (4, 'Mike', 'Davis', '233', 'California', '2018-4-27', 2, 'N', 'Y');
insert into `patient` values (5, 'Jane', 'Smith', '333', 'Malden', '2018-4-26', 4, 'N', 'Y');
insert into `patient` values (6, 'Fanny', 'Davis', '666', 'Beijing', '2018-4-27', 3, 'Y', 'N');

delete from patient where patientID = 1;
delete from patient where patientID = 3;
delete from patient where patientID = 6;
select * from patient;

update patient set FirstName = 'haha' where patientID = 2;
delete from patient where patientID = 2;

-- outpatient
update outpatient set CheckBackDate = '2018-4-30'where patientID = 1;
update outpatient set CheckBackDate = '2018-4-29'where patientID = 3;
update outpatient set CheckBackDate = '2018-4-28'where patientID = 6;
insert into `outpatient` values (1, '2018-4-30');
insert into `outpatient` values (3, '2018-4-29');
insert into `outpatient` values (6, '2018-4-28');
delete from outpatient where patientID = 1;
delete from outpatient where patientID = 3;
delete from outpatient where patientID = 6;
select * from outpatient;
-- residentpatient
insert into `residentpatient` values (2, '2018-5-30', 1, 100, 1, 1);
update ResidentPatient set DischargedDate = '2018-5-30'where patientID = 2;
update ResidentPatient set BedID = 1, RoomID = 100 ,CcID = 1 ,BID = 1 where patientID = 2;
update ResidentPatient set DischargedDate = '2018-6-10'where patientID = 4;
update ResidentPatient set BedID = 2,RoomID = 101, CcID = 1, BID = 1 where patientID = 4;
update ResidentPatient set DischargedDate = '2018-7-20'where patientID = 5;
update ResidentPatient set BedID = 1, RoomID = 200 ,CcID = 2 , BID = 2 where patientID = 5;
select * from ResidentPatient;
update ResidentPatient set DischargedDate = '2018-8-20'where patientID = 10;
update ResidentPatient set BedID = 2, RoomID = 200 ,CcID = 2 , BID = 2 where patientID = 5;
-- items
insert into `items` values (1, 'Anti-inflammatory', 'Oral', 88.8);
insert into `items` values (2, 'headache', 'Oral', 100.9);
insert into `items` values (3, 'cold', 'Oral', 20.3);
insert into `items` values (4, 'trauma', 'External', 55.5);
insert into `items` values (5, 'prevention', 'injection', 330.4);
select * from items;
-- consumes
insert into `consumes` values (1, 1, '2018-4-25', 2, 177.6);
insert into `consumes` values (1, 2, '2018-4-25', 2, 201.8);
insert into `consumes` values (3, 3, '2018-4-26', 4, 81.2);
insert into `consumes` values (4, 5, '2018-4-27', 1, 330.4);
insert into `consumes` values (5, 1, '2018-4-26', 4, 355.2);
insert into `consumes` values (5, 2, '2018-4-26', 1, 100.9);
insert into `consumes` values (6, 4, '2018-4-27', 5, 277.5);
select * from consumes;
-- treatment
insert into `treatment` values (1, 'Consultation');
insert into `treatment` values (2, 'Prescribetion');
insert into `treatment` values (3, 'Hospitalization');
insert into `treatment` values (4, 'Surgery');
select * from treatment;
-- treat
insert into `treat` values (1, 1, 2, '2018-4-25', '13:00', 'Pending');
insert into `treat` values (2, 1, 2, '2018-4-25', '14:00', 'Pending');
insert into `treat` values (2, 2, 1, '2018-4-26', '13:00', 'Pending');
insert into `treat` values (2, 3, 3, '2018-4-26', '8:00', 'Completed');
insert into `treat` values (3, 4, 2, '2018-4-27', '10:00', 'Completed');
insert into `treat` values (3, 5, 4, '2018-4-26', '8:00', 'Completed');
insert into `treat` values (4, 5, 4, '2018-4-27', '18:00', 'Pending');
insert into `treat` values (1, 6, 3, '2018-4-27', '22:00', 'Pending');
select * from treat;