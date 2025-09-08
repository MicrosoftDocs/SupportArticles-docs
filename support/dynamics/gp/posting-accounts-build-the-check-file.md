---
title: Posting accounts to build the check file
description: Lists the posting accounts that are required to build the check file in Payroll in Microsoft Dynamics GP.
ms.reviewer: theley
ms.date: 04/17/2025
ms.custom: sap:Payroll
---
# Required posting accounts to build the check file in Payroll in Microsoft Dynamics GP

This article lists the posting accounts that are required to build the check file in Payroll in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 871962

## Introduction

If these accounts don't exist in the Payroll Posting Accounts setup, you'll get the critical error in the build check file report:

> Posting account is not set up for deduction code.  
Posting account is not set up for benefit expense.  
Posting account is not set up for benefit payable.  
Posting account is not set up for pay code.  
Posting account is not set up for gross pay.  
Posting account is not set up for federal tax withholding.  
Posting account is not set up for state tax withholding.  
Posting account is not set up for taxable benefit expense.  
Posting account is not set up for taxable benefit payable.

## More information

The build process looks for any **ALL ALL** posting accounts for all payroll account types, even if you don't use these account types. Make sure that all the types that are listed in the following table exist.

|Payroll Account Type|Department|Job|Code|
|---|---|---|---|
|Gross Pay (DR)|ALL|ALL|ALL|
|Federal Tax Withholding (CR)|ALL|ALL|FED|
||ALL|ALL|EFIC/S|
||ALL|ALL|EFIC/M|
||ALL|ALL|FICA/S|
||ALL|ALL|FICA/M|
|State Tax Withholding (CR)|ALL|ALL|ALL|
|Local Tax Withholding (CR)|ALL|ALL|ALL|
|Deduction Withholding (CR)|ALL|ALL|ALL|
|Employer's Tax Expense (DR)|ALL|ALL|FIC/SE|
||ALL|ALL|FIC/ME|
||ALL|ALL|FUTA|
||ALL|ALL|SUTA|
|Benefit Expense (DR)|ALL|ALL|ALL|
|Benefit Payable (CR)|ALL|ALL|ALL|
|Taxable Benefit Expense (DR)|ALL|ALL|ALL|
|Taxable Benefit Payable (CR)|ALL|ALL|ALL|
|SUTA Payable (CR)|ALL|ALL|ALL|
|FUTA Payable (CR)|ALL|ALL|FUTA|
|W/Comp Tax Expense (DR)|ALL|ALL|ALL|
|W/Comp Tax Payable (CR)|ALL|ALL|ALL|
  
  You can also try to run the **check links** process against the Account Master file in the Financial series.

> [!NOTE]
> These payroll account types should have a **Job** value and a **Department** value of **ALL**. This condition makes sure that no departments or jobs are missed or are added later. Even if a job and a department are set up for all the listed payroll account types, the generic **ALL ALL** types must also exist.
