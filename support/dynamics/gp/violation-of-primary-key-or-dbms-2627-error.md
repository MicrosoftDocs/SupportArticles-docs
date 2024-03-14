---
title: Error when you post or print in Payables Management
description: Provides a solution to an error that occurs when you post or print in Payables Management in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "Violation of Primary key" or "DBMS 2627" error message when you post or print in Payables Management

This article provides a solution to an error that occurs when you post or print in Payables Management in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 852808

## Symptoms

When you try to post or print in Payables Management in Microsoft Dynamics GP, you receive one of the following error messages:

- Error message 1

  > Violation of Primary key

- Error message 2

  > Error attempting to insert duplicates.

- Error message 3

  > DBMS 2627

## Cause

These errors occur after some type of posting interruption. Typically, a transaction is written to the history table. However, the interruption occurs before the transaction is removed from the work table or the open table. Therefore, the transaction exists in both tables and violates the primary key fields of the table.

## Resolution

> [!IMPORTANT]
> Before you follow the instructions in this article, make sure that you have a complete backup of the database that you can restore if a problem occurs.

To resolve the problem, locate the duplicate records and remove the invalid records manually. If you need assistance removing the invalid records, contact your partner, or create a ticket with [Microsoft Support](https://support.microsoft.com/contactus/).

> [!NOTE]
>
> - You should back up your company database before proceeding. You should also verify that the information in the history tables is correct and complete.  
> - If the duplicate records are in the history table and also either the work table or open table, determine if the records in the history table are valid. If so, remove the records from the work table or the open table.  
> - If the duplicate records are only in the work and open tables, determine which record is valid, and remove the invalid records. When removing the invalid records, note that these tables share a distribution table that must also be modified.  
> - If you need further assistance regarding this process, contact your partner, or create a ticket with [Microsoft Support](https://support.microsoft.com/contactus/).
