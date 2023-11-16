---
title: Transaction log file doesn't grow
description: This article provides resolutions for the problem where the SQL Server database transaction log file doesn't grow by the configured file growth value.
ms.date: 07/23/2020
ms.custom: sap:Administration and management
ms.reviewer: SureshKa
---
# The SQL Server database transaction log file doesn't grow by the configured file growth value

This article helps you resolve the problem where the SQL Server database transaction log file doesn't grow by the configured file growth value.

_Original product version:_ &nbsp; SQL Server 2008, SQL Server 2008 R2  
_Original KB number:_ &nbsp; 2633151

## Symptoms

The file growth value that is configured for the SQL Server database transaction log file is 4 gigabytes (GB) or multiples thereof (for example, 8 GB, 12 GB, and so on). However, the transaction log file does not grow by that value. Instead, the transaction log file grows by increments of only 250 kilobytes (KB). Additionally, you notice that there are lots of virtual log files in the transaction log file.

## Resolution

- **For SQL Server 2008 R2**

    The fix for this issue was first released in KB2633145 (Cumulative update package 11 for SQL Server 2008 R2).

    > [!NOTE]
    > Because the builds are cumulative, each new fix release contains all the hotfixes and all the security fixes that were included with the previous SQL Server 2008 R2 fix release. We recommend that you consider applying the most recent fix release that contains this hotfix. For more information, see [The SQL Server 2008 R2 builds that were released after SQL Server 2008 R2 was released](https://support.microsoft.com/help/981356).

- **For SQL Server 2008 R2 Service Pack 1**

    The fix for this issue was first released in Cumulative Update 4. For more information about how to obtain this cumulative update package for SQL Server 2008 R2, see [Cumulative update package 4 for SQL Server 2008 R2 Service Pack 1](https://support.microsoft.com/help/2633146).

    > [!NOTE]
    > Because the builds are cumulative, each new fix release contains all the hotfixes and all the security fixes that were included with the previous SQL Server 2008 R2 fix release. We recommend that you consider applying the most recent fix release that contains this hotfix. For more information, see [The SQL Server 2008 R2 builds that were released after SQL Server 2008 R2 was released](https://support.microsoft.com/help/981356).

## Workaround

Change the file growth value for the SQL Server database transaction log file so that it is not exactly divisible by 4 GB.

## More information

You can use the following query to identify the SQL Server database transaction log file:

```sql
SELECT name FROM sys.master_files name
FROM sys.master_files WHERE database_id = DB_ID('<db name>')
AND type = 1
AND is_percent_growth = 0
AND growth % 524288 = 0

```

For more information about the products or tools that automatically check for file growth vales of 4 GB or multiples thereof on your instance of SQL Server and on the versions of the SQL Server product, see the following table:

|Rule software|Rule title|Rule description|Product versions against which the rule is evaluated|
|---|---|---|---|
|System Center Advisor|SQL Server database file might not grow using the configured growth value|System Center Advisor determines whether the SQL Server database transaction log file is configured for a growth value of 4 GB or multiples thereof and generates a warning if this is the case. Review the information that is provided in the **Information Collected** section of the warning, and make the necessary changes to the transaction log that is affected.|SQL Server 2008, SQL Server 2008 R2|
  
If you have large number of virtual log files in the transaction log, you will encounter long database recovery. For more information, see [Database operations take a long time to complete, or they trigger errors when the transaction log has numerous virtual log files](https://support.microsoft.com/help/2028436).
