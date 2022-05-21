---
title: Restart the upgrade of a company database
description: Describes the steps to restart the upgrade of a company database that was restored from a backup.
ms.reviewer: kyouells
ms.topic: how-to
ms.date: 03/31/2021
---
# How to restart the upgrade of a company database in Microsoft Dynamics GP

This article describes how to restart the upgrade of a company database to Microsoft Dynamics GP if the company database was restored from a backup.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 920900

## Introduction

> [!NOTE]
> The method that this article describes does not apply when you upgrade to Microsoft Business Solutions - Great Plains 8.0 or to Microsoft Business Solutions - Great Plains 7.5.

## More information

> [!NOTE]
> Before you upgrade a company database that was restored from a backup, we recommend that you create a backup of the DYNAMICS database.

### Upgrade from Microsoft Business Solutions - Great Plains 8.0 or from Microsoft Business Solutions - Great Plains 7.5 to Microsoft Dynamics GP 9.0

To restart the upgrade of a company database from Microsoft Business Solutions - Great Plains 8.0 or from Microsoft Business Solutions - Great Plains 7.5 to Microsoft Dynamics GP, follow these steps:

1. Restore a backup of the company database that was made before the upgrade was done.
2. Run the following script in Microsoft SQL Query Analyzer, in SQL Server Management Studio, or in the Support Administrator Console:

    ```sql
    use DYNAMICS
    declare
    @companyDBName as char(5),
    @companyName as char(65),
    @version as numeric(3,2),
    @verMajor as int,
    @verMinor as int,
    @verOldMajor as int,
    @verOldMinor as int,
    @companyID as smallint 
    set nocount on 
    set @companyDBName = '<Company_Database_Name>' 
    set @version = <insert earlier version here> 
    
    if (@version = 8.0 or @version = 8)
    begin
               set @verMajor = 8 
               set @verMinor = 0 
               set @verOldMajor = 7 
               set @verOldMinor = 50
    end
    if (@version = 7.5)
    begin
               set @verMajor = 7
               set @verMinor = 50
               set @verOldMajor = 7
               set @verOldMinor = 50
    end
    
    set @companyID = (select CMPANYID from SY01500 where INTERID = @companyDBName)
    
    delete DB_Upgrade where PRODID <>0 and db_name = @companyDBName
    
    delete DU000020 where PRODID <>0 and companyID = @companyID
    
    update DB_Upgrade set db_verMajor = @verMajor, db_verMinor = @verMinor,
    db_verOldMajor = @verOldMajor, db_verOldMinor = @verOldMinor, db_verBuild=0, db_verOldBuild=0, db_status = 0
    where PRODID = 0 and db_name = @companyDBName
    
    set @companyName = (select CMPNYNAM from SY01500 where INTERID = @companyDBName)
    
    update DU000020 set versionMajor = @verMajor, versionMinor = @verMinor, versionBuild = 0 where companyID = @companyID and PRODID = 0
    
    delete DU000030 where companyID = @companyID
    
    delete duLCK
    
    set nocount off
    ```

    > [!NOTE]
    > In this script, replace the following placeholders with the correct information, and then run the script:
    >
    > - Replace the *\<Company_Database_Name>* placeholder with the name of the company database. For example, if a company that is named Adventureworks has a database that is named TWO, type **TWO**.
    > - Replace the *\<insert earlier version here>* placeholder with the version number to which you want to revert. If you are upgrading from Microsoft Business Solutions - Great Plains 8.0, type **8.0**. If you're upgrading from Microsoft Business Solutions - Great Plains 7.5, type **7.5**.

3. Rename the current Dexsql.log file, and then start Microsoft Dynamics GP Utilities to restart the upgrade. If the update is still unsuccessful, contact Technical Support for Microsoft Dynamics at 888-477-7877.

    > [!NOTE]
    > If you contact Technical Support for Microsoft Dynamics, or if you visit the Technical Support for Microsoft Dynamics Web site, provide the Dexsql.log file for the update. Additionally, provide the results from the following script:

    ```sql
    SELECT b.fileOSName, a.fileNumber, a.PRODID, a.Status, a.errornum, a.errordes, c.CMPANYID, c.INTERID
          FROM DYNAMICS.dbo.DU000030 a
          JOIN
          DYNAMICS.dbo.DU000010 b
          ON a.fileNumber = b.fileNumber
          AND a.PRODID = b.PRODID
          JOIN
          DYNAMICS.dbo.SY01500 c
          ON a.companyID = c.CMPANYID
          WHERE (a.Status <> 0 or a.errornum <> 0) and a.Status <>15
    ```

### Update from Microsoft Business Solutions - Great Plains 8.0 to Microsoft Dynamics GP 10.0

To restart the upgrade of a company database from Microsoft Business Solutions - Great Plains 8.0 to Microsoft Dynamics GP 10.0, follow these steps:

