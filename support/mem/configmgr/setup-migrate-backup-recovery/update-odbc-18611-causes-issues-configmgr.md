---
title: Updating ODBC Driver for SQL Server to 18.6.1.1 update causes issues in Configuration Manager
description: Describes issues that appear after updating to ODBC Driver for SQL Server to version 18.6.1.1 in Configuration Manager.
ms.date: 01/16/2025
ms.reviewer: kaushika, payur
ms.author: payur
ms.custom: sap:Configuration Manager Setup, High Availability, Migration and Recovery\Site Installation or Prerequisites
---
# Updating ODBC Driver for SQL Server to 18.6.1.1 update causes issues in Configuration Manager

*Applies to*: Configuration Manager

## Symptoms

After you install the [Microsoft ODBC driver for SQL Server on Windows version 18.6.1.1](/sql/connect/odbc/windows/release-notes-odbc-sql-server-windows#186), the installation of new ConfigMgr site fails with the following error in ConfigMgrSetup.log:

```output
    INFO: Database watermark:
    ERROR: Failed parsing the watermark from the database: 80070057.
    INFO: Could not retrieve and process both watermarks, will import all tables from disk.
    INFO: On disk watermark is newer than the one in the database. All tables will be imported.
    INFO: Starting data import data to table: LU_LicensedProduct
    ***     MERGE [dbo].[LU_LicensedProduct] AS TARGET ~    using (select [LicensedProductID], [ProductPool], [ProductName], ~                  [FamilyName], [VersionSequence], [VersionCode], ~                  GETUTCDATE() , N'$CD' ~                  from tempdb.dbo.temp_LU_LicensedProduct) ~            as SOURCE ( [LicensedProductID], [ProductPool], [ProductName], ~                        [FamilyName], [VersionSequence], [VersionCode], ~                        [LastUpdated], [SourceSite]) ~    ON SOURCE.[LicensedProductID] = TARGET.[LicensedProductID] ~    when matched and (~        TARGET.[ProductPool] != SOURCE.[ProductPool] OR ~        TARGET.[ProductName] != SOURCE.[ProductName] OR ~        TARGET.[FamilyName] != SOURCE.[FamilyName] OR ~        TARGET.[VersionSequence] != SOURCE.[VersionSequence] OR ~        TARGET.[VersionCode] != SOURCE.[VersionCode] OR ~        TARGET.[SourceSite] != SOURCE.[SourceSite]) ~    then ~    UPDATE SET ~        [ProductPool] = SOURCE.[ProductPool], ~        [ProductName] = SOURCE. 
    *** [23000][515][Microsoft][ODBC Driver 18 for SQL Server][SQL Server]Cannot insert the value NULL into column 'VersionCode', table 'CM_TS1.dbo.LU_LicensedProduct'; column does not allow nulls. UPDATE fails.
...
    ERROR: FAILED to import data to table LU_LicensedProduct
    ERROR: Failed to import data from CSV files
    ERROR: Failed to import Asset Intelligence data into the site database.
```

In the existing environments, after updating the ODBC Driver for SQL Server to version 18.6.1.1, the Client Notification feature might stop working. In particular, you notice that "Currently Logged on User" column isn't populated in the Configuration Manager console. You also see the following error message in the BGBMgr.log on the Site Server:

```output
BCP queued 18 rows for currently logged on users
*** [23000][515][Microsoft][ODBC Driver 18 for SQL Server][SQL Server]Cannot insert the value NULL into column 'CurrentLogonUser', table 'CM_P01.dbo.BGB_LiveDataLogonUsersPending'; column does not allow nulls. INSERT fails.
*** [01000][3621][Microsoft][ODBC Driver 18 for SQL Server][SQL Server]The statement has been terminated.
*** bcp_batch() failed
ERROR: Failed to send batched rows
ERROR: Failed to execute task class LiveDataBcp
ERROR: Failed to bcp file
ERROR: Failed to execute task class LiveDataProcessTask
WARNING: Failed to process file Bgbtdhs3.BLD, move it to bad inbox
Begin to move file from E:\Microsoft Configuration Manager\inboxes\bgb.box\Bgbtdhs3.BLD to E:\Microsoft Configuration Manager\inboxes\bgb.box\bad\Bgbtdhs3.BLD
```

## Cause

ODBC Driver for SQL Server version 18.6.1.1 includes a change that enforces stricter handling of NULL values for non-nullable columns. This change can lead to failures in Configuration Manager operations that attempt to insert NULL values into such columns, resulting in errors during Site Installation and "Currently Logged on User" reporting.

## Resolution

Downgrade the ODBC Driver for SQL Server to [version 18.5.2.1](/sql/connect/odbc/windows/release-notes-odbc-sql-server-windows#1852) or use a [version 18.4.1.1](/sql/connect/odbc/windows/release-notes-odbc-sql-server-windows#184) being included with Configuration Manager version 2503 and later as Redistributable content.

## More information

Microsoft plans resolving the issue in the next ODBC Driver for SQL Server release expected in the middle of 2026. Note, there are no security updates in ODBC Driver for SQL Server version 18.6.1.1.

See also: [Support lifecycle for Microsoft ODBC Driver for SQL Server](/sql/connect/odbc/support-lifecycle)
