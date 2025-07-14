---
title: Determine the version and edition of SQL Server Database Engine
description: This article describes the procedures to determine the version and edition of SQL Server Database Engine that is running.
ms.date: 01/10/2025
ms.topic: how-to
ms.custom: sap:Installation, Patching, Upgrade, Uninstall
ms.reviewer: v-six, jopilov
---

<!---Internal note: The screenshots in the article are being or were already updated. Please contact "gsprad" and "christys" for triage before making the further changes to the screenshots.
--->

# Determine which version and edition of SQL Server Database Engine is running

This article describes the procedures to determine the version and edition of SQL Server Database Engine that is running.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 321185

To determine the version of SQL Server, you can use any of the following methods.

> [!NOTE]  
>  The version information follows the *major.minor.build.revision* pattern. The "revision" information is typically not used when checking the version of SQL Server.

## Method 1: Connect to the server by using SQL Server Management Studio

Connect to the server by using Object Explorer in [SQL Server Management Studio (SSMS)](/sql/ssms/sql-server-management-studio-ssms). Once connected, the version information will be displayed in parentheses, along with the username used to connect to the specific instance of SQL Server. For more information on how to connect to SQL Server using Object Explorer, see [Connect to a SQL Server or Azure SQL Database](/sql/ssms/object/connect-to-an-instance-from-object-explorer).

## Method 2: Look at the first few lines of the Errorlog file

Look at the first few lines of the *Errorlog* file for that instance. By default, the error log is located at `Program Files\Microsoft SQL Server\MSSQL.n\MSSQL\LOG\ERRORLOG` in _ERRORLOG.n_ files. The entries may resemble the following one:

```output
2024-09-05 16:56:22.35 Server      Microsoft SQL Server 2022 (RTM-CU14) (KB5038325) - 16.0.4135.4 (X64)  
Jul 10 2024 14:09:09  
Copyright (C) 2022 Microsoft Corporation 
Developer Edition (64-bit) on Windows 11 Enterprise 10.0 <X64> (Build 22631: ) (Hypervisor)
```

This entry provides information about the product, such as version, product level, 64-bit versus 32-bit, the edition of SQL Server, and the OS version on which SQL Server is running.

## Method 3: Look at the output after running the query "SELECT @@VERSION"

Connect to the instance of SQL Server, and then run the following query:

```sql
SELECT @@VERSION
```

Here's an example of the output of this query:

```output
Microsoft SQL Server 2022 (RTM-CU14) (KB5038325) - 16.0.4135.4 (X64)   Jul 10 2024 14:09:09   Copyright (C) 2022 Microsoft Corporation  Developer Edition (64-bit) on Windows 11 Enterprise 10.0 <X64> (Build 22631: ) (Hypervisor) 
```

From the output, you can determine the SQL Server product's version, service pack level, cumulative update level, or security update level (if applicable).

## Method 4: Use the SERVERPROPERTY function 

Connect to the instance of SQL Server, and then run the following query in [SSMS](/sql/ssms/sql-server-management-studio-ssms):

```sql
SELECT SERVERPROPERTY('productversion'), SERVERPROPERTY ('productlevel'), SERVERPROPERTY ('edition')
```

The following results are returned:

- The product version (for example, 16.0.4135.4)
- The product level (for example, RTM)
- The edition (for example, Developer)

For example, the results resemble the following.

|Product version|Product level|Edition|
|---|---|---|
| 16.0.4135.4|RTM| Developer Edition (64-bit) |

> [!NOTE]
>
> - The `SERVERPROPERTY` function returns individual properties related to the version information, although the `@@VERSION` function combines the output into one string. If your application requires individual property strings, you can use the `SERVERPROPERTY` function to return them instead of parsing the `@@VERSION` results.
>
> - This method also works for SQL Azure Database instances. For more information, see [SERVERPROPERTY (Transact-SQL)](/sql/t-sql/functions/serverproperty-transact-sql).
>
> - Starting with [SQL Server 2014 RTM Cumulative Update 10](https://support.microsoft.com/help/3094220) and [SQL Server 2014 Service Pack 1 Cumulative Update 3](https://support.microsoft.com/help/3094221), additional properties have been added to the `SERVERPROPERTY` statement. For a complete list, see [SERVERPROPERTY (Transact-SQL)](/sql/t-sql/functions/serverproperty-transact-sql).

## Method 5: Use the "Installed SQL Server features discovery report"

You can also use the **Installed SQL Server features discovery report**. You can find this report on the **Tools** page of the SQL Server Installation Center. This tool provides information about all the instances of SQL Server that are installed on the system, including client tools such as SSMS. Note that this tool can be run locally only on the system where SQL Server is installed. It can't be used to obtain information about remote servers. For more information, see [Validate a SQL Server Installation](/sql/database-engine/install-windows/validate-a-sql-server-installation).

A snapshot of a sample report is as follows:

:::image type="content" source="media/find-my-sql-version/sample-report.svg" alt-text="Screenshot shows a sample SQL Server 2016 Setup Discovery report." border="false":::

## See also

- [Determine version information of SQL Server components and client tools](components-client-tools-versions.md)
- [Latest updates and version history for SQL Server](download-and-install-latest-updates.md)
