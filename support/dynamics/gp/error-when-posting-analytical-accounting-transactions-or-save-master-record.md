---
title: Error when you post Analytical Accounting transactions or save a Master record in Microsoft Dynamics GP 
description: Describes a problem that occurs because the next value in the AAG00102 table has already been used in the applicable table that is causing the duplicate record.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Financial - Analytical Accounting
---
# Error when you try to post Analytical Accounting transactions or save a Master record in Microsoft Dynamics GP: Cannot insert duplicate key in object 'AAGXXXXX'

This article provides a solution to an error that occurs when you post Analytical Accounting transactions or save a Master record in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 897280

## Symptoms

When you try to post Analytical Accounting transactions in Microsoft Dynamics GP, you may receive the following error message:

> [Microsoft][ODBC SQL Server Driver][SQL Server]Violation of PRIMARY KEY contraint '**PKAAG30000**', cannot insert duplicate key in object '**AAG30003**'

> [!NOTE]
> In this error message, **AAG30000** is a placeholder for the table. The word "contraint" is a misspelling of "constraint."

The actual error message that you receive may contain one of the following tables:

- AAG00103
- AAG00500
- AAG00600
- AAG00601
- AAG00602
- AAG00603
- AAG00400
- AAG00401
- AAG00201
- AAG00310
- AAG00900
- AAG00901
- AAG00902
- AAG00903
- AAG10000
- AAG10001
- AAG10002
- AAG10003
- AAG20000
- AAG20001
- AAG20002
- AAG20003
- AAG30000
- AAG30001
- AAG30002
- AAG30003

## Cause

This problem occurs because the next available value (aaRowID) indicated for this table (aaTableID) in the AAG00102 table has already been used in the applicable table (or series of sub-tables).

For example, the '30000' table in the AAG00102 table will look at the AAG30000, AAG30001, AAG30002 and AAG30003 tables, so be careful to check all the tables in the series for the applicable table.

## Resolution

To work around this problem, use one of the following methods below to compare the highest used value in the AA table (and sub-tables) against the next available value stored in the AAG00102 table.

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

### Method 1: Use SQL Script to update values in AAG00102 for most AA tables

You can download a SQL script using the link below and run it in SQL Server Management Studio against the company database to automatically update the next available number stored in the AAG00102 table as compared to the last used value in the AA table. The script will look at the following tables:

[AAG10000, AAG20000, AAG30000, AAG00201, AAG00400, AAG00401, AAG00500, AAG00600, AAG00900, and AAG00903](https://mbs2.microsoft.com/fileexchange/?fileID=5b13dba3-4766-4c5d-8f6f-90962605302c)

So it looks at most of the AA tables, but not all, and not sub-tables for a series.

### Method 2: Manual method to research and update value in AAG00102 for one AA table at a time

1. Open SQL Server Management Studio. To do this, click **Start**, point to **Programs**, point to **Microsoft SQL Server version**, and then click **SQL Server Management Studio**.

2. In the **Connect to SQL Server** window, log in to SQL Server Management Studio by using your sa password.

3. Click on the New Query icon to open a query window and copy or type the following script in the query window. Execute against the company database.

    ```sql
    select MAX (aaGLHdrID) from AAG30000
    */Insert in the appropriate column/table for the aaGLHdrID and AAG30000 placeholders in the script.
    ```

4. Note the query results which will show the highest value last used in the table. (If the table has sub-tables, make sure to check the highest last used value in those as well.)

5. Type the following script in the query window and execute against the Dynamics database:

    ```sql
    select * from AAG00102 where CMPANYID = 'nnn'
    ```

    In this query, replace the **nnn** placeholder with the company ID. To find the company ID, type the following query in the query window.

    ```sql
    select * from SY01500
    ```

    Select the **DYNAMICS** database in the list at the top of the window, and then press F5.

6. Verify that the value in the **aaRowID** field for the **aaTableID** value of **30000** (or appropriate table) is equal to or greater than the value that you noted in step 4.

7. Use the following script to update the value. To do this, type the script below in the query window, and then press F5.

    ```sql
    update aag00102 set aaROWID = 'yyyy' where aaTableID = 30000 and CMPANYID = 'zzz'
    ```

    > [!NOTE]
    > In this script, replace the **yyyy** placeholder with the value that you noted in step 4. Replace the **zzz** placeholder with the company ID. Also replace the aaTableID with the appropriate table.
