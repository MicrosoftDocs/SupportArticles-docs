---
title: BizTalk Server hotfixes, cumulative updates, and service packs
description: This article gives information about BizTalk Server hotfixes, cumulative updates, and service packs, including support.
ms.date: 03/06/2020
ms.prod-support-area-path: 
ms.reviewer: MandiA
---
# Information about BizTalk Server hotfixes, cumulative updates, and service packs

This article gives information about Microsoft BizTalk Server hotfixes, cumulative updates, and service packs, including support.

_Original product version:_&nbsp;BizTalk Server  
_Original KB number:_&nbsp;2003907

When you install a hotfix, cumulative update, or service pack for BizTalk Server, consider the following variables.

## x86 and x64 versions

Some BizTalk Server files are compiled for 32-bit computers and 64-bit computers individually. Other BizTalk Server files are compiled for both 32-bit and 64-bit computers, regardless of the CPU. 

When a BizTalk hotfix includes only an x86 download, the hotfix applies to both 32-bit and 64-bit computers. When a BizTalk Server hotfix includes separate x86 and x64 downloads, make sure that you download the hotfix that corresponds to the bit specs of the computer in question.

## Prerequisites

The user who installs the hotfix must be:

- A Windows administrator on the computer that's running BizTalk Server.
- A system administrator on the computer that's running SQL Server.

Make sure that you [back up all the databases for BizTalk Server](#backing-up-the-biztalk-server-databases).

## Restart requirements

If the hotfix includes an SQL script (.sql), you must stop the BizTalk Server services and SQL Server Agent before you install the hotfix. After the hotfix installation is complete, restart the BizTalk Server services and SQL Server Agent.

If the hotfix doesn't include an SQL script (.sql), you must restart the BizTalk host instance after the hotfix installation is complete.

> [!NOTE]
> You can review the `Setup.xml` file to determine which files will be updated.

## Installation in a BizTalk Server group

When multiple BizTalk servers are configured in a group, you must install the hotfix on all BizTalk servers in the group. To do this, follow these steps:

1. Stop all BizTalk host instances, custom isolated adapters, and any other services or applications (such as BizTalk Admin console, Health, and Activity Tracking) that are related to BizTalk Server services. Do this on all servers in the BizTalk group. If you use the HTTP, SOAP, WSE, or WCF adapters, restart and stop the IIS services. If you don't stop the IIS services, you may still receive incoming traffic. This behavior may affect the update, and the traffic may be lost when you do the rollback.
2. Stop SQL Server Agent on the SQL instance(s) that host the BizTalk databases.
3. Leave the SSO services running.
4. Verify that the BizTalk databases aren't in use by checking **Activity Monitoring** in SQL Server Management Studio or by running the `sp_who2` SQL command.
5. Install the hotfix on all servers in the BizTalk group. Only install the hotfix on one server at a time.
6. Restart all the BizTalk Server services, all the IIS services, and SQL Server Agent.

## Uninstallation and rollback

A BizTalk hotfix may update .dll files, and it may execute SQL scripts. If the hotfix contains only .dll files, and if it doesn't include an SQL script (.sql), it can be rolled back by using the uninstall command in Add or Remove Programs. You can review the `Setup.xml` file to determine which files will be updated.

If the hotfix contains an SQL script (.sql), it will execute the SQL script against a BizTalk database or databases. In this case, the hotfix can't be rolled back by uninstalling. If you uninstall by using **Add or Remove Programs**, this won't roll back the database changes, and it may leave the BizTalk environment in an inconsistent state.

## Backing up the BizTalk Server databases

> [!NOTE]
> Before you apply a hotfix that includes an SQL (.sql) script, you must back up all the BizTalk Server databases.

To force a full Backup of the data and log files, execute the `BizTalkMgmtDb.dbo.sp_ForceFullBackup` stored procedure. Then, execute the Backup BizTalk Server SQL Agent job.

For more information about how to back up and restore the BizTalk Server databases in BizTalk Server, visit the following websites:

- [BizTalk Server 2010](https://www.microsoft.com/download/details.aspx?id=56420)
- [BizTalk Server 2006 R2 and BizTalk Server 2006](https://www.microsoft.com/download/details.aspx?id=56495)
- [BizTalk Server 2004](https://www.microsoft.com/download/details.aspx?id=56488)

To roll back a hotfix that includes an SQL script (.sql), follow these steps:

1. Stop all BizTalk hosts, services, custom isolated adapters, and SQL Server Agent. If you use the HTTP, SOAP, or WCF adapters, restart the IIS services. If you make heavy use of the isolated host, you may want to consider stopping the IIS services.
2. Uninstall the hotfix by using **Add or Remove Programs**.
3. Restore the full Backups of all the BizTalk databases.

    > [!NOTE]
    > You must back up and restore all the BizTalk databases.
4. Restart all the BizTalk Server services and SQL Server Agent.

    > [!NOTE]
    > Don't execute any SQL scripts (.sql).

## Support for service packs and cumulative updates

All service packs, cumulative updates, security updates, and hot fixes are supported on a BizTalk Server. It's encouraged to install the latest update for Windows, SQL Server, Visual Studio, or any program installed. Service Packs for Microsoft products are supported based on the baseline support for that product. The [Support Lifecycle Index](https://support.microsoft.com/gp/lifeselectindex) lists the lifecycle information for BizTalk Server, SQL Server, Visual Studio, and other Microsoft programs.

For more information on any minimum service pack requirements, see [Summary of 64-bit support, operating systems and SQL Server versions supported by BizTalk Server](https://support.microsoft.com/kb/926628).
