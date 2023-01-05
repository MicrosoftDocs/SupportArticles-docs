---
title: Troubleshooting upgrade script failures when applying an update
description: Troubleshooting upgrade script failures when you apply an update.
ms.date: 01/04/2023
ms.custom: sap:Installation, Patching and Upgrade
ms.reviewer: ramakoni
author: sevend2
ms.author: v-sidong
ms.prod: sql
---

# Troubleshooting upgrade script failures when applying an update

## Database upgrade scripts

Each update for SQL Server includes scripts to update system databases.  

- Starting with SQL Server 2008, when you upgrade or apply a patch on SQL Server, the update only upgrades the binaries, not the database and its objects.  

- Once the upgrade completes and the service restarts for the first time, it starts the database upgrade using the script *msdb110_upgrade.sql* that is located in the folder: *C:\Program Files\Microsoft SQL Server\MSSQLXX.YYYY\MSSQL\Install\\*.

These scripts ensure that the system databases are ready for new fixes/features that ship as part of the corresponding Cumulative Updates (CU) or the Service Packs (SP). Database upgrade scripts need to be executed successfully for a complete installation of CU and SP. Not doing so can cause unexpected issues with your SQL Server instance. Upgrade script execution failures are a frequent cause for CU and SP installation failures. This troubleshooting series covers common failures in this category and the steps you can take to solve these failures.

## Start SQL Server with trace flag 902

As noted in [MSSQLSERVER_912](/sql/relational-databases/errors-events/mssqlserver-912-database-engine-error), when upgrade scripts fail, the installation wizard reports an error message "Wait on the Database Engine recovery handle failed. Check the SQL Server error log for potential causes." and the SQL Server error log will have entries for 912 and 3417 error messages. The errors 912 and 3417 are generic errors associated with database upgrade script failures. And the messages preceding 912 error usually provide information on what exactly failed during the execution of these scripts. Troubleshooting and fixing these errors will require you to start SQL Server with trace flag 902.

> [!NOTE]
> Starting SQL Server with trace flag 902 is part of troubleshooting and fixing upgrade script errors. It's applicable to all the scenarios where a CU or SP fails during the database upgrade script execution phase. See [Steps to start SQL Server with trace flag 902](/sql/relational-databases/errors-events/mssqlserver-912-database-engine-error#steps-to-start--with-trace-flag-902) to start your SQL Server instance using trace flag 902.

Once you start SQL Server with trace flag 902, you can select one of the following articles to troubleshoot and solve your issues.

## Database upgrade script error messages

"Wait on the Database Engine recovery handle failed" is the common error message for the following errors:

- [MSSQLSERVER_912](/sql/relational-databases/errors-events/mssqlserver-912-database-engine-error)
- [Error 2714: Object already exists](upgrade-fails-error-code-2714.md)
- [Error 574: Config statement can't be used inside a transaction](upgrade-fails-error-code-574.md)
- [Error 4860: File name does not exist](link)
- [Error 1802: Create temporary database failed](upgrade-fails-errors-598-1802.md)
- [Error 15173: Issues dropping server principals](link)
- [Error 17182: TLS 1.0 disabled](link)
