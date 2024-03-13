---
title: Cannot insert the value NULL into column
description: Provides a solution to an error that occurs when you try to post a journal entry that contains Analytical Accounting assignments in Microsoft Dynamics GP.
ms.reviewer: theley, lmuelle
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "Cannot insert the value NULL into column 'aatrxsource' table" Error message when you try to post a journal entry that contains Analytical Accounting assignments in Microsoft Dynamics GP

This article provides a solution to an error that occurs when you try to post a journal entry that contains Analytical Accounting assignments in Microsoft Dynamics GP.

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 936298

## Symptoms

When you try to post a journal entry that contains Analytical Accounting assignments in Microsoft Dynamics GP, you receive the following error message:

> Cannot insert the value NULL into column 'aatrxsource' table TRIAL.dbo. AAG30000 column does not allow nulls. Insert fails.  
The stored procedure aagCreateRecordsInaaGL returned the following results: DBMS: 515.

## Cause

This problem occurs because an Analytical Accounting record is missing in the SY01000 table for the Transaction Source code.

## Resolution

To resolve this problem, insert the missing record in each company database. To do it, follow these steps:

1. First, make a backup copy of the company database:
    1. On the **File** menu, select **Backup**.
    2. In the **Back Up Company** dialog box, select the company that you want to back up in the **Company Name** list.
    3. In the **Select the backup file** list, select the location where you want to save the backup file, and then select **OK**.
2. Next, run the following script in SQL Server Management Studio against the company database to insert the missing record:

    ```sql
    insert into SY01000 VALUES (0,2,0,'Analytical Accounting','AATRX',1,'')
    ```

> [!NOTE]
> If you're using Microsoft SQL Server, run the script in SQL Server Management Studio against the company database. To open it, select **Start**, point to **Programs**, point to **Microsoft SQL Server XXXX** (where xxxx is the SQL Server version), and then select **SQL Server Management Studio**. Select the **New Query** button in the top menubar, and select the company database from the drop-down list at the top. Copy in the script above and select the **Execute** button (or press F5) to run the script.
