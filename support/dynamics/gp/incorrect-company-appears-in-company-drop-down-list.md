---
title: Incorrect company appears in the Company drop-down list
description: Describes a problem in which an incorrect company appears in the Company drop-down list when you try to log on to Microsoft Dynamics GP. A resolution is provided.
ms.topic: troubleshooting
ms.reviewer: kyouells
ms.date: 03/13/2024
---
# An incorrect company appears in the Company drop-down list when you try to log on to Microsoft Dynamics GP

This article provides a solution to an issue where an incorrect company appears in the **Company** drop-down list when you try to log on to Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 968058

## Symptoms

When you try to log on to Microsoft Dynamics GP or Microsoft Business Solutions - Great Plains 8.0, an incorrect company appears in the **Company** drop-down list in the Company Login window. The incorrect company is either a duplicate of your company or a company that does not exist.

## Cause

This problem occurs because a duplicate record or an invalid record refers to the companies in the tables in the DYNAMICS database.

## Resolution

To resolve this problem, use one of the following methods.

### Method 1

If the incorrect company is a company that does not exist or a duplicate of an invalid company, use this method.

> [!NOTE]
>
> - The following ClearCompanys.sql script is a script to remove all entries in the DYNAMICS database that refer to the databases that no longer exist on the computer that is running Microsoft SQL Server.
> - Before you run this script to remove the company database from the tables in the DYNAMICS database, you must remove the company database from the computer that is running SQL Server.
> - Before you use this method, make sure that you have a complete backup copy of the database so that you can restore the database if a problem occurs.

To use this method, run the ClearCompanies.sql script to remove incorrect records that refer to companies from the DYNAMICS database. To do this, follow these steps:

1. Start the Support Administrator Console, Microsoft SQL Query Analyzer, or SQL Server Management Studio. To do this, use one of the following methods depending on the program that you are using.

    - Method 1: For SQL Server Desktop Engine

        If you are using SQL Server Desktop Engine (also known as MSDE 2000), start the Support Administrator Console. To do this, click **Start**, point to **All Programs**, point to **Microsoft Administrator Console**, and then click **Support Administrator Console**.

    - Method 2: For SQL Server 2000

        If you are using SQL Server 2000, start SQL Query Analyzer. To do this, click **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then click **Query Analyzer**.

    - Method 3: For SQL Server 2005

        If you are using SQL Server 2005, start SQL Server Management Studio. To do this, click **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005**, and then click **SQL Server Management Studio**.

    - Method 4: For SQL Server 2008

        If you are using SQL Server 2008, start SQL Management Studio. to do this, click **Start**, point to **All Programs**, point to **Microsoft SQL Server 2008**, and then click **SQL Server Management Studio**.  

