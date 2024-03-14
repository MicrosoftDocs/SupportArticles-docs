---
title: Error when you create a company by using Dynamics GP Utilities
description: Describes that you receive an error message when you create a company by using Microsoft Dynamics GP Utilities. Provides a resolution.
ms.topic: troubleshooting
ms.reviewer: theley, kyouells
ms.date: 03/13/2024
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# Error when you create a company by using Microsoft Dynamics GP Utilities: "Violation of PRIMARY KEY constraint 'PKSY60100'. Cannot insert duplicate key in object 'dbo.SY60100'"

This article provides a solution to an error that occurs when you create a company by using Microsoft Dynamics GP Utilities.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 871699

## Symptoms

When you create a company by using Microsoft Dynamics GP Utilities, you may receive the following error message:

> Violation of PRIMARY KEY constraint 'PKSY60100'. Cannot insert duplicate key in object 'dbo.SY60100'.

Additionally, you may receive the following error message in the Dexsql.log file:

> /*
>
> BEGIN  
DECLARE @stored_proc_name char(34)  
DECLARE @retstat int  
DECLARE @param2 int  
set nocount on  
SELECT @stored_proc_name = '**Database_name**.dbo.smGrantAccessForDboAndSa'  
EXEC @retstat = @stored_proc_name **Number**, @param2 OUT SELECT @retstat, @param2 set nocount on  
END
>
> /\* [Microsoft][SQL Native Client][SQL Server]Violation of PRIMARY KEY constraint 'PKSY60100'. Cannot insert duplicate key in object 'dbo.SY60100'.*/
>
> /\* [Microsoft][SQL Native Client][SQL Server]The statement has been terminated.*/

## Cause

This problem occurs because the database owner of the DYNAMICS database is not DYNSA. Additionally, the database owner may be the same as the current user. The smGrantAccessForDboAndSa stored procedure inserts two records into the SY_User_Company_Access_REL (SY60100) table. One record refers to the current user, and the other record refers to the database owner. Typically, the two users are sa and DYNSA. If the database owner for the DYNAMICS database is the same as the current user, the stored procedure tries to insert the same user two times. The second Insert statement generates the error message about the primary key violation.

## Resolution

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

1. Start the Support Administrator Console, Microsoft SQL Query Analyzer, or SQL Server Management Studio. To do this, use one of the following methods depending on the program that you are using.

    - For SQL Server 2000

        If you are using SQL Server 2000, start SQL Query Analyzer. To do this, click **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then click **Query Analyzer**.

    - For SQL Server 2005

        If you are using SQL Server 2005, start SQL Management Studio. To do this, click **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005**, and then click **SQL Server Management Studio**.

    - For SQL Server 2008 or 2008 R2

        If you are using SQL Server 2008, start SQL Server Management Studio. To do this, click **Start**, point to **All Programs**, point to **Microsoft SQL Server 2008 or 2008 R2**, and then click **SQL Server Management Studio**.

    - For SQL Server 2012

        If you are using SQL Server 2012, start SQL Management Studio. to do this, click **Start**, point to **All Programs**, point to **Microsoft SQL Server 2012**, and then click **SQL Server Management Studio**.  

2. Verify that the DYNSA user is the owner of the correct databases.

    To verify that the DYNSA user is the owner of the correct databases yourself, follow these steps:

      1. Run the following statement and make sure that DYNSA is listed as the owner for the DYNAMICS database and all Microsoft Dynamics GP companies.

          ```sql
          sp_helpdb
          ```

      2. If DYNSA is not listed as the owner of the Microsoft Dynamics GP databases, run the following statement against the databases that have to change the owner to DYNSA.

          ```sql
          sp_changedbowner 'DYNSA'
          ```

3. To delete the company from Microsoft Dynamics GP or from Microsoft Great Plains, follow these steps:

    1. Run the following statement.

          ```sql
          SELECT * FROM MASTER..SYSDATABASES
          ```

    2. If the database is listed in the results, delete the database by running the following statement.

          ```sql
          DROP DATABASE **XXX**
          ```

          > [!NOTE]
          > Replace **XXX** with the database name.

4. To delete the company reference from the tables, download and run the statement that is available at [this website](https://mbs2.microsoft.com/fileexchange/?fileid=d57c52af-2432-486d-9072-e1a1d60563bf).

5. Restart Microsoft Dynamics GP Utilities, and then try to create the company again.

## More information

For more information about how to create a Dexsql.log file for Microsoft Dynamics GP, click the following article number to view the article in the Microsoft Knowledge Base:

[850996](https://support.microsoft.com/topic/kb-850996-how-to-create-a-dexsql-log-file-to-troubleshoot-error-messages-in-microsoft-dynamics-gp-67f4d9e9-51dd-69a8-57d8-6625416e3cb1) How to create a Dexsql.log file for Microsoft Dynamics GP
