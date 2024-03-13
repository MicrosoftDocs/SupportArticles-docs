---
title: Stored Procedure smCleanupFilesBeforeLogin
description: Provides a solution to an error that occurs when you try to sign in to a company in Microsoft Great Plains or in Microsoft Dynamics GP.
ms.reviewer: theley, kyouells
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "Stored Procedure smCleanupFilesBeforeLogin returned the following results" Error message when you try to sign in to a company in Microsoft Great Plains or in Microsoft Dynamics GP

This article provides a solution to an error that occurs when you try to sign in to a company in Microsoft Great Plains or in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 849708

## Symptoms

When you try to sign in to a company in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains, you receive the following error message:
> Stored Procedure smCleanupFilesBeforeLogin returned the following results: DBMS: **XXX**, Great Plains: **XXX**  

## Cause

This problem may occur for any one of the following causes:

- Cause 1: The smCleanupFilesBeforeLogin stored procedure is damaged or missing. See [Resolution 1](#resolution-1).
- Cause 2: The DYNSA user isn't the database owner of the company database. See [Resolution 2](#resolution-2).
- Cause 3: The permissions for Microsoft Great Plains users who are part of the DYNGRP role in Microsoft SQL Server are incorrect. See [Resolution 3](#resolution-3).
- Cause 4: Records are stuck in the ACTIVITY table or in the SY00800 table. See [Resolution 4](#resolution-4).

## Resolution 1

> [!NOTE]
> Make sure that all users are logged off Microsoft Dynamics GP or Microsoft Great Plains before you follow these steps.

1. Start SQL Server Management Studio or Query Analyzer. To do it, follow the steps for the program that you use.
    - Microsoft SQL Server 2005, Microsoft SQL Server 2005 Express, or Microsoft SQL Server 2008
        1. Select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2008** or to **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio**.
            > [!NOTE]
            > The Connect to Server window opens.

        2. In the **Server name** box, type the name of the instance of SQL Server.
        3. In the **Authentication** list, select **SQL Authentication**.
        4. In the **User name** box, type **sa**.
        5. In the **Password** box, type the password for the sa user, and then select **Connect**.
    - Microsoft SQL Server 2000
        1. Select **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.
        2. Type the password for the sa user, and then select **OK**.
2. On the **File** menu, select **New**.
3. Select **Database Engine Query**.
4. Re-create the stored procedure. Then, run the script against the company database. The following files are available for download from the Microsoft Dynamics File Exchange Server.

    - [The script for Microsoft Dynamics GP 2010](https://mbs2.microsoft.com/fileexchange/?fileid=126d5922-43c0-4f3b-a02d-33b5bcca9e64)
    - [The script for Microsoft Dynamics GP 10.0](https://mbs2.microsoft.com/fileexchange/?fileid=a3792765-0deb-43cb-8db4-a620da3ee4c0)
    - [The script for Microsoft Dynamics GP 9.0](https://mbs2.microsoft.com/fileexchange/?fileid=0dc2a65d-8c06-4d41-b086-0ec8ee157bda)
    - [The script for Microsoft Business Solutions - Great Plains 8.0](https://mbs2.microsoft.com/fileexchange/?fileid=bb21a74f-aaa1-45c5-b85b-323b47dd680f)

Microsoft scanned these files for viruses. Microsoft used the most current virus-detection software that was available on the date that these files were posted. The files are stored on security-enhanced servers that help prevent any unauthorized changes to the files.

## Resolution 2

> [!NOTE]
> Make sure that all users are logged off Microsoft Dynamics GP or Microsoft Great Plains before you follow these steps.

1. Start SQL Server Management Studio or Query Analyzer. To do it, follow the steps for the program that you use.
   - Microsoft SQL Server 2005, Microsoft SQL Server 2005 Express, or Microsoft SQL Server 2008
        1. Select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2008** or to **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio**.
            > [!NOTE]
            > The Connect to Server window opens.

        2. In the **Server name** box, type the name of the instance of SQL Server.
        3. In the **Authentication** list, select **SQL Authentication**.
        4. In the **User name** box, type **sa**.
        5. In the **Password** box, type the password for the sa user, and then select **Connect**.
   - Microsoft SQL Server 2000
        1. Select **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.
        2. Type the password for the sa user, and then select **OK**.
2. On the **File** menu, select **New**.
3. Select **Database Engine Query**.
4. Use the following script to determine the database owner.

    ```sql
    sp_helpdb
    ```

    If the DYNSA user isn't listed as the database owner (db_owner) in the results, make the DYNSA user the owner of the database. To do it, run the following script against the wanted database.

    ```sql
    sp_changedbowner 'DYNSA' 
    ```

## Resolution 3

> [!NOTE]
> Make sure that all users are logged off Microsoft Dynamics GP or Microsoft Great Plains before you follow these steps.

1. Start SQL Server Management Studio or Query Analyzer. To do it, follow the steps for the program that you use.
   - Microsoft SQL Server 2005, Microsoft SQL Server 2005 Express, or Microsoft SQL Server 2008
        1. Select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2008** or to **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio**.
            > [!NOTE]
            > The Connect to Server window opens.

        2. In the **Server name** box, type the name of the instance of SQL Server.
        3. In the **Authentication** list, select **SQL Authentication**.
        4. In the **User name** box, type **sa**.
        5. In the **Password** box, type the password for the sa user, and then select **Connect**.
   - Microsoft SQL Server 2000
        1. Select **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.
        2. Type the password for the sa user, and then select **OK**.
2. On the **File** menu, select **New**.
3. Select **Database Engine Query**.
4. Run the following Grant.sql script against the DYNAMICS database and against all the company databases. This script gives the appropriate permissions to all Microsoft Great Plains users who are part of the DYNGRP role in SQL Server.

    ```sql
    /*Count : 1 */
    
    declare @cStatement varchar(255)
    
    declare G_cursor CURSOR for select 'grant select,update,insert,delete on [' + convert(varchar(64),name) + '] to DYNGRP' from sysobjects 
    where (type = 'U' or type = 'V') and uid = 1
    
    set nocount on
    OPEN G_cursor
    FETCH NEXT FROM G_cursor INTO @cStatement 
    WHILE (@@FETCH_STATUS <> -1)
    begin
    EXEC (@cStatement)
    FETCH NEXT FROM G_cursor INTO @cStatement 
    end
    DEALLOCATE G_cursor
    
    declare G_cursor CURSOR for select 'grant execute on [' + convert(varchar(64),name) + '] to DYNGRP' from sysobjects 
    where type = 'P' 
    
    set nocount on
    OPEN G_cursor
    FETCH NEXT FROM G_cursor INTO @cStatement 
    WHILE (@@FETCH_STATUS <> -1)
    begin
    EXEC (@cStatement)
    FETCH NEXT FROM G_cursor INTO @cStatement 
    end
    DEALLOCATE G_cursor
    ```

## Resolution 4

> [!NOTE]
> Make sure that all users are logged off Microsoft Dynamics GP or Microsoft Great Plains before you follow these steps.

1. Start SQL Server Management Studio or Query Analyzer. To do it, follow the steps for the program that you use.
   - Microsoft SQL Server 2005, Microsoft SQL Server 2005 Express, or Microsoft SQL Server 2008
        1. Select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2008** or to **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio**.
            > [!NOTE]
            > The Connect to Server window opens.

        2. In the **Server name** box, type the name of the instance of SQL Server.
        3. In the **Authentication** list, select **SQL Authentication**.
        4. In the **User name** box, type **sa**.
        5. In the **Password** box, type the password for the sa user, and then select **Connect**.
   - Microsoft SQL Server 2000
        1. Select **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.
        2. Type the password for the sa user, and then select **OK**.
2. On the **File** menu, select **New**.
3. Select **Database Engine Query**.
4. Run the following script to remove any records that are stuck in the ACTIVITY table and in the BATCH ACTIVITY table.

    ```sql
    DELETE DYNAMICS..ACTIVITY
    DELETE DYNAMICS..SY00800
    ```
