---
title: Cannot insert the value NULL into column error when billing service calls in Contract Administration
description: Describes steps to resolve the error message - Cannot insert the value NULL into column ACTCAL, table xxx.dbo.SVC00601, column does not allow nulls when you attempt to run the Service Call Billing process.
ms.reviewer: theley, Beckyber
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "Cannot insert the value NULL into column 'ACTCAL', table 'xxx.dbo.SVC00601'" error when billing service calls in Contract Administration

This article provides steps on how to resolve the error that occurs when you run the service call billing in Contract Administration for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2707968

## Symptoms

You receive the following error when you try to run the service call billing in Contract Administration for Microsoft Dynamics GP:

> [Microsoft][SQL Native Client][SQL Server]Cannot insert the value NULL into column 'ACTCAL', table 'xxx.dbo.SVC00601', column does not allow nulls. UPDATE fails.

## Cause

This message is typically due to a record in the SVC00601 table (SVC_Contract_Line) that has a blank contract number.

## Resolution

Find the blank record and remove it from the SVC00601.

1. Make a full backup and have all users exit Microsoft Dynamics GP.
2. Run the following script in SQL Server Management Studio against the company database.

    ```sql
    select * from SVC00600 where CONTNBR = ''
    select * from SVC00601 where CONTNBR = ''
    ```

3. If you receive results from step 2, delete those records using this script.

    ```sql
    delete SVC00600 where CONTNBR = ''
    delete SVC00601 where CONTNBR = ''
    ```
