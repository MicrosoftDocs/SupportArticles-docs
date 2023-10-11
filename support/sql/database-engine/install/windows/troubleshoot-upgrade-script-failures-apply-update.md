---
title: Troubleshoot upgrade script failures when applying an update
description: This article helps you troubleshoot and solve upgrade script failures when you apply an update.
ms.date: 07/08/2023
ms.custom: sap:Installation, Patching and Upgrade
ms.reviewer: ramakoni, v-sidong, v-jayaramanp
---

# Troubleshoot upgrade script failures when applying an update

## Database upgrade scripts

T-SQL upgrade scripts are shipped together with every SQL Server cumulative update. They are executed after the SQL Server binaries are replaced with the latest versions. When you either apply a Cumulative Update (CU) to an existing instance of SQL Server or update it to a newer version, the associated setup process runs the procedure in two different phases:

- In the initial phase, the setup process only updates the binaries (DLLs, EXEs), not the database and its objects.

- After the upgrade completes and the service restarts for the first time, the update process starts the database upgrade using the script *msdb110_upgrade.sql* in the folder *C:\Program Files\Microsoft SQL Server\MSSQLXX.YYYY\MSSQL\Install\\*.

These T-SQL scripts make sure that the system databases are ready for new fixes or features delivered as part of the corresponding CUs or Service Packs (SP) or for the new version. A complete installation of CU and SP or upgrading to a new version requires the successful execution of the database upgrade script. Failure to do so can cause unexpected issues with your SQL Server instance. Upgrade script execution failure is a common cause of CU and SP installation failures. This troubleshooting series covers common failures in this category and the steps you can take to solve them.

## General troubleshooting methodology

1. Review the SQL Server error logs (ERRORLOG) for details about the failure.
1. To bypass running the upgrade script, start SQL Server by using [trace flag 902](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf902).
1. Address the cause of the failure based on different scenarios.

As noted in [MSSQLSERVER_912](/sql/relational-databases/errors-events/mssqlserver-912-database-engine-error), when upgrade scripts fail, the installation wizard reports the initial "Wait on the Database Engine recovery handle failed. Check the SQL Server error log for potential causes". The SQL Server error log will have entries for the 912 and 3417 error messages. Errors 912 and 3417 are generic errors associated with database upgrade script failures. And the messages preceding error 912 usually provide information on what exactly failed during the execution of these scripts. Troubleshooting and fixing these errors will require you to start SQL Server with trace flag 902.

> [!NOTE]
> Starting SQL Server with trace flag 902 is part of troubleshooting and fixing upgrade script errors. It's applicable to all the scenarios where a CU, SP, or upgrading to a new version fails during the execution of the database upgrade script. To start your SQL Server instance using trace flag 902, see [Steps to start SQL Server with trace flag 902](/sql/relational-databases/errors-events/mssqlserver-912-database-engine-error#steps-to-start--with-trace-flag-902).

After you start SQL Server with trace flag 902, you can select one of the articles in the following section to troubleshoot and solve your issues.

### Database upgrade script error messages

The "Wait on the Database Engine recovery handle failed" is the common error message for the following errors:

- [Error 574: Config statement can't be used inside a transaction](sql-server-upgrade-failed-error-574.md)
- [Error 945: Upgrading SSISDB that's part of Availability group](sql-server-upgrade-failed-error-945.md)
- [Error 1712: Online index operations can only be performed in Enterprise edition](sql-server-upgrade-failed-error-1712.md)
- [Error 2714: Object already exists error](sql-server-upgrade-failed-error-2714.md)
- [Error 4860: File name does not exist](sql-server-upgrade-failed-error-4860.md)
- [Error 5133: Create temporary database failed](sql-server-upgrade-failed-error-5133.md)
- [Error 6528: SQL Server upgrade fails with error 6528](sql-server-upgrade-failed-error-6528.md)
- [Error 15151: Issues SSISDB principals](sql-server-upgrade-failed-error-15151.md)
- [Error 15173: Issues dropping server principals](sql-server-upgrade-failed-error-15173.md)
- [Error 17182: TLS 1.0 disabled](sql-server-upgrade-failed-error-17182.md)
- [Errors during SQL Server upgrade when certificate-based principals own user objects](sql-server-upgrade-failed-error-cert-principals-own-object.md)

