---
title: Error when you run the Sqlmaint Utility
description: This article provides a resolution for the problem that occurs when you run the Sqlmaint Utility after you upgrade from SQL Server 2000 SP4 to SQL Server 2008 or a later version.
ms.date: 09/25/2020
ms.custom: sap:Other tools
ms.reviewer: jamestod
---
# Error when you try to run the Sqlmaint Utility after you upgrade to SQL Server 2008 or a later version

This article helps you resolve the problem that occurs when you run the Sqlmaint Utility after you upgrade from SQL Server 2000 SP4 to SQL Server 2008 or a later version.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 955626

## Symptoms

You successfully upgrade Microsoft SQL Server 2000 Service Pack 4 (SP4) to SQL Server 2008 or 2008 R2. However, when you try to run the Sqlmaint Utility (Sqlmaint.exe), you receive the following error message:

> The SQLDMO 'Application' object failed to initialize (specific error: One of the library files needed to run this application cannot be found.)

> [!NOTE]
> This issue also occurs in SQL Server 2012

## Cause

This problem may occur if the SQL Server Distributed Management Objects (SQL-DMO) version that is installed cannot connect to an instance of SQL Server 2008 or SQL Server 2008 R2.

In SQL Server 2012 or a later version, SQL DMO is one of the discontinued features and customers are advised to use SQL Server Management Objects (SMO). For more information, see [Discontinued Database Engine Functionality in SQL Server 2012](/previous-versions/sql/sql-server-2012/ms144262(v=sql.110)).

| Category| Discontinued feature| Replacement |
|---|---|---|
|Programmability|SQL Server Distributed Management Objects (SQL-DMO)|SQL Server Management Objects (SMO)|
  
## Resolution

To resolve this problem, use one of the following methods.

## Method 1: Upgrade maintenance plans to the SQL Server 2008 or SQL Server 2008 R2 format (recommended)

This method migrates maintenance plans to the SQL Server 2008 format. If all older maintenance plans are upgraded, Method 2 is not required.

To use SQL Server Management Studio to upgrade maintenance plans, follow these steps:

1. Start SQL Server Management Studio, and then connect to the affected instance of SQL Server.
2. In Object Explorer, expand **Management**, expand **Legacy**, and then expand **Database Maintenance Plans**.
3. Right-click each maintenance plan that you want to migrate, and then click **Migrate**. This step creates a new, non-legacy maintenance plan in the SQL Server 2008 format.
4. Right-click the **Database Maintenance Plans** folder, and then click **Refresh** to update the maintenance plans in the Management folder.

## Method 2: Install the latest SQL-DMO from the SQL Server Backward Compatibility Setup

This method installs the latest version of SQL-DMO to enable the older maintenance plan format to continue working in SQL Server 2008.

> [!NOTE]
> If you no longer have any maintenance plans in the older format, this method is not required.

To run the SQL Server Backward Compatibility Setup Wizard, follow these steps:

1. Locate the following installation source folder for SQL Server 2008: `drive :\Servers\Setup`.

   > [!NOTE]
   > The **drive** placeholder is the drive letter of the DVD drive.

2. Double-click the **SQLServer2005_BC.ms** i file to run the SQL Server Backward Compatibility Setup Wizard, and then click **Next**.

3. Click **Modify**, and then click **Next**.
4. Make sure that the **SQL Distributed management Objects (SQL-DMO)** feature is set to install on the local hard disk drive, and then click **Next**.
5. Click **Install**.

## References

- [sqlmaint Utility](/previous-versions/sql/sql-server-2008/ms162827(v=sql.100))

- [SQL Server Backward Compatibility](/previous-versions/sql/sql-server-2008/cc707787(v=sql.100))

- [SQL Server Backward Compatibility](/previous-versions/sql/sql-server-2008/cc707787(v=sql.100))

## Applies to

- SQL Server 2008 Developer
- SQL Server 2008 Enterprise
- SQL Server 2008 Express
- SQL Server 2008 Express with Advanced Services
- SQL Server 2008 Standard
- SQL Server 2008 Web
- SQL Server 2008 Workgroup
- SQL Server 2008 R2 Datacenter
- SQL Server 2008 R2 Developer
- SQL Server 2008 R2 Enterprise
- SQL Server 2008 R2 Express
- SQL Server 2008 R2 Express with Advanced Services
- SQL Server 2008 R2 Standard
- SQL Server 2008 R2 Standard Edition for Small Business
- SQL Server 2008 R2 Web
- SQL Server 2008 R2 Workgroup
