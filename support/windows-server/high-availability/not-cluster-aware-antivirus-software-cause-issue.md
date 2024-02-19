---
title: Antivirus software cause problems with Cluster Services
description: Resolve problems with Cluster Services that be caused by antivirus software that isn't cluster-aware.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:setup-and-configuration-of-clustered-services-and-applications, csstroubleshoot
---
# Antivirus software that isn't cluster-aware may cause problems with Cluster Services

This article provides help to solve problems with Cluster Services that be caused by antivirus software that isn't cluster-aware.

_Applies to:_ &nbsp; Windows Server 2022、Windows Server 2019、Windows Server 2016、Windows Server 2012 R2  
_Original KB number:_ &nbsp; 250355

## Summary

Antivirus software that is not cluster-aware may cause unexpected problems on a server that is running Cluster Services. For example, you may experience resource failures or problems when you try to move a group to a different node.

## Workaround

> [!WARNING]
> This workaround may make a computer or a network more vulnerable to attack by malicious users or by malicious software such as viruses. We do not recommend this workaround but are providing this information so that you can implement this workaround at your own discretion. Use this workaround at your own risk.

> [!NOTE]
> Antivirus software helps protect your computer from viruses. You must not download or open files from sources that you do not trust, visit Web sites that you do not trust, or open e-mail attachments when the antivirus software is disabled.

For more information about computer viruses, see [How to prevent and remove viruses and other malware](https://support.microsoft.com/help/129972).  

Most antivirus software uses filter drivers (device drivers) that work together with a service to scan for viruses. These filter drivers reside above the file system recognizer and scan files as they are opened and closed on a local hard disk. Antivirus software may not understand the shared disk model and may not correctly allow for failover.

If you are troubleshooting failover issues or general problems with a Cluster services and antivirus software is installed, temporarily uninstall the antivirus software or check with the manufacturer of the software to determine whether the antivirus software works with Cluster services. Just disabling the antivirus software is insufficient in most cases. Even if you disable the antivirus software, the filter driver is still loaded when you restart the computer.

Even if you are not monitoring the shared disk, the filter drivers are still loaded and may affect the operation of the cluster.

You can run antivirus software on a SQL Server cluster. However, you must make sure that the antivirus software is cluster-aware. Contact your antivirus software vendor about cluster-aware versions and interoperability.

Additionally, you should exclude the following file system locations and the processes from virus scanning on a server that is running Cluster Services:

### Directory

- The path of the `\Cluster` folder on the quorum hard disk. For example, exclude the `Q:\Cluster` folder from virus scanning.
- The `%Systemroot%\Cluster` folder.
- The temp folder for the Cluster Service account. For example, exclude the `\cliusr\Local Settings\Temp` folder from virus scanning.

### Process

- clussvc.exe (`%systemroot%\Cluster\clussvc.exe`)

    This file may have to be configured as a process exclusion within the antivirus software.

- rhs.exe (`%systemroot%\Cluster\rhs.exe`)

    This file may have to be configured as a process exclusion within the antivirus software.

For more information about running antivirus software on servers that are running SQL Server, see [Configure antivirus software to work with SQL Server](../../sql/database-engine/security/antivirus-and-sql-server.md).
