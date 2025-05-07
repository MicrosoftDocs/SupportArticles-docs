---
ms.author: jaferebe
author: JamesFerebee
ms.date: 04/30/2025
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen
---
SQL Server 2019 CU27 introduced fix [2994446](../sqlserver-2019/cumulativeupdate27.md#2994446) to make secondary databases in an availability group (AG) startup more reliably. However, this fix causes a problem where AG databases don't start recovery if SQL Server is running in single-user mode. SQL Server Setup runs in single-user mode. As a result of this, if you run Setup and also have SQL replication or change data capture (CDC) enabled on a database in the AG, when the catalog upgrade scripts try to run but can't access the database, setup fails.

After SQL Server Setup initially fails, the SQL Server service then tries to come online again without single-user mode. At that time, the patch upgrade scripts finish successfully and patching is complete. Once startup completes, the issue is resolved and no user action is required.

The patch fails with the following error:

> Error installing SQL Server Database Engine Services Instance Features  
> Wait on the Database Engine recovery handle failed. Check the SQL Server error log for potential causes.  
> Error code: 0x851A001A

When you check the SQL Server error log, you see a message with an invalid Group ID. To verify it's an invalid ID, look for previous startup records in the same log file for the problematic database name to compare:

> Skipping the default startup of database \<DatabaseName> because the database belongs to an availability group (Group ID: \<GroupID>). The database will be started by the availability group. This is an informational message only. No user action is required.

If you want to prevent the patch from reporting an initial failure, you can perform one of the following actions before running the patch:

- Enable Trace Flag 12347 - reverts the changes made in fix [2994446](../sqlserver-2019/cumulativeupdate27.md#2994446). You should remove this trace flag after patching.

- Drop the CDC or replication enabled database from the AG.

- Remove CDC or replication from the database in the AG.

This issue is fixed in [SQL Server 2019 CU29](../sqlserver-2019/cumulativeupdate29.md#3418490).
