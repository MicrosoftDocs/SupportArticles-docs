---
title: GPS Error 54 SQL Error 2601 or ODBC Error 2300 when running Fixed Assets GL Posting
description: This article addresses the error messages when running Fixed Assets GL Posting for the first time after upgrading to Microsoft Dynamics GP 2013.
ms.reviewer: cwaswick
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# "GPS Error: 54", " SQL Error 2601", or "ODBC Error: 2300" when running Fixed Assets to GL Posting after upgrading to Dynamics GP 2013

This article provides a resolution for the error messages that may occur when running Fixed Assets to GL Posting after you upgrade to Microsoft Dynamics GP 2013.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2930489

## Symptoms

After migrating to Microsoft Dynamics GP 2013, you receive all of the following error messages when running GL Posting:

> An error occurred executing the SQL Statements.

> GPS Error: 54

> SQL Error: 2601 [Microsoft][SQL Server Native Client 10.0][SQL Server]Cannot insert duplicate key row in object 'dbo.FA00905' with unique index 'AK2FA00905'. The duplicate key value is (120151(.

> ODBC Error: 23000

## Cause

This issue has not been able to be recreated in-house, and therefore no cause has been identified to date. However, all customers experiencing this have just upgraded to Microsoft Dynamics GP 2013. The problem itself deals with the new functionality added to the FA00905 where, when any data is brought into this table by selecting **Process** in the GL Posting window, the data should have the `GLINTBTCHNUM` field in the FA00905 table populated with the FATRX Batch ID that was showing in the GL Posting window prior to selecting **Process**. For this issue, the `GLINTBTCHNUM` field in the FA00905 is blank for the transactions added into this table.

## Resolution

To resolve this issue, you need to remove the corrupted data from the FA00905 table where the `GLINTBTCHNUM` is blank. If you test the usage of this table in Microsoft Dynamics GP 2013, you will see the `GLINTBTCHNUM` field for the records in the FA00905 table is populated with the Batch ID from the GL Posting window at the time Process  was clicked.

1. To view the corrupted records, run the following select statement against the company database in SQL Server Management Studio:

    ```sql
    select * from FA00905 where GLINTBTCHNUM = '' 
    /*two single apostrophes denote a blank entry*/
    ```

2. If the records returned in step 2 are all damaged records and need to be removed, run the following delete statement against the company database in SQL Server Management Studio:

    ```sql
    delete FA00905 where GLINTBTCHNUM = '' 
    /*two single apostrophes denote a blank entry*/
    ```

3. Now rerun the GL Posting process and the issue should be resolved.
