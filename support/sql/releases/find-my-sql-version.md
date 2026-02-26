---
title: Find the Version and Edition of Your SQL Server Database Engine
description: Learn how to find the version and edition of your SQL Server Database Engine using methods like SSMS, error logs, T-SQL queries, and more.
ms.date: 01/21/2026
ms.topic: how-to
ms.custom: sap:Installation, Patching, Upgrade, Uninstall
ms.reviewer: jopilov, v-shaywood
---

<!---Internal note: The screenshots in the article are being or were already updated. Please contact "gsprad" and "aartigoyle" for triage before making the further changes to the screenshots.
--->

# Determine which version and edition of SQL Server Database Engine is running

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 321185

## Summary

Knowing your SQL Server Database Engine version and edition is essential for troubleshooting, planning upgrades, and ensuring compatibility with other components. This article explains several methods to find this information, including [SQL Server Management Studio (SSMS)](/sql/ssms/sql-server-management-studio-ssms), error log files, [T-SQL](/sql/t-sql/language-reference) queries, and the SQL Server Installation Center.

> [!NOTE]
> The version information follows the `major.minor.build.revision` pattern. The _revision_ information typically isn't used when you check the SQL Server version.

## Choose your method to determine version and edition

| Method                                                                         | Best for                   | Requirements                      |
| ------------------------------------------------------------------------------ | -------------------------- | --------------------------------- |
| [Object Explorer (SSMS)](#use-object-explorer-in-sql-server-management-studio) | Quick visual check         | SSMS installed, server connection |
| [Errorlog file](#view-the-errorlog-file)                                       | No connection needed       | File system access                |
| [SELECT @@VERSION](#run-the-select-version-query)                              | Scripting and automation   | Query access                      |
| [SERVERPROPERTY](#use-the-serverproperty-function)                             | Individual property values | Query access                      |
| [Discovery report](#use-the-installed-sql-server-features-discovery-report)    | All instances on system    | Local access only                 |

## Use Object Explorer in SQL Server Management Studio

Connect to the server by using Object Explorer in [SQL Server Management Studio (SSMS)](/sql/ssms/sql-server-management-studio-ssms). After you connect, the version information appears in parentheses, along with the username that you used to connect to the specific instance of SQL Server.

To learn how to connect to SQL Server by using Object Explorer, see [Connect to a SQL Server or Azure SQL Database](/sql/ssms/object/connect-to-an-instance-from-object-explorer).

## View the Errorlog file

Check the first few lines of the `Errorlog` file for that instance. By default, the error log is located at `Program Files\Microsoft SQL Server\MSSQL.n\MSSQL\LOG\ERRORLOG` in `ERRORLOG.n` files. The entries might resemble the following example:

```output
2024-09-05 16:56:22.35 Server      Microsoft SQL Server 2022 (RTM-CU14) (KB5038325) - 16.0.4135.4 (X64)  
Jul 10 2024 14:09:09  
Copyright (C) 2022 Microsoft Corporation 
Developer Edition (64-bit) on Windows 11 Enterprise 10.0 <X64> (Build 22631: ) (Hypervisor)
```

This entry provides product information like version, product level, 64-bit versus 32-bit architecture, the SQL Server edition, and the operating system version that SQL Server runs on.

## Run the SELECT @@VERSION query

Connect to the instance of SQL Server, and then run the following query:

```sql
SELECT @@VERSION
```

The following example shows the output of this query:

```output
Microsoft SQL Server 2022 (RTM-CU14) (KB5038325) - 16.0.4135.4 (X64)   Jul 10 2024 14:09:09   Copyright (C) 2022 Microsoft Corporation  Developer Edition (64-bit) on Windows 11 Enterprise 10.0 <X64> (Build 22631: ) (Hypervisor) 
```

From the output, you can identify the SQL Server product version, service pack level, cumulative update level, or security update level (if applicable). For more information, see [Latest updates and version history for SQL Server](download-and-install-latest-updates.md).

## Use the SERVERPROPERTY function

Connect to the instance of SQL Server, and then run the following query in [SSMS](/sql/ssms/sql-server-management-studio-ssms):

```sql
SELECT SERVERPROPERTY('productversion'), SERVERPROPERTY('productlevel'), SERVERPROPERTY('edition')
```

This query returns the following results:

- The product version (for example, 16.0.4135.4)
- The product level (for example, RTM)
- The edition (for example, Developer)

For example, the results might look like this:

| Product version | Product level | Edition                    |
| --------------- | ------------- | -------------------------- |
| 16.0.4135.4     | RTM           | Developer Edition (64-bit) |

> [!NOTE]
>
> - The `SERVERPROPERTY` function returns individual properties related to version information, while the `@@VERSION` function combines the output into one string. If your application requires individual property strings, use the `SERVERPROPERTY` function to return them instead of parsing the `@@VERSION` results.
>
> - This method also works for [Azure SQL Database](/azure/azure-sql/database/sql-database-paas-overview) instances. For more information, see [SERVERPROPERTY (Transact-SQL)](/sql/t-sql/functions/serverproperty-transact-sql).
>
> - Starting with [SQL Server 2014 RTM Cumulative Update 10](https://support.microsoft.com/help/3094220) and [SQL Server 2014 Service Pack 1 Cumulative Update 3](https://support.microsoft.com/help/3094221), more properties were added to `SERVERPROPERTY`. For a complete list, see [SERVERPROPERTY (Transact-SQL)](/sql/t-sql/functions/serverproperty-transact-sql).

## Use the Installed SQL Server features discovery report

Find the **Installed SQL Server features discovery report** on the **Tools** page of the SQL Server Installation Center. This report provides information about all the SQL Server instances installed on the system, including client tools like SSMS. This tool runs locally only on the system where SQL Server is installed. It can't get information about remote servers.

For more information, see [Validate a SQL Server Installation](/sql/database-engine/install-windows/validate-a-sql-server-installation).

The following image shows a sample report:

:::image type="content" source="media/find-my-sql-version/sample-report.svg" alt-text="Screenshot that shows a sample SQL Server 2016 Setup Discovery report." border="false":::

## Related content

- [Determine version information of SQL Server components and client tools](components-client-tools-versions.md)
- [Latest updates and version history for SQL Server](download-and-install-latest-updates.md)
- [SQL Server installation guide](/sql/database-engine/install-windows/install-sql-server)
