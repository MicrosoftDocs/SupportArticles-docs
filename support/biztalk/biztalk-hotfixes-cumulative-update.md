---
title: BizTalk Server hotfixes, cumulative updates, and service packs
description: This article gives information about BizTalk Server hotfixes, cumulative updates, and service packs, including support.
ms.date: 03/06/2020
ms.prod-support-area-path: BizTalk Server Setup and Configuration
ms.reviewer: MandiA
---
# Information about BizTalk Server hotfixes, cumulative updates, and service packs

This article gives information about Microsoft BizTalk Server hotfixes, cumulative updates, and service packs, including support.

_Original product version:_ &nbsp; BizTalk Server  
_Original KB number:_ &nbsp; 2003907

When you install a hotfix, cumulative update, or service pack for BizTalk Server, consider the following variables.

## x86 and x64 versions

Some BizTalk Server files are compiled for 32-bit computers and 64-bit computers individually. Other BizTalk Server files are compiled for both 32-bit and 64-bit computers, regardless of the CPU. 

When a BizTalk Server hotfix includes only an x86 download, the hotfix applies to both 32-bit and 64-bit computers. When a BizTalk Server hotfix includes separate x86 and x64 downloads, make sure that you download the hotfix that corresponds to the bit specs of the computer in question.

## Prerequisites

The user who installs the hotfix must be:

- A Windows administrator on the computer that's running BizTalk Server.
- A system administrator on the computer that's running SQL Server.

Make sure that you [back up all the databases for BizTalk Server](#backing-up-the-biztalk-server-databases).

## Restart requirements

If the hotfix includes an SQL (.sql) script, you must stop the BizTalk Server services and SQL Server Agent before you install the hotfix. After the hotfix installation is complete, restart the BizTalk Server services and SQL Server Agent.

If the hotfix doesn't include an SQL script, you must restart the BizTalk Server host instance after the hotfix installation is complete.

> [!NOTE]
> You can review the Setup.xml file to determine which files will be updated.

## Installation in a BizTalk Server group

When multiple computers running BizTalk Server are configured in a group, you must install the hotfix on all computers running BizTalk Server in the group. Follow these steps:

1. Stop all BizTalk Server host instances, custom isolated adapters, and any other services or applications (such as Administration Console and Health and Activity Tracking) that are related to BizTalk Server services. Do this on all computers in the BizTalk Server group. 

   If you use the HTTP, SOAP, WSE, or WCF adapters, restart and stop the IIS services. If you don't stop the IIS services, you might still receive incoming traffic. This behavior might affect the update, and the traffic might be lost when you do the rollback.
2. Stop SQL Server Agent on the SQL Server instances that host the BizTalk Server databases.
3. Leave the SSO services running.
4. Verify that the BizTalk Server databases aren't in use by checking **Activity Monitoring** in SQL Server Management Studio or by running the `sp_who2` SQL command.
5. Install the hotfix on all servers in the BizTalk Server group. Install the hotfix on only one server at a time.
6. Restart all the BizTalk Server services, all the IIS services, and SQL Server Agent.

## Uninstallation and rollback

A BizTalk Server hotfix might update .dll files, and it might run SQL scripts. If the hotfix contains only .dll files, and if it doesn't include an SQL script, you can roll it back by using the uninstall command in Add or Remove Programs. You can review the Setup.xml file to determine which files will be updated.

If the hotfix contains an SQL script, it will run the script against a BizTalk Server database or databases. In this case, uninstalling doesn't roll back the hotfix. Uninstalling by using Add or Remove Programs won't roll back the database changes, and it might leave the BizTalk Server environment in an inconsistent state.

## Backing up the BizTalk Server databases

> [!NOTE]
> Before you apply a hotfix that includes an SQL script, you must back up all the BizTalk Server databases.

To force a full backup of the data and log files, execute the `BizTalkMgmtDb.dbo.sp_ForceFullBackup` stored procedure. Then, run the **Backup BizTalk Server** SQL Agent job.

For more information about how to back up and restore the BizTalk Server databases in BizTalk Server, visit the following websites:

- [BizTalk Server 2010](https://www.microsoft.com/download/details.aspx?id=56420)

- [BizTalk Server 2006 R2 and BizTalk Server 2006](https://www.microsoft.com/download/details.aspx?id=56495)

- [BizTalk Server 2004](https://www.microsoft.com/download/details.aspx?id=56488)

To roll back a hotfix that includes an SQL script, follow these steps:

1. Stop all BizTalk Server hosts, services, custom isolated adapters, along with SQL Server Agent. If you use the HTTP, SOAP, or WCF adapters, restart the IIS services. If you use the isolated host heavily, you might want to consider stopping the IIS services.
2. Uninstall the hotfix by using Add or Remove Programs.
3. Restore the full backups of all the BizTalk Server databases.

    > [!NOTE]
    > You must back up and restore all the BizTalk Server databases.
4. Restart all the BizTalk Server services and SQL Server Agent.

    > [!NOTE]
    > Don't run any SQL scripts.

## Support for service packs and cumulative updates

BizTalk Server supports all service packs, cumulative updates, security updates, and hotfixes. We encourage you to install the latest updates for Windows, SQL Server, Visual Studio, or any installed program. Service packs for Microsoft products are supported based on the baseline support for that product. The [Microsoft Lifecycle Policy](https://support.microsoft.com/gp/lifeselectindex) lists the lifecycle information for BizTalk Server, SQL Server, Visual Studio, and other Microsoft programs.

For more information on minimum service pack requirements, see [Summary of 64-bit support, operating systems, and SQL Server versions supported by BizTalk Server](https://support.microsoft.com/kb/926628).
