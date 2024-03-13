---
title: Use BCP to export Dynamics GP data
description: Discusses how to use the Bulk Copy Process (BCP) to export Microsoft Dynamics GP data from one database and import data into a new database.
ms.reviewer:
ms.topic: how-to
ms.date: 03/13/2024
---
# How to use the Bulk Copy Process (BCP) to export Microsoft Dynamics GP data from one database and import data into a new database

This article discusses how to use the Bulk Copy Process (BCP) to export data and to import data by using Microsoft Dynamics GP or Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 875179

## Introduction

1. Make a backup of your company database.
2. Copy and paste the following CreateBulkCopyOut.sql script into Microsoft SQL Query Analyzer.

    ```sql
    /* Script to create bcp commands to export data for all tables. */ SET QUOTED_IDENTIFIER OFF select 'bcp "TWO..' + name + '" out ' + name + '.out -e ' + name + '.err -c -b 1000 -U sa -P password -t "|" -S SERVERNAME -r "#EOR#\n"' from sysobjects where type = 'U' order by name
    ```

    In the script, replace the following placeholders with the correct information:
    - Replace **TWO** with the name of your company database.
    - Replace **password** with your sa password.
    - Replace **SERVERNAME** with the name of your instance of Microsoft SQL Server.

        > [!NOTE]
        > To open Query Analyzer, select **Start**, point to **Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.

        > [!NOTE]
        > If you're using Microsoft SQL Server 2000 Desktop Engine (also known as MSDE 2000), run the statement in Microsoft Support Administrator Console. To open Support Administrator Console, select **Start**, point to **Programs**, point to **Microsoft Support Administrator Console**, and then select **Support Administrator Console**. Support Administrator Console requires a separate installation. You can install the program by using the Great Plains installation CD number 2.
3. Run the script against the database and then save the results to a batch file. To do it, follow these steps:
   - If you're using Query Analyzer, select the **results** pane, and then select **Save As** on the **File** menu. Create a folder named **BCPData**, name this file *Copyout.bat*, and then select **Save**.
   - If you're using Support Administrator Console, select **File**, and then select **Export**. Create a folder and name it **BCPData**. Name the file *Copyout.bat*. Then select **Save**.
4. Copy and paste the following CreateBulkCopyIn.sql script into Query Analyzer.

    ```sql
    /* Script to create bcp commands to import data for all tables. */ SET QUOTED_IDENTIFIER OFF select 'bcp "TWO..' + name + '" in ' + name + '.out -e ' + name + '.err -c -b 1000 -U sa -P password -t "|" -S SERVERNAME -r "#EOR#\n"' from sysobjects where type = 'U' order by name
    ```

    In the script, replace the following placeholders with the correct information:
    - Replace **TWO** with the name of your company database.
    - Replace **password** with your sa password.
    - Replace **SERVERNAME** with the name of your instance of SQL Server.

        > [!NOTE]
        > To open Query Analyzer, select **Start**, point to **Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.

        > [!NOTE]
        > If you're using SQL Server 2000 Desktop Engine, run the statement in Support Administrator Console. To open Support Administrator Console, select **Start**, point to **Programs**, point to **Microsoft Support Administrator Console**, and then select **Support Administrator Console**. Support Administrator Console requires a separate installation. You can install the program by using the Great Plains installation CD number 2.
5. Run the script against the database and then save the results to a batch file.
   - If you're using Query Analyzer, select the **results** pane, and then select **Save As** on the **File** menu. Create a folder and name it **BCPData**. Name the file Copyin.bat, and then select **Save**.
   - If you're using Support Administrator Console, select **File** and then select **Export**. Create a folder and name it **BCPData**. Name the file *Copyin.bat*. Then select **Save**.
6. Do a bcp command to move the data out of the company database. To do it, use the appropriate method.
   - For Microsoft SQL Server 2000 or MSDE 2000
      1. Open the BCPData folder.
      2. Double-click the *Copyout.bat* file.

         > [!NOTE]
         > The batch file starts the BCP process to copy the data from the database to a text file.

      3. Open the BCPData folder.
      4. Right-click the *Copyout.bat* file, and then select Edit to open the file in Notepad or in another text editor
      5. Select all the text. To do it, select **Edit**, and then select **Select All**. Or, press Alt+A.
      6. Copy all the text from the *Copyout.bat* file to the Clipboard. To do it, select **Edit**, and then select **Copy**. Or, press Ctrl+C.
      7. Open a Command Prompt window. To do it, select **Start**, select **Run**, type **cmd**, and then select **OK**.
      8. Paste the contents of the *Copyout.bat* file into the Command Prompt window. To do it, right-click the window, and then select **Paste**.

   - For Microsoft SQL Server 2005
       1. Open the BCPData folder.
       2. Double-click the *Copyout.bat* file.

            > [!NOTE]
            > The batch file starts the BCP process to copy the data from the database to a text file.
