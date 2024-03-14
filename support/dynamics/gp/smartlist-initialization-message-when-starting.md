---
title: SmartList initialization message occurs when starting
description: Explains how to resolve the prompt to initialize smartlist error message when you start Microsoft Dynamics GP.
ms.reviewer: theley, kyouells
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# You receive a SmartList initialization message when you start Microsoft Dynamics GP

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 898475

## Symptoms

When you start Microsoft Dynamics GP, you receive the following message:

> Initialization of SmartList was not completed successfully. Be sure you are logged into Microsoft Dynamics GP as the owner of the databases.

If you select **OK**, you receive the following error message:

> Initialization of SmartList was not completed successfully. Be sure you are logged into Microsoft Dynamics GP as the owner of the databases.

If you select **OK** again, you may receive the following message when you select the lookup button for Accounts in the Accounts Maintenance window:

> A get/change first operation on table 'ASI_MSTR_Explorer_Favorites' cannot find the table.

## Cause

This problem can have any of the following causes.

### Cause 1

The Pathname parameter in the Dex.ini file may be incorrect. See Resolution 1 in the Resolution section.

### Cause 2

Records may be missing from the SY02100 table in the Dynamics database. See Resolution 2 in the Resolution section.

### Cause 3

The Dynamics.dic file may not be synchronized with the account framework. See Resolution 3 in the Resolution section.

### Cause 4

The Open Database Connectivity (ODBC) connection may be incorrect or damaged. See Resolution 4 in the Resolution section.

### Cause 5

SmartList auto procedures may be incorrect or damaged. See Resolution 5 in the Resolution section.

## Resolution

### Resolution 1

To resolve this problem, verify the Pathname parameter in the Dex.ini file. To do this, follow these steps:

1. Locate the Dex.ini file on the computer. To locate the file, follow the appropriate step:

   - If you are using Microsoft Dynamics GP 10.0 or Microsoft Dynamics GP 2010, the Dex.ini is in the Data folder of the installation folder. By default the installation folder is C:\Program Files\Microsoft Dynamics\GP.
   - If you are using Microsoft Dynamics GP 9.0, the Dex.ini is in the installation folder. By default the installation folder is C:\Program Files\Microsoft Dynamics\GP.

2. Open the file in Notepad.
3. Verify that the parameter is as follows:

   Pathname=DYNAMICS/dbo/

### Resolution 2

To resolve this problem, verify the Dynamics database records in the SY02100 table. To do this, follow these steps:

1. Run the following statement.

    ```sql
    SELECT * FROM DYNAMICS..SY02100
    ```

    > [!NOTE]
    > If you are using Microsoft SQL Server, run the statement in SQL Query Analyzer. To open SQL Query Analyzer, select **Start**, point to **Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**. If you are using SQL Server Desktop Engine (MSDE), run the statement in Support Administrator Console. To open Support Administrator Console, select **Start**, point to **Programs**, point to **Microsoft Support Administrator Console**, and then select **Support Administrator Console**. The Support Administrator Console requires a separate installation. If you do not have Support Administrator Console installed, you can install it by using the Microsoft Dynamics GP installation CD.

2. In the results that are returned, make sure that you have at least seven records that contain the following:

    - DTAPTHNM=DYNAMICS/dbo/
    - CMPANYID=0

### Resolution 3

To resolve this problem, resynchronize the Dynamics.dic file to the account framework. To do this, follow these steps:

1. Locate the Dex.ini file on the computer. To locate the file, follow the appropriate step:

   - If you are using Microsoft Dynamics GP 10.0 or Microsoft Dynamics GP 2010, the Dex.ini is in the Data folder of the installation folder. By default the installation folder is C:\Program Files\Microsoft Dynamics\GP.
   - If you are using Microsoft Dynamics GP 9.0, the Dex.ini is in the installation folder. By default the installation folder is C:\Program Files\Microsoft Dynamics\GP.

2. Open the file in Notepad.
3. Change the Synchronize parameter as follows:

   Synchronize=TRUE

4. On the **File** menu, select **Save**.
5. On the **File** menu, select **Exit**.
6. To start the synchronization process, start Microsoft Dynamics GP Utilities. To do this, follow the appropriate step:

   - In Microsoft Dynamics GP 2010, select **Start**, point to **All Programs**, point to **Microsoft Dynamics**, point to **GP 2010**, and then select **GP Utilities**.
   - In Microsoft Dynamics GP 10.0, select **Start**, point to **All Programs**, point to **Microsoft Dynamics**, point to **GP 10.0**, and then select **GP Utilities**.
   - In Microsoft Dynamics GP 9.0, select **Start**, point to **All Programs**, point to **Microsoft Dynamics**, point to **GP 9.0**, and then select **GP Utilities**.

### Resolution 4

To resolve this problem, verify the current ODBC connection, or create a new ODBC connection that uses a new name. For more information, see [How to set up an ODBC Data Source on SQL Server for Microsoft Dynamics GP](https://support.microsoft.com/topic/how-to-set-up-an-odbc-data-source-on-sql-server-for-microsoft-dynamics-gp-06f8c9e7-7493-1b91-d764-318910ebb9e5).

### Resolution 5

To resolve this issue, you will need to re-create the auto procedures for SmartList. To do this, follow these steps:

> [!NOTE]
> You should have valid backups of your GP databases before you proceed.

1. In Microsoft Dynamics GP, open the SQL maintenance window. To do this, follow these steps:

   - Select **Microsoft Dynamics GP**.
   - Point to **Maintenance**.
   - Select **SQL**.
2. With the SQL Maintenance window open, use the following options to populate the SmartList SQL objects:

   - Database: DYNAMICS.
   - Product: SmartList.
3. With the SmartList objects populated, select all items listed.
4. With all items selected, check the boxes for the following actions:

   - Drop Auto Procedure.
   - Create Auto Procedure.
5. Select **Process**.
