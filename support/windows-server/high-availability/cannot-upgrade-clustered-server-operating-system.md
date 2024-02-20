---
title: Can't upgrade operating system of clustered server
description: Describes an issue in which you cannot upgrade the operating system of a server from Windows Server 2003 or later versions.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, eldenc
ms.custom: sap:replacing-hardware-and-updating-the-operating-system, csstroubleshoot
---
# You cannot upgrade the operating system of a clustered server from Windows Server 2003 or later versions

This article provides workarounds for an issue where you can't upgrade the operating system of a clustered server from Windows Server 2003 or later versions.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 935197

## Symptoms

When you try to perform one of the following server operating system upgrades, the upgrade is blocked:

- Windows Server 2003 to Windows Server 2008 or Windows Server 2008 R2
- Windows Server 2008 to Windows Server 2008 R2 or Windows Server 2012
- Windows Server 2008 R2 to Windows Server 2012 or Windows Server 2012 R2
- Windows Server 2012 to Windows Server 2012 R2

When this problem occurs, the following error message is recorded in the System Compatibility report:

> You must make the following changes before upgrading Windows
>
> Uninstall the following Windows components and features:  
Server Clustering - Please read Microsoft Knowledge Base article: 935197

## Cause

This behavior occurs because the server is a cluster member. Windows Server 2008, Windows Server 2008 R2, Windows Server 2012, and Windows Server 2012 R2 do not support an upgrade of clustered servers from previous versions. This is because of incompatibilities between the cluster versions.

## Workaround

To work around this behavior, use one of the following methods, as appropriate for your situation.

### Method 1: Clean installation

1. Perform a clean installation of Windows Server 2008 or a later version on the nodes in the cluster.
2. Install the Failover Clustering feature, create a new cluster, and then reconfigure the cluster settings.

### Method 2: In-place migration

To perform in-place migration, go to the following Microsoft website for more information:

[Migrating to a Failover Cluster Running Windows Server 2008 R2](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc730990(v=ws.11))

## Status

This behavior is by design.

## More information

The Help files for Windows Server 2008 and later versions contain more information about supported paths from previous versions of clustered servers.