7. Delete the company from within Microsoft Dynamics GP. To do it, sign into Great Plains as the sa user. Select **Tools**, point to **Setup**, point to **System** and then select **Company**. Select the lookup glass to display all the companies listed. Select the company and then select **Delete**.

    > [!NOTE]
    > For versions of Microsoft Great Plains that are earlier than Microsoft Great Plains 8.0, delete the company. To delete the company, do the following: On the Setup menu, select **System**, and then select **Company** to delete the company.
8. Remove the database.
   - If you're using Microsoft SQL Server, open Enterprise Manager, expand the server name, expand **Database**, right-click the company database that you deleted in step 7, and then select **Delete**.
   - If you're using SQL Server 2000 Desktop Engine, remove the database from within Support Administrator Console by running the following script, where **TWO** is the name of the database.

        ```sql
        DROP DATABASE TWO
        ```

9. Re-create the company database and procedures. To do it, start Microsoft Dynamics GP Utilities, sign in as the sa user, and then select **Create new company** in the **Additional Tasks** dialog box.

    > [!NOTE]
    > Use the same company name as the one that you deleted in step 7.
10. After the company is created, the tables must be truncated.

    - If you're using Microsoft SQL Server, run the following Truncate_Table_Company.sql script in Query Analyzer.

        ```sql
        /* Script to remove all data from all user tables in the company database */ SET QUOTED_IDENTIFIER OFF if exists (select * from sysobjects where name = 'RM_NationalAccounts_MSTR_FKC') ALTER TABLE dbo.RM00105 DROP CONSTRAINT RM_NationalAccounts_MSTR_FKC Go declare @tablename char(255) DECLARE t_cursor CURSOR for select "truncate table " + name from sysobjects where type = 'U' set NOCOUNT on open t_cursor FETCH NEXT FROM t_cursor INTO @tablename while (@@fetch_status <> -1) begin if (@@fetch_status <> -2) begin exec (@tablename) end FETCH NEXT FROM t_cursor into @tablename end DEALLOCATE t_cursor GO ALTER TABLE dbo.RM00105 ADD CONSTRAINT RM_NationalAccounts_MSTR_FKC FOREIGN KEY ( CPRCSTNM ) REFERENCES dbo.RM00101 ( CUSTNMBR ) GO
        ```

    - If you're using SQL Server 2000 Desktop Engine, run the following scripts separately in the Support Administrator console.

        **Script 1**

        ```sql
        SET QUOTED_IDENTIFIER OFF if exists (select * from sysobjects where name = 'RM_NationalAccounts_MSTR_FKC') ALTER TABLE dbo.RM00105 DROP CONSTRAINT RM_NationalAccounts_MSTR_FKC
        ```

        **Script 2**

        ```sql
        SET QUOTED_IDENTIFIER OFF declare @tablename char(255) DECLARE t_cursor CURSOR for select "truncate table " + name from sysobjects where type = 'U' set NOCOUNT on open t_cursor FETCH NEXT FROM t_cursor INTO @tablename while (@@fetch_status <> -1) begin if (@@fetch_status <> -2) begin exec (@tablename) end FETCH NEXT FROM t_cursor into @tablename end DEALLOCATE t_cursor
        ```

        **Script 3**

        ```sql
        ALTER TABLE dbo.RM00105 ADD CONSTRAINT RM_NationalAccounts_MSTR_FKC FOREIGN KEY ( CPRCSTNM ) REFERENCES dbo.RM00101 ( CUSTNMBR )
        ```

11. Move the data back into the company database. To do it, open the **BCPData** folder, and then double-click the **Copyin.bat** batch file. Running this batch file starts the process of moving the data back into the company database. When the data is moved back into the database, all indexes are created and verified for each table.

    > [!NOTE]
    > When the process is completed, the BCPData folder will contain .err files. If any one of these .err files is larger than 0 KB, the data was not imported for the company database successfully.