1. Restore a backup of the company database that was made before the upgrade was done.
2. Run the following script in Microsoft SQL Query Analyzer, in SQL Server Management Studio, or in the Support Administrator Console:

    ```sql
    use DYNAMICS
    declare
    @companyDBName as char(5),
    @version as numeric(3,2),
    @verMajor as int,
    @verMinor as int,
    @verOldMajor as int,
    @verOldMinor as int,
    @verBuild as int,
    @companyID as smallint 
    set nocount on 
    set @companyDBName = '<Company_Database_Name>' 
    set @version = 8 
    set @verBuild = 0
    
    if (@version = 8.0 or @version = 8)
    begin
               set @verMajor = 8 
               set @verMinor = 0 
               set @verBuild = 0
               set @verOldMajor = 8 
               set @verOldMinor = 0
     
    end
    set @companyID = (select CMPANYID from SY01500 where INTERID = @companyDBName)
    
    delete DB_Upgrade where PRODID <>0 and db_name = @companyDBName
    
    
    delete DU000020 where PRODID <>0 and companyID = @companyID
    
    update DB_Upgrade set db_verMajor = @verMajor, db_verMinor = @verMinor, db_verOldMajor = @verOldMajor, db_verOldMinor = @verOldMinor, db_verBuild=@verBuild, db_verOldBuild=@verBuild, db_status = 0
    where PRODID = 0 and db_name = @companyDBName
    
    update DU000020 set versionMajor = @verMajor, versionMinor = @verMinor, versionBuild = @verBuild  where companyID = @companyID and PRODID = 0
    
    delete DU000030 where companyID = @companyID
    
    delete duLCK
    
    set nocount off
    ```

    > [!NOTE]
    > In this script, replace the *\<Company_Database_Name>* placeholder with the name of the company database. For example, if a company that is named Adventureworks has a database that is named TWO, type **TWO**.

3. Rename the current Dexsql.log file, and then start Microsoft Dynamics GP Utilities to restart the upgrade.

If the update is still unsuccessful, contact Technical Support for Microsoft Dynamics at 888-477-7877.

> [!NOTE]
> If you contact Technical Support for Microsoft Dynamics, or if you visit the Technical Support for Microsoft Dynamics Web site, provide the Dexsql.log file for the update. Additionally, provide the results from the following script:

```sql
SELECT b.fileOSName, a.fileNumber, a.PRODID, a.Status, a.errornum, a.errordes, c.CMPANYID, c.INTERID
      FROM DYNAMICS.dbo.DU000030 a
      JOIN
      DYNAMICS.dbo.DU000010 b
      ON a.fileNumber = b.fileNumber
      AND a.PRODID = b.PRODID
      JOIN
      DYNAMICS.dbo.SY01500 c
      ON a.companyID = c.CMPANYID
      WHERE (a.Status <> 0 or a.errornum <> 0) and a.Status <>15
```

### Update from Microsoft Dynamics GP 9.0, Microsoft Dynamics GP 10.0, or Microsoft Dynamics GP 2010 to Microsoft Dynamics GP 10.0, Microsoft Dynamics GP 2010 or Microsoft Dynamics GP 2013

To restart the upgrade of a company database from Microsoft Dynamics GP 9.0 to Microsoft Dynamics GP 10.0, follow these steps:

