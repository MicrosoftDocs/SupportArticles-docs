---
title: Error when you post or print in Payables Management
description: Provides a solution to an error that occurs when you post or print in Payables Management.
ms.reviewer:
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# "Violation of Primary key" or "DBMS 2627" error messages when you post or print in Payables Management

This article provides a solution to an error that occurs when you post or print in Payables Management.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 852808

## Symptoms

When you try to post or you try to print in Payables Management in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains, you receive one of the following error messages:

- Error message 1

    > Violation of Primary key
- Error message 2

    > Error attempting to insert duplicates.

- Error message 3

    > DBMS 2627

## Cause

These errors occur after some type of posting interruption. Typically, a transaction is written to the history table. However, the interruption occurs before the transaction is removed from the work table or from the open table. Therefore, the transaction exists in both tables and violates the primary key fields of the table.

## Resolution

To resolve the problem, locate the duplicate records and then remove the appropriate record manually. This article is designed only to assist you in locating the duplicate records. If you need assistance in removing the problem records, you may contact Microsoft Technical Support or your Partner.

### Automated solution

Use the automated solution to identify the duplicate records in the Payables Management (PM) tables.

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

An Automated Solution script may be available to perform this task.

> [!NOTE]
>
> - The Automated Solution will report the duplicate records.
> - You should back up your company database before proceeding. You should also verify that the information in the History tables is correct and complete.
> - If the duplicate records are in history and also either the work or open tables, determine if the records in the history table are valid. If so, then remove the records from the work tables or from the open tables.
> - If the duplicate records are in both the work and open tables only, determine which record is valid and remove the other record. However, when removing the problem record, keep in mind that these tables share a distribution table which also must be modified.
> - If you require further assistance regarding this process, contact Technical Support for Microsoft Dynamics at 1-8888-477-7877 or open a chargeable support case.