## More steps

If you're using the BCP process to change your Microsoft SQL Server Sort Order, you must bulk copy data out of the DYNAMICS database and all Company databases.

> [!NOTE]
> Changing the Microsoft SQL Server Sort Order for the DYNAMICS database and for the Company database isn't supported by Microsoft. For information about consulting services that may be available to change the Microsoft SQL Server Sort Order for you, use one of the following options, depending on whether you're a customer or a partner:

Customers:  
For more information about data manipulation consulting services, contact your partner of record. If you don't have a partner of record, visit [Microsoft Pinpoint](https://www.microsoft.com/solution-providers/home) to identify a partner.

Partners:  
For more information about data manipulation consulting services, contact Microsoft Advisory Services at 800-MPN-SOLVE.

To do it, follow steps 1 through 11 in the [Introduction](#introduction) section. In step 10, you must also truncate the DYNAMICS database. To do it, use one of the following methods:

- If you're using Microsoft SQL Server, run the following Truncate_Tables_Dynamics.sql script in Query Analyzer.

    ```sql
    /* ** **
    Truncate_Tables_Dynamics.sql 
    function: Will remove all data from all user tables in the DYNAMICS database
     ** */ 
    
    SET QUOTED_IDENTIFIER OFF 
    
    if exists (select * from sysobjects where name = 'orgEntity_SETP')
    ALTER TABLE dbo.ORG40100
    DROP CONSTRAINT orgEntity_SETP
    GO
    if exists (select * from sysobjects where name = 'orgRelation_MSTR')
    ALTER TABLE dbo.ORG00100
    DROP CONSTRAINT orgRelation_MSTR
    Go
    declare @tablename char(255) 
    
    DECLARE t_cursor CURSOR for
    select "truncate table " + name
    from sysobjects where type = 'U'
    
    set NOCOUNT on
    open t_cursor
    FETCH NEXT FROM t_cursor INTO @tablename
    while (@@fetch_status <> -1)
    begin
    if (@@fetch_status <> -2)
    begin
    exec (@tablename)
    end 
    
    FETCH NEXT FROM t_cursor into @tablename
    end
    
    DEALLOCATE t_cursor
    GO
    ALTER TABLE dbo.ORG40100 ADD 
    CONSTRAINT orgEntity_SETP FOREIGN KEY 
    (
    ENTYLVL
    ) REFERENCES dbo.ORG40000 (
    ENTYLVL
    )
    GO
    ALTER TABLE dbo.ORG00100 ADD 
    CONSTRAINT orgRelation_MSTR FOREIGN KEY 
    ( ENTITYID ) REFERENCES dbo.ORG40100 ( ENTITYID )

    GO 
    ```

- If you're using Microsoft SQL Server 2000 Desktop Engine, run the following scripts separately in the Support Administrator console.
  - Script 1

      ```sql
      if exists (select * from sysobjects where name = 'orgEntity_SETP') ALTER TABLE dbo.ORG40100 DROP CONSTRAINT orgEntity_SETP
      ```

  - Script 2

      ```sql
      if exists (select * from sysobjects where name = 'orgRelation_MSTR') ALTER TABLE dbo.ORG00100 DROP CONSTRAINT orgRelation_MSTR
      ```

  - Script 3

      ```sql
      declare @tablename char(255) 
      
      DECLARE t_cursor CURSOR for
      select "truncate table " + name
      from sysobjects where type = 'U'
      
      set NOCOUNT on
      open t_cursor
      FETCH NEXT FROM t_cursor INTO @tablename
      while (@@fetch_status <> -1)
      begin
      if (@@fetch_status <> -2)
      begin
      exec (@tablename)
      end 
      
      FETCH NEXT FROM t_cursor into @tablename
      end
      
      DEALLOCATE t_cursor
      ```

  - Script 4

      ```sql
      ALTER TABLE dbo.ORG40100 ADD 
      CONSTRAINT orgEntity_SETP FOREIGN KEY 
      (
      ENTYLVL
      ) REFERENCES dbo.ORG40000 (
      ENTYLVL
      )
      ```

  - Script 5

      ```sql
      ALTER TABLE dbo.ORG00100 ADD 
      CONSTRAINT orgRelation_MSTR FOREIGN KEY 
      ( ENTITYID ) REFERENCES dbo.ORG40100 ( ENTITYID )
      ```
