---
title: An incorrect RECON batch is created
description: Provides a solution to an issue where an incorrect RECON batch is created in Payroll when you reconcile attendance transactions in Human Resources in Microsoft Dynamics GP.
ms.reviewer: lmuelle, theley
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Payroll
---
# An incorrect RECON batch is created in Payroll when you reconcile attendance transactions in Human Resources in Microsoft Dynamics GP

This article provides a solution to an issue where an incorrect RECON batch is created in Payroll when you reconcile attendance transactions in Human Resources in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 919346

## Symptoms

When you reconcile attendance transactions in Human Resources in Microsoft Dynamics GP, an incorrect RECON batch is created in Payroll in Microsoft Dynamics GP. The batch includes transactions that were created in Human Resources in a prior pay period.

## Cause

This problem occurs because the reconcile process incorrectly includes human resource transactions from the TATX1030 table that have an ATTTRXSTATUS value of 1 and of 3.

## Resolution

To resolve this problem, obtain the latest service pack for Microsoft Dynamics GP 9.0.

## Status

Microsoft has confirmed that it's a problem in the Microsoft products that are listed in the Applies to section. This problem was first corrected in Microsoft Dynamics GP 9.0 Service Pack 1.

## More information

> [!NOTE]
> Before you follow the instructions in this article, make sure that you've a complete backup copy of the database that you can restore if a problem occurs.

To remove the incorrect RECON batch, run the following script against your company database.

> [!NOTE]
> To run the following script, use SQL Query Analyzer in Microsoft SQL Server. If you're using Microsoft SQL Server Desktop Engine (also known as MSDE 2000), use the Support Administrator Console.

```sql
DELETE FROM UPR10301 WHERE BACHNUMB ='RECON'
DELETE FROM UPR10302 WHERE BACHNUMB ='RECON'
```
