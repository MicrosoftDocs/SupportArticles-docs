---
title: Updating ODBC Driver for SQL Server to 18.6.1.1 causes issues in Configuration Manager
description: Describes issues that appear after you update ODBC Driver for SQL Server to version 18.6.1.1 in Configuration Manager, and explains how to work around these issues until a permanent fix becomes available.
ms.date: 01/30/2026
ms.reviewer: kaushika, payur, v-tappelgate
ms.custom: sap:Configuration Manager Setup, High Availability, Migration and Recovery\Site Installation or Prerequisites
---
# Updating ODBC Driver for SQL Server to version 18.6.1.1 causes issues in Configuration Manager

*Applies to*: Configuration Manager

## Summary

After you update Microsoft ODBC Driver for SQL Server to version 18.6.1.1, Configuration Manager site installations might fail, and Client Notification features might stop working. This article provides information about these issues and explains how to work around them until a permanent fix becomes available.

## Symptoms

After you install [Microsoft ODBC driver for SQL Server on Windows, version 18.6.1.1](/sql/connect/odbc/windows/release-notes-odbc-sql-server-windows#186), you experience the following symptoms.

### Symptom: You can't install a new ConfigMgr site

You try to create a new site, but the operation fails. The ConfigMgrSetup.log file reports an error that resembles the following example:

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

### Symptom: Client Notification stops working

In existing environments, in the Configuration Manager console, you notice that the **Currently Logged on User** column doesn't populate. You also see the following error message in the BGBMgr.log on the Site Server:

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

ODBC Driver for SQL Server version 18.6.1.1 includes a change that enforces stricter handling of NULL values for non-nullable columns. This change can cause failures in Configuration Manager operations that attempt to insert NULL values into such columns. Such failures generate errors during Site Installation and "Currently Logged on User" reporting.

## Workaround

Make one of the following changes to the ODBC Driver for SQL Server:

- Downgrade the driver to [version 18.5.2.1](/sql/connect/odbc/windows/release-notes-odbc-sql-server-windows#1852)
- Downgrade the driver to [version 18.4.1.1](/sql/connect/odbc/windows/release-notes-odbc-sql-server-windows#184). Configuration Manager version 2503 and later versions include this version of the driver as Redistributable content.

> [!NOTE]  
> ODBC Driver for SQL Server version 18.6.1.1 doesn't contain security updates, so rolling back the driver doesn't introduce vulnerabilities.

## More information

Microsoft plans resolving the issue in an upcoming ODBC Driver for SQL Server release. For more information, see [Support lifecycle for Microsoft ODBC Driver for SQL Server](/sql/connect/odbc/support-lifecycle).
