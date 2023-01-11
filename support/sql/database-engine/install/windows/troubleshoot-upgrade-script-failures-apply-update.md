---
title: Troubleshoot upgrade script failures when applying an update
description: Helps you troubleshoot and solve upgrade script failures when you apply an update.
ms.date: 01/10/2023
ms.custom: sap:Installation, Patching and Upgrade
ms.reviewer: ramakoni
author: sevend2
ms.author: v-sidong
ms.prod: sql
---

# Troubleshoot upgrade script failures when applying an update

## Database upgrade scripts

 When you either apply a Cumulative update to an existing instance of SQL Server or you update it to a newer version, the associated setup process runs the procedure in two different phases:

- In the initial phase, the update only updates the binaries, not the database and its objects.  

- Once the upgrade completes and the service restarts for the first time, the update process starts the database upgrade using the script *msdb110_upgrade.sql* in the folder: *C:\Program Files\Microsoft SQL Server\MSSQLXX.YYYY\MSSQL\Install\\*.

These scripts ensure that the system databases are ready for new fixes/features delivered as part of the corresponding Cumulative Updates (CU) or Service Packs (SP) or for the new version. A complete installation of CU and SP or upgrading to new version requires the successful execution of the database upgrade script. Failure to do so can cause unexpected issues with your SQL Server instance. Upgrade script execution failure is a common cause of CU and SP installation failures. This troubleshooting series covers common failures in this category and the steps you can take to solve them.

## General troubleshooting methodology

As noted in [MSSQLSERVER_912](/sql/relational-databases/errors-events/mssqlserver-912-database-engine-error), when upgrade scripts fail, the installation wizard reports the error message "Wait on the Database Engine recovery handle failed. Check the SQL Server error log for potential causes". The SQL Server error log will have entries for 912 and 3417 error messages. Errors 912 and 3417 are generic errors associated with database upgrade script failures. And the messages preceding error 912 usually provide information on what exactly failed during the execution of these scripts. Troubleshooting and fixing these errors will require you to start SQL Server with trace flag 902.

> [!NOTE]
> Starting SQL Server with trace flag 902 is part of troubleshooting and fixing upgrade script errors. It's applicable to all the scenarios where a CU or SP or upgrading to new version fails during the execution of the database upgrade script. To start your SQL Server instance using trace flag 902, see [Steps to start SQL Server with trace flag 902](/sql/relational-databases/errors-events/mssqlserver-912-database-engine-error#steps-to-start--with-trace-flag-902).

Once you start SQL Server with trace flag 902, you can select one of the following articles to troubleshoot and solve your issues.

## Database upgrade script error messages

"Wait on the Database Engine recovery handle failed" is the common error message for the following errors:

- [Error 2714: Object already exists](upgrade-fails-error-code-2714.md)
- [Error 574: Config statement can't be used inside a transaction](upgrade-fails-error-code-574.md)
- [Error 4860: File name does not exist](sql-server-upgrade-failed-error-4860-upgrade-script.md)
- [Error 1802: Create temporary database failed](upgrade-fails-errors-598-1802.md)
- [Error 15173: Issues dropping server principals](sql-server-upgrade-failed-error-15173-upgrade-script.md)
- [Error 17182: TLS 1.0 disabled](sql-server-upgrade-failed-error-17182-upgrade-script.md)
- [Error 1712: Online index operations can only be performed in Enterprise edition](sql-server-upgrade-failed-error-1712-upgrade-script.md)
