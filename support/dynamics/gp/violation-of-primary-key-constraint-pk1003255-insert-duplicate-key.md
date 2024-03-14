---
title: Error in Receivables Management Inquiry window
description: Provides a solution to an error that may occur when you look up some customers in the Receivables Management Inquiry window.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "Violation of PRIMARY KEY constraint 'PK1003255' attempt to insert a duplicate key" error message in Receivables Management Inquiry window in Microsoft Dynamics GP

This article provides a solution to an error that may occur when you look up some customers in the Receivables Management Inquiry window.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 864730

## Symptoms

When you look up some customers in the Receivables Management Inquiry window, you may receive the following error message:

> Violation of PRIMARY KEY constraint 'pk1003255' attempt to insert a duplicate key.

## Cause

There is a duplicate record in Receivables Management violating a primary key on the table. The same record is in Work and Open, Open and History, or Work and History tables.

## Resolution

To solve this issue, follow these steps:

1. Identify duplicate records

    Identify duplicate records in the Receivables Management tables yourself. The tables are:

    - RM10301 - RM Sales Work File
    - RM10201 - Cash Receipts Work File
    - RM20101 - RM Open File
    - RM30101 - RM History File

    There is an Automated Solution available to perform this task titled "Receivables Duplicates".

    > [!NOTE]
    > The Automated Solution will only find and report any existing duplicate records between the tables. It will not correct the issue. You must determine which records are duplicates and then you must manually delete those records after researching which record is incorrect.

2. Delete duplicate records

    Once you have determined which records are duplicates, research them to determine which record is valid and manually delete the duplicated record using SQL Server Management Studio. If you want assistance deleting duplicated records, contact your Partner, Technical Support for Microsoft Dynamics at 1-8888-477-7877, or open a chargeable support case.
