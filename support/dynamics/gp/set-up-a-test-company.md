---
title: Set up a test company
description: Describes how to set up a test company that has a copy of your live production company data by using Microsoft SQL Server.
ms.reviewer: theley
ms.date: 02/18/2024
---
# Set up a test company that has a copy of live company data for Microsoft Dynamics GP by using Microsoft SQL Server

This article describes how to set up a test company that has a copy of live company data by using Microsoft SQL Server.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 871973

## Summary

To test certain issues, a troubleshooting technique may be to copy the Live Company database to a Test Company database.

## More information

Notes:

- If you're using **Human Resources** for Microsoft Dynamics GP, the Attendance Setup information appears to haven't been copied over. To open this window, select **Tools**, point to **Setup**, point to **Human Resources**, point to **Attendance**, and then select **Setup**. This table (TAST0130) is copied over, but it contains a field that still references the Live Company database. To correct this issue, you can reenter the data in the Attendance Setup window in the new Test company database to contain the same information as before and Save it. Or, you may choose to update the COMPANYCODE_I field in the TAST0130 table to change the company code reference to Test database instead (which can be found in the INTERID column value for the Test company in the Dynamics..SY01500 table).  

- If you're using **Fixed Assets** for Microsoft Dynamics GP, the Fixed Assets Company Setup information won't be brought over to the Test Company. To correct this issue, open the Fixed Assets Company Setup window in the Live Company and note the settings. Open the Fixed Assets Company Setup window in the Test Company and enter the same settings as the Live Company. To open the window, use the following one:
  - Microsoft Dynamics GP 10.0 or a later version:  
    Select **Microsoft Dynamics GP**, point to **Tools**, point to **Setup**, point to **System**, point to **Fixed Assets**, and then select **Company**.

