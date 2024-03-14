---
title: Update the Inactive status
description: How to update the Inactive status for a Benefit/Deduction in mass in Human Resources.
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# How to update the Inactive status for a Benefit/Deduction in mass in Human Resources

This article describes how to update the Inactive status for a Benefit/Deduction in mass in Human Resources.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 3055314

## Symptoms

When you run the HR Reconcile utility for Update Benefit Setup and Update Benefit Enrollment, the gets created on the HR side even for Benefit and Deduction codes that are Inactive on the Payroll side. If you want to also set them to be inactive on the HR side, the only current functionality is to mark the code inactive in the HR Enrollment window *one employee at a time*. The main setup for the code doesn't have an Inactive field that to roll down, so there isn't functionality to do it in mass. How can you also set the Benefit/Deduction codes to be inactive on the HR side all at once?

## Cause

Current design to only update one employee/code at a time.

## Resolution

To inactivate the benefit and deduction codes in mass, run the below SQL scripts below against the company database in SQL Server Management Studio for the scenario that fits your needs:

*Before running any update script, it's always recommended to make a current backup copy of the company database first!

**Scenario 1**: DEDUCTIONS ONLY: The first script below will 'find' where the status code on the deduction on the HR side doesn't match the status code on the same code in the Payroll Deduction Master table, so you can view what codes don't match. Then run the second script to update the status on the HR side and the End Date, to match the status and End Date as stored on the Payroll side. Run these scripts against the company database to affect deduction codes only:

```sql
DEDUCTIONS:
---------------------------------------
Select a.EMPLOYID, a.deducton as 'Deduction', b.inactive as 'HR_Active', 
a.inactive as 'Payroll_Active', a.DEDENDDT as 'DED End date' 
from UPR00500 a
join BE010130 b
on a.EMPLOYID = b.EMPID_I
and a.DEDUCTON = b.BENEFIT
where a.INACTIVE <> b. inactive
---------------------------------------
update a set a.inactive = b.inactive, a.BNFENDDT = b.DEDENDDT
from BE010130 a
join UPR00500 b
on b.EMPLOYID = a.EMPID_I
and b.DEDUCTON = a.BENEFIT
where b.INACTIVE <> a.INACTIVE
-------------------------------
```

> [!IMPORTANT]
> The benefit and deduction codes may have the same code ID, and are stored in two different tables on the Payroll side (UPR00500 and UPR00600), however, they're stored together as one record in only one table on the HR side (BE010130). So take note what script you ran last as it will overwrite the status and End Date on the record in HR, and *will apply to both the benefit and deduction on the HR side*. So *if you have any instances where the deduction is inactive, but the benefit is active (or visa versa*), you will need to pay attention to what script you ran last. It is recommended for these situations to view the code in the front-end and activate back the one needed in the front-end.

**Scenario 2**: BENEFITS ONLY: The first script below will find where the status code on the benefit on the HR side doesn't match the status code on the same code in the Payroll Benefit Master table, so you can view what codes don't match. Then run the second script to 'update' the status on the HR side and the End Date, to match the status and End Date as stored on the Payroll side. Run these scripts against the company database to affect benefit codes only:

```sql
BENEFITS:
---------------------------------------
Select a.EMPLOYID, a.BENEFIT as 'Paycode', b.inactive as 'HR_inactive', 
a.inactive as 'Payroll_inactive', a.BNFENDDT as 'BEN End date' 
from UPR00600 a
join BE010130 b
on a.EMPLOYID = b.EMPID_I
and a. BENEFIT = b.BENEFIT
where a.INACTIVE <> b. inactive
---------------------------------------
update a set a.inactive = b.inactive, a.BNFENDDT = b.BNFENDDT 
from BE010130 a
join UPR00600 b
on b.EMPLOYID = a.EMPID_I
and b.BENEFIT = a.BENEFIT
where b.INACTIVE <> a.INACTIVE
--------------------------------------- 
```

> [!IMPORTANT]
> The benefit and deduction codes may have the same code ID, and are stored in two different tables on the Payroll side (UPR00500 and UPR00600), however, they are stored together as one record in only one table on the HR side (BE010130). So take note what script you ran last above as it will overwrite the status and End Date on the record in HR, and *will apply to both the benefit and deduction on the HR side*. So *if you have any instances where the benefit is inactive, but the deduction is active (or visa versa*), you'll need to pay attention to what script you ran last. It's recommended for these situations to view the code in the front-end and activate back the one needed in the front-end.

**Scenario 3**: ALL: Use this script if you know a code (benefit and deduction) is inactive on the Payroll side for 'all' employees, and you just want to update the status for all the employees enrolled in it on the HR side too: (The first script will find all records for that code, whether a benefit or deduction, where it isn't inactive on the HR side, and the second script will update the status for that code to be inactive for all employees enrolled in it on the HR side.)

```sql
Select * from BE010130 where BENEFITSTATUS_I <> '2' and BENEFIT = 'xxx'
---------------------------------------------------------------
update BE010130 set BENEFITSTATUS_I = '2' where BENEFIT = 'xxx'
```

Update the xxx placeholder for the benefit or deduction code that you would like to mark as inactive on the HR side.

> [!NOTE]
> This script just sets the INACTIVE status and does not update the Benefit/Deduction End Date on the HR side. Also refer to the note above in Scenario 2.

Benefit Status values mean:
1=active
2=inactive
3=waived

## More information

> [!NOTE]
> Only the Payroll side for the Benefit or Deduction is used in the payrun, so having the code active on the HR side does not affect the payrun at all.