1. Restore a backup of the company database that was made before the upgrade was done.
2. Restore a backup of the DYNAMICS database that was made before the upgrade was done. Restore the backup to a database that is named OLDDYNAMICS.

    If you use SQL Server Enterprise Manager, follow these steps:

      1. Select **Start**.
      2. Select **Programs**.
      3. Point to **Microsoft SQL Server**, and then select **Enterprise Manager**.
      4. Expand **Microsoft SQL Servers**, expand **SQL Server Group**, and then expand the instance of SQL Server.
      5. Right-click **Database**, and then select **New Database**,
      6. In the **Database Name** field, enter OLDDYNAMICS, and then select **OK**.
      7. In **Enterprise Manager**, right-click the **OLDDYNAMICS** database, select **All Tasks**, and then select **Restore Database**.
      8. On the **General** tab, verify that the **OLDDYNAMICS** database is selected in the **Restore as database** field.
      9. In the **Restore** section, select the **From device** check box.
      10. In the **Parameters** section, select **Select Devices**.
      11. In the Choose Restore Devices window, select **Add**.
      12. In the Choose Restore Destination window, select the ellipsis button (...) next to the **File name** field.
      13. In the Backup Device Location window, expand the folders, and then locate the backup of the Dynamics database.
      14. Select **OK** repeatedly until you return to the Restore Database window.
      15. Select the **Options** tab.
      16. Select the **Force restore over existing database** check box.
      17. Verify that a valid path appears in the **Move to physical file name** field, and then verify that the .mdf and .ldf file names are for the test company database that you created in step 1.

          > [!NOTE]
          > The logical file name reflects the name of the live database. Do not change the logical file name.

      18. Select **OK** to start restoring the backup Dynamics database into the OLDDYNAMICS database.
      19. When the restoration is completed successfully, select **OK**.

    If you use SQL Server Management Studio 2005 or SQL Management Studio 2008, follow these steps:

      1. Select **Start**, and then select **Programs**.
      2. Point to **Microsoft SQL Server 2005** or **Microsoft SQL Server 2008**, and then select **SQL Server Management Studio**.
          > [!NOTE]
          >The Connect to Server window opens.
      3. In the **Server name** box, type the name of the instance of SQL Server.
      4. In the **Authentication** list, select **SQL Authentication**.
      5. In the **User name** box, type **sa**.
      6. In the **Password** box, type the password for the sa user, and then select **Connect**.
      7. In the **Object Explorer** section, right-click **Databases**, and then select **New Database**.
      8. In the **Database Name** field, enter OLDDYNAMICS, and then select **OK**.
      9. Right-click the test company database, point to **Tasks**, point to **Restore**, and then select **Database**.
      10. In the **Source for Restore** area, select **From Device**, and then select the ellipsis button (...).
      11. In the **Backup Location** area, select **Add**.
      12. Locate the backup of the Dynamics database, and then select **OK**.

3. Run the following script in Microsoft SQL Query Analyzer, in SQL Server Management Studio, or in the Support Administrator Console.

    ```sql
    declare @CompanyDb varchar(5)
    set @CompanyDb = '<Company_Database_Name>'
    /*Converting DU000020 back to Pre-Update Values*/
    delete a from DYNAMICS..DU000020 a 
    inner join DYNAMICS..SY01500 b on a.companyID = b.CMPANYID
    where b.INTERID = @CompanyDb
    insert into DYNAMICS..DU000020 (companyID, PRODID, versionMajor, versionMinor, versionBuild) 
    select companyID, PRODID, versionMajor, versionMinor, versionBuild from OLDDYNAMICS..DU000020 where companyID in 
    (select CMPANYID from DYNAMICS..SY01500 where INTERID = @CompanyDb)
    /*Converting DU000030 back to Pre-Update Values*/
    delete a from DYNAMICS..DU000030 a 
    inner join DYNAMICS..SY01500 b on a.companyID = b.CMPANYID
    left outer join OLDDYNAMICS..DU000030 c on a.fileNumber = c.fileNumber and a.companyID = c.companyID
    where b.INTERID = @CompanyDb and c.fileNumber is null and c.companyID is null
    
    /*Converting DB_Upgrade back to Pre-Update Values*/
    delete DYNAMICS..DB_Upgrade where [db_name] = @CompanyDb
    
    insert into DYNAMICS..DB_Upgrade ([db_name], PRODID, db_verMajor, db_verMinor, db_verBuild, db_verOldMajor, db_verOldMinor, db_verOldBuild, db_status, start_time, stop_time)
    select [db_name], PRODID, db_verMajor, db_verMinor, db_verBuild, db_verOldMajor, db_verOldMinor, db_verOldBuild, db_status, start_time, stop_time
    from OLDDYNAMICS..DB_Upgrade where [db_name] = @CompanyDb
    delete DYNAMICS..dulck
    ```

    > [!NOTE]
    > In this script, replace the *\<Company_Database_Name>* placeholder with the name of the company database. For example, if a company that is named Adventureworks has a database that is named TWO, type **TWO**.

4. Rename the current Dexsql.log file, and then start Microsoft Dynamics GP Utilities to complete the restart of the upgrade.

If the update is still unsuccessful, contact Technical Support for Microsoft Dynamics at 888-477-7877.

> [!NOTE]
> If you contact Technical Support for Microsoft Dynamics, or if you visit the Technical Support for Microsoft Dynamics Web site, provide the Dexsql.log file for the update. Additionally, provide the results from the following script:

```sql
SELECT b.fileOSName, a.fileNumber, a.PRODID, a.Status, a.errornum, a.errordes, c.CMPANYID, c.INTERID
      FROM DYNAMICS.dbo.DU000030 a
      JOIN
      DYNAMICS.dbo.DU000010 b
      ON a.fileNumber = b.fileNumber
      AND a.PRODID = b.PRODID
      JOIN
      DYNAMICS.dbo.SY01500 c
      ON a.companyID = c.CMPANYID
      WHERE (a.Status <> 0 or a.errornum <> 0) and a.Status <>15
```

## References

For more information, see [How to create a Dexsql.log file to troubleshoot error messages in Microsoft Dynamics GP](https://support.microsoft.com/help/850996).
