---
title: Set up a test company that has a copy of live company data
description: Describes how to set up a test company that has live company data by using Microsoft Dynamics GP running on MSDE 2000, on SQL Server 2005 Express, or on SQL Server 2008 Express.
ms.reviewer: theley, kyouells
ms.topic: how-to
ms.date: 03/13/2024
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# Set up a test company that has a copy of live company data by using Microsoft Dynamics GP on MSDE 2000, SQL Server 2005 Express, SQL Server 2008 Express, or SQL Server 2012 Express

To test certain issues, you may want to use a troubleshooting technique by using your live company data. To do this, you can copy a live company database to a test company database.

This article describes how to create the test company that has a copy of live company data. To do this, you can use Microsoft Dynamics GP or Microsoft Business Solutions - Great Plains running on SQL Server Desktop Engine (also known as MSDE 2000), on Microsoft SQL Server 2005 Express, or on Microsoft SQL Server 2008 Express.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 872370

> [!NOTE]
>
> - Microsoft Dynamics GP 9.0 is not supported on SQL Server 2008. Microsoft Dynamics GP 2010 is not supported on SQL Server 2000.
> - If you use Record Level Notes in your existing live company, and if you plan to use them in the test company, you will be required to run a NoteFix. For more information, call Technical Support for Microsoft Dynamics at (888) 477-7877.
> - If you use Human Resources for Microsoft Dynamics GP, the Attendance Setup information will not be copied to the test company. To open this window, do one of the following:
>   - In Microsoft Dynamics GP 10.0 or later, select **Microsoft Dynamics GP** > **Tools** > **Setup** > **Human Resources**, and then select **Setup**.
>   - In Microsoft Dynamics GP 9.0, select **Tools**, point to **Setup** > **Human Resources** > **Attendance**, and then select **Setup**.  
>   The Attendance Setup information is not copied over because the TAST0130 table contains a reference to the live company database. To correct this issue, update the Attendance Setup window in the new test company database to contain the same information that is contained in the live database.
> - If you use Fixed Assets for Microsoft Dynamics GP, the Fixed Assets Company Setup information will not be copied to the test Company. To correct this issue, open the Fixed Assets Company Setup window in the live company, and then note the settings. Open the Fixed Assets Company Setup window in the test company, and then enter the same settings as those that are in the live company. To open the Fixed Assets Company Setup window, use one of the following options:
>   - In Microsoft Dynamics GP 10.0 or later, select **Microsoft Dynamics GP** > **Tools** > **Setup** > **System** > **Fixed Assets** > **Company**.
>   - In Microsoft Dynamics GP 9.0, select **Tools** > **Setup** > **Fixed Assets**, and then select **Company**.
> - If you use Audit Trails for Microsoft Dynamics GP, the tables that have audits on the live company database will also have audits in the test company database. To remove Auditing in the test company database, call Technical Support for Microsoft Dynamics at (888) 477-7877. For more information about how to set up a test company that has a copy of live company data by using Microsoft SQL Server 7.0/2000/2005, see [Set up a test company that has a copy of live company data for Microsoft Dynamics GP by using Microsoft SQL Server](https://support.microsoft.com/topic/kb-set-up-a-test-company-that-has-a-copy-of-live-company-data-for-microsoft-dynamics-gp-by-using-microsoft-sql-server-6199295b-fc49-d963-3865-2d24a4b49211).

## More information

To create a test company that has a copy of live company data by using Microsoft Dynamics GP or Microsoft Business Solutions - Great Plains running on MSDE 2000, on Microsoft SQL Server 2005 Express, on Microsoft SQL Server 2008 Express or on Microsoft SQL Server 2012 Express, follow these steps:

1. Create a company database in Utilities that you will use as the test company. Make sure that you give the database a name that will identify the database as a test company. For example, if the live company database is The World Online, Inc. (TWO), the test company database can be named *TWOT* or *TEST*.

    After the test company is created, you can use the test company without making any modifications to it. Continue with the remaining steps to load the test company with data from the live company.

2. Make a backup of the live company database. To do this, follow these steps:

   1. In Microsoft Dynamics GP 10.0 or later, point to **Maintenance** on the **Microsoft Dynamics GP** menu, and then select **Backup**. In Microsoft Dynamics GP 9.0, select **Backup** on the **File** menu.
   2. Select the live company that you want to back up.
   3. Verify the path of the backup location, and then select **OK**.

3. Restore the backup that you made in step 2 into the test company database. To do this, follow the appropriate steps.

    Using MSDE 2000

    1. Run the following script in Support Administrator Console.

    > [!NOTE]
    > Do not select the TEST database in the drop-down list in Support Administrator Console.

    ```console
    RESTORE DATABASE [<TEST>] 
     FROM DISK = N'C:\Program Files\Dynamics\Backup\TWO_Mar5-2003.bak'
     WITH FILE = 1, NOUNLOAD,
     STATS = 10, RECOVERY, REPLACE,
     MOVE N'GPSTWODat.mdf' TO N'C:\Program Files\Microsoft SQL Server\MSSQL\Data\GPSTESTDat.mdf',
     MOVE N'GPSTWOLog.ldf' TO N'C:\Program Files\Microsoft SQL Server\MSSQL\Data\GPSTESTLog.ldf'
    ```

    > [!NOTE]
    >
    > - Replace the *\<TEST>* placeholder with the name of the test company.
    > - In the second line of code, replace the path with the physical path of the backup of the live company.
    > - The first MOVE statement specifies the location of the .mdf file. Replace the first .mdf file with the .mdf file of the live production database. In this example, the live production database is TWO. Therefore, the .mdf file is GPSTWODat.mdf.  
    > Following "TO," replace the path with the physical path of the .mdf file of the test database. In this example, the test database is TEST, and the .mdf file is located in C:\Program Files\Microsoft SQL Server\MSSQL\Data.
    > - The second MOVE statement specifies the location of the .ldf file. Replace the first .ldf file with the .ldf file of the live production database. In this example, the live production database is TWO. Therefore, the .ldf file is GPSTWOLog.ldf.  
    > Following "TO," replace the path with the physical path of the .ldf file of the test database. In this example, the test database is TEST, and the .ldf file is located in C:\Program Files\Microsoft SQL Server\MSSQL\Data.

    Using Microsoft SQL Server 2008 Express or Microsoft SQL Server 2005 Express

    1. Do one of the following:
         - If you use Microsoft SQL Server 2008 Express or Microsoft SQL Server 2012 Express, select **Start**, point to **Programs**, point to **Microsoft SQL Server 2008**, and then select **SQL Server Management Studio**.
         - If you use Microsoft SQL Server 2005 Express, select **Start**, point to **Programs**, point to **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio**.
    2. In the **Server name** box, type the name of the instance of SQL Server.
    3. In the **Authentication** list, select **SQL Server Authentication**.
    4. In the **User name** box, type *sa*.
    5. In the **Password** box, type the password for the sa user, and then select **Connect**.
    6. In the **Object Explorer** area, double-click **Databases**.
    7. Right-click the test company database, point to **Tasks**, point to **Restore**, and then select **Database**.
    8. In the **Source for restore** area, select **From device**, and then select the lookup button.
    9. In the **Backup location** area, select **Add**.
    10. Locate the live backup file, select the file, and then select **OK** two times.
    11. In the **Select the backup sets to restore** area, select **Restore** for the backup file that you want to restore.
    12. In the **Select a page** area, select **Options**.
    13. In the **Restore the database files as** area, verify that the names of the .mdf file and the .ldf file in the **Restore As** column match the names of the .mdf file and .ldf file in the test company.
    14. Select **OK**.

4. After you complete the restore process, the COMPANYID information and the INTERID information in the test company match the COMPANYID information and the INTERID information in the live company. This information must be updated to reflect the COMPANYID information and the INTERID information correctly in the test company. Run the following script in Support Administrator Console or in SQL Server Management Studio against the test company to update the COMPANYID information and the INTERID information.

    ```sql
    if exists 
    (
       select
          1 
       from
          INFORMATION_SCHEMA.COLUMNS 
       where
          TABLE_NAME = 'SY00100'
    )
    begin
       declare @Statement varchar(850) 
       select
          @Statement = 'declare @cStatement varchar(255)
     
          declare G_cursor CURSOR for 
          select
             case
                when
                   UPPER(a.COLUMN_NAME) in 
                   (
                      ''COMPANYID'',
                      ''CMPANYID''
                   )
                then
                   ''
                   update
                      '' + a.TABLE_NAME + '' 
                   set
                      '' + a.COLUMN_NAME + '' = '' + cast(b.CMPANYID as char(3)) 
                   else
                      ''
                      update
                         '' + a.TABLE_NAME + '' 
                      set
                         '' + a.COLUMN_NAME + '' = '''''' + db_name() + '''''''' 
             end
                      from
                         INFORMATION_SCHEMA.COLUMNS a, '+rtrim(DBNAME)+'.dbo.SY01500 b 
                      where
                         UPPER(a.COLUMN_NAME) in 
                         (
                            ''COMPANYID'', ''CMPANYID'', ''INTERID'', ''DB_NAME'', ''DBNAME''
                         )
                         and b.INTERID = db_name() 
                         and COLUMN_DEFAULT is not null 
                         and rtrim(a.TABLE_NAME) + '' - '' + rtrim(a.COLUMN_NAME) <> ''SY00100 - DBNAME'' 
                      order by
                         a.TABLE_NAME 
                      set
                         nocount 
                         on OPEN G_cursor FETCH NEXT 
                      FROM
                         G_cursor INTO @cStatement WHILE (@@FETCH_STATUS <> - 1) 
                         begin
                            exec (@cStatement) FETCH NEXT 
                      FROM
                         G_cursor INTO @cStatement 
                         end
                         close G_cursor DEALLOCATE G_cursor 
                      set
                         nocount off'
     
                      from
                         SY00100 exec (@Statement) 
    end
    else
       begin
          declare @cStatement varchar(255) 
          declare G_cursor CURSOR for 
          select
             case
                when
                   UPPER(a.COLUMN_NAME) in 
                   (
                      'COMPANYID',
                      'CMPANYID'
                   )
                then
                   'update ' + a.TABLE_NAME + ' set ' + a.COLUMN_NAME + ' = ' + cast(b.CMPANYID as char(3)) 
                else
                   'update ' + a.TABLE_NAME + ' set ' + a.COLUMN_NAME + ' = ''' + db_name() + '''' 
             end
          from
             INFORMATION_SCHEMA.COLUMNS a, DYNAMICS.dbo.SY01500 b 
          where
             UPPER(a.COLUMN_NAME) in 
             (
                'COMPANYID', 'CMPANYID', 'INTERID', 'DB_NAME', 'DBNAME'
             )
             and b.INTERID = db_name() 
             and COLUMN_DEFAULT is not null 
          order by
             a.TABLE_NAME 
          set
             nocount 
             on OPEN G_cursor FETCH NEXT 
          FROM
             G_cursor INTO @cStatement WHILE (@@FETCH_STATUS <> - 1) 
             begin
                exec (@cStatement) FETCH NEXT 
          FROM
             G_cursor INTO @cStatement 
             end
             close G_cursor DEALLOCATE G_cursor 
          set
             nocount off 
       end
    ```

5. Verify that the owner of the TEST database is DYNSA by executing the following script against the TEST database in Support Administrator Console.

    ```sql
    sp_changedbowner 'DYNSA'
    ```

After you complete these steps, the test company has a copy of the live company data. Therefore, the test company is ready for use in Microsoft Dynamics GP.

## References

To download SQL Server Management Studio for SQL Express, see [Download SQL Server Management Studio (SSMS)](/sql/ssms/download-sql-server-management-studio-ssms).