2. Run the following ClearCompanies.sql script:

    ```SQL
    set nocount on
    
    /* Remove all references in the company master table (table SY01500) for databases that do not exist on the Microsoft SQL Server server. */
    delete DYNAMICS..SY01500 where INTERID not in
     (select name from master..sysdatabases)
    
    /* Remove the tables from the DYNAMICS database if the CMPANYID value of the table does not match any company IDs in table SY01500. */
    USE DYNAMICS
    declare @CMPANYID char(150)
    declare CMPANYID_Cleanup CURSOR for 
    select 'delete ' + o.name + ' where CMPANYID not in (0,-32767)'
    + ' and CMPANYID not in (select CMPANYID from DYNAMICS..SY01500)' 
     from sysobjects o, syscolumns c
    whereo.id = c.id
     and o.type = 'U'
     and c.name = 'CMPANYID'
     and o.name <> 'SY01500' order by o.name
    
    OPEN CMPANYID_Cleanup
    FETCH NEXT from CMPANYID_Cleanup into @CMPANYID
    
    while (@@FETCH_STATUS <>-1)
    begin
    
    exec (@CMPANYID)
    FETCH NEXT from CMPANYID_Cleanup into @CMPANYID
    
    end
    
    DEALLOCATE CMPANYID_Cleanup
    go
    
    /* Remove the tables from the DYNAMICS database if the companyID value of the table does not match any company IDs in table SY01500. */
    USE DYNAMICS
    declare @companyID char(150)
    declare companyID_Cleanup CURSOR for 
    select 'delete ' + o.name + ' where companyID not in (0,-32767)'
    + ' and companyID not in (select CMPANYID from DYNAMICS..SY01500)' 
     from sysobjects o, syscolumns c
    whereo.id = c.id
     and o.type = 'U'
     and c.name = 'companyID'
     and o.name <> 'SY01500'
    set nocount on
    OPEN companyID_Cleanup
    FETCH NEXT from companyID_Cleanup into @companyID
    while (@@FETCH_STATUS <>-1)
    begin
    
    exec (@companyID)
    FETCH NEXT from companyID_Cleanup into @companyID
    
    end
    
    DEALLOCATE companyID_Cleanup
    go
    
    /* Remove the tables from the DYNAMICS database if the db_name value of the table does not match any company names (INTERID) in table SY01500. */
    USE DYNAMICS
    declare @db_name char(150)
    declare db_name_Cleanup CURSOR for 
    select 'delete ' + o.name + ' where db_name <> ''DYNAMICS'' and db_name <> ''''
     and db_name not in (select INTERID from DYNAMICS..SY01500)' 
     from sysobjects o, syscolumns c
    whereo.id = c.id
     and o.type = 'U'
     and c.name = 'db_name'
    
    set nocount on
    OPEN db_name_Cleanup
    FETCH NEXT from db_name_Cleanup into @db_name
    
    while (@@FETCH_STATUS <>-1)
    begin
    
    exec (@db_name)
    FETCH NEXT from db_name_Cleanup into @db_name
    
    end
    
    DEALLOCATE db_name_Cleanup
    GO
    set nocount on
    
    /* Remove the tables from the DYNAMICS database if the dbname value of the table does not match any company names (INTERID) in table SY01500. */
    USE DYNAMICS
    declare @dbname char(150)
    declare dbname_Cleanup CURSOR for 
    select 'delete ' + o.name + ' where DBNAME <> ''DYNAMICS'' and DBNAME <> ''''
     and DBNAME not in (select INTERID from DYNAMICS..SY01500)' 
     from sysobjects o, syscolumns c
    whereo.id = c.id
     and o.type = 'U'
     and c.name = 'DBNAME'
    
    set nocount on
    OPEN dbname_Cleanup
    FETCH NEXT from dbname_Cleanup into @dbname
    
    while (@@FETCH_STATUS <>-1)
    begin
    
    exec (@dbname)
    FETCH NEXT from dbname_Cleanup into @dbname
    
    end
    
    DEALLOCATE dbname_Cleanup
    GO
    set nocount on
    
    /* Remove all stranded references from the other Business Alerts table that do not exist in table SY40500. */
    delete SY40502 where BARULEID NOT IN (SELECT BARULEID FROM SY40500)
    delete SY40503 where BARULEID NOT IN (SELECT BARULEID FROM SY40500)
    delete SY40504 where BARULEID NOT IN (SELECT BARULEID FROM SY40500)
    delete SY40505 where BARULEID NOT IN (SELECT BARULEID FROM SY40500)
    delete SY40506 where BARULEID NOT IN (SELECT BARULEID FROM SY40500)
    GO
    ```

3. Log on to Microsoft Dynamics GP or Microsoft Great Plains 8.0 again.

### Method 2

If the incorrect company is a duplicate of a valid company, use this method to reconcile the User-Company Access table. To do this, follow these steps:

1. Log on to Microsoft Dynamics GP or to Microsoft Great Plains 8.0 as the sa user.
2. In the Company Login window, click the company that you want to use in the **Company** drop-down list, and then click **OK**.
3. Use the appropriate method:

    - In Microsoft Dynamics GP 10.0, click **Microsoft Dynamics GP**, click **Tools**, click **Utilities**, click **System**, and then click **Reconcile**.

    - In Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0, click **Tools**, click **Utilities**, click **System**, and then click **Reconcile**.

4. In the Reconcile window, click **User-Company Access** in the **Tables** pane, and then click **Insert**. After you do this, the **User-Company Access** table appears in the **List to Reconcile** pane.

5. Click **Reconcile**.

6. In the Report Destination window, click to select one or more of the following check boxes in the **Destination** area:

    - **Screen**  
    - **Printer**  
    - **File**

7. Click **OK**.

8. Exit Microsoft Dynamics GP or Microsoft Business Solutions - Great Plains 8.0.

9. Log on to Microsoft Dynamics GP or Microsoft Business Solutions - Great Plains 8.0 again.
