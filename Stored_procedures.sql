-- procedures
Delimiter //
create procedure p_findPatientPhysician (in pFn varchar(45), in pLn varchar(45))
begin
select physician.FirstName as PhysicianFirstName, physician.LastName as PhysicianLastName
from physician inner join Patient on patient.PhyID = physician.PhyID 
and patient.FirstName = pFn and patient.LastName = pLn;
end;//

call p_findPatientPhysician ('Bob', 'Brown');

Delimiter //
create procedure p_findResidentPatientLocation (in pid int)
begin
select view_residentpatient.BuildingName, view_residentpatient.RoomID, view_residentpatient.BedID
from view_residentpatient
where PatientID = pid;
end;//

call p_findResidentPatientLocation(4);

Delimiter //
create procedure p_PatientConsumedItems (in pid int)
begin
select view_consumeditems.ItemID, view_consumeditems.ConsumeDate, view_consumeditems.Quantity, view_consumeditems.Description
from view_consumeditems
where PatientID = pid;
end;//

call p_PatientConsumedItems(1);

Delimiter //
create procedure p_PatientPaymentBills (in pid int)
begin
select view_consumeditems.ConsumeDate, view_consumeditems.ItemID, view_consumeditems.Quantity, view_consumeditems.UnitPrice, view_consumeditems.TotalPrice
from view_consumeditems
where PatientID = pid;
end;//

call p_PatientPaymentBills(1);

Delimiter //
create procedure p_findAllPatientsInACertainDate (in d Date)
begin
select patient.PatientID, patient.FirstName, patient.LastName
from patient
where patient.AdmitDate = d;
end;//

call p_findAllPatientsInACertainDate('2018-4-26');

Delimiter //
create procedure p_PhysicianAllPatients (in pid int)
begin
select patient.PatientID, patient.FirstName, patient.LastName, patient.AdmitDate, patient.OutPatient, patient.ResidentPatient
from patient
where patient.PhyID = pid;
end;//

call p_PhysicianAllPatients(2);

Delimiter //
create procedure p_findAllReceivedTreatmentForAPatient (in pid int)
begin
select view_treatment.PatientFirstName, view_treatment.PatientLastName, view_treatment.Date, view_treatment.Time, view_treatment.Description as TreatmentDetails, view_treatment.Result
from view_treatment
where PatientID = pid;
end;//

call p_findAllReceivedTreatmentForAPatient(1);

Delimiter //
create procedure p_searchCertainCareCenterInfo (in cid int)
begin
select view_carecenterinfo.CcName, view_carecenterinfo.telephoneNumber as ContactPhoneNumber, view_carecenterinfo.BuildingName, view_carecenterinfo.employeeFirstName, view_carecenterinfo.employeeLastName
from view_carecenterinfo
where CcID = cid;
end;//

call p_searchCertainCareCenterInfo(1);

