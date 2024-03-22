---
title: Deleting the login failed
description: Provides a solution to an error that occurs when you try to delete a user through Microsoft Dynamics GP.
ms.reviewer: theley, KYouells
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# "Deleting the login failed for an unknown reason. Contact your SQL Server Administrator for assistance" Error message when you try to delete a user through Microsoft Dynamics GP

This article provides a solution to an error that occurs when you try to delete a user through Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 943027

## Symptoms

When you try to delete a user through Microsoft Dynamics GP, you receive the following error message:
> Deleting the login failed for an unknown reason. Contact your SQL Server Administrator for assistance.

Additionally, the following message is logged in the Dexsql.log file:
> [Microsoft][ODBC SQL Server Driver][SQL Server] Cannot drop the user '<User_name>', because it does not exist or you do not have permission.

> [!NOTE]
> In this message, **\<User_name>** represents the actual user name that you try to delete through Microsoft Dynamics GP.

Or, you may receive the following error message when you try to delete the user:
> Login userid is aliased or mapped to a user in one or more databases. Drop the user or alias before dropping the login.

When you select **OK**, you receive the following extra error message:
> The stored procedure smEnterUserNamesDeleteButton returned the following results: DBMS:15175, GP:0

## Cause

This problem occurs if the Microsoft Dynamics GP user exists as a Microsoft SQL Server user in an application database that isn't a Microsoft Dynamics GP database.

## Resolution

To resolve this problem, use one of the following methods.

### Method 1: If the Microsoft Dynamics GP user can be dropped from the database in which this user exists as a Microsoft SQL Server user

To resolve this problem, follow these steps:

1. Drop the SQL Server user from the DYNAMICS database and from all Microsoft Dynamics GP company databases. Then, drop the SQL Server sign-in. To do it, use the appropriate method.
   - SQL Server Management Studio
      1. Select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005** or to **Microsoft SQL Server 2008**, and then select **SQL Server Management Studio**.
      2. In the **Connect to Server** dialog box, follow these steps:
          1. In the **Server name** box, type the name of the server that hosts the Microsoft Dynamics GP databases.
          2. In the **Authentication** list, select **SQL Authentication**.
          3. In the **Login** box, type **sa**.
          4. In the **Password** box, type the password for the sa user, and then select **Connect**.
      3. On the **File** menu, point to **New**, and then select **Query with Current Connection**.
      4. In the Query window, type the following script.

          ```sql
          DROP USER <User_name>
          ```

          > [!NOTE]
          > In the scripts in this method, **\<User_name>** represents the actual user name in the databases.
      5. In the box that has the database list, change the value from **master** to **DYNAMICS**.
      6. On the **Query** menu, select **Execute**.

          > [!NOTE]
          >
          > - By default, the value in the box that contains the database list is "master."
          > - Repeat steps 5 and 6 for each Microsoft Dynamics GP company database that you use. For each company database, change the value in the box that contains the database list from "master" to a database name.

      7. On the **File** menu, point to **New**, and then select **Query with Current Connection**.
      8. In the Query window, type the following script.

          ```sql
          USE master
          GO
          DROP LOGIN <Login_name>
          ```

          > [!NOTE]
          > In the scripts in this method, **\<Login_name>** represents the actual login name for SQL Server.
      9. On the **Query** menu, select **Execute**.

   - Microsoft SQL Query Analyzer
      1. Select **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.
      2. In the **Connect to SQL Server** dialog box, follow these steps:
          1. In the **SQL Server** box, type the name of the server that hosts the Microsoft Dynamics GP databases.
          2. Select the **SQL Server Authentication** option.
          3. In the **Logon name** box, type **sa**.
          4. In the **Password** box, type the password for the sa user, and then select **OK**.
      3. In the Query window, type the following script:

          ```sql
          sp_dropuser <User_name>
          ```

      4. In the box that has the database list, change the value from **master** to **DYNAMICS**.
      5. On the **Query** menu, select **Execute**.

          > [!NOTE]
          >
          > - By default, the value in the box that contains the database list is **master**.
          > - Repeat steps 4 and 5 for each Microsoft Dynamics GP company database that you use. For each company database, change the value in the box that contains the database list from "master" to a database name.

      6. On the **File** menu, point to **New**, and then select **Blank Query Window**.
      7. In the Query window, type the following script.

          ```sql
          USE master
          GO
          sp_droplogin <Login_name>
          ```

      8. On the **Query** menu, select **Execute**.

   - For Microsoft Support Administrator Console, follow these steps:
      1. Select **Start**, point to **All Programs**, point to **Microsoft Support Administrator Console**, and then select **Support Administrator Console**.
      2. In the **Connect to SQL Server** dialog box, follow these steps:
          1. In the **SQL Server** box, type the name of the server.
          2. In the **Logon Name** box, type **sa**.
          3. In the **Password** box, type the password for the sa user, and then select **OK**.
      3. In the Query window, type the following script.

          ```sql
          sp_dropuser <User_name>
          ```

      4. In the box that contains the database list, change the value from "master" to "DYNAMICS."
      5. On the **Query** menu, select **Execute**.

          > [!NOTE]
          >
          > - By default, the value in the box that contains the database list is "master."
          > - Repeat steps 4 and 5 for each Microsoft Dynamics GP company database that you use. For each company database, change the value in the box that contains the database list from "master" to a database name.

      6. On the **Query** menu, select **New**.
      7. In the Query window, type the following script.

          ```sql
          master..sp_droplogin <Login_name>
          ```

      8. On the **Query** menu, select **Execute**.

