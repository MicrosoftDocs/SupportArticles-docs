---
title: A Get Change First operation on table SY Users MSTR failed accessing SQL data error when you start Microsoft Dynamics GP
description: Describes an error message that you receive when you start Microsoft Dynamics GP or Microsoft Business Solutions - Great Plains 8.0. Provides a resolution.
ms.reviewer: kyouells
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "A Get/Change First operation on table SY_Users_MSTR failed accessing SQL data" error when you start Microsoft Dynamics GP

This article provides a resolution for the **A Get/Change First operation on table SY_Users_MSTR failed accessing SQL data** error that may occurs when you start Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 860468

## Symptoms

When you start Microsoft Dynamics GP or Microsoft Business Solutions - Great Plains, you receive the following error message:

> A Get/Change First operation on table SY_Users_MSTR failed accessing SQL data

## Resolution

To resolve this problem, follow these steps:

1. Verify that you are using the correct Open Database Connectivity (ODBC) system data source name (DSN). To do this, follow these steps:
   1. In Control Panel, open **Administrative Tools**.
   2. Double-click **Data Sources (ODBC)**.
   3. Select the **System DSN** tab.
   4. Select the name of the ODBC data source that you use for Microsoft Dynamics GP or for Microsoft Business Solutions - Great Plains.
   5. Select **Configure**.

   The server in the **Server** field is the computer on which the Microsoft Dynamics GP databases or the Microsoft Business Solutions - Great Plains databases reside. Compare this server to the server in the **Server** field on another workstation on which no problem occurs.

2. Set up a new ODBC DSN.

    For more information about how to set up a new ODBC DSN, see [How to set up an ODBC Data Source on SQL Server for Microsoft Dynamics GP](https://support.microsoft.com/topic/how-to-set-up-an-odbc-data-source-on-sql-server-for-microsoft-dynamics-gp-06f8c9e7-7493-1b91-d764-318910ebb9e5).

3. Verify the version of the ODBC. To do this, follow these steps:

    1. In Control Panel, open **Administrative Tools**.
    2. Double-click **Data Sources (ODBC)**.
    3. Select the **System DSN** tab.
    4. Select **Add**.
    5. At the bottom of the **Name** column, select **SQL Server**, or select **SQL Native Client**.

       The versions are displayed in the **Version** column.

4. Verify that the DYNSA user is the owner of the DYNAMICS database and of the company databases.

    If the DYNSA user is not the owner of the DYNAMICS database and of the company databases, change the owner of the databases to the DYNSA user. To do this, use one of the following methods:

    - If you use Microsoft SQL Server Enterprise Manager, follow these steps:

      1. Select **Start**, point to **Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.
      2. In the list, select the server that is running SQL Server, and then sign in by using the sa user account.

      3. Verify that the DYNSA user is the owner of the DYNAMICS database and of the company databases. To do this, run the following script in the **Query** box.

         ```console
         sp_helpdb
         ```

      4. If the values in the **Owner** field for the DYNAMICS database or for the company databases are not **DYNSA**, run the following script against the DYNAMICS database and against the company databases.

        ```console
        sp_changedbowner 'DYNSA'
        ```

    - If you use SQL Server Management Studio, follow these steps:

      1. Select **Start**, point to **Programs**, point to **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio**.
      2. In the **Server name** list, select the server that is running SQL Server, and then sign in by using the sa user account.
      3. Verify that the DYNSA user is the owner of the DYNAMICS database and of the company databases. To do this, select **New Query**, and then run the following script in the **Query** box.

            ```console
            sp_helpdb
            ```

      4. If the values in the **Owner** field for the DYNAMICS database or for the company databases are not **DYNSA**, run the following script against the DYNAMICS database and against the company databases.

            ```console
            sp_changedbowner 'DYNSA'
            ```

    - If you use Microsoft Support Administrator Console, follow these steps:

      1. Select **Start**, point to **Programs**, point to **Microsoft Support Administrator Console**, and then select **Support Administrator Console**.

      2. In the **SQL Server** list, select the server that is running SQL Server, and then sign in by using the sa user account.
      3. Verify that the DYNSA user is the owner of the DYNAMICS database and of the company databases. To do this, run the following script in the **Query** box.

            ```console
            sp_helpdb
            ```

      4. If the values in the **Owner** field for the DYNAMICS database or for the company databases are not **DYNSA**, run the following script against the DYNAMICS database and against the company databases.

          ```console
          sp_changedbowner 'DYNSA'
          ```

    > [!NOTE]
    >
    > - Do not run the script against the following default SQL Server databases:
    >
    >   - The master database
    >   - The model database
    >   - The tempdb database
    >   - The msdb database
    >
    > - After you change the owner of the databases to the DYNSA user, you should run the Grant.sql script against the DYNAMICS database and against the company databases. The content of the Grant.sql script is as follows.

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

    Therefore, appropriate permissions are assigned to the users who have the DYNGRP role. Then, these users can access the Microsoft Dynamics GP objects or the Microsoft Business Solutions - Great Plains objects.

5. Verify that the user who received the error message that is mentioned in the "Symptoms" section is a user in the DYNAMICS database and in the company databases. To do this, use one of the following methods:

   - If you use SQL Server Enterprise Manager, follow these steps:

     1. Select **Start**, point to **Programs**, point to **Microsoft SQL Server**, and then select **Enterprise Manager**.
     2. Expand **Microsoft SQL Servers**, expand **SQL Server Group**, and then expand the instance of SQL Server.
     3. Expand **Security**, and then select **Logins**.
     4. Right-click the user who received the error message, and then select **Properties**.
     5. Select the **Database Access** tab, and then verify that the **Permit** check box is selected for the DYNAMICS database and for the company databases.
     6. For each database to which the Microsoft Dynamics GP user or the Microsoft Business Solutions - Great Plains user has access, make sure that the **public** check box and the **DYNGRP** check box are selected in the **Permit in Database Role** pane.
     7. To save the changes, select **OK**.

   - If you use SQL Server Management Studio, follow these steps:

     1. Select **Start**, point to **Programs**, point to **SQL Server 2005** or to **SQL Server 2008**, and then select **SQL Server Management Studio**.
     2. Expand **Security**, and then expand **Logins**.
     3. Right-click the user who received the error message, and then select **Properties**.

     4. In the **Login Properties** dialog box, select **User Mapping**, and then verify that the **map** check box is selected for the DYNAMICS database and for the company databases to which the user has access.

     5. For each database to which the Microsoft Dynamics GP user or the Microsoft Business Solutions - Great Plains user has access, make sure that the **public** check box and the **DYNGRP** check box are selected in the **Database role membership for** pane.
     6. To save the changes, select **OK**.

   - If you use Support Administrator Console, follow these steps:
     1. Select **Start**, point to **Programs**, point to **Microsoft Support Administrator Console**, and then select **Support Administrator Console**.
     2. Sign in by using the sa user account.
     3. In the database list, select the database of the company in which the user received the error message.
     4. Run the following script.

        ```console
        EXEC sp_addrolemember 'DYNGRP','<username>'
        ```

        > [!NOTE]
        > In this script, **\<username>** is a placeholder for the actual user name.

## More information

Microsoft Dynamics GP or Microsoft Business Solutions - Great Plains must have the owner of databases set to **DYNSA** to apply the correct permissions for the users. All users are members of the DYNGRP database role. The Grant.sql script gives the users the correct permissions to access the databases.
