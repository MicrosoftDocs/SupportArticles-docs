---
title: Determine which version and edition of SQL Server Database Engine
description: This article describes the procedures to determine the version and edition of SQL Server Database Engine is running.
ms.date: 10/15/2022
ms.custom: sap:Installation, Patching and Upgrade
ms.topic: how-to
ms.reviewer: v-six
---

<!---Internal note: The screenshots in the article are being or were already updated. Please contact "gsprad" and "christys" for triage before making the further changes to the screenshots.
--->

# Determine which version and edition of SQL Server Database Engine is running

This article describes the procedures to determine the version and edition of SQL Server Database Engine is running.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 321185

To determine the version of SQL Server, you can use any of the following methods.

> [!NOTE]  
>  The version information follows *major.minor.build.revision* pattern. The "revision" information is not typically used when checking version of SQL Server.

- **Method 1:** Connect to the server by using Object Explorer in SQL Server Management Studio. After Object Explorer is connected, it will show the version information in parentheses, together with the user name that is used to connect to the specific instance of SQL Server.

- **Method 2:** Look at the first few lines of the Errorlog file for that instance. By default, the error log is located at `Program Files\Microsoft SQL Server\MSSQL.n\MSSQL\LOG\ERRORLOG` and _ERRORLOG.n_ files. The entries may resemble the following one:

  ```output
  2011-03-27 22:31:33.50 Server Microsoft SQL Server 2008 (SP1) - 10.0.2531.0 (X64)
  March 29 2009 10:11:52
  Copyright (c) 1988-2008 Microsoft Corporation
  Express Edition (64-bit)
  on Windows NT 6.1 <X64> (Build 7600: )
  ```

  This entry provides all the necessary information about the product, such as version, product level, 64-bit versus 32-bit, the edition of SQL Server, and the OS version on which SQL Server is running.

  > [!NOTE]
  > The output of this query has been enhanced to show additional information, as documented in the blog post article, [What build of SQL Server are you using?](https://techcommunity.microsoft.com/t5/sql-server-support/what-build-of-sql-server-are-you-using/ba-p/318613), for the following versions:
  >
  > - SQL Server 2014 RTM CU10 and later versions
  > - SQL Server 2014 Service Pack 1 CU3 and later versions
  > - SQL Server 2012 Service Pack 2 CU7 and later versions

- **Method 3:** Connect to the instance of SQL Server, and then run the following query:

  ```sql
  Select @@version
  ```

  An example of the output of this query is the following:

  ```output
  Microsoft SQL Server 2008 (SP1) - 10.0.2531.0 (X64)
  March 29 2009 10:11:52
  Copyright (c) 1988-2008 Microsoft Corporation Express Edition (64-bit)
  on Windows NT 6.1 <X64> (Build 7600: )
  ```

  > [!NOTE]
  > The output of this query has been enhanced to show additional information. This is documented in the blog post article, [What build of SQL Server are you using?](https://techcommunity.microsoft.com/t5/sql-server-support/what-build-of-sql-server-are-you-using/ba-p/318613), for the following versions:
  >
  > - SQL Server 2014 RTM CU10 and later versions
  > - SQL Server 2014 Service Pack 1 CU3 and later versions
  > - SQL Server 2012 Service Pack 2 CU7 and later versions
  >
  > :::image type="content" source="media/find-my-sql-version/enhanced-output.svg" alt-text="Screenshot of an example of enhanced output for SQL Server 2012 Service Pack 2 CU7. (SP2-CU7) is added in the first row.":::

- **Method 4:** Connect to the instance of SQL Server, and then run the following query in SQL Server Management Studio (SSMS):

  ```sql
  SELECT SERVERPROPERTY('productversion'), SERVERPROPERTY ('productlevel'), SERVERPROPERTY ('edition')
  ```

  > [!NOTE]
  > This query works for any instance of SQL Server 2000 or a later version.

  The following results are returned:

  - The product version (for example, 10.0.1600.22)
  - The product level (for example, RTM)
  - The edition (for example, Enterprise)

  For example, the results resemble the following.
  
  |product version|product level|edition|
  |---|---|---|
  | 14.0.2027.2|RTM| Developer Edition (64-bit) |

  > [!NOTE]
  >
  > - The SERVERPROPERTY function returns individual properties that relate to the version information, although the @@VERSION function combines the output into one string. If your application requires individual property strings, you can use the SERVERPROPERTY function to return them instead of parsing the @@VERSION results.
  >
  > - This method also works for SQL Azure Database instances. For more information, see the following topic in SQL Server Books Online [SERVERPROPERTY (Transact-SQL)](/sql/t-sql/functions/serverproperty-transact-sql).
  >
  > - Starting with [SQL Server 2014 RTM Cumulative Update 10](https://support.microsoft.com/help/3094220) and [SQL Server 2014 Service Pack 1 Cumulative Update 3](https://support.microsoft.com/help/3094221), additional properties have been added to ServerProperty statement. For a complete list review [SERVERPROPERTY (Transact-SQL)](/sql/t-sql/functions/serverproperty-transact-sql).

- **Method 5:** Starting in SQL Server 2008, you can also use the Installed SQL Server Features Discovery report. This report can be found by locating the **Tools** page of SQL Server Installation Center. This tool gives information about all the instances of SQL Server that are installed on the system. These include client tools such as SQL Server Management Studio. The only thing to be aware of is that this tool can be run locally only on the system where SQL Server is installed. It can't be used to obtain information about remote servers. For more information, see [Validate a SQL Server Installation](/sql/database-engine/install-windows/validate-a-sql-server-installation).

  A snapshot of a sample report is as follows:

  :::image type="content" source="media/find-my-sql-version/sample-report.svg" alt-text="Screenshot shows a sample SQL Server 2016 Setup Discovery report." border="false":::

## See also

- [Determine version information of SQL Server components and client tools](components-client-tools-versions.md)
- [Latest updates and version history for SQL Server](download-and-install-latest-updates.md)