2. Sign in to Microsoft Dynamics GP as the sa user.
3. Open the **User Setup** window. To do it, follow the appropriate step:
   - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **System**, and then select **User**.
   - In Microsoft Dynamics GP 9.0, point to **Setup** on the **Tools** menu, point to **System**, and then select **User**.
4. In the User Setup window, select the magnifying glass button in the **User ID** box.
5. In the Users window, select a user, and then select **Select**.

    > [!NOTE]
    > You may receive the following message:
    >
    > This user does not have a corresponding SQL Login. To create a SQL Login, enter a password and choose save.

6. In the User Setup window, select **Delete**.

### Method 2: If the Microsoft Dynamics GP user can't be dropped from the database that contains this user as a SQL Server user

To resolve this problem, drop the SQL Server user from the DYNAMICS database and from all Microsoft Dynamics GP company databases. To do it, follow the appropriate methods:

- For SQL Server Management Studio, follow these steps:
    1. Select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005** or to **Microsoft SQL Server 2008**, and then select **SQL Server Management Studio**.
    2. In the **Connect to Server** dialog box, follow these steps:
        1. In the **Server name** box, type the name of the server that hosts the Microsoft Dynamics GP databases.
        2. In the **Authentication** list, select **SQL Authentication**.
        3. In the **Login** box, type **sa**.
        4. In the **Password** box, type the password for the sa user. Then, select **Connect**.
    3. On the **File** menu, point to **New**, and then select **Query with Current Connection**.
    4. In the Query window, type the following script.

        ```sql
        DROP USER <User_name>
        ```

        > [!NOTE]
        > In the scripts in this method, **<User_name>** represents the actual user name in the databases.
    5. In the box that contains the database list, change the value from **master** to **DYNAMICS**.
    6. On the **Query** menu, select **Execute**.

        > [!NOTE]
        >
        > - By default, the value in the box that contains the database list is "master."
        > - Repeat steps 5 and 6 for each Microsoft Dynamics GP company database that you use. For each company database, change the value in the box that contains the database list from "master" to a database name.

    7. On the **File** menu, point to **New**, and then select **Query with Current Connection**.
    8. In the Query window, type the following script for the appropriate program version.

          - Microsoft Dynamics GP 10.0

              ```sql
              DELETE DYNAMICS..SY01400 WHERE USERID = '<User_name>' 
              DELETE DYNAMICS..ACTIVITY WHERE USERID = '<User_name>' 
              DELETE DYNAMICS..SY60100 WHERE USERID = '<User_name>' 
              DELETE DYNAMICS..SY10500 WHERE USERID = '<User_name>'
              DELETE DYNAMICS..SY10550 WHERE USERID = '<User_name>'
              ```

          - Microsoft Dynamics GP 9.0

              ```sql
              DELETE DYNAMICS..SY01400 WHERE USERID = '<User_name>' 
              DELETE DYNAMICS..ACTIVITY WHERE USERID = '<User_name>' 
              DELETE DYNAMICS..SY02000 WHERE USERID = '<User_name>' 
              DELETE DYNAMICS..SY60100 WHERE USERID = '<User_name>'
              ```

    9. On the **Query** menu, select **Execute**.

- Microsoft Support Administrator Console
    1. Select **Start**, point to **All Programs**, point to **Microsoft Support Administrator Console**, and then select **Support Administrator Console**.
    2. In the **Connect to SQL Server** dialog box, follow these steps:
        1. In the **SQL Server** box, type the name of the server.
        2. In the **Logon Name** box, type sa .
        3. In the **Password** box, type the password for the sa user. Then, select **OK**.

    3. In the Query window, type the following script.

        ```sql
        sp_dropuser <User_name>
        ```

    4. In the box that contains the database list, change the value from "master" to "DYNAMICS."
    5. On the **Query** menu, select **Execute**.

        > [!NOTE]
        >
        > - By default, the value in the box that contains the database list is "master."
        > - Repeat steps 4 and 5 for each Microsoft Dynamics GP company database that you use. For each company database, change the value in the box that contains the database list from "master" to a database name.

    6. On the **Query** menu, select **New**.
    7. In the Query window, type the following script for the appropriate program version.

        - Microsoft Dynamics GP 10.0

          ```sql
          DELETE DYNAMICS..SY01400 WHERE USERID = '<User_name>' 
          DELETE DYNAMICS..ACTIVITY WHERE USERID = '<User_name>' 
          DELETE DYNAMICS..SY10000 WHERE USERID = '<User_name>' 
          DELETE DYNAMICS..SY60100 WHERE USERID = '<User_name>' 
          DELETE DYNAMICS..SY10500 WHERE USERID = '<User_name>'
          DELETE DYNAMICS..SY10550 WHERE USERID = '<User_name>'
          ```

        - Microsoft Dynamics GP 9.0

          ```sql
          DELETE DYNAMICS..SY01400 WHERE USERID = '<User_name>' 
          DELETE DYNAMICS..ACTIVITY WHERE USERID = '<User_name>' 
          DELETE DYNAMICS..SY02000 WHERE USERID = '<User_name>' 
          DELETE DYNAMICS..SY60100 WHERE USERID = '<User_name>'
          ```

    8. On the **Query** menu, select **Execute**.