- If you're using **Audit Trails** for Microsoft Dynamics GP, you must delete the audit triggers from the test company using SQL and not from the front-end. Audit Trails is just triggers that are copied over and still point to the same live audit database. However, don't delete, stop, or remove the audit in the Audit Trail Maintenance window in the test company, or it will clear out the history in the audit table and/or remove the trigger on the live company. To remove the audit trail triggers from the test company, refer to the steps outlined in [How to stop Audit Trail triggers in the test company from updating the live audit database using Audit Trails in Microsoft Dynamics GP](https://support.microsoft.com/help/2847491).

- If you're using **Analytical Accounting** (AA), you must first activate AA in the Test company before you copy over the live database (that has AA active). Follow the steps in [How to create a test company with Analytical Accounting installed using Microsoft Dynamics GP](https://community.dynamics.com/blogs/post/?postid=30001b50-2b30-4856-8ae7-2d2c12fff83d).

    > [!NOTE]
    > After the restore, don't forget to run the two scripts mentioned in the blog: The first to update the INTERID (from step 6 below in this article, and also the script to update the next available numbers stored in the AAG00102 table (to prevent Duplicate Key errors when keying new transactions).

- If you're using **Management Reporter 2012**, you must stop the Management Reporter services that can be done using either of the following options:

    1. In the Management Reporter 2012 Configuration Console, on the first page, you'll see both the Management Reporter 2012 Application Service and Management Reporter 2012 Process Service. Select **Stop** under these two services to stop them.

    2. Select **Start**, select **Control Panel**, select **Administrative Tools**, then select to open Services. In the Services window, highlight the Management Reporter 2012 Application Service and select the **link** to Stop this service. Also, highlight the Management Reporter 2012 Process Service and select the **link** to Stop this service as well.

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. It includes, but isn't limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you're familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure. However, they won't modify these examples to provide added functionality or construct procedures to meet your specific requirements.

To set up the test company, follow these steps:

1. In Utilities, create a new company database that you can use as the test company. Make sure that you give the database a unique DB/company ID and company name that will designate the database as a test company. For example, you could use a DB/company ID of **TEST** and a company name of **TEST COMPANY**.

    > [!NOTE]
    > The path where the database's .mdf and .ldf files are being created. You will need this information for a step later in this article.

2. Sign into the test company. In Microsoft Dynamics GP, select **Microsoft Dynamics GP**, select **Tools**, select **Setup**, select **System**, and then select **User Access**.

3. In the **User Access** area, select the user to whom you want to grant access to the test company database. Then, select the check box next to the test company name to grant access to the test company database. Repeat this step for all users to whom you want to grant access to the test company database. To do it, use the following step.
   - Microsoft Dynamics GP: Select **Microsoft Dynamics GP**, select **Tools**, select **Setup**, select **System**, and then select **User Access**.

4. Make a backup of the live company database.

    If you're using SQL Server Management Studio, follow these steps:

      1. Select **Start**, and then select **Programs**.
      2. Point to **Microsoft SQL Server**, and then select **SQL Server Management Studio**. The Connect to Server window opens.
      3. In the **Server name** box, type the name of the instance of SQL Server.
      4. In the **Authentication** list, select
      **SQL Authentication**.
      5. In the **User name** box, type **sa**.
      6. In the **Password** box, type the password for the sa user, and then select **Connect**.
      7. In the **Object Explorer** section, expand **Databases**.
      8. Right-click the live company database, point to
      **Tasks**, and then select **Backup**.
      9. In the **Destination** area, select
      **Remove**, and then select **Add**.
      10. In the **Destination on disk** area, select the **ellipsis** button.
      11. Find the location where you want to create the backup file, type a name for the backup file, such as LIVE.bak, and then select **OK**.
      12. Select **OK** repeatedly until you return to the Backup Database window.
      13. Select **OK** to start the backup.

5. Restore the live company backup file that you created in step 4 into the test company database.

    If you're using SQL Server Management Studio, follow these steps:
      1. Select **Start**, and then select
      **Programs**.
      2. Point to **Microsoft SQL Server**, and then select **SQL Server Management Studio**. The Connect to Server window opens.
      3. In the **Server name** box, type the name of the instance of SQL Server.
      4. In the **Authentication** list, select
      **SQL Authentication**.
      5. In the **User name** box, type **sa**.
      6. In the **Password** box, type the password for the sa user, and then select **Connect**.
      7. In the **Object Explorer** section, expand **Databases**.
      8. Right-click the test company database, point to
      **Tasks**, point to **Restore**, and then select **Database**.
      9. In the **Source for Restore** area, select
      **From Device**, and then select the **ellipsis** button.
      10. In the **Backup Location** area, select **Add**.
      11. Find the location where saved the backup file, select
      **LIVE.bak file**, and then select **OK**.
      12. Select **OK**. You return to the Restore Database window.
      13. In the **Select the Backup Sets to Restore** section, select the backup file that you want to restore.
      14. In the **Select a Page** area, select **File**.
      15. In the **Restore Database Files as** area, you'll need to change the location of these two files from the Live database to the test database's .mdf and .ldf files. By default, they'll be selected on the Live database's .mdf and .ldf files.

          > [!NOTE]
          > The logical file name reflects the name of the live database. Don't change the logical file name.

      16. To change these locations, select the **Ellipse (...)** next to the file location field.
      17. Navigate to the path that you noted in step 1, where the test database was created.
      18. Highlight the respective .mdf file, and then select
      **OK**.
      19. Repeat steps 16 through 18, select the .ldf file, and then select **OK**.
      20. Select the **Options** tab to select the **Overwrite existing database** check box.
      21. Select **OK** to return to the Restore Database window

    If you're using Microsoft Dynamics GP 10.0 or later, follow these steps to copy the security permissions from the live company to the test company:

    1. Sign into Microsoft Dynamics GP as the sa user.
    2. Select **Microsoft Dynamics GP**, point to
    **Tools**, point to **Setup**, point to
    **System**, and then select **User Access**.
    3. Select an appropriate user, and then make sure that the check box for the new test company is selected to indicate that access is granted.

        > [!NOTE]
        > If you receive an error message when you select a company, delete the user from the Users folder under the new test database in SQL Server Management Studio.

    4. Select **Microsoft Dynamics GP**, point to
    **Tools**, point to **Setup**, point to
    **System**, and then select **User Security**.
    5. In the Security Task Setup window, select the user who you want to have access to the test company.
    6. In the **Company** list, select the live company.
    7. Select **Copy**, select the check box that is next to the test company, and then select **OK**.

        The user's permissions in the live company are copied to the test company.

6. After the live company database has been restored over the top of the test company database, the test company contains references that have the same COMPANYID and INTERID information that the live company has. To correctly reflect the information for the test company, run the following script below against the test company in Query Analyzer or in SQL Server Management Studio. This script updates the COMPANYID and INTERID in the test database with the information that is listed in the system database SY01500 table for this test company.

    ```sql
    if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'SY00100') begin
      declare @Statement varchar(850)
      select @Statement = 'declare @cStatement varchar(255)
    declare G_cursor CURSOR for
    select case when UPPER(a.COLUMN_NAME) in (''COMPANYID'',''CMPANYID'')
      then ''update ''+a.TABLE_NAME+'' set ''+a.COLUMN_NAME+'' = ''+ cast(b.CMPANYID as char(3)) 
      else ''update ''+a.TABLE_NAME+'' set ''+a.COLUMN_NAME+'' = ''''''+ db_name()+'''''''' end
    from INFORMATION_SCHEMA.COLUMNS a, '+rtrim(DBNAME)+'.dbo.SY01500 b
      where UPPER(a.COLUMN_NAME) in (''COMPANYID'',''CMPANYID'',''INTERID'',''DB_NAME'',''DBNAME'')
        and b.INTERID = db_name() and COLUMN_DEFAULT is not null
     and rtrim(a.TABLE_NAME)+''-''+rtrim(a.COLUMN_NAME) <> ''SY00100-DBNAME''
      order by a.TABLE_NAME
    set nocount on
    OPEN G_cursor
    FETCH NEXT FROM G_cursor INTO @cStatement
    WHILE (@@FETCH_STATUS <> -1)
    begin
      exec (@cStatement)
      FETCH NEXT FROM G_cursor INTO @cStatement
    end
    close G_cursor
    DEALLOCATE G_cursor
    set nocount off'
      from SY00100
      exec (@Statement)
    end
    else begin
      declare @cStatement varchar(255)
      declare G_cursor CURSOR for
      select case when UPPER(a.COLUMN_NAME) in ('COMPANYID','CMPANYID')
        then 'update '+a.TABLE_NAME+' set '+a.COLUMN_NAME+' = '+ cast(b.CMPANYID as char(3)) 
        else 'update '+a.TABLE_NAME+' set '+a.COLUMN_NAME+' = '''+ db_name()+'''' end
      from INFORMATION_SCHEMA.COLUMNS a, DYNAMICS.dbo.SY01500 b
        where UPPER(a.COLUMN_NAME) in ('COMPANYID','CMPANYID','INTERID','DB_NAME','DBNAME')
          and b.INTERID = db_name() and COLUMN_DEFAULT is not null
        order by a.TABLE_NAME
      set nocount on
      OPEN G_cursor
      FETCH NEXT FROM G_cursor INTO @cStatement
      WHILE (@@FETCH_STATUS <> -1)
      begin
        exec (@cStatement)
        FETCH NEXT FROM G_cursor INTO @cStatement
      end
      close G_cursor
      DEALLOCATE G_cursor
      set nocount off
    end
    ```

    > [!NOTE]
    > If this script fails with a duplicate key error, you must manually change the **INTERID** and **COMPANYID** columns in the table on which you're receiving the primary key error in the test company.

    For example: A primary key constraint error on PKRVLPD033. To properly do a search for the table, the prefix, PK, refers to Primary Key and isn't part of the table name. In this example, the table that you want to verify is RVLPD033 for that database.

    > [!NOTE]
    > If you're using **Human Resources**, you must also change the COMPANYCODE_I value in the TAST0130 table. For more information, see the NOTES section at the top of this article.

7. Verify that the database owner of the test database is DYNSA. To do it, run the following script against the test company in Query Analyzer or in SQL Server Management Studio:

    ```sql
    sp_changedbowner 'DYNSA'
    ```

8. If you use the drilldown functionality in the SQL Server Reporting Services or Excel integrated reports, you need to do the following to update your server links so the drilldowns work after the database change:

    - Ensure that everyone has logged out of Microsoft Dynamics GP and close all instances of SQL Server Management Studio
    - On a machine where Dynamics GP is installed select **Start**, then point to **All Programs**. Select **Microsoft Dynamics**, then GP and select **Database Maintenance**.
    - When the utility opens, select or enter the SQL Server instance where the Dynamics GP databases are stored. If you're signed in as a domain account with rights to this SQL Server instance, you can select that option. Otherwise select SQL Authentication and enter an appropriate user name and password. Then select **Next >>**
    - Select **Mark All** to choose each of the Dynamics GP databases and select **Next >>**
    - Select the Microsoft Dynamics GP product, then select **Next >>**
    - Select **Functions and Stored Procedures** and **Views**, then select **Next >>**.
    - Review the confirmation window, then select **Next >>** to begin the process.

    The test company should now have a copy of the live company data and be ready for use.

## References

For more information, see [Set up a test company that has a copy of live company data by using Microsoft Dynamics GP on MSDE 2000, SQL Server 2005 Express, SQL Server 2008 Express, or SQL Server 2012 Express](https://support.microsoft.com/help/872370).
