---
title: Importing data into Human Resources module
description: Importing data in to the Human Resources module in Microsoft Dynamics GP.
ms.reviewer: theley 
ms.topic: troubleshooting
ms.date: 02/15/2024
---
# Importing data into the Human Resources module in Microsoft Dynamics GP

This article provides a solution to an issue where importing data in to the Human Resources module in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2856302

## Symptoms

This article contains more information about importing data into the Human Resources module in Microsoft Dynamics GP.

## Resolution

Here's a summary of the options:

### SQL Server Import

You can use the *SQL Server Import and Export Wizard* to import/append a SQL table from an Excel spreadsheet and it works for HR tables as well. In SQL Server Management Studio, right-click on the company database, and select **Tasks** and select **Import Data...** to open the wizard.

SQL Server Data Transformation Services:

Refer to [The SQL Server Import and Export Wizard how-to guide](https://searchsqlserver.techtarget.com/feature/The-SQL-Server-Import-and-Export-Wizard-how-to-guide).

### Table Import

Currently an option is to use Table Import to import data into the HR windows. Information on the window may be held in the SDK.

To gather information on importing into Microsoft Dynamics GP, you can refer to [How to use Table Import to import data into Microsoft Dynamics GP](https://support.microsoft.com/help/856667).

### eConnect

With Microsoft Dynamics GP, you can use eConnect to import *limited data* into HR using the following Human Resources schemas:

- HRApplicantEducationType
- HRApplicantInterviewType
- HRApplicantReferenceType
- HRApplicantSkillType
- HRApplicantTestType
- HRApplicantType
- HRApplicantWorkHistoryType
- HRCreateSkillSetType
- HRCreateTestType
- HRDeleteApplicantApplicationType
- HRDeleteApplicantEducationLineType
- HRDeleteApplicantEducationType
- HRDeleteApplicantInterviewType
- HRDeleteApplicantReferenceLineType
- HRDeleteApplicantReferenceType
- HRDeleteApplicantRequisitionType
- HRDeleteApplicantTestLineType
- HRDeleteApplicantTestType
- HRDeleteApplicantType
- HRDeleteApplicantWorkHistoryLineType
- HRDeleteApplicantWorkHistoryType
- HRDeleteRequistionType
- HRDeleteSkillSetLineType
- HRDeleteSkillSetType
- HRDeleteSkillType
- HRDeleteTestType
- HRRequisitionType
- HRSkillType

### Integration Manager

Integration Manager doesn't support importing information/data directly into the Human Resource module. Within IM, there's no destination available for Human Resource as it is considered a third party add-on within the Microsoft Dynamics GP system. So IM doesn't have a supported option to bring in transaction data into HR. However, you could use some of the IM features with Payroll to bring in some of the setup information as follows:

- IM could be used to bring in Employee Master Data directly into Payroll. Human Resources Management reads directly from the Payroll Employee Master data table (UPR00100) from Payroll.
- The main setup for Benefits and Deductions could be brought into Payroll with IM, and then use the HR Reconcile utility in Microsoft Dynamics GP to bring this setup data over to HR. There are HR Reconcile options for **Update Benefit Setup** and **Update Benefit Enrollment** to update HR with benefit/deduction setup and enrollment from the corresponding codes in Payroll.
